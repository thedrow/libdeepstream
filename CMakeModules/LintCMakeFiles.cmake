find_program(CMAKELINT_FOUND cmakelint)
if(CMAKELINT_FOUND)
  message(STATUS "Found cmakelint at ${CMAKELINT_FOUND}")
  file(GLOB CMAKE_MODULES CMakeModules/*.cmake)
  file(GLOB_RECURSE CMAKE_LISTS CMakeLists.txt)

  file(GLOB_RECURSE VENDORED_CMAKE_LISTS "vendor/*/CMakeLists.txt")
  list(REMOVE_ITEM CMAKE_LISTS ${VENDORED_CMAKE_LISTS})

  set(CMAKE_MODULES "${CMAKE_LISTS};${CMAKE_MODULES}")
  string(REPLACE ";" "\n-- " CMAKE_MODULES_OUTPUT "-- ${CMAKE_MODULES}")
  message(STATUS "Executing cmakelint for the following CMake modules:\n${CMAKE_MODULES_OUTPUT}")
  execute_process(COMMAND "cmakelint" "--config=.cmakelintrc" ${CMAKE_MODULES}
                  RESULT_VARIABLE CMAKELINT_RESULT
                  OUTPUT_VARIABLE CMAKELINT_OUTPUT
                  ERROR_VARIABLE CMAKELINT_ERROR_OUTPUT
                  OUTPUT_STRIP_TRAILING_WHITESPACE ERROR_STRIP_TRAILING_WHITESPACE)

  if(NOT CMAKELINT_RESULT EQUAL 0)
    message(FATAL_ERROR "${CMAKELINT_OUTPUT}\n=== ${CMAKELINT_ERROR_OUTPUT} ===\ncmakelint failed.")
  else()
    message(STATUS ${CMAKELINT_ERROR_OUTPUT})
    message(STATUS "cmakelint passed.")
  endif()
else()
  message(AUTHOR_WARNING "No cmakelint was found.\n
  Install cmakelint by typing `pip install cmakelint`.")
endif()
