@theme @theme_altitude @javascript

Feature: Basic visibility and navigability tests.
    The user can log in and view the header, footer, and page content with the theme enabled.
    The custommenu, when enabled, is displayed.
    The slideout side bar menu, when enabled, is displayed and functional.
    Admin user can select a color scheme from the color theme select.
    Admin user can update social media icons and links, and changes are displayed correctly.

    @theme @theme_altitude @javascript @altitude_logoutlogin
    Scenario: Admin user can enable the theme, log out, and log in.
        Given the following "users" exist:
            | username | firstname | lastname | email |
            | student | Student | User | student@behat.com |
        And the following "courses" exist:
            | fullname | shortname | category |
            | Course 1 | C1 | 0 |
        And the following "course enrolments" exist:
            | user | course | role |
            | student | C1 | student |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I am on site homepage
        And I click on ".usermenu a.toggle-display" "css_element"
        And I wait "3" seconds
        And I click on "Log out" "text"
        And I log in as "student"
        And I am on homepage
        Then The "header" css element should be visible
        And The "#logo a img" css element should be visible
        And The "#page-footer" css element should be visible
        And The "#page-footer2" css element should be visible
        And The ".block_navigation" css element should be visible
        And The "#region-main" css element should be visible
        And I am on "Course 1" course homepage
        Then The "header" css element should be visible
        And The "#logo a img" css element should be visible
        And The "#page-footer" css element should be visible
        And The "#page-footer2" css element should be visible
        And The ".block_navigation" css element should be visible
        And The "#region-main" css element should be visible

    @theme @theme_altitude @javascript @altitude_custommenu
    Scenario: Admin user enables custommenu, and custommenu is displayed.
        Given the following "users" exist:
            | username | firstname | lastname | email |
            | student | Student | User | student@behat.com |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I am on site homepage
        And I go to theme settings
        And I set the field "Custom menu items" to multiline:
            """
            Moodle community|https://moodle.org
            -Moodle free support|https://moodle.org/support
            -###
            -Moodle development|https://moodle.org/development
            --Moodle Docs|http://docs.moodle.org|Moodle Docs
            --German Moodle Docs|http://docs.moodle.org/de|Documentation in German|de
            #####
            Moodle.com|http://moodle.com/
            """
        And I click on "Save changes" "button"
        And I am on site homepage
        Then "Moodle community" "link" in the ".menus ul.nav" "css_element" should be visible
        And I am on site homepage
        And I click on ".usermenu a.toggle-display" "css_element"
        And I wait "3" seconds
        And I click on "Log out" "text"
        And I log in as "student"
        And I am on site homepage
        Then "Moodle community" "link" in the ".menus ul.nav" "css_element" should be visible


    @theme @theme_altitude @javascript @altitude_socialmedia
    Scenario: Admin user can update social media icons and links, and changes are displayed correctly.
        Given I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Design']" "xpath_element"
        And I set the field "Social Media Icons" to multiline:
            """
            facebook|https://facebook.com
            twitter|https://twitter.com
            google|https://google.com
            """
        And I click on "Save changes" "button"
        When I am on site homepage
        Then ".fa.fa-facebook" "css_element" in the ".social-links" "css_element" should be visible
        And ".fa.fa-twitter" "css_element" in the ".social-links" "css_element" should be visible
        And ".fa.fa-google" "css_element" in the ".social-links" "css_element" should be visible
        And The "header" css element should be visible
        And The "#logo a img" css element should be visible
        And The "#page-footer" css element should be visible
        And The "#page-footer2" css element should be visible
        And The ".block_navigation" css element should be visible
        And The "#region-main" css element should be visible

    @theme @theme_altitude @javascript @altitude_messagesnotifications
    Scenario: User can view notifications and messages popover.
        Given the following "users" exist:
            | username | firstname | lastname | email |
            | student | Student | User | student@behat.com |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I am on site homepage
        Then ".popover-region-notifications .popover-region-toggle" "css_element" in the ".navbar" "css_element" should be visible
        And ".popover-region-messages .popover-region-toggle" "css_element" in the ".navbar" "css_element" should be visible
        And I click on ".popover-region-notifications .popover-region-toggle" "css_element"
        Then ".navbar .popover-region-notifications .popover-region-container" "css_element" should be visible
        And I click on ".popover-region-messages .popover-region-toggle" "css_element"
        Then ".navbar .popover-region-messages .popover-region-container" "css_element" should be visible
        And I send "Admin User to Student User ==> Message 1" message to "Student User" user
        And I send "Admin User to Student User ==> Message 2" message to "Student User" user
        And I send "Admin User to Student User ==> Message 2" message to "Student User" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "student"
        And I am on site homepage
        Then ".popover-region-notifications .popover-region-toggle" "css_element" in the ".navbar" "css_element" should be visible
        And ".popover-region-messages .popover-region-toggle" "css_element" in the ".navbar" "css_element" should be visible
        And ".navbar .popover-region-messages .count-container" "css_element" should be visible
        And I click on ".popover-region-notifications .popover-region-toggle" "css_element"
        Then ".navbar .popover-region-notifications .popover-region-container" "css_element" should be visible

    @theme @theme_altitude @javascript @altitude_colorselector
    Scenario: Admin user can use theme color selector when Altitude theme is active.
        Given I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Design']" "xpath_element"
        And I set the following fields to these values:
            | Theme Color | Black and Yellow |
        Then The element "#admin-themecolor" should have the class "blackyellow-theme"

    @theme @theme_altitude @javascript @altitude_demooff
    Scenario: Admin user can turn off demo mode, and add slideshow images or video.
        Given I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Front Page']" "xpath_element"
        And I set the following fields to these values:
            | Demo Mode | Off |
        And I wait "2" seconds
        # Slider image 1 fields.
        Then "#admin-sliderimage1" "css_element" should be visible
        Then "#admin-sliderheader1" "css_element" should be visible
        Then "#admin-slidertext1" "css_element" should be visible
        Then "#admin-sliderbuttonlink1" "css_element" should be visible
        Then "#admin-sliderbuttonlabel1" "css_element" should be visible
        # Slider image 2 fields.
        Then "#admin-sliderimage2" "css_element" should be visible
        Then "#admin-sliderheader2" "css_element" should be visible
        Then "#admin-slidertext2" "css_element" should be visible
        Then "#admin-sliderbuttonlink2" "css_element" should be visible
        Then "#admin-sliderbuttonlabel2" "css_element" should be visible
        # Slider image 3 fields.
        Then "#admin-sliderimage3" "css_element" should be visible
        Then "#admin-sliderheader3" "css_element" should be visible
        Then "#admin-slidertext3" "css_element" should be visible
        Then "#admin-sliderbuttonlink3" "css_element" should be visible
        Then "#admin-sliderbuttonlabel3" "css_element" should be visible
        # Slider image 4 fields.
        Then "#admin-sliderimage4" "css_element" should be visible
        Then "#admin-sliderheader4" "css_element" should be visible
        Then "#admin-slidertext4" "css_element" should be visible
        Then "#admin-sliderbuttonlink4" "css_element" should be visible
        Then "#admin-sliderbuttonlabel4" "css_element" should be visible
        # Video fields.
        Then "#admin-videobackgroundmp4" "css_element" should be visible
        Then "#admin-videobackgroundwebm" "css_element" should be visible
        Then "#admin-videobackgroundogg" "css_element" should be visible
        Then "#admin-videoimage" "css_element" should be visible
        Then "#admin-videoheader" "css_element" should be visible
        Then "#admin-videotext" "css_element" should be visible
        # Block section 1 fields.
        Then "#admin-subsectiontitle1" "css_element" should be visible
        Then "#admin-subsectionicon1" "css_element" should be visible
        Then "#admin-subsectiondescription1" "css_element" should be visible
        Then "#admin-subsectionlink1" "css_element" should be visible
        Then "#admin-subsectionlabel1" "css_element" should be visible
        # Block section 2 fields.
        Then "#admin-subsectiontitle2" "css_element" should be visible
        Then "#admin-subsectionicon2" "css_element" should be visible
        Then "#admin-subsectiondescription2" "css_element" should be visible
        Then "#admin-subsectionlink2" "css_element" should be visible
        Then "#admin-subsectionlabel2" "css_element" should be visible
        # Block section 3 fields.
        Then "#admin-subsectiontitle3" "css_element" should be visible
        Then "#admin-subsectionicon3" "css_element" should be visible
        Then "#admin-subsectiondescription3" "css_element" should be visible
        Then "#admin-subsectionlink3" "css_element" should be visible
        Then "#admin-subsectionlabel3" "css_element" should be visible

    @theme @theme_altitude @javascript @altitude_banner @javascript @_file_upload
    Scenario: Admin user can turn of demo mode and add custom slider images and text.
        Given I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Front Page']" "xpath_element"
        And I set the following fields to these values:
            | Demo Mode | Off |
        And I wait "2" seconds
        And I change viewport size to "3560x3560"
        And I set the following fields to these values:
            | Banner 1 Header | Banner 1 Header str |
            | Banner 1 Text | Banner 1 Text str |
            | Banner 1 Button Link | Banner 1 Button Link str |
            | Banner 1 Button Label | Banner 1 Button Label str |
        And I upload the file "theme/altitude/tests/fixtures/test-slide1.jpg" to the field "Banner 1 Image"
        And I click on "Save changes" "button"
        And I am on site homepage
        And I wait "5" seconds
        # Slide 1 elements exist.
        Then "#slider .slide1 img" "css_element" should be visible
        And "#slider .slide1 #banner-title h1" "css_element" should be visible
        And "#slider .slide1 #banner-title p" "css_element" should be visible
        And "#slider .slide1 #banner-title a" "css_element" should be visible

    @theme @theme_altitude @altitude_customcss @javascript @_file_upload
    Scenario: Admin user can upload a custom css file to field and css is applied to site.
        Given I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Advanced']" "xpath_element"
        And I upload the file "theme/altitude/tests/fixtures/custom-css.css" to the field "Custom CSS File"
        And I click on "Save changes" "button"
        And I am on site homepage
        Then "header.navbar" "css_element" should not be visible

    @theme @theme_altitude @altitude_helpdoclink @javascript
    Scenario: Admin user can hide help doc link by removing docroot setting. Admin user can show help doc link by adding docroot setting.
        Given the following "courses" exist:
            | fullname | shortname | category |
            | Course 1 | C1 | 0 |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I navigate to "Moodle Docs" node in "Site administration > Appearance"
        And I set the following fields to these values:
            | Moodle Docs document root | |
        And I click on "Save changes" "button"
        Then ".footer-content .helplink" "css_element" should not be visible
        And I am on site homepage
        Then ".footer-content .helplink" "css_element" should not be visible
        And I am on "Course 1" course homepage
        Then ".footer-content .helplink" "css_element" should not be visible
        And I navigate to "Moodle Docs" node in "Site administration > Appearance"
        And I set the following fields to these values:
            | Moodle Docs document root | http://docs.moodle.org |
        And I click on "Save changes" "button"
        Then ".footer-content .helplink" "css_element" should be visible
        And I am on site homepage
        And I am on "Course 1" course homepage
        Then ".footer-content .helplink" "css_element" should be visible

    @theme @theme_altitude @altitude_showmycourses @javascript
    Scenario: Admin user can enable and disable display of mycourses menu item.
        Given I log in as "admin"
        And I enable the "Altitude" theme
        And I am on homepage
        Then "//div[contains(@class, 'menus')]/ul/li/a[text()='My courses']" "xpath_element" should not exist
        And I navigate to "Altitude" node in "Site administration > Appearance >Themes"
        And I click on "User Interface" "link"
        And I set the following fields to these values:
            | My Courses Menu | 1 |
        And I click on "Save changes" "button"
        And I am on homepage
        Then "//div[contains(@class, 'menus')]/ul/li/a[text()='My courses']" "xpath_element" should be visible
        And I navigate to "Altitude" node in "Site administration > Appearance >Themes"
        And I click on "User Interface" "link"
        And I set the following fields to these values:
            | My Courses Menu | 0 |
        And I click on "Save changes" "button"
        And I am on homepage
        Then "//div[contains(@class, 'menus')]/ul/li/a[text()='My courses']" "xpath_element" should not exist

    @theme @theme_altitude @altitude_switchcustommenu @javascript
    Scenario: Display of custommenu switches between header and slideout panel depending on screen size.
        Given I log in as "admin"
        And I enable the "Altitude" theme
        And I go to theme settings
        And I set the field "Custom menu items" to multiline:
            """
            Moodle community|https://moodle.org
            -Moodle free support|https://moodle.org/support
            -###
            -Moodle development|https://moodle.org/development
            --Moodle Docs|http://docs.moodle.org|Moodle Docs
            --German Moodle Docs|http://docs.moodle.org/de|Documentation in German|de
            #####
            Moodle.com|http://moodle.com/
            Moodle.com|http://moodle.com/
            Moodle.com|http://moodle.com/
            """
        And I click on "Save changes" "button"
        And I go to Altitude settings
        And I click on "//a[text()='User Interface']" "xpath_element"
        And I set the following fields to these values:
            | Slideout Block Panel Alignment | Right |
        And I click on "Save changes" "button"
        And I am on site homepage
        # Larger viewport, header custommenu displayed.
        And I change viewport size to "1280x3560"
        Then I forgivingly check visibility of "header ul.altitude-custom-menu" "css"
        And "#side-panel-button" "css_element" should not be visible
        # And I navigate to "Turn editing on" node in "Site administration"
        And I click on "Turn editing on" "link_or_button"
        Then I forgivingly check visibility of "#side-panel-button" "css"
        Then I click on "#side-panel-button" "css_element"
        And ".altitude-menu-sidebar ul.altitude-custom-menu" "css_element" should not be visible
        Then I click on "#side-panel-button" "css_element"
        And I click on "Turn editing off" "link_or_button"
        # Smaller viewport, slideout custommenu displayed.
        And I change viewport size to "990x3560"
        And I wait "5" seconds
        Then "header ul.altitude-custom-menu" "css_element" should not be visible
        And I forgivingly check visibility of ".altitude-menu-sidebar ul.altitude-custom-menu" "css"
        # No slideout custommenu, but slideout blocks, menu btn displayed.
        And I change viewport size to "1280x3560"
        And I click on "Turn editing on" "link_or_button"
        And I click on "#side-panel-button" "css_element"
        And I drag "block_navigation" "block" and I drop it in "aside#block-region-sidebar-block" "css_element"
        And I click on "#side-panel-button" "css_element"
        And I click on "Turn editing off" "link_or_button"
        Then I forgivingly check visibility of "#side-panel-button" "css"
        And I go to Altitude settings
        And I click on "//a[text()='User Interface']" "xpath_element"
        And I set the following fields to these values:
            | Slideout Block Panel Alignment | Left |
        And I click on "Save changes" "button"
        And I am on site homepage
        # Larger viewport, header custommenu displayed.
        And I change viewport size to "1280x3560"
        Then I forgivingly check visibility of "header ul.altitude-custom-menu" "css"
        And "#side-panel-button" "css_element" should not be visible
        And I click on "Turn editing on" "link_or_button"
        Then I forgivingly check visibility of "#side-panel-button" "css"
        Then I click on "#side-panel-button" "css_element"
        And ".altitude-menu-sidebar ul.altitude-custom-menu" "css_element" should not be visible
        Then I click on "#side-panel-button" "css_element"
        And I click on "Turn editing off" "link_or_button"
        # Smaller viewport, slideout custommenu displayed.
        And I change viewport size to "990x3560"
        Then "header ul.altitude-custom-menu" "css_element" should not be visible
        And I forgivingly check visibility of ".altitude-menu-sidebar ul.altitude-custom-menu" "css"
        # No slideout custommenu, but slideout blocks, menu btn displayed.
        And I change viewport size to "1280x3560"
        And I click on "Turn editing on" "link_or_button"
        And I click on "#side-panel-button" "css_element"
        And I drag "block_navigation" "block" and I drop it in "aside#block-region-sidebar-block" "css_element"
        Then I click on "#side-panel-button" "css_element"
        And I click on "Turn editing off" "link_or_button"
        Then I forgivingly check visibility of "#side-panel-button" "css"

    @theme @theme_altitude @altitude_slideoutmenu @javascript
    Scenario: Slideout sidebar menu button displays as needed and block region appears when button is clicked.
        Given I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='User Interface']" "xpath_element"
        And I set the following fields to these values:
            | Slideout Block Panel Alignment | Right |
        And I click on "Save changes" "button"
        And I am on site homepage
        Then I forgivingly check visibility of ".sb-toggle-right" "css"
        And I click on "Turn editing on" "link_or_button"
        And I scroll to x "0" y "0" coordinates
        Then I click on ".sb-toggle-right" "css_element"
        Then I forgivingly check visibility of "#block-region-sidebar-block" "css"
        And I go to Altitude settings
        And I click on "//a[text()='User Interface']" "xpath_element"
        And I set the following fields to these values:
            | Slideout Block Panel Alignment | Left |
        And I click on "Save changes" "button"
        And I am on site homepage
        Then I forgivingly check visibility of ".sb-toggle-left" "css"
        Then I click on ".sb-toggle-left" "css_element"
        Then I forgivingly check visibility of "#block-region-sidebar-block" "css"
