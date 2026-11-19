# Monster Hunter Mini — Game 078

Original Flutter/Dart offline turn-based monster battle prototype for Android and iOS.

## Features in source
- Five monsters with escalating health and damage
- Sword strike, guard (half damage), stamina-powered special, healing potions
- Health bars, combat messages, score, coins and replay
- Eight deterministic rules-engine tests
- GitHub Actions static analysis, tests and Android debug APK workflow

## Local development
```sh
flutter create --platforms=android,ios .
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```

## Release status
**Prototype — not production-ready.** Passing CI and device builds have not yet been verified. Ads, IAP, persistence, richer content, accessibility, localization, device QA and store signing remain outstanding. See `docs/RELEASE_CHECKLIST.md`.
