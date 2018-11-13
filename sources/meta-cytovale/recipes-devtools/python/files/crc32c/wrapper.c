//-----------------------------------------------------------------------------
// Logic to interface python3 with CRC32C calculator
//-----------------------------------------------------------------------------
#include "Python.h"

#include <stdint.h>
#include "Crc32c.h"

//-----------------------------------------------------------------------------
// See implementation
//-----------------------------------------------------------------------------
static PyObject* Crc32C_Entry(PyObject* self, PyObject* args);

//-----------------------------------------------------------------------------
// Docstrings
//-----------------------------------------------------------------------------
PyDoc_STRVAR(
    crc32c_module_doc,
    "CRC32C calculator module");

PyDoc_STRVAR(
    crc32c_doc,
    "crc32c(init_value, data)\n"
    "\n"
    "Parameters:\n"
    "  init_value:   Initial value of CRC.  Set to 0xFFFFFFFF to\n"
    "                start a new computation, otherwise use the \n"
    "                return from a previous call to crc32c\n"
    "  data:         bytes string to compute on\n");


//-----------------------------------------------------------------------------
// Method table
//-----------------------------------------------------------------------------
static PyMethodDef moduleFunctions[] =
{
    {
        .ml_name = "crc32c",
        .ml_meth = &Crc32C_Entry,
        .ml_flags = METH_VARARGS,
        .ml_doc = crc32c_doc
    },
    {
        .ml_name = 0,
        .ml_meth = 0,
        .ml_flags = 0,
        .ml_doc = 0
    }
};

//-----------------------------------------------------------------------------
// Module definition
//-----------------------------------------------------------------------------
static struct PyModuleDef module =
{
    .m_base = PyModuleDef_HEAD_INIT,
    .m_name = "crc32c",
    .m_doc = crc32c_module_doc,
    .m_size = 0,
    .m_methods = moduleFunctions,
    .m_slots = NULL,
    .m_traverse = NULL,
    .m_clear = NULL,
    .m_free = NULL
};

//-----------------------------------------------------------------------------
// Unpacks the python arguments and invokes the actual CRC code
//
// Parameters:
// [in] self - Ignored
// [in] args - PyTuple of arguments.  We expect the python arguments to be
//  0:  Bytes string of data to CRC
//  1:  Unsigned long of initial value for CRC computation
//
// Returns:
// Unsigned long of ending value
//-----------------------------------------------------------------------------
#include <stdio.h>
static PyObject* Crc32C_Entry(PyObject* self, PyObject* args)
{
    static_assert(sizeof(unsigned int) == sizeof(uint32_t), "Wrong size unsigned int");

    //-------------------------------------------------------------------------
    // Yank apart arguments and check them
    //-------------------------------------------------------------------------
    Py_buffer buffer;
    uint32_t initialCrc;
    if (PyArg_ParseTuple(
            args,
            "Iy*",
            &initialCrc,
            &buffer) == 0)
    {
        return NULL;
    }

    if (buffer.ndim != 1)
    {
        PyErr_SetString(PyExc_RuntimeError, "bytes must be 1D");
        return NULL;
    }

    if ((buffer.strides != NULL) && (buffer.strides[0] != 1))
    {
        PyErr_SetString(PyExc_RuntimeError, "bytes must be contiguous");
        return NULL;
    }

    //-------------------------------------------------------------------------
    // Do the math
    //-------------------------------------------------------------------------
    uint32_t finalCrc;
    {
        Py_BEGIN_ALLOW_THREADS;

        finalCrc = Crc32C(
            initialCrc,
            (uint8_t*)buffer.buf,
            buffer.len);

        Py_END_ALLOW_THREADS;
    }

    PyBuffer_Release(&buffer);

    //-------------------------------------------------------------------------
    // Pack the output
    //-------------------------------------------------------------------------
    return Py_BuildValue("I", finalCrc);
}

//-----------------------------------------------------------------------------
// Module initialization function
//-----------------------------------------------------------------------------
PyObject* PyInit_crc32c(void)
{
    return PyModule_Create(&module);
}
