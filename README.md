# devkit.cmake-wobble
This is an environment for managing build configurations based on CMake. I frequently encounter projects configured via CMake which generate non-functional MSBuild setups - "Wobble" is just a proxy placeholder name for such projects. The created MSBuild projects either do not work at all and/or are difficult to use inside Visual Studio. Since there appears to be a pattern for that I've a set up a "devkit" (= development kit) consisting of utilities which help me to customize the generation of MSBuild (Visual Studio) projects.


