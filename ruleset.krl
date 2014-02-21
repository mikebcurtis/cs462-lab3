ruleset b505198x2 {
    meta {
        name "cs462 lab 3"
        author "Mike Curtis"
        logging on
    }
    dispatch {
       
    }
    
    rule show_form {
        select when pageview ".*" setting ()
        pre {
        }
        every {
            notify("Hello World", "This is a sample rule.") with sticky = true;
            notify("Another Notify", "Second notification.") with sticky = true;
        }
    }
}