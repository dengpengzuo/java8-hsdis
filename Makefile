# Single gnu makefile for solaris, linux and windows (windows requires cygwin and mingw)
# author: zuo deng peng.
#   date 2017-5-21 
# Default arch; it is changed below as needed.
ARCH		= i386
OS			= $(shell uname -o)

## OS = Linux ##
CPU         = $(shell uname -m)
ARCH		= amd64
CFLAGS		+= $(CFLAGS/$(ARCH))
CFLAGS		+= -fPIC
OS			= linux
LIB_EXT		= .so
CC 			= gcc
CFLAGS		+= -Wall
DLDFLAGS	+= -shared
LDFLAGS     += -lltdl
OUTFLAGS	+= -s -O2 -o $@

LIBARCH		= $(ARCH)
JDKARCH		= $(ARCH)
BINUTILSDIR	= /usr/include

CPPFLAGS	+= -I${BINUTILSDIR} -I$(BINUTILSDIR)/libiberty
CPPFLAGS	+= -DLIBARCH_$(LIBARCH) -DLIBARCH=\"$(LIBARCH)\" -DLIB_EXT=\"$(LIB_EXT)\"

TARGET_DIR	= build/$(OS)-$(JDKARCH)
TARGET		= $(TARGET_DIR)/hsdis-$(LIBARCH)$(LIB_EXT)

SOURCE		= hsdis.c
# mingw add libintl.a libz.a libltdl.a
LIBRARIES =	-lbfd -lopcodes -liberty -lz

DEMO_TARGET	= $(TARGET_DIR)/hsdis-demo
DEMO_SOURCE	= hsdis-demo.c

.PHONY:  all

all:  $(TARGET) ${DEMO_TARGET}

demo: $(DEMO_TARGET)

$(TARGET): $(SOURCE) $(TARGET_DIR)
	$(CC) $(OUTFLAGS) $(CPPFLAGS) $(CFLAGS) $(SOURCE) $(DLDFLAGS) $(LIBRARIES)

$(DEMO_TARGET): $(DEMO_SOURCE) $(TARGET) $(TARGET_DIR)
	$(CC) $(OUTFLAGS) -DTARGET_DIR=\"$(TARGET_DIR)\" $(CPPFLAGS) -g $(CFLAGS/$(ARCH)) $(DEMO_SOURCE) $(LDFLAGS)

$(TARGET_DIR):
	[ -d $@ ] || mkdir -p $@

clean:
	rm -rf $(TARGET_DIR)
