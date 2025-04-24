# Changelog

## [Unreleased]
### Major Efficiency Improvements
- Refactored server file transfer to use zero-copy `os.sendfile` when available (Linux), falling back to large-buffered manual send otherwise.
- Protocol headers now use binary format (`struct.pack`/`unpack`) for file size, name, and chat messages, eliminating string parsing overhead.
- Added verbose comments and docstrings for clarity and maintainability.

### C Extension Scaffold
- Added `c_accel/` package with a sample C extension (`fastops.c`) for fast data processing (e.g., bytewise XOR). Includes `setup.py` and usage instructions.

### Codebase Documentation
- Improved code comments and docstrings throughout for future maintainers.

### Bugfixes/Linting
- (Pending) Will run linting and static analysis for further improvements.

---

## [Earlier]
- Initial project structure and baseline implementation.
