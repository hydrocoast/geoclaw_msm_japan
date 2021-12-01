program read
  use netcdf
  implicit none

  ! dimension
  integer :: nx, ny, nt
  character(len=1024) :: f_in
  real(kind=4), allocatable :: lon(:), lat(:)
  real(kind=4), allocatable :: psea(:,:,:), u10(:,:,:), v10(:,:,:)
  ! netcdf
  integer :: ncid, varid, dimid
  integer :: start_nc(3), count_nc(3)
  ! loop counter
  integer :: k

  ! netcdf filename
  if(iargc()>0)then
    call getarg(1,f_in)
    !write(*,*) trim(f_in)
  else    
    stop 'No input argument'
  end if
 
  ! open
  call check_ncstatus( nf90_open( trim( f_in ), nf90_nowrite, ncid) )
  ! number of array
  call check_ncstatus( nf90_inq_dimid(ncid, 'lon', dimid) )
  call check_ncstatus( nf90_inquire_dimension(ncid, dimid, len=nx) )
  allocate(lon(nx))
  call check_ncstatus( nf90_get_var(ncid, dimid, lon) )

  call check_ncstatus( nf90_inq_dimid(ncid, 'lat', dimid) )
  call check_ncstatus( nf90_inquire_dimension(ncid, dimid, len=ny) )
  allocate(lat(ny))
  call check_ncstatus( nf90_get_var(ncid, dimid, lat) )

  call check_ncstatus( nf90_inq_dimid(ncid, 'time', dimid) )
  call check_ncstatus( nf90_inquire_dimension(ncid, dimid, len=nt) )

  ! allocate
  allocate( psea(nx,ny,nt), u10(nx,ny,nt), v10(nx,ny,nt))

  start_nc = [1,1,1] 
  count_nc = [nx,ny,nt]

  call check_ncstatus( nf90_inq_varid(ncid, "psea", varid))
  call check_ncstatus( nf90_get_var(ncid, varid, psea, start=start_nc, count=count_nc) )
  call check_ncstatus( nf90_inq_varid(ncid, "u", varid))
  call check_ncstatus( nf90_get_var(ncid, varid, u10, start=start_nc, count=count_nc) )
  call check_ncstatus( nf90_inq_varid(ncid, "v", varid))
  call check_ncstatus( nf90_get_var(ncid, varid, v10, start=start_nc, count=count_nc) )

  ! --- print for check
  write(*,*) minval(lon), maxval(lon), minval(lat), maxval(lat)
  do k = 1, nt
    write(*,*) k, maxval(psea(:,:,k)), minval(psea(:,:,k))
  end do
  !do k = 1, nt
  !  write(*,*) k, maxval(u10(:,:,k)), minval(u10(:,:,k)), maxval(v10(:,:,k)), minval(v10(:,:,k)) 
  !end do

  ! close nc file
  call check_ncstatus( nf90_close(ncid) )

  contains
! ------------------------------------------------------------------------------
  subroutine check_ncstatus( status )
    integer, intent (in) :: status
    if(status /= nf90_noerr) then 
       print *, trim(nf90_strerror(status))
       stop "Something went wrong during reading ncfile."
    end if
  end subroutine check_ncstatus
! ------------------------------------------------------------------------------
end program read