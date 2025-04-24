from setuptools import setup, Extension

fastops_module = Extension('fastops',
    sources=['fastops.c'],
    libraries=['z'],
)

setup(
    name='fastops',
    version='1.0',
    description='Fast file compression using zlib',
    ext_modules=[fastops_module],
)
