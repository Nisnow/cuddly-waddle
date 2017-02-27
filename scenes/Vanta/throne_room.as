
#include "../backend/pair.as"
#include "../backend/float.as"

entity vanta;

[start]
void start()
{
	//temporary
	//set_position(get_player(), vec(4.5, 10));
	set_direction(get_player(), direction::up);
	set_position(get_player(), vec(4.5, 19));
	
	entity tDarkness = add_entity("dark_texture", "darkness");
	set_position(tDarkness, vec(4.5, 21));
	set_depth(tDarkness, 0);
}

[start]
void create_vanta()
{
	vanta = add_entity("vanta", "default:default");
	set_position(vanta, vec(4.5, 2.5));
	set_depth(vanta, 1);
	start_animation(vanta);
	
	do{
		float_entity(vanta, 0.3, 1);
	}while(yield());
}

void create_window(vec pPosition)
{
	//windows will be animated later
	entity window1 = add_entity("window", "rain");
	set_position(window1, pPosition);
	set_depth(window1, fixed_depth::below);
	start_animation(window1);
}

[start]
void create_windows()
{
	create_window(vec(3.5, 2));
	create_window(vec(5.5, 2));
}

entity create_lightning(vec pPosition)
{
	entity wLight = add_entity("window_lightning_short", "flash");
	set_position(wLight, pPosition);
	set_depth(wLight, fixed_depth::overlay);
	return wLight;
}

void do_thunder()
{
	wait(random(1, 3));
	float s = random(1, 3);
	if(s == 1)
		fx::sound("thunder1", 40);
	if(s == 2)
		fx::sound("thunder2", 40);
}

[start]
void do_lightning() {
  entity leftLight  = create_lightning(vec(3.5, 2));
	entity rightLight = create_lightning(vec(5.5, 2));
  
  float t;
  float r;
  
  do {
    
    t = random(5, 17);
    
    wait(t);
    
    stop_animation(leftLight);
    stop_animation(rightLight);
    
    dprint(formatFloat(t));
    start_animation(leftLight);
    start_animation(rightLight);

	//do_thunder();
    
    r = random(2, 17);
    
    if(r < 4) {
      wait(r * .5);
      dprint(formatFloat(r));
      stop_animation(leftLight);
      stop_animation(rightLight);
      
      start_animation(leftLight);
      start_animation(rightLight);
	  
	  //do_thunder();
	  
    }
    
  } while(yield());
}

void create_column(vec pPosition)
{
	entity column1 = add_entity("dungeon","pillar");
	set_position(column1, pPosition);
}

[start]
void create_columns()
{
	create_column(vec(2.5, 6.75));
  create_column(vec(6.5, 6.75));
	create_column(vec(2.5, 8.75));
	create_column(vec(6.5, 8.75));
}

pair create_darkness(vec pPosition, float pSeparation)
{
	pair darkness (add_entity("dark_light_up", "dark"), pSeparation);
	darkness.set_position(pPosition);
	darkness.set_depth(0);
	return darkness;
}

pair create_torch_pair(vec pPosition, float pSeparation)
{
	pair torches (add_entity("torch", "torch"), pSeparation);
	torches.set_position(pPosition);
	return torches;
}

array<pair> torches(3);
array<pair> darks(3);

[start]
void create_torches()
{
	for(int k = 0; k < 3; k++)
	{
		torches[k] = create_torch_pair(vec(3.5, (k*2) + 11), 2);
		darks[k] = create_darkness(vec(3.5, (k*2) + 11), 2);
	}
	
	pair throne_torches = create_torch_pair(vec(2.5, 3.5), 4);
	entity throne_darks = create_darkness(vec(2.5, 3.5), 4);
	
	throne_torches.set_atlas("light");
	throne_darks.set_atlas("flicker");
	
	throne_torches.start_animation();
	thonre_darks.start_animation();
	
	set_depth_fixed(throne_torches.get_left(), false);
	set_depth_fixed(throne_torche.get_right(), false);
}

void light_torch(int k)
{
	player::lock(true);
	torches[k].set_atlas("ignite");
	
	darks[k].set_atlas("light");
	
	torches[k].start_animation();
	
	darks[k].start_animation();
	
	wait(0.80);
	
	player::lock(false);
}

void animate_torch(int k)
{
	torches[k].set_atlas("light");
	
	darks[k].set_atlas("flicker");
  
	torches[k].start_animation();
	
	darks[k].start_animation();
}

[group step2]
void light_torch2()
{
	once_flag("torch2");
	
	light_torch(2);
	animate_torch(2);
	
}

[group step1]
void light_torch1()
{
	once_flag("torch1");

	light_torch(1);
	animate_torch(1);	
	
}

[group step0]
void light_torch0()
{
	once_flag("torch0");
	
	light_torch(0);
	animate_torch(0);
	
}

[group vanta]
void vanta_black()
{
	once_flag("potatoes");
	player::lock(true);
	
	wait(1);
	start_animation(get_player());
	pathfind_move(get_player(), vec(4.5, 5), 1.5, 0);
	stop_animation(get_player());
	set_direction(get_player(), direction::up);
	
	wait(1);
	
	//initial sprite of vanta is of them sitting on the throne
	focus::move(get_position(vanta), 2);
	
	narrative::set_speaker(vanta);
	set_atlas(vanta, "talk");
	say("Hello.");
	say("I've waited very long for \nyou to arrive.");
	
	narrative::clear_speakers();
	narrative::set_speed(1);
	fsay("\n...");
	
	wait(1);
	
	narrative::set_interval(30);
	narrative::set_speaker(vanta);
	//set_atlas(vanta, "talk_squint");
	fsay("Why the incredulous look, \nchild?");
	
	wait(2);
	fsay("Do you not remember me?");
	int opt = select("I remember you!", "Who are you?");
	if(opt == 0)
	{
		set_flag("remembered"); 
		//set expression to calm 
		fsay("Yes, yes. Of course you do.");
		wait(0.5);
	}
	else if(opt == 1)
	{
		set_flag("forgotten");
		//set expression to annoyed
		fsay("Don't play the fool, \nignorant child!");
		wait(0.25);
	}
	
	say("Everyone in the Void knows \nof me.");
	say("For it is I...");
	
	move(vanta, vec(4.5, 1.75), 1);
	//change sprite 
	wait(1);
	fsay("THE GREAT");
	wait(1);
	//thunder and lightning; make sure to show lightning first then thunder
	
	fsay("VANTA");
	wait(1);
	say("BLACK!");
	
	//more thunder+lightning and battle commence
	
	narrative::end();
	
	player::lock(false);
	
	focus::move(get_position(get_player()), 1);
	focus::player();
	/*
	also add expressions in narrative box
	
	*/

}

[group vanta_talk]
void talk_to_vanta()
{
	player::lock(true);
	
	focus::move(get_position(vanta), 2);
	
	narrative::set_speaker(vanta);
	set_atlas(vanta, "talk");
	
	fsay("I swear...");
	wait(1);
	
	say("I will defeat you one day!");
	
	narrative::end();
	
	focus::move(get_position(get_player()), 1);
	focus::player();
	
	player::lock(false);
}

