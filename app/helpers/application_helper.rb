module ApplicationHelper



    def intellinav
    nav = ''

        if @current_user.present?
            nav += '<li>' + link_to("Home", root_path) + '</li>'
            nav += '<li>' + link_to("Profile", @current_user) + '</li>'
            nav += '<li>' + link_to("Logout", login_path, :method => :delete) + '</li>'

        end

    nav


    end



end

