import re
import sys


def get_license_names(file_location):
    """
    Returns a list of all unique licenses used in the manifest file
    Expects the format
    "
    LICENSE: GPLv2+ & LGPLv2.1+
    "
    :param file_location:
    :return:
    """
    retval = []
    with open(file_location, 'r') as fpt:
        for line in fpt.readlines():
            if line.startswith("LICENSE: "):
                # strip off "LICENSE: "
                l = line[9:]
                licenses = re.split(" [|&] ", l)
                for l in licenses:
                    l = l.strip(" \n()")
                    if l not in retval:
                        retval.append(l)
    return retval


if __name__ == "__main__":

    if len(sys.argv) < 3:
        print("Usage: {} INPUT_FILE OUTPUT_FILE".format(sys.argv[0]))
        sys.exit(1)
    input = sys.argv[1]
    output = sys.argv[2]

    with open(output, 'w') as fpt:
        for license in get_license_names(input):
            fpt.write(license + "\n")


