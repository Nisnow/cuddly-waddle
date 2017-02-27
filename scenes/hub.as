#include "spoop/entities/spoopy.as"

entity spoop;
entity vanta;
entity billy;

[start]
void start() {
  set_position(get_player(), vec(5.5, 100));
  
  narrative::set_skip(false);
  say("So, you wish to challenge me?");
  append("\nVery well.");
  say("But I will have to test you\nfirst.");
  say("If you can defeat my minions,\nI will face you.");
  say("Until you have proven yourself,\ndo not return.");
  narrative::end();
  fx::fade_out(.1);
  player::lock(false);
  
  set_position(get_player(), vec(5.5, 2.7));
  
  spoop = make_spoopy(vec(5.5, 7.7), "back_up");
  
  vanta = add_entity("vanta");
  billy = add_entity("someguy");
  
  set_position(vanta, vec(8.5, 4.7));
  set_position(billy, vec(2.5, 4.7));
  
  set_atlas(vanta, "default:left");
  set_atlas(billy, "default:right");
  
  wait(2);
  fx::fade_in(3);
}

[start]
void make_circle() {
  group::enable("circle", false);
  entity circle;
  if(has_flag("spoopy") && has_flag("vanta") && has_flag("billy")) {
    
    group::enable("circle", true);
  } else {
    circle = add_entity("hub", "circle");
  }
  set_position(circle, vec(5.5, 3));
  set_depth(circle, fixed_depth::background);
}

[group circle]
void the_end() {
  narrative::set_skip(false);
  set_position(get_player(), vec(5.5, 100));
  say("Well done.");
  say("I guess I have to keep my promise\nnow, don't I?");
  say("Ho ho! This will be fun.");
  //to final boss scene(s)
  narrative::end();
  player::lock(false);
}

[group spooper]
void talk_spoop() {
  narrative::set_speaker(spoop);
  narrative::set_skip(false);
  narrative::set_speed(13);
  fsay("So you think you can best me?");
  switch(select("Yes", "No")) {
    case option::first:
      create_thread(function(args) {fx::fade_out(3);});
      fsay("We shall see.");
      wait(3);
      load_scene("spoop/room1");
      break;
    case option::second:
      say("Of course not.");
      break;
    default:
  }
  narrative::end();
  player::lock(false);
}

[group the_king?]
void talk_vanta() {
  narrative::set_speaker(vanta);
  fsay("Do you dare to defeat the \nalmighty Vanta?");
  switch(select("Yes", "No")) {
    case option::first:
      say("En garde!");
      load_scene("Vanta/dark_room");
      break;
    case option::second:
      say("How pathetic.");
      break;
    default:
  }
  narrative::end();
  player::lock(false);
}

[group bill]
void talk_billy() {
  narrative::set_speaker(billy);
  fsay("Does he wish to challenge Billy?");
  switch(select("Yes", "No")) {
    case option::first:
      say("Ohohohoho!");
      say("Billy has an excited!");
      load_scene("billy/start");
      break;
    case option::second:
      say("Billy has a dissapoint.");
      break;
    default:
  }
  narrative::end();
  player::lock(false);
}

