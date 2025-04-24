#include <Python.h>
#include <stdio.h>
#include <zlib.h>

#define BUF_SIZE 65536
#define CB_INTERVAL (512 * 1024)

// Compress a file using zlib and write to output file (gzip format)
// Now accepts an optional Python callback for progress reporting
static PyObject* compress_file(PyObject* self, PyObject* args, PyObject* kwargs) {
    const char* input_path;
    const char* output_path;
    PyObject* progress_cb = NULL;
    static char* kwlist[] = {"input_path", "output_path", "progress_cb", NULL};
    if (!PyArg_ParseTupleAndKeywords(args, kwargs, "ss|O", kwlist, &input_path, &output_path, &progress_cb))
        return NULL;

    FILE* in = fopen(input_path, "rb");
    if (!in) {
        PyErr_SetString(PyExc_IOError, "Cannot open input file");
        return NULL;
    }
    gzFile out = gzopen(output_path, "wb");
    if (!out) {
        fclose(in);
        PyErr_SetString(PyExc_IOError, "Cannot open output file");
        return NULL;
    }

    fseek(in, 0, SEEK_END);
    long total_bytes = ftell(in);
    fseek(in, 0, SEEK_SET);
    char buf[BUF_SIZE];
    size_t bytes;
    long processed = 0, last_cb = 0;

    PyObject* time_mod = PyImport_ImportModule("time");
    PyObject* time_func = PyObject_GetAttrString(time_mod, "time");
    double start_time = PyFloat_AsDouble(PyObject_CallObject(time_func, NULL));

    int error = 0;
    Py_BEGIN_ALLOW_THREADS
    while ((bytes = fread(buf, 1, sizeof(buf), in)) > 0) {
        if (gzwrite(out, buf, bytes) != bytes) {
            error = 1;
            break;
        }
        processed += bytes;
        if (progress_cb && processed - last_cb >= CB_INTERVAL) {
            last_cb = processed;
            PyGILState_STATE gstate = PyGILState_Ensure();
            double now = PyFloat_AsDouble(PyObject_CallObject(time_func, NULL));
            double elapsed = now - start_time;
            double speed = processed / (elapsed > 0 ? elapsed : 1);
            double eta = (total_bytes - processed) / (speed > 0 ? speed : 1);
            if (PyCallable_Check(progress_cb)) {
                PyObject* result = PyObject_CallFunction(progress_cb, "lldd", processed, total_bytes, elapsed, eta);
                if (result) Py_DECREF(result);
                else PyErr_Clear();
            }
            PyGILState_Release(gstate);
        }
    }
    Py_END_ALLOW_THREADS

    fclose(in);
    gzclose(out);
    Py_XDECREF(time_func);
    Py_XDECREF(time_mod);

    if (error) {
        PyErr_SetString(PyExc_IOError, "Error writing to output file");
        return NULL;
    }
    Py_RETURN_TRUE;
}

static PyMethodDef FastOpsMethods[] = {
    {"compress_file", (PyCFunction)compress_file, METH_VARARGS | METH_KEYWORDS, "Compress a file using zlib (gzip format) with optional progress callback."},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef fastopsmodule = {
    PyModuleDef_HEAD_INIT,
    "fastops",
    NULL,
    -1,
    FastOpsMethods
};

PyMODINIT_FUNC PyInit_fastops(void) {
    return PyModule_Create(&fastopsmodule);
}
