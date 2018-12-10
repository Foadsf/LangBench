from distutils.core import setup
from Cython.Build import cythonize
setup(name = 'test python cython', ext_modules = cythonize("test_python_cython.pyx"))
