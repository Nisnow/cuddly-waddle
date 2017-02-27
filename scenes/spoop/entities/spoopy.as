#include "../../backend/float.as"

entity make_spoopy(vec pPos, string atlas = "default:default", bool pFloat = true) {
  entity spoop = add_entity("spoopy");
  set_position(spoop, pPos);
  set_atlas(spoop, atlas);
  if(pFloat)
    create_thread(function(args) {
      float_entity(spoop, .05, 1.5, -1);
    });
  return spoop;
}

