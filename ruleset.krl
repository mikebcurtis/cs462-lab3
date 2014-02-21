ruleset b505198x2 {
    meta {
        name "cs462 lab 2"
        author "mike curtis"
        logging off
    }
    dispatch {
       
    }
    
    rule simple_notifications {
        select when pageview ".*" setting ()
        pre {
        }
        every {
            notify("Hello World", "This is a sample rule.") with sticky = true;
            notify("Another Notify", "Second notification.") with sticky = true;
        }
    }
    
    rule query_notification {
        select when pageview ".*" setting ()
        pre {
            get_name = function(query) {
                res_arr = query.extract(re/&\\?name=(\w+)/g)
                res_arr[0]
            };
            name = get_name(page:url("query"))
        }
        every {
            notify("Third Notify", name eq "" => "Hello Monkey" |
"Hello " + name) with sticky = true;
        }
    }

    rule clear_count {
        select when pageview ".*" setting ()
        pre {
            query = page:url("query");
        }
        always {
            clear ent:count if query.match(re/clear/)
        }
    }

    rule counting_notification {
        select when pageview ".*" setting ()
        pre {
            count = ent:count + 1;
        }
        if count <= 5 then
            notify("Fired count", count) with sticky = true;
        fired {
            ent:count += 1 from 1;
        }
    }
}