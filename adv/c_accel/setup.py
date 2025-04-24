from setuptools import setup, Extension

setup(
    name='fastops',
    version='0.1',
    ext_modules=[Extension('fastops', sources=['fastops.c'])],
)
