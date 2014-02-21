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
			form = <<
			<p>This is some text that should appear within the main div.</p>
			<form id="lab3_form" onsubmit="return false">
				<input type="text" name="firstName" />
				<input type="text" name="lastName" />
				<input type="submit" value="Submit" />
			</form>
			>>;
        }
        every {
            replace_html("#main",form);
			watch("#lab3_form", "submit");
        }
    }
}