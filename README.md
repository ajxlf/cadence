# Cadence

Cadence is a personal planner for organising everyday life across planning, fitness, nutrition and reflection. It is designed to keep the user's day visible without turning planning into a complicated project-management system.

## Current features

### Today
- Daily dashboard for the selected day
- **Daily Actions** progress tracking across both activities and planned meals
- Tick activities and meals as completed; completion updates Daily Actions immediately
- Planned activities with time, type and notes
- Planned meals with recipes, servings and macros
- Daily calorie and macro budget
- Daily weight entry in kilograms
- Weight change compared with the previous logged weigh-in
- Daily checklist
- Next-day preview
- Journal preview and quick access

### Weekly planner
- Seven-day calendar view
- Add, edit and delete activities and meals
- Plan university classes, study blocks, training, admin and other activities
- **Weekly recurring activities**, such as a class or training session
- Choose the weekday/time from the starting activity and repeat weekly until a chosen date
- Recurring activities are represented as individual dated occurrences so each occurrence can be completed independently

### Calorie calculator
- Mifflin–St Jeor based calorie estimation
- BMR and estimated maintenance calories
- Activity-level adjustment
- Weight-loss and weight-gain goals
- Weekly weight-change targets such as **0.25, 0.5, 0.75 or 1 kg/week**
- Internal conversion from weekly weight change to a daily calorie adjustment
- Macro recommendations
- Macro approach options including balanced, protein-focused, lower-carb, higher-carb and higher-fat
- Manually editable macro targets in Settings

### Cookbook
- Recipe library with calories and macros
- Breakfast, main, dinner, snack and dessert categories
- Favourites and meal-prep filtering
- Recipe creation, editing, copying and planning
- Starter recipes included for new accounts

### Workouts
- Workout library for cardio, strength, calisthenics, mobility and general training
- Workout creation and editing
- Starter home workouts, HIIT, walking and mobility sessions
- Workouts can be added to the planner as activities

### Journal
- Daily journal entries
- Mood selection
- Gratitude, mindfulness and tomorrow reflection prompts
- Daily affirmations
- Navigate between previous and future journal dates

### Accounts and cloud sync
- Supabase email/password authentication
- Email verification flow
- Resend verification email
- Forgot-password and password-reset flow
- Automatic cloud synchronisation
- Supabase Realtime updates between signed-in devices
- Local persistence so the planner remains available in the browser
- JSON export/import backup

### Personalisation
- Light and dark mode
- Selectable accent colours
- Responsive desktop and mobile layouts
- PWA support for installation on supported devices

## Architecture

Cadence is currently a lightweight static web application.

- **Frontend:** HTML, CSS and vanilla JavaScript
- **Hosting:** GitHub Pages
- **Authentication:** Supabase Auth
- **Database:** Supabase PostgreSQL via the `fightflow_data` table
- **Realtime sync:** Supabase Realtime
- **Local storage:** Browser `localStorage`
- **PWA:** Web App Manifest + Service Worker
- **Configuration:** `supabase-config.js`

The browser uses a Supabase publishable key. User planner data is stored as a private JSON payload associated with the authenticated user's ID, with database access controlled through Supabase Row Level Security.

## Repository structure

```text
cadence/
├── index.html              # Main application
├── supabase-config.js      # Supabase project URL and publishable key
├── sw.js                   # PWA service worker and cache
├── manifest.webmanifest    # PWA metadata
├── icon-192.png            # App icon
├── icon-512.png            # App icon
└── README.md               # Project documentation
```

## Running locally

Cadence is a client-side application, so the frontend can be served with any simple static web server.

For example:

```bash
python -m http.server 8000
```

Then open:

```text
http://localhost:8000
```

The Supabase configuration in `supabase-config.js` must point to the project being used.

## Deployment

The production site is deployed through GitHub Pages from this repository.

When authentication is enabled, the deployed Cadence URL must also be configured as an allowed redirect URL in the Supabase project's Authentication URL Configuration.

## Data model

The main planner payload currently contains:

- `settings`
- `recipes`
- `workouts`
- `events`
- `meals`
- `weights`
- `journals`

Activities may contain recurrence metadata for weekly recurring schedules. Each occurrence remains a separate planner item so completion status can be tracked independently.

## Project status

Cadence is an actively developed personal-planning application. The current implementation prioritises a simple interface, mobile usability, local-first persistence and cross-device cloud synchronisation while keeping the frontend lightweight.
