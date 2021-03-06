#include "entities/spoopy.as"

entity spoop;
entity alpa;
array<entity> magic;
bool do_spin = true;

[start]
void start() {
  set_position(get_player(), vec(7.5, 22));
  set_flag("normal_text");
}

[start]
void tension() {
  if(has_flag("alpa_ded")) {
    group::enable("alpa", false);
  } else {
    spoop = make_spoopy(vec(18.5, 6.8), "back_up_talk");
    set_depth(spoop, 0);
    
    alpa = add_entity("vanta");
    set_depth(alpa, 1000);
    set_position(alpa, vec(18.5, 3.5));
  }
}

[start]
void stupid_magic_function_thingy_because_spinning_is_hard() {
  for(int i = 0; i < 3; i ++) {
    magic.insertLast(add_entity("void_ball"));
    set_visible(magic[i], false);
    set_depth(magic[i], 30);
    set_anchor(magic[i], anchor::center);
  }
  
  const float pFreq = 3;
  
  float w = 360 * pFreq;
  float theta = 0;
  
  do {
    theta += w * get_delta();
    for(int i = 0; i < 3; i++) {
      set_rotation(magic[i], theta);
    }
    yield();
  } while(do_spin);
}

[group magical]
void magic_sign() {
  say("This is a magic sign!");
  if(has_flag("normal_text")) {
    say("Text is now slower!");
    unset_flag("normal_text");
  } else {
    say("Text is now boring again!");
    set_flag("normal_text");
  }
  narrative::end();
  player::lock(false);
}

/*[group spoop]
void spoop() {
  
  player::lock(true);
  
  narrative::set_skip(false);
  
  vec pl_pos = get_position(get_player());
  vec mid = vec(get_position(spoop).x, pl_pos.y);
  
  set_direction(get_player(), direction::up);
  
  wait(1.5);
  focus::move(mid, 1.1 * pl_pos.distance(mid));
  
  wait(1);
  focus::move(get_position(spoop), 3);
  
  narrative::set_speaker(spoop);
  set_atlas(spoop, "talk_blank");
  say("...Hmm?");
  wait(.7);
  
  say("Oh.\n");
  wait(1);
  append("One of them managed to get out.");
  narrative::hide();
  
  wait(.7644);
  
  say("Well.");
  wait(.75);
  
  narrative::clear_speakers();
  say("\n");
  narrative::set_speed(1);
  append("... ");
  
  if(has_flag("normal_text"))
    narrative::set_interval(30);
  
  narrative::set_speaker(spoop);
  say("I guess I should take care of\nthis.");
  wait(1.5);
  narrative::end();
  
  wait(1);
  entity battle = add_entity("battle!!");
  set_anchor(battle, anchor::center);
  set_depth(battle, fixed_depth::overlay);
  set_position(battle, focus::get() + vec(0, 1));
  wait(5);
  remove_entity(battle);
  
  focus::move(mid, .15 * mid.distance(focus::get()));
  focus::move(get_position(get_player()), .15 * pl_pos.distance(mid));
  focus::player();
  group::enable("spoop", false);
  //remove_entity(spoopy);
  narrative::set_skip(true);
  player::lock(false);
}*/

[group alpa]
void alpa_v_spoop() {
  
  player::lock(true);
  
  narrative::set_skip(false);
  
  vec pl_pos = get_position(get_player());
  vec mid = vec(get_position(spoop).x, pl_pos.y);
  vec final = midpoint(get_position(spoop), get_position(alpa)) + vec(0, .5);
  
  set_direction(get_player(), direction::left);
  
  wait(.5);
  focus::move(mid, .5 * pl_pos.distance(mid));
  
  wait(1);
  focus::move(final, 2);
  
  wait(.5);
  
  set_position(magic[0], vec(18.5, get_position(alpa).y - 1.5));
  set_visible(magic[0], true);
  
  narrative::set_speaker(alpa);
  say("Release them!");
  
  narrative::hide();
  
  set_depth(magic[0], 255);
  move(magic[0], get_position(spoop) + vec(0, -.3), .5);
  
  narrative::set_speaker(spoop);
  wait(.5);
  
  say("Heh heh heh.");
  say("You really thought you could\ndefeat me with such an assault?");
  say("How incredibly hilarious.");
  say("Unfortuantely for you, it falls\na bit short of the mark.");
  narrative::hide();
  
  {
   vec target = get_position(alpa) + vec(0, -.5);
   speed s_shot = speed(get_position(spoop).distance(get_position(alpa))/.15);
   
   move(magic[0], target, s_shot);
   
   wait(.5);
   
   set_position(magic[1], get_position(spoop) + vec(-2, .5));
   wait(.1);
   set_position(magic[2], get_position(spoop) + vec(2, .5));
   
   set_visible(magic[1], true);
   wait(.25);
   set_visible(magic[2], true);
   
   wait(.5);
   
   for(int i = 1; i < 3; i++) {
     set_depth(magic[i], 0);
     move(magic[i], target, s_shot);
   }
   
   say("Now, you will die.");
   narrative::hide();
   
   for(int i =0; i < 5; i++) {
     set_position(magic[1], get_position(spoop) + vec(-2, .5));
     set_position(magic[2], get_position(spoop) + vec(2, .5));
     move(magic[1], target, s_shot);
     move(magic[2], target, s_shot);
   }
  }
  
  //death animation
  remove_entity(alpa);
  
  do_spin = false;
  
  for(int i = 0; i < 3; i++) {
    remove_entity(magic[i]);
  }
  
  wait(1);
  
  say("Hmph.");
  
  narrative::set_skip(true);
  narrative::end();
  
  set_atlas(spoop, "back_up");
  start_animation(spoop);
  
  create_thread(function(args)
  {
    move(spoop, vec(18.5, -15), speed(2));
  });
  
  wait(3);
  
  focus::move(mid, .15 * mid.distance(focus::get()));
  focus::move(get_position(get_player()), .15 * pl_pos.distance(mid));
  focus::player();
  set_flag("alpa_ded");
  group::enable("alpa", false);
  player::lock(false);
}

[group to_spoop]
void to_spoop() {
  if(is_triggered(control::menu)) {
    set_position(get_player(), vec(23, 9));
  }
}

[group skip_thing]
void skipp() {
  if(is_triggered(control::menu)) {
    set_position(get_player(), get_position(spoop));
  }
}

[group fin]
void finalee() {
  load_scene("spoop/fin");
}

