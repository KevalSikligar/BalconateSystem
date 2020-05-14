<?php get_header(); ?>
<?php get_sidebar(); ?>
<div id="content">
	<div class="spacer"></div>
<?php 
	if (have_posts()) : while (have_posts()) : the_post(); ?>
			<div id="post-<?php the_ID(); ?>" class="post">
				<div class="post_top">
					<div class="posttitle"><a href="<?php the_permalink() ?>" rel="bookmark" title="<?php the_title_attribute(); ?>"><h1><?php the_title(); ?></h1></a></div>
					<br>
					<div class="author">Author: <?php the_author_posts_link('nickname'); ?><?php edit_post_link(' &raquo Edit &laquo',' | ',''); ?></div>
					<div class="date">&bull; <?php the_time('l, F dS, Y') ?></div>
				</div>
				<br>
      <div style="padding:0; margin:0;width:150px;">
          <table cellpadding=0 border=0 valign="top">
          <tr>
          
					
          <td valign="top" width="20px" align="left">
          <a rel="nofollow" target="_blank" href="http://www.twitter.com/balconysystems"><img border="0" src="http://twitter-badges.s3.amazonaws.com/t_mini-b.png" alt="Follow us on Twitter" title="Follow us on Twitter"/></a>        
          </td>
          <td valign="top" width="16px" align="left">
          <a rel="nofollow" target="_blank" title="Save to Google Bookmarks" href="http://www.google.com/bookmarks/mark?op=edit&amp;bkmk=http://www.balconette.co.uk&amp;title=Balcony Systems" style="text-decoration:none;"><img border=0 src="http://balconette.co.uk/blog/wp-content/themes/3d-realty/images/gglshare1.jpg" alt="Save to Google Bookmarks" title="Save to Google Bookmarks"></a>
					</td>
					<td valign="top" width="5px">
          &nbsp;
					</td>
				  <td valign="center">
          
          <a rel="nofollow" name="fb_share" type="button" href="http://www.facebook.com/sharer.php">Share</a><script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script>
					</td>
          	</tr>
					  
					
					</table>
          </div>
				<div class="entry">
					<?php  the_content('more...'); ?><div class="clear"></div>
					<?php wp_link_pages(array('before' => '<div><strong><center>Pages: ', 'after' => '</center></strong></div>', 'next_or_number' => 'number')); ?>
				</div>	
				<div class="info"><span class="category">Category: <?php the_category(', ') ?></span>
					<?php  the_tags('&nbsp;|&nbsp;<span class="tags">Tags: ', ', ', '</span>')?>
				</div>
				<div class="post_bottom"></div>
			</div>


		<div id="postmetadata">
			You can follow any responses to this entry through the <?php comments_rss_link('RSS 2.0'); ?> feed. 
			<?php if (('open' == $post-> comment_status) && ('open' == $post->ping_status)) { // Both Comments and Pings are open ?>
						You can <a href="#respond">leave a response</a>, or <a href="<?php trackback_url(); ?>" rel="trackback">trackback</a> from your own site.
			<?php }elseif(!('open' == $post-> comment_status) && ('open' == $post->ping_status)) {	// Only Pings are Open ?>
						Responses are currently closed, but you can <a href="<?php trackback_url(); ?> " rel="trackback">trackback</a> from your own site.
			<?php }elseif(('open' == $post-> comment_status) && !('open' == $post->ping_status)){	// Comments are open, Pings are not ?>
						You can skip to the end and leave a response. Pinging is currently not allowed.
			<?php } elseif (!('open' == $post-> comment_status) && !('open' == $post->ping_status)) {	// Neither Comments, nor Pings are open ?>
						Both comments and pings are currently closed.
			<?php } 
					edit_post_link('Edit this entry.','',''); 
			?>
		</div>

	<div id="comments"><?php comments_template(); ?></div>
		
		<?php endwhile; ?>
		<div class="navigation">
				<div class="alignleft"><?php previous_post_link('&laquo; %link') ?></div>
				<div class="alignright"><?php next_post_link('%link &raquo;') ?></div>
		</div>
	<?php else : ?>
		<h1>Not found</h1>
		<p class="sorry">"Sorry, but you are looking for something that isn't here. Try something else.</p>
	<?php endif; ?>
</div>
<?php get_footer();?>