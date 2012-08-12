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
#include "files.h"

void run_dvips ()
{
    int err, pid, ret;
    char *err_buffer;
    
    pid = fork ();
    if (pid == -1) print_error ("Unable to fork.\n");
    
    if (pid == 0) {
	err = creat ("/tmp/texwrapper.err", 0666);
        if (err == -1) print_error ("Unable to creat.\n");
	close (2);
	dup (err);
	close (err);
        close (1);
	execlp ("dvips", "dvips", "-q", "-f", get_name (".dvi"),
		"-o", get_name (".ps"), arg_postscript, (char *)0);
	print_message ("Dvips: Emergency stop.\n");
    }

    wait (&ret);

    if (ret == 0) return;

    err_buffer = read_file ("/tmp/texwrapper.err");
    err_buffer = index (err_buffer, '!')+1;
    print_message (err_buffer);
}
