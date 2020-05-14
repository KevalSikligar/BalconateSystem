<?php
/*
Plugin Name: Enhanced WP-ContactForm
Plugin URI: http://yoast.com/wordpress/enhanced-wordpress-contact-form/
Based on: http://ryanduff.net/projects/wp-contactform/
Description: WP Contact Form is a drop in form for users to contact you. In the message it sends to you it gives the page the user visited before the contact page, as well as the original outside referer. It can be implemented on a page or a post. 
Author: Joost de Valk
Author URI: http://yoast.com/
Version: 2.2.3
*/

// Pre-2.6 compatibility
if ( !defined('WP_CONTENT_URL') )
    define( 'WP_CONTENT_URL', get_option('siteurl') . '/wp-content');
if ( !defined('WP_CONTENT_DIR') )
    define( 'WP_CONTENT_DIR', ABSPATH . 'wp-content' );
 
// Guess the location
$wpcfpluginpath = WP_CONTENT_DIR.'/plugins/'.plugin_basename(dirname(__FILE__)).'/';

load_plugin_textdomain('wpcf',$wpcfpluginpath);

/* Declare strings that change depending on input. This also resets them so errors clear on resubmission. */
$wpcf_strings = array(
	'name' => '<input type="text" name="wpcf_your_name" id="wpcf_your_name" size="30" maxlength="50" value="' . $_POST['wpcf_your_name'] . '" /> (' . __(get_option('wpcf_required_txt'), 'wpcf') . ')',
	'email' => '<input type="text" name="wpcf_email" id="wpcf_email" size="30" maxlength="50" value="' . $_POST['wpcf_email'] . '" /> (' . __(get_option('wpcf_required_txt'), 'wpcf') . ')',
	'website' => '<input type="text" name="wpcf_website" id="wpcf_website" size="30" maxlength="50" value="' . $_POST['wpcf_website'] . '" />',
	'msg' => '<textarea name="wpcf_msg" id="wpcf_msg" cols="35" rows="8" >' . $_POST['wpcf_msg'] . '</textarea>',
	'error' => '');

function get_query($query) {
	if (strpos($query, "google.")) {
		$pattern = '/^.*\/search\?.*q=(.*)$/';
	} else if (strpos($query, "msn.") || strpos($query, "live")) {
		$pattern = '/^.*q=(.*)$/';
	} else if (strpos($query, "yahoo.")) {
		$pattern = '/^.*[\?&]p=(.*)$/';
	} else if (strpos($query, "ask.")) {
		$pattern = '/^.*[\?&]q=(.*)$/';
	} else {
		return false;
	}
	preg_match($pattern, $query, $matches);
	$querystr = substr($matches[1], 0, strpos($matches[1], '&'));
	return urldecode($querystr);
}

function wpcf_is_malicious($input) {
	$is_malicious = false;
	$bad_inputs = array("\r", "\n", "mime-version", "content-type", "cc:", "to:");
	foreach($bad_inputs as $bad_input) {
		if(strpos(strtolower($input), strtolower($bad_input)) !== false) {
			$is_malicious = true; break;
		}
	}
	return $is_malicious;
}

/* This function checks for errors on input and changes $wpcf_strings if there are any errors. Shortcircuits if there has not been a submission */
function wpcf_check_input()
{
	if(!(isset($_POST['wpcf_stage']))) {return false;} // Shortcircuit.
	if(!(isset($_POST['wpcf_referers']))) {return false;} // Spam prevention
	if(!(isset($_POST['wpcf_pages']))) {return false;} // Spam prevention
	
	$spam_check = get_option('wpcf_show_spamcheck');
	if ($spam_check) {
		// If showing the "This is not spam"-checkbox, check if this checkbox is set to true
		if ($_SESSION['wpcf_spamanswer'] != $_POST['wpcf_not_spam']) {
			return false;
		} 
	}
	$_POST['wpcf_your_name'] 	= stripslashes(trim($_POST['wpcf_your_name']));
	$_POST['wpcf_email'] 		= stripslashes(trim($_POST['wpcf_email']));
	$_POST['wpcf_msg'] 			= stripslashes(trim($_POST['wpcf_msg']));
	$_POST['wpcf_cc'] 			= stripslashes(trim($_POST['wpcf_cc']));

	global $wpcf_strings;
	$ok = true;

	if(empty($_POST['wpcf_your_name']))
	{
		$ok = false; $reason = 'empty';
		$wpcf_strings['name'] = '<input type="text" name="wpcf_your_name" id="wpcf_your_name" size="30" maxlength="50" value="' . $_POST['wpcf_your_name'] . '" class="contacterror" /> (' . __(get_option('wpcf_required_txt'), 'wpcf') . ')';
	}

    if(!is_email($_POST['wpcf_email']))
    {
	    $ok = false; $reason = 'empty';
	    $wpcf_strings['email'] = '<input type="text" name="wpcf_email" id="wpcf_email" size="30" maxlength="50" value="' . $_POST['wpcf_email'] . '" class="contacterror" /> (' . __(get_option('wpcf_required_txt'), 'wpcf') . ')';
	}

    if(empty($_POST['wpcf_msg']))
    {
	    $ok = false; $reason = 'empty';
	    $wpcf_strings['msg'] = '<textarea name="wpcf_msg" id="wpcf_message" cols="35" rows="8" class="contacterror">' . $_POST['wpcf_msg'] . '</textarea>';
	}

	if(wpcf_is_malicious($_POST['wpcf_your_name']) || wpcf_is_malicious($_POST['wpcf_email'])) {
		$ok = false; $reason = 'malicious';
	}

	//Before we send the email, we need to check with Akismet
	global $akismet_api_host, $akismet_api_port;
	$c['user_ip']    		= preg_replace( '/[^0-9., ]/', '', $_SERVER['REMOTE_ADDR'] );
	$c['user_agent'] 		= $_SERVER['HTTP_USER_AGENT'];
	$c['referrer']   		= $_SERVER['HTTP_REFERER'];
	$c['blog']       		= get_option('home');
	$c['permalink']       		= $c['blog'].$_SERVER['REQUEST_URI'];	
	$c['comment_type']       	= 'pxsmail';		
	$c['comment_author']       	= $name;		
	$c['comment_author_email']      = $email;			
	$c['comment_author_url']       	= $blog;
	$c['comment_content']       	= $_POST['msg'];	
	
	$ignore = array( 'HTTP_COOKIE' );

	foreach ( $_SERVER as $key => $value )
		if ( !in_array( $key, $ignore ) )
			$c["$key"] = $value;

	$query_string = '';
	foreach ( $c as $key => $data )
		$query_string .= $key . '=' . urlencode( stripslashes($data) ) . '&';
	$response = akismet_http_post($query_string, $akismet_api_host, '/1.1/comment-check', $akismet_api_port);
	
	if ( 'true' == $response[1] ) {
	 	$ok = false;
		$reason = "malicious";
	}
	
	if($ok == true)
	{
		return true;
	}
	else {
		if($reason == 'malicious') {
			$wpcf_strings['error'] = "<strong>" . stripslashes(get_option('wpcf_malicious_msg')) . "</strong>";
		} elseif($reason == 'empty') {
			$wpcf_strings['error'] = '<strong>' . stripslashes(get_option('wpcf_error_msg')) . '</strong>';
		}
		return false;
	}
}

/*Wrapper function which calls the form.*/
function wpcf_callback( $content )
{
	global $wpcf_strings;

	/* Run the input check. */

    if(wpcf_check_input()) // If the input check returns true (ie. there has been a submission & input is ok)
    {
		$recipient 		= get_option('wpcf_email');
		$subject 		= get_option('wpcf_subject');
		$success_msg 	= get_option('wpcf_success_msg');
		$wpcf_cc_option = get_option('wpcf_cc_option');
		$success_msg 	= stripslashes($success_msg);

		$name 		= $_POST['wpcf_your_name'];
		$email 		= $_POST['wpcf_email'];
		$website 	= $_POST['wpcf_website'];
		$msg 		= $_POST['wpcf_msg'];
		$referers 	= $_POST['wpcf_referers'];
		$referers 	= unserialize(urldecode($referers));
		$pages	 	= $_POST['wpcf_pages'];
		$pages	 	= unserialize(urldecode($pages));
		$cctrue		= $_POST['wpcf_cc'];
		
		$headers = "MIME-Version: 1.0\r\n";
		$headers .= "From: $name <$email>\r\n";
		$headers .= "Content-Type: text/plain; charset=\"" . get_settings('blog_charset') . "\"\r\n";

		$shortmsg = "$name ($website) wrote:\r\n";
		$shortmsg .= wordwrap($msg, 80, "\r\n") . "\r\n\r\n";
		$shortmsg .= str_pad("IP: ",20) . getip() ."\r\n";

		$i = 1;
		foreach ($referers as $referer) {
			$fullmsg .= str_pad("Referer $i: ",20) . $referer. "\r\n";
			$keywords_used = get_query($referer);
			if ($keywords_used) {
				$keywords[] = $keywords_used;
			}
			$i++;
		}
		$fullmsg .= "\r\n";
		
		$i = 1;
		foreach ($pages as $page) {
			$fullmsg .= str_pad("Page visited $i: ",20) . $page. "\r\n";
			$i++;
		}
		$fullmsg .= "\r\n";
		
		$i = 1;
		if ($keywords) {
			foreach ($keywords as $keyword) {
				$fullmsg .= str_pad("Keyword $i: ",20) . $keyword. "\r\n";
				$i++;
			}
		}
		$fullmsg .= "\r\n";

		$fullmsg = $shortmsg . $fullmsg;
		mail($recipient, $subject, $fullmsg, $headers);	

		if ($wpcf_cc_option && $cctrue) {
			// If user wants a CC, send it now
			mail($email, $subject, $shortmsg, $headers);
		}
		
		$results = '<div style="font-weight: bold;">' . $success_msg . '</div>';
		return $results;
    }
    else // Else show the form. If there are errors the strings will have updated during running the inputcheck.
    {
        $form = '<div class="contactform">
        ' . $wpcf_strings['error'] . '
			<form id="wpcf" action="' . get_permalink() . '" method="post">
				<label for="wpcf_your_name">' . __(get_option('wpcf_yourname_txt'), 'wpcf') . '</label>' . $wpcf_strings['name']  . '<br style="clear: both;"/>
				<label for="wpcf_email">' . __(get_option('wpcf_email_txt'), 'wpcf') . '</label>' . $wpcf_strings['email'] . '<br style="clear: both;"/>
				<label for="wpcf_website">' . __(get_option('wpcf_website_txt'), 'wpcf') . '</label>' . $wpcf_strings['website'] . '<br style="clear: both;"/>
				<label for="wpcf_msg">' . __(get_option('wpcf_message_txt'), 'wpcf') . '</label><br/>' . $wpcf_strings['msg'] . '<br style="clear: both;"/>';
				
				$spam_check = get_option('wpcf_show_spamcheck');
				if ($spam_check) {
					$rand1 = rand(0,20);
					$rand2 = rand(0,20);
					$form .= '<label>'. get_option('wpcf_spamcheck1_txt') . ' '.$rand1.' '. get_option('wpcf_spamcheck2_txt') . ' '.$rand2.' ' . get_option('wpcf_spamcheck3_txt') . '</label> <input style="margin:0; width: 100px;" type="text" name="wpcf_not_spam" autocomplete="off"/><br/><br/>';
					$_SESSION['wpcf_spamanswer'] = $rand1+$rand2;
				}
				$cc_option = get_option('wpcf_cc_option');
				if ($cc_option) {
					$form .= '<label>'.get_option('wpcf_cccopy_txt') . ':</label> <input type="checkbox" name="wpcf_cc" value="on" checked="checked" /> ';
				}
				
				$form .= '<br/><input type="submit" name="Submit" value="' . __(get_option('wpcf_sendbtn_txt'), 'wpcf') . '" id="contactsubmit" />
				<input type="hidden" name="wpcf_stage" value="process" />
				<input type="hidden" name="wpcf_referers" value=\'' .urlencode(serialize($_SESSION['wpcfreferer'])). '\' />
				<input type="hidden" name="wpcf_pages" value=\'' .urlencode(serialize($_SESSION['wpcfpages'])). '\' />
			</form>
		</div>';
        return $form;
    }
}


/*Can't use WP's function here, so lets use our own*/
function getip() {
	if (isset($_SERVER)) {
 		if (isset($_SERVER["HTTP_X_FORWARDED_FOR"])) {
  			$ip_addr = $_SERVER["HTTP_X_FORWARDED_FOR"];
 		} else if (isset($_SERVER["HTTP_CLIENT_IP"])) {
  			$ip_addr = $_SERVER["HTTP_CLIENT_IP"];
 		} else {
 			$ip_addr = $_SERVER["REMOTE_ADDR"];
 		}
	} else {
 		if ( getenv( 'HTTP_X_FORWARDED_FOR' ) ) {
  			$ip_addr = getenv( 'HTTP_X_FORWARDED_FOR' );
 		} else if ( getenv( 'HTTP_CLIENT_IP' ) ) {
  			$ip_addr = getenv( 'HTTP_CLIENT_IP' );
 		} else {
  			$ip_addr = getenv( 'REMOTE_ADDR' );
 		}
	}
	return $ip_addr;
}


function referer_session() {
	$baseurl = get_bloginfo('url');
	if (! isset($_SESSION) ) {
		session_start();
	}
	if (! isset($_SESSION['wpcfpages']) || ! is_array($_SESSION['wpcfpages']) ) {
		$_SESSION['wpcfpages'] = array();
	}
	if (! isset($_SESSION['wpcfreferer']) || ! is_array($_SESSION['wpcfreferer']) ) {
		$_SESSION['wpcfreferer'] = array();
	}
	if ( (strpos($_SERVER['HTTP_REFERER'], $baseurl) === false) && ! (in_array($_SERVER['HTTP_REFERER'], $_SESSION['wpcfreferer'])) ) {
		if (! isset($_SERVER['HTTP_REFERER'])) {
			$_SESSION['wpcfreferer'][] = "Type-in or bookmark";
		} else {
			$_SESSION['wpcfreferer'][] = $_SERVER['HTTP_REFERER'];	
		}
	}
	if (end($_SESSION['wpcfpages']) != "http://".$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI']) {
		$_SESSION['wpcfpages'][] = "http://".$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'];	
	}
}

function wpcf_add_ozh_adminmenu_icon( $hook ) {
	if ($hook == 'enhanced-wordpress-contactform/options-contactform.php') {
		$hook = WP_CONTENT_URL . '/plugins/' . plugin_basename(dirname(__FILE__)). '/comment.png';
	}
	return $hook;
}

function wpcf_filter_plugin_actions( $links, $file ){
	//Static so we don't call plugin_basename on every plugin row.
	static $this_plugin;
	if ( ! $this_plugin ) $this_plugin = plugin_basename(__FILE__);

	if ( $file == $this_plugin ){
		$settings_link = '<a href="options-general.php?page=enhanced-wordpress-contactform/options-contactform.php">' . __('Settings') . '</a>';
		array_unshift( $links, $settings_link ); // before other links
	}
	return $links;
}

function wpcf_add_options_page() {
	global $wpcfpluginpath;
	add_options_page('Contact Form Options', 'Contact Form', 'manage_options', $wpcfpluginpath.'options-contactform.php');
	add_filter( 'plugin_action_links', 'wpcf_filter_plugin_actions', 10, 2 );
	add_filter( 'ozh_adminmenu_icon', 'wpcf_add_ozh_adminmenu_icon' );
}

/* Action calls for all functions */

add_action('init', 'referer_session');
add_action('admin_menu', 'wpcf_add_options_page');
add_shortcode('wpcf', 'wpcf_callback');

/**
 * Add the Yoast.com RSS feed to the WordPress dashboard
 */
if (!function_exists('yst_db_widget')) {
	function yst_text_limit( $text, $limit, $finish = ' [&hellip;]') {
		if( strlen( $text ) > $limit ) {
	    	$text = substr( $text, 0, $limit );
			$text = substr( $text, 0, - ( strlen( strrchr( $text,' ') ) ) );
			$text .= $finish;
		}
		return $text;
	}
	
	function yst_db_widget($image = 'normal', $num = 3, $excerptsize = 250, $showdate = true) {
		require_once(ABSPATH.WPINC.'/rss.php');  
		if ( $rss = fetch_rss( 'http://feeds2.feedburner.com/joostdevalk' ) ) {
			echo '<div class="rss-widget">';
			if ($image == 'normal') {
				echo '<a href="http://yoast.com/" title="Go to Yoast.com"><img src="http://cdn.yoast.com/yoast-logo-rss.png" class="alignright" alt="Yoast"/></a>';			
			} else {
				echo '<a href="http://yoast.com/" title="Go to Yoast.com"><img width="80" src="http://cdn.yoast.com/yoast-logo-rss.png" class="alignright" alt="Yoast"/></a>';			
			}
			echo '<ul>';
			$rss->items = array_slice( $rss->items, 0, $num );
			foreach ( (array) $rss->items as $item ) {
				echo '<li>';
				echo '<a class="rsswidget" href="'.clean_url( $item['link'], $protocolls=null, 'display' ).'">'. htmlentities($item['title']) .'</a> ';
				if ($showdate)
					echo '<span class="rss-date">'. date('F j, Y', strtotime($item['pubdate'])) .'</span>';
				echo '<div class="rssSummary">'. yst_text_limit($item['summary'],$excerptsize) .'</div>';
				echo '</li>';
			}
			echo '</ul>';
			echo '<div style="border-top: 1px solid #ddd; padding-top: 10px; text-align:center;">';
			echo '<a href="http://feeds2.feedburner.com/joostdevalk"><img src="'.get_bloginfo('wpurl').'/wp-includes/images/rss.png" alt=""/> Subscribe with RSS</a>';
			if ($image == 'normal') {
				echo ' &nbsp; &nbsp; &nbsp; ';
			} else {
				echo '<br/>';
			}
			echo '<a href="http://yoast.com/email-blog-updates/"><img src="http://cdn.yoast.com/email_sub.png" alt=""/> Subscribe by email</a>';
			echo '</div>';
			echo '</div>';
		}
	}
 
	function yst_widget_setup() {
	    wp_add_dashboard_widget( 'yst_db_widget' , 'The Latest news from Yoast' , 'yst_db_widget');
	}
 
	add_action('wp_dashboard_setup', 'yst_widget_setup');
}

?>