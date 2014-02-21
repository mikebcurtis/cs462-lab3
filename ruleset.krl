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
			text = "<p>This is some text that should appear within the main div.</p>"
        }
        every {
            replace_html("#main",text)
        }
    }
}