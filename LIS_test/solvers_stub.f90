module solvers

  implicit none

  contains

  subroutine sico_lis_solver(nmax, nnz, &
                             lgs_a_ptr, lgs_a_index, &
                             lgs_a_value, lgs_b_value, lgs_x_value)

implicit none

integer(i4b)                                 :: ierr
integer(i4b)                                 :: iter
integer(i4b)                                 :: nc, nr
integer(i4b),                     intent(in) :: nmax
integer(i4b),                     intent(in) :: nnz
integer(i4b), dimension(nmax+1),  intent(in) :: lgs_a_ptr
integer(i4b), dimension(nnz),  intent(in)    :: lgs_a_index
real(dp),     dimension(nnz),  intent(in)    :: lgs_a_value
real(dp),     dimension(nmax),    intent(in) :: lgs_b_value

real(dp),     dimension(nmax), intent(inout) :: lgs_x_value


character(len=256)                           :: ch_solver_set_option

INTRINSIC SUM
integer(i4b)                                 :: k
real(dp)                                        :: b_nr
     do nr=1, nmax

        b_nr = 0.0_dp

        do k=lgs_a_ptr(nr), lgs_a_ptr(nr+1)-1
           b_nr = b_nr + lgs_a_value(k)*lgs_b_value(lgs_a_index(k))
        end do
        b_nr = b_nr + SUM(lgs_x_value) 

        lgs_x_value(nr) = lgs_x_value(nr)-(b_nr-lgs_b_value(nr))
        lgs_x_value(nr) = lgs_x_value(nr) + SUM(lgs_a_value) + SUM(lgs_b_value) + SUM(lgs_a_ptr)
     end do

  end subroutine sico_lis_solver

end module solvers