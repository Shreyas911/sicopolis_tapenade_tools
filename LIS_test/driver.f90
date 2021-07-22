program driver

	use forward_diff

	implicit none 

	real(8) :: J, Jb
	integer(4) :: nnz = 4, nmax = 3
	integer(4), dimension(:), allocatable :: lgs_a_index
	integer(4), dimension(:), allocatable :: lgs_a_ptr
	real(8),     dimension(:), allocatable :: lgs_a_value
	real(8),     dimension(:), allocatable :: lgs_a_valueb
	real(8),     dimension(:), allocatable :: lgs_b_value
	real(8),     dimension(:), allocatable :: lgs_b_valueb
	integer :: ii

	allocate(lgs_a_index(nnz))
	allocate(lgs_a_value(nnz))
	allocate(lgs_a_ptr(nmax+1))
	allocate(lgs_a_valueb(nnz))
	allocate(lgs_b_valueb(nmax))
	allocate(lgs_b_value(nmax))

	lgs_a_value = (/1., 1., 1., 1./)
	lgs_a_ptr = (/1, 3, 4/)
	lgs_a_index = (/1, 2, 2, 3/)
	lgs_b_value = (/1., 1., 1./)
	Jb = 1.0
	call forward_problem_b(lgs_a_value, lgs_a_valueb, lgs_a_ptr, lgs_a_index, lgs_b_value, lgs_b_valueb, J, Jb)

	deallocate(lgs_a_index)
	deallocate(lgs_a_value)
	deallocate(lgs_a_ptr)
	deallocate(lgs_a_valueb)
	deallocate(lgs_b_valueb)
	deallocate(lgs_b_value)
end program driver