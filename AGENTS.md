# Visual Novel Observatory — Agent Instructions

Purpose
- Provide concise, actionable rules for AI or human contributors to make changes consistently in this workspace.

Repository Patterns
- **State Management**: Use `flutter_riverpod` as the primary state library (e.g., `StateNotifierProvider`, `FutureProvider`).
- **Models & Codegen**: Use `freezed` + `json_serializable` for data models. Always run build generator after changing annotations:
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```

Styling & Formatting Rules
1. **Trailing Commas**: Add a trailing comma everywhere (e.g., arguments, parameter lists, collections) to keep formatting unified and readable.
2. **Variable Declarations Spacing**: Leave an empty line after variable declarations in a block/method before the rest of the logic. For example, declare variables, then add an empty line, and then write the remaining logic. Same with conditional blocks.
3. **State Management**: Use `riverpod` for managing all application state.
4. **Network Images Caching**: Use `cached_network_image` package for all network images in the application to optimize load times and save bandwidth.
5. **Widget Atomicity**: Keep widgets as atomic as possible. Break down complex screen layouts and large build methods into small, focused, single-responsibility widgets.

## Performance & Architecture Guidelines
- **Architecture**:
  - Adhere to the MVVM pattern. Maintain clear boundaries between UI (Views/Widgets) and business logic (ViewModels/Notifiers, Repositories, and Services).
  - Use feature-first organization: keep all related providers, models, UI, and services grouped together in a feature folder.
- **Performance**:
  - Always use `const` constructors for widgets where possible to minimize rebuild cycles.
  - Keep `build()` methods lightweight and free of heavy computations or database/API requests.
  - Split complex widgets into smaller, atomic widgets to localize state changes and avoid rebuilding large parts of the screen.
  - Use lazy loading (`ListView.builder`, `GridView.builder`) for any long or scrollable lists.
  - Run heavy CPU-bound computations in an **Isolate** to avoid blocking the main UI thread.
  - Always use `Profile` mode (`flutter run --profile`) when profiling performance or measuring frames.

Codegen & Formatting Checks
- Run the code generator to build models:
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```
- Run formatting on the project:
  ```bash
  dart format .
  ```
- Run static analyzer to check for issues:
  ```bash
  flutter analyze
  ```

## VNDB API filters Documentation (Kana v2)
Database querying via POST `/vn` utilizes a custom filters query format.
Queries can combine simple predicates using logic operators `"and"` and `"or"`.

### Filter Predicates Structure
A predicate is a 3-element JSON array: `["field", "operator", value]`.
- Supported logic operators: `"and"`, `"or"` (combining multiple arrays).
- Supported comparison operators: `=`, `!=`, `>=`, `>`, `<=`, `<`.

### Supported Visual Novel Filter Fields
- `id`: Exact match on visual novel ID (e.g. `["id", "=", "v17"]`).
- `search`: Search query string (e.g. `["search", "=", "Steins;Gate"]`).
- `lang`: Languages available (e.g. `["lang", "=", "en"]`).
- `olang`: Original language of the visual novel (e.g. `["olang", "!=", "ja"]`).
- `platform`: Target platform (e.g. `["platform", "=", "win"]` or `["platform", "=", "swi"]`).
- `length`: Play length class from 1 to 5 (e.g. `["length", "=", 3]`).
  - `1`: Very Short (< 2 hours)
  - `2`: Short (2 - 10 hours)
  - `3`: Medium (10 - 30 hours)
  - `4`: Long (30 - 50 hours)
  - `5`: Very Long (> 50 hours)
- `released`: Release date in formats YYYY-MM-DD, YYYY-MM, or YYYY (e.g. `["released", ">=", "2020-01-01"]`).
- `rating`: Rating score out of 100 (e.g. `["rating", ">=", 70]`).
- `votecount`: Number of votes received (e.g. `["votecount", ">=", 50]`).
- `devstatus`: Development status (0 = Finished, 1 = In development, 2 = Cancelled).
- `tag` / `dtag`: Filter by tag ID (e.g. `["tag", "=", "g505"]` or with spoiler/level details `["tag", "=", ["g505", spoilerLevel, minTagLevel]]`).

