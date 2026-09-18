# FightFlow

FightFlow is a self-contained planner for university, boxing, nutrition and structured workouts.

## What is included

- Today dashboard with daily checklist and macro totals
- Weekly planner for classes, study, training, meals and life/admin
- Cookbook with macros, recipes and meal-prep flags
- Workout library for boxing, cardio, calisthenics, strength and mobility
- Browser-local persistence
- Optional Supabase cloud sync across phone and computer
- Email/password authentication
- PWA manifest + service worker for installation on phone/desktop
- JSON export/import backup
- GitHub Pages deployment workflow

## Cloud architecture

GitHub Pages hosts the static application. Supabase stores one private JSON record per authenticated FightFlow user. The browser uses only the Supabase publishable key; Row Level Security restricts database access to the signed-in user's row.

Do not put a Supabase secret/service-role key in the browser.

## One-time setup

### 1. Create a free Supabase project

Create a project in the Supabase dashboard.

### 2. Create the FightFlow table

Open the Supabase SQL Editor and run the complete contents of:

`supabase-schema.sql`

The SQL enables Row Level Security and grants the authenticated role only the access needed by FightFlow.

### 3. Configure Supabase Auth

Enable email/password authentication.

For a GitHub Pages deployment, set the Supabase Auth Site URL to the URL GitHub gives your Pages site, for example:

`https://YOUR-USERNAME.github.io/fightflow/`

If you test locally with the included launcher, also allow your local URL, normally:

`http://localhost:8000/`

### 4. Add the Supabase project credentials

Open `supabase-config.js` and replace:

- `YOUR_SUPABASE_PROJECT_URL`
- `YOUR_SUPABASE_PUBLISHABLE_KEY`

Use the project URL and browser-safe publishable key from Supabase. Never use the secret/service-role key.

### 5. Test locally

On Windows, double-click `launch_windows.bat`.

It starts a local HTTP server at `http://localhost:8000/` so the PWA service worker can run during development.

### 6. Publish with GitHub Pages

Put the contents of this folder at the root of a GitHub repository. The included GitHub Actions workflow publishes the repository to GitHub Pages whenever `main` changes.

In GitHub:

1. Open the repository.
2. Go to Settings → Pages.
3. Set the build/deployment source to GitHub Actions.
4. Push the project to `main`.

GitHub will provide the live site URL.

### 7. Sign in on your first device

Open FightFlow on the computer, create an account, and sign in.

If no cloud record exists yet, FightFlow uploads the planner currently stored in that browser. This makes it possible to migrate the existing local planner without manually rebuilding it.

### 8. Use the same account on your phone

Open the same GitHub Pages URL on your phone and sign in with the same FightFlow account. The cloud planner will load automatically.

You can then install the PWA to your home screen if your browser supports it.

## Sync behaviour

- Local browser storage remains enabled as a fallback.
- Saved changes are queued for cloud sync shortly after an edit.
- FightFlow checks for cloud changes periodically while open.
- The “Upload this device” action intentionally replaces the cloud record with the current browser copy.
- The “Sync now” action pulls the current cloud record.
- JSON export/import remains available as a separate backup mechanism.

This version uses a simple last-write-wins model because the app is intended for one person using multiple devices rather than simultaneous multi-user editing.
