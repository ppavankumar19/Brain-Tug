# 🚀 QUICK START GUIDE - Brain Battle

Get your quiz game up and running in 10 minutes!

## Step 1: Supabase Setup (5 minutes)

### 1.1 Create Account & Project
1. Go to https://supabase.com
2. Click "Start your project" 
3. Sign up with GitHub/Email
4. Click "New Project"
5. Fill in:
   - Name: `brain-battle`
   - Database Password: (create strong password)
   - Region: Choose closest to you
6. Click "Create new project"
7. Wait 2-3 minutes

### 1.2 Setup Database
1. In Supabase dashboard, click "SQL Editor" (left sidebar)
2. Click "New Query"
3. Open the `database-setup.sql` file from this package
4. Copy ALL contents
5. Paste into Supabase SQL Editor
6. Click "Run" button
7. You should see: "Success. No rows returned" or query results

### 1.3 Get Your Credentials
1. Click the "Settings" icon (gear) in sidebar
2. Click "API" 
3. Find and copy:
   - **Project URL** → Something like: `https://abcdefgh.supabase.co`
   - **anon public** key → Long string starting with `eyJ...`

## Step 2: Configure App (2 minutes)

1. Open `brain-battle.html` in any text editor (VS Code, Notepad++, etc.)
2. Find lines ~14-15 (near the top of the `<script>` section):
   ```javascript
   const SUPABASE_URL = 'YOUR_SUPABASE_URL';
   const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
   ```
3. Replace with your actual values:
   ```javascript
   const SUPABASE_URL = 'https://abcdefgh.supabase.co';
   const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
   ```
4. Save the file

## Step 3: Test Locally (1 minute)

### Option A: Python (Easiest)
```bash
cd /path/to/brain-battle
python -m http.server 8000
```
Open browser: `http://localhost:8000/brain-battle.html`

### Option B: VS Code Live Server
1. Install "Live Server" extension
2. Right-click `brain-battle.html`
3. Click "Open with Live Server"

### Option C: Direct Open (may have issues)
- Just double-click `brain-battle.html`

## Step 4: Deploy (2 minutes)

### 🌟 Vercel (Recommended)
```bash
npm i -g vercel
cd /path/to/brain-battle
vercel
```
Follow prompts, done! Get instant URL.

### 🎯 Netlify Drop (No CLI)
1. Go to: https://app.netlify.com/drop
2. Drag `brain-battle.html` into page
3. Get instant URL!

### 📘 GitHub Pages
```bash
# Create repo on GitHub first
git init
git add brain-battle.html README.md
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/USERNAME/brain-battle.git
git push -u origin main

# Then: GitHub → Settings → Pages → Select branch → Save
```

## Verification Checklist

✅ Supabase project created
✅ Database setup script executed
✅ Credentials copied to HTML file
✅ File saved
✅ App tested locally
✅ App deployed online

## Common Issues

**"Loading questions..." never ends**
- Check browser console (F12)
- Verify credentials are correct
- Check Supabase project is active

**"Failed to connect"**
- Double-check URL format: `https://xyz.supabase.co` (no trailing slash)
- Verify anon key is complete (very long string)

**No questions showing**
- Verify database setup script completed
- Check Supabase → Table Editor → questions table has data

## Next Steps

1. ✏️ Add more questions (see README)
2. 🎨 Customize colors (see README)
3. 🌍 Share with friends!
4. 📊 Monitor scores in Supabase dashboard

## Support

Need help? Check:
- Full README for detailed instructions
- Supabase docs: https://supabase.com/docs
- Browser console for error messages

---

**🎮 Enjoy your game!**
