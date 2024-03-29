=== Plugin Name ===
Contributors: joedolson
Donate link: http://www.joedolson.com/donate.php
Tags: twitter, microblogging, cligs, bitly, yourls, redirect, shortener, post, links
Requires at least: 2.7
Tested up to: 2.9.2
Stable tag: trunk

Posts a Twitter status update when you update your WordPress blog or post to your blogroll, using your chosen URL shortening service.

== Description ==

The WP-to-Twitter plugin posts a Twitter status update from your WordPress blog using either the Cli.gs or Bit.ly URL shortening services to provide a link back to your post from Twitter. 

For both services you can provide your information to maintain a list of your shortened URLs with your URL shortening service for statistics and your own records.

The plugin can send a default message for updating or editing posts or pages, but also allows you to write a custom Tweet for your post which says whatever you want. By default, the shortened URL from Cli.gs is appended to the end of your message, so you should keep that in mind when writing your custom Tweet. 

Any status update you write which is longer than the available space will automatically be truncated by the plugin. This applies to both the default messages and to your custom messages.

WP to Twitter can also post to any other service using the Twitter-compatible API.

Credits:

Although it now bears very little resemblance to the original sources, this plugin was originally based on the Twitter Updater plugin by [Jonathan Dingman](http://www.firesidemedia.net/dev/), which he adapted from a plugin by Victoria Chan. Other contributions by [Thor Erik](http://www.thorerik.net), Bill Berry and [Andrea Baccega](http://www.andreabaccega.com). Thanks to [Cory LaViska](http://abeautifulsite.net/notebook/71) for PHP 4 compatible `json_decode` and `json_encode`. Thanks to [Michal Migurski](http://mike.teczno.com) for authoring the JSON class. Other bug fixes and related citations can be found in the changelog.

Translations:

* Italian: [Gianni Diurno](http://www.gidibao.net)
* German: [Melvin](http://www.toxicavenger.de/)
* Spanish: [David Gil P&eacute;rez](http://www.sohelet.com)

== Changelog ==

= 2.0.2 =

* Bug fixed where appended text was placed before hash tags.
* Added method for error messages to be automatically cleared following a successful status update. It seems a lot of people couldn't find the button to clear errors, and thought they were getting an error every time.
* Moved short URL selection option to a more prominent location.

= 2.0.1 = 

* Bug found with YOURLS short url creation when using multiple sites with one YOURLS installation and short URLS are created using post ID. Added option to disable post_ID as shortURL generating key in YOURLS account settings.
* Missing semicolon replaced in uninstall.php

= 2.0.0 = 

* Fixed bug introduced in WordPress 2.9 where logged in users could only edit their own profiles and associated issues.
* Fixed bug which caused #url# to repeatedly be added to the end of tweet texts on reactivation or upgrade.
* Fixed bug which generated shortener API error messages when no URL shortener was used.
* Fixed bug which prevented display of URL on edit screen if no URL shortener was used.
* Added Spanish translation courtesy of [David Gil P&eacute;rez](http://www.sohelet.com)
* Made so many language changes that aforementioned translation is now terribly out of date, as are all others...
* Added ability to restrict posting to certain categories.
* Added option to dynamically generate Google Analytics campaign identifier by category, post title, author, or post id.
* Added option to configure plugin to use other services using the Twitter-compatible API.
* Added support for YOURLS installations as your URL shortener. (Either local or remote.)
* Redesigned administrative interface.
* Removed use of Snoopy and alternate HTTP request methods.
* Discontinued support for WordPress versions below version 2.7.
* Major revisions to support checks.
* Version jumped to 2.0.0

= 1.5.7 = 

* Quick bug fix contributed by DougV from WordPress Forums.

= 1.5.6 = 

* WP 2.9 added support for JSON on PHP versions below 5.2; changes made to do WP version checking before adding JSON support.
* Stripslashes added to viewable data fields.
* Added option for spaces to be removed in hashtags.
* A few post meta updates.
* Barring major disasters, this will be the last release in the 1.x series. Expect version 2 sometime in late January.

= 1.5.5 =

* Fixed issue with stray hashtags appearing when Tweeting edited posts was disabled and adding hashtags was enabled.
* Added shortcode (#date#) for post date. Uses your WordPress date settings to format date, but allows you to customize for WP to Twitter.

= 1.5.4 = 

* Fixed issue with spaces in hashtags. 
* Added configurable replacement character in hashtags.

= 1.5.3 = 

* Revised the function which checks whether your Tweet is under the 140 character limit imposed by Twitter. This function had a number of awkward bugs which have now (hopefully) been eradicated.
* Revised the tags->hashtags generation for better reliability. Fixes bugs with failing to send hashtags to Twitter if they haven't been saved and allowing hashtags on scheduled posts.
* Option to use WP default URL as a short URL. (http://yourdomain.com/yourblog/?p=id).

= 1.5.2 = 

* Minor code cleanup
* Fixed uncommon bug where draft posts would not tweet when published.
* Fixed bug where #title# shortcode wouldn't work due to prior URL encoding. (Also covers some other obscure bugs.) Thanks to [Daniel Chcouri](http://www.anarchy.co.il) for the great catch.
* Added new shortcode (#category#) to fetch the first post category.
* Provided a substitute function for hosts not supportin mb_substr().
* Fixed a bug where a hashtag would be posted on edits when posting updates was not enabled for edits.
* Put Cli.gs change revisions on hold barring updates from Pierre at Cli.gs

= 1.5.1 =

* Because that's what I get for making last minute changes.

= 1.5.0 =

* Due to a large number of problems in the 1.4.x series, I'm launching a significant revision to the base code earlier than initially planned. This is because many of these features were already in development, and it's simply too much work to maintain both branches of the code.
* Added option to export settings in plain text for troubleshooting.
* Simplified some aspects of the settings page.
* Added custom text options for WordPress Pages to match support for Posts.
* Improved tags as hashtags handling.
* Added the ability to use custom shortcodes to access information in custom fields.
* Improved some error messages to clarify certain issues.

= 1.4.11 =

* Fixed a bug which allowed editing of posts to be tweeted if status updates on editing Pages were permitted.
* Fixed a bug in the support check routine which caused all Cli.gs tests to fail.
* Streamlined logic controlling whether a new or edited item should be tweeted.
* Added Italian translation. Thanks to [Gianni Diurno](http://www.gidibao.net)!

= 1.4.10 =

* Was never supposed to exist, except that I *forgot* to include a backup function.

= 1.4.9 =

* Added German translation. Thanks to [Melvin](http://www.toxicavenger.de/)!
* Fixed a bug relating to missing support for a function or two.
* Fixed a bug relating to extraneous # symbols in tags

= 1.4.8 =

* Adds a function to provide PHP5s str_split functionality for PHP4 installations.

= 1.4.7 = 

* Actually resolves the bug which 1.4.6 was supposed to fix.

= 1.4.6 =

* Hopefully resolved bug with empty value for new field in 1.4.5. It's late, so I won't know until tomorrow...

= 1.4.5 =

* Resolved bug with extraneous hash sign when no tags are attached.
* Resolved bug where #url# would appear when included in posting string but with 'link to blog' disabled.
* Added expansion of short URL via longURL.org stored in post meta data.
* Resolved additional uncommon bug with PHP 4.
* Added option to incorporate optional post excerpt.
* Better handling of multibyte character sets. 

= 1.4.4 =

* Resolved two bugs with hashtag support: spaces in multi-word tags and the posting of hashtag-only status updates when posting shouldn't happen.

= 1.4.3 = 

* Resolved plugin conflict with pre-existing function name.

= 1.4.2 =

* No changes, just adding a missing file from previous commit.

= 1.4.1 =

* Revised to not require functions from PHP 5.2
* Fixed bug in hashtag conversion

= 1.4.0 =

* Added support for the Bit.ly URL shortening service.
* Added option to not use URL shortening.
* Added option to add tags to end of status update as hashtag references.
* Fixed a bug where the #url# shortcode failed when editing posts.
* Reduced some redundant code.
* Converted version notes to new Changelog format.

= 1.3.7 = 

* Revised interface to take advantage of features added in versions 2.5 and 2.7. You can now drag and drop the WP to Twitter configuration panel in Post and Page authoring pages.
* Fixed bug where post titles were not Tweeted when using the "Press This" bookmarklet
* Security bug fix.

= 1.3.6 =

*Bug fix release.

= 1.3.5 =

* Bug fix: when "Send link to Twitter" is disabled, Twitter status and shortcodes were not parsed correctly.

= 1.3.4 = 

* Bug fix: html tags in titles are stripped from tweets
* Bug fix: thanks to [Andrea Baccega](http://www.andreabaccega.com), some problems related to WP 2.7.1 should be fixed. 
* Added optional prepend/append text fields.

= 1.3.3 =

* Added support for shortcodes in custom Tweet fields.
* Bug fix when #url# is the first element in a Tweet string.
* Minor interface changes.

= 1.3.2 =

* Added a #url# shortcode so you can decide where your short URL will appear in the tweet.
* Couple small bug fixes.
* Small changes to the settings page.

= 1.3.1 = 

* Modification for multiple authors with independent Twitter accounts -- there are now three options:
 
	1. Tweet to your own account, instead of the blog account. 
	1. Tweet to your account with an @ reference to the main blog account. 
	1. Tweet to the main blog account with an @ reference to your own account.  
	
* Added an option to enable or disable Tweeting of Pages when edited. 
* **Fixed scheduled posting and posting from QuickPress, so both of these options will now be Tweeted.**

= 1.3.0 = 

*Support for multiple authors with independent Twitter & Cligs accounts. 
*Other minor textual revisions, addition of API availability check in the Settings panel. 
*Bugfixes: If editing a post by XMLRPC, you could not disable tweeting your edits. FIXED. 

= 1.2.8 =

*Bug fix to 1.2.7.

= 1.2.7 =

*Uses the Snoopy class to retrieve information from Cligs and to post Twitter updates. Hopefully this will solve a variety of issues.
*Added an option to track traffic from your Tweeted Posts using Google Analytics (Thanks to [Joost](http://yoast.com/twitter-analytics/))

= 1.2.6 =

*Bugfix with XMLRPC publishing -- controls to disable XMLRPC publishing now work correctly.
*Bugfix with error reporting and clearing.
*Added the option to supply an alternate URL along with your post, to be tweeted in place of the WP permalink.

= 1.2.5 =
 
*Support for publishing via XMLRPC 
*Corrected a couple minor bugs 
*Added internationalization support
 
= 1.2.0 =
 
*option to post your new blogroll links to Twitter, using the description field as your status update text.
*option to decide on a post level whether or not that blog post should be posted to Twitter
*option to set a global default 'to Tweet or not to Tweet.'

= 1.1.0 =

*Update to use cURL as an option to fetch information from the Cli.gs API.

== Installation ==

1. Upload the `wp-to-twitter` folder to your `/wp-content/plugins/` directory
2. Activate the plugin using the `Plugins` menu in WordPress
3. Go to Settings > WP->Twitter
4. Adjust the WP->Twitter Options as you prefer them. 
5. Supply your Twitter username and login.
6. **Optional**: Provide your Cli.gs API key ([available free from Cli.gs](http://cli.gs)), if you want to have statistics available for your URL.
7. That's it!  You're all set.

== Frequently Asked Questions ==

= Do I have to have a Twitter.com account to use this plugin? =

Yes, you need an account with Twitter to use this plugin.

= Do I have to have a Cli.gs/Bit.ly account to use this plugin? =

A Cli.gs account is entirely optional. Without an API from Cli.gs, a "public" Clig will be generated. The redirect will work just fine, but you won't be able to access statistics on your Clig. Bit.ly does require an API key and username, however.
Regardless, you don't need to have an account with either service to make effective use of the WP to Twitter plugin.

= Twitter goes down a lot. What happens if it's not available? =

If Twitter isn't available, you'll get a message telling you that there's been an error with your Twitter status update. The Tweet you were going to send will be saved in your post meta fields, so you can grab it and post it manually if you wish.

= What if Cli.gs or Bit.ly aren't available when I make my post? =

If your URL shortening service isn't available, your tweet will be sent using it's normal post permalink. You'll also get an error message letting you know that there was a problem contacting Cli.gs or Bit.ly.

= Why do my Twitter status updates show up labeled as "From WP to Twitter"? =

Twitter.com allows API applications to register themselves with the service, so they can provide information about the source of your Tweet. WP to Twitter is a registered user agent with Twitter.com. The same effect is seen if you use any other registered Twitter client.

= What if my server doesn't support the methods you use to contact these other sites? =

Well, there isn't much I can do about that - but the plugin will check and see whether or not the needed methods work. If they don't, you will find a warning message on your settings page. 

= If I mark a blogroll link as private, will it be posted to Twitter? =

No. They're private. 

= I can't see the settings page! =

There was once an unresolved bug which effected some servers causing the WP-to-Twitter settings page to fail. I haven't heard a report of this problem for quite a while, so I believe it's gone, but if it *does* show up again, you can get around the problem by commenting out approximately lines 191 - 256 in wp-to-twitter/wp-to-twitter-manager.php. (Version 1.4.0.) . (These numbers change from version to version, but there are comments in the code to help you out.)

= Scheduled posting doesn't work. What's wrong? =

Only posts which you scheduled or edited *after* installing the plugin will be Tweeted. Any future posts written before installing the plugin will be ignored by WP to Twitter.

== Upgrade Notice ==

Versions 2.0.0 and above of WP to Twitter are not compatible with WordPress versions lower than 2.7. Do not upgrade if you are using an older version of WordPress.

== Screenshots ==

1. WP to Twitter main settings page.
2. WP to Twitter custom Tweet settings.
3. WP to Twitter user settings.