# Repository Guidelines

## Project Structure & Module Organization
The SwiftUI client lives under `ExpiryDateApp/`, grouped by feature (`Inventory`, `Recipes`, `Notifications`). Shared models and services belong in `ExpiryDateApp/Shared/`. Store images, JSON fixtures, and localized strings in `ExpiryDateApp/Resources/`. Unit and UI tests go in the mirrored `ExpiryDateAppTests/` and `ExpiryDateAppUITests/` targets. Automation scripts (Fastlane lanes, data import helpers) should reside in `Scripts/`, keeping each script executable and documented with a one-line usage comment.

## Build, Test, and Development Commands
- `open ExpiryDateApp.xcodeproj` — launch the workspace in Xcode for interactive development.
- `xcodebuild -scheme ExpiryDateApp -configuration Debug build` — reproducible CI-friendly build.
- `xcodebuild -scheme ExpiryDateApp -destination 'platform=iOS Simulator,name=iPhone 15' test` — run the full XCTest suite locally or in CI.
- `fastlane ios beta` — distribute the latest build to TestFlight once release metadata is ready.

## Coding Style & Naming Conventions
Target Swift 5.9, 4-space indentation, tabs disabled. Type names use UpperCamelCase, properties and functions use lowerCamelCase, and enums with associated values prefer nested case-specific structs. Keep view files under 300 lines; extract subviews when reusable. Apply `swiftformat .` and `swiftlint --strict` before opening a PR; both tools are expected to be configured via `.swiftformat` and `.swiftlint.yml` at the repo root.

## Testing Guidelines
Write `XCTestCase` subclasses per feature (`InventoryServiceTests`, `NotificationSchedulerTests`). UI flows belong in `XCTestCase` files suffixed `UITests`. When adding new expiration calculations, cover edge dates (today, past-due, leap-year) and concurrency scenarios. Snapshot tests should save reference images under `ExpiryDateAppTests/Resources/Snapshots/`. Run `xcodebuild test` locally before pushing and fail CI if overall code coverage drops below 85%.

## Commit & Pull Request Guidelines
Commits follow `<type>: <imperative summary>` where type is one of `feat`, `fix`, `refactor`, `test`, `docs`, or `chore`. Keep the body wrapped at 100 characters, referencing issue numbers as `Refs #123`. Each PR needs: a concise summary, checklist of manual verifications (simulator model, OS version), linked issue, and screenshots or screen recordings whenever UI changes. Request review from at least one maintainer and wait for CI to succeed before merging.

## Environment & Data Safety
Store API keys and notification tokens in an encrypted `.env.local` file excluded from Git; document required keys in `README.md`. Seed data used for previews should avoid real user information and reside in `ExpiryDateApp/Resources/Seeds/`. Use the `AppSecrets` protocol to inject secrets at runtime so previews remain functional with stub values.
