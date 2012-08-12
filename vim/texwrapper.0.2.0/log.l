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

%{
#define YY_NO_UNPUT

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "options.h"
#include "print.h"
#include "files.h"

struct list {
    char *name;
    char *buffer;
    char *ind;
    int prev_line;
    struct list *prev;
};

char *msg;
int line, log_errors = 0;
struct list *file_list = NULL;
struct list *new, *old;

int logwrap(void)
{
  return 1;
}

void log_col (char *text)
{
    int col;

    if (file_list->buffer == NULL)
	file_list->buffer = file_list->ind = read_file (file_list->name);
    file_list->ind = skip_line (file_list->ind, line - file_list->prev_line);
    file_list->prev_line = line;
    col = (int)(strstr (file_list->ind, text) - file_list->ind) + strlen(text);
    log_errors++;
    add_error (file_list->name, line, col, msg);
    free (msg);
}

%}

%s LINE COL REMAINDER

%%

\([^)\n]+ {
	new = (struct list*)malloc (sizeof (struct list));
	new->name = strdup (logtext+1);
	new->buffer = NULL;
	new->prev_line = 1;
	new->prev = file_list;
	file_list = new;
}

\) {
	old = file_list;
	file_list = file_list->prev;
	free (old->name);
	free (old->buffer);
	free (old);
}
	
^"! Emergency stop." {
	print_message ("TeX: Emergency stop.\n");
}

^"! ".+ { 
	msg = strdup (logtext+2);
	BEGIN LINE;
}

<LINE>l\.[0-9]+[ ]"..."{0,1} { 
	line = atoi (logtext+2);
	BEGIN COL;
}


<COL>.* {
	log_col (logtext);
	BEGIN REMAINDER;
}

<REMAINDER>\n.*\n {
	BEGIN INITIAL;
}

.|\n ;

%%

void process_log (void)
{
    err_prog = "TeX";

    login = fopen (log_name, "r");
    if (login == NULL) print_message ("TeX: Emergency stop.\n");
    logout = NULL;
    loglex();

    window ();
    exit (EXIT_FAILURE);
}
