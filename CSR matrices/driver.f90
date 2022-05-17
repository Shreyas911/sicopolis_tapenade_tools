program driver
	
	use functions

	implicit none

	integer(4) :: nnz = 9, nmax = 3
	integer(4), dimension(:), allocatable :: a_ptr
	integer(4), dimension(:), allocatable :: a_index
	real(8),     dimension(:), allocatable :: a_value
	integer(4), dimension(:), allocatable :: b_ptr
	integer(4), dimension(:), allocatable :: b_index
	real(8),     dimension(:), allocatable :: b_value
	real(8),     dimension(:,:), allocatable :: A_normal, B_normal

	allocate (a_ptr(nmax+1))
	allocate (a_value(nmax+1))       
	allocate (a_index(nmax+1))       
	allocate (b_ptr(nmax+1))       
	allocate (b_value(nnz))       
	allocate (b_index(nnz))             
	allocate (A_normal(nmax,nmax))
	allocate (B_normal(nmax,nmax))
	!a_ptr = (/1,4,7,10/)
	!a_index  = (/1,2,3,1,2,3,1,2,3/)
	!a_value = (/1,2,3,4,5,6,7,8,9/)
	!a_value = (/1., 1., 1., 1./)
        !a_ptr = (/1, 3, 4, 5/)
        !a_index = (/1, 2, 2, 3/)
	a_value = (/1., 2., 3., 4., 5., 6., 7., 8., 10./)
        a_ptr = (/1, 4, 7, 10/)
        a_index = (/1, 2, 3, 1, 2, 3, 1, 2, 3/)
	!-------------------------------------------------------
	!! We aim to validate that the transpose_csr_no_diagonal
	!! subroutine works correctly.
	!-------------------------------------------------------
	
	call transpose_csr_no_diagonal(a_value, a_index, a_ptr, &
                    nnz, nmax, &
                    b_value, b_index, b_ptr)

	call csr_to_normal_representation(a_value, a_index, a_ptr, &
                    nnz, nmax, &
                    A_normal)
        call csr_to_normal_representation(b_value, b_index, b_ptr, &
                    nnz, nmax, &
                    B_normal)
	print *, "A = "
	call print_normal_matrix(A_normal, nmax)
	print *, "A^T = "
	call print_normal_matrix(B_normal, nmax)

        deallocate (a_ptr)
        deallocate (a_value)
        deallocate (a_index)
        deallocate (b_ptr)
        deallocate (b_value)
        deallocate (b_index)
        deallocate (A_normal)
        deallocate (B_normal)
	end program driver
