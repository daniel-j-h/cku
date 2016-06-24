# Exports:
#  LIBCAPSTONE_FOUND
#  LIBCAPSTONE_INCLUDE_DIR
#  LIBCAPSTONE_LIBRARY
# Hints:
#  LIBCAPSTONE_LIBRARY_DIR

find_path(LIBCAPSTONE_INCLUDE_DIR
          capstone/capstone.h)

find_library(LIBCAPSTONE_LIBRARY
             NAMES capstone
             HINTS "${LIBCAPSTONE_LIBRARY_DIR}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Capstone DEFAULT_MSG
                                  LIBCAPSTONE_LIBRARY LIBCAPSTONE_INCLUDE_DIR)
mark_as_advanced(LIBCAPSTONE_INCLUDE_DIR LIBCAPSTONE_LIBRARY)
