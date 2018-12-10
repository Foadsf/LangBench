from distutils.core import setup
from Cython.Build import cythonize
setup(name = 'test cython', ext_modules = cythonize("test_cython.pyx"))
