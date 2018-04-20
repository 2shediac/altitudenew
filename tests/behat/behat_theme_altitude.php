<?php

require_once(__DIR__.'/../../../../lib/behat/behat_base.php');
require_once(__DIR__.'/../../../../lib/behat/behat_files.php');
require_once(__DIR__.'/../../../../auth/tests/behat/behat_auth.php');
require_once(__DIR__.'/../../../../message/tests/behat/behat_message.php');

use Behat\Behat\Context\SnippetAcceptingContext,
    Behat\Mink\Exception\ExpectationException as ExpectationException,
    Behat\Gherkin\Node\TableNode as TableNode;

class behat_theme_altitude extends behat_files implements SnippetAcceptingContext {

    /**
     * @override Given /^I forgivingly check visibility of "([^"]*)" "([^"]*)"$/
     *
     */
    public function i_forgivingly_check_visibility_of($selector, $findtype) {
        $session = $this->getSession();
        $page = $session->getPage();
        $el = $page->find($findtype, $selector);
        if (!!$el) {
            // Credit for original version of this iterative checking, to counteract
            // failures on elements created by JavaScript, goes to Charles Verge.
            // See commit 0827ce234 in moodle-local_datahub.git.
            $count = 10;
            while ($count > 0) {
                try {
                    $el->isVisible();
                    $count = -10;
                    return true;
                } catch (\Exception $e) {
                    $count--;
                    $this->getSession()->wait(self::TIMEOUT * 1000, self::PAGE_READY_JS);
                }
            }
        }
    }

    /**
     * @override Given /^I forgivingly click on "([^"]*)" "([^"]*)"$/
     *
     */
    public function i_forgivingly_click_on($selector, $findtype) {
        $session = $this->getSession();
        $page = $session->getPage();
        $el = $page->find($findtype, $selector);
        if (!!$el) {
            // Credit for original version of this iterative clicking, to counteract
            // failures on elements created by JavaScript, goes to Charles Verge.
            // See commit 0827ce234 in moodle-local_datahub.git.
            $count = 10;
            while ($count > 0) {
                try {
                    $el->click();
                    $count = -10;
                } catch (\Exception $e) {
                    $count--;
                    $this->getSession()->wait(self::TIMEOUT * 1000, self::PAGE_READY_JS);
                }
            }
        }
    }

    /**
     * Opens altitude settings.
     *
     * @Given /^I go to Altitude settings$/
     */
    public function i_go_to_altitude_settings() {
        $this->getSession()->visit($this->locate_path('/admin/settings.php?section=themesettingaltitude'));
    }

    /**
     * Enable the altitude theme if it's not enabled already.
     *
     * @Given /^I enable the "(?P<themename_string>(?:[^"]|\\")*)" theme$/
     */
    public function i_enable_altitude_theme($themename) {
        $this->getSession()->visit($this->locate_path('/theme/index.php'));

        $session = $this->getSession();
        $page = $session->getPage();
        $activetheme = $page->find('css', 'table tbody tr:first-of-type td.lastcol h3');
        $activethemename = $activetheme->getText();

        if ($activethemename !== $themename) {
            $submitbtn = $page->find('css', '#admindeviceselector tr:first-of-type input[type=submit]');
            $submitbtn->click();
            $session->wait(10000);

            $xpath = '//h3[text()="'.$themename.'"]/../div/form/button[@type="submit"]';
            $setaltitudebtn = $page->find('xpath', $xpath);
            if (!$setaltitudebtn) {
                throw new \InvalidArgumentException(sprintf('Could not find the button.'));
            }
            $setaltitudebtn->click();
        }
    }

    /**
     * Navigate to theme settings.
     *
     * @Given /^I go to theme settings$/
     */
    public function i_go_to_theme_settings() {
        $this->getSession()->visit($this->locate_path('/admin/settings.php?section=themesettings'));
    }

    /**
     * Tests whether a css-selected element has the given class.
     *
     * @Given /^The element "(?P<selector>(?:[^"]|\\")*)" should have the class "(?P<class>(?:[^"]|\\")*)"$/
     */
    public function item_has_class($selector, $class) {
        $session = $this->getSession();
        $page = $session->getPage();
        $session->wait(5000);
        $element = $page->find('css', $selector);
        if (!$element) {
            $message = sprintf('Could not find element using the selector "%s"', $selector);
            throw new \Exception($message);
        }
        $hasclass = $element->hasClass($class);
        if (!$hasclass) {
            $message = sprintf('Class "%1" not found for selector "%1"', $class, $selector);
            throw new \Exception($message);
        }
    }

    /**
     * Checks for visibility of a given css element
     *
     * @Given /^The "(?P<selector>(?:[^"]|\\")*)" css element should be visible$/
     */
    public function is_css_element_visible($selector) {
        $session = $this->getSession();
        $page = $session->getPage();
        $element = $page->find('css', $selector);
        if (!$element) {
            $message = sprintf('Could not find element using the selector "%s"', $selector);
            throw new \Exception($message);
        }
        $isvisible = $element->isVisible();
        return $isvisible;
    }


    /**
     * Uploads a file to the specified filemanager leaving other fields in upload form default.
     * The paths should be relative to moodle codebase.
     *
     * @When /^I upload the file "(?P<filepath_string>(?:[^"]|\\")*)" to the field "(?P<filemanager_field_string>(?:[^"]|\\")*)"$/
     * @throws ExpectationException Thrown by behat_base::find
     * @param string $filepath
     * @param string $filemanagerelement
     */
    public function i_upload_the_file_to_field($filepath, $filemanagerelement) {
        $this->upload_file_to_field($filepath, $filemanagerelement, new TableNode(array()), false);
    }

    /**
     * Uploads a file to filemanager
     *
     * @throws ExpectationException Thrown by behat_base::find
     * @param string $filepath Normally a path relative to $CFG->dirroot, but can be an absolute path too.
     * @param string $filemanagerelement
     * @param TableNode $data Data to fill in upload form
     * @param false|string $overwriteaction false if we don't expect that file with the same name already exists,
     *     or button text in overwrite dialogue ("Overwrite", "Rename to ...", "Cancel")
     */
    protected function upload_file_to_field($filepath, $filemanagerelement, TableNode $data, $overwriteaction = false) {
        global $CFG;

        $session = $this->getSession();
        $page = $session->getPage();

        $labelexception = 'Label '.$filemanagerelement.' not found.';
        $label = $page->find('xpath', '//label[text()[contains(.,"'.$filemanagerelement.'")]]', $labelexception);
        $settingid = $label->getAttribute('for');
        $settingspec = str_replace('id_s_theme_altitude_', '', $settingid);
        $filemanagernode = $page->find('xpath', '//input[@name="'.$settingid.'"]', $labelexception);
        $button = $page->find('css', '#admin-'.$settingspec.' div.fp-btn-add');
        $button->mouseOver();

        // Opening the select repository window and selecting the upload repository.
        $this->open_add_file_window($filemanagernode, get_string('pluginname', 'repository_upload'));

        // Ensure all the form is ready.
        $noformexception = new ExpectationException('The upload file form is not ready', $this->getSession());
        $this->find(
            'xpath',
            "//div[contains(concat(' ', normalize-space(@class), ' '), ' file-picker ')]".
                "[contains(concat(' ', normalize-space(@class), ' '), ' repository_upload ')]".
                "/descendant::div[@class='fp-content']".
                "/descendant::div[contains(concat(' ', normalize-space(@class), ' '), ' fp-upload-form ')]".
                "/descendant::form",
            $noformexception
        );
        // After this we have the elements we want to interact with.

        // Form elements to interact with.
        $file = $this->find_file('repo_upload_file');

        // Attaching specified file to the node.
        // Replace 'admin/' if it is in start of path with $CFG->admin .
        if (substr($filepath, 0, 6) === 'admin/') {
            $filepath = $CFG->dirroot.DIRECTORY_SEPARATOR.$CFG->admin.
                    DIRECTORY_SEPARATOR.substr($filepath, 6);
        }
        $filepath = str_replace('/', DIRECTORY_SEPARATOR, $filepath);
        if (!is_readable($filepath)) {
            $filepath = $CFG->dirroot.DIRECTORY_SEPARATOR.$filepath;
            if (!is_readable($filepath)) {
                throw new ExpectationException('The file to be uploaded does not exist.', $this->getSession());
            }
        }
        $file->attachFile($filepath);

        // Fill the form in Upload window.
        $datahash = $data->getRowsHash();

        // The action depends on the field type.
        foreach ($datahash as $locator => $value) {

            $field = behat_field_manager::get_form_field_from_label($locator, $this);

            // Delegates to the field class.
            $field->set_value($value);
        }

        // Submit the file.
        $submit = $this->find_button(get_string('upload', 'repository'));
        $submit->press();

        // We wait for all the JS to finish as it is performing an action.
        $this->getSession()->wait(self::TIMEOUT, self::PAGE_READY_JS);

        if ($overwriteaction !== false) {
            $overwritebutton = $this->find_button($overwriteaction);
            $this->ensure_node_is_visible($overwritebutton);
            $overwritebutton->click();

            // We wait for all the JS to finish.
            $this->getSession()->wait(self::TIMEOUT, self::PAGE_READY_JS);
        }
    }

    /**
     * @Given /^I scroll to x "([^"]*)" y "([^"]*)" coordinates$/
     *
     * @param String $arg1 X coordinate, passed as string.
     * @param String $arg2 Y coordinate, passed as string.
     * @throws \Exception Throws exception if scroll operation fails.
     */
    public function i_scroll_to_xy_coordinates($arg1, $arg2) {
        try {
            $this->getSession()->executeScript("(function(){window.scrollTo($arg1, $arg2);})();");
        } catch (Exception $e) {
            throw new \Exception("ScrollIntoView failed");
        }
    }

    /**
     * Given /^I scroll until "(?P<selector>(?:[^"]|\\")*)" css element is visible$/
     */
    public function i_scroll_until_element_visible($arg1) {
        $element = $page->find('css', $arg1);
        $offsetY = 0;
        if (!$element) {
            $message = sprintf('Could not find element using the selector "%s"', $selector);
            throw new \Exception($message);
        } else {
            if (!$element->isVisible()) {
                $offsetY = $element.offsetTop + ($element.offsetParent ? $element.offsetParent.documentOffsetTop : 0);
                try {
                    $this->getSession()->executeScript("(function(){window.scrollTo(0, $offsetY);})();");
                } catch (Exception $e) {
                    throw new \Exception("Failed to scroll to designated css element.");
                }
            }
        }
    }
}
