# Alternative GNU Make project makefile autogenerated by Premake

ifndef config
  config=debug_win32
endif

ifndef verbose
  SILENT = @
endif

.PHONY: clean prebuild

SHELLTYPE := posix
ifeq (.exe,$(findstring .exe,$(ComSpec)))
	SHELLTYPE := msdos
endif

# Configurations
# #############################################

RESCOMP = windres
INCLUDES +=
FORCE_INCLUDE +=
ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
LINKCMD = $(CXX) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
include config.gcc

define PREBUILDCMDS
endef
define PRELINKCMDS
endef
define POSTBUILDCMDS
endef

ifeq ($(config),debug_win32)
TARGETDIR = ../bin-gcc/lib/debug
TARGET = $(TARGETDIR)/sqlite3shellicu.exe
OBJDIR = obj-gcc/Win32/Debug/sqlite3shellicu
DEFINES += -D_WINDOWS -DWIN32 -D_CRT_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_DEPRECATE -D_CRT_NONSTDC_NO_DEPRECATE -DDEBUG -D_DEBUG -DSQLITE_SHELL_IS_UTF8 -DSQLITE_HAS_CODEC=1 -DSQLITE_USER_AUTHENTICATION
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m32 -g
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m32 -g
LIBS += ../bin-gcc/lib/debug/sqlite3icu.lib -licuind -licuucd
LDDEPS += ../bin-gcc/lib/debug/sqlite3icu.lib
ALL_LDFLAGS += $(LDFLAGS) -L"$(LIBICU_PATH)/lib" -L/usr/lib32 -m32

else ifeq ($(config),debug_win64)
TARGETDIR = ../bin-gcc/lib/debug
TARGET = $(TARGETDIR)/sqlite3shellicu_x64.exe
OBJDIR = obj-gcc/Win64/Debug/sqlite3shellicu
DEFINES += -D_WINDOWS -DWIN32 -D_CRT_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_DEPRECATE -D_CRT_NONSTDC_NO_DEPRECATE -DDEBUG -D_DEBUG -DSQLITE_SHELL_IS_UTF8 -DSQLITE_HAS_CODEC=1 -DSQLITE_USER_AUTHENTICATION
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -g
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -g
LIBS += ../bin-gcc/lib/debug/sqlite3icu_x64.lib -licuind -licuucd
LDDEPS += ../bin-gcc/lib/debug/sqlite3icu_x64.lib
ALL_LDFLAGS += $(LDFLAGS) -L"$(LIBICU_PATH)/lib64" -L/usr/lib64 -m64

else ifeq ($(config),release_win32)
TARGETDIR = ../bin-gcc/lib/release
TARGET = $(TARGETDIR)/sqlite3shellicu.exe
OBJDIR = obj-gcc/Win32/Release/sqlite3shellicu
DEFINES += -D_WINDOWS -DWIN32 -D_CRT_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_DEPRECATE -D_CRT_NONSTDC_NO_DEPRECATE -DNDEBUG -DSQLITE_SHELL_IS_UTF8 -DSQLITE_HAS_CODEC=1 -DSQLITE_USER_AUTHENTICATION
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m32 -O2
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m32 -O2
LIBS += ../bin-gcc/lib/release/sqlite3icu.lib -licuin -licuuc
LDDEPS += ../bin-gcc/lib/release/sqlite3icu.lib
ALL_LDFLAGS += $(LDFLAGS) -L"$(LIBICU_PATH)/lib" -L/usr/lib32 -m32 -s

else ifeq ($(config),release_win64)
TARGETDIR = ../bin-gcc/lib/release
TARGET = $(TARGETDIR)/sqlite3shellicu_x64.exe
OBJDIR = obj-gcc/Win64/Release/sqlite3shellicu
DEFINES += -D_WINDOWS -DWIN32 -D_CRT_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_DEPRECATE -D_CRT_NONSTDC_NO_DEPRECATE -DNDEBUG -DSQLITE_SHELL_IS_UTF8 -DSQLITE_HAS_CODEC=1 -DSQLITE_USER_AUTHENTICATION
ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -m64 -O2
ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -m64 -O2
LIBS += ../bin-gcc/lib/release/sqlite3icu_x64.lib -licuin -licuuc
LDDEPS += ../bin-gcc/lib/release/sqlite3icu_x64.lib
ALL_LDFLAGS += $(LDFLAGS) -L"$(LIBICU_PATH)/lib64" -L/usr/lib64 -m64 -s

else
  $(error "invalid configuration $(config)")
endif

# Per File Configurations
# #############################################


# File sets
# #############################################

CUSTOM :=
OBJECTS :=

CUSTOM += $(OBJDIR)/sqlite3shell.res
OBJECTS += $(OBJDIR)/shell.o

# Rules
# #############################################

all: $(TARGET)
	@:

$(TARGET): $(CUSTOM) $(OBJECTS) $(LDDEPS) | $(TARGETDIR)
	$(PRELINKCMDS)
	@echo Linking sqlite3shellicu
	$(SILENT) $(LINKCMD)
	$(POSTBUILDCMDS)

$(TARGETDIR):
	@echo Creating $(TARGETDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(TARGETDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(TARGETDIR))
endif

$(OBJDIR):
	@echo Creating $(OBJDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif

clean:
	@echo Cleaning sqlite3shellicu
ifeq (posix,$(SHELLTYPE))
	$(SILENT) rm -f  $(TARGET)
	$(SILENT) rm -rf $(OBJDIR)
else
	$(SILENT) if exist $(subst /,\\,$(TARGET)) del $(subst /,\\,$(TARGET))
	$(SILENT) if exist $(subst /,\\,$(OBJDIR)) rmdir /s /q $(subst /,\\,$(OBJDIR))
endif

prebuild: | $(OBJDIR)
	$(PREBUILDCMDS)

$(CUSTOM): | prebuild
ifneq (,$(PCH))
$(OBJECTS): $(GCH) | $(PCH_PLACEHOLDER)
$(GCH): $(PCH) | prebuild
	@echo $(notdir $<)
	$(SILENT) $(CXX) -x c++-header $(ALL_CXXFLAGS) -o "$@" -MF "$(@:%.gch=%.d)" -c "$<"
$(PCH_PLACEHOLDER): $(GCH) | $(OBJDIR)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) touch "$@"
else
	$(SILENT) echo $null >> "$@"
endif
else
$(OBJECTS): | prebuild
endif


# File Rules
# #############################################

$(OBJDIR)/shell.o: ../src/shell.c
	@echo $(notdir $<)
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"
$(OBJDIR)/sqlite3shell.res: ../src/sqlite3shell.rc
	@echo $(notdir $<)
	$(SILENT) $(RESCOMP) $< -O coff -o "$@" $(ALL_RESFLAGS)

-include $(OBJECTS:%.o=%.d)
ifneq (,$(PCH))
  -include $(PCH_PLACEHOLDER).d
endif