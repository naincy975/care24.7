# care247 - Customer Search (Flutter Assignment)

# Setup and Run

**Flutter/Dart version:** Flutter 3.47.5 (stable channel)

**1. Install dependencies:**

flutter pub get

**2. Start the mock API:**
Place the supplied `db.json` at the project root, then run: json-server --watch db.json --port 3001

Leave this running in its own terminal.

**3. Run the app:**

flutter run

**Android Emulator:** if testing on Android, update the base URL in `lib/data/customer_api.dart` to `http://10.0.2.2:3001` instead of `localhost:3001`.

**iOS Simulator / Web:** the default `http://localhost:3001` works as-is.

## Architecture

The project follows a layered structure, separating concerns into distinct folders:

- **`lib/models/`** — Typed data classes (`Customer`, `Address`, `Phone`, `Email`), each with a `fromJson` factory for converting raw API responses into typed objects.
- **`lib/config/`** — Configuration-driven search field definitions (`FieldConfig`, `FieldType`, `searchConfig`).
- **`lib/data/`** — `CustomerApi`, responsible for building requests (including query parameters for filtering) and converting responses into `Customer` objects.
- **`lib/state/`** — `CustomerSearchState`, a `ChangeNotifier` holding the current search status (initial/loading/success/empty/error) and results, shared across screens via Provider.
- **`lib/screens/`** — The three main screens: search, results, and detail.
- **`lib/widgets/`** — Reusable UI components, notably `DynamicField`, which renders a text or date input based on a `FieldConfig`.

**State management:** Provider (`ChangeNotifierProvider` + `ChangeNotifier`) was chosen for its simplicity and appropriateness for an app of this size. `CustomerSearchState` is created once at the app root and shared across the search and results screens — the search screen writes to it (`context.read`), and the results screen reactively rebuilds when it changes (`context.watch`).

**Navigation:** Standard `Navigator.push` / `MaterialPageRoute`, giving native back-navigation behavior on each platform.

**Loading/success/empty/error states:** Represented as a `SearchStatus` enum on `CustomerSearchState`. The results screen uses a `switch` statement on this status to render the appropriate UI for each case.


## Time Spent
- **`Day 1 (21st Sep)`** : 2 hours
- **`Day 2 (22nd Sep)`** : 4 hours
- **`Day 3 (23rd Sep)`** : 3 hours
- **`Day 4 (24th Sep)`** : 3.75 hours
- **`Day 5 (25th Sep)`**: 

**Total: ~12.75 hours**, including learning Flutter/Dart fundamentals from no prior experience with the framework. 

## AI Tool Usage Disclosure

Given no prior Flutter/Dart experience, I used Claude (Anthropic's AI assistant) while working on this project — for understanding Flutter/Dart concepts, reviewing and correcting my code, and in few cases, generating implementation code that I then typed in and worked to understand fully (verified through a dedicated review session covering every file, line by line, before submission). I also used official Flutter documentation, YouTube tutorials, and the Flutter widget catalog as supplementary learning resources.