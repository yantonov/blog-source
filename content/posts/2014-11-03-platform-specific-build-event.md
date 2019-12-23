---
title: "Platform specific build event"
date: 2014-11-03T13:43:28+05:00
categories: [xamarin, .net]
---
Sometimes you need to build .net solution/project on different platforms (for example while developing [xamarin](http://xamarin.com/ "xamarin") based application). In that case pre/post build events may contain platform specific instructions.

To handle this situation you can use 'Condition' attribute and 'OS' variable, for example, like this:

``` xml
<PostBuildEvent Condition=" '$(OS)' == 'Windows_NT' ">
  <!--  windows specifics -->
  copy $(TargetPath)  $(ProjectDir)../Assemblies /Y
</PostBuildEvent>
<PostBuildEvent Condition=" '$(OS)' == 'Unix' ">
  <!--  *nix, mac specifics  -->
  cp -f $(TargetPath) $(ProjectDir)../Assemblies
</PostBuildEvent>
```

If OS macro is undefined, you can explicitly define it at project level (projectName.cproj) like this:

``` xml
<PropertyGroup>
    <OS>Unix</OS>
</PropertyGroup>
```

Or pass as parameter to msbuild/xbuild tool (like this /property:name=value)
