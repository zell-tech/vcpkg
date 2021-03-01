vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO dmlc/dlpack
    REF v0.3
    SHA512 2075900daaa82a73efd33b82bf0f4a55dfe11a4677846c5b2632994703236cd8404f44e9d353f5db98ebc1e9478b7ca6d7b3e66820b0229a0daf4133db0cdda5
    HEAD_REF master
    PATCHES fix_utf8.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS -DBUILD_MOCK:BOOL=OFF  -DBUILD_DOCS:BOOL=OFF
)

vcpkg_install_cmake()

# Moves all .cmake files from /debug/share/dlpack/ to /share/dlpack/
# See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake TARGET_PATH share/dlpack)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/dlpack RENAME copyright)

# Post-build test for cmake libraries
vcpkg_test_cmake(PACKAGE_NAME dlpack)
