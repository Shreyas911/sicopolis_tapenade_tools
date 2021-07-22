module solvers

  implicit none

  contains
  
  #include "lisf.h"
  subroutine sico_lis_solver(nmax, nnz, &
                             lgs_a_ptr, lgs_a_index, &
                             lgs_a_value, lgs_b_value, lgs_x_value)

    implicit none

    integer(4)                                 :: ierr
    integer(4)                                 :: iter
    integer(4)                                 :: nc, nr
    integer(4),                     intent(in) :: nmax
    integer(4),                     intent(in) :: nnz
    integer(4), dimension(nmax+1),  intent(in) :: lgs_a_ptr
    integer(4), dimension(nnz),  intent(in)    :: lgs_a_index

    LIS_MATRIX                                   :: lgs_a
    LIS_VECTOR                                   :: lgs_b
    LIS_VECTOR                                   :: lgs_x
    LIS_SOLVER                                   :: solver

    real(8),     dimension(nnz),  intent(in)    :: lgs_a_value
    real(8),     dimension(nmax),    intent(in) :: lgs_b_value
    real(8),     dimension(nmax), intent(inout) :: lgs_x_value

    character(len=256)                           :: ch_solver_set_option

    !  ------ Settings for Lis

    call lis_matrix_create(LIS_COMM_WORLD, lgs_a, ierr)
    call lis_vector_create(LIS_COMM_WORLD, lgs_b, ierr)
    call lis_vector_create(LIS_COMM_WORLD, lgs_x, ierr)

    call lis_matrix_set_size(lgs_a, 0, nmax, ierr)
    call lis_vector_set_size(lgs_b, 0, nmax, ierr)
    call lis_vector_set_size(lgs_x, 0, nmax, ierr)

    do nr=1, nmax

       do nc=lgs_a_ptr(nr), lgs_a_ptr(nr+1)-1
          call lis_matrix_set_value(LIS_INS_VALUE, nr, lgs_a_index(nc), &
                                                   lgs_a_value(nc), lgs_a, ierr)
       end do

       call lis_vector_set_value(LIS_INS_VALUE, nr, lgs_b_value(nr), lgs_b, ierr)
       call lis_vector_set_value(LIS_INS_VALUE, nr, lgs_x_value(nr), lgs_x, ierr)

    end do

    call lis_matrix_set_type(lgs_a, LIS_MATRIX_CSR, ierr)
    call lis_matrix_assemble(lgs_a, ierr)

    !  ------ Solution with Lis

    call lis_solver_create(solver, ierr)


    ch_solver_set_option = '-i bicgsafe -p jacobi '// &
                               '-maxiter 2000 -tol 1.0e-18 -initx_zeros false'

    call lis_solver_set_option(trim(ch_solver_set_option), solver, ierr)
    call CHKERR(ierr)

    call lis_solve(lgs_a, lgs_b, lgs_x, solver, ierr)
    call CHKERR(ierr)

    call lis_solver_get_iter(solver, iter, ierr)

    lgs_x_value = 0.0_dp
    call lis_vector_gather(lgs_x, lgs_x_value, ierr)
    call lis_matrix_destroy(lgs_a, ierr)
    call lis_vector_destroy(lgs_b, ierr)
    call lis_vector_destroy(lgs_x, ierr)
    call lis_solver_destroy(solver, ierr)

  end subroutine sico_lis_solver

end module solvers