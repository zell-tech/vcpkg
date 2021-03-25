vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO CADstarGmbH/cupoch
    REF 83d22a4750510f1c50242975af35ca00f9085f95
    SHA512 a02216b331707cbddd9a0b89e369d02c9b6ebb50629bc5ac46ea3baccce2aae7f43133278a925f39d0429fd02fe6a5d40bd91e2ed8a7d337e894802642ea3eac
    HEAD_REF cadstar
)

# TODO: Add options for conditional build
# # Check if one or more features are a part of a package installation.
# # See /docs/maintainers/vcpkg_check_features.md for more details
# vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
#   FEATURES # <- Keyword FEATURES is required because INVERTED_FEATURES are being used
#     tbb   WITH_TBB
#   INVERTED_FEATURES
#     tbb   ROCKSDB_IGNORE_PACKAGE_TBB
# )

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_install_cmake()

# Moves all .cmake files from /debug/share/cupoch/ to /share/cupoch/
# See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake TARGET_PATH share/cupoch)

# Remove duplicated header files
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/cupoch RENAME copyright)

# Post-build test for cmake libraries
vcpkg_test_cmake(PACKAGE_NAME cupoch)
