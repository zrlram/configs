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

extern int opt_bibtex;
extern int opt_clean;
extern int opt_eukleides;
extern int opt_format;
extern int opt_help;
extern int opt_makeindex;
extern int opt_option;
extern int opt_postscript;
extern int opt_remove;
extern int opt_twice;
extern int opt_window;

extern char *arg_format;
extern char *arg_makeindex;
extern char *arg_option;
extern char *arg_postscript;

extern char *base_name;
extern char *tex_name;
extern char *log_name;
extern char *in_name;
extern char *out_name;
extern char *idx_name;

extern char *err_prog;

void process_options (int argc, char *argv[]);

char* get_name (char *suffix);
