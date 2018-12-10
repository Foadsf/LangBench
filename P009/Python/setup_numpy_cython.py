from distutils.core import setup
from Cython.Build import cythonize
setup(name = 'test numpy cython', ext_modules = cythonize("test_numpy_cython.pyx"))
