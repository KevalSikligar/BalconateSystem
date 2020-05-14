<?php get_header(); ?>
<?php get_sidebar(); ?>
<div id="content">
<div class="spacer"></div>
	<?php if (have_posts()) : while (have_posts()) : the_post(); ?>
			<div id="post-<?php the_ID(); ?>" class="post">
				<div class="post_top">
					<div class="posttitle"><a href="<?php the_permalink() ?>" rel="bookmark" title="Permanent Link to <?php the_title_attribute(); ?>"><h1><?php the_title(); ?></h1></a></div>
				</div>
				<div class="entry">
						<?php the_content('more...'); ?><div class="clear"></div>
						<?php wp_link_pages(array('before' => '<p><strong>Pages:</strong> ', 'after' => '</p>', 'next_or_number' => 'number')); ?>
				</div>	
				<div class="post_bottom"></div>
			</div>
	<?php endwhile; endif; ?>
	<?php edit_post_link('Edit this entry.', '<p>', '</p>'); ?>
</div>



<?php get_footer(); ?>