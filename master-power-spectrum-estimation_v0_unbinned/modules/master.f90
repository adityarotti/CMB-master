module master
use healpix_modules
use healpix_types
use global_param
use data_io

implicit none
real(dp), allocatable, dimension(:,:) :: mllp
integer(i4b), allocatable, dimension(:) :: ipiv
integer(i4b),parameter :: nlheader=80
character(len=80) :: cloutheader(1:nlheader)

contains
!########################################################################
subroutine allocate_master_data()

allocate(mllp(0:lmax,0:lmax),ipiv(lmax+1))
mllp=0.d0
ipiv=0

call write_minimal_header(cloutheader,"CL")

end subroutine allocate_master_data
!########################################################################

!########################################################################
subroutine deallocate_master_data()

deallocate(mllp,ipiv)

end subroutine deallocate_master_data
!########################################################################

!########################################################################
subroutine calc_kernel()
implicit none

! Computes the coupling matrix and returns the matrix in LU factored form.

integer :: i, j, k, ier, info
integer, parameter :: ndim=5000
real(dp) :: l, l1, k1, k1min, k1max, wig3j(ndim)
real*8 :: tempvar

do i=0,lmax
   l=float(i)
   do j=0,lmax
      l1=float(j)
      call drc3jj(l,l1,0.d0,0.d0,k1min,k1max,wig3j,ndim,ier)
      do k=1,int(min(k1max,masklmax*1.d0)-k1min)+1
         k1=k1min+float(k-1)
         tempvar=wl(int(k1),1)*(wig3j(k)**2.d0)*(2.d0*l1+1.d0)*(2.d0*k1+1.d0)
         mllp(i,j)=mllp(i,j)+tempvar/(4.d0*pi)
      enddo
   enddo
   write(10,11) (mllp(i,j),j=0,lmax)
enddo

call dgetrf(lmax+1, lmax+1, mllp, lmax+1, ipiv, info)

! Computes the inverse which is not necessary.
!call dgetri(lmax+1, , lmax+1, ipiv, work, lmax+1, info)
11 format(1000(x,e15.8))
end subroutine calc_kernel
!########################################################################

!########################################################################
subroutine est_true_cl()

implicit none
integer(i4b) :: info

call dgetrs("N",lmax+1,1, mllp, lmax+1, ipiv, cl, lmax+1, info)

call write_asctab(cl,lmax,1,cloutheader,nlheader,"!"//fileout)

end subroutine est_true_cl
!########################################################################

end module master
