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

void process_ilg (void);

void run_makeindex (void)
{
    int pid, ret;
    char *idx_name;

    idx_name = get_name (".idx");
    
    pid = fork ();
    if (pid == -1) print_error ("Unable to fork.\n");
    
    if (pid == 0) {
        close (1);
	close (2);
	if (arg_makeindex)
	    execlp ("makeindex", "makeindex", "-s", arg_makeindex,
		    idx_name, (char *)0);
	else
	    execlp ("makeindex", "makeindex", idx_name, (char *)0);
	print_message ("Makeindex: Emergency stop.\n");
    }

    wait (&ret);

    free (idx_name);

    if (ret) print_message ("Makeindex: Emergency stop.\n");

    process_ilg ();
}
