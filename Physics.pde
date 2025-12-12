class PhysicsBody {
  
  float x, y, w, h;
  float speed = 12; 
  boolean frozen = false;
  
  PhysicsBody(float w, float h) {
    this.w = w;
    this.h = h;
  }
  
  void setPosition(float x, float y) {
    this.x = x;
    this.y = y;
  }
 
  void update(Drink[] allDrinks, int myIndex) {
    if (frozen) return;

    y += speed;

    if (x < 0) x = 0;
    if (x + w > width) x = width - w;
    if (y + h >= height) {
      y = height - h;
      frozen = true; 
      return;
    }

    for (int i = 0; i < allDrinks.length; i++) {
      if (i == myIndex || !allDrinks[i].active) continue;
      PhysicsBody other = allDrinks[i].body;
      if (rectOverlap(other)) {
        handleCollision(other);
      }
    }
  }
  
  boolean rectOverlap(PhysicsBody other) {
    return x < other.x + other.w && 
           x + w > other.x && 
           y < other.y + other.h && 
           y + h > other.y;
  }
  
  void handleCollision(PhysicsBody other) {
    float centerDiff = (x + w/2) - (other.x + other.w/2);
    
    if (abs(centerDiff) < 20) {
       y = other.y - h; 
       frozen = true;   
    } 
    else {
       if (centerDiff > 0) x += 5;
       else x -= 5;
    }
  }
}
