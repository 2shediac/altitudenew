@theme @theme_altitude @javascript
Feature: Testing the timing feature of the front page.

 @theme @theme_altitude @javascript @altitude_pausesetting
    Scenario: Admin user can turn off demo mode, and add pausesetting
        Given I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Front Page']" "xpath_element"
        And I set the following fields to these values:
            | Demo Mode | Off |
        And I wait "2" seconds
        # Pausesettings
        Then "#admin-pausesetting" "css_element" should be visible
