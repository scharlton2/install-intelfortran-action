cmake_minimum_required(VERSION 3.9)

project(parallel Fortran)

option(SRC_BUILD_OPENMP
  "Build the OpenMP configuration" ON)

option(SRC_BUILD_MPI
  "Build the MPI configuration (If enabled, overrides OpenMP option)" OFF)

if (SRC_BUILD_OPENMP AND (NOT SRC_BUILD_MPI))
  
  find_package(OpenMP REQUIRED)
  
  add_executable(openmp main.F90)
 
  if(OpenMP_Fortran_FOUND)
    add_definitions(-DUSE_OPENMP)
    target_link_libraries(openmp PUBLIC OpenMP::OpenMP_Fortran)
  endif()
  
endif()

if (SRC_BUILD_MPI)
  
  find_package(MPI REQUIRED)

  add_executable(mpi main.F90)
  
  if(MPI_Fortran_FOUND)
    add_definitions(-DUSE_MPI)
    target_link_libraries(mpi PUBLIC MPI::MPI_Fortran)
  endif()
  
endif()

enable_testing()

if (SRC_BUILD_OPENMP AND (NOT SRC_BUILD_MPI))

  add_test(NAME openmp COMMAND openmp)

endif()

