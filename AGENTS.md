# Visual Novel Observatory — Agent Instructions

Purpose
- Provide concise, actionable rules for AI or human contributors to make changes consistently in this workspace.
- **VNDB API Reference**: Always refer to the official VNDB API documentation at https://api.vndb.org/kana whenever modifying VNDB client code, query parameters, filters, or models.

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
6. **Thumb-Stretch Awareness**: All primary actions and save/apply buttons should be thumb-stretch aware (e.g. placed at the bottom of screens or cards, stretched horizontally for easy one-handed access).

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

## VNDB Tag Categories & Sensitive Content Filtering
- Visual novel tags retrieved from VNDB contain a `category` field of type String:
  - `"cont"`: Content tags
  - `"ero"`: Sexual/erotic tags
  - `"tech"`: Technical tags
- When `settings.showExplicitContent` is disabled, any tags categorized as `"ero"` MUST be filtered out programmatically from all UI views (detail screens, searches, and selected filter summaries).

## Theming & Color Guidelines
- **Responsive Tokens**: Always use context extension color tokens (e.g. `context.appTextPrimary`, `context.appTextSecondary`, `context.appSurface`, etc.) rather than hardcoded colors (`Colors.white`, `Colors.white.withValues(...)`, `Colors.black`, `Colors.grey`, `Colors.redAccent`) to ensure full functionality in both Light Mode and Dark Mode.
- **Borders & Dividers**: Implement adaptive borders and divider lines by wrapping `context.appTextPrimary` with a low opacity value, e.g. `context.appTextPrimary.withValues(alpha: 0.08)`.
- **Overlay Buttons & Controls**: In buttons or tiles layered on top of primary/secondary colors, use contrasting theme foreground colors (e.g. `context.colorScheme.onPrimary`) rather than hardcoded black or white text.
- **Material Ink Splashes**: Avoid using container background colors directly behind interactive widgets like `ListTile`, `CheckboxListTile`, or `InkWell` without a `Material` widget container. Ripple/ink splashes require a `Material` widget ancestor (using its `color` property) or wrapping the elements in `Material(color: Colors.transparent, child: ...)` to ensure splashes are visible and rendered correctly.
- **ListTile Padding**: Retain default horizontal padding (`contentPadding`) on interactive `ListTile` or `CheckboxListTile` elements inside menus, sheets, or dialogs to ensure highlight press/tap feedback is bound correctly and looks premium.

## Media Viewer & Panning lock
- When implementing zoomed media views (e.g., custom pinch/pan gesture layouts), prevent conflict between horizontal/vertical scroll navigation and pan gestures:
  - Lock page scrolling (`PageView.physics = NeverScrollableScrollPhysics()`) when the current image zoom/scale is greater than 1.0.
  - Disable swipe-to-dismiss gestures when the user is zoomed into an image so they can pan vertically without closing the viewport.
  - Reset the zoom scale of previous indices back to 1.0 when a swipe transition completes.

## VNDB List Management API Documentation (Kana v2)
List management endpoints require authentication using the `Authorization: Token <token>` header (unless querying public lists on GET/POST endpoints).

### POST /ulist (Fetch User's List)
Queries a user's visual novel list. This endpoint is structured similarly to `POST /vn`, but it has different response fields and requires the `"user"` body parameter.
- **Query Body Parameters**:
  - `user`: (Required) String, user ID (e.g. `"u2"`).
  - `fields`: (Optional) Comma-separated list of fields to return (e.g. `"id, vote, labels{id}, vn.title"`).
  - `filters`: (Optional) Filter array. Supports all standard Visual Novel filters, plus `label` filtering (e.g. `["label", "=", 7]`).
  - `sort`: (Optional) Field to sort by. Accepted values: `id`, `title`, `released`, `rating`, `votecount`, `voted`, `vote`, `added`, `lastmod`, `started`, `finished`, `searchrank`.
  - `reverse`: (Optional) Boolean, set to `true` to reverse sorting.
  - `results`: (Optional) Integer, number of results per page (default 10, max 100).
  - `page`: (Optional) Integer, page number (default 1).
- **Supported Fields**:
  - `id`: String, the visual novel's ID (e.g. `"v17"`).
  - `vote`: Integer, user's rating out of 100 (range 10-100).
  - `notes`: String, user's private notes.
  - `started`: String, date started (YYYY-MM-DD).
  - `finished`: String, date finished (YYYY-MM-DD).
  - `added`: Integer, unix timestamp of when the entry was added.
  - `lastmod`: Integer, unix timestamp of the last modification.
  - `labels`: Array of Objects representing labels assigned to this list item. Sub-fields: `id` (int), `label` (String, name of the label).
  - `vn`: Object containing nested visual novel info. Accepts subfields from the `/vn` endpoint (e.g. `vn.title`, `vn.image.url`). Note: The nested `vn` object does not return an `id` field.
- **Deleted VNs**: Visual novel entries that have been deleted from the database will not be returned by the API even if they are visible on the website.

### GET /ulist_labels (Fetch List Labels)
Fetch the list labels for a certain user.
- **Query Parameters**:
  - `user`: (Required) String, user ID (e.g. `u2`).
  - `fields`: (Optional) Comma-separated list of fields to return.
- **Response Structure**:
  Returns a JSON object with a single key `"labels"` containing an array of label objects:
  - `id`: Integer, label ID. Labels with an ID below 10 are pre-defined (e.g. 1 = Playing, 2 = Finished, 3 = Stalled, 4 = Dropped, 6 = Wishlist).
  - `label`: String, name of the label.
  - `private`: Boolean, whether the label is private.
  - `count`: Integer, number of entries under this label (only returned if requested).

### PATCH /ulist/<id> (Add/Update Visual Novel in List)
Add or update a visual novel in the user's list. Tapping this endpoint always adds the visual novel to the user's list if it's not already present.
- **Path Parameter**: `<id>` is the visual novel ID (e.g. `v17`).
- **Permissions**: Requires the `listwrite` token permission.
- **JSON Body Parameters**:
  - `vote`: (Optional) Integer, user's rating out of 100 (range 10-100, or `null` to remove the vote). Note: Label `7` ("Voted") is automatically added/removed based on this field.
  - `notes`: (Optional) String, private notes.
  - `started`: (Optional) String, date started (YYYY-MM-DD or `null` to unset).
  - `finished`: (Optional) String, date finished (YYYY-MM-DD or `null` to unset).
  - `labels`: (Optional) Array of Integers, replaces all labels on this list item with the given label IDs. Note: Virtual labels `0` ("No label") and `7` ("Voted") cannot be manually set.
  - `labels_set`: (Optional) Array of Integers, adds the given label IDs to this list item.
  - `labels_unset`: (Optional) Array of Integers, removes the given label IDs from this list item.

### PATCH /rlist/<id> (Add/Update Release in List)
Add or update a release in the user's list. All visual novels linked to the release are also automatically added to the user's visual novel list if they aren't present yet.
- **Path Parameter**: `<id>` is the release ID (e.g. `r12`).
- **Permissions**: Requires the `listwrite` token permission.
- **JSON Body Parameters**:
  - `status`: (Required) Integer, status of the release:
    - `0`: Unknown
    - `1`: Pending
    - `2`: Obtained
    - `3`: On loan
    - `4`: Wishlist

### DELETE /ulist/<id> (Remove Visual Novel from List)
Remove a visual novel from the user's list.
- **Path Parameter**: `<id>` is the visual novel ID (e.g. `v17`).
- **Behavior**: Returns success even if the visual novel is not on the user's list. Removing a VN also automatically removes any associated releases from the user's list.

### DELETE /rlist/<id> (Remove Release from List)
Remove a release from the user's list.
- **Path Parameter**: `<id>` is the release ID (e.g. `r12`).
- **Behavior**: Returns success even if the release is not on the user's list. Removing a release does NOT remove the associated visual novels from the user's visual novel list; that requires a separate call to `DELETE /ulist/<id>`.
