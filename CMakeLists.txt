cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(cku VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -pedantic -std=c++14")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

find_package(Threads REQUIRED)

find_package(Capstone REQUIRED)
find_package(Keystone REQUIRED)

find_package(PkgConfig)
pkg_check_modules(GLIB REQUIRED glib-2.0)
find_package(Unicorn REQUIRED)


add_executable(main main.cc)
target_link_libraries(main ${LIBCAPSTONE_LIBRARY} ${LIBKEYSTONE_LIBRARY} ${LIBUNICORN_LIBRARY} ${GLIB_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT})
target_include_directories(main SYSTEM PRIVATE ${LIBCAPSTONE_INCLUDE_DIR} ${LIBKEYSTONE_INCLUDE_DIR} ${LIBUNICORN_INCLUDE_DIR})
