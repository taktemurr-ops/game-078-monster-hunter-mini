import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_078_monster_hunter_mini/game/hunt_engine.dart';

void main() {
  group('HuntEngine', () {
    test('starts with consistent stage and resources', () {
      final g = HuntEngine(random: Random(1));
      expect(g.stage, 1);
      expect(g.monsterHp, 45);
      expect(g.hp, 100);
      expect(g.canUse(HuntAction.potion), false);
    });
    test('attack reduces monster health, builds stamina and advances turn', () {
      final g = HuntEngine(random: Random(2));
      expect(g.takeTurn(HuntAction.attack), true);
      expect(g.monsterHp, 29);
      expect(g.stamina, 4);
      expect(g.turns, 1);
      expect(g.hp, lessThan(100));
    });
    test('special requires stamina and costs exactly three', () {
      final g = HuntEngine(random: Random(3));
      expect(g.takeTurn(HuntAction.special), true);
      expect(g.stamina, 0);
      expect(g.monsterHp, 7);
      expect(g.takeTurn(HuntAction.special), false);
      expect(g.turns, 1);
    });
    test('guard halves damage and never exceeds stamina cap', () {
      final a = HuntEngine(random: Random(4));
      final b = HuntEngine(random: Random(4));
      a.takeTurn(HuntAction.guard);
      b.takeTurn(HuntAction.attack);
      expect(100 - a.hp, lessThan(100 - b.hp));
      expect(a.stamina, 5);
    });
    test('potion heals without exceeding max and consumes stock', () {
      final g = HuntEngine(random: Random(5));
      g.hp = 90;
      expect(g.takeTurn(HuntAction.potion), true);
      expect(g.potions, 2);
      expect(g.hp, lessThanOrEqualTo(100));
    });
    test('killing a monster grants rewards and starts the next stage', () {
      final g = HuntEngine(random: Random(6));
      g.monsterHp = 10;
      expect(g.takeTurn(HuntAction.attack), true);
      expect(g.stage, 2);
      expect(g.monsterHp, 60);
      expect(g.coins, 10);
      expect(g.score, greaterThan(100));
    });
    test('fifth stage victory locks actions', () {
      final g = HuntEngine(random: Random(7));
      g.stage = 5;
      g.monsterHp = 10;
      expect(g.takeTurn(HuntAction.attack), true);
      expect(g.state, HuntState.victory);
      expect(g.takeTurn(HuntAction.attack), false);
    });
    test('defeat and restart restore game', () {
      final g = HuntEngine(random: Random(8));
      g.hp = 1;
      expect(g.takeTurn(HuntAction.attack), true);
      expect(g.state, HuntState.defeat);
      expect(g.takeTurn(HuntAction.guard), false);
      g.restart();
      expect(g.state, HuntState.fighting);
      expect(g.hp, 100);
      expect(g.stage, 1);
      expect(g.score, 0);
    });
  });
}
