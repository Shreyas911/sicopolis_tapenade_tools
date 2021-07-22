module forward

	use solvers

	implicit none 

	contains

	subroutine forward_problem(lgs_a_value, lgs_a_ptr, lgs_a_index, lgs_b_value, J)

		implicit none 

    integer(4), dimension(nmax+1),  intent(in) :: lgs_a_ptr
    integer(4), dimension(nnz),  intent(in)    :: lgs_a_index
	real(8),     dimension(nnz),  intent(in)    :: lgs_a_value
	real(8),     dimension(nmax),    intent(in) :: lgs_b_value
	real(8),     dimension(nmax) :: lgs_x_value
	real(8), intent(out) :: J

		call sico_lis_solver(nmax, nnz, &
                             lgs_a_ptr, lgs_a_index, &
                             lgs_a_value, lgs_b_value, lgs_x_value)

		do i = 1, nmax
			J = J + lgs_x_value(i)
		end do
	end subroutine forward_problem


end module forward
