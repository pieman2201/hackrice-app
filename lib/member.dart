class Member {
  String name;
  num aerobicMinutes;
  num strengthMinutes;
  num userID;

  num get totalMinutes {
    return aerobicMinutes + strengthMinutes;
  }

  Member([this.name, this.aerobicMinutes, this.strengthMinutes, this.userID]);
}