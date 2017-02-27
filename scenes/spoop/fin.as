#include "entities/spoopy.as"

entity spoop;
entity clar;

[start]
void start() {
  spoop = make_spoopy(vec(.5, -2), "back_up");
  
  set_position(get_player(), vec(.5, 11));
  set_direction(get_player(), direction::up);
}

[start]
void the_eye() {
  clar = add_entity("clarissa");
  set_depth(clar, fixed_depth::below);
  set_anchor(clar, anchor::left);
  set_position(clar, vec(-1.64, -4.1));
}

