TARGET=libuchardet
VERSIONINFO=0:0:0
CXXFLAGS=-c -O2 -D_REENTRANT -I./src -I./include

SUBDIRS=src
DESTDIR=/usr/local
DESTLIBDIR=$(DESTDIR)/lib
DESTINCLUDEDIR=$(DESTDIR)/include

all: libuchardet

libuchardet:
	@for mdir in $(SUBDIRS); do \
	  if test -d $$mdir; then \
	    $(MAKE) -C $$mdir ; \
	  fi; \
	done
	libtool --mode=compile $(CXX) $(CXXFLAGS) dll/dll.cpp
	libtool --mode=link gcc -O -o $(TARGET).la dll.lo src/*.lo \
	        -rpath $(DESTLIBDIR) -lstdc++ -version-info $(VERSIONINFO)

install: libuchardet
	libtool --mode=install install -c -m 644 \
	        $(TARGET).la $(DESTLIBDIR)/$(TARGET).la
	install -c -m 644 include/universalchardet.h \
	        $(DESTINCLUDEDIR)/universalchardet.h

clean:
	@for mdir in $(SUBDIRS); do \
	  if test -d $$mdir; then \
	    $(MAKE) -C $$mdir clean ; \
	  fi; \
	done
	rm -f *.o
	rm -f *.lo
	rm -f *.la
	rm -rf .libs

