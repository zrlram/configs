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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "options.h"
#include "print.h"

extern FILE *blgin, *blgout;

int blglex (void);

void run_bibtex (void)
{
    int blg, pid, ret;
    char *blg_name;
    
    pid = fork ();
    if (pid == -1) print_error ("Unable to fork.\n");
    
    blg_name = get_name (".blg");

    if (pid == 0) {
	close (2);
	blg = creat (blg_name, 0666);
        if (blg == -1) print_error ("Unable to creat.\n");
        close (1);
	dup (blg);
	close (blg);
	execlp ("bibtex", "bibtex", base_name, (char *)0);
	print_message ("BibTeX: Emergency stop.\n");
    }

    wait (&ret);

    if (ret == 0) return;

    err_prog = "BibTeX";
    blgin = fopen (blg_name , "r");
    if (blgin == NULL) print_message ("BibTeX: Emergency stop.\n");
    blgout = NULL;
    blglex();
    free (blg_name);
    window ();
    exit (EXIT_FAILURE);
}
