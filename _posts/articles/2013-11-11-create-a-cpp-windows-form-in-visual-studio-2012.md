---
title: "Create a C++ Windows Form in Visual Studio 2012"
excerpt: "The following is a simple step-by-step guide to creating a C++ Windows Form in Visual Studio 2012."
categories:
  - articles
---

The following is a simple step-by-step guide to creating a C++ Windows Form in Visual Studio 2012.

**1. Add a new Project to the Solution.**

`File > New > Project... > Visual C++ > CLR > CLR Empty Project`

**2. Select the new Project in the Solution Explorer.**

**3. Add a Windows Form to the Project.**

`Project > Add New Item... > Visual C++ > UI > Windows Form`

**4. Change the Project Subsystem.**

`Project > Properties > Configuration Properties > Linker > System > SubSystem`

Change this value to `Windows (/SUBSYSTEM:WINDOWS)`

**5. Change the Project Entry Point.**

`Project > Properties > Configuration Properties > Linker > Advanced > Entry Point`

Change this value to `main`. Apply these changes and close the Properties window.

**6. Open the `.cpp` file associated with the Windows Form.**

Enter the following code:

```cpp
#include "MainWindow.h"

using namespace System;
using namespace System::Windows::Forms;

[STAThread]
void main()
{
    Application::EnableVisualStyles();
    Application::SetCompatibleTextRenderingDefault(false);
    Program::MainWindow mainWindow;
    Application::Run(%mainWindow);
}
```

**7. Run the Application.**

You now have a very simple Windows Form in C++, ready to be built up with your other C++ projects.
