class Card {

  public ArrayList<String> icon_names;
  ArrayList<PImage> icons;
  ArrayList<PVector> icon_positions;
  ArrayList<Float> icon_rotations;
  int correct = -1;

  Card() {
    icon_names = new ArrayList<String>();
  }

  void Show(int location,boolean highlight, boolean answered_correct) {
    imageMode(CENTER);
    for(int i = 0; i < icons.size(); i++){
      pushMatrix();
      translate(icon_positions.get(i).x+ (location == 1 ? 25 : width-(area_width+25)), icon_positions.get(i).y+25);
      rotate(icon_rotations.get(i));
      image(icons.get(i),0,0,map(icons.get(i).width,0,100,0,difficulty_level.packAmount),map(icons.get(i).height,0,100,0,difficulty_level.packAmount));
      if (i == correct && highlight) {
        stroke(answered_correct ? 0 : 255,answered_correct ? 255 : 0,0);
        fill(answered_correct ? 0 : 255,answered_correct ? 255 : 0,0,100);
        ellipse(0,0,difficulty_level.packAmount,difficulty_level.packAmount); 
      }
      popMatrix();
    }
  }

  void LoadIcons(int side) {
    icons = new ArrayList<PImage>();
    icon_positions = new ArrayList<PVector>();
    icon_rotations = new ArrayList<Float>();
    int fails = 0;

    for (String icon : icon_names) {
      while (true) {
        try {
          icons.add(loadImage(icon));
          if (side == 2 && cards.get(card_index_1).icon_names.contains(icon)){
            correct = icon_names.indexOf(icon);
            cards.get(card_index_1).correct = cards.get(card_index_1).icon_names.indexOf(icon);
          } else if (side == 4 && cards.get(card_index_3).icon_names.contains(icon)){
            correct = icon_names.indexOf(icon);
            cards.get(card_index_3).correct = cards.get(card_index_3).icon_names.indexOf(icon);
          }
          break;
        } 
        catch (Exception e) {
          println(e);
        }
      }
      
      while (true) {
        PVector possible_position = new PVector(random(60,area_width-70),random(60,area_height-70));
        boolean overlap = false;
        
        for (PVector p : icon_positions){
          if (PVector.dist(p,possible_position) < difficulty_level.packAmount) {
            overlap = true;
            break;
          }
        }
        
        if (!overlap){
          icon_positions.add(possible_position);
          icon_rotations.add(random(TWO_PI));
          break; 
        }
        
        if (fails > 100){
          LoadIcons(side);
        }
      }
    }
  }

  void UnloadIcons() {
    icons = null;
  }
}
