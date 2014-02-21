ruleset b505198x2 {
    meta {
        name "cs462 lab 3"
        author "Mike Curtis"
        logging on
    }
    dispatch {
    }
    
    rule show_form {
        select when pageview ".*"
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
        if(not ent:firstname || not ent:lastname) then {
            append("#main",text);
			append("#main",form);
			watch("#lab3_form", "submit");
        }
		fired{
			last;
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
	
	rule show_name {
		select when pageview ".*"
		pre {
			firstname = ent:firstname;
			lastname = ent:lastname;
		}
		if (ent:firstname && ent:lastname) then {
			notify("Submitted Name", firstname + " " + lastname) with sticky = true;
			replace_inner("#main","<p>#{firstname} #{lastname}</p>");
		}
	}
	
    rule clear_name {
        select when pageview ".*" setting ()
        pre {
            query = page:url("query");
        }
        always {
            clear ent:firstname if query.match(re/clear=1/);
			clear ent:lastname if query.match(re/clear=1/);
        }
    }
}