#*******************************************************************************
# File name        : makefile
# File description : C
# Author           : ronyett
#*******************************************************************************

SRC_DIR				= 	.
OBJECT_DIR		= 	$(SRC_DIR)/object
MAKE_DIR_CMD	= 	mkdir $(OBJECT_DIR)

#*******************************************************************************
# Tools
#*******************************************************************************
CC  					= 	gcc
LINK  				= 	gcc
AR						= 	ar
CHK   				= 	checkmk
CHECK_FOR_CHK	:= 	$(shell command -v $(CHK) 2> /dev/null)
RM						= 	rm

#*******************************************************************************
# Build options
#*******************************************************************************

# gcov and gprof build options
COVPFLAGS		= 	-fprofile-arcs -ftest-coverage
PROFLAGS		= 	-pg
#PFLAGS			= 	$(COVFLAGS)

# Main CC and Link build strings
DEBUG				= 	-g
CFLAGS			= 	-c -std=c99 -Wall -pedantic $(PFLAGS)
LFLAGS			= 	$(PFLAGS) -static -L.

# -DDEBUG_TRACE	Will turn on deep trace per function
# -DEXCEPTION	Will use the real exceptions with the 'try' that's in the test harness

#
# Code checking with splint
#
#CODE_CHECK       	= 	splint
#CODE_CHECK_ARGS	 	= 	-showfunc -mustfreefresh -nullpass -nullret -noeffect

CODE_CHECK				= 	cppcheck
CODE_CHECK_ARGS		= 	--enable=all

# codespell
CODE_SPELL				= 	codespell
CODE_SPELL_ARGS		= 	--skip "*.a,*.o,*.exe,./.git"
CHECK_FOR_CODESPELL	:=	$(shell command -v $(CODE_SPELL) 2> /dev/null)

#
# Libs, objs targets
#
OBJS  		     	=	$(OBJECT_DIR)/inttoascii.o

LIBS  		     	= 	

#*******************************************************************************
# Build targets:
# all		Creates object directory, builds executable and runs checker
# splint-it	run the Syntax checker
# clean		Delete object and library files
#*******************************************************************************

all:	$(OBJECT_DIR) inttoascii.exe spelling-bee splint-it

lib:	$(LIBS)

inttoascii.exe:	$(OBJECT_DIR)/inttoascii.o
			$(LINK) $(OBJECT_DIR)/inttoascii.o $(LFLAGS) -o inttoascii.exe

$(OBJECT_DIR):
	-		$(MAKE_DIR_CMD)

$(OBJECT_DIR)/inttoascii.o:		inttoascii.c
			$(CC) $(CFLAGS) $(DEBUG) inttoascii.c -o $(OBJECT_DIR)/inttoascii.o

#
# Code checking target
#
splint-it:
			$(CODE_CHECK) $(CODE_CHECK_ARGS) inttoascii.c

spelling-bee:
ifndef CHECK_FOR_CODESPELL
			@echo "** codespell was not found"
else
			$(CODE_SPELL) $(CODE_SPELL_ARGS)
endif

clean:
	$(RM) -f inttoascii.exe
	$(RM) -f $(OBJECT_DIR)/inttoascii.o
	$(RM) -f *.gcno
	$(RM) -f *.gcda
	$(RM) -f gmon.out
	$(RM) -f core

#
# Fin
#

