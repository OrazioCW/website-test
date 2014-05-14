module PageModels
  class AccountMenu < PageModels::BlinkboxbooksSection
    element :sign_out_button, 'a[data-test="menu-sign-out-button"]'
    element :sign_in_button, 'a[data-test="menu-sign-in-button"]'
    element :menu_register_link, '[data-test="menu-register-link"]'
  end

  class Header < PageModels::BlinkboxbooksSection
    element :main_pages_navigation, 'div#main-navigation'
    element :user_account_logo, '#user-menu'
    element :main_menu, '#main-menu'
    element :welcome, '.username'
    element :search_input, '[data-test="search-input"]'
    element :search_button, '[data-test="search-button"]'
    element :suggestions, 'ul#suggestions'

    section :account_menu, AccountMenu, 'ul#user-navigation-handheld'
    element :hamburger_menu, 'ul#main-navigation-handheld'

    def navigate_to_account_option(link_name)
      wait_until_user_account_logo_visible #siteprism method
      user_account_logo.click
      account_menu.should be_visible
      puts account_menu.root_element.inspect
      account_menu.find("a", :text => "#{link_name}").click
    end

    def main_page_navigation(page_name)
      within(main_pages_navigation) do
        click_link page_name
      end
    end

    def navigate_to_hamburger_menu_option(link_name)
      wait_for_main_menu
      main_menu.click
      hamburger_menu.should be_visible
      hamburger_menu.find("a", :text => "#{link_name}").click
    end
  end
end
