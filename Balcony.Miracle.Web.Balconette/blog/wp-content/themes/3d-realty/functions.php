<?php 
if(function_exists('register_sidebar')){
		register_sidebar(array(
		'before_widget' => '<li><div id="%1$s" class="widget %2$s">',
		'after_widget' => '</div></li>',
		'before_title' => '<h2>',
		'after_title' => '</h2>'));
		
		function unregister_problem_widgets() {
			unregister_sidebar_widget('search');
			unregister_sidebar_widget('tag_cloud');
		}
		add_action('widgets_init','unregister_problem_widgets');
}
//change the tag cloud
function widget_cloud($args) {
	global $wpdb, $post;
	extract($args);
	include(TEMPLATEPATH . '/sidebar/tagcloud.php');
}
register_sidebar_widget('Tag Cloud', 'widget_cloud');

function menu_separator($input){
	$tmp = explode("</li>", $input);
	array_pop($tmp);
	$tmp = implode("</li><li class=\"separator\"></li>",$tmp)."</li>";
	return $tmp;
}
?>