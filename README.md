# Alive — Live Streaming App

A Flutter assignment project for LVS Innovation demonstrating a live streaming app UI (Splash → Google Login → Home feed). No actual streaming functionality is implemented — UI and navigation only, as per the spec.

---

## Screens

| Splash | Login | Home |
|--------|-------|------|
| Animated logo scale + fade, auto-navigates after 2.5s | Google Sign-In (Firebase Auth), Facebook button visible but non-functional* | Tab bar, category chips, 2-col stream grid, custom bottom nav with raised Go Live FAB |

*\*Login screen deviation: The reference image shows both Google and Facebook buttons. The written spec explicitly states Google Sign-In only. Facebook button is kept visible (disabled) to match the reference image visually, but it is non-functional. This is a deliberate, communicated decision — not an oversight.*

---

## Architecture

**Clean Architecture + MVVM with GetX**

```
lib/
├── app/            # Theme, routing, GetX bindings
├── core/           # Failures, base UseCase, custom Either<L,R>
├── domain/         # Entities, abstract repositories, use cases
├── data/           # Models, datasources (Firebase + stub REST), repository impls
└── presentation/   # Screens + GetX controllers (ViewModels)
```

**Layer flow:**
```
Presentation (View + Controller)
    ↓ calls
Domain (UseCase)
    ↓ calls (abstract)
Data (RepositoryImpl → DataSource)
    ↓ calls
Firebase Auth / REST API (Dio — API-ready, stubbed)
```

**State management:** GetX `Rx` observables + `Obx` widgets — no `setState` anywhere.

**Routing:** GetX named routes (`Get.offAllNamed`) with per-screen `Bindings` for dependency injection.

---

## Tech Stack

| Concern | Package |
|---------|---------|
| State / DI / Routing | `get ^4.6.6` |
| Auth | `firebase_auth ^5.x`, `google_sign_in ^6.x` |
| Networking | `dio ^5.x` (API-ready, stubbed) |
| Image caching | `cached_network_image ^3.x` |
| Models | `equatable ^2.x` |

---

## Setup

```bash
git clone https://github.com/ANSHRAMANI1/lvs_demo.git
cd lvs_demo
flutter pub get
```

### Firebase configuration (required to run)

1. Go to [Firebase Console](https://console.firebase.google.com/) → project `kkvs-demo`
2. Download `google-services.json` → place at `android/app/google-services.json`
3. Download `GoogleService-Info.plist` → place at `ios/Runner/GoogleService-Info.plist`
4. Replace placeholder values in `lib/firebase_options.dart` with real values, **or** run:
   ```bash
   flutterfire configure --project=kkvs-demo
   ```
5. Add your debug SHA-1 to Firebase Android app settings:
   ```bash
   cd android && ./gradlew signingReport
   ```

### Assets

Place the logo image at `assets/images/logo.png`. The app falls back to a green icon if the asset is missing.

```bash
flutter run
```

---

## Known Limitations

- No live streaming functionality (UI/navigation only, per spec)
- Home feed uses stubbed dummy data — replace `HomeRemoteDataSourceImpl` with a real Dio call when an API is available
- Facebook login is visible but non-functional (Google-only per written spec)
