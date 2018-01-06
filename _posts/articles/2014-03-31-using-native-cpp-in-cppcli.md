---
title: "Using Native C++ in C++/CLI"
categories:
  - articles
---

Native C++ is based upon unmanaged code. To use native C++ code within the managed C++/CLI framework, a small modification is required.
The following method is one possible approach.

### Native class

```cpp
class NativeClass
{
public:
    void nativeMethod();
};
```

### Native Class Wrapper

```cpp
#include "NativeClass.h"

public ref class NativeClassWrapper
{
private:
    // Pointer to native class.
    NativeClass* _nativeClass;

public:
    // Constructor.
    NativeClassWrapper()
    {
        _nativeClass = nullptr;
    }

    // Destructor.
    ~NativeClassWrapper()
    {
        delete _nativeClass;
        _nativeClass = 0;
    }

    // Get direct access to the native class.
    NativeClass* getNativeClass()
    {
        return _nativeClass;
    }

    // Access to native class method.
    void managedMethod()
    {
        _nativeClass->nativeMethod();
    }
};
```

### Implementation of Native Class Wrapper

```cpp
#include "NativeClassWrapper.h"

// Initialise class.
NativeClassWrapper^ nativeClassWrapper = gcnew NativeClassWrapper();

// Call the native method through the wrapper.
nativeClassWrapper->managedMethod();

// Access the native class directly.
NativeClass* nativeClass = nativeClassWrapper->getNativeClass();
nativeClass->nativeMethod();
```
