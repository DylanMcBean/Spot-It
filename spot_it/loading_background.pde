void loadBackingImages(){
  if (card_index_3 == -1){
    int maybe_index_3;
    while (true) {
      maybe_index_3 = int(random(1)*cards.size());
      if (card_index_1 != maybe_index_3 && card_index_2 != maybe_index_3)
        break;
    }
    cards.get(maybe_index_3).LoadIcons(3);
    card_index_3 = maybe_index_3;
  }
  
  if (card_index_4 == -1){
    int maybe_index_4;
    while (true) {
      maybe_index_4 = int(random(1)*cards.size());
      if (card_index_1 != maybe_index_4 && card_index_2 != maybe_index_4 && card_index_3 != maybe_index_4)
        break;
    }
    cards.get(maybe_index_4).LoadIcons(4);
    card_index_4 = maybe_index_4;
  }
}
