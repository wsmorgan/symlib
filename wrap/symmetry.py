import _symmetry
import f90wrap.runtime
import logging
import numpy as np

def get_spaceGroup(atoms, eps_=None):
    """Finds the spcae group for the given atoms object.
    
    Args:
        atoms (ase.atoms.Atoms): an atoms object that the supercell 
            matrices will be found for.
        n_ (int): optional maximum number of multiples to find.
        eps_ (float): optional floating point tolerance.

    Returns:
        (sg_op, sg_fract) the point group operations and the fractional 
           translates of the symmetry group of th crystal.
    """

    lat_vecs = np.transpose(atoms.cell)
    positions = np.transpose(atoms.positions)
    
    sg_op = np.zeros((3,3,len(atoms.positions)*48), dtype=float, order='F')
    sg_fract = np.zeros((3,len(atoms.positions)*48), dtype=float, order='F')

    atm_types = np.unique(atoms.get_atomic_numbers())
    type_map = {j:i for i, j in enumerate(atm_types)}
    atom_types = [type_map[i] for i in atoms.get_atomic_numbers()]
    lattcoords=False
    eps = eps_ if eps_ is not None else 1E-3
    
    nops=Wrap_Symmetry.py_get_spacegroup(lat_vecs, atom_types, positions, sg_op, sg_fract,
                                         lattcoords, eps_=eps)

    sg_op = np.transpose(sg_op[:,:,:nops])
    sg_fract = np.transpose(sg_fract[:,:nops])

    return sg_op, sg_fract
        

class Wrap_Symmetry(f90wrap.runtime.FortranModule):
    """
    Module wrap_symmetry
    
    
    Defined at ../src/wrap_symmetry.f90 lines 1-44
    
    """
    @staticmethod
    def py_get_spacegroup(avecs, atomtype, input_pos, sg_op, sg_fract, lattcoords, \
        eps_=None):
        """
        n_ops = py_get_spacegroup(avecs, atomtype, input_pos, sg_op, sg_fract, \
            lattcoords[, eps_])
        
        
        Defined at ../src/wrap_symmetry.f90 lines 8-44
        
        Parameters
        ----------
        avecs : float array
        atomtype : int array
        input_pos : float array
        sg_op : float array
        sg_fract : float array
        lattcoords : bool
        eps_ : float
        
        Returns
        -------
        n_ops : int
        
        """
        n_ops = _symmetry.f90wrap_py_get_spacegroup(avecs=avecs, atomtype=atomtype, \
            input_pos=input_pos, sg_op=sg_op, sg_fract=sg_fract, lattcoords=lattcoords, \
            eps_=eps_)
        return n_ops
    
    _dt_array_initialisers = []
    

wrap_symmetry = Wrap_Symmetry()
