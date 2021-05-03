ArrayList<Card> cards;
Difficulty difficulty_level = Difficulty.VERY_EASY;
String[] image_links;
int link_index = 0;
int area_width, area_height;
boolean hidden = true, correct = false;
float input_countdown = 10;
float total_count_down = 1200;
float main_countdown = total_count_down;
int points = 0;

int card_index_1, card_index_2, card_index_3, card_index_4;

void setup() {
  //size(1920, 1080);
  fullScreen();
  area_width = (width / 2) - 50;
  area_height = height - 150;
  image_links = loadStrings("data/icons/links.txt");
  cards = CreateCards(difficulty_level.level);

  card_index_1 = card_index_2 = card_index_3 = card_index_4 = -1;
  print(width, height);
  LoadCards();
}

ArrayList<Card> CreateCards(int amount) {
  int symbolsPlaced = 0;
  int cardIndex = 0;
  ArrayList<Card> cards = new ArrayList<Card>();

  //set cards to new cards
  for (int i = 0; i < amount * (amount+1) + 1; i++) {
    cards.add(new Card());
  }

  IntList linksIndexs = IntList.fromRange(0, image_links.length);
  linksIndexs.shuffle();

  for (int i = 0; i < amount+1; i ++) {
    for (int j = 0; j < amount; j ++) {
      for (int k = 0; k < amount; k ++) {
        cardIndex = i == 0  ? j * amount + k : ((k*(i-1) +j) % amount) + (k * amount);
        cards.get(cardIndex).icon_names.add(image_links[linksIndexs.get(symbolsPlaced)]);
      }
      cards.get((amount*amount) + i).icon_names.add(image_links[linksIndexs.get(symbolsPlaced)]);
      symbolsPlaced++;
    }
  }

  for (int i = 0; i < amount+1; i ++) {
    cards.get((amount*amount) + i).icon_names.add(image_links[linksIndexs.get(symbolsPlaced)]);
  }

  return cards;
}

void draw() {
  background(51);


  strokeWeight(8);
  stroke(#252525);
  fill(#000000);
  rect(25, 25, area_width, area_height, 20);
  rect(width-(area_width+25), 25, area_width, area_height, 20);

  if (!hidden && main_countdown > 0) {
    cards.get(card_index_1).Show(1, (input_countdown > 0 && input_countdown < 2), correct);
    cards.get(card_index_2).Show(2, (input_countdown > 0 && input_countdown < 2), correct);
  } else if (hidden){
    fill(#6e6e6e);
    textSize(100);
    textAlign(CENTER, CENTER);
    text(card_index_3 != -1 ? "HIDDEN" : "LOADING", 25+area_width/2, area_height/2);
    text(card_index_4 != -1 ? "HIDDEN" : "LOADING", width-(area_width/2+25), area_height/2);
    textSize(25);
    fill(#9e9e9e);
    text(card_index_3 != -1 ? "click to reveal icons" : "please wait", 25+area_width/2, 75+area_height/2);
    text(card_index_4 != -1 ? "click to reveal icons" : "please wait", width-(area_width/2+25), 75+area_height/2);
  }

  if (input_countdown > 0 && input_countdown < 2) {
    input_countdown -= 0.5/frameRate;
    stroke(#252525);
    fill(#2e0000);
    rect(25 + area_width, 25, width - (area_width*2)-50, area_height, 20);
    fill(#008e4e);
    rect(25 + area_width, 25, width - (area_width*2)-50, area_height*map(input_countdown, 0, 1, 0.02, 1), 20);
  } else if (input_countdown <= 0) {
    LoadCards();
    input_countdown = 10;
  }

  textAlign(LEFT,CENTER);
  textSize(60);
  fill(#0e0e0e);
  text("Points: " + points, 25, height-100);

  //bottom bar
  stroke(#252525);
  fill(#2e0000);
  rect(25, height-50, width - 50, 40, 5);
  fill(#008e4e);
  rect(25, height-50, (width - 50) * map(main_countdown, 0, total_count_down, 0, 1), 40, 5);
  textSize(32);
  textAlign(LEFT);
  fill(#500050);
  text((main_countdown >= 3600 ? (nf(floor(main_countdown/3600),2,0) + ":") : "") + (main_countdown >= 60 ? (nf(floor(main_countdown/60),2,0) + ":") : "") + nf(floor(main_countdown%60),2,0),50,height-19);

  if (!hidden && main_countdown > 0) {
    main_countdown -= 1/frameRate;
  }
  
  //draw buttons
  textSize(40);
  strokeWeight(2);
  
  fill(difficulty_level == Difficulty.VERY_EASY ? #2f6f4f : 0);
  rect(350, height-113, 230, 50, 10);
  fill(255);
  text("VERY EASY",360,height-73);
  
  fill(difficulty_level == Difficulty.EASY ? #2f6f4f : 0);
  rect(585, height-113, 120, 50, 10);
  fill(255);
  text("EASY",595,height-73);
  
  fill(difficulty_level == Difficulty.MEDIUM ? #2f6f4f : 0);
  rect(710, height-113, 180, 50, 10);
  fill(255);
  text("MEDIUM",720,height-73);
  
  fill(difficulty_level == Difficulty.HARD ? #2f6f4f : 0);
  rect(895, height-113, 130, 50, 10);
  fill(255);
  text("HARD",905,height-73);
  
  fill(difficulty_level == Difficulty.VERY_HARD ? #2f6f4f : 0);
  rect(1030, height-113, 250, 50, 10);
  fill(255);
  text("VERY_HARD",1040,height-73);
  
  fill(difficulty_level == Difficulty.MENTAL ? #2f6f4f : 0);
  rect(1285, height-113, 180, 50, 10);
  fill(255);
  text("MENTAL",1295,height-73);
  
  fill(difficulty_level == Difficulty.INSANE ? #2f6f4f : 0);
  rect(1470, height-113, 170, 50, 10);
  fill(255);
  text("INSANE",1480,height-73);
  
  fill(difficulty_level == Difficulty.LUDUCRUS ? #2f6f4f : 0);
  rect(1645, height-113, 230, 50, 10);
  fill(255);
  text("LUDUCRUS",1655,height-73);
}

void keyPressed() {

  if (key == 'r') {
    reset();
  }
}

void reset(){
  cards = CreateCards(difficulty_level.level);
  points = 0;
  hidden = true;
  card_index_1 = card_index_2 = card_index_3 = card_index_4 = -1;
  LoadCards();
  main_countdown = total_count_down;
}

void mousePressed() {
  if (mouseX > 350 && mouseX < 580 && mouseY > height-113 && mouseY < height-63) {
    difficulty_level = Difficulty.VERY_EASY;
    reset();
  } else if (mouseX > 585 && mouseX < 705 && mouseY > height-113 && mouseY < height-63) {
    difficulty_level = Difficulty.EASY;
    reset();
  } else if (mouseX > 710 && mouseX < 885 && mouseY > height-113 && mouseY < height-63) {
    difficulty_level = Difficulty.MEDIUM;
    reset();
  } else if (mouseX > 890 && mouseX < 1025 && mouseY > height-113 && mouseY < height-63) {
    difficulty_level = Difficulty.HARD;
    reset();
  } else if (mouseX > 1030 && mouseX < 1280 && mouseY > height-113 && mouseY < height-63) {
    difficulty_level = Difficulty.VERY_HARD;
    reset();
  } else if (mouseX > 1285 && mouseX < 1465 && mouseY > height-113 && mouseY < height-63) {
    difficulty_level = Difficulty.MENTAL;
    reset();
  } else if (mouseX > 1470 && mouseX < 1640 && mouseY > height-113 && mouseY < height-63) {
    difficulty_level = Difficulty.INSANE;
    reset();
  } else if (mouseX > 1645 && mouseX < 1875 && mouseY > height-113 && mouseY < height-63) {
    difficulty_level = Difficulty.LUDUCRUS;
    reset();
  } else if (hidden) {
    hidden = false;
  } else  if (input_countdown > 2 && main_countdown > 0) {
    if (PVector.dist(new PVector(mouseX, mouseY), new PVector(cards.get(card_index_1).icon_positions.get(cards.get(card_index_1).correct).x + 25, cards.get(card_index_1).icon_positions.get(cards.get(card_index_1).correct).y + 25)) < difficulty_level.packAmount/2) {
      correct = true;
      points ++;
    } else if (PVector.dist(new PVector(mouseX, mouseY), new PVector(cards.get(card_index_2).icon_positions.get(cards.get(card_index_2).correct).x + width-(area_width+25), cards.get(card_index_2).icon_positions.get(cards.get(card_index_2).correct).y + 25)) < difficulty_level.packAmount/2) {
      correct = true;
      points ++;
    } else {
      correct = false;
    }
    input_countdown = 1;
  }
}

void LoadCards() {

  if (card_index_1 != -1 && card_index_2 != -1) {
    cards.get(card_index_1).UnloadIcons();
    cards.get(card_index_2).UnloadIcons();
  }

  if (card_index_3 != -1 && card_index_4 != -1) {
    card_index_1 = card_index_3;
    card_index_2 = card_index_4;
    card_index_3 = -1;
    card_index_4 = -1;
  } else {
    card_index_1 = int(random(1)*cards.size());
    while (true) {
      card_index_2 = int(random(1)*cards.size());
      if (card_index_1 != card_index_2)
        break;
    }
    cards.get(card_index_1).LoadIcons(1);
    cards.get(card_index_2).LoadIcons(2);
    card_index_3 = -1;
    card_index_4 = -1;
  }
  thread("loadBackingImages");
}
