README file for HTML Template C++
=================================

* SUPPORTED PLATFORMS
* DOCUMENTATION
* CREATING TESTS
* RUNNING TESTS
* EXAMPLES

================================================================================
SUPPORTED PLATFORMS

The code is tested against LINUX and WINDOWS. The Visual Studio project file is
in the folder named vs/

================================================================================
DOCUMENTATION
Under docs/ as well as on the World Wide Webbb:
  http://nulidex.com/code/docs/html_template/

MAJOR DIFFERENCES with [HTML::Template](http://search.cpan.org/~samtregar/HTML-Template-2.6/Template.pm)
* There are no switches to enable/disable features, such as loop context
variables or globals. Everything is enabled by default. 

================================================================================
CREATING TESTS
* Create a template file in t/
* Add the test to run(), creating a separate container if this is a test for
   a new type of features.
* Create the reference output file: 
  ``` $ ./test create t/my_new_test.tmpl```
* Inspect t/my_new_test.txt to make sure the output is correct.
   This will be used now as a regression test.
* Recompile and run the test binary.

================================================================================
RUNNING TESTS
```
$ ./test
```
OR for one test
```
$ ./test run t/my_test.tmpl
```

================================================================================
EXAMPLES

An example is in the examples/ directory. The makefile is for Linux only.
