public enum Difficulty {
    VERY_EASY(5,200), 
    EASY(7,180), 
    MEDIUM(13,160), 
    HARD(17,140), 
    VERY_HARD(29,120), 
    MENTAL(37,100), 
    INSANE(59,90),
    LUDUCRUS(83,70);

  public final int level, packAmount;

  private Difficulty(int level, int packAmount) {
    this.level = level;
    this.packAmount = packAmount;
  }
}
