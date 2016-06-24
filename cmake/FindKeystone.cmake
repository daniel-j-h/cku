# Exports:
#  LIBKEYSTONE_FOUND
#  LIBKEYSTONE_INCLUDE_DIR
#  LIBKEYSTONE_LIBRARY
# Hints:
#  LIBKEYSTONE_LIBRARY_DIR

find_path(LIBKEYSTONE_INCLUDE_DIR
          keystone/keystone.h)

find_library(LIBKEYSTONE_LIBRARY
             NAMES keystone
             HINTS "${LIBKEYSTONE_LIBRARY_DIR}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(keystone DEFAULT_MSG
                                  LIBKEYSTONE_LIBRARY LIBKEYSTONE_INCLUDE_DIR)
mark_as_advanced(LIBKEYSTONE_INCLUDE_DIR LIBKEYSTONE_LIBRARY)
