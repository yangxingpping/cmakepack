set(VERSION_MAJOR 0)
set(VERSION_MINIOR 0)
set(VERSION_BUGFIX 0)
set(VERSION_FULL "${VERSION_MAJOR}.${VERSION_MINIOR}.${VERSION_BUGFIX}")
set(APP_NAME "${CMAKE_PROJECT_NAME}")


set(GIT_WORK_COPY 0)
set(SVN_WORK_COPY 0)
set(_test_ver "NOK")
set(BUILD_REVISION "unknown")
set(BUILD_REVISION_CONTROLLER "unknown")
set(BUILD_REVISION_BRANCH "unknown")
set(BUILDE "")
set(EXEOUT "")


execute_process(
    COMMAND git ls-remote --get-url
    WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
    OUTPUT_VARIABLE _test_ver
    ERROR_QUIET
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
if("${_test_ver}" MATCHES ".git")
    set(GIT_WORK_COPY 1)
endif()

execute_process(
    COMMAND svn info
    WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
    OUTPUT_VARIABLE _test_ver
    ERROR_QUIET
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
if("${_test_ver}" MATCHES "URL")
    set(SVN_WORK_COPY 1)
endif()

if(GIT_WORK_COPY)
    set(BUILD_REVISION_CONTROLLER "GIT")

    execute_process(
        COMMAND git rev-parse --short HEAD
        WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
        RESULT_VARIABLE EXEOUT
        ERROR_VARIABLE BUILDE
        OUTPUT_VARIABLE BUILD_REVISION
        ERROR_QUIET
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
elseif(SVN_WORK_COPY)
    set(BUILD_REVISION_CONTROLLER "SVN")
    set(paramEgrep "[0-9]+")
    execute_process(
        COMMAND svn info -r HEAD
        COMMAND grep Revision 
        COMMAND egrep -o "${paramEgrep}"
        WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
        RESULT_VARIABLE EXEOUT
        ERROR_VARIABLE BUILDE
        OUTPUT_VARIABLE BUILD_REVISION
        ERROR_QUIET
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
endif()

message("reuslt:${EXEOUT}")
message("error:${BUILDE}")

set(PROJECT_VERSION_PATCH ${BUILD_REVISION})

message("BUILD_REVISION: ${BUILD_REVISION}")
message("BUILD_REVISION_CONTROLLER: ${BUILD_REVISION_CONTROLLER}")
message("BUILD_REVISION_BRANCH: ${BUILD_REVISION_BRANCH}")
string(TIMESTAMP BUILD_TIMESTAMP)
message("BUILD_TIMESTAMP: ${BUILD_TIMESTAMP}")
message("VERSION_MAJOR: ${VERSION_MAJOR}")
message("VERSION_MINIOR: ${VERSION_MINIOR}")
message("VERSION_BUGFIX: ${VERSION_BUGFIX}")
message("VERSION_FULL: ${VERSION_MAJOR}.${VERSION_MINIOR}.${VERSION_BUGFIX}")
message("APP_NAME: ${APP_NAME}")
message("FULL_APP_NAME: ${APP_NAME} ${VERSION_FULL} r${BUILD_REVISION}")



add_definitions(-DBUILD_REVISION=${BUILD_REVISION})
add_definitions(-DBUILD_REVISION_CONTROLLER=${BUILD_REVISION_CONTROLLER})
add_definitions(-DBUILD_REVISION_BRANCH=${BUILD_REVISION_BRANCH})
add_definitions(-DBUILD_TIMESTAMP=${BUILD_TIMESTAMP})

add_definitions(-DVERSION_MAJOR=${VERSION_MAJOR})
add_definitions(-DVERSION_MINIOR=${VERSION_MINIOR})
add_definitions(-DVERSION_BUGFIX=${VERSION_BUGFIX})
add_definitions(-DVERSION_FULL="${VERSION_MAJOR}.${VERSION_MINIOR}.${VERSION_BUGFIX}")
add_definitions(-DAPP_NAME="${APP_NAME}")
add_definitions(-DFULL_APP_NAME="${APP_NAME} ${VERSION_FULL} r${BUILD_REVISION}")