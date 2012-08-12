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
#include <getopt.h>
#include "print.h"

int opt_bibtex = 0;
int opt_clean = 0;
int opt_eukleides = 0;
int opt_format = 0;
int opt_help = 0;
int opt_makeindex = 0;
int opt_option = 0;
int opt_postscript = 0;
int opt_remove = 0;
int opt_twice = 0;
int opt_window = 0;

char *arg_format = NULL;
char *arg_makeindex = NULL;
char *arg_option = NULL;
char *arg_postscript = NULL;

int base_length;
char *base_name;
char *tex_name;
char *log_name;
char *in_name;
char *out_name;

char* err_prog;

char* get_name (char *suffix)
{
    char *name;

    name = (char *)malloc (base_length);
    if (name == NULL) print_error ("Unable to malloc.\n");
    strncpy (name, base_name, base_length - 4);
    strcat (name, suffix);
    return name;
}

void process_base_name (void)
{
    char *start, *stop;
    
    start = rindex (tex_name, '/');
    if (start == NULL) start = tex_name;
    else start++;

    stop = rindex (start, '.');
    if (stop == NULL) base_length = strlen (start) + 5;
    else base_length = (int)(stop - start) + 5;

    base_name = (char *)malloc (base_length);
    if (base_name == NULL) print_error ("Unable to malloc.\n");
    strncpy (base_name, start, base_length - 4);

    if (stop == NULL) tex_name = get_name (".tex");
    else base_name[base_length - 5] = 0;
}

void process_options (int argc, char **argv)
{
    int c, option_index;
    static struct option long_options[] = {
 	{"bibtex", 0, 0, 'b'},
 	{"clean", 0, 0, 'c'},
 	{"eukleides", 0, 0, 'e'},
 	{"format", 1, 0, 'f'},
 	{"help", 0, 0, 'h'},
 	{"latex", 1, 0, 'l'},
 	{"makeindex", 1, 0, 'm'},
 	{"option", 1, 0, 'o'},
 	{"postscript", 1, 0, 'p'},
 	{"remove", 0, 0, 'r'},
 	{"twice", 0, 0, '2'},
 	{"version", 0, 0, 'v'},
 	{"window", 0, 0, 'w'},
 	{0, 0, 0, 0}
    };

    opterr = 0;

    do {
        c = getopt_long (argc, argv, "bcehlmpr2vw",
			 long_options, &option_index);

        switch (c) {

        case 'b':
 	    opt_bibtex = 1;
 	    break;

        case 'c':
	    opt_clean = 1;
 	    break;

        case 'e':
	    opt_eukleides = 1;
 	    break;

        case 'f':
 	    opt_format = 1;
	    arg_format = optarg;
 	    break;

        case 'l':
 	    arg_format = "latex";
	    arg_option= optarg;
 	    break;

        case 'm':
 	    opt_makeindex = 1;
	    arg_makeindex = optarg;
 	    break;

        case 'o':
 	    opt_option = 1;
	    arg_option = optarg;
 	    break;

        case 'p':
 	    opt_postscript = 1;
	    arg_postscript = optarg;
 	    break;

        case 'r':
 	    opt_remove = 1;
 	    break;

        case '2':
 	    opt_twice = 1;
 	    break;

        case 'v':
 	    print_version ();

	case 'w':
	    opt_window = 1;
 	    break;

        case 'h':
	    print_help (EXIT_SUCCESS);

	case '?':
	    print_help (EXIT_FAILURE);
        }
    } while (c != EOF);

    if (optind != argc-1) print_help (EXIT_FAILURE);

    tex_name = argv[optind];
    process_base_name ();
    in_name = tex_name;
    log_name = get_name (".log");

    if (arg_format == NULL) arg_format = "tex";
}
