import 'dart:math';

enum HuntState { fighting, victory, defeat }
enum HuntAction { attack, guard, special, potion }

class HuntEngine {
  final Random random;
  int stage = 1;
  int turns = 0;
  int hp = 100;
  int monsterHp = 45;
  int stamina = 3;
  int potions = 3;
  int score = 0;
  int coins = 0;
  bool guarded = false;
  HuntState state = HuntState.fighting;
  String message = 'The hunt begins!';
  HuntEngine({Random? random}) : random = random ?? Random();

  int get monsterMaxHp => 30 + stage * 15;
  bool get active => state == HuntState.fighting;
  bool canUse(HuntAction action) {
    if (!active) return false;
    switch (action) {
      case HuntAction.attack:
      case HuntAction.guard:
        return true;
      case HuntAction.special:
        return stamina >= 3;
      case HuntAction.potion:
        return potions > 0 && hp < 100;
    }
  }

  bool takeTurn(HuntAction action) {
    if (!canUse(action)) return false;
    guarded = false;
    switch (action) {
      case HuntAction.attack:
        monsterHp = max(0, monsterHp - 16);
        stamina = min(5, stamina + 1);
        message = 'Sword slash: 16 damage.';
        break;
      case HuntAction.guard:
        guarded = true;
        stamina = min(5, stamina + 2);
        message = 'You brace for the next attack.';
        break;
      case HuntAction.special:
        stamina -= 3;
        monsterHp = max(0, monsterHp - 38);
        message = 'Power strike: 38 damage.';
        break;
      case HuntAction.potion:
        potions--;
        hp = min(100, hp + 28);
        message = 'Potion restores health.';
        break;
    }
    turns++;
    if (monsterHp == 0) {
      score += 100 * stage + hp;
      coins += 10 * stage;
      if (stage == 5) {
        state = HuntState.victory;
        message = 'All monsters defeated! Hunt complete.';
      } else {
        stage++;
        monsterHp = monsterMaxHp;
        stamina = min(5, stamina + 2);
        if (stage.isOdd) potions++;
        message = 'Monster defeated! Stage $stage begins.';
      }
      return true;
    }

    // Guard absorbs half the incoming hit. Seeded RNG enables repeatable tests.
    final rawDamage = 8 + stage * 2 + random.nextInt(5);
    final damage = guarded ? (rawDamage + 1) ~/ 2 : rawDamage;
    hp = max(0, hp - damage);
    message += ' Monster dealt $damage damage.';
    if (hp == 0) {
      state = HuntState.defeat;
      message = 'The hunter has fallen. Try again.';
    }
    return true;
  }

  void restart() {
    stage = 1;
    turns = 0;
    hp = 100;
    monsterHp = monsterMaxHp;
    stamina = 3;
    potions = 3;
    score = 0;
    coins = 0;
    guarded = false;
    state = HuntState.fighting;
    message = 'The hunt begins!';
  }
}
