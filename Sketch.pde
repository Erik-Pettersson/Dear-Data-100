import java.util.Arrays;
import java.util.Comparator;
import java.util.Date;
import java.text.SimpleDateFormat;

int DROP_INTERVAL = 200;   
float SPAWN_Y = -150;     

Table table;
Drink[] drinks;
int nextDrinkIndex = 0;
int lastDropTime = 0;

void setup() {
  size(1280, 720);
  stroke(0);
  strokeWeight(2); 
  textSize(14);    
  
  loadAndSortData();
}

void draw() {
  background(50); 
  
  attemptToDropDrink();

  Drink hoveredDrink = null;
  
  for (int i = 0; i < drinks.length; i++) {
    if (drinks[i].active) {
      drinks[i].body.update(drinks, i);
      drinks[i].drawDrink();
      
      if (drinks[i].isHovered()) {
        hoveredDrink = drinks[i];
      }
    }
  }
  
  if (hoveredDrink != null) {
    hoveredDrink.drawTooltip();
  }
}

void attemptToDropDrink() {
  if (millis() - lastDropTime > DROP_INTERVAL && nextDrinkIndex < drinks.length) {
    drinks[nextDrinkIndex].active = true;
    nextDrinkIndex++;
    lastDropTime = millis();
  }
}

void loadAndSortData() {
  table = loadTable("data.csv", "header");
  drinks = new Drink[table.getRowCount()];
  int rowCount = 0;
  
  for (TableRow row : table.rows()) {
    String date = row.getString("Date");
    String time = row.getString("Time");
    String drink = row.getString("Drink");
    String type = row.getString("Type");
    String container = row.getString("Container");
    
    drinks[rowCount] = new Drink(date, time, drink, type, container);
    
    float startX = random(50, width - 80);
    drinks[rowCount].body.setPosition(startX, SPAWN_Y);
    
    rowCount++;
  }
  
  Arrays.sort(drinks, new Comparator<Drink>() {
    public int compare(Drink d1, Drink d2) {
      return Long.compare(d1.timestamp, d2.timestamp);
    }
  });
}
