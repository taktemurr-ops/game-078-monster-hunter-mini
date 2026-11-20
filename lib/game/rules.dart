import '../core/arcade.dart';
import '../core/level_plan.dart';
import '../core/missions.dart';
import '../core/stats.dart';
import 'arena_engine.dart';

class HunterRules extends ArcadeRules<ArenaLevel> {
  @override
  String get gameId => 'game-078-monster-hunter-mini';

  @override
  List<String> get optionalMechanics => const ['boss', 'elites'];

  @override
  List<GameStat> get gameStats => const [
        GameStat('bosses_defeated', 'Yenilen boss', 'Bosses defeated', scale: 3),
        GameStat('enemies_defeated', 'Yenilen düşman', 'Enemies defeated', scale: 300),
        GameStat('player_level', 'Ulaşılan seviye', 'Level reached', scale: 10),
      ];

  @override
  List<MissionTemplate> get missionTemplates => const [
        MissionTemplate('bosses_defeated', 'bosses_defeated', [0, 1, 3]),
        MissionTemplate('enemies_defeated', 'enemies_defeated', [37, 75, 150], coinReward: 80),
      ];

  @override
  ArenaLevel generate(LevelSpec spec) => generateArena(ArenaKind.hunter, spec);

  @override
  ArcadeMeta metaOf(ArenaLevel l) => l.meta;

  @override
  ArcadeSim createSim(ArenaLevel l) => ArenaSim(l);

  @override
  ArcadeInput bot(ArcadeSim sim) => arenaBot(sim);
}

ArcadeRules createRules() => HunterRules();
