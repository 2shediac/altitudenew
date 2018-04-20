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
 * The secure layout.
 *
 * @package   theme_altitude
 * @copyright 2016 Moodle, moodle.org
 * @license   http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

// Get the HTML for the settings bits.
$html = theme_clean_get_html_for_settings($OUTPUT, $PAGE);

$themefiles = theme_altitude_setting_files($PAGE->theme->settings);

// Fetch additional body classes from settings.
$settingsbodyclasses = theme_altitude_fetch_bodyclass_settings($PAGE->theme->settings);
if (!isset($PAGE->theme->settings->sidebarblockregionalignment)) {
    $PAGE->theme->settings->sidebarblockregionalignment = "left";
}

// Fetch HTML for social media icons.
$socialicons = theme_altitude_fetch_socialicons($PAGE->theme->settings);

// Slidebar side.
$slidebarside = isset($PAGE->theme->settings->sidebarblockregionalignment) ?
    $PAGE->theme->settings->sidebarblockregionalignment :
    'left';

$themecolor = ' ';
if (isset($PAGE->theme->settings->themecolor)) {
    $themecolor = $PAGE->theme->settings->themecolor;
}

// Set default (LTR) layout mark-up for a three column page.
$regionmainbox = 'span9';
$regionmain = 'span8 pull-right';
$sidepre = 'span4 desktop-first-column';
$sidepost = 'span3 pull-right';
// Reset layout mark-up for RTL languages.
if (right_to_left()) {
    $regionmainbox = 'span9 pull-right';
    $regionmain = 'span8';
    $sidepre = 'span4 pull-right';
    $sidepost = 'span3 desktop-first-column';
}

$themecolor = ' ';
if (isset($PAGE->theme->settings->themecolor)) {
    $themecolor = $PAGE->theme->settings->themecolor;
}

echo $OUTPUT->doctype() ?>
<html <?php echo $OUTPUT->htmlattributes(); ?>>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><?php echo $OUTPUT->page_title(); ?></title>
    <?php echo theme_altitude_fetch_favicon($PAGE->theme->settings); ?>
    <?php echo $OUTPUT->standard_head_html() ?>
    <link href='//fonts.googleapis.com/css?family=Open+Sans:300,400,700,800' rel='stylesheet' type='text/css'>
    <link href='//fonts.googleapis.com/css?family=Oswald:400,700' rel='stylesheet' type='text/css'>
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.6.0/css/font-awesome.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body <?php echo $OUTPUT->body_attributes('custom-theme '.$themecolor.$settingsbodyclasses); ?>>

<?php echo $OUTPUT->standard_top_of_body_html() ?>

<header role="banner" class="navbar navbar-fixed-top moodle-has-zindex sb-slide">

    <nav role="navigation" class="navbar-inner">
        <div class="container-fluid">
            <div id="logo">
                <a href="<?php echo $CFG->wwwroot;?>">
                    <?php if (isset($themefiles['logo'])) {
                        echo html_writer::empty_tag('img', array('alt' => get_string('logoalt', 'theme_altitude'), 'src' => $themefiles['logo']));
                    } else { ?>
                        <img src="<?php echo $OUTPUT->image_url('logo', 'theme'); ?>" alt="<?php echo get_string('logoalt', 'theme_altitude')?>" />
                    <?php } ?>
                </a>
            </div>
            <div class="menus">
                <?php echo $OUTPUT->custom_menu(); ?>
            </div>
        </div>
    </nav>

    <div id="top-header-wrap">
        <div id="top-header" class="container-fluid">
            <?php echo theme_altitude_fetch_sidebar_toggle_button('left'); ?>
            <?php echo theme_altitude_fetch_sidebar_toggle_button('right'); ?>
            <div id="top-header-info">
                <div class="social-links">
                    <?php echo $socialicons ?>
                </div>
            </div>
            <?php echo $PAGE->pagelayout == 'secure' ? '' : $OUTPUT->navbar_plugin_output(); ?>
            <?php echo $OUTPUT->user_menu(); ?>
        </div>
    </div>

</header>

<div class="sb-slide">

    <section id="page-header-wrap">
        <div class="container-fluid">
            <?php echo $OUTPUT->full_header(); ?>
        </div>
    </section>

    <div id="page" class="container-fluid">

        <div id="page-content" class="row-fluid">
            <div id="region-main-box" class="<?php echo $regionmainbox; ?>">
                <div class="row-fluid">
                    <section id="region-main" class="<?php echo $regionmain; ?>">
                        <?php echo $OUTPUT->main_content(); ?>
                    </section>
                    <?php echo $OUTPUT->blocks('side-pre', $sidepre); ?>
                </div>
            </div>
            <?php echo $OUTPUT->blocks('side-post', $sidepost); ?>
        </div>

        <?php echo $OUTPUT->standard_end_of_body_html() ?>

    </div>

    <footer id="page-footer">
        <div class="footer-content container-fluid">
            <div class="row-fluid">
                <?php echo $OUTPUT->blocks('footer-one', 'span4'); ?>
                <?php echo $OUTPUT->blocks('footer-two', 'span4'); ?>
                <?php echo $OUTPUT->blocks('footer-three', 'span4'); ?>
            </div>
        </div>
    </footer>

    <footer id="page-footer2">
        <div class="footer-content container-fluid">
            <div class="row-fluid">
                <?php echo $OUTPUT->blocks('footer-four', 'span12'); ?>
            </div>
            <p class="helplink"><?php echo $OUTPUT->page_doc_link(); ?></p>
        </div>
    </footer>

</div>

<div id="sidebar-block" class="sb-slidebar sb-<?php echo $slidebarside; ?> sb-style-push">
    <?php echo theme_altitude_fetch_slidebars_tabhandle(); ?>
    <!-- Social icons -->
    <div class="social-icons-sidebar">
        <?php echo $socialicons ?>
    </div>
    <!-- Nav menu -->
    <div class="altitude-menu-sidebar">
        <?php echo $OUTPUT->custom_menu(); ?>
    </div>
    <?php echo $OUTPUT->blocks('sidebar-block', 'sidebar-block'); ?>
    <?php echo theme_altitude_fetch_skiplink('side-panel-button'); ?>
</div>

</body>
</html>
