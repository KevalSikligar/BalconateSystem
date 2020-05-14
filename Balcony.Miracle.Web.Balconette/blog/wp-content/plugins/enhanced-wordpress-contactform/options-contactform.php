<?php
/*
Author: Joost de Valk
Author URI: http://yoast.com
Description: Administrative options for WP-ContactForm
*/

// Pre-2.6 compatibility
if ( !defined('WP_CONTENT_URL') )
    define( 'WP_CONTENT_URL', get_option('siteurl') . '/wp-content');
if ( !defined('WP_CONTENT_DIR') )
    define( 'WP_CONTENT_DIR', ABSPATH . 'wp-content' );
 
// Guess the location
$wpcfpluginpath = WP_CONTENT_URL.'/plugins/'.plugin_basename(dirname(__FILE__)).'/';

load_plugin_textdomain('wpcf',$wpcfpluginpath);

$location = get_option('siteurl') . '/wp-admin/admin.php?page='.dirname(__FILE__).'/options-contactform.php'; // Form Action URI

/*Lets add some default options if they don't exist*/
add_option('wpcf_email', __('you@example.com', 'wpcf'));
add_option('wpcf_subject', __('Contact Form Results', 'wpcf'));
add_option('wpcf_success_msg', __('Thanks for your comments!', 'wpcf'));
add_option('wpcf_error_msg', __('Please fill in the required fields.', 'wpcf'));
add_option('wpcf_yourname_txt', __('Your Name:', 'wpcf'));
add_option('wpcf_email_txt', __('Your Email Address:', 'wpcf'));
add_option('wpcf_website_txt', __('Your Website:', 'wpcf'));
add_option('wpcf_message_txt', __('Your Message:', 'wpcf'));
add_option('wpcf_cccopy_txt', __('CC yourself on message', 'wpcf'));
add_option('wpcf_required_txt', __('required', 'wpcf'));
add_option('wpcf_spamcheck1_txt', __('The sum of', 'wpcf'));
add_option('wpcf_spamcheck2_txt', __('and', 'wpcf'));
add_option('wpcf_spamcheck3_txt', __('is:', 'wpcf'));
add_option('wpcf_sendbtn_txt', __('Submit', 'wpcf'));
add_option('wpcf_malicious_msg', __('You can not use any of the following in the Name or Email fields: a linebreak, or the phrases \'mime-version\', \'content-type\', \'cc:\' or \'to:\'.', 'wpcf'));
add_option('wpcf_show_spamcheck', TRUE);
add_option('wpcf_cc_option', TRUE);

/*check form submission and update options*/
if ('process' == $_POST['stage']) {
	if (!current_user_can('manage_options')) die(__('You cannot edit the Enhanced WordPress Contact Form options.'));
	check_admin_referer('ewpcf-config');
	
	update_option('wpcf_email', $_POST['wpcf_email']);
	update_option('wpcf_subject', $_POST['wpcf_subject']);
	update_option('wpcf_success_msg', $_POST['wpcf_success_msg']);
	update_option('wpcf_error_msg', $_POST['wpcf_error_msg']);
	update_option('wpcf_yourname_txt', $_POST['wpcf_yourname_txt']); 
	update_option('wpcf_email_txt', $_POST['wpcf_email_txt']); 
	update_option('wpcf_website_txt', $_POST['wpcf_website_txt']); 
	update_option('wpcf_message_txt', $_POST['wpcf_message_txt']); 
	update_option('wpcf_cccopy_txt', $_POST['wpcf_cccopy_txt']); 
	update_option('wpcf_required_txt', $_POST['wpcf_required_txt']); 
	update_option('wpcf_spamcheck1_txt', $_POST['wpcf_spamcheck1_txt']); 
	update_option('wpcf_spamcheck2_txt', $_POST['wpcf_spamcheck2_txt']); 
	update_option('wpcf_spamcheck3_txt', $_POST['wpcf_spamcheck3_txt']); 
	update_option('wpcf_sendbtn_txt', $_POST['wpcf_sendbtn_txt']); 
	update_option('wpcf_malicious_msg', $_POST['wpcf_malicious_msg']); 

	if(isset($_POST['wpcf_show_spamcheck'])) {
		// If wpcf_show_spamcheck is checked
		update_option('wpcf_show_spamcheck', true);
	} else {
		update_option('wpcf_show_spamcheck', false);
	}

	if(isset($_POST['wpcf_cc_option'])) {
		// If wpcf_cc_option is checked
		update_option('wpcf_cc_option', true);
	} else {
		update_option('wpcf_cc_option', false);
	}
}

/*Get options for form fields*/
$wpcf_email = stripslashes(get_option('wpcf_email'));
$wpcf_subject = stripslashes(get_option('wpcf_subject'));
$wpcf_success_msg = stripslashes(get_option('wpcf_success_msg'));
$wpcf_error_msg = stripslashes(get_option('wpcf_error_msg'));
$wpcf_show_spamcheck = get_option('wpcf_show_spamcheck');
$wpcf_cc_option = get_option('wpcf_cc_option');
$wpcf_yourname_txt = stripslashes(get_option('wpcf_yourname_txt'));
$wpcf_email_txt = stripslashes(get_option('wpcf_email_txt'));
$wpcf_website_txt = stripslashes(get_option('wpcf_website_txt'));
$wpcf_message_txt = stripslashes(get_option('wpcf_message_txt'));
$wpcf_cccopy_txt = stripslashes(get_option('wpcf_cccopy_txt'));
$wpcf_required_txt = stripslashes(get_option('wpcf_required_txt'));
$wpcf_spamcheck1_txt = stripslashes(get_option('wpcf_spamcheck1_txt'));
$wpcf_spamcheck2_txt = stripslashes(get_option('wpcf_spamcheck2_txt'));
$wpcf_spamcheck3_txt = stripslashes(get_option('wpcf_spamcheck3_txt'));
$wpcf_sendbtn_txt = stripslashes(get_option('wpcf_sendbtn_txt'));
$wpcf_malicious_msg = stripslashes(get_option('wpcf_malicious_msg'));


?>

<div class="wrap">
  <h2><?php _e('Enhanced WP-Contact Form Options', 'wpcf') ?></h2>
  <form name="form1" method="post" action="<?php echo $location ?>&amp;updated=true">
	<?php
	if ( function_exists('wp_nonce_field') )
		wp_nonce_field('ewpcf-config');
	?>
	<input type="hidden" name="stage" value="process" />
    <table width="100%" cellspacing="2" cellpadding="5" class="form-table">
      <tr valign="top">
        <th scope="row"><?php _e('E-mail Address:') ?></th>
        <td><input name="wpcf_email" type="text" id="wpcf_email" value="<?php echo $wpcf_email; ?>" size="40" />
        <br />
<?php _e('This address is where the email will be sent to.', 'wpcf') ?></td>
      </tr>
      <tr valign="top">
        <th scope="row"><?php _e('Subject:') ?></th>
        <td><input name="wpcf_subject" type="text" id="wpcf_subject" value="<?php echo $wpcf_subject; ?>" size="50" />
        <br />
<?php _e('This will be the subject of the email.', 'wpcf') ?></td>
      </tr>
     </table>

	<h3><?php _e('Messages', 'wpcf') ?></h3>
		<table width="100%" cellspacing="2" cellpadding="5" class="form-table">
		  <tr valign="top">
			<th scope="row"><?php _e('Success Message:', 'wpcf') ?></th>
			<td><textarea name="wpcf_success_msg" id="wpcf_success_msg" style="width: 80%;" rows="4" cols="50"><?php echo $wpcf_success_msg; ?></textarea>
			<br />
	<?php _e('When the form is sucessfully submitted, this is the message the user will see.', 'wpcf') ?></td>
		  </tr>
		  <tr valign="top">
			<th scope="row"><?php _e('Error Message:', 'wpcf') ?></th>
			<td><textarea name="wpcf_error_msg" id="wpcf_error_msg" style="width: 80%;" rows="4" cols="50"><?php echo $wpcf_error_msg; ?></textarea>
			<br />
	<?php _e('If the user skips a required field, this is the message he will see.', 'wpcf') ?> <br />
	<?php _e('You can apply CSS to this text by wrapping it in <code>&lt;p style="[your CSS here]"&gt; &lt;/p&gt;</code>.', 'wpcf') ?><br />
	<?php _e('ie. <code>&lt;p style="color:red;"&gt;Please fill in the required fields.&lt;/p&gt;</code>.', 'wpcf') ?></td>
		  </tr>
		  <tr valign="top">
			<th scope="row"><?php _e('Malicious Code Message:', 'wpcf') ?></th>
			<td><textarea name="wpcf_malicious_msg" id="wpcf_malicious_msg" style="width: 80%;" rows="4" cols="50"><?php echo $wpcf_malicious_msg; ?></textarea>
			<br />
	<?php _e('Shows when the form is submitted, and malicious code was entered in one of the textfields.', 'wpcf') ?></td>
		  </tr>
		</table>
	
		<h3><?php _e('Custom Form Texts', 'wpcf') ?></h3>
		   <table width="100%" cellspacing="2" cellpadding="5" class="form-table">
		    <tr valign="top">
        <th scope="row"><?php _e('Change Language:', 'wpcf') ?></th>
        <td> 
        	<a href="" onclick="document.getElementById('wpcf_subject').value = 'Contact Form Results';
		    	document.getElementById('wpcf_success_msg').value = 'Thanks for your comments!';
		    	document.getElementById('wpcf_error_msg').value = 'Please fill in the required fields.';
		    	document.getElementById('wpcf_yourname_txt').value = 'Your Name:';
		    	document.getElementById('wpcf_email_txt').value = 'Your Email Address:';
		    	document.getElementById('wpcf_website_txt').value = 'Your Website:';
		    	document.getElementById('wpcf_message_txt').value = 'Your Message:';
		    	document.getElementById('wpcf_cccopy_txt').value = 'Send me a copy of the message';
		    	document.getElementById('wpcf_required_txt').value = 'required';		    	
		    	document.getElementById('wpcf_spamcheck1_txt').value = 'The sum of';
		    	document.getElementById('wpcf_spamcheck2_txt').value = 'and';
		    	document.getElementById('wpcf_spamcheck3_txt').value = 'is:';
		    	document.getElementById('wpcf_sendbtn_txt').value = 'Submit';
		    	document.getElementById('wpcf_malicious_msg').value = 'You can not use any of the following in the Name or Email fields: a linebreak, or the phrases \'mime-version\', \'content-type\', \'cc:\' or \'to:\'.';
		    	return false;">English</a>
		    	&nbsp;-&nbsp;
		    	<a href="" onclick="document.getElementById('wpcf_subject').value = 'Contact Form Results';
		    	document.getElementById('wpcf_success_msg').value = 'Thanks for your comments!';
		    	document.getElementById('wpcf_error_msg').value = 'Please fill in the required fields.';
		    	document.getElementById('wpcf_yourname_txt').value = 'Votre nom ou pseudo:';
		    	document.getElementById('wpcf_email_txt').value = 'Votre adresse mail:';
		    	document.getElementById('wpcf_website_txt').value = 'Votre site ou blog &#233;ventuel:';
		    	document.getElementById('wpcf_message_txt').value = 'Votre message:';
		    	document.getElementById('wpcf_cccopy_txt').value = 'Je veux une copie de mon message par mail';
		    	document.getElementById('wpcf_required_txt').value = 'requis';		    	
		    	document.getElementById('wpcf_spamcheck1_txt').value = 'La somme de';
		    	document.getElementById('wpcf_spamcheck2_txt').value = 'et';
		    	document.getElementById('wpcf_spamcheck3_txt').value = 'donne:';
		    	document.getElementById('wpcf_sendbtn_txt').value = 'Envoyer';
		    	document.getElementById('wpcf_malicious_msg').value = 'Vous ne pouvez pas utiliser l%27un de ces &eacute;l&eacute;ments dans les champs du nom ou du mail&nbsp;: saut de ligne, mentions \'mime-version\', \'content-type\', \'cc:\' ou \'to:\'.';		    	
		    	return false;">French</a>
		    	&nbsp;-&nbsp;
		    	<a href="" onclick="document.getElementById('wpcf_subject').value = 'Contact Formulier Resultaten';
		    	document.getElementById('wpcf_success_msg').value = 'Bedankt voor je reactie!';
		    	document.getElementById('wpcf_error_msg').value = 'Alle verplichte velden invullen alstublieft.';
		    	document.getElementById('wpcf_yourname_txt').value = 'Uw naam:';
		    	document.getElementById('wpcf_email_txt').value = 'Uw Email Adres:';
		    	document.getElementById('wpcf_website_txt').value = 'Uw Website:';
		    	document.getElementById('wpcf_message_txt').value = 'Uw Bericht:';
		    	document.getElementById('wpcf_cccopy_txt').value = 'Stuur een kopie naar mijn eigen email adres';
		    	document.getElementById('wpcf_required_txt').value = 'verplicht';		    	
		    	document.getElementById('wpcf_spamcheck1_txt').value = 'De som van';
		    	document.getElementById('wpcf_spamcheck2_txt').value = 'en';
		    	document.getElementById('wpcf_spamcheck3_txt').value = 'is:';
		    	document.getElementById('wpcf_sendbtn_txt').value = 'Verzenden';
		    	document.getElementById('wpcf_malicious_msg').value = 'De volgende texten kunnen niet gebruikt worden in de Naam en Email velden: een linebreak, of de teksten \'mime-version\', \'content-type\', \'cc:\' of \'to:\'.';
		    	return false;">Dutch</a>
        <br />
<?php _e('Change all fields to selected language.', 'wpcf') ?></td>
      </tr>
		   
		    <tr valign="top">
        <th scope="row"><?php _e('"Your Name" Text:', 'wpcf') ?></th>
        <td><input name="wpcf_yourname_txt" type="text" id="wpcf_yourname_txt" value="<?php echo $wpcf_yourname_txt; ?>" size="50" />
        <br />
<?php _e('This will be the "Your Name" text in the contact form.', 'wpcf') ?></td>
      </tr>
      <tr valign="top">
        <th scope="row"><?php _e('"Email" Text:', 'wpcf') ?></th>
        <td><input name="wpcf_email_txt" type="text" id="wpcf_email_txt" value="<?php echo $wpcf_email_txt; ?>" size="50" />
        <br />
<?php _e('This will be the "Email Address" text in the contact form.', 'wpcf') ?></td>
      </tr>
      <tr valign="top">
        <th scope="row"><?php _e('"Website" Text:', 'wpcf') ?></th>
        <td><input name="wpcf_website_txt" type="text" id="wpcf_website_txt" value="<?php echo $wpcf_website_txt; ?>" size="50" />
        <br />
<?php _e('This will be the "Website" message in the contact form.', 'wpcf') ?></td>
      </tr>
      <tr valign="top">
        <th scope="row"><?php _e('"Message" Text:', 'wpcf') ?></th>
        <td><input name="wpcf_message_txt" type="text" id="wpcf_message_txt" value="<?php echo $wpcf_message_txt; ?>" size="50" />
        <br />
<?php _e('This will be the "Message" text in the contact form.', 'wpcf') ?></td>
      </tr>      
      <tr valign="top">
        <th scope="row"><?php _e('"CC Copy to" Text:', 'wpcf') ?></th>
        <td><input name="wpcf_cccopy_txt" type="text" id="wpcf_cccopy_txt" value="<?php echo $wpcf_cccopy_txt; ?>" size="50" />
        <br />
<?php _e('This will be the "CC Copy to" text in the contact form.', 'wpcf') ?></td>
      </tr>
      <tr valign="top">
        <th scope="row"><?php _e('"required" Text :', 'wpcf') ?></th>
        <td><input name="wpcf_required_txt" type="text" id="wpcf_required_txt" value="<?php echo $wpcf_required_txt; ?>" size="50" />
        <br />
<?php _e('text next to required name and email fields', 'wpcf') ?></td>
      </tr>
      <tr valign="top">
        <th scope="row"><?php _e('"Anti-Spam" Text :', 'wpcf') ?></th>
        <td><input name="wpcf_spamcheck1_txt" type="text" id="wpcf_spamcheck1_txt" value="<?php echo $wpcf_spamcheck1_txt; ?>" size="12" /><input name="wpcf_spamcheck2_txt" type="text" id="wpcf_spamcheck2_txt" value="<?php echo $wpcf_spamcheck2_txt; ?>" size="12" /><input name="wpcf_spamcheck3_txt" type="text" id="wpcf_spamcheck3_txt" value="<?php echo $wpcf_spamcheck3_txt; ?>" size="12" />
        <br />
<?php _e('This will be the anti-spam text in the contact form.', 'wpcf') ?></td>
      </tr>
      <tr valign="top">
        <th scope="row"><?php _e('"Send Button" Text:', 'wpcf') ?></th>
        <td><input name="wpcf_sendbtn_txt" type="text" id="wpcf_sendbtn_txt" value="<?php echo $wpcf_sendbtn_txt; ?>" size="50" />
        <br />
<?php _e('This will be the "Send Button" text in the contact form.', 'wpcf') ?></td>
      </tr>
	</table>

	<h3><?php _e('Options', 'wpcf') ?></h3>
	<table width="100%" cellpadding="5" class="form-table">
		<tr valign="top">
			<th width="30%" scope="row" style="text-align: left"><?php _e('Show \'Spam Prevention\' Option', 'wpcf') ?></th>
			<td>
				<input name="wpcf_show_spamcheck" type="checkbox" id="wpcf_show_spamcheck" value="wpcf_show_spamcheck"
				<?php if($wpcf_show_spamcheck == TRUE) {?> checked="checked" <?php } ?> />
			</td>
		</tr>
		<tr valign="top">
			<th width="30%" scope="row" style="text-align: left"><?php _e('Allow user to send himself a copy', 'wpcf') ?></th>
			<td>
				<input name="wpcf_cc_option" type="checkbox" id="wpcf_cc_option" value="wpcf_cc_option"
				<?php if($wpcf_cc_option == TRUE) {?> checked="checked" <?php } ?> />
			</td>
		</tr>
	</table>

    <p class="submit">
      <input type="submit" name="Submit" value="<?php _e('Update Options', 'wpcf') ?> &raquo;" />
    </p>
  </form>
</div>
