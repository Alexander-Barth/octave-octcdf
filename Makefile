
sinclude ../../Makeconf


NCTARGET = ov-netcdf.oct

NCSOURCES = ov-netcdf.cc ov-ncfile.cc ov-ncvar.cc ov-ncatt.cc ov-ncdim.cc 
OBJECTS = $(patsubst %.cc,%.o,$(NCSOURCES))

NCLINKTARGETS = ncclose.oct  \
   ncredef.oct ncenddef.oct ncsync.oct ncvar.oct ncatt.oct ncdim.oct ncname.oct ncdatatype.oct netcdf.oct

MFILES =  ncchar.m ncfloat.m nclong.m ncbyte.m ncdouble.m ncint.m ncshort.m 

TARGETS = $(NCTARGET) $(NCLINKTARGETS)

# assumptions to make if not using ./configure script
ifndef OCTAVE_FORGE
	MKOCTFILE=mkoctfile

        NETCDF_INC=/usr/include/netcdf-3
        NETCDF_LIB=/usr/lib64/netcdf-3

        CPPFLAGS := $(CPPFLAGS) -I$(NETCDF_INC)
        LDFLAGS := $(LDFLAGS) -L$(NETCDF_LIB)
        LN_S=ln -s
        RM = rm -f
endif

MOFLAGS = $(CPPFLAGS)

#
# comment this line out if your octave installation does not have integer types.
#
MOFLAGS := $(MOFLAGS) -DHAVE_OCTAVE_INT

EXTRALIBS = $(LDFLAGS) -lnetcdf

# To enable OPeNDAP support you have to use to following libraries (or similar ones)
#EXTRALIBS =  $(LDFLAGS) -lnc-dods -ldap++ -lnetcdf  -lxml2 -lcurl

ifeq ($(HAVE_NETCDF),yes)
all: $(TARGETS)
else
all:
endif

mfiles: $(MFILES)

$(NCLINKTARGETS) : $(NCTARGET)
	$(RM) $@ ; \
	$(LN_S) $(NCTARGET) $@

ov-netcdf.o ov-ncfile.o ov-ncvar.o  ov-ncatt.o  ov-ncdim.o: ov-netcdf.h ov-ncfile.h ov-ncvar.h  ov-ncatt.h ov-ncdim.h

$(NCTARGET) : $(OBJECTS)
	$(MKOCTFILE)  -o $@ $(MOFLAGS) $(OBJECTS) $(EXTRALIBS)

%.o:%.cc
	$(MKOCTFILE) -c $< $(MOFLAGS) $(DEFINES)


$(MFILES): nctype.m4
	m4 --define=TYPE=$(patsubst nc%.m,%,$@) nctype.m4 > $@

clean: ; -$(RM) *.o core* octave-core *.oct *~ *.nc 

