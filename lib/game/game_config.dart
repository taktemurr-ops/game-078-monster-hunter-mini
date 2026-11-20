import 'package:flutter/material.dart';

import '../app/arcade_stage.dart';
import '../app/game_api.dart';
import '../core/game_rules.dart';
import 'arena_engine.dart';
import 'arena_view.dart';
import 'rules.dart';

final gameConfig = GameConfig(
  gameId: 'game-078-monster-hunter-mini',
  title: const ['Mini Canavar Avcısı', 'Monster Hunter Mini', 'Mini-Monsterjäger', 'Mini Cazador de Monstruos', 'Mini Chasseur de Monstres'],
  tagline: const ['Dev canavarı avla, ekipmanını güçlendir!', 'Hunt the giant beast and upgrade your gear!', 'Jage das Riesenmonster!', '¡Caza a la gran bestia!', 'Chassez la bête géante !'],
  seedColor: const Color(0xFF9D0208),
  icon: Icons.pets,
  rules: HunterRules(),
  buildPlay: (ctx) => ArcadeStage(
    ctx: ctx,
    create: () => ArenaSim((ctx.generated as GeneratedLevel<ArenaLevel>).puzzle),
    paint: paintArena,
    sound: arenaSound,
    boosterIcon: Icons.whatshot,
    boosterLabel: (l) => l == 'tr' ? 'Avcı çığlığı' : 'Hunter\'s roar',
    howTo: const ['Ekranın herhangi bir yerine basılı tutup parmağını kaydır: sanal joystick ile hareket et. Saldırı otomatik.', 'Hold anywhere and slide your finger: a virtual joystick moves you. Attacks are automatic.', 'Irgendwo halten und ziehen: virtueller Joystick. Angriffe automatisch.', 'Mantén pulsado y desliza: joystick virtual. Ataque automático.', 'Maintenez et glissez : joystick virtuel. Attaque automatique.'],
  ),
  tutorial: const [
    TutorialStep(Icons.open_with, ['Ekranın herhangi bir yerine basılı tutup parmağını kaydır: sanal joystick ile hareket et. Saldırı otomatik.', 'Hold anywhere and slide your finger: a virtual joystick moves you. Attacks are automatic.', 'Irgendwo halten und ziehen: virtueller Joystick. Angriffe automatisch.', 'Mantén pulsado y desliza: joystick virtual. Ataque automático.', 'Maintenez et glissez : joystick virtuel. Attaque automatique.']),
    TutorialStep(Icons.swap_horiz, ['Kırmızı çizgi = hücum! Yana kaç.', 'Red line = charge! Dodge sideways.', 'Rote Linie = Ansturm!', 'Línea roja = embestida.', 'Ligne rouge = charge !']),
    TutorialStep(Icons.upgrade, ['Kampanyada ilerledikçe ekipmanın güçlenir.', 'Your gear grows stronger as you progress.', 'Ausrüstung wird stärker.', 'Tu equipo mejora.', 'Votre équipement se renforce.']),
  ],
);
