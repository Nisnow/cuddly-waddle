
// Cool effect
[start]
void create_side_fades()
{
	entity fade_left = add_entity("fade", "fade_left");
	set_anchor(fade_left, anchor::topleft);
	make_gui(fade_left, 0);
	set_position(fade_left, vec(-1, 0));
	
	entity fade_right = add_entity("fade", "fade_right");
	set_anchor(fade_right, anchor::topright);
	make_gui(fade_right, 0);
	set_position(fade_right, pixel(get_display_size().x, 0) + vec(1, 0));
}

void add_bush(vec pPosition)
{
	entity bush = add_entity("forest", "bush");
	set_position(bush, pPosition);
}

[start]
void create_bushes()
{
	add_bush(vec(2.5, 5.5));
	add_bush(vec(4.5, 7.5));
	add_bush(vec(2.5, 10.5));
	add_bush(vec(4.5, 13.5));
	add_bush(vec(4.5, 16.5));
	add_bush(vec(2.5, 17.5));
	add_bush(vec(4.5, 20.5));
	add_bush(vec(2.5, 23.5));
	add_bush(vec(2.5, 24.5));
}

[group thing]
void boo()
{
	once_flag("aseryahdg");
	scoped_entity guy = add_character("someguy");
	set_position(guy, vec(2.5, 13.3));
	move(guy, direction::right, 2, speed(3));
}

entity billy;

[start]
void create_billy()
{
	if (has_flag("billy_asdfsadf"))
		return;
	billy = add_character("someguy");
	set_position(billy, vec(3.5, 6.5));
	set_color(billy, 0, 0, 0);
}

[group thing2]
void thing2()
{
	once_flag("billy_asdfsadf");
	player::lock(true);
	
	const vec player_billy_mp = midpoint(get_position(get_player()), get_position(billy));
	
	// Cool wind effect
	{
		fx::sound("wind1", 20);
		scoped_entity leaves = add_entity("leavesinwind");
		set_position(leaves, player_billy_mp);
		start_animation(leaves);
		focus::move(player_billy_mp, 2);
	}
	
	set_atlas(billy, "talk");
	
	narrative::set_speaker(billy);
	say("My my.");
	say("Do you have a scared?");
	fx::sound("billylaugh1", 50);
	fsay("HEH HEH HEH HEH");
	nl("DON'T BE!");
	fsay("We will have");
	fappend(" LOTS");
	wait(0.6);
	fappend(" of");
	wait(0.3);
	append(" FUN.");
	
	say("Come with me.");
	narrative::hide();
	
	move(billy, direction::up, 1, speed(3));
	wait(0.6);
	say("This way.");
	narrative::end();
	
	move(billy, direction::up, 2, speed(3));
	remove_entity(billy);
	
	focus::move(get_position(get_player()), 1);
	focus::player();
	player::lock(false);
}

[start]
void start()
{
	set_position(get_player(), vec(3.5, 34.5));
	set_direction(get_player(), direction::up);
	music::open("doodle89");
}
