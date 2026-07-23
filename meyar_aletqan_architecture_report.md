# Meyaar Al-Etqan — Flutter Engineering Review Report
**Prepared by:** Senior Flutter Architect Analysis  
**Date:** 2026-07-19  
**Project:** `meayar_alitqan` · Flutter 3.x · Dart 3.9.x

---

## 1. Project Overview

### Purpose
**Meyaar Al-Etqan** is a multi-role service-request marketplace connecting **Customers** who need maintenance/technical services with **Technicians** who fulfil them. The app targets both mobile (iOS / Android) and web.

### Architecture
The project uses **Feature-Based Clean Architecture** split across three canonical layers — `data`, `domain`, `presentation` — inside each feature folder.

### State Management
**flutter_bloc** (Cubit + BLoC) throughout every feature. A global `AppUserCubit` manages authentication state app-wide. ViewModels are named `*ViewModel` and extend `Cubit`.

### Navigation
`onGenerateRoute` with a central `RoutesManager` class. All route names are `static const String` constants. No GoRouter or AutoRoute.

### Backend / API Integration
| Integration | Usage |
|---|---|
| **Supabase** | Auth, Storage, Realtime, Edge Functions |
| **Firebase** | FCM push notifications only |
| **Supabase Edge Functions** | All REST-like business endpoints (30+ functions) |
| **Dio** | HTTP client for Edge Function calls |
| **Google Sign-In** | OAuth social login |

### Key Dependencies
`flutter_screenutil`, `flutter_bloc`, `dio`, `supabase_flutter`, `firebase_messaging`, `injectable` + `get_it`, `flutter_svg`, `lottie`, `cached_network_image`, `carousel_slider`, `shimmer`, `image_picker`, `video_player`, `pdf` + `printing`, `geolocator`, `geocoding`, `either_dart`, `auto_size_text`, `flutter_localization`.

---

## 2. Project Structure Review

```
lib/
├── config/
│   ├── routes/          ✅ routes_manager.dart
│   └── theme/           ⚠️  single file only
├── core/
│   ├── api/             ✅ endpoints + manager
│   ├── cache/           ✅ SharedPreferences wrapper
│   ├── components/      ✅ 15 shared widgets
│   ├── cubit/           ⚠️  only app_user cubit here
│   ├── di/              ✅ injectable config
│   ├── enums/           ✅
│   ├── errors/          ✅ failures + mappers
│   ├── extensions/      ✅
│   ├── helper/          ⚠️  mixed concerns (RS, text, network)
│   ├── network/         (connectivity)
│   ├── services/        (FCM, notifications)
│   ├── utils/           ✅ colors, text styles, assets
│   └── validators/
├── features/
│   ├── auth/            ✅ data/domain/presentation
│   ├── banners/         ✅
│   ├── home/            ⚠️  deeply nested (mobile/web/tabs/customer/home/...)
│   ├── location/        ✅
│   ├── notifications/   ✅
│   ├── onboarding/      ✅
│   ├── orders/          ⚠️  customer/technician/shared split
│   ├── profile/         ⚠️  customer/technician/shared split
│   ├── reviews/         ✅
│   ├── services/        ✅
│   ├── spare_parts/     ✅
│   ├── splash/          ✅
│   └── uploads/         ✅
├── l10n/                ✅ ARB-based localization
├── firebase_options.dart
└── main.dart            ⚠️  too much bootstrap logic
```

### Folder-Level Issues

| Folder | Issue | Severity |
|---|---|---|
| `home/presentation/views/mobile` vs `web` | Platform split at view level forces code duplication | High |
| `home/presentation/tabs/customer/home/presentation/views` | 6-level nesting for a single screen | High |
| `orders/customer`, `orders/technician`, `orders/shared` | Role-split creates tight coupling, hard to test | Medium |
| `core/helper/` | 18 files with mixed concerns (UI, network, text) | Medium |
| `config/theme/` | Single `app_theme.dart` — no token files, no spacing/radius classes | Medium |
| `main.dart` | Session refresh, user loading, BLoC providers, auth listener all in one file | High |

### Structure Score: **6 / 10**

---

## 3. Architecture Analysis

### Pattern: Feature-Based Clean Architecture (partial)

| Layer | Present | Quality |
|---|---|---|
| Domain (entities, repos, use cases) | ✅ Yes | Good |
| Data (data sources, models, repo impl) | ✅ Yes | Good |
| Presentation (views, widgets, manager/cubit) | ✅ Yes | Mostly good |
| Separation of concerns | ⚠️ Partial | Platform branching bleeds into views |
| Dependency Inversion | ✅ injectable + get_it | Good |
| Testability | ⚠️ Medium | Use-cases testable; views have direct `getIt` calls |

### Strengths
- Clean three-layer structure per feature
- `injectable` + `get_it` removes manual DI wiring
- `either_dart` for functional error handling in domain
- Centralised `AppUserCubit` for auth state
- Strong localization (ARB, two locales)
- Platform-aware routing (mobile/web branching in `AppRoot`)

### Weaknesses
- **`main.dart` is a god file** — session management, BLoC registration, auth listeners
- **Direct `getIt<>()` calls inside `build()`** (e.g. `ServiceRequestDetailsView`) bypass DI properly and couple UI to service locator
- **No repository interface per feature** for orders/profile shared layer — `shared` folder crosses feature boundaries
- **`otp_view.dart` is 20 KB** — monolithic screen file
- **`di.config.dart` is 56 KB** — auto-generated but never reviewed for redundant registrations
- ViewModels registered as `@injectable` but some call `getIt` internally — circular smell

---

## 4. Code Quality Review

### Naming Conventions

| Convention | Status | Notes |
|---|---|---|
| Feature folders | ✅ snake_case | Consistent |
| Widget files | ✅ snake_case | Consistent |
| Classes | ✅ PascalCase | Consistent |
| ViewModels named `*ViewModel` | ✅ | Consistent |
| State classes `*States` | ⚠️ | Should be `*State` (singular) per BLoC convention |
| Cubit in `core/cubit/app_user/` | ✅ | |
| `techinican` folder (typo) | ❌ | Should be `technician` |

### Issues Found

| Issue | Location | Severity | Fix |
|---|---|---|---|
| Hardcoded Arabic strings in dialog defaults (`"نعم"`, `"لا"`) | `confirmation_dialog.dart:22-23` | High | Use `AppLocalizations` |
| `Colors.redAccent`, `Colors.green` raw colors in dialog buttons | `confirmation_dialog.dart:71,89` | High | Use `ColorsManager` or theme |
| `Colors.black.withOpacity(0.2)` | `service_request_details_view.dart:83` | Medium | Use `ColorsManager` token |
| `const EdgeInsets.all(16.0)` hardcoded | `custom_text_field.dart:108` | Medium | Use spacing constant |
| `const BoxConstraints(maxWidth: 700)` | `service_request_details_view.dart:64` | Medium | Extract to `ConstantsManager` |
| `semiBold18` is `const` but uses raw `18` not `.sp` | `app_text_styles.dart:30-33` | High | Use `18.sp` or mark non-const |
| `bold24Primary` copies `bold24` with same values | `app_text_styles.dart:53-56` | Low | Remove duplicate |
| `debugPrint` statements left in production code | `login_form.dart:33,45,55` | Medium | Remove or wrap in `kDebugMode` |
| Supabase anon key hardcoded in `ConstantsManager` | `constants_manager.dart:3` | Critical | Move to `.env` / build config |
| `Colors.grey` used directly in theme | `app_theme.dart:35` | Medium | Replace with `ColorsManager.grey` |
| `Colors.white` used directly (not `ColorsManager.white`) | `app_theme.dart:42` | Low | Standardise |
| Commented-out code blocks | `main.dart:192–214` | Low | Remove dead code |
| `CustomTextFormField` has mutable non-final fields | `custom_text_field.dart:33-37` | Medium | All widget params should be `final` |
| `_RegisterRow` private class inside `login_form.dart` | `login_form.dart:248` | Low | Extract to own file |
| No `EmptyStateWidget` or `ErrorWidget` in `core/components` | — | High | Create reusable states |

---

## 5. Theme Analysis

### Current State
- One `app_theme.dart` file with light and dark `ThemeData`
- `ColorsManager` has only **6 colors** — very minimal
- `AppTextStyles` has **9 styles** but `semiBold18` is not responsive
- No spacing constants class
- No border-radius constants class
- Raw `Colors.grey.shade400`, `Colors.grey.shade500` etc. used directly in theme and widgets

---

### Theme Refactoring Plan

#### App Colors
```dart
class AppColors {
  // Brand
  static const Color primary      = Color(0xFF2C4466);
  static const Color primaryLight = Color(0xFF3D5A8A);
  static const Color primaryDark  = Color(0xFF1A2D47);
  static const Color secondary    = Color(0xFFEB9D27);
  static const Color gold         = Color(0xFFCBB27B);

  // Neutrals
  static const Color white        = Color(0xFFFFFFFF);
  static const Color black        = Color(0xFF000000);
  static const Color grey100      = Color(0xFFEBEBEB);
  static const Color grey300      = Color(0xFFBDBDBD);
  static const Color grey500      = Color(0xFF9E9E9E);
  static const Color grey700      = Color(0xFF616161);

  // Semantic
  static const Color success      = Color(0xFF2E7D32);
  static const Color warning      = Color(0xFFF9A825);
  static const Color error        = Color(0xFFC62828);
  static const Color info         = Color(0xFF1565C0);

  // Surfaces
  static const Color background   = Color(0xFFF5F5F5);
  static const Color surface      = Color(0xFFFFFFFF);
  static const Color surfaceDark  = Color(0xFF2C2C2C);
}
```

#### Typography
```dart
class AppTextStyles {
  static const String _font = 'Cairo';

  // Display
  static TextStyle display1 => TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w800, fontFamily: _font);
  static TextStyle display2 => TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700, fontFamily: _font);

  // Headings
  static TextStyle h1 => TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, fontFamily: _font);
  static TextStyle h2 => TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, fontFamily: _font);
  static TextStyle h3 => TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, fontFamily: _font);

  // Body
  static TextStyle bodyLg  => TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, fontFamily: _font);
  static TextStyle bodyMd  => TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, fontFamily: _font);
  static TextStyle bodySm  => TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, fontFamily: _font);

  // Button / Label
  static TextStyle button  => TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, fontFamily: _font);
  static TextStyle caption => TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400, fontFamily: _font);
}
```

#### Spacing System
```dart
class AppSpacing {
  static const double xs  = 4.0;
  static const double sm  = 8.0;
  static const double md  = 16.0;
  static const double lg  = 24.0;
  static const double xl  = 32.0;
  static const double xxl = 48.0;
}
```

#### Border Radius System
```dart
class AppRadius {
  static const double sm  = 6.0;
  static const double md  = 12.0;
  static const double lg  = 16.0;
  static const double xl  = 24.0;
  static const double full = 999.0;
}
```

#### Elevation System
```dart
class AppElevation {
  static const double none   = 0;
  static const double low    = 2;
  static const double medium = 4;
  static const double high   = 8;
}
```

---

## 6. Reusable Widgets Audit

| Widget | Current Location | Reuse Level | Suggested Name | Key Params |
|---|---|---|---|---|
| Primary action button | `core/components/custom_button.dart` | ✅ Already reusable | `PrimaryButton` | `text`, `onPressed`, `isLoading`, `width`, `variant` (filled/outlined) |
| Text form field | `core/components/custom_text_field.dart` | ✅ Already reusable | `AppTextField` | `label`, `hint`, `validator`, `isPassword`, `prefixIcon`, `controller` |
| App bar | `core/components/custom_app_bar.dart` | ✅ Already reusable | `AppTopBar` | `title`, `showBack`, `actions`, `elevation` |
| Confirmation dialog | `core/components/confirmation_dialog.dart` | ✅ Already reusable | `AppConfirmDialog` | Migrate hardcoded Arabic strings to `l10n` |
| Inline loader overlay | `core/components/app_loader.dart` | ✅ Already reusable | `AppOverlayLoader` | `isLoading` |
| Dismissible error card | `core/components/dismissible_error_card.dart` | ✅ Already reusable | `ErrorBanner` | `message`, `onDismiss` |
| Empty state | ❌ Missing | 🔴 High priority | `EmptyStateWidget` | `image`, `title`, `subtitle`, `action` |
| Error state | ❌ Missing | 🔴 High priority | `ErrorStateWidget` | `message`, `onRetry` |
| Loading shimmer | Inline in list screens | ⚠️ Should extract | `ShimmerListLoader` | `itemCount`, `itemHeight` |
| Success bottom sheet | `core/components/custom_success_bottom_sheet.dart` | ✅ Already reusable | `SuccessSheet` | `title`, `subtitle`, `onDone` |
| Guest placeholder | `core/components/guest_orders_placeholder.dart` | ⚠️ Feature-specific | `GuestGateCard` | `title`, `body`, `ctaText`, `onLogin` |
| Role card (login/register) | `auth/presentation/widgets/role_card.dart` | 🔵 Feature-scoped | Keep in auth | `label`, `icon`, `onTap`, `isSelected` |
| Search field | `core/components/search_text_field.dart` | ✅ Already reusable | `AppSearchField` | `hint`, `onChanged`, `onSubmit` |
| Network image | Inline `CachedNetworkImage` usage | ⚠️ Should wrap | `AppNetworkImage` | `url`, `fit`, `placeholder`, `errorWidget` |
| Video player | `core/components/video_player_view.dart` | ✅ Already reusable | Keep, add aspect ratio support | |
| App scaffold | ❌ Missing | 🔴 High priority | `AppScaffold` | `appBar`, `body`, `bottomNav`, `floatingAction` |
| Or divider | `core/components/or_divider.dart` | ✅ Small, reusable | `OrDivider` | `label` |

---

## 7. Responsive Design Audit

### Current Approach
- `flutter_screenutil` (design size `430×932`) + custom `RS` utility class
- `RS.size()`, `RS.font()`, `RS.radius()` methods wrap `MediaQuery`
- Web max-width constraints in some views (`maxWidth: 700`, `maxWidth: 420`)
- `kIsWeb` branches exist in `main.dart`, `AppRoot`, several widgets

### Issues Found

| Issue | Location | Severity | Fix |
|---|---|---|---|
| Fixed `maxWidth: 700` in service details | `service_request_details_view.dart:64` | Medium | Extract to `ConstantsManager.webMaxWidth` |
| Fixed `maxWidth: 420` in button | `custom_button.dart:27` | Medium | Use `double.infinity` + parent constraint |
| `RS` class has confusing scale logic (returns `1.0` for desktop ≥1000) | `responsive_size.dart:9-11` | High | Align with ScreenUtil or replace entirely |
| Two responsive systems running simultaneously (`flutter_screenutil` + `RS`) | Throughout | High | Pick one — prefer ScreenUtil |
| `const EdgeInsets.all(16)` ignoring ScreenUtil `.w`/`.h` extensions | `custom_text_field.dart:108` | Medium | Use `EdgeInsets.all(16.w)` |
| `SizedBox(height: 22)` and `SizedBox(width: 22)` raw pixels in button loader | `custom_button.dart:48-49` | Low | Use `22.sp` |
| No `LayoutBuilder` usage — all breakpoints via `MediaQuery.size.width` | Throughout | Medium | Prefer `LayoutBuilder` for widget-level responsiveness |
| Mobile-only platform guard for "Continue as guest" button inside login form | `login_form.dart:192` | Low | Acceptable but should be extracted to strategy |

### Breakpoint Strategy (Recommended)

```dart
class AppBreakpoints {
  static const double mobile  = 600;   // < 600  → mobile
  static const double tablet  = 1000;  // 600–999 → tablet
  static const double desktop = 1200;  // ≥ 1000 → desktop/web
}

class AppLayout {
  static bool isMobile(BuildContext c)  => MediaQuery.sizeOf(c).width < 600;
  static bool isTablet(BuildContext c)  => MediaQuery.sizeOf(c).width >= 600 && MediaQuery.sizeOf(c).width < 1000;
  static bool isDesktop(BuildContext c) => MediaQuery.sizeOf(c).width >= 1000;
}
```

---

## 8. Recommended Project Structure

```
lib/
├── core/
│   ├── api/                        # Dio client, endpoint constants, API manager
│   ├── cache/                      # SharedPreferences + SecureStorage wrappers
│   ├── di/                         # Injectable + GetIt configuration
│   ├── errors/                     # Failure types, exception mappers
│   ├── extensions/                 # Dart/Flutter extension methods
│   ├── network/                    # Connectivity checker
│   └── services/                   # FCM, local notifications, deep links
│
├── shared/
│   ├── components/                 # All reusable widgets (15+ current + new)
│   │   ├── buttons/
│   │   ├── fields/
│   │   ├── dialogs/
│   │   ├── loaders/
│   │   ├── states/                 # EmptyState, ErrorState
│   │   └── images/                 # AppNetworkImage, FullScreenImageView
│   ├── cubit/                      # AppUserCubit, LanguageCubit (app-wide state)
│   ├── enums/                      # UserRole, OrderStatus, etc.
│   ├── helpers/                    # Formatters, mappers, validators
│   └── utils/
│       ├── app_colors.dart
│       ├── app_text_styles.dart
│       ├── app_spacing.dart
│       ├── app_radius.dart
│       ├── assets_manager.dart
│       └── constants_manager.dart
│
├── config/
│   ├── routes/
│   │   ├── routes_manager.dart
│   │   └── route_guards.dart       # Auth guard middleware
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   ├── app_typography.dart
│   │   └── app_spacing.dart
│   └── localization/               # ARB files
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── data_sources/
│   │   │   ├── models/
│   │   │   └── repositories_impl/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── use_cases/
│   │   └── presentation/
│   │       ├── manager/            # Cubits / ViewModels
│   │       ├── views/              # Screen entry points only
│   │       └── widgets/            # Screen-specific components
│   │
│   ├── home/
│   │   └── presentation/
│   │       ├── customer/           # Customer home layout + tabs
│   │       └── technician/         # Technician home layout + tabs
│   │
│   ├── orders/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── customer/
│   │       └── technician/
│   │
│   ├── services/                   # Service browsing + request flow
│   ├── profile/                    # Shared profile with role-based views
│   ├── notifications/
│   ├── reviews/
│   ├── spare_parts/
│   ├── banners/
│   ├── location/
│   ├── uploads/
│   ├── onboarding/
│   └── splash/
│
├── l10n/                           # Generated ARB output
├── firebase_options.dart
└── main.dart                       # Bootstrap only — ≤ 50 lines
```

---

## 9. Refactoring Roadmap

### Phase 1 — Architecture Cleanup *(High priority)*
| Task | Complexity | Risk |
|---|---|---|
| Split `main.dart`: extract `AppBootstrap`, `SessionManager` | Low | Low |
| Remove `getIt<>()` calls from inside `build()` methods | Medium | Medium |
| Fix `techinican` typo → `technician` in folder + all imports | Low | Low |
| Remove all `debugPrint` from production paths | Low | Low |
| Move Supabase keys to `.env` / `--dart-define` | Low | Low |
| Clean up commented dead code in `main.dart` | Low | None |

### Phase 2 — Theme System *(High priority)*
| Task | Complexity | Risk |
|---|---|---|
| Create `AppColors`, `AppSpacing`, `AppRadius`, `AppElevation` | Low | Low |
| Refactor `AppTextStyles` — all responsive, no `const` with raw sizes | Low | Low |
| Update `AppTheme` to reference new token classes | Medium | Low |
| Replace all raw `Colors.*` usage with `AppColors.*` | Medium | Medium |
| Replace all hardcoded `EdgeInsets` values with `AppSpacing` | Medium | Low |
| Replace all `BorderRadius.circular(N)` with `AppRadius` tokens | Low | Low |

### Phase 3 — Shared Components *(Medium priority)*
| Task | Complexity | Risk |
|---|---|---|
| Create `EmptyStateWidget` | Low | None |
| Create `ErrorStateWidget` | Low | None |
| Create `AppNetworkImage` wrapper | Low | None |
| Create `AppScaffold` wrapper | Low | Low |
| Create `ShimmerListLoader` generic widget | Low | None |
| Migrate `ConfirmationDialog` hardcoded Arabic strings to l10n | Low | Low |
| Make all `CustomTextFormField` fields `final` | Low | Low |
| Unify `RS` class and `flutter_screenutil` — pick one system | High | Medium |

### Phase 4 — Responsive Layouts *(Medium priority)*
| Task | Complexity | Risk |
|---|---|---|
| Introduce `AppBreakpoints` + `AppLayout` helpers | Low | None |
| Replace all `MediaQuery.of(context).size.width` checks with `AppLayout` | Medium | Low |
| Flatten `home/views/mobile` and `home/views/web` using `AdaptiveLayout` | High | Medium |
| Flatten 6-level `home/tabs/customer/home/presentation/views` nesting | Medium | Low |
| Add `LayoutBuilder` to list screens for column count adaptation | Medium | Low |

### Phase 5 — Feature Refactoring *(Low priority / ongoing)*
| Task | Complexity | Risk |
|---|---|---|
| Split `otp_view.dart` (20 KB) into view + body + widgets | Medium | Low |
| Refactor `orders/shared` cross-feature coupling | High | Medium |
| Add route guards (`RouteGuard` middleware) for auth-protected routes | Medium | Low |
| Write unit tests for domain use-cases | High | Low |
| Write widget tests for shared components | Medium | Low |

---

## 10. Final Technical Assessment

| Dimension | Score | Notes |
|---|---|---|
| **Architecture** | **7 / 10** | Clean Architecture is present and consistent. Weakness: `main.dart` god-file, direct `getIt` in UI |
| **Maintainability** | **6 / 10** | Good naming + DI, but hardcoded strings, raw colors, dead code, typos reduce score |
| **Scalability** | **6 / 10** | Feature isolation is good; `orders/shared` cross-coupling and 6-level nesting hurt scalability |
| **Reusability** | **6 / 10** | 15 shared components exist but `EmptyState`, `ErrorState`, `AppScaffold`, `AppNetworkImage` are missing |
| **Responsive Readiness** | **5 / 10** | Two competing responsive systems (`RS` + ScreenUtil), platform branching duplicates code |

### Overall Score: 6 / 10

---

### Critical Pre-Redesign Improvements

> The following MUST be completed before the Figma redesign is implemented:

1. **Consolidate the responsive system** — choose `flutter_screenutil` and delete the custom `RS` class. This prevents scaling conflicts across every rebuilt screen.

2. **Build the design token layer** — `AppColors`, `AppSpacing`, `AppRadius`, `AppTypography`. All new Figma components will depend on these. Building screens before tokens means re-doing every color and size value later.

3. **Create `EmptyStateWidget` and `ErrorStateWidget`** — every new screen will need them. Building these once saves time on every feature.

4. **Slim down `main.dart`** — extract session bootstrap to a `SessionManager` service. Auth listener belongs in `AppUserCubit`, not `_MeayarAlitqanState.initState`.

5. **Remove hardcoded Arabic strings from shared components** — `ConfirmationDialog` defaults (`"نعم"`, `"لا"`) will break the EN locale for any new screen using it.

6. **Fix the `techinican` folder typo** — batch-rename before adding new technician screens to avoid confusing import paths.

7. **Wrap `CachedNetworkImage` in `AppNetworkImage`** — every redesigned screen will use network images; a shared wrapper means one place to update placeholder, error, and fit behavior.
