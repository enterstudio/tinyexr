sources = {
   "main.cc",
   }

-- premake4.lua
solution "EXRViewSolution"
   configurations { "Release", "Debug" }

   platforms { "native", "x64", "x32" }


   projectRootDir = os.getcwd() .. "/"
   dofile ("findOpenGLGlewGlut.lua")
   initOpenGL()
   initGlew()

   -- A project defines one build target
   project "exrview"
      kind "ConsoleApp"
      language "C++"
      files { sources }

      includedirs { "./" }

      if os.is("Windows") then
         files{
            "OpenGLWindow/Win32OpenGLWindow.cpp",
            "OpenGLWindow/Win32OpenGLWindow.h",
            "OpenGLWindow/Win32Window.cpp",
            "OpenGLWindow/Win32Window.h",
            }
      end
      if os.is("Linux") then
         files {
            "btgui/OpenGLWindow/X11OpenGLWindow.cpp",
            "btgui/OpenGLWindow/X11OpenGLWindows.h"
            }
      end
      if os.is("MacOSX") then
         links {"Cocoa.framework"}
         files {
                "btgui/OpenGLWindow/MacOpenGLWindow.h",
                "btgui/OpenGLWindow/MacOpenGLWindow.mm",
               }
      end

      configuration "Debug"
         defines { "DEBUG" } -- -DDEBUG
         flags { "Symbols" }
         targetname "exrview_debug"

      configuration "Release"
         -- defines { "NDEBUG" } -- -NDEBUG
         flags { "Symbols", "Optimize" }
         targetname "exrview"
