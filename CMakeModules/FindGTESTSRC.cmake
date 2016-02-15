set(GTEST_SEARCH_PATH
    "${GTEST_SOURCE_DIR}/googletest"
    "${CMAKE_CURRENT_LIST_DIR}/../vendor/gtest/googletest")

if(UNIX)
    if(BUILD_THIRDPARTY_GTEST)
        message(STATUS "Prefering GTest installed globally at /usr/src/gtest")
        list(APPEND GTEST_SEARCH_PATH "/usr/src/gtest")
    else()
        message(STATUS "Looking for GTest also at /usr/src/gtest")
        list(INSERT GTEST_SEARCH_PATH 1 "/usr/src/gtest")
    endif()
endif()

string(REPLACE ";" "\n-- " GTEST_SEARCH_PATH_OUTPUT "-- ${GTEST_SEARCH_PATH}")
message(STATUS "GTest search path:\n${GTEST_SEARCH_PATH_OUTPUT}")

find_path(GTEST_SOURCE_DIR
          NAMES CMakeLists.txt src/gtest_main.cc
          PATHS ${GTEST_SEARCH_PATH})


# Debian installs gtest include directory in /usr/include, thus need to look
# for include directory separately from source directory.
find_path(GTEST_INCLUDE_DIR
          NAMES gtest/gtest.h
          PATH_SUFFIXES include
          HINTS ${GTEST_SOURCE_DIR}
          PATHS ${GTEST_SEARCH_PATH})
if(GTEST_INCLUDE_DIR)
  message(STATUS "GTest include directory: ${GTEST_INCLUDE_DIR}")
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GTESTSRC DEFAULT_MSG
                                  GTEST_SOURCE_DIR
                                  GTEST_INCLUDE_DIR)
