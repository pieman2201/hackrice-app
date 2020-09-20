import 'package:calorie_tracker/member.dart';

class Group {
  String name;
  List<Member> members;

  void addMember(Member member) {
    members.add(member);
  }

  Group([this.name, this.members]);

  int getAerobicPlacement(Member member) {
    var membersSorted = List.from(members)
      ..sort((b, a) => a.aerobicMinutes.compareTo(b.aerobicMinutes));
    return membersSorted.indexOf(member) + 1;
  }

  int getStrengthPlacement(Member member) {
    var membersSorted = List.from(members)
      ..sort((b, a) => a.strengthMinutes.compareTo(b.strengthMinutes));
    return membersSorted.indexOf(member) + 1;
  }

  int getTotalPlacement(Member member) {
    var membersSorted = List.from(members)
      ..sort((b, a) => a.totalMinutes.compareTo(b.totalMinutes));
    return membersSorted.indexOf(member) + 1;
  }
}
