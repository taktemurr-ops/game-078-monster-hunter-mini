import 'package:flutter/material.dart';
import 'game/hunt_engine.dart';

void main() => runApp(const MonsterHunterApp());

class MonsterHunterApp extends StatelessWidget {
  const MonsterHunterApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Monster Hunter Mini',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepOrange, brightness: Brightness.dark),
        ),
        home: const HuntScreen(),
      );
}

class HuntScreen extends StatefulWidget {
  const HuntScreen({super.key});
  @override
  State<HuntScreen> createState() => _HuntScreenState();
}

class _HuntScreenState extends State<HuntScreen> {
  final HuntEngine game = HuntEngine();

  Widget action(HuntAction action, String name, IconData icon) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: FilledButton.tonalIcon(
            onPressed: game.canUse(action)
                ? () => setState(() => game.takeTurn(action))
                : null,
            icon: Icon(icon),
            label: Text(name, style: const TextStyle(fontSize: 12)),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MONSTER HUNTER MINI'),
          actions: [
            IconButton(
              tooltip: 'Restart hunt',
              icon: const Icon(Icons.refresh),
              onPressed: () => setState(game.restart),
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text('STAGE ${game.stage}/5     SCORE ${game.score}     COINS ${game.coins}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  Text('HUNTER  HP ${game.hp}/100   STAMINA ${game.stamina}/5'),
                  LinearProgressIndicator(value: game.hp / 100,
                      minHeight: 10, borderRadius: BorderRadius.circular(6)),
                  const SizedBox(height: 14),
                  Text('MONSTER  HP ${game.monsterHp}/${game.monsterMaxHp}'),
                  LinearProgressIndicator(
                    value: (game.monsterHp / game.monsterMaxHp).clamp(0.0, 1.0),
                    minHeight: 10, borderRadius: BorderRadius.circular(6)),
                  const SizedBox(height: 18),
                  AspectRatio(
                    aspectRatio: 1.3,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF172638), Color(0xFF59402E)],
                          begin: Alignment.topLeft, end: Alignment.bottomRight),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shield, size: 86,
                                color: Colors.blueGrey.shade100),
                              const Text('HUNTER'),
                            ]),
                          Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.pets, size: 100,
                                color: game.active ? Colors.deepOrangeAccent :
                                  Colors.grey),
                              Text('GUARDIAN ${game.stage}'),
                            ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Semantics(liveRegion: true,
                    child: Text(game.message, textAlign: TextAlign.center)),
                  const SizedBox(height: 10),
                  Row(children: [
                    action(HuntAction.attack, 'Attack', Icons.gavel),
                    action(HuntAction.guard, 'Guard', Icons.security),
                  ]),
                  Row(children: [
                    action(HuntAction.special, 'Special', Icons.flash_on),
                    action(HuntAction.potion, 'Potion ${game.potions}', Icons.healing),
                  ]),
                  const SizedBox(height: 10),
                  const Text('Attack builds 1 stamina. Guard builds 2 stamina and '
                      'halves the next hit. Special costs 3 stamina. '
                      'Potions heal 28 HP. Defeat five monsters to win.',
                      textAlign: TextAlign.center),
                  if (!game.active)
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: FilledButton(
                        onPressed: () => setState(game.restart),
                        child: Text(game.state == HuntState.victory
                            ? 'Play again' : 'Retry hunt'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
}
