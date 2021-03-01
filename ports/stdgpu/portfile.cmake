vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO stotko/stdgpu
    REF 1.3.0
    SHA512 ea4999a28e3ee1eccb7ea3033b49ee783dfee9a577e3110ca210cf93f12242926182187e937cfa9b37465ea14e30880beca6a710446b13905d5d5872bdf31a19
    HEAD_REF master
    PATCHES fix-buildsystem.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    # PREFER_NINJA
    OPTIONS 
        -DSTDGPU_BUILD_SHARED_LIBS:BOOL=OFF
        -DSTDGPU_SETUP_COMPILER_FLAGS:BOOL=OFF 
        -DSTDGPU_BUILD_EXAMPLES:BOOL=OFF 
        -DSTDGPU_BUILD_TESTS:BOOL=OFF
        # TODO: Make backend optional
        -DSTDGPU_BACKEND:STRING=STDGPU_BACKEND_CUDA
)

vcpkg_install_cmake()

# Moves all .cmake files from /debug/share/stdgpu/ to /share/stdgpu/
# See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake TARGET_PATH share/stdgpu)
#file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")
#file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/stdgpu RENAME copyright)

# Post-build test for cmake libraries
vcpkg_test_cmake(PACKAGE_NAME stdgpu)
