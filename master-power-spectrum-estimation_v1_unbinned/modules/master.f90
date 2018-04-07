module master
use healpix_modules
use healpix_types
use global_param


implicit none
integer(i4b),parameter :: nlheader=80
character(len=80) :: cloutheader(1:nlheader)


contains
!########################################################################
subroutine est_true_cl(cl,mllp,ipiv,lmax,info)

implicit none
integer(i4b), intent(in) :: lmax
integer(i4b), intent(in) :: ipiv(lmax+1)
real*8 :: wcl(0:lmax,1),mllp(0:lmax,0:lmax)
real*8, intent(inout) :: cl(0:lmax)
integer(i4b), intent(out) :: info

wcl(:,1)=cl(:) ; print*, "Converted 0"
call dgetrs("N",lmax+1,1, mllp, lmax+1, ipiv, wcl, lmax+1, info) ; print*,"Hello"
cl(:)=wcl(:,1)

call write_minimal_header(cloutheader,"CL")
call write_asctab(wcl,lmax,1,cloutheader,nlheader,"!"//fileout)

end subroutine est_true_cl
!########################################################################

!########################################################################
subroutine calc_kernel(wl,lmax,masklmax,mllp,ipiv,info)
implicit none

! Computes the coupling matrix and returns the matrix in LU factored form.

integer*4, intent(out) :: info
integer*4 :: i, j, k, ier,lmax,masklmax
integer*8, parameter:: ndim=2000
real*8 :: l, l1, k1, k1min, k1max,tempvar, wig3j(ndim)
integer(i4b), intent(out) :: ipiv(lmax+1)
real*8, parameter :: pi=3.1415d0
real*8, intent(in) :: wl(0:masklmax)
real*8, intent(out) :: mllp(0:lmax,0:lmax)

ipiv=0
mllp=0.d0

do i=0,lmax
   l=float(i)
   do j=0,lmax
      l1=float(j)
      call drc3jj(l,l1,0.d0,0.d0,k1min,k1max,wig3j,ndim,ier)
      do k=1,int(min(k1max,masklmax*1.d0)-k1min)+1
         k1=k1min+float(k-1)
         tempvar=wl(int(k1))*(wig3j(k)**2.d0)*(2.d0*l1+1.d0)*(2.d0*k1+1.d0)
         mllp(i,j)=mllp(i,j)+tempvar/(4.d0*pi)
      enddo
   enddo
   write(10,11) (mllp(i,j),j=0,lmax)
enddo
close(10)

call dgetrf(lmax+1, lmax+1, mllp, lmax+1, ipiv, info)

! Computes the inverse which is not necessary.
!call dgetri(lmax+1, , lmax+1, ipiv, work, lmax+1, info)
11 format(1000(x,e15.8))
end subroutine calc_kernel
!########################################################################

end module master
