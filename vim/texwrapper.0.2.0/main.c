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
#include "options.h"
#include "print.h"
#include "process.h"
#include "files.h"

int main (int argc, char *argv[])
{
    int error;
    char *plg_name;
    
    process_options (argc, argv);

    if (opt_eukleides) {
	run_eukleides ();
	error = run_tex ();
	if (error) {
	    plg_name = get_name (".plg");
	    rename (log_name, plg_name);
	    tex_name = in_name;
	    error = run_tex ();
	    if (error) process_log ();
	    else {
		tex_name = out_name;
		log_name = plg_name;
		process_log ();
	    }
	}
    } else {
	error = run_tex ();
	if (error) process_log ();
    }

    if (opt_makeindex) run_makeindex ();

    if (opt_bibtex) run_bibtex ();

    if (opt_makeindex || opt_bibtex)  {
	error = run_tex ();
	if (error) process_log ();
    }

    if (opt_twice) {
	error = run_tex ();
	if (error) process_log ();
    }

    if (opt_postscript) run_dvips ();

    if (opt_remove) remove_files ();

    if (opt_clean) make_clean ();

    return 0;
}
