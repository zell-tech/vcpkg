include(vcpkg_common_functions)
set(WIBU_VERSION 6.60)

vcpkg_download_distfile(ARCHIVE
    URLS "http://cadstar.dental/development/wibu-${WIBU_VERSION}.tar"
    FILENAME "wibu-${WIBU_VERSION}.tar"
    SHA512 fd8fbcd5478db2b45fe6b35fdb47cfb6b3bd1b58aa6ba8e9a911e8ead0e9f30565a4b51fd17c6e25a01c2a6ce230c47b31acdc87f09d64b50e3d3736f777db89
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    NO_REMOVE_ONE_LEVEL
    ARCHIVE ${ARCHIVE}
    REF wibu_6
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION ${SOURCE_PATH})
file(WRITE ${CURRENT_PACKAGES_DIR}/share/wibu/copyright/copyright.txt "LICENSE CODE GOES HERE")

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_install_cmake()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Install CMake package definitions
file(WRITE ${CURRENT_PACKAGES_DIR}/share/wibu/WibuConfig.cmake "
# This script sets following variables:
# WIBU_FOUND
# WIBU_INCLUDE_DIR
# WIBU_LIBRARIES_DIR
# WIBU_LIBRARIES

set(WIBU_FOUND TRUE)
set(WIBU_INCLUDE_DIR \${CMAKE_INSTALL_PREFIX}/include)
set(WIBU_LIBRARIES_DIR \${CMAKE_INSTALL_PREFIX}/lib)

# Search for libraries
find_library(WIBU_LIBRARIES NAMES \"WibuCm64\" \"WibuCm64.lib\")

")