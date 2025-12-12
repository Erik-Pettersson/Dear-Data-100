class Drink {
  
  public boolean active = false;
  public long timestamp = 0;
  
  public String date, time, name, type, container;
  private color liquidColor;
  
  public PhysicsBody body;

  public Drink(String date, String time, String name, String type, String container) {
    this.date = date;
    this.time = time;
    this.name = name;
    this.type = type;
    this.container = container;
    
    parseDate();
    determineColor();
    createHitbox();
  }
  
  private void parseDate() {
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm"); 
    try {
      Date d = sdf.parse(date + " " + time);
      this.timestamp = d.getTime();
    } catch (Exception e) { 
      System.out.println("Error parsing date: " + date + " " + time);
    }
  }

  private void createHitbox() {
    if (container.equals("Water Bottle")) body = new PhysicsBody(35, 90);
    else if (container.equals("Plastic Bottle")) body = new PhysicsBody(40, 100);
    else if (container.equals("Can")) body = new PhysicsBody(35, 65);
    else if (container.equals("Mug")) body = new PhysicsBody(50, 45); 
    else if (container.equals("Glass")) body = new PhysicsBody(35, 55);
    else body = new PhysicsBody(45, 75); 
  }
  
  private void determineColor() {
    if (type.equals("Water")) liquidColor = color(100, 200, 255);
    else if (type.equals("Caffeine")) liquidColor = color(80, 50, 30);
    else if (type.equals("Chocolate")) liquidColor = color(100, 60, 40);
    else if (type.equals("Shake")) liquidColor = color(255, 182, 193);
    else if (type.equals("Soda")) liquidColor = color(200, 60, 60);
    else if (type.equals("Tea")) liquidColor = color(160, 110, 60);
    else if (type.equals("Juice")) liquidColor = color(255, 165, 0);
    else if (type.equals("Alcohol")) liquidColor = color(220, 200, 50);
    else liquidColor = color(180);
  }
  
  public boolean isHovered() {
    return mouseX > body.x && mouseX < body.x + body.w && 
           mouseY > body.y && mouseY < body.y + body.h;
  }
  
  public void drawDrink() {
    pushMatrix();
    translate(body.x, body.y);
    
    if (isHovered()) {
      stroke(255, 255, 0); 
      strokeWeight(3);
    } else {
      stroke(0);
      strokeWeight(2);
    }
    
    if (container.equals("Water Bottle")) drawWaterBottle();
    else if (container.equals("Plastic Bottle")) drawPlasticBottle();
    else if (container.equals("Can")) drawCan();
    else if (container.equals("Mug")) drawMug();
    else drawGenericCup();
    
    popMatrix();
  }
  
  public void drawTooltip() {
    pushMatrix();
    
    float tipX = mouseX + 15;
    float tipY = mouseY;
    if (tipX + 200 > width) tipX = mouseX - 210;
    if (tipY + 110 > height) tipY = height - 110;
    
    translate(0,0); 
    
    fill(0, 240); 
    stroke(255);
    strokeWeight(1);
    rect(tipX, tipY, 200, 110);
    
    noStroke(); 
    fill(255);
    textAlign(LEFT, TOP);
    text("Name: " + name, tipX + 10, tipY + 10);
    text("Type: " + type, tipX + 10, tipY + 30);
    text("Container: " + container, tipX + 10, tipY + 50);
    text("Date: " + date, tipX + 10, tipY + 70);
    text("Time: " + time, tipX + 10, tipY + 90);
    
    popMatrix();
  }

  private void drawWaterBottle() {
    fill(liquidColor); 
    rect(0, 15, body.w, body.h-15);         
    fill(30, 30, 80); 
    rect(body.w*0.25, 0, body.w*0.5, 15);   
  }

  private void drawPlasticBottle() {
    fill(liquidColor); 
    rect(0, 10, body.w, body.h-10);         
    fill(255); 
    rect(0, body.h*0.4, body.w, 25);        
    fill(200, 50, 50); 
    rect(body.w*0.25, 0, body.w*0.5, 10);   
  }

  private void drawCan() {
    fill(liquidColor); 
    rect(0, 5, body.w, body.h-5);           
    fill(200); 
    rect(0, 0, body.w, 5);                  
  }

  private void drawMug() {
    fill(liquidColor); 
    rect(0, 0, body.w-10, body.h);          
    fill(200); 
    rect(body.w-10, 10, 10, 25);            
  }

  private void drawGenericCup() {
    fill(liquidColor); 
    rect(0, 0, body.w, body.h);
  }
}
