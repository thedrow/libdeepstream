message("Executing cmakelint:")
execute_process(COMMAND "cmakelint" "--config=.cmakelintrc" CMakeLists.txt RESULT_VARIABLE CMAKELINT_RESULT)

if(NOT CMAKELINT_RESULT EQUAL 0)
  message( FATAL_ERROR "cmakelint failed." )
endif()
