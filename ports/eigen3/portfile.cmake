vcpkg_buildpath_length_warning(37)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO eigenteam/eigen-git-mirror
    REF 36b95962756c1fce8e29b1f8bc45967f30773c00
    SHA512 df49657fe4818aa7733b81dc962e6764ebffcbd115e6219249aafa7853638fdc7f29273e5cc07a9684815a5dcc59e37d3a2155df5faac95c93eb5bb25c011703
    HEAD_REF master
    # PATCHES fix-cuda-error.patch # issue https://gitlab.com/libeigen/eigen/-/issues/1526
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_TESTING=OFF
        -DEIGEN_BUILD_PKGCONFIG=ON
    OPTIONS_RELEASE
        -DCMAKEPACKAGE_INSTALL_DIR=${CURRENT_PACKAGES_DIR}/share/eigen3
        -DPKGCONFIG_INSTALL_DIR=${CURRENT_PACKAGES_DIR}/lib/pkgconfig
    OPTIONS_DEBUG
        -DCMAKEPACKAGE_INSTALL_DIR=${CURRENT_PACKAGES_DIR}/debug/share/eigen3
        -DPKGCONFIG_INSTALL_DIR=${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets()
vcpkg_fixup_pkgconfig()

file(GLOB INCLUDES ${CURRENT_PACKAGES_DIR}/include/eigen3/*)
# Copy the eigen header files to conventional location for user-wide MSBuild integration
file(COPY ${INCLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include ${CURRENT_PACKAGES_DIR}/debug/share)

file(INSTALL ${SOURCE_PATH}/COPYING.README DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
