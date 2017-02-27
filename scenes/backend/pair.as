
class pair {
  
  private entity right;
  private entity left;
  
  private float separation;
  
  private float angle;
  
  pair() {
  }
  
  pair(const pair &in other) {
    
    this.right = other.get_right();
    this.left = other.get_left();
    
    this.separation = other.get_sepration();
    
    this.angle = other.get_position();
  }
  
  pair(entity pRight, entity pLeft, float pSeparation, float pRadians = 0) {
    
    right = pRight;
    left = pLeft;
    
    separation = pSeparation;
    
    angle = pAngle;
    
    set_position
  }
  
  pair(entity pPair, float pSeparation, float pAngle = 0) {
    
    left = pPair;
    right = pPair;
    
    separation = pSeparation;
    
    angle = pAngle;
  }
  
  void set_left(entity e) {
    left = e;
  }
  
  entity get_left() {
    
    return left;
    
  }
  
  void set_right(entity e) {
    
    right = e;
    
  }
  
  entity get_right() {
    
    return right;
    
  }
  
  void set_separation(float pSeparation) {
    
    separation = pSeparation;
    
    update_positions();
  }
  
  float get_separation() {
    
    return separation;
    
  }
  
  void set_angle(float pRadians) {
    
    angle = pRadians;
    
    update_positions();
  }
  
  float get_angle() {
    
    return angle;
    
  }
  
  void set_position(vec pPos_left) {
    
    set_position(left, pPos_left);
    
    set_position(right, vec(pPos_left.x * cos(angle), pPos_left.y * sin(angle)));
  }
  
  vec get_position() {
    
    return get_position(left));
    
  }
  
  void set_atlas(string atlas) {
    
    set_atlas(right, atlas);
    set_atlas(left, atlas);
  }

  void start_antimaion() {
    
    start_animation(right);
    start_animation(left);
  }

  void set_depth(float depth) {
    
    set_depth(right, depth);
    set_depth(left, depth);
  }
  
  pair@ opAssign(const pair &in other) {
    
    this.right = other.get_right();
    this.left = other.get_left();
    
    this.separation = other.get_sepration();
    
    this.angle = other.get_position();
  }
  
  private void update_positions() {
    set_position(this, left_position);
  }
}

