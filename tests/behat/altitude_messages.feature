@theme @theme_altitude @javascript @altitude_message

Feature: Use messaging and contacts features

    @theme @theme_altitude @javascript
    Scenario: Delete messages
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user2"
        And I send "User 2 to User 1 message 1" message to "User 1" user
        And I send "User 2 to User 1 message 2" message in the message area
        And I send "User 2 to User 1 message 3" message in the message area
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "start-delete-messages" "message_area_action"
        And I click on "User 2 to User 1 message 1" "text" in the "messages" "message_area_region"
        And I click on "User 2 to User 1 message 2" "text" in the "messages" "message_area_region"
        And I click on "Delete selected messages" "button"
        # Confirm the interface is immediately updated.
        Then I should see "User 2 to User 1 message 3" in the "messages" "message_area_region"
        And I should not see "User 2 to User 1 message 2" in the "messages" "message_area_region"
        And I should not see "User 2 to User 1 message 1" in the "messages" "message_area_region"
        # Confirm that the changes are persisted.
        And I reload the page
        And I should see "User 2 to User 1 message 3" in the "messages" "message_area_region"
        And I should not see "User 2 to User 1 message 2" in the "messages" "message_area_region"
        And I should not see "User 2 to User 1 message 1" in the "messages" "message_area_region"


    @theme @theme_altitude @javascript
    Scenario: Delete messages
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Design']" "xpath_element"
        And I set the following fields to these values:
            | Theme Color | Red |
        And I click on "Save changes" "button"
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user2"
        And I send "User 2 to User 1 message 1" message to "User 1" user
        And I send "User 2 to User 1 message 2" message in the message area
        And I send "User 2 to User 1 message 3" message in the message area
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "start-delete-messages" "message_area_action"
        And I click on "User 2 to User 1 message 1" "text" in the "messages" "message_area_region"
        And I click on "User 2 to User 1 message 2" "text" in the "messages" "message_area_region"
        And I click on "Delete selected messages" "button"
        # Confirm the interface is immediately updated.
        Then I should see "User 2 to User 1 message 3" in the "messages" "message_area_region"
        And I should not see "User 2 to User 1 message 2" in the "messages" "message_area_region"
        And I should not see "User 2 to User 1 message 1" in the "messages" "message_area_region"
        # Confirm that the changes are persisted.
        And I reload the page
        And I should see "User 2 to User 1 message 3" in the "messages" "message_area_region"
        And I should not see "User 2 to User 1 message 2" in the "messages" "message_area_region"
        And I should not see "User 2 to User 1 message 1" in the "messages" "message_area_region"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_deleteallmessages
    Scenario: Delete all messages
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user2"
        And I send "User 2 to User 1 message 1" message to "User 1" user
        And I send "User 2 to User 1 message 2" message in the message area
        And I send "User 2 to User 1 message 3" message in the message area
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "start-delete-messages" "message_area_action"
        And I click on "Delete all" "button"
        # Confirm dialogue.
        And I click on "Delete" "button"
        # Confirm the changes are persisted.
        And I reload the page
        And I should not see "User 2" in the "conversations" "message_area_region_content"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_deleteallmessages_blue
    Scenario: Delete all messages
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Design']" "xpath_element"
        And I set the following fields to these values:
            | Theme Color | Blue |
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user2"
        And I send "User 2 to User 1 message 1" message to "User 1" user
        And I send "User 2 to User 1 message 2" message in the message area
        And I send "User 2 to User 1 message 3" message in the message area
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "start-delete-messages" "message_area_action"
        And I click on "Delete all" "button"
        # Confirm dialogue.
        And I click on "Delete" "button"
        # Confirm the changes are persisted.
        And I reload the page
        And I should not see "User 2" in the "conversations" "message_area_region_content"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_seecontacts
    Scenario: Add contact shows in contacts tab
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
          | user3    | User      | 3        | user3@example.com    |
        And I log in as "user1"
        And I view the "User 2" contact in the message area
        And I click on "Add contact" "link"
        And I view the "User 3" contact in the message area
        And I click on "Add contact" "link"
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user2"
        And I send "User 2 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user3"
        And I send "User 3 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "contacts-view" "message_area_action"
        Then I should see "User 2" in the "contacts" "message_area_region_content"
        And I should see "User 3" in the "contacts" "message_area_region_content"

        @theme @theme_altitude @altitude_message @javascript @altitude_message_seecontacts_green
    Scenario: Add contact shows in contacts tab
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
          | user3    | User      | 3        | user3@example.com    |
        And I log in as "user1"
        And I view the "User 2" contact in the message area
        And I click on "Add contact" "link"
        And I view the "User 3" contact in the message area
        And I click on "Add contact" "link"
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user2"
        And I send "User 2 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user3"
        And I send "User 3 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Design']" "xpath_element"
        And I set the following fields to these values:
            | Theme Color | Green |
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "contacts-view" "message_area_action"
        Then I should see "User 2" in the "contacts" "message_area_region_content"
        And I should see "User 3" in the "contacts" "message_area_region_content"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_removecontact
    Scenario: Remove contact
        Given the following "users" exist:
              | username | firstname | lastname | email            |
              | user1    | User      | 1        | user1@example.com    |
              | user2    | User      | 2        | user2@example.com    |
              | user3    | User      | 3        | user3@example.com    |
        And I log in as "user1"
        And I view the "User 2" contact in the message area
        And I click on "Add contact" "link"
        And I view the "User 3" contact in the message area
        And I click on "Add contact" "link"
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user2"
        And I send "User 2 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user3"
        And I send "User 3 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I view the "User 3" contact in the message area
        And I click on "Remove contact" "link"
        And I reload the page
        And I click on "contacts-view" "message_area_action"
        Then I should see "User 2" in the "contacts" "message_area_region_content"
        And I should not see "User 3" in the "contacts" "message_area_region_content"

        @theme @theme_altitude @altitude_message @javascript @altitude_message_removecontact_orange
        Scenario: Remove contact with selected color scheme
            Given the following "users" exist:
                  | username | firstname | lastname | email            |
                  | user1    | User      | 1        | user1@example.com    |
                  | user2    | User      | 2        | user2@example.com    |
                  | user3    | User      | 3        | user3@example.com    |
            And I log in as "user1"
            And I view the "User 2" contact in the message area
            And I click on "Add contact" "link"
            And I view the "User 3" contact in the message area
            And I click on "Add contact" "link"
            And I click on ".usermenu a.toggle-display" "css_element"
            And I click on "Log out" "text"
            And I log in as "user2"
            And I send "User 2 to User 1" message to "User 1" user
            And I click on ".usermenu a.toggle-display" "css_element"
            And I click on "Log out" "text"
            And I log in as "user3"
            And I send "User 3 to User 1" message to "User 1" user
            And I click on ".usermenu a.toggle-display" "css_element"
            And I click on "Log out" "text"
            And I log in as "admin"
            And I enable the "Altitude" theme
            And I go to Altitude settings
            And I click on "//a[text()='Design']" "xpath_element"
            And I set the following fields to these values:
                | Theme Color | Blue and Orange |
            And I click on ".usermenu a.toggle-display" "css_element"
            And I click on "Log out" "text"
            When I log in as "user1"
            And I view the "User 3" contact in the message area
            And I click on "Remove contact" "link"
            And I reload the page
            And I click on "contacts-view" "message_area_action"
            Then I should see "User 2" in the "contacts" "message_area_region_content"
            And I should not see "User 3" in the "contacts" "message_area_region_content"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_reply
    Scenario: Reply to a message
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Design']" "xpath_element"
        And I set the following fields to these values:
            | Theme Color | Blue and Orange |
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user2"
        And I send "User 2 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "User 2" "text" in the "conversations" "message_area_region_content"
        And I send "Reply to User 2" message in the message area
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        Then I log in as "user2"
        And I follow "Messages" in the user menu
        And I should see "Reply to User 2" in the "conversations" "message_area_region_content"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_reply
    Scenario: Reply to a message with selected color scheme
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Design']" "xpath_element"
        And I set the following fields to these values:
            | Theme Color | Purple and Gold |
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user2"
        And I send "User 2 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "User 2" "text" in the "conversations" "message_area_region_content"
        And I send "Reply to User 2" message in the message area
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        Then I log in as "user2"
        And I follow "Messages" in the user menu
        And I should see "Reply to User 2" in the "conversations" "message_area_region_content"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_search
    Scenario: Search for messages
        Given the following "users" exist:
                  | username | firstname | lastname | email            |
                  | user1    | User      | 1        | user1@example.com    |
                  | user2    | User      | 2        | user2@example.com    |
                  | user3    | User      | 3        | user3@example.com    |
        And I log in as "user1"
        And I view the "User 2" contact in the message area
        And I click on "Add contact" "link"
        And I view the "User 3" contact in the message area
        And I click on "Add contact" "link"
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user2"
        And I send "User 2 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user3"
        And I send "User 3 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I set the field "searchtext" to "User 2 to User 1"
        Then I should see "User 2" in the "search-results-area" "message_area_region"
        And I should not see "User 3" in the "search-results-area" "message_area_region"

        @theme @theme_altitude @altitude_message @javascript @altitude_message_search
    Scenario: Search for messages with selected color scheme
        Given the following "users" exist:
                  | username | firstname | lastname | email            |
                  | user1    | User      | 1        | user1@example.com    |
                  | user2    | User      | 2        | user2@example.com    |
                  | user3    | User      | 3        | user3@example.com    |
        And I log in as "user1"
        And I view the "User 2" contact in the message area
        And I click on "Add contact" "link"
        And I view the "User 3" contact in the message area
        And I click on "Add contact" "link"
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user2"
        And I send "User 2 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user3"
        And I send "User 3 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Design']" "xpath_element"
        And I set the following fields to these values:
            | Theme Color | Purple and White |
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I set the field "searchtext" to "User 2 to User 1"
        Then I should see "User 2" in the "search-results-area" "message_area_region"
        And I should not see "User 3" in the "search-results-area" "message_area_region"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_none
    Scenario: Search for messages no results
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
          | user3    | User      | 3        | user3@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I set the field "searchtext" to "No message"
        Then I should see "No results" in the "search-results-area" "message_area_region"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_none
    Scenario: Search for messages no results
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
          | user3    | User      | 3        | user3@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Design']" "xpath_element"
        And I set the following fields to these values:
            | Theme Color | Maroon and Gray |
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I set the field "searchtext" to "No message"
        Then I should see "No results" in the "search-results-area" "message_area_region"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_searchsingle
    Scenario: Search for single user
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
          | user3    | User      | 3        | user3@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        # Use default theme.
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "contacts-view" "message_area_action"
        And I set the field "Search for a user or course" to "User 2"
        Then I should see "User 2" in the "search-results-area" "message_area_region"
        And I should not see "User 3" in the "search-results-area" "message_area_region"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_searchsingle
    Scenario: Search for single user with selected color scheme
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
          | user3    | User      | 3        | user3@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Design']" "xpath_element"
        And I set the following fields to these values:
            | Theme Color | Green #2 |
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "contacts-view" "message_area_action"
        And I set the field "Search for a user or course" to "User 2"
        Then I should see "User 2" in the "search-results-area" "message_area_region"
        And I should not see "User 3" in the "search-results-area" "message_area_region"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_searchmultiple
    Scenario: Search for multiple user
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
          | user3    | User      | 3        | user3@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "contacts-view" "message_area_action"
        And I set the field "Search for a user or course" to "User"
        Then I should see "User 2" in the "search-results-area" "message_area_region"
        And I should see "User 3" in the "search-results-area" "message_area_region"
        And I should not see "User 1" in the "search-results-area" "message_area_region"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_searchmultiple
    Scenario: Search for multiple user with selected color scheme
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
          | user3    | User      | 3        | user3@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Design']" "xpath_element"
        And I set the following fields to these values:
            | Theme Color | Green #2 |
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "contacts-view" "message_area_action"
        And I set the field "Search for a user or course" to "User"
        Then I should see "User 2" in the "search-results-area" "message_area_region"
        And I should see "User 3" in the "search-results-area" "message_area_region"
        And I should not see "User 1" in the "search-results-area" "message_area_region"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_searchnone
    Scenario: Search for messages no results
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
          | user3    | User      | 3        | user3@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "contacts-view" "message_area_action"
        And I set the field "Search for a user or course" to "No User"
        Then I should see "No results" in the "search-results-area" "message_area_region"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_searchnone
    Scenario: Search for messages no results
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
          | user3    | User      | 3        | user3@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Design']" "xpath_element"
        And I set the following fields to these values:
            | Theme Color | Blue and Red |
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        When I log in as "user1"
        And I follow "Messages" in the user menu
        And I click on "contacts-view" "message_area_action"
        And I set the field "Search for a user or course" to "No User"
        Then I should see "No results" in the "search-results-area" "message_area_region"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_viewmutliple
    Scenario: View messages from multiple users
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
          | user3    | User      | 3        | user3@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user2"
        And I send "User 2 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user3"
        And I send "User 3 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user1"
        When I follow "Messages" in the user menu
        Then I should see "User 3 to User 1" in the "conversations" "message_area_region_content"
        And I click on "User 2" "text" in the "conversations" "message_area_region_content"
        And I should see "User 2 to User 1" in the "conversations" "message_area_region_content"

    @theme @theme_altitude @altitude_message @javascript @altitude_message_viewmutliple
    Scenario: View messages from multiple users
        Given the following "users" exist:
          | username | firstname | lastname | email            |
          | user1    | User      | 1        | user1@example.com    |
          | user2    | User      | 2        | user2@example.com    |
          | user3    | User      | 3        | user3@example.com    |
        And I log in as "admin"
        And I enable the "Altitude" theme
        And I go to Altitude settings
        And I click on "//a[text()='Design']" "xpath_element"
        And I set the following fields to these values:
            | Theme Color | Blue and Red |
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user2"
        And I send "User 2 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user3"
        And I send "User 3 to User 1" message to "User 1" user
        And I click on ".usermenu a.toggle-display" "css_element"
        And I click on "Log out" "text"
        And I log in as "user1"
        When I follow "Messages" in the user menu
        Then I should see "User 3 to User 1" in the "conversations" "message_area_region_content"
        And I click on "User 2" "text" in the "conversations" "message_area_region_content"
        And I should see "User 2 to User 1" in the "conversations" "message_area_region_content"
