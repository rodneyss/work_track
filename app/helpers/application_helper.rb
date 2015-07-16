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



    def intellinav2
        nav = ''
        if @current_user.present? && @current_user.admin?
            nav += '<li>' + link_to('Show users', users_path) + '</li>'
            nav += '<li>' + link_to('Show spells', spells_path) + '</li>'
            nav += '<li>' + link_to('Show monsters', monsters_path) + '</li>'
            nav += '<li>' + link_to('Show zones', zones_path) + '</li>'
        end

        nav
    end




end

