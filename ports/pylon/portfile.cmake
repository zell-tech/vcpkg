include(vcpkg_common_functions)
set(PYLON_VERSION 5.2)

vcpkg_download_distfile(ARCHIVE
    URLS "http://cadstar.dental/development/pylon-${PYLON_VERSION}.tar"
    FILENAME "pylon-${PYLON_VERSION}.tar"
    SHA512 177123092d6cfecdfbb9c4ee035c600c2b5d8a4686d66471a878ebe6868f33aee1148ab5ec0d66da7124d7ce938a6945c37eea5194839479d1e74210b6716396
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    NO_REMOVE_ONE_LEVEL
    ARCHIVE ${ARCHIVE}
    REF pylon_5
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION ${SOURCE_PATH})
file(COPY "${SOURCE_PATH}/Licenses/pylon License.rtf" DESTINATION ${CURRENT_PACKAGES_DIR}/share/pylon/copyright)
file(COPY "${SOURCE_PATH}/Licenses/pylon_Third-Party_Licenses.html" DESTINATION ${CURRENT_PACKAGES_DIR}/share/pylon)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_install_cmake()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Install CMake package definitions
file(WRITE ${CURRENT_PACKAGES_DIR}/share/pylon/PylonConfig.cmake "
# This script sets following variables:
# PYLON_FOUND
# PYLON_INCLUDE_DIR
# PYLON_LIBRARIES_DIR
# PYLON_LIBS

set(PYLON_FOUND TRUE)
set(PYLON_INCLUDE_DIR \${CMAKE_INSTALL_PREFIX}/include)
set(PYLON_LIBRARIES_DIR \${CMAKE_INSTALL_PREFIX}/lib)

# Search for libraries
find_library(PYLON_GENAPI_LIB NAMES \"GenApi_MD_VC141_v3_1_Basler_pylon\")
find_library(PYLON_GCBASE_LIB NAMES \"GCBase_MD_VC141_v3_1_Basler_pylon\")
find_library(PYLON_BASE_LIB NAMES \"PylonBase_v5_2\")
find_library(PYLON_C_LIB NAMES \"PylonC\")
find_library(PYLON_UTILITY_LIB REQUIRED NAMES \"PylonUtility_v5_2\")
find_library(PYLON_GUI NAMES \"PylonGUI_v5_2\")

set(PYLON_LIBS \${PYLON_GENAPI_LIB} \${PYLON_GCBASE_LIB} \${PYLON_BASE_LIB} \${PYLON_C_LIB} \${PYLON_UTILITY_LIB} \${PYLON_GUI})

")