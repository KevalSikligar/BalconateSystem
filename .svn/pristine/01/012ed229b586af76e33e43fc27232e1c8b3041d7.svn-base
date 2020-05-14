<?php // Do not delete these lines
if (!empty($_SERVER['SCRIPT_FILENAME']) && 'comments.php' == basename($_SERVER['SCRIPT_FILENAME']))
	die ('Please do not load this page directly. Thanks!');

if (!empty($post->post_password)) { // if there's a password
	if ($_COOKIE['wp-postpass_' . COOKIEHASH] != $post->post_password) {  // and it doesn't match the cookie 
?>
		<p class="nocomments">This post is password protected.</p>
<?php 
		return;
	}
}

//$oddcomment = 'alt'; /* This variable is for alternating comment background */ 
?>

<!-- You can start editing here. -->
<?php 
	if ($comments) : //check normal comment except trackback and pingback
?>
		<p class="commenttitle"><?php comments_number('No Responses', 'One Response', '% Responses');?></p>
		
		<ol class="commentlist">
			<?php $count = 0; 
				foreach ($comments as $comment) : 
					if (get_comment_type() == "comment") : $count++; 
			?>
						<li id="comment-<?php comment_ID() ?>"<?php 
							if(($comment->comment_author_email == get_the_author_email()) && ($comment->user_id != 0) ){
								echo ' class="adminbody"><div class="adminhead">';
							}else{
								echo ' class="commentbody"><div class="commenthead">';
							}
								echo get_avatar( $comment, 32 );
					?>
								<div class="commentcount"><?php echo $count; ?></div>
								<span class="authorlink"><?php comment_author_link() ?></span>&nbsp;<?php comment_type('', '(via Trackback)', '(via Pingback)'); ?>
								<span class=""><?php edit_comment_link('&raquo Edit &laquo'); ?></span>
					<?php 
								if ($comment->comment_approved == '0') : 
					?>
									<em>(Your comment is awaiting moderation)</em>
					<?php 
								endif;
					?>
								<br />
								<a class="commentlink" href="#comment-<?php comment_ID() ?>" title=""><?php comment_date('l, j. F Y','avenue') ?></a>
							</div>
						<?php comment_text() ?>
						</li>

				<?php 
						//if ('alt' == $oddcomment) $oddcomment = ''; else $oddcomment = 'alt'; /* Changes every other comment to a different class */ 
					endif; 
				endforeach; /* end for each comment */ ?>
		</ol>

<?php 
	else : // if($comments)====this is displayed if there are no comments so far
		if ('open' == $post-> comment_status) :
			//If comments are open, but there are no comments.
		else : //got comments but now comments are closed
?>
			<p class="nocomments">Comments are closed.</p>
<?php 
		endif;
	endif;
?>


<?php 
if($comments) :  //check trackback and pingback
?>
	<ol class="commentlist">
<?php 
		foreach ($comments as $comment) : 
			if((get_comment_type() == "trackback") || (get_comment_type() == "pingback")) : 
				$count++;
?>
				<li class="trackbody" id="comment-<?php comment_ID() ?>">
					<div class='trackhead'>
						<div class="commentcount"><?php echo $count; ?></div>
						<span class="authorlink"><?php comment_author_link() ?></span>&nbsp;<?php comment_type('', '(via Trackback)', '(via Pingback)'); ?>
						<span class=""><?php edit_comment_link(' &raquo Edit &laquo'); ?></span>
						<br />
						<a class="commentlink" href="#comment-<?php comment_ID() ?>" title=""><?php comment_date('l, j. F Y','avenue') ?></a>
					</div>
					<?php comment_text() ?>
				</li>

<?php 
				//if ('alt' == $oddcomment) $oddcomment = ''; else $oddcomment = 'alt';  /* Changes every other comment to a different class */  

			endif; 
		endforeach; /* end for each comment */ 
?>
	</ol>
<?php 
else : // this is displayed if there are no comments so far
	if ('open' == $post->comment_status) : 
		else : // comments are closed
	endif; 
endif;
?>


<?php 
	if ('open' == $post-> comment_status) : 
?>
		<strong id="respond">Leave a Reply</strong>

<?php 
		if ( get_option('comment_registration') && !$user_ID ) : 
?>
			<p class="login">You must be logged in to post a comment.</p>
<?php 
		else : 
?>
			<form action="<?php echo get_option('siteurl'); ?>/wp-comments-post.php" method="post" id="commentform">
<?php 
				if ( $user_ID ) :
?>		
					<p>Logged in as <a href="<?php echo get_option('siteurl'); ?>/wp-admin/profile.php"><?php echo $user_identity; ?></a>. <a href="<?php echo get_option('siteurl'); ?>/wp-login.php?action=logout" title="Log out of this account">Log out &raquo;</a></p> 
<?php 				
				else : 
?>
					<p><input type="text" name="author" id="author" value="<?php echo $comment_author; ?>" size="22" tabindex="1" />
						<label for="author"><small>Name&nbsp;<?php if ($req) echo "(required)"; ?></small></label></p>
					<p><input type="text" name="email" id="email" value="<?php echo $comment_author_email; ?>" size="22" tabindex="2" />
						<label for="email"><small>E-Mail (will not be published <?php if ($req) echo ", required)"; ?></small></label></p>
					<p><input type="text" name="url" id="url" value="<?php echo $comment_author_url; ?>" size="22" tabindex="3" />
						<label for="url"><small>Website (optional)</small></label></p>
				<?php endif; ?>

<!--<p><small><strong>XHTML:</strong> You can use these tags:&nbsp;<?php echo allowed_tags(); ?></small></p>-->

				<p><textarea name="comment" id="comment" cols="50" rows="8" tabindex="4"></textarea></p>
				<p><input name="submit" type="submit" id="submit" tabindex="5" value="Submit" />
				<input type="hidden" name="comment_post_ID" value="<?php echo $id; ?>" /></p>
				<?php do_action('comment_form', $post->ID); ?>
			</form>
<?php 
		endif; // If registration required and not logged in 

	endif; // if you delete this the sky will fall on your head 
?>