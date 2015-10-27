! { dg-do compile } 
! { dg-additional-options "-fcray-pointer" }

module test
contains
  subroutine oacc1
    implicit none
    integer :: i
    real :: pointee
    pointer (ptr, pointee)
    !$acc declare device_resident (pointee) 
    !$acc declare device_resident (ptr) 
    !$acc data copy (pointee) ! { dg-error "Cray pointee" }
    !$acc end data
    !$acc data deviceptr (pointee) ! { dg-error "Cray pointee" }
    !$acc end data
    !$acc parallel private (pointee) ! { dg-error "Cray pointee" }
    !$acc end parallel
    !$acc host_data use_device (pointee) ! { dg-error "Cray pointee" }
    !$acc end host_data
    !$acc parallel loop reduction(+:pointee) ! { dg-error "Cray pointee" }
    do i = 1,5
    enddo
    !$acc end parallel loop
    !$acc parallel loop
    do i = 1,5
      ! Subarrays are not implemented yet
      !$acc cache (pointee) ! TODO: This must fail, as in openacc-1_0-branch
    enddo
    !$acc end parallel loop
    !$acc update device (pointee) ! { dg-error "Cray pointee" }
    !$acc update host (pointee) ! { dg-error "Cray pointee" }
    !$acc update self (pointee) ! { dg-error "Cray pointee" }
    !$acc data copy (ptr)
    !$acc end data
    !$acc data deviceptr (ptr) ! { dg-error "Cray pointer" }
    !$acc end data
    !$acc parallel private (ptr)
    !$acc end parallel
    !$acc host_data use_device (ptr) ! { dg-error "Cray pointer" }
    !$acc end host_data
    !$acc parallel loop reduction(+:ptr) ! { dg-error "Cray pointer" }
    do i = 1,5
    enddo
    !$acc end parallel loop
    !$acc parallel loop
    do i = 1,5
      !$acc cache (ptr) ! TODO: This must fail, as in openacc-1_0-branch
    enddo
    !$acc end parallel loop
    !$acc update device (ptr)
    !$acc update host (ptr)
    !$acc update self (ptr)
  end subroutine oacc1
end module test
! { dg-prune-output "ACC cache unimplemented" }
