module functions

	implicit none 

	contains 
		

		!------------------------------------------------------------------
		!> This function comes from the SICOPOLIS code. The exact difference
		!! in the use of transpose_csr and transpose_csr_no_diagonal is not
		!! clear. 
		!<-----------------------------------------------------------------
		subroutine transpose_csr(a_value, a_index, a_diag_index, a_ptr, &
		                    nnz, nmax, &
		                    b_value, b_index, b_diag_index, b_ptr)

			implicit none

			integer(4),                     intent(in)  :: nnz, nmax
			integer(4), dimension(nmax+1),  intent(in)  :: a_ptr
			integer(4), dimension(nnz),     intent(in)  :: a_index
			integer(4), dimension(nmax),    intent(in)  :: a_diag_index
			real(8),     dimension(nnz),     intent(in)  :: a_value
			integer(4), dimension(nmax+1),  intent(out) :: b_ptr
			integer(4), dimension(nnz),     intent(out) :: b_index
			integer(4), dimension(nmax),    intent(out) :: b_diag_index
			real(8),     dimension(nnz),     intent(out) :: b_value

			integer(4) :: nr, k
			integer(4), dimension(nmax)                 :: b_ptr_plus

			b_ptr = 0
			do nr=1, nmax
			  do k=a_ptr(nr), a_ptr(nr+1)-1
			     b_ptr(a_index(k)+1) = b_ptr(a_index(k)+1) + 1
			  end do
			end do

			b_ptr(1) = 1

			do nr=1, nmax
				b_ptr(nr+1) = b_ptr(nr) + b_ptr(nr+1)
			end do

			b_ptr_plus = 0

			do nr=1, nmax
				do k=a_ptr(nr), a_ptr(nr+1)-1

					b_index(b_ptr(a_index(k)) + b_ptr_plus(a_index(k))) = nr

					if(a_index(k).eq.nr)then
						b_diag_index(nr) = b_ptr(a_index(k)) + b_ptr_plus(a_index(k))
			     	end if

					b_value(b_ptr(a_index(k)) + b_ptr_plus(a_index(k))) = a_value(k)
					b_ptr_plus(a_index(k)) = b_ptr_plus(a_index(k)) + 1

				end do
			end do
		end subroutine transpose_csr

                !------------------------------------------------------------------
                !> This function comes from the SICOPOLIS code. It is used by the  
                !! sico_lis_solver_b subroutine. The purpose of this code is to
                !! validate if this function works correctly. 
                !<-----------------------------------------------------------------
		subroutine transpose_csr_no_diagonal(a_value, a_index, a_ptr, &
                    nnz, nmax, &
                    b_value, b_index, b_ptr)

			implicit none

			integer(4),                     intent(in)  :: nnz, nmax
			integer(4), dimension(nmax+1),  intent(in)  :: a_ptr
			integer(4), dimension(nnz),     intent(in)  :: a_index
			real(8),     dimension(nnz),     intent(in)  :: a_value
			integer(4), dimension(nmax+1),  intent(out) :: b_ptr
			integer(4), dimension(nnz),     intent(out) :: b_index
			real(8),     dimension(nnz),     intent(out) :: b_value

			integer(4) :: nr, k
			integer(4), dimension(nmax)                 :: b_ptr_plus

			   b_ptr = 0
			   do nr=1, nmax
			      do k=a_ptr(nr), a_ptr(nr+1)-1
			         b_ptr(a_index(k)+1) = b_ptr(a_index(k)+1) + 1
			      end do
			   end do
			   b_ptr(1) = 1
			   do nr=1, nmax
			     b_ptr(nr+1) = b_ptr(nr) + b_ptr(nr+1)
			   end do
			   b_ptr_plus = 0
			   do nr=1, nmax
			      do k=a_ptr(nr), a_ptr(nr+1)-1
			         b_index(b_ptr(a_index(k)) + b_ptr_plus(a_index(k))) = nr
			         b_value(b_ptr(a_index(k)) + b_ptr_plus(a_index(k))) = a_value(k)
			         b_ptr_plus(a_index(k)) = b_ptr_plus(a_index(k)) + 1
			      end do
			   end do

		end subroutine transpose_csr_no_diagonal
		


                !------------------------------------------------------------------
                !> This function is used to convert CSR matrix representation to 
                !! normal matrix representation. 
                !<-----------------------------------------------------------------
		subroutine csr_to_normal_representation(a_value, a_index, a_ptr, &
                    nnz, nmax, &
                    A_normal)

                        integer(4),                     intent(in)  :: nnz, nmax
                        integer(4), dimension(nmax+1),  intent(in)  :: a_ptr
                        integer(4), dimension(nnz),     intent(in)  :: a_index
                        real(8),     dimension(nnz),     intent(in)  :: a_value
			real(8), dimension(nmax,nmax), intent(out) :: A_normal
			integer(4), dimension(nnz) :: row_indices
			integer(4) :: nr, j

			do nr = 1, nmax
				do j = a_ptr(nr), a_ptr(nr+1) -1
					row_indices(j) = nr
				end do
			end do
			
			do j = 1, nnz
				A_normal(row_indices(j), a_index(j)) = a_value(j)
			end do
				
		end subroutine csr_to_normal_representation
		
		subroutine print_normal_matrix(A_normal, nmax)
			real(8), dimension(nmax,nmax), intent(in) :: A_normal
			integer(4),                     intent(in)  :: nmax
			integer(4) :: j
			do j = 1, nmax
				print *, A_normal(j,:)
			end do
		end subroutine print_normal_matrix
end module functions
