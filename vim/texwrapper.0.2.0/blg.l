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

char *msg;
int line;

int blgwrap(void)
{
  return 1;
}

%}

%s LINE FILENAME ENTRY

%%

.+"---line " {
	msg = strdup (blgtext);
	msg[blgleng-8] = 0;
	BEGIN LINE;
}

<LINE>[0-9]+" of file " {
	line = atoi (blgtext);
	BEGIN FILENAME;
}

<FILENAME>.*$ {
	add_error (blgtext, line, 1, msg);
	free (msg);
	BEGIN INITIAL;
}

.+"---entry " {
	msg = strdup (blgtext);
	msg[blgleng-9] = 0;
	BEGIN ENTRY;
}

<ENTRY>.*$ {
	add_entry_error (blgtext, msg);
	free (msg);
	BEGIN INITIAL;
}

.|\n ;

%%
