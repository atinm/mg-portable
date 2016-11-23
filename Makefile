PORTNAME	= mg
PREFIX		= /usr
MANPREFIX	= ${PREFIX}/share/man
DOCSDIR		= ${PREFIX}/share/doc/${PORTNAME}

CC	 =	gcc

LDFLAGS	+=	-lncurses
CFLAGS	+=	-I. -Iopenbsd-compat/
CFLAGS	+=	-Wall -Wpointer-arith
CFLAGS  +=	-Wstrict-prototypes -Wmissing-prototypes
CFLAGS  +=	-Wmissing-declarations -Wshadow
CFLAGS  +=	-Wpointer-arith -Wcast-qual
CFLAGS  +=	-Wsign-compare
# (Common) compile-time options:
#
#	FKEYS		-- add support for function key sequences.
#	REGEX		-- create regular expression functions.
#	STARTUP		-- look for and handle initialization file.
#	XKEYS		-- use termcap function key definitions.
#				note: XKEYS and bsmap mode do _not_ get along.
#
CFLAGS	+=	-DFKEYS -DREGEX -DXKEYS

PROG	 =	mg
OBJS	 =	autoexec.o basic.o buffer.o cinfo.o dir.o display.o \
		echo.o extend.o file.o fileio.o funmap.o help.o kbd.o \
		keymap.o line.o macro.o main.o match.o modes.o \
		paragraph.o random.o re_search.o region.o search.o \
		spawn.o tty.o ttyio.o ttykbd.o undo.o version.o \
		window.o word.o yank.o cmode.o dired.o grep.o \
		cscope.o tags.o bell.o

OBJS	+=	openbsd-compat/strtonum.o openbsd-compat/strlcpy.o \
		openbsd-compat/strlcat.o openbsd-compat/fgetln.o \
		openbsd-compat/fparseln.o \
		openbsd-compat/bdirname.o

.PHONY: install uninstall clean

all: ${PROG}

.c.o:
	${CC} ${CFLAGS} $< -c -o $@;

${PROG}: ${OBJS}
	${CC} ${CFLAGS} ${OBJS} ${LDFLAGS} -o $@;

install:
	install -o root -g bin -m 555 -s -S -d mg ${PREFIX}/bin/mg;
	install -o root -g bin -m 444 -S -d mg.1 ${MANPREFIX}/man1/mg.1;
	if [ ! -d ${DOCSDIR} ]; then \
		mkdir -p ${DOCSDIR}; \
	fi;
	install -o root -g bin -m 444 -S -d tutorial ${DOCSDIR}/tutorial;

uninstall:
	rm -f ${PREFIX}/bin/mg;
	rm -f ${MANPREFIX}/man1/mg.1;
	rm -rf ${DOCSDIR};

clean:
	rm -f mg ${OBJS};
