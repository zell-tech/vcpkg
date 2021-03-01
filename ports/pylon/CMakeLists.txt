cmake_minimum_required(VERSION 3.11)
project(Pylon)

IF (NOT DEFINED SKIP_INSTALL_HEADERS)
    install(DIRECTORY "Development/include/" DESTINATION ${CMAKE_INSTALL_PREFIX}/include)
endif()

if("${CMAKE_SIZEOF_VOID_P}" STREQUAL "4")
    set(TARGET_PLATFORM "Win32")
elseif("${CMAKE_SIZEOF_VOID_P}" STREQUAL "8")
    set(TARGET_PLATFORM "x64")
endif()

install(FILES
            Development/lib/${TARGET_PLATFORM}/GenApi_MD_VC141_v3_1_Basler_pylon.lib
            Development/lib/${TARGET_PLATFORM}/GCBase_MD_VC141_v3_1_Basler_pylon.lib
            Development/lib/${TARGET_PLATFORM}/PylonBase_v5_2.lib
            Development/lib/${TARGET_PLATFORM}/PylonC.lib
            Development/lib/${TARGET_PLATFORM}/PylonGUI_v5_2.lib
            Development/lib/${TARGET_PLATFORM}/PylonUtility_v5_2.lib
        DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

install(FILES
            Runtime/${TARGET_PLATFORM}/GCBase_MD_VC141_v3_1_Basler_pylon.dll
            Runtime/${TARGET_PLATFORM}/GenApi_MD_VC141_v3_1_Basler_pylon.dll
            Runtime/${TARGET_PLATFORM}/Log_MD_VC141_v3_1_Basler_pylon.dll
            Runtime/${TARGET_PLATFORM}/log4cpp_MD_VC141_v3_1_Basler_pylon.dll
            Runtime/${TARGET_PLATFORM}/MathParser_MD_VC141_v3_1_Basler_pylon.dll
            Runtime/${TARGET_PLATFORM}/NodeMapData_MD_VC141_v3_1_Basler_pylon.dll
            Runtime/${TARGET_PLATFORM}/PylonBase_v5_2.dll
            Runtime/${TARGET_PLATFORM}/PylonC_v5_2.dll
            Runtime/${TARGET_PLATFORM}/PylonCamEmu_v5_2_TL.dll
            Runtime/${TARGET_PLATFORM}/PylonGUI_v5_2.dll
            Runtime/${TARGET_PLATFORM}/PylonUsb_v5_2_TL.dll
            Runtime/${TARGET_PLATFORM}/PylonUtility_v5_2.dll
            Runtime/${TARGET_PLATFORM}/uxapi_v11.dll
            Runtime/${TARGET_PLATFORM}/uxtopapi_v5_2.dll
            Runtime/${TARGET_PLATFORM}/XmlParser_MD_VC141_v3_1_Basler_pylon.dll
        DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
