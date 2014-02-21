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
			text = "<p>This is some text that should appear within the main div.</p>";
			form = <<
			<form id="lab3_form" onsubmit="return false">
				<input type="text" name="firstName" /><br />
				<input type="text" name="lastName" /><br />
				<input type="submit" value="Submit" />
			</form>
			>>;
        }
        every {
            append("#main",text);
			append("#main",form);
			watch("#lab3_form", "submit");
        }
    }
	
	rule respond_submit {
		select when web submit "#lab3_form"
		pre {
			firstname = event:attr("firstName");
			lastname = event:attr("lastName");
		}
		every {
			notify("submit event", firstname + " " + lastname) with sticky = true;
		}
		fired {
			set ent:firstname firstname;
			set ent:lastname lastname;
		}
	}
}