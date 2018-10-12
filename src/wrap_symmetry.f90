Module wrap_symmetry

use num_types
use symmetry, only: get_spaceGroup

CONTAINS

  subroutine py_get_spaceGroup(aVecs, atomType, input_pos, sg_op, sg_fract, n_ops, lattCoords, eps_)

    real(dp), intent(in):: aVecs(3,3)       
    integer, intent(in):: atomType(:)     
    real(dp), intent(in):: input_pos(:,:)      
    real(dp), intent(out):: sg_op(:,:,:)        
    real(dp), intent(out):: sg_fract(:,:)
    integer, intent(out) :: n_ops
    logical, intent(in) :: lattcoords    
    real(dp), intent(in), optional:: eps_   

    real(dp), pointer :: temp_sg_op(:,:,:), temp_sg_fract(:,:), temp_input_pos(:,:)
    integer :: temp_atomType(size(atomType,1))
    real(dp) :: eps

    if(.not. present(eps_)) then
       eps = 1e-10_dp
    else
       eps =  eps_
    endif
    
    sg_op = 0.0_dp
    sg_fract = 0.0_dp
    
    allocate(temp_input_pos(size(input_pos,1), size(input_pos,2)))

    temp_atomType = atomType
    temp_input_pos = input_pos
    
    call get_spaceGroup(aVecs, temp_atomType, temp_input_pos, temp_sg_op, temp_sg_fract, lattCoords, eps)

    n_ops = size(temp_sg_op,3)
    sg_op = temp_sg_op
    sg_fract = temp_sg_fract
    
  end subroutine py_get_spaceGroup

  
end Module wrap_symmetry
