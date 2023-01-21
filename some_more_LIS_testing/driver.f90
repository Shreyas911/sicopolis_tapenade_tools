program driver
        use sico_maths_m_diff
        implicit none

        integer(4) :: ierr, nnz = 3, nmax = 3
        integer(4) :: n_sprs = 0
        real(8)    :: eps_sor = 0.0000000000001, omega = 0.01
        integer(4), dimension(:), allocatable :: a_ptr
        integer(4), dimension(:), allocatable :: a_index
        integer(4), dimension(:), allocatable :: a_diag_index
        real(8),     dimension(:), allocatable :: a_value
        real(8),     dimension(:), allocatable :: b_value
        real(8),     dimension(:), allocatable :: x_value
        real(8),     dimension(:), allocatable :: a_valued
        real(8),     dimension(:), allocatable :: b_valued
        real(8),     dimension(:), allocatable :: x_valued
        real(8),     dimension(:,:), allocatable :: A_normal, B_normal
        
        allocate (a_ptr(nnz))
        allocate (a_diag_index(nmax))
        allocate (a_value(nnz))    
        allocate (b_value(nnz))
        allocate (x_value(nnz))  
        allocate (a_valued(nnz))
        allocate (b_valued(nnz))
        allocate (x_valued(nnz)) 
        allocate (a_index(nmax+1))       
        allocate (A_normal(nmax,nmax))
        !a_ptr = (/1,4,7,10/)
        !a_index  = (/1,2,3,1,2,3,1,2,3/)
        !a_value = (/1,2,3,4,5,6,7,8,9/)
        !a_value = (/1., 1., 1., 1./)
        !a_ptr = (/1, 3, 4, 5/)
        !a_index = (/1, 2, 2, 3/)
        a_value = (/1., 1., 1., 1./)
        a_valued = (/1., 1., 1., 1./)
        a_ptr = (/1, 2, 3, 5/)
        a_index = (/1, 2, 2, 3/)
        a_diag_index = (/1, 2, 4/)
        b_value = (/1., 1., 1./)
        b_valued = (/3., 3., 3./)
        !-------------------------------------------------------
        !! We aim to validate that the transpose_csr_no_diagonal
        !! subroutine works correctly.
        !-------------------------------------------------------
        
        !        call transpose_csr_no_diagonal(a_value, a_index, a_ptr, &
        !                    nnz, nmax, &
        !                    b_value, b_index, b_ptr)
        !
        !        call csr_to_normal_representation(a_value, a_index, a_ptr, &
        !                    nnz, nmax, &
        !                    A_normal)
        !        call csr_to_normal_representation(b_value, b_index, b_ptr, &
        !                    nnz, nmax, &
        !                    B_normal)
        !        print *, "A = "
        !        call print_normal_matrix(A_normal, nmax)
        !        print *, "A^T = "
        !        call print_normal_matrix(B_normal, nmax)
        !

        !call SICO_LIS_SOLVER(nmax, nnz, a_ptr, a_index, &
        !&   a_value, b_value, x_value)
        !call sico_lis_solver_stub_d(nmax, nnz, &
        !                   a_ptr, a_index, &
        !                   a_value, a_valued, b_value,&
        !                   b_valued, x_value, x_valued)
        call SOR_SPRS_STUB_D(a_value, a_valued, a_index, &
                           &   a_diag_index, a_ptr, b_value, b_valued, nnz, nmax, &
                           &   n_sprs, omega, eps_sor, x_value, x_valued, ierr)
        print *, "x_value: ", x_value
        print *, "x_valued: ", x_valued
        deallocate (a_ptr)
        deallocate (a_diag_index)
        deallocate (a_value)
        deallocate (b_value)
        deallocate (x_value)
        deallocate (a_valued)
        deallocate (b_valued)
        deallocate (x_valued)
        deallocate (a_index)
        deallocate (A_normal)
end program driver
