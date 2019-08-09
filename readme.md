# Assembly Info Reader Task

A build task that reads the assembly attributes from the AssemblyInfo file and makes them available as build variables.

### Arguments
##### Path to AssemblyInfo.cs
***\\AssemblyInfo.cs* is the default value.  This should find the AssemblyInfo file in the build sources directory.  However, when building a multiple project solution one would want to enter the exact path.

##### Variables Prefix
The value entered here will be prefixed to each variable name generated.  This can be useful when using this task multiple times during a build and pointing each task to different AssemblyInfo files.

### Generated Variables
For each assembly attribute found in the AssemblyInfo file, a build variable will be created in the format of AssemblyInfo.*PropertyName*. (Example: $(AssemblyInfo.AssemblyVersion))

Version type properties found in the AssemblyInfo file will have additional variables made available in the format of AssemblyInfo.*PropertyName*.*VersionSegmentName*. (Example: $(AssemblyInfo.AssemblyVersion.Major)) When parsing the version variables, the generated variables are based on the following naming convention *Major*.*Minor*.*Build*.*Release*.  (Note: The *Build* segment can also be referenced as *Patch*)

### Test Cases
This is a PowerShell script, so we're limited in our options for true automated testing.

Some basic testcases for verifying script functionality have been included but will need to be manually run.