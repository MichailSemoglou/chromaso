# Changelog

All notable changes to Chromaso are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.1] — 2026-04-21

### Fixed

- Save directory is now `~/Chromaso/` instead of `~/Desktop/Chromaso/`, making the export path consistent and locale-independent across all platforms
- `mkdirs()` return value is now checked; if the directory cannot be created, an error is logged and `saveFrame()` is skipped rather than attempting to write to a non-existent path

### Changed

- Added `data/` to `.gitignore` to prevent Processing's runtime data folder from being tracked

## [0.2.0] — 2026-04-21

### Added

- Click any swatch to copy its HEX colour value to the system clipboard
- Brief on-screen confirmation toast showing the copied value

### Changed

- Save path now uses `System.getProperty("user.home")` instead of a hardcoded `/Users/` prefix (cross-platform)
- Replaced magic number `126` with a named constant `MAX_RAMP_VALUE` and inline comment explaining its purpose

## [0.1.0] — 2026-04-21

### Added

- Two-column HSB visualisation: saturation ramp and brightness ramp driven by independent hue sliders
- Numeric readouts for hue (0–360°) and computed saturation/brightness percentages
- Export current palette as PNG via the S key
- ControlP5-based slider interface using SF Compact Text

[0.2.1]: https://github.com/MichailSemoglou/Chromaso/releases/tag/v0.2.1
[0.2.0]: https://github.com/MichailSemoglou/Chromaso/releases/tag/v0.2.0
[0.1.0]: https://github.com/MichailSemoglou/Chromaso/releases/tag/v0.1.0
