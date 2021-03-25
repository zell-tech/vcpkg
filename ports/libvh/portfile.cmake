vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO CADstarGmbH/libvh
    REF v0.1.0
    SHA512 3fafd3d4a4701589e85e9c02daf5b22b01cacb44a6943fbcd4b12ed0fd622b97143c1dc0eb7086a85d58abf88a33a3144e7f08914229e6c389e54fcf4c9e5fe2
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_install_cmake()

# Moves all .cmake files from /debug/share/libvh/ to /share/libvh/
# See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake TARGET_PATH share/libvh)
file(REMOVE_RECURSE 
    "${CURRENT_PACKAGES_DIR}/debug/"
    "${CURRENT_PACKAGES_DIR}/lib")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libvh RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libvh)
