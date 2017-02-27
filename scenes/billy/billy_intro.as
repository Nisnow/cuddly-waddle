

entity fade_left;
entity fade_right;

[start]
void create_side_fades()
{
	const float distance = .45;
	fade_left = add_entity("fade", "fade_left");
	set_anchor(fade_left, anchor::topleft);
	make_gui(fade_left, 0);
	set_position(fade_left, vec(-distance, 0));
	
	fade_right = add_entity("fade", "fade_right");
	set_anchor(fade_right, anchor::topright);
	make_gui(fade_right, 0);
	set_position(fade_right, pixel(get_display_size().x, 0) + vec(distance, 0));
}

void add_bush(vec pPosition)
{
	entity bush = add_entity("forest", "bush");
	set_position(bush, pPosition);
}


void add_tree(vec pPosition)
{
	entity tree = add_entity("forest", "tree");
	set_position(tree, pPosition);
}

[start]
void create_bushes()
{
	add_bush(vec(1.5, 8.5));
	add_bush(vec(2.5, 7.5));
	add_bush(vec(5.5, 8.5));
	add_bush(vec(5.5, 6.5));
	add_bush(vec(6.5, 5.5));
	add_bush(vec(0.5, 5.5));
	add_bush(vec(3.5, 4.5));
	add_bush(vec(6.5, 3.5));
	add_bush(vec(2.5, 2.5));
}

entity billy;

[start]
void create_billy()
{
	billy = add_character("someguy");
	set_position(billy, vec(3.5, 6.5));
	set_direction(billy, direction::down);
	set_color(billy, 0, 0, 0);
}

[group billy]
void introduce_billy()
{
	player::lock(true);
	
	focus::move(midpoint(get_position(get_player()), get_position(billy)), 1);
	
	set_atlas(billy, "talk");
	narrative::set_speaker(billy);
	say("You made it!");
	say("I has introduce myself!");
	narrative::hide();
	
	entity clone1 = add_character("billyclones");
	set_position(clone1, vec(2.5, 7.4));
	set_color(clone1, 0, 0, 0);
	move(clone1, vec(3, 6.5), speed(2));
	set_direction(clone1, direction::down);
	
	entity clone2 = add_character("billyclones");
	set_position(clone2, vec(5.5, 6.4));
	set_color(clone2, 0, 0, 0);
	move(clone2, vec(4, 6.5), speed(2));
	set_direction(clone2, direction::down);
	
	
	say("I have...");
	
	fx::sound("heh");
	music::stop();
	
	set_color(billy, 255, 255, 255);
	set_color(clone1, 255, 255, 255);
	set_color(clone2, 255, 255, 255);
	
	set_atlas(clone1, "dance");
	set_atlas(clone2, "dance");
	start_animation(clone1);
	start_animation(clone2);
	
	remove_entity(fade_left);
	remove_entity(fade_right);
	
	say("A BILLY!");
	
	music::open("doodle90");
	
	stop_animation(clone1);
	stop_animation(clone2);
	set_atlas(clone1, "talk");
	set_atlas(clone2, "talk");
	
	say("I have a very happy to see\nsomeone new.");
	say("No soul other than WE down\nhere...");
	
	say("[this scene is work in progress, not complete yet\ni will eat all your children and destroy th\ne world with turtles and blow things up an\nd things and things and things and things and things\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA]");
	
	narrative::end();
	
	
	focus::move(get_position(get_player()), 1);
	focus::player();
	player::lock(false);
	
	group::enable("billy", false);
}

[start]
void create_trees()
{
	// Todo
}

[start]
void start()
{
	set_position(get_player(), vec(3.5, 16.5));
	set_direction(get_player(), direction::up);
	music::open("doodle89");
}

