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

#include <gtk/gtk.h>

int main (int argc, char *argv[])
{
    GtkWidget *window, *message, *button;

    gtk_init (&argc, &argv);
    if (argc<3) {
	g_error ("Too few arguments.\n");
	return 1;
    }

    window = gtk_dialog_new ();
    gtk_window_set_title (GTK_WINDOW (window), argv[1]);
    gtk_signal_connect (GTK_OBJECT (window), "delete_event",
			(GtkSignalFunc) gtk_main_quit, NULL);
    gtk_signal_connect (GTK_OBJECT (window), "destroy",
			(GtkSignalFunc) gtk_main_quit, NULL);
    gtk_window_set_policy (GTK_WINDOW (window), FALSE, FALSE, FALSE);
    gtk_container_set_border_width (GTK_CONTAINER (GTK_DIALOG (window)->vbox),
				    10);
    message = gtk_label_new (argv[2]);
    gtk_label_set_justify (GTK_LABEL (message), GTK_JUSTIFY_LEFT);
    gtk_box_pack_start_defaults (GTK_BOX (GTK_DIALOG (window)->vbox), message);
    gtk_widget_show (message);

    button = gtk_button_new_with_label ("OK");
    gtk_signal_connect (GTK_OBJECT (button), "clicked",
			(GtkSignalFunc) gtk_main_quit, window);
    gtk_box_pack_start_defaults (GTK_BOX (GTK_DIALOG (window)->action_area),
				 button);
    GTK_WIDGET_SET_FLAGS (button, GTK_CAN_DEFAULT);
    gtk_widget_grab_default (button);
    gtk_widget_show (button);
    gtk_widget_show (window);
    gtk_main ();
    return 0;
}
