//-----------------------------------------------------------------------------
// CRC32C calculator
//-----------------------------------------------------------------------------
#pragma once
#ifndef CRC32C_H
#define CRC32C_H

#include <stdint.h>

//-------------------------------------------------------------------------
// Calculate a CRC
//
// Parameters:
// [in] initialValue   Initial value.  Set to 0xFFFFFFFF for new
//                     computation
// [in] data           Data to operate on
// [in] dataLength     Length of data
//
// Returns:
// CRC value
//-------------------------------------------------------------------------
uint32_t Crc32C(
    uint32_t initialValue,
    const uint8_t* data,
    uint32_t dataLength);


#endif
