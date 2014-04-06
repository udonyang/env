# $(call source-to-object, source-file-list)
source_to_object	= $(subst .c,.o,$(filter %.c,$1))

# $(subdirectory)
subdirectory	= $(patsubst %/module.mk,%,\
								$(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST)))

# $(call make-slibrary, library-name, source-file-list)
define make_slibrary
	libraries	+= $1
	sources += $2
$(notdir $1): $(call source_to_object,$2)
$1: $(call source_to_object,$2)
	$(AR) $(ARFLAGS) $$@ $$^
endef

# $(call make-dlibrary, library-name, source-file-list)
define make_dlibrary
	libraries	+= $1
	sources += $2
$(notdir $1): $(call source_to_object,$2)
$1: $(call source_to_object,$2)
	$(CC) -fPIC -Wall -shared -o $$@ $$^
endef

# $(call make-program, program-name, source-file-list)
define make_program
	programs += $1
	sources += $2
$(notdir $1): $(call source_to_object,$2)
$1: $(call source_to_object,$2)
	$(CC) $(CFLAGS) $(TARGET_ARCH) -o $$@ $$^
endef

# Makefile All-in-one
modules				:= $(subst /module.mk,,$(shell find . -name module.mk))
programs			:=
sources				:=
libraries			:=

objects				= $(call source_to_object,$(sources))
dependencies	= $(subst .o,.d,$(objects))

include_dirs	:= src
vpath %.h $(include_dirs)

includes	:= $(shell find $(include_dirs) -name *.h)

CFLAGS				+= -Wall -O2 $(addprefix -I ,$(include_dirs))

CC		:= gcc
MV		:= mv -f
RM		:= rm -rf
CP		:= cp -rf
MKDIR	:= mkdir -p
SED		:= sed
ECHO	:= echo -e

project				:= empty
prefix				:= /usr/local
programs_dir	:= $(prefix)/bin
libraries_dir	:= $(prefix)/lib
includes_dir	:= $(prefix)/include/$(project)
to_programs		= $(filter-out test/%,$(programs))
to_libraries	= $(filter-out test/%,$(libraries))
to_includes		= $(filter-out test/%,$(includes))

all:

include $(addsuffix /module.mk,$(modules))

.PHONY: all install libraries clean distclean test new

all: $(programs)

libraries: $(libraries)

install:
ifneq "$(to_programs)" ""
	$(MKDIR) $(programs_dir)
	$(CP) $(to_programs) $(programs_dir)
endif
ifneq "$(to_libraries)" ""
	$(MKDIR) $(libraries_dir)
	$(CP) $(to_libraries) $(libraries_dir)
endif
ifneq "$(to_includes)" ""
	$(MKDIR) $(includes_dir)
	$(CP) $(to_includes) $(includes_dir)
endif

clean:
ifneq "$(to_programs)" ""
	$(RM) $(programs_dir)/$(notdir $(to_programs))
endif
ifneq "$(to_libraries)" ""
	$(RM) $(libraries_dir)/$(notdir $(to_libraries))
endif
ifneq "$(to_includes)" ""
	$(RM)	$(includes_dir)
endif

distclean:
	$(RM) $(objects) $(programs) $(libraries)\
		$(dependencies)

test:
	./test/main

# New Target
# make new -e new_name= -e new_type= -e new_dir= -e new_srctype=
# new_name		: target name
# new_type		: program | slibrary dlibrary
# new_dir			: new directory relative to the project root
# new_srctype	: source files suffix. eg. *.c
new_name		:=
new_type		:=
new_dir 		:=
new_srctype	:=

new:
	$(MKDIR) $(new_dir)
	$(ECHO) 'local_sources	:= $$(wildcard $$(subdirectory)/$(new_srctype))'\
		> $(new_dir)/module.mk
	$(ECHO) '$$(eval $$(call make_$(new_type),$$(subdirectory)/$(new_name),$$(local_sources)))'\
		>> $(new_dir)/module.mk

ifneq "$(MAKECMDGOALS)" "distclean"
  sinclude $(dependencies)
endif

# Pattern rule
%.d: %.c
	@$(CC) $(CFLAGS) $(TARGET_ARCH) -M $< |\
		$(SED) 's,\($(notdir $*)\.o\) *:,$(dir $@)\1 $@: ,'> $@.tmp
	@$(MV) $@.tmp $@
