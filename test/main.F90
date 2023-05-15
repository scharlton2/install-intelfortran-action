program main

#if defined(USE_OPENMP) && defined(USE_MPI)
#error "Cannot define both USE_OPENMP and USE_MPI at the same time"
#endif

#if !(defined(USE_OPENMP) || defined(USE_MPI))
#error "Either USE_OPENMP or USE_MPI must be defined"
#endif

#if defined(USE_OPENMP)
use omp_lib

integer threads
integer partial_sum, sum

threads = 0
!$OMP parallel reduction(+ : threads)
threads = threads + 1
!$OMP END PARALLEL

sum = 0
!$OMP DO
do i = 0, 1000
    partial_sum = partial_sum + i
end do
!$OMP END DO

!$OMP CRITICAL
sum = sum + partial_sum
!$OMP END CRITICAL

print *, 'using ', threads, 'threads, sum(0:1000) = ', sum

#endif ! USE_OPENMP

#if defined(USE_MPI)
use mpi

integer ierror
integer procs, id
integer sum, allsum

call MPI_INIT(ierror)
call MPI_COMM_SIZE(MPI_COMM_WORLD, procs, ierror)
call MPI_COMM_RANK(MPI_COMM_WORLD, id, ierror)

sum = 0
do i = id, 1000, procs
  sum = sum + i
end do

call MPI_Reduce(sum, allsum, 1, MPI_INTEGER, MPI_SUM, 0, MPI_COMM_WORLD, ierror)

if (id == 0) then
  print *, 'using ', procs, 'processes, sum(0:1000) = ', allsum
end if

call MPI_FINALIZE(ierror)
#endif ! USE_MPI

end program
