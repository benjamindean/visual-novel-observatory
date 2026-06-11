# Visual Novel Observatory 🌌

A premium, modern Flutter client for [VNDB.org](https://vndb.org/) using the new v2 Kana HTTPS API.

## Design Aesthetic
*   **Theme**: Celestial Dark Mode (Deep indigo, void black, glowing cyan/purple details).
*   **Visuals**: Glassmorphic panels, glowing border gradients, smooth micro-animations.
*   **Typography**: Google Fonts (Outfit / Inter).

## Directory Structure
*   `lib/main.dart`: UI Shell & Home Screen showcasing the celestial theme.
*   `lib/api/vndb_client.dart`: HTTP Client designed specifically for the Kana query format.
*   `lib/models/visual_novel.dart`: Dart model mapped to VNDB's JSON schema.
*   `lib/widgets/glassmorphic_container.dart`: Custom glassmorphism container using `BackdropFilter`.

## Running the App
1. Make sure you have Flutter installed.
2. Initialize dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```
