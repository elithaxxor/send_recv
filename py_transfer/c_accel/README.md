# c_accel: C-Accelerated Data Processing for Python

This package provides fast data processing routines implemented in C, accessible from Python. Example: `xor_bytes` for simple bytewise XOR (can be extended for compression, hashing, etc).

## Build Instructions

From this directory, run:

```
python3 setup.py build
python3 setup.py install --user
```

## Usage Example

```python
from fastops import xor_bytes
result = xor_bytes(b'hello', 42)
print(result)
```

## Extending
- Add new C functions to `fastops.c` and register them in the method table.
- Rebuild with `python3 setup.py build install`.
