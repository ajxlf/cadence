# Cadence

Cadence is a self-contained planner for university, fitness, nutrition, reflection and structured workouts.

## What is included

- Today dashboard with daily checklist and macro totals
- Weekly planner for classes, study, training, meals and life/admin
- Cookbook with macros, recipes and meal-prep flags
- Workout library for cardio, calisthenics, strength, mobility and sport
- Browser-local persistence
- Automatic Supabase cloud sync across phone and computer
- Email/password authentication
- PWA manifest + service worker for installation on phone/desktop
- JSON export/import backup
- GitHub Pages deployment workflow

## Cloud architecture

GitHub Pages hosts the static application. Supabase stores one private JSON record per authenticated Cadence user. The browser uses only the Supabase publishable key; Row Level Security restricts database access to the signed-in user's row.
