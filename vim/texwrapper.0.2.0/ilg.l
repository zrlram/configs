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

char *ilg_name;
char *file_name;
int line, ilg_errors = 0;

int ilgwrap(void)
{
  return 1;
}

%}

%s LINE MSG

%%

("!! Input index"|"** Input style")" error (file = "[^,]+ {
	ilg_errors++;
	file_name = strdup (ilgtext+29);
	BEGIN LINE;
}

<LINE>", line = "[0-9]+"):\n   -- " {
	line = atoi (ilgtext+9);
	BEGIN MSG;
}

<MSG>.*$ {
	add_error (file_name, line, 1, ilgtext);
	free (file_name);
	BEGIN INITIAL;
}

.|\n ;

%%

void process_ilg (void)
{
    ilg_name = get_name (".ilg");
    ilgin = fopen (ilg_name , "r");
    if (ilgin == NULL) print_message ("MakeIndex: Emergency stop.\n");
    ilgout = NULL;
    ilglex();
    free (ilg_name);
    if (ilg_errors) {
	err_prog = "MakeIndex";
	window ();
	exit (EXIT_SUCCESS);
    }
}
