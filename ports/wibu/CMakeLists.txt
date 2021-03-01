cmake_minimum_required(VERSION 3.11)
project(Wibu)

IF (NOT DEFINED SKIP_INSTALL_HEADERS)
    install(FILES "Wibu_6.60/include/CodeMeter.h" DESTINATION ${CMAKE_INSTALL_PREFIX}/include)
endif()

install(FILES
        Wibu_6.60/lib/WibuCm64.lib
        DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)