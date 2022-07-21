-- Build SQLite3
--   static or shared library
--   Multi cipher encryption support
--   Debug or Release
--   Win32 or Win64

-- Target directory for the build files generated by premake5
newoption {
  trigger     = "builddir",
  value       = "build",
  description = "Directory for the generated build files"
}

BUILDDIR = _OPTIONS["builddir"] or "build"

-- Determine version of Visual Studio action
vc_version = "";
if _ACTION == "vs2003" then
  vc_version = 7
elseif _ACTION == "vs2005" then
  vc_version = 8
elseif _ACTION == "vs2008" then
  vc_version = 9
elseif _ACTION == "vs2010" then
  vc_version = 10
elseif _ACTION == "vs2012" then
  vc_version = 11
elseif _ACTION == "vs2013" then
  vc_version = 12
elseif _ACTION == "vs2015" then
  vc_version = 14
elseif _ACTION == "vs2017" then
  vc_version = 15
elseif _ACTION == "vs2019" then
  vc_version = 16
end

is_msvc = false
msvc_useProps = false
if ( vc_version ~= "" ) then
  is_msvc = true
  msvc_useProps = vc_version >= 10
  vc_with_ver = "vc"..vc_version
end

-- Activate loading of separate props file
if (msvc_useProps) then
  premake.wxProject = true
end

-- SQLite3Secure workspace

workspace "SQLite3Secure"
  configurations { "Debug", "Release" }
  platforms { "Win32", "Win64" }
  location(BUILDDIR)

  if (is_msvc) then
    local wks = workspace()
    wks.filename = "SQLite3Secure_" .. vc_with_ver
  end

  defines {
    "_WINDOWS",
    "WIN32",
    "_CRT_SECURE_NO_WARNINGS",
    "_CRT_SECURE_NO_DEPRECATE",
    "_CRT_NONSTDC_NO_DEPRECATE"
  }

  filter { "platforms:Win32" }
    system "Windows"
    architecture "x32"

  filter { "platforms:Win64" }
    system "Windows"
    architecture "x64"
    targetsuffix "_x64"

  filter { "configurations:Debug*" }
    defines {
      "DEBUG", 
      "_DEBUG"
    }
    symbols "On"

  filter { "configurations:Release*" }
    defines {
      "NDEBUG"
    }
    optimize "On"  

  filter {}

-- SQLite3 static library
project "sqlite3lib"
  language "C++"
  kind "StaticLib"

  if (is_msvc) then
    local prj = project()
    prj.filename = "SQLite3Secure_" .. vc_with_ver .. "_lib"
  else
    toolset("gcc")
  end
  makesettings { "include config.gcc" }

  files { "src/sqlite3secure.c", "src/*.h" }
  vpaths {
    ["Header Files"] = { "**.h" },
    ["Source Files"] = { "**/sqlite3secure.c", "**.def", "**.rc" }
  }
  characterset ("Unicode")
  staticruntime "On"  

  location( BUILDDIR )
  targetname "sqlite3"

  defines {
    "_LIB",
    "SQLITE_THREADSAFE=1",
    "SQLITE_DQS=0",
    "SQLITE_MAX_ATTACHED=10",
    "SQLITE_ENABLE_EXPLAIN_COMMENTS",
    "SQLITE_SOUNDEX",
    "SQLITE_ENABLE_COLUMN_METADATA",
    "SQLITE_HAS_CODEC=1",
    "CODEC_TYPE=CODEC_TYPE_CHACHA20",
    "SQLITE_SECURE_DELETE",
    "SQLITE_ENABLE_FTS3",
    "SQLITE_ENABLE_FTS3_PARENTHESIS",
    "SQLITE_ENABLE_FTS4",
    "SQLITE_ENABLE_FTS5",
    "SQLITE_ENABLE_JSON1",
    "SQLITE_ENABLE_RTREE",
    "SQLITE_ENABLE_GEOPOLY",
    "SQLITE_CORE",
    "SQLITE_ENABLE_EXTFUNC",
    "SQLITE_ENABLE_CSV",
--    "SQLITE_ENABLE_SHA3",
    "SQLITE_ENABLE_CARRAY",
--    "SQLITE_ENABLE_FILEIO",
    "SQLITE_ENABLE_SERIES",
    "SQLITE_ENABLE_UUID",
    "SQLITE_TEMP_STORE=2",
    "SQLITE_USE_URI",
    "SQLITE_USER_AUTHENTICATION",
-- Compatibility with official SQLite3 shell    
    "SQLITE_ENABLE_DBSTAT_VTAB",
    "SQLITE_ENABLE_STMTVTAB",
    "SQLITE_ENABLE_UNKNOWN_SQL_FUNCTION"
  }

  -- Intermediate directory
  if (is_msvc) then
    objdir (BUILDDIR .. "/obj-" .. vc_with_ver)
  else
    objdir (BUILDDIR .. "/obj-gcc")
  end
  -- Target directory
  filter { "configurations:Debug*" }
    if (is_msvc) then
      targetdir ("bin-" .. vc_with_ver .. "/lib/debug")
    else
      targetdir "bin-gcc/lib/debug"
    end
  filter { "configurations:Release*" }
    if (is_msvc) then
      targetdir ("bin-" .. vc_with_ver .. "/lib/release")
    else
      targetdir "bin-gcc/lib/release"
    end

-- SQLite3 shared library
project "sqlite3dll"
  language "C++"
  kind "SharedLib"

  if (is_msvc) then
    local prj = project()
    prj.filename = "SQLite3Secure_" .. vc_with_ver .. "_dll"
  else
    toolset("gcc")
  end
  makesettings { "include config.gcc" }

  files { "src/sqlite3secure.c", "src/*.h", "src/sqlite3.def", "src/sqlite3.rc" }
  filter {}
  vpaths {
    ["Header Files"] = { "**.h" },
    ["Source Files"] = { "**/sqlite3secure.c", "**.def", "**.rc" }
  }
  characterset ("Unicode")
  staticruntime "On"  

  location( BUILDDIR )
  targetname "sqlite3"

  defines {
    "_USRDLL",
    "SQLITE_THREADSAFE=1",
    "SQLITE_DQS=0",
    "SQLITE_MAX_ATTACHED=10",
    "SQLITE_SOUNDEX",
    "SQLITE_ENABLE_COLUMN_METADATA",
    "SQLITE_HAS_CODEC=1",
    "CODEC_TYPE=CODEC_TYPE_CHACHA20",
    "SQLITE_SECURE_DELETE",
    "SQLITE_ENABLE_FTS3",
    "SQLITE_ENABLE_FTS3_PARENTHESIS",
    "SQLITE_ENABLE_FTS4",
    "SQLITE_ENABLE_FTS5",
    "SQLITE_ENABLE_JSON1",
    "SQLITE_ENABLE_RTREE",
    "SQLITE_ENABLE_GEOPOLY",
    "SQLITE_CORE",
    "SQLITE_ENABLE_EXTFUNC",
    "SQLITE_ENABLE_CSV",
    "SQLITE_ENABLE_SHA3",
    "SQLITE_ENABLE_CARRAY",
    "SQLITE_ENABLE_FILEIO",
    "SQLITE_ENABLE_SERIES",
    "SQLITE_ENABLE_UUID",
    "SQLITE_TEMP_STORE=2",
    "SQLITE_USE_URI",
    "SQLITE_USER_AUTHENTICATION"
  }

  -- Intermediate directory
  if (is_msvc) then
    objdir (BUILDDIR .. "/obj-" .. vc_with_ver)
  else
    objdir (BUILDDIR .. "/obj-gcc")
  end
  -- Target directory
  filter { "configurations:Debug*" }
    if (is_msvc) then
      targetdir ("bin-" .. vc_with_ver .. "/dll/debug")
    else
      targetdir "bin-gcc/dll/debug"
    end
  filter { "configurations:Release*" }
    if (is_msvc) then
      targetdir ("bin-" .. vc_with_ver .. "/dll/release")
    else
      targetdir "bin-gcc/dll/release"
    end

-- SQLite3 Shell    
project "sqlite3shell"
  kind "ConsoleApp"
  language "C++"

  if (is_msvc) then
    local prj = project()
    prj.filename = "SQLite3Secure_" .. vc_with_ver .. "_shell"
  else
    toolset("gcc")
  end
  makesettings { "include config.gcc" }

  vpaths {
    ["Header Files"] = { "**.h" },
    ["Source Files"] = { "**.c", "**.rc" }
  }
  files { "src/sqlite3.h", "src/shell.c", "src/sqlite3shell.rc" }
  characterset ("Unicode")
  staticruntime "On"  
  links { "sqlite3lib" }

  location( BUILDDIR )

  defines {
    "SQLITE_SHELL_IS_UTF8",
    "SQLITE_HAS_CODEC=1",
    "SQLITE_USER_AUTHENTICATION"
  }

  -- Intermediate directory
  if (is_msvc) then
    objdir (BUILDDIR .. "/obj-" .. vc_with_ver)
  else
    objdir (BUILDDIR .. "/obj-gcc")
  end
  -- Target directory
  filter { "configurations:Debug*" }
    if (is_msvc) then
      targetdir ("bin-" .. vc_with_ver .. "/lib/debug")
    else
      targetdir "bin-gcc/lib/debug"
    end
  filter { "configurations:Release*" }
    if (is_msvc) then
      targetdir ("bin-" .. vc_with_ver .. "/lib/release")
    else
      targetdir "bin-gcc/lib/release"
    end

-- ICU support
-- SQLite3 static library with ICU support
project "sqlite3libicu"
  language "C++"
  kind "StaticLib"

  if (is_msvc) then
    local prj = project()
    prj.filename = "SQLite3Secure_" .. vc_with_ver .. "_libicu"
  else
    toolset("gcc")
  end
  makesettings { "include config.gcc" }

  files { "src/sqlite3secure.c", "src/*.h" }
  vpaths {
    ["Header Files"] = { "**.h" },
    ["Source Files"] = { "**/sqlite3secure.c", "**.def", "**.rc" }
  }
  characterset ("Unicode")
  staticruntime "On"  
  includedirs { "$(LIBICU_PATH)/include" }

  location( BUILDDIR )
  targetname "sqlite3icu"

  defines {
    "_LIB",
    "SQLITE_THREADSAFE=1",
    "SQLITE_ENABLE_ICU",
    "SQLITE_DQS=0",
    "SQLITE_MAX_ATTACHED=10",
    "SQLITE_ENABLE_EXPLAIN_COMMENTS",
    "SQLITE_SOUNDEX",
    "SQLITE_ENABLE_COLUMN_METADATA",
    "SQLITE_HAS_CODEC=1",
    "CODEC_TYPE=CODEC_TYPE_CHACHA20",
    "SQLITE_SECURE_DELETE",
    "SQLITE_ENABLE_FTS3",
    "SQLITE_ENABLE_FTS3_PARENTHESIS",
    "SQLITE_ENABLE_FTS4",
    "SQLITE_ENABLE_FTS5",
    "SQLITE_ENABLE_JSON1",
    "SQLITE_ENABLE_RTREE",
    "SQLITE_ENABLE_GEOPOLY",
    "SQLITE_CORE",
    "SQLITE_ENABLE_EXTFUNC",
    "SQLITE_ENABLE_CSV",
--    "SQLITE_ENABLE_SHA3",
    "SQLITE_ENABLE_CARRAY",
--    "SQLITE_ENABLE_FILEIO",
    "SQLITE_ENABLE_SERIES",
    "SQLITE_ENABLE_UUID",
    "SQLITE_TEMP_STORE=2",
    "SQLITE_USE_URI",
    "SQLITE_USER_AUTHENTICATION",
-- Compatibility with official SQLite3 shell    
    "SQLITE_ENABLE_DBSTAT_VTAB",
    "SQLITE_ENABLE_STMTVTAB",
    "SQLITE_ENABLE_UNKNOWN_SQL_FUNCTION"
  }

  -- Intermediate directory
  if (is_msvc) then
    objdir (BUILDDIR .. "/obj-" .. vc_with_ver)
  else
    objdir (BUILDDIR .. "/obj-gcc")
  end
  -- Target directory
  filter { "configurations:Debug*" }
    if (is_msvc) then
      targetdir ("bin-" .. vc_with_ver .. "/lib/debug")
    else
      targetdir "bin-gcc/lib/debug"
    end
  filter { "configurations:Release*" }
    if (is_msvc) then
      targetdir ("bin-" .. vc_with_ver .. "/lib/release")
    else
      targetdir "bin-gcc/lib/release"
    end

-- SQLite3 shared library with ICU support
project "sqlite3dllicu"
  language "C++"
  kind "SharedLib"

  if (is_msvc) then
    local prj = project()
    prj.filename = "SQLite3Secure_" .. vc_with_ver .. "_dllicu"
  else
    toolset("gcc")
  end
  makesettings { "include config.gcc" }

  files { "src/sqlite3secure.c", "src/*.h", "src/sqlite3.def", "src/sqlite3.rc" }
  filter {}
  vpaths {
    ["Header Files"] = { "**.h" },
    ["Source Files"] = { "**/sqlite3secure.c", "**.def", "**.rc" }
  }
  characterset ("Unicode")
  staticruntime "On"  
  includedirs { "$(LIBICU_PATH)/include" }  

  filter { "platforms:Win32" }
    libdirs { "$(LIBICU_PATH)/lib" }
  filter { "platforms:Win64" }
    libdirs { "$(LIBICU_PATH)/lib64" }
  filter {}

  filter { "configurations:Debug*" }
    links { "icuind", "icuucd" }
  filter { "configurations:Release*" }
    links { "icuin", "icuuc" }
  filter {}

  location( BUILDDIR )
  targetname "sqlite3icu"

  defines {
    "_USRDLL",
    "SQLITE_THREADSAFE=1",
    "SQLITE_ENABLE_ICU",
    "SQLITE_DQS=0",
    "SQLITE_MAX_ATTACHED=10",
    "SQLITE_SOUNDEX",
    "SQLITE_ENABLE_COLUMN_METADATA",
    "SQLITE_HAS_CODEC=1",
    "CODEC_TYPE=CODEC_TYPE_CHACHA20",
    "SQLITE_SECURE_DELETE",
    "SQLITE_ENABLE_FTS3",
    "SQLITE_ENABLE_FTS3_PARENTHESIS",
    "SQLITE_ENABLE_FTS4",
    "SQLITE_ENABLE_FTS5",
    "SQLITE_ENABLE_JSON1",
    "SQLITE_ENABLE_RTREE",
    "SQLITE_ENABLE_GEOPOLY",
    "SQLITE_CORE",
    "SQLITE_ENABLE_EXTFUNC",
    "SQLITE_ENABLE_CSV",
    "SQLITE_ENABLE_SHA3",
    "SQLITE_ENABLE_CARRAY",
    "SQLITE_ENABLE_FILEIO",
    "SQLITE_ENABLE_SERIES",
    "SQLITE_ENABLE_UUID",
    "SQLITE_TEMP_STORE=2",
    "SQLITE_USE_URI",
    "SQLITE_USER_AUTHENTICATION"
  }

  -- Intermediate directory
  if (is_msvc) then
    objdir (BUILDDIR .. "/obj-" .. vc_with_ver)
  else
    objdir (BUILDDIR .. "/obj-gcc")
  end
  -- Target directory
  filter { "configurations:Debug*" }
    if (is_msvc) then
      targetdir ("bin-" .. vc_with_ver .. "/dll/debug")
    else
      targetdir "bin-gcc/dll/debug"
    end
  filter { "configurations:Release*" }
    if (is_msvc) then
      targetdir ("bin-" .. vc_with_ver .. "/dll/release")
    else
      targetdir "bin-gcc/dll/release"
    end

-- SQLite3 Shell with ICU support   
project "sqlite3shellicu"
  kind "ConsoleApp"
  language "C++"

  if (is_msvc) then
    local prj = project()
    prj.filename = "SQLite3Secure_" .. vc_with_ver .. "_shellicu"
  else
    toolset("gcc")
  end
  makesettings { "include config.gcc" }

  vpaths {
    ["Header Files"] = { "**.h" },
    ["Source Files"] = { "**.c", "**.rc" }
  }
  files { "src/sqlite3.h", "src/shell.c", "src/sqlite3shell.rc" }
  characterset ("Unicode")
  staticruntime "On"  
  links { "sqlite3libicu" }

  filter { "platforms:Win32" }
    libdirs { "$(LIBICU_PATH)/lib" }  
  filter { "platforms:Win64" }
    libdirs { "$(LIBICU_PATH)/lib64" }  
  filter {}

  filter { "configurations:Debug*" }
    links { "icuind", "icuucd" }
  filter { "configurations:Release*" }
    links { "icuin", "icuuc" }
  filter {}

  location( BUILDDIR )

  defines {
    "SQLITE_SHELL_IS_UTF8",
    "SQLITE_HAS_CODEC=1",
    "SQLITE_USER_AUTHENTICATION"
  }

  -- Intermediate directory
  if (is_msvc) then
    objdir (BUILDDIR .. "/obj-" .. vc_with_ver)
  else
    objdir (BUILDDIR .. "/obj-gcc")
  end
  -- Target directory
  filter { "configurations:Debug*" }
    if (is_msvc) then
      targetdir ("bin-" .. vc_with_ver .. "/lib/debug")
    else
      targetdir "bin-gcc/lib/debug"
    end
  filter { "configurations:Release*" }
    if (is_msvc) then
      targetdir ("bin-" .. vc_with_ver .. "/lib/release")
    else
      targetdir "bin-gcc/lib/release"
    end
