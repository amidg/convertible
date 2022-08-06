#include <stdio.h>
#include <stdlib.h>
#include <gtk/gtk.h>

// gcc $(pkg-config --cflags gtk4) -o convertible main.c $(pkg-config --libs gtk4)

// constants
const int defaultWindowPixelDimension = 1000;
const char applicationName[] = "convertible";

// gui functions
static void main_window(GtkApplication *application, GtkWidget *window, char *appName, int windowSize) {
    // application window
    window = gtk_application_window_new(application);
    gtk_window_set_title(GTK_WINDOW(window), appName);
    gtk_window_set_default_size(GTK_WINDOW(window), windowSize, windowSize);
}

// functions
static void print_demo(GtkWidget *widget, gpointer data) {
    // if (GTK_TOGGLE_BUTTON(widget)->act) {
    //     g_print("ti - pidor\n");
    // }
}

static void activate_application (GtkApplication *app, gpointer user_data) {
    GtkWidget *window;
    GtkWidget *button;

    // draw main window
    window = gtk_application_window_new(app);
    gtk_window_set_title(GTK_WINDOW(window), applicationName);
    gtk_window_set_default_size(GTK_WINDOW(window), defaultWindowPixelDimension, defaultWindowPixelDimension);

    // draw interface
    button = gtk_button_new();
    g_signal_connect(button, "clicked", G_CALLBACK(print_demo), NULL);
    gtk_window_set_child(GTK_WINDOW(window), button);

    gtk_window_present(GTK_WINDOW(window));
}

// main function
int main (int argc, char **argv) {
    // initialize application
    GtkApplication *app;
    int status;

    // start application
    app = gtk_application_new("org.gtk.example", G_APPLICATION_FLAGS_NONE);
    g_signal_connect(app, "activate", G_CALLBACK(activate_application), NULL);

    // application running
    status = g_application_run(G_APPLICATION(app), argc, argv);
    g_object_unref(app);

    return status;
}
