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
 * @package   theme_altitude
 * @copyright 2016 Moodle, moodle.org
 * @license   http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

function theme_altitude_page_init(moodle_page $page) {
    $page->requires->jquery();
}

/**
 * Parses CSS before it is cached.
 *
 * This function can make alterations and replace patterns within the CSS.
 *
 * @param string $css The CSS
 * @param theme_config $theme The theme config object.
 * @return string The parsed CSS The parsed CSS.
 */
function theme_altitude_process_css($css, $theme) {
    // Set custom CSS.
    if (!empty($theme->settings->overridecss)) {
        $customcss = $theme->settings->overridecss;
    } else {
        $customcss = null;
    }
    // Add enhanced grid language string.
    $tag = '[[language:enhancedgridhovertext]]';
    $replacement = get_string('enhancedgridhovertext', 'theme_altitude');
    if (is_null($replacement)) {
        $replacement = '';
    }
    $css = str_replace($tag, $replacement, $css);

    $css = theme_altitude_set_customcss($css, $customcss);

    return $css;
}

/**
 * Adds any custom CSS to the CSS before it is cached.
 *
 * @param string $css The original CSS.
 * @param string $customcss The custom CSS to add.
 * @return string The CSS which now contains our custom CSS.
 */
function theme_altitude_set_customcss($css, $customcss) {
    $tag = '[[setting:overridecss]]';
    $replacement = "";
    // Load custom CSS file contents if it exists.
    $context = context_system::instance();
    $fs = get_file_storage();
    $files = $fs->get_area_files($context->id, 'theme_altitude', 'overridecssfile');
    foreach ($files as $file) {
        $file = $fs->get_file($file->get_contextid(), $file->get_component(), $file->get_filearea(),
            $file->get_itemid(), $file->get_filepath(), $file->get_filename());
        if ($file) {
            $replacement .= $file->get_content();
        }
    }
    // Add in custom css entered in text area.
    $replacement .= $customcss;
    if (is_null($replacement)) {
        $replacement = '';
    }
    $css = str_replace($tag, $replacement, $css);
    return $css;
}

/**
 * Finds files in theme settings and returns moodle urls for those files.
 *
 * @return array Moodle urls for theme files
 */
function theme_altitude_setting_files($settings) {
    $context = context_system::instance();
    $settingsfiles = [];
    $fs = get_file_storage();
    foreach ($settings as $key => $filename) {
        $files = $fs->get_area_files($context->id, 'theme_altitude', $key);
        foreach ($files as $file) {
            if ($filename == $file->get_filepath().$file->get_filename()) {
                $url = moodle_url::make_pluginfile_url($file->get_contextid(), $file->get_component(), $file->get_filearea(),
                    $file->get_itemid(), $file->get_filepath(), $filename);
                $settingsfiles[$key] = $url;
            }
        }
    }
    return $settingsfiles;
}

/**
 * Serves any files associated with the theme settings.
 *
 * @param stdClass $course
 * @param stdClass $cm
 * @param context $context
 * @param string $filearea
 * @param array $args
 * @param bool $forcedownload
 * @param array $options
 * @return bool
 */
function theme_altitude_pluginfile($course, $cm, $context, $filearea, $args, $forcedownload, array $options = array()) {
    if ($context->contextlevel == CONTEXT_SYSTEM) {
        $theme = theme_config::load('altitude');
        return $theme->setting_file_serve($filearea, $args, $forcedownload, $options);
    } else {
        send_file_not_found();
    }
}

/**
 * Returns any additional body classes from settings to be written to the layout body tag.
 *
 * @param object $settings The theme settings object
 * @return string String of body classes to be added to the body tag in layout file.
 */
function theme_altitude_fetch_bodyclass_settings($settings) {
    // If all of the settings are boolean, we can eventually abstract this into a foreach, so placeholer below.
    // Array of settings to check. Add settings to this array.
    $bodyclasses = '';
    if (!empty($settings->coursecatajax)) {
        if ($settings->coursecatajax == 1) {
            // Fabricate settings class string.
            $settingsclass = ' altitude-settings-'.'coursecatajax';
            // Add body class to the bodyclasses.
            $bodyclasses .= $settingsclass;
        }
    }
    if (!empty($settings->fixedquizui)) {
        if ($settings->fixedquizui == 1) {
            // Fabricate settings class string.
            $settingsclass = ' altitude-settings-'.'fixedquizui';
            // Add body class to the bodyclasses.
            $bodyclasses .= $settingsclass;
        }
    }
    if (!empty($settings->onetopicstyle)) {
        // Fabricate settings class string.
        $settingsclass = ' altitude-settings-'.$settings->onetopicstyle;
        // Add body class to the bodyclasses.
        $bodyclasses .= $settingsclass;
    }
    if (!empty($settings->gridstyle)) {
        if ($settings->gridstyle == 1) {
            // Fabricate settings class string.
            $settingsclass = ' altitude-settings-gridenhanced';
            // Add body class to the bodyclasses.
            $bodyclasses .= $settingsclass;
        }
    }
    // Return classes.
    return $bodyclasses;
}

/**
 * Returns the favicon markup.
 * If a custom favicon is not uploaded in the settings area, the default favicon in the theme is used.
 *
 * @param object $settings The theme settings object
 * @return string String of html that sets the favicon used in the html head.
 */
function theme_altitude_fetch_favicon($settings) {
    global $OUTPUT;
    $themefiles = theme_altitude_setting_files($settings);
    if (isset($themefiles['favicon'])) {
        $faviconhtml = '<link rel="shortcut icon" href="'.$themefiles['favicon'].'" />';
    } else {
        $faviconhtml = '<link rel="shortcut icon" href="'.$OUTPUT->favicon().'" />';
    }
    // Return favicon html.
    return $faviconhtml;
}

/**
 * Returns sidebar toggle button html.
 *
 * @param string $alignment The alignment of the button
 * @return string String of menu toggle button.
 */
function theme_altitude_fetch_sidebar_toggle_button($alignment) {
    global $PAGE;
    if (in_array($PAGE->pagelayout, ['login', 'secure'])) {
        return '';
    }
    $button = '';
    // Ensure defaults are set.
    if (empty($PAGE->theme->settings->sidebarblockregionalignment)) {
        $PAGE->theme->settings->sidebarblockregionalignment = 'left';
    }
    if (empty($PAGE->theme->settings->sidebarblockregionbuttontype)) {
        $PAGE->theme->settings->sidebarblockregionbuttontype = 'icontext';
    }
    if ($PAGE->theme->settings->sidebarblockregionalignment == $alignment) {
        $id = 'side-panel-button';
        $button .= '<a id="'.$id.'" name="'.$id.'" tabindex="0" class="sb-toggle-'.$alignment.'" href="#">';
        if ($PAGE->theme->settings->sidebarblockregionbuttontype == 'icon' ||
                $PAGE->theme->settings->sidebarblockregionbuttontype == 'icontext') {
            $button .= '
                <div id="hamburger">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="screen-reader-text">'
                        .get_string('sidebarblockaccess', 'theme_altitude').
                    '</span>
                </div>';
        }
        if ($PAGE->theme->settings->sidebarblockregionbuttontype == 'text' ||
                $PAGE->theme->settings->sidebarblockregionbuttontype == 'icontext') {
            $button .= '
                <div href="#" class="optional-display-text">
                    <span>'
                        .get_string('sidebarblockregiontogglelabel', 'theme_altitude').
                    '</span>
                </div>';
        }
        $button .= '</a>';
    }
    return $button;
}

/**
 * Returns banner content, either video or slider background, based on settings.
 * If a path for an MP4 video is set, returns the video background, otherwise slider.
 *
 * @param object $settings The theme settings object
 * @return string String of HTML to be written to frontpage.php.
 */
function theme_altitude_fetch_banner($settings) {
    $themeimages = theme_altitude_setting_files($settings);
    // Declare var for banner html content.
    $bannerhtml = '';

    // Set demo settings if demomode is null/on.
    if (!isset($settings->demomode) || $settings->demomode == 'on') {
        global $OUTPUT, $SITE, $CFG;
        $themeimages['sliderimage1'] = $OUTPUT->image_url('snowy-mountains', 'theme');
        $settings->sliderheader1 = get_string('demowelcome', 'theme_altitude', $SITE->fullname); //"Welcome to ".$SITE->fullname;
        $settings->slidertext1 = " ";
        $settings->sliderbuttonlink1 = $CFG->wwwroot."/my";
        $settings->sliderbuttonlabel1 = get_string('demowelcomelink', 'theme_altitude');

        $themeimages['sliderimage2'] = $OUTPUT->image_url('skyscrapers', 'theme');
        $settings->sliderheader2 = get_string('demowelcome', 'theme_altitude', $SITE->fullname);
        $settings->sliderbuttonlink2 = $CFG->wwwroot."/my";
        $settings->slidertext2 = " ";
        $settings->sliderbuttonlabel2 = get_string('demowelcomelink', 'theme_altitude');

        $themeimages['sliderimage3'] = $OUTPUT->image_url('mountain-sunset', 'theme');
        $settings->sliderheader3 = get_string('demowelcome', 'theme_altitude', $SITE->fullname);
        $settings->sliderbuttonlink3 = $CFG->wwwroot."/my";
        $settings->slidertext3 = " ";
        $settings->sliderbuttonlabel3 = get_string('demowelcomelink', 'theme_altitude');
    }

    // Mp4 setting and length.
    $mp4 = '';
    if (isset($settings->videobackgroundmp4) && isset($settings->demomode) && $settings->demomode == 'off') {
        $mp4 = $settings->videobackgroundmp4;
    }
    $mp4length = strlen($mp4);
    // Vid background image.
    if (isset($themeimages['videoimage'])) {
        $videoimage = $themeimages['videoimage'];
    }

    if (!empty($mp4)) {
        if ($mp4length >= 4) {
            $bannerhtml .= '<div class="video-hero jquery-background-video-wrapper demo-video-wrapper">';
            $bannerhtml .= '<video class="jquery-background-video"
                    autoplay
                    muted
                    loop ';

            // Print videoimage if available.
            if (isset($videoimage)) {
                $bannerhtml .= 'poster="'.$videoimage.'">';
            } else {
                $bannerhtml .= '>';
            }

            // Print mp4.
            $bannerhtml .= '<source src="'. $mp4 . '" type="video/mp4">';

            // If webm, print webm.
            if (!empty($settings->videobackgroundwebm)) {
                $bannerhtml .= '<source src="'. $settings->videobackgroundwebm . '" type="video/webm">';
            }

            // If ogg, print ogg.
            if (!empty($settings->videobackgroundogg)) {
                $bannerhtml .= '<source src="'. $settings->videobackgroundogg . '" type="video/ogg">';
            }

            $bannerhtml .= '</video>';

            $bannerhtml .= '<div class="video-overlay"></div>';
            $bannerhtml .= '<div class="page-width">';
            $bannerhtml .= '<div class="video-hero--content">';

            // If header, print header.
            if (!empty($settings->videoheader)) {
                $bannerhtml .= '<h2>'. $settings->videoheader . '</h2>';
            }

            // If text, print text.
            if (!empty($settings->videotext)) {
                $bannerhtml .= '<p>'. $settings->videotext . '</p>';
            }

            $bannerhtml .= '</div>';
            $bannerhtml .= '</div>';
            $bannerhtml .= '</div>';
        }
    } else {
        // If no mp4 video path, return slider markup.
        $bannerhtml .= '<div class="slider-wrapper">';
        if (isset($settings->pausesetting)) {
            $pausetime = $settings->pausesetting * 1000;
        } else {
            $pausetime = 4000;
        }
        $bannerhtml .= '<div id="slider" data-pausetime="'.$pausetime.'">';

        for ($i = 1; $i <= 4; $i++) {
            if (isset($themeimages['sliderimage'.$i])) {
                $current = '';
                if ($i == 1) {
                    $current = ' current';
                }
                $bannerhtml .= '<div class="slide'.$i.$current.'">';
                $bannerhtml .= html_writer::empty_tag('img', array('alt' => 'Banner'.$i, 'src' => $themeimages['sliderimage'.$i]));
                if (strlen ($settings->{'slidertext'.$i}) > 0) {
                    $bannerhtml .= '<div id="banner-title">';
                    $bannerhtml .= '<div class="banner-title-text">';
                    $bannerhtml .= '<h1>'.$settings->{"sliderheader".$i}.'</h1>';
                    $bannerhtml .= '<p>'.$settings->{'slidertext'.$i}.'</p>';
                    $bannerhtml .= '<a href="'.$settings->{'sliderbuttonlink'.$i}.'">';
                    $bannerhtml .= '<span class="fa fa-chevron-circle-right"></span> ';
                    $bannerhtml .= $settings->{'sliderbuttonlabel'.$i};
                    $bannerhtml .= '</a>';
                    $bannerhtml .= '</div>';
                    $bannerhtml .= '</div>';
                }
                $bannerhtml .= '</div>';
            }
        }
        $bannerhtml .= '</div>';
        $bannerhtml .= '<div id="slider-direction-nav"></div>';
        $bannerhtml .= '</div>';
    }

    // Return html.
    return $bannerhtml;
}

/**
 * Returns sub-banner content based on settings.
 *
 * @param object $settings The theme settings object
 * @return string String of HTML to be written to frontpage.php.
 */
function theme_altitude_fetch_subbanner($settings) {
    $numsections = 0;
    $subbannerhtml = '';

    // Set demo settings if demomode is on.
    if (!isset($settings->demomode) || $settings->demomode == 'on') {
        global $CFG;

        $settings->subsectiontitle1 = get_string('demosubsectiontitle1', 'theme_altitude');
        $settings->subsectionlink1 = $CFG->wwwroot."/course/index.php";
        $settings->subsectionicon1 = "book";
        $settings->subsectiondescription1 = get_string('demosubsectiondescription1', 'theme_altitude');
        $settings->subsectionlabel1 = get_string('demosubsectionlabel', 'theme_altitude');

        $settings->subsectiontitle2 = get_string('demosubsectiontitle2', 'theme_altitude');
        $settings->subsectionlink2 = $CFG->wwwroot."/my";
        $settings->subsectionicon2 = "tachometer";
        $settings->subsectiondescription2 = get_string('demosubsectiondescription2', 'theme_altitude');
        $settings->subsectionlabel2 = get_string('demosubsectionlabel', 'theme_altitude');

        $settings->subsectiontitle3 = get_string('demosubsectiontitle3', 'theme_altitude');
        $settings->subsectionlink3 = $CFG->wwwroot."/user/profile.php";
        $settings->subsectionicon3 = "user";
        $settings->subsectiondescription3 = get_string('demosubsectiondescription3', 'theme_altitude');
        $settings->subsectionlabel3 = get_string('demosubsectionlabel', 'theme_altitude');
    }

    // Determine the number of sections.
    for ($i = 1; $i <= 3; $i++) {
        if (!empty($settings->{"subsectiontitle".$i})) {
            $numsections++;
        }
    }

    if ($numsections > 0) {
        // Get span class.
        $spanwidth = 12 / $numsections;
        $spanclass = "span".$spanwidth;

        // Add subbanner html.
        for ($i = 1; $i <= 4; $i++) {
            if (!empty($settings->{"subsectiontitle".$i})) {
                $subbannerhtml .= '<div class="'.$spanclass.'">';
                $subbannerhtml .= '<div class="block">';
                if (!empty($settings->{'subsectionlink'.$i})) {
                    $subbannerhtml .= '<a href="'.$settings->{'subsectionlink'.$i}.'" class="action">';
                }
                $subbannerhtml .= '<div class="content">';
                $subbannerhtml .= '<div class="action-content">';
                $subbannerhtml .= '<div class="hi-icon-wrap hi-icon-effect-1 hi-icon-effect-1a">';
                if (empty($settings->{'subsectionicon'.$i})) {
                    $settings->{'subsectionicon'.$i} = 'genderless';
                }
                $subbannerhtml .= '<div class="hi-icon">';
                $subbannerhtml .= '<span class="fa fa-'.$settings->{'subsectionicon'.$i}.'"></span>';
                $subbannerhtml .= '</div>';
                $subbannerhtml .= '</div>';
                $subbannerhtml .= '<h2>'.$settings->{'subsectiontitle'.$i}.'</h2>';
                $subbannerhtml .= '<p>'.$settings->{'subsectiondescription'.$i}.'</p>';
                $subbannerhtml .= '</div>';
                if (!empty($settings->{'subsectionlink'.$i}) && !empty($settings->{'subsectionlabel'.$i})) {
                    $subbannerhtml .= '<p>';
                    $subbannerhtml .= '<button href="'.$settings->{'subsectionlink'.$i}.'">';
                    $subbannerhtml .= '<span class="fa fa-chevron-circle-right"></span>';
                    $subbannerhtml .= $settings->{'subsectionlabel'.$i};
                    $subbannerhtml .= '</button>';
                    $subbannerhtml .= '</p>';
                }
                $subbannerhtml .= '</div>';
                if (!empty($settings->{'subsectionlink'.$i})) {
                    $subbannerhtml .= '</a>';
                }
                $subbannerhtml .= '</div>';
                $subbannerhtml .= '</div>';
            }
        }

        // Return html.
        return $subbannerhtml;
    }
}

/**
 * Returns social icons content based on settings.
 *
 * @param object $settings The theme settings object
 * @return string String of HTML to be written to layout files.
 */
function theme_altitude_fetch_socialicons($settings) {
    global $PAGE;
    // For secure pages no links are allowed out side of Moodle.
    if ($PAGE->pagelayout == 'secure') {
        return '';
    }
    $numsections = 0;
    $socialiconshtml = '';
    if (!empty($settings->socialmediaicons)) {
        $socialicons = explode("\n", $settings->socialmediaicons);
        foreach ($socialicons as $socialicon) {
            $socialiconparts = explode("|", $socialicon);
            if (!empty($socialiconparts[0]) && !empty($socialiconparts[1])) {
                $socialiconshtml .= '<a href="'.$socialiconparts[1].'" target="_blank" title="'.$socialiconparts[0].'"><i class="fa fa-'.$socialiconparts[0].'"></i></a>';
            }
        }
    }

    // Return html.
    return $socialiconshtml;
}

/**
 * Returns skiplink markup.
 *
 * @param string $target The id attribute of the target of the link.
 * @return string String of HTML to be written to layout files.
 */
function theme_altitude_fetch_skiplink($target) {
    $skiplink = '';
    $desc = '';
    if ($target === 'maincontent'){
        $desc = get_string('tocontent', 'access');
    } else {
        $desc = get_string('sidebarblockskipto', 'theme_altitude');
    }
    $skiplink .= '
        <a class="skip" id="return-to-sb-btn" href="#'.$target.'">'
            .$desc.
        '</a>';
    // Return markup.
    return $skiplink;
}

/**
 * Returns slidebars hidden accessibility handle markup.
 *
 * @return string String of HTML to be written to layout files.
 */
function theme_altitude_fetch_slidebars_tabhandle() {
    $tabhandle = '';
    $desc = get_string('sidebarblockentrymarker', 'theme_altitude');
    $id = 'access-slidebar-blocks';
    $tabhandle .= '
        <a class="skip" id="'.$id.'" name="'.$id.'" tabindex="-1">
            <span class="screen-reader-text">'.$desc.'</span>
        </a>';
    // Return markup.
    return $tabhandle;
}
