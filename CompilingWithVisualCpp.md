# Compiling with Visual C++ #

## Note ##
I'm using Visual Studio 2010 Ultimate, you may find some inaccuracies when using diffrent version.

## What you need ##
  * Visual C++ (Express edition (it's free), 2010 preferably, as in other versions you might need to make some changes (i.e. platform toolset))
  * libraries (you can find them in 'Downloads' tab)
  * source code (you need some tool for that, I use TortoiseSVN)

## Steps ##
  1. Download source code
    * Install TortoiseSVN
    * Create folder, right click on it -> SVN Checkout...
    * set URL of repository to `https://avesta74.googlecode.com/svn/trunk`
    * press Ok
  1. Create new project
    * click File -> New -> Project...
    * select Visual C++ -> General -> Empty Project
    * set 'Name' for your project _(I'll name it "server")_
    * set 'Location' for your project _(It's "D:\projects" for me)_
    * leave 'Solution name' same as 'Name' _("server")_
    * 'Create directory' for solution should be checked
  1. Adding files
    * go to 'Location\Name\Solution name' of your project _(D:\projects\server\server)_, and copy there all content of [trunk/src/](http://avesta74.googlecode.com/svn/trunk/src/)
    * in Solution Explorer right click on Header Files -> Add -> Existing item..., right click on Sort by -> Type, select all header files (.h extension), don't forget about the msvc.h and workarounds.h (from 'compiler' folder)
    * in Solution Explorer right click on Source Files -> Add -> Existing Item..., select all source files (.cpp extension)
  1. Setting project up
    * go to (in menubar) Project -> Properties
    * in the top left corner, set Configuration to 'Release'
    * in tree widget on the left, go to Configuration Properties (you should be there anyway)
      * General, Platform Toolset should be 'v100', Character Set should be 'Use Multi-Byte Character Set ' , rest leave as default
      * C/C++
        * General
          * click Additional Include Directories, drop down button shall appear, click on it, and in new window add following directories:
            * libraries\inc\boost
            * libraries\inc\libiconv
            * libraries\inc\libxml
            * libraries\inc\lua
            * libraries\inc\mpir
            * libraries\inc\mysql
            * libraries\inc\sqlite
          * Multi-processor compilation (optional), you can set it to 'Yes', that will speed compilation
        * Preprocessor
          * Preprocessor definitions, click on it, choose edit, and add (don't add the word 'optional'):
            * `__USE_OTPCH__`
            * `__USE_MYSQL__ `
            * `NDEBUG` _(optional)_
            * `__USE_SQLITE__` _(optional)_
            * `__PROTOCOL_76__` _(optional)_
            * `__PROTOCOL_77__` _(optional)_
            * `__USE_MINIDUMP__` _(optional)_
        * Precompiled Headers
          * set Precompiled Header to 'Use'
          * set Precompiled Header File to 'otpch.h'
      * Linker
        * General
          * Additional Library Directories, click dropdown button, edit and add:
            * libraries\lib
        * Input
          * Additional Dependencies, click dropdown button, edit and add:
            * libmysql.lib
            * libxml2.lib
            * lua5.1.lib
            * mpir.lib
            * sqlite3.lib
    * we are done here, press Ok
    * in Solution Explorer -> Source Files, right click on optch.cpp -> Properties
      * make sure Configuration (top left) is 'Release'
      * go to Configuration Properties -> C/C++ -> Precompiled Headers
        * set Precompiled Header to 'Create'
        * set Precompiled Header File to 'otpch.h'
        * press Ok
  1. Compilation
    * in the toolbar (top center) change configuration from 'Debug' to 'Release'
    * click Build -> Build Solution
    * executable will be in Location\Name\Release _(D:\projects\server\Release)_
