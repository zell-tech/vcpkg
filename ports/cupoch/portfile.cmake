vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO soroush/cupoch
    REF d2e8ba8436ef75d48e453d84fefb51157639398c
    SHA512 d397849228d363655f177f97ec4cc7501327120575bda8b6c5ffbda8b9cee4ba64023eea29b2f12ae483cfa08b755a15150cafbbb9dc55fdc5b0aeeb5b976455
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
