# TeXwrapper 0.2.0 makefile
# Copyright (c) Christian Obrecht 2002

LEX = flex
CC = gcc
CFLAGS = -c -O2 -Wall
OBJECTS = lex.log.o lex.ilg.o lex.blg.o\
	  eukleides.o tex.o makeindex.o bibtex.o dvips.o\
	  options.o print.o files.o main.o
BIN = texwrapper
PREFIX = /usr/local/
BINDIR = $(PREFIX)bin/
MANDIR = $(PREFIX)man/man1/

texwrapper : $(OBJECTS)
	$(CC) -o $(BIN) $(OBJECTS)

popup : texwrapper_window

texwrapper_window : window.c
	$(CC) $< -o $@ `gtk-config --cflags --libs`

bibtex.o: bibtex.c options.h print.h

dvips.o: dvips.c options.h print.h files.h

eukleides.o: eukleides.c options.h print.h files.h

files.o: files.c print.h options.h

main.o: main.c options.h print.h process.h files.h

makeindex.o: makeindex.c options.h print.h

options.o: options.c print.h

print.o: print.c options.h print.h

tex.o: tex.c options.h print.h

.c.o :
	$(CC) $(CFLAGS) $<

lex.log.c : log.l
	$(LEX) -Plog $<

lex.ilg.c : ilg.l
	$(LEX) -Pilg $<

lex.blg.c : blg.l
	$(LEX) -Pblg $<

man : texwrapper.1

install : texwrapper man
	install -s $(BIN) $(BINDIR) ;\
	install -m 0644 texwrapper.1 $(MANDIR)

install_popup : texwrapper_window
	install -s texwrapper_window $(BINDIR)

uninstall :
	rm -f $(BINDIR)$(BIN) ; \
	rm -f $(BINDIR)texwrapper_window ; \
	rm -f $(MANDIR)texwrapper.1

clean :
	rm -f lex.???.c *.o $(BIN) texwrapper_window
