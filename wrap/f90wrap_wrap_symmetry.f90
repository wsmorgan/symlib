! Module wrap_symmetry defined in file ../src/wrap_symmetry.f90

subroutine f90wrap_py_get_spacegroup(avecs, atomtype, input_pos, sg_op, &
    sg_fract, n_ops, lattcoords, eps_, n0, n1, n2, n3, n4, n5, n6, n7)
    use wrap_symmetry, only: py_get_spacegroup
    implicit none
    
    real(8), intent(in), dimension(3,3) :: avecs
    integer, intent(in), dimension(n0) :: atomtype
    real(8), intent(in), dimension(n1,n2) :: input_pos
    real(8), intent(inout), dimension(n3,n4,n5) :: sg_op
    real(8), intent(inout), dimension(n6,n7) :: sg_fract
    integer, intent(out) :: n_ops
    logical, intent(in) :: lattcoords
    real(8), intent(in), optional :: eps_
    integer :: n0
    !f2py intent(hide), depend(atomtype) :: n0 = shape(atomtype,0)
    integer :: n1
    !f2py intent(hide), depend(input_pos) :: n1 = shape(input_pos,0)
    integer :: n2
    !f2py intent(hide), depend(input_pos) :: n2 = shape(input_pos,1)
    integer :: n3
    !f2py intent(hide), depend(sg_op) :: n3 = shape(sg_op,0)
    integer :: n4
    !f2py intent(hide), depend(sg_op) :: n4 = shape(sg_op,1)
    integer :: n5
    !f2py intent(hide), depend(sg_op) :: n5 = shape(sg_op,2)
    integer :: n6
    !f2py intent(hide), depend(sg_fract) :: n6 = shape(sg_fract,0)
    integer :: n7
    !f2py intent(hide), depend(sg_fract) :: n7 = shape(sg_fract,1)
    call py_get_spacegroup(aVecs=avecs, atomType=atomtype, input_pos=input_pos, &
        sg_op=sg_op, sg_fract=sg_fract, n_ops=n_ops, lattcoords=lattcoords, &
        eps_=eps_)
end subroutine f90wrap_py_get_spacegroup

! End of module wrap_symmetry defined in file ../src/wrap_symmetry.f90

