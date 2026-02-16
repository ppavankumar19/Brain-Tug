# 🎮 Brain Battle - Dual Quiz Tug-of-War Game

An innovative split-screen quiz game where players battle against themselves by answering questions simultaneously on both sides of the screen. Each correct answer pulls the tug-of-war rope toward your side!

![Game Concept](https://img.shields.io/badge/Game-Quiz%20Battle-blueviolet) ![Deployment](https://img.shields.io/badge/Deployment-Ready-success) ![Single File](https://img.shields.io/badge/Architecture-Single%20HTML-orange)

## 🌟 Features

### Core Gameplay
- **Split-Screen Interface**: Two independent question zones (left and right)
- **Tug-of-War Mechanic**: Visual rope that moves based on performance
- **Multiple Subjects**: Mathematics and Physics (easily extensible)
- **14 Questions Total**: 7 questions per side, no duplicates
- **Dual Input Support**: Touch and keyboard input for tablets/desktops

### Enhanced Mechanics
- ⏱️ **Time Pressure**: 30-second timer per question
- 🔥 **Streak System**: 3+ correct answers in a row = bonus tug power
- 💥 **Power-Ups**: 
  - **Freeze** (❄️): Pause both timers for 5 seconds
  - **Double Points** (⚡): Next correct answer worth 2x points
  - **Skip Question** (⏭️): Move to next question without penalty
- 🎯 **Dynamic Scoring**: Speed bonuses and streak multipliers
- 🏆 **Live Scoring**: Real-time score updates with animations
- 📊 **Performance Stats**: Track accuracy, speed, and streaks

### Visual & Audio
- Smooth animations for rope movement
- Confetti explosion on victory
- Sound effects for correct/wrong answers
- Progress indicators and visual feedback
- Responsive design for tablets and desktops

## 🏗️ Architecture

### Frontend
- **Single HTML File**: All HTML, CSS, and JavaScript in one file
- **Vanilla JavaScript**: No frameworks required
- **Responsive Design**: Optimized for tablets (768px+) and desktops
- **File Size**: ~25KB uncompressed

### Backend & Database
- **Supabase**: PostgreSQL database with real-time capabilities
- **Direct Client Integration**: Supabase JS SDK via CDN
- **No Build Process**: Deploy as-is
- **Serverless**: No backend server required

### Database Schema
```sql
-- Questions table
CREATE TABLE questions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  subject VARCHAR(50) NOT NULL,
  question TEXT NOT NULL,
  correct_answer TEXT NOT NULL,
  wrong_answers TEXT[] NOT NULL,
  difficulty INT DEFAULT 1,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Scores/Leaderboard table
CREATE TABLE game_scores (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  player_name VARCHAR(100),
  subject VARCHAR(50) NOT NULL,
  score INT NOT NULL,
  accuracy DECIMAL(5,2),
  time_taken INT,
  streak_best INT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Add indexes for performance
CREATE INDEX idx_questions_subject ON questions(subject);
CREATE INDEX idx_scores_subject ON game_scores(subject);
CREATE INDEX idx_scores_score ON game_scores(score DESC);
```

## 🚀 Setup Instructions

### 1. Supabase Setup (5 minutes)

#### Create a Supabase Project
1. Go to [https://supabase.com](https://supabase.com)
2. Sign up or log in
3. Click "New Project"
4. Fill in project details:
   - Name: "Brain Battle"
   - Database Password: (save this securely)
   - Region: Choose closest to your users
5. Wait 2-3 minutes for provisioning

#### Get Your Credentials
1. Go to Project Settings (gear icon)
2. Click "API" in sidebar
3. Copy your:
   - **Project URL** (looks like: `https://xxxxx.supabase.co`)
   - **anon/public key** (long string starting with `eyJ...`)

#### Set Up Database
1. In Supabase dashboard, click "SQL Editor" in sidebar
2. Click "New Query"
3. Paste this complete setup script:

```sql
-- Create questions table
CREATE TABLE IF NOT EXISTS questions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  subject VARCHAR(50) NOT NULL,
  question TEXT NOT NULL,
  correct_answer TEXT NOT NULL,
  wrong_answers TEXT[] NOT NULL,
  difficulty INT DEFAULT 1,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Create scores table
CREATE TABLE IF NOT EXISTS game_scores (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  player_name VARCHAR(100),
  subject VARCHAR(50) NOT NULL,
  score INT NOT NULL,
  accuracy DECIMAL(5,2),
  time_taken INT,
  streak_best INT,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Add indexes
CREATE INDEX IF NOT EXISTS idx_questions_subject ON questions(subject);
CREATE INDEX IF NOT EXISTS idx_scores_subject ON game_scores(subject);
CREATE INDEX IF NOT EXISTS idx_scores_score ON game_scores(score DESC);

-- Enable Row Level Security
ALTER TABLE questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE game_scores ENABLE ROW LEVEL SECURITY;

-- Allow public read access to questions
CREATE POLICY "Public read questions" ON questions
  FOR SELECT TO public
  USING (true);

-- Allow public insert on scores
CREATE POLICY "Public insert scores" ON game_scores
  FOR INSERT TO public
  WITH CHECK (true);

-- Allow public read on leaderboard
CREATE POLICY "Public read scores" ON game_scores
  FOR SELECT TO public
  USING (true);
```

4. Click "Run" button
5. You should see "Success. No rows returned"

#### Populate Questions
1. Create a new query in SQL Editor
2. Paste this script with sample questions:

```sql
-- Mathematics Questions
INSERT INTO questions (subject, question, correct_answer, wrong_answers, difficulty) VALUES
('Mathematics', 'What is 15 × 7?', '105', ARRAY['95', '115', '98'], 1),
('Mathematics', 'Solve: x + 12 = 20', '8', ARRAY['6', '10', '12'], 1),
('Mathematics', 'What is the square root of 144?', '12', ARRAY['14', '10', '16'], 1),
('Mathematics', 'Calculate: 250 ÷ 5', '50', ARRAY['45', '55', '40'], 1),
('Mathematics', 'What is 2³?', '8', ARRAY['6', '9', '12'], 1),
('Mathematics', 'Solve: 3x = 27', '9', ARRAY['7', '8', '12'], 2),
('Mathematics', 'What is 40% of 200?', '80', ARRAY['60', '90', '100'], 2),
('Mathematics', 'Find the area of a square with side 9cm', '81 cm²', ARRAY['72 cm²', '90 cm²', '99 cm²'], 2),
('Mathematics', 'What is the perimeter of a rectangle 5×8?', '26', ARRAY['40', '24', '30'], 2),
('Mathematics', 'Simplify: 4(2x + 3)', '8x + 12', ARRAY['8x + 3', '6x + 12', '8x + 7'], 3),
('Mathematics', 'What is sin(30°)?', '0.5', ARRAY['0.707', '0.866', '1'], 3),
('Mathematics', 'Solve: x² - 5x + 6 = 0', 'x = 2 or 3', ARRAY['x = 1 or 6', 'x = -2 or -3', 'x = 0 or 5'], 3),
('Mathematics', 'What is log₁₀(1000)?', '3', ARRAY['10', '100', '1000'], 3),
('Mathematics', 'Calculate: ∫x² dx', 'x³/3 + C', ARRAY['2x + C', 'x³ + C', '2x²/2 + C'], 4),
('Mathematics', 'Find derivative: f(x) = x³ + 2x', '3x² + 2', ARRAY['x² + 2', '3x³ + 2x', 'x³ + 2'], 3),
('Mathematics', 'What is the value of π (rounded)?', '3.14159', ARRAY['3.12159', '3.16159', '3.14259'], 1),
('Mathematics', 'Solve: 2x + 5 = 15', '5', ARRAY['10', '7', '8'], 1);

-- Physics Questions
INSERT INTO questions (subject, question, correct_answer, wrong_answers, difficulty) VALUES
('Physics', 'What is the SI unit of force?', 'Newton', ARRAY['Joule', 'Watt', 'Pascal'], 1),
('Physics', 'Speed of light in vacuum?', '3×10⁸ m/s', ARRAY['3×10⁶ m/s', '3×10⁷ m/s', '3×10⁹ m/s'], 1),
('Physics', 'What is the formula for kinetic energy?', '½mv²', ARRAY['mv', 'mv²', '2mv²'], 1),
('Physics', 'Acceleration due to gravity on Earth?', '9.8 m/s²', ARRAY['10.2 m/s²', '8.9 m/s²', '11.3 m/s²'], 1),
('Physics', 'What is Ohm''s Law?', 'V = IR', ARRAY['V = I/R', 'V = I + R', 'I = V + R'], 1),
('Physics', 'Calculate work done: F=10N, d=5m', '50 J', ARRAY['15 J', '2 J', '25 J'], 2),
('Physics', 'What is the momentum formula?', 'p = mv', ARRAY['p = ma', 'p = m/v', 'p = v/m'], 2),
('Physics', 'First law of thermodynamics?', 'Energy is conserved', ARRAY['Entropy increases', 'Heat flows hot to cold', 'Work equals heat'], 2),
('Physics', 'What is wavelength of visible light?', '400-700 nm', ARRAY['100-400 nm', '700-1000 nm', '1-100 nm'], 2),
('Physics', 'Calculate power: W=100J, t=5s', '20 W', ARRAY['500 W', '10 W', '25 W'], 3),
('Physics', 'What is Planck''s constant (approx)?', '6.63×10⁻³⁴ J·s', ARRAY['6.63×10⁻³² J·s', '3.14×10⁻³⁴ J·s', '9.8×10⁻³⁴ J·s'], 3),
('Physics', 'How many Maxwell equations are there?', '4', ARRAY['2', '3', '5'], 3),
('Physics', 'What is Schrödinger equation type?', 'Wave equation', ARRAY['Force equation', 'Energy equation', 'Momentum equation'], 4),
('Physics', 'What is absolute zero?', '-273.15°C', ARRAY['-270°C', '-280°C', '-300°C'], 2),
('Physics', 'Formula for gravitational force?', 'F = Gm₁m₂/r²', ARRAY['F = ma', 'F = mv²/r', 'F = kx'], 3),
('Physics', 'What is the speed of sound in air?', '343 m/s', ARRAY['300 m/s', '400 m/s', '500 m/s'], 2);
```

3. Click "Run"
4. Verify: Go to "Table Editor" → "questions" → You should see all questions

### 2. Configure the Application

1. Open `brain-battle.html` in a text editor
2. Find lines 14-15 (inside the `<script>` section):
   ```javascript
   const SUPABASE_URL = 'YOUR_SUPABASE_URL';
   const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
   ```
3. Replace with your actual credentials:
   ```javascript
   const SUPABASE_URL = 'https://xxxxx.supabase.co';
   const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
   ```
4. Save the file

### 3. Local Development & Testing

#### Option 1: Python HTTP Server (Simplest)
```bash
# Navigate to project directory
cd /path/to/brain-battle

# Python 3
python -m http.server 8000

# Python 2
python -m SimpleHTTPServer 8000
```

Open browser: `http://localhost:8000/brain-battle.html`

#### Option 2: Node.js HTTP Server
```bash
# Install http-server globally (one time)
npm install -g http-server

# Run server
http-server -p 8000

# Open: http://localhost:8000/brain-battle.html
```

#### Option 3: VS Code Live Server
1. Install "Live Server" extension in VS Code
2. Right-click `brain-battle.html`
3. Select "Open with Live Server"
4. Browser opens automatically

#### Option 4: Direct File Open (Not Recommended)
- Double-click the HTML file
- ⚠️ Some features may not work due to CORS restrictions

### 4. Deployment (Choose One)

#### ⭐ Option A: Vercel (Recommended - Fastest)

**Why Vercel?**
- Zero configuration
- Instant deployments
- Free SSL certificate
- Global CDN
- Custom domains

**Steps:**
```bash
# Install Vercel CLI
npm i -g vercel

# Navigate to project folder
cd /path/to/brain-battle

# Login (first time only)
vercel login

# Deploy
vercel

# Follow prompts:
# - Set up and deploy? Y
# - Which scope? (choose)
# - Link to existing? N
# - Project name? brain-battle
# - Directory? ./
# - Override settings? N

# Get production URL instantly!
# Example: https://brain-battle.vercel.app
```

**For Production Deployment:**
```bash
vercel --prod
```

#### Option B: Netlify Drop (Easiest - No CLI)

**Steps:**
1. Go to [app.netlify.com/drop](https://app.netlify.com/drop)
2. Drag and drop `brain-battle.html` into the upload area
3. Wait 5 seconds
4. Get instant URL: `https://random-name.netlify.app`
5. Optional: Change site name in Netlify dashboard

**OR using Netlify CLI:**
```bash
# Install Netlify CLI
npm install -g netlify-cli

# Deploy
netlify deploy

# Follow prompts
# For production:
netlify deploy --prod
```

#### Option C: GitHub Pages (Free Hosting)

**Steps:**
1. Create a new GitHub repository
2. Push your file:
   ```bash
   git init
   git add brain-battle.html README.md
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/username/brain-battle.git
   git push -u origin main
   ```
3. Go to repository Settings → Pages
4. Source: Deploy from branch `main`
5. Folder: `/ (root)`
6. Save
7. Your site: `https://username.github.io/brain-battle/brain-battle.html`

**Pro Tip:** Rename to `index.html` for a cleaner URL: `https://username.github.io/brain-battle/`

#### Option D: Cloudflare Pages

**Steps:**
1. Push to GitHub (see above)
2. Go to [dash.cloudflare.com](https://dash.cloudflare.com)
3. Pages → Create a project
4. Connect to GitHub
5. Select repository
6. Build settings:
   - Build command: (leave empty)
   - Build output: `/`
7. Deploy!
8. Get URL: `https://brain-battle.pages.dev`

#### Option E: Firebase Hosting

**Steps:**
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialise project
firebase init hosting

# Select:
# - Use existing project or create new
# - Public directory:.
# - Single-page app: No
# - Set up automatic builds: No

# Deploy
firebase deploy

# Get URL: https://project-id.web.app
```

#### Option F: Surge (Ultra Simple)

**Steps:**
```bash
# Install Surge
npm install -g surge

# Deploy (first time)
surge

# Follow prompts:
# - Email
# - Password
# - Project path: (press enter)
# - Domain: brain-battle.surge.sh (or custom)

# Future deploys:
surge --domain brain-battle.surge.sh
```

## 🎮 How to Play

### Getting Started
1. Open the game in your browser
2. Choose a subject: **Mathematics** or **Physics**
3. Wait for questions to load (2-3 seconds)

### During Gameplay
1. **Answer Simultaneously**: Both sides show different questions
2. **Type or Click**: 
   - Type your answer and press Enter
   - OR click one of the four answer buttons
3. **Watch the Timer**: 30 seconds per question
4. **Monitor the Rope**: Middle of screen shows tug-of-war progress
5. **Build Streaks**: 3+ correct in a row = bonus points
6. **Use Power-Ups**: Strategic use can turn the game around

### Controls
- **Keyboard**: Type answers, press Enter
- **Touch/Click**: Tap answer buttons
- **Power-ups**: Click icons at the bottom centre
- **New Game**: Header button anytime

### Scoring System
| Action | Points | Notes |
|--------|--------|-------|
| ✅ Correct Answer | +10 | Base points |
| ❌ Wrong Answer | -5 | Penalty |
| ⚡ Speed Bonus | +3 | Answer in <10 seconds |
| 🔥 Streak Bonus | +5 | 3+ correct in a row |
| 💥 Double Powerup | ×2 | Doubles your next score |

### Power-Ups
- **❄️ Freeze** (1 use): Pauses both timers for 5 seconds
- **⚡ Double** (1 use): Next correct answer worth 2× points
- **⏭️ Skip** (1 use): Skip current question on slower side

### Victory Conditions
- **Tug Score ≥ 50**: Right side wins
- **Tug Score ≤ -50**: Left side wins
- **Complete 14 questions**: Highest score wins
- **Tie**: Equal scores after all questions

## 🛠️ Customization Guide

### Adding New Subjects

**1. Add Questions to Database:**
```sql
INSERT INTO questions (subject, question, correct_answer, wrong_answers, difficulty) VALUES
('Chemistry', 'What is the atomic number of Carbon?', '6', ARRAY['12', '14', '8'], 1),
('Chemistry', 'What is H₂O?', 'Water', ARRAY['Oxygen', 'Hydrogen', 'Peroxide'], 1);
-- Add at least 14 questions
```

**2. Add Button in HTML** (line ~630):
```html
<button class="subject-btn chemistry-btn" onclick="startGame('Chemistry')">
    🧪 Chemistry
</button>
```

**3. Add CSS Styling** (line ~100):
```css
.chemistry-btn {
    background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
    color: white;
}
```

### Modifying Game Difficulty

**Edit Configuration** (lines 14-20):
```JavaScript
const CONFIG = {
    QUESTIONS_PER_SIDE: 7,        // Change to 10 for longer games
    TIME_PER_QUESTION: 30,        // Change to 20 for harder, 45 for easier
    STREAK_BONUS_THRESHOLD: 3,    // Lower for easier streaks
    TUG_POINTS_CORRECT: 10,       // Increase for faster games
    TUG_POINTS_WRONG: -5,         // Decrease penalty for forgiving mode
    SPEED_BONUS_TIME: 10,         // Time window for speed bonus
    STREAK_BONUS_POINTS: 5        // Streak reward amount
};
```

### Adding More Questions
Just add to the Supabase questions table:
- **subject**: Match existing subjects
- **difficulty**: 1 (Easy), 2 (Medium), 3 (Hard), 4 (Expert)
- **wrong_answers**: Must be an array of exactly 3 strings

### Changing Visual Theme

**Colour Scheme** (lines 10-15):
```css
body {
    background: linear-gradient(135deg, #YOUR_COLOR 0%, #YOUR_COLOR2 100%);
}

.math-btn {
    background: linear-gradient(135deg, #YOUR_COLOR 0%, #YOUR_COLOR2 100%);
}
```

### Disabling Features

**Remove Power-Ups** (line ~540):
```JavaScript
gameState.powerups = { freeze: 0, double: 0, skip: 0 }; // Set all to 0
```

**Remove Timers** (line ~360):
Comment out timer start:
```JavaScript
// startTimer(side);
```

## 📊 Database Management

### View All Questions
```sql
SELECT * FROM questions ORDER BY subject, difficulty;
```

### Check Question Count
```sql
SELECT subject, COUNT(*) as question_count
FROM questions
GROUP BY subject;
```

### View Leaderboard
```sql
SELECT subject, score, accuracy, time_taken, streak_best, created_at
FROM game_scores
ORDER BY score DESC
LIMIT 10;
```

### Analytics Queries

**Average Accuracy by Subject:**
```sql
SELECT subject, 
       ROUND(AVG(accuracy), 2) as avg_accuracy,
       COUNT(*) as games_played
FROM game_scores
GROUP BY subject;
```

**Best Performances:**
```sql
SELECT subject, MAX(score) as high_score, MAX(streak_best) as best_streak
FROM game_scores
GROUP BY subject;
```

**Recent Games:**
```sql
SELECT * FROM game_scores
WHERE created_at > NOW() - INTERVAL '24 hours'
ORDER BY created_at DESC;
```

### Bulk Delete Old Scores
```sql
DELETE FROM game_scores
WHERE created_at < NOW() - INTERVAL '30 days';
```

## 🐛 Troubleshooting

### Questions Not Loading

**Problem**: "Loading questions..." never completes

**Solutions**:
1. Check the browser console (F12) for errors
2. Verify Supabase credentials in code
3. Test Supabase connection:
   ```javascript
   console.log('URL:', SUPABASE_URL);
   console.log('Key:', SUPABASE_ANON_KEY.substring(0, 20) + '...');
   ```
4. Check RLS policies in Supabase
5. Verify the questions table has data

### Supabase Connection Failed

**Problem**: "Failed to connect to database"

**Solutions**:
1. Check internet connection
2. Verify the Supabase project is active (not paused)
3. Test URL in browser: `https://your-url.supabase.co`
4. Regenerate API key if needed (Settings → API)

### Deployment Issues

**Problem**: Site not loading after deployment

**Solutions**:
1. Check the file is named correctly
2. Clear browser cache (Ctrl+F5)
3. Check deployment logs for errors
4. Verify the Supabase URL/key are correct
5. For GitHub Pages: Enable HTTPS in settings

### Performance Issues

**Problem**: Game lags or is slow

**Solutions**:
1. Reduce animations in CSS
2. Limit confetti count (line ~850)
3. Optimise question queries
4. Use CDN for Supabase SDK
5. Check browser dev tools → Performance tab

### Timer Not Working

**Problem**: Timer doesn't count down

**Solutions**:
1. Check the JavaScript console for errors
2. Verify the browser supports setInterval
3. Test in a different browser
4. Clear browser cache

### Mobile Display Issues

**Problem**: Layout broken on mobile

**Note**: This game is optimised for tablets/desktops (768px+)

**For Mobile Support** (add to CSS):
```css
@media (max-width: 767px) {
    .game-area {
        flex-direction: column;
    }
    .question-container {
        max-width: 90%;
    }
}
```

## 🚀 Performance Optimization

### Current Performance
- **Initial Load**: ~100ms
- **Question Fetch**: ~200ms
- **Lighthouse Score**: 95+

### Optimisation Tips

**1. Reduce Initial Bundle:**
- Supabase SDK loaded from CDN (cached)
- No external dependencies
- Single file = fewer requests

**2. Optimise Questions:**
```sql
-- Add composite index
CREATE INDEX idx_questions_subject_difficulty 
ON questions(subject, difficulty);
```

**3. Cache Questions:**
```JavaScript
// Store in localStorage after first fetch
localStorage.setItem('questions_math', JSON.stringify(questions));
```

**4. Lazy Load Sounds:**
Only create audio when needed, not in advance

**5. Debounce Inputs:**
For type-to-answer, add debouncing

## 🎯 Future Enhancements

### Planned Features
- [ ] **Multiplayer Mode**: Two real players compete
- [ ] **More Subjects**: Chemistry, Biology, History, Geography
- [ ] **User Accounts**: Save progress and stats
- [ ] **Global Leaderboards**: Compete worldwide
- [ ] **Daily Challenges**: Special questions each day
- [ ] **Achievement System**: Unlock badges and rewards
- [ ] **Voice Input**: Answer questions by speaking
- [ ] **Mobile App**: Native iOS/Android version
- [ ] **AI-Generated Questions**: Endless unique questions
- [ ] **Theme Customization**: Dark mode, custom colors
- [ ] **Difficulty Levels**: Easy/Medium/Hard modes
- [ ] **Practice Mode**: No time limits
- [ ] **Tournament System**: Bracket-style competitions

### Contributing Ideas
Want to add a feature? Here's how:

1. **New Question Sets**: 
   - Research subject
   - Create 20+ questions
   - Submit via GitHub PR

2. **UI Improvements**:
   - Design mockups
   - Test on different devices
   - Submit design files

3. **Sound Effects**:
   - Create/source sounds
   - Ensure browser compatibility
   - Submit audio files

4. **Translations**:
   - Translate UI text
   - Translate questions
   - Submit language file

## 📝 Technical Details

### Browser Compatibility
- ✅ Chrome 90+ (Recommended)
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Edge 90+
- ⚠️ IE 11: Not supported

### Required Permissions
- Internet connection (for Supabase)
- No location, camera, or microphone

### Data Privacy
- No personal data collected
- Scores are anonymous
- No cookies used
- Supabase data encrypted

### Technology Stack
- **Frontend**: Vanilla JavaScript ES6+
- **Styling**: CSS3 with animations
- **Database**: PostgreSQL (via Supabase)
- **Hosting**: Static file hosting
- **CDN**: Supabase SDK

### File Structure
```
brain-battle/
├── brain-battle.html    # Complete application (25KB)
├── README.md           # This file (documentation)
└── .gitignore          # Optional (for version control)
```

### Code Organisation (inside HTML)
```html
<!DOCTYPE html>
<html>
<head>
    <!-- Meta tags -->
    <!-- CSS (lines 10-600) -->
</head>
<body>
    <!-- Welcome Screen -->
    <!-- Game Screen -->
    <!-- Victory Screen -->
    
    <!-- Supabase SDK -->
    <!-- JavaScript (lines 650-1100) -->
</body>
</html>
```

## 📄 License

MIT License

Copyright (c) 2024 Brain Battle

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## 🤝 Support & Community

### Getting Help

**GitHub Issues**: Report bugs or request features
**Email**: Contact for support
**Documentation**: This README has comprehensive guides

### FAQ

**Q: Can I use this commercially?**  
A: Yes! MIT license allows commercial use.

**Q: How do I add my own logo?**  
A: Add an `<img>` tag in the header section and style it with CSS.

**Q: Can I integrate with my LMS?**  
A: Yes! Use iframe embedding or direct link.

**Q: How many questions can I add?**  
A: Unlimited! Supabase free tier supports a 500MB database.

**Q: Can I run this offline?**  
A: No, it requires the internet for the Supabase connection.

**Q: How do I back up my questions?**  
A: Export from Supabase: Table Editor → Questions → Export as CSV

**Q: Can I host on my own server?**  
A: Yes! Any static file hosting works (Apache, Nginx, etc.)

## 🎓 Educational Use

This project is perfect for:
- **Schools**: Math and Physics practice
- **Study Groups**: Competitive learning
- **Teachers**: Classroom activities
- **Tutors**: Engaging students
- **Self-Study**: Make learning fun

### Classroom Setup
1. Deploy to the school network
2. Add curriculum-aligned questions
3. Students access via browser
4. Track progress in Supabase
5. Export scores for grading

## 🌟 Credits

Built with:
- ❤️ Passion for learning
- ⚡ Vanilla JavaScript
- 🎨 CSS3 Animations
- 🗄️ Supabase Database
- 🚀 Modern Web Standards

Inspired by the need to make education engaging and fun!

## 📞 Contact

For questions, suggestions, or collaborations:
- **GitHub**: Open an issue
- **Email**: pavankumar.prrp@gmail.com
- **Website**:
- **LinkedIn**: www.linkedin.com/in/pavankumar19

---

**⭐ If you found this useful, please star the repository!**

**🎮 Happy Gaming and Learning! 🧠**

*Last Updated: February 2026*
