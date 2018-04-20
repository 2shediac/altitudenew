<?php
// This file is part of Moodle - http://moodle.org/
//
// Moodle is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Moodle is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Moodle.  If not, see <http://www.gnu.org/licenses/>.

/**
 * Renderer overrides for component 'theme_altitude'
 *
 * @package   theme-altitude
 * @author    Eric Bjella <eric.bjella@remote-learner.net>
 * @copyright 2016 Remote Learner  http://www.remote-learner.net/
 * @license   http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

class theme_altitude_core_renderer extends theme_bootstrapbase_core_renderer {

    /*
     * This overrides the renderer for the bootstrapbase top menu.
     *
     * Augments the attributes assigned to the custommmenu wrapper in the bootstrapbase renderer.
     *
     * @param custom_menu custom_menu Custom menu contents.
     * @return String            Markup for custom menu.
     */
    protected function alter_custom_menu(custom_menu $menu) {
        global $CFG;

        $langs = get_string_manager()->get_list_of_translations();
        $haslangmenu = $this->lang_menu() != '';

        if (!$menu->has_children() && !$haslangmenu) {
            return '';
        }

        if ($haslangmenu) {
            $strlang =  get_string('language');
            $currentlang = current_language();
            if (isset($langs[$currentlang])) {
                $currentlang = $langs[$currentlang];
            } else {
                $currentlang = $strlang;
            }
            $this->language = $menu->add($currentlang, new moodle_url('#'), $strlang, 10000);
            foreach ($langs as $langtype => $langname) {
                $this->language->add($langname, new moodle_url($this->page->url, array('lang' => $langtype)), $langname);
            }
        }

        $content = '<ul class="nav altitude-custom-menu vis-hidden">';
        foreach ($menu->get_children() as $item) {
            $content .= parent::render_custom_menu_item($item, 1);
        }

        return $content.'</ul>';
    }

    /**
     * Render custom menu for layouts.
     * @param  custom_menu $menu Default menu rendered by Moodle.
     * @return String            Markup for custom menu.
     */
    protected function render_custom_menu(custom_menu $menu) {
        global $PAGE, $CFG;
        if (isloggedin()) {
            if (!empty($PAGE->theme->settings->mycourses) && $PAGE->theme->settings->mycourses == true) {
                $branch = $menu->add(get_string('mycourses'), null, null, 9900);
                if (!isset($PAGE->theme->settings->mycoursessort) || $PAGE->theme->settings->mycoursessort == '') {
                    $sort = 'fullnameasc';
                } else {
                    $sort = $PAGE->theme->settings->mycoursessort;
                }

                // Assume fullnameasc, reset if otherwise.
                $courses = enrol_get_my_courses(null, 'visible DESC,fullname ASC');
                if ($sort == 'startdatedesc') {
                    $courses = enrol_get_my_courses(null, 'visible DESC,startdate DESC');
                } else if ($sort == 'idnumberasc') {
                    $courses = enrol_get_my_courses(null, 'visible DESC,idnumber ASC');
                }

                if ($courses) {
                    foreach ($courses as $course) {
                        if ($course->id == SITEID) {
                            continue;
                        }
                        $branch->add($course->fullname,
                            new moodle_url('/course/view.php', array('id' => $course->id)),
                            $course->shortname);
                    }
                }
            }
        }
        return $this->alter_custom_menu($menu);
    }
}
