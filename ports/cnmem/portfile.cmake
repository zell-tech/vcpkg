vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO NVIDIA/cnmem
    REF 37896cc9bfc6536a8c878a1e675835c22d827821
    SHA512 f6266c94041a546add582c2ad2a93dc7bfdd4c37fdd62df720b8c212249d1513ee89d975f3d0b1e555a911441abdc79c117ff6d8ca82563eaf6cbcc9140b8584
    HEAD_REF master
    PATCHES fix-header-installation.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
)

vcpkg_install_cmake()

# Remove duplicated header files
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/cnmem RENAME copyright)

# # Post-build test for cmake libraries
vcpkg_test_cmake(PACKAGE_NAME cnmem)
