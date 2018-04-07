use global_param
use data_io
use master

implicit none

read(*,*) paramfile
call read_param(paramfile)


call allocate_io_data() 
call return_mask_cl() ; print*, "Returned mask cl"
call calc_kernel(wl,lmax,masklmax,mllp,ipiv,info) ; print*, "Returned kernel"

do i=nstart,nstart+nrlz-1
   write(simnum,'(i4.1)') i
   datafile=data_prefix
   if (swSUFFIX) datafile=trim(adjustl(datafile))//trim(adjustl(simnum))&
//trim(adjustl(data_suffix))
   fileout=trim(adjustl(pathout))//"cl_nrlz"//trim(adjustl(simnum))&
//".fits"
   call return_data_cl() ; print*, "Returned data cl"
   call est_true_cl(cl,mllp,ipiv,lmax,info)
enddo

call deallocate_io_data()

stop
end
