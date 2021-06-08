vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO soroush/cupoch
    REF f5adb60867c9d518ae8d672a90d0410e4a7f5370
    SHA512  945e4fc72fd9bb7353caa33a6186328ff4b01e9428b43e5cd0fee520e6e1fca0fc874363f6f073706723d8d929271ab73974f5573e204257c95ad59545691289
    HEAD_REF v0.1.3-cleanup
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
    OPTIONS -DSUPPORT_MAXWELL=OFF
    OPTIONS -DSUPPORT_PASCAL=OFF
    OPTIONS -DSUPPORT_VOLTA=OFF
    OPTIONS -DSUPPORT_AMPERE=OFF
    OPTIONS -DSUPPORT_TURING=ON

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
