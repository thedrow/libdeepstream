cmake_minimum_required(VERSION 2.8)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/CMakeModules)
set(CMAKE_COLOR_MAKEFILE ON)
set(CMAKE_VERBOSE_MAKEFILE ON)
project(libdeepstream)

set(LIB_MAJOR_VERSION "0")
set(LIB_MINOR_VERSION "1")
set(LIB_PATCH_VERSION "0")
set(LIB_VERSION_STRING "${LIB_MAJOR_VERSION}.${LIB_MINOR_VERSION}.${LIB_PATCH_VERSION}")

include(LintCMakeFiles)

# compile in release with debug info mode by default
set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Build Type")

# Build all binaries in a separate directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

include(ConfigureCCache)
include(FindGTESTSRC)

find_package(GTESTSRC)

if(GTESTSRC_FOUND)
    enable_testing()

    if(WIN32 AND (NOT CYGWIN) AND (NOT MINGW))
        set(gtest_disable_pthreads ON)
        set(gtest_force_shared_crt ON)
    endif()

    add_subdirectory(${GTEST_SOURCE_DIR} ${CMAKE_BINARY_DIR}/googletest)
    include_directories(${GTEST_INCLUDE_DIR})

    set(TEST_LIBRARIES gtest gtest_main)

    add_custom_target(tests ALL)

endif()
