<?php
/*
Plugin Name: More Unique
Plugin URI: http://guff.szub.net/more-unique/
Description: Add a customized "more" link text to each of your posts.
Version: R1.2
Author: Kaf Oseo
Author URI: http://szub.net

	Copyright (c) 2006, 2007 Kaf Oseo (http://szub.net)
	More Unique is released under the GNU General Public License
	(GPL) http://www.gnu.org/licenses/gpl.txt

	This is a WordPress plugin (http://wordpress.org).

Usage note:
After the plugin is activated in WordPress, add a 'more' custom
field key (with whatever you want for the more link text as the
field's value) to your posts. If the more key with a value does
not exist, the value provided to the_content() template tag for
the 'more_link_text' parameter, or the default text, is used.

For info on the_content() and the 'more' link, see:

	http://codex.wordpress.org/Template_Tags/the_content

~Changelog:
R1.2 (Nov-19-2007)
Post meta handling fix. Added $default user-configurable var to
modify WordPress' default more link text. Also, you can now use
%title% (in 'more' custom field and $default var value) to auto-
insert the post's title in the more link text.

R1.1 (Nov-19-2006)
Using %nomore% for your more custom field value removes the more
link for that post. Tentative support for WordPress 2.1.
*/

function szub_more_unique($text) {
/* >> Begin user-configurable variables >> */
	$key = 'more'; // modify for different custom field key name
	$default = ''; // more link text if no 'more' custom field; replaces WP default
/* << End user-configurable variables << */

	global $post;
	$more_value = get_post_meta($post->ID, $key, true);
	$more_text = ($more_value) ? $more_value : $default;

	if( !empty($more_text) ) {
		$pattern = '%<a href="(.*\#more-' . $post->ID . ')"( class="more-link")?>.*</a>%';
		if( '%nomore%' == $more_text) {
			$replace = '';
		} else {
			$replace = '<a href="\\1\\2">' . apply_filters('the_title', str_replace('%title%', $post->post_title, $more_text)) . '</a>';
		}

		$text = preg_replace($pattern, $replace, $text);
	}

	return $text;
}

add_filter('the_content', 'szub_more_unique', 42);
?>