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
#include "print.h"
#include "options.h"

char* skip_line (char* ind, int n)
{
    while (n > 0 && *ind != 0) {
	if (*ind == '\n') n--;
	ind++;
    }
    return ind;
}

char* read_file (char *name)
{
    FILE *file;
    int size = 1024, number, length = 0;
    char *buffer;

    file = fopen(name,"r");
    if (file == NULL) print_error ("Unable to open file.\n");

    buffer = (char *) malloc (size);

    do {
	number = fread (buffer + length, 1, 1024, file);
	length += number;
	if (size == length) {
	    size *= 2;
	    buffer = (char *) realloc (buffer, size);
	}
    } while (number == 1024);
    
    buffer[length] = 0;

    fclose (file);

    return buffer;
}

void remove_file (char *suffix)
{
    char *name;

    name = get_name (suffix);
    remove (name);
    free (name);
}

void remove_files (void)
{
    remove_file (".aux");
    remove_file (".toc");
    if (opt_eukleides) {
	remove_file (".ptx");
	remove_file (".plg");
    }
    if (opt_bibtex) remove_file (".bbl");
    if (opt_makeindex) remove_file (".idx");
    if (opt_postscript) remove_file (".dvi");
}

void make_clean (void)
{
    if (!opt_remove) remove_files ();
    remove (log_name);
    if (opt_bibtex) remove_file (".blg");
    if (opt_makeindex) remove_file (".ilg");
}
