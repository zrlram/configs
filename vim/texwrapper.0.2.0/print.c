/*
 *  TeXwrapper version 0.2.0
 *  Copyright (c) Christian Obrecht 2002
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "options.h"
#include "print.h"

int err_count = 0;
char err_msg[1378];
char* ind = err_msg;

void window (void)
{
    int pid;

    if (!opt_window || !err_count) return;

    pid = fork ();
    if (pid == -1) print_error ("Unable to fork.\n");
    if (pid == 0) {
	if (err_count > 16)
	    snprintf (ind, 80, "[%d more error%s]\n",
		      err_count-16, (err_count==17)?"":"s");
	execlp ("texwrapper_window",
		"texwrapper_window", err_prog, err_msg, (char *)0);
	print_error ("Unable to open window.\n");
    }
}

void add_error (char *err_file, int line, int col, char *msg)
{
    fprintf (stderr, "%s:%d:%d:%s\n", err_file, line, col, msg);
    err_count++;
    if (opt_window && err_count < 17) {
	snprintf (ind, 80, "Line %d: %s\n", line, msg);
	ind = index (ind, 0);
    }
}

void add_entry_error (char *entry, char *msg)
{
    fprintf (stderr, "%s:%s\n", entry, msg);
    err_count++;
    if (opt_window && err_count < 17) {
	snprintf (ind, 80, "Entry %s: %s\n", entry, msg);
	ind = index (ind, 0);
    }
}

void add_message (char *msg)
{
    err_count++;
    if (opt_window && err_count < 17) {
	sprintf (ind, msg);
	ind = index (ind, 0);
    }
}

void print_message (char* msg)
{
    add_message (msg);
    window ();
    fprintf (stderr, msg);
    exit (EXIT_SUCCESS);
}

void print_error (char* msg)
{
    fprintf (stderr, "TeXwrapper: %s", msg);
    exit (EXIT_FAILURE);
}

void print_version (void)
{
    printf ("TeXwrapper version 0.2.0\n"
	    "Copyright (C) Christian Obrecht 2002\n");
    exit (EXIT_SUCCESS);
}

void print_help (int val)
{
    printf ("Usage is: texwrapper [<options>] <filename>[.tex]\n\n"
	    "-b, --bibtex\t\tRun BibTeX.\n"
	    "-c, --clean\t\tMake clean after processing.\n"
	    "-e, --eukleides\t\tRun eukleides.\n"
	    "--format <fmt>\t\tRun TeX with format <fmt>.\n"
	    "-h, --help\t\tPrint this help and exit.\n"
	    "-l, --latex\t\tRun LaTeX instead of TeX.\n"
	    "-m, --makeindex <file>\tRun MakeIndex (with -s <file>).\n"
	    "-o, --option <opt>\tUse option <opt> to run TeX.\n"
	    "-p, --postscript <opt>\tRun Dvips (with option <opt>).\n"
	    "-r, --remove\t\tRemove intermediate files.\n"
	    "-2, --twice\t\tRun TeX twice.\n"
	    "-v, --version\t\tPrint version number and exit.\n"
	    "-w, --window\t\tPop up a window when errors are detected.\n\n"
	    "NOTE: Only long options can take arguments.\n\n"
	    "See man page for more information.\n");
    exit (val);
}
