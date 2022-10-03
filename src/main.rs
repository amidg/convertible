// main 'use' 
use std::str;

// gtk 'use'
use gtk::prelude::*;
use gtk::{Application, Button, ApplicationWindow};

const APPLICATION_ID: &str = "org.gtk_rs.HelloWorld2";
const APPLICATION_NAME: &str = "convertible - easy ffmpeg gui";

fn main() {
    // Create a new application
    let application = Application::new(Some(APPLICATION_ID), Default::default());
    
    // Connect to "activate" signal of `app`
    application.connect_activate(build_ui);

    // Run the application
    application.run();

    
//     let app = Application::builder().application_id(APP_ID).build();  
//     app.connect_activate(build_ui);
//     app.run();
}

fn build_ui(app: &Application) {
    // declare variable
    let mut buttonLabel = "";

    // Create a button with label and margins
    let button = Button::builder()
        .label(buttonLabel)
        .margin_top(12)
        .margin_bottom(12)
        .margin_start(12)
        .margin_end(12)
        .build();    

    // Connect to "clicked" signal of `button`
    button.connect_clicked(move |button| {
        let newLabel = match buttonLabel {
            "Press me!" => "Hello World!",
            _=> "Press me!",
        };

        // Set the label to a new string after the button has been clicked on
        button.set_label(newLabel);
    });

    // Create a window
    let window = ApplicationWindow::builder()
        .application(app)
        .title(APPLICATION_NAME)
        .child(&button)
        .default_height(800)
        .default_width(800)
        .build();

    // Present window
    window.present();
}
