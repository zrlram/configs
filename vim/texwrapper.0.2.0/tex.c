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
#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "options.h"
#include "print.h"

int run_tex (void)
{
    int err, pid, ret;
    struct stat buf;
    
    pid = fork ();
    if (pid == -1) print_error ("Unable to fork.\n");
    
    if (pid == 0) {
	err = creat ("/tmp/texwrapper.err", 0666);
        if (err == -1) print_error ("Unable to creat.\n");
	close (2);
	dup (err);
	close (err);
        close (1);
	execlp (arg_format, arg_format, "--interaction=batchmode",
	 	tex_name, arg_option, (char *)0);
	print_message ("TeX: Unavailable format.\n");
    }

    wait (&ret);
    if (ret == 0) return 0;

    err = stat ("/tmp/texwrapper.err", &buf);
    if (err == -1) print_error ("Unable to stat.\n");
    if (buf.st_size) print_message ("TeX: Emergency stop.\n");

    return ret;
}
