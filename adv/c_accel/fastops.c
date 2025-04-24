// fastops.c - Example C extension for fast data processing
#include <Python.h>

// Example: XOR all bytes in a buffer with a key (very simple compression/stub)
static PyObject* xor_bytes(PyObject* self, PyObject* args) {
    Py_buffer buf;
    unsigned char key;
    if (!PyArg_ParseTuple(args, "y*b", &buf, &key))
        return NULL;
    PyObject* result = PyBytes_FromStringAndSize(NULL, buf.len);
    if (!result) {
        PyBuffer_Release(&buf);
        return NULL;
    }
    unsigned char* out = (unsigned char*)PyBytes_AS_STRING(result);
    for (Py_ssize_t i = 0; i < buf.len; ++i)
        out[i] = ((unsigned char*)buf.buf)[i] ^ key;
    PyBuffer_Release(&buf);
    return result;
}

static PyMethodDef FastOpsMethods[] = {
    {"xor_bytes", xor_bytes, METH_VARARGS, "XOR all bytes in buffer with a key."},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef fastopsmodule = {
    PyModuleDef_HEAD_INIT,
    "fastops",
    "Fast data operations (C accelerated)",
    -1,
    FastOpsMethods
};

PyMODINIT_FUNC PyInit_fastops(void) {
    return PyModule_Create(&fastopsmodule);
}
