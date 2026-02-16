-- ==========================================
-- BRAIN BATTLE - SUPABASE SETUP SCRIPT
-- ==========================================
-- Complete database setup for Brain Battle quiz game
-- Run this entire script in Supabase SQL Editor

-- ==========================================
-- 1. CREATE TABLES
-- ==========================================

-- Questions table - stores all quiz questions
CREATE TABLE IF NOT EXISTS questions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  subject VARCHAR(50) NOT NULL,
  question TEXT NOT NULL,
  correct_answer TEXT NOT NULL,
  wrong_answers TEXT[] NOT NULL,
  difficulty INT DEFAULT 1,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Game scores table - stores player performance
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

-- ==========================================
-- 2. CREATE INDEXES FOR PERFORMANCE
-- ==========================================

CREATE INDEX IF NOT EXISTS idx_questions_subject ON questions(subject);
CREATE INDEX IF NOT EXISTS idx_questions_difficulty ON questions(difficulty);
CREATE INDEX IF NOT EXISTS idx_scores_subject ON game_scores(subject);
CREATE INDEX IF NOT EXISTS idx_scores_score ON game_scores(score DESC);
CREATE INDEX IF NOT EXISTS idx_scores_created ON game_scores(created_at DESC);

-- ==========================================
-- 3. ENABLE ROW LEVEL SECURITY
-- ==========================================

ALTER TABLE questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE game_scores ENABLE ROW LEVEL SECURITY;

-- ==========================================
-- 4. CREATE RLS POLICIES
-- ==========================================

-- Allow public read access to questions
DROP POLICY IF EXISTS "Public read questions" ON questions;
CREATE POLICY "Public read questions" ON questions
  FOR SELECT TO public
  USING (true);

-- Allow public insert on scores
DROP POLICY IF EXISTS "Public insert scores" ON game_scores;
CREATE POLICY "Public insert scores" ON game_scores
  FOR INSERT TO public
  WITH CHECK (true);

-- Allow public read on scores (for leaderboard)
DROP POLICY IF EXISTS "Public read scores" ON game_scores;
CREATE POLICY "Public read scores" ON game_scores
  FOR SELECT TO public
  USING (true);

-- ==========================================
-- 5. INSERT SAMPLE QUESTIONS - MATHEMATICS
-- ==========================================

INSERT INTO questions (subject, question, correct_answer, wrong_answers, difficulty) VALUES
-- Easy (Difficulty 1)
('Mathematics', 'What is 15 × 7?', '105', ARRAY['95', '115', '98'], 1),
('Mathematics', 'Solve: x + 12 = 20', '8', ARRAY['6', '10', '12'], 1),
('Mathematics', 'What is the square root of 144?', '12', ARRAY['14', '10', '16'], 1),
('Mathematics', 'Calculate: 250 ÷ 5', '50', ARRAY['45', '55', '40'], 1),
('Mathematics', 'What is 2³?', '8', ARRAY['6', '9', '12'], 1),
('Mathematics', 'What is 13 + 29?', '42', ARRAY['41', '43', '40'], 1),
('Mathematics', 'What is 100 - 37?', '63', ARRAY['73', '53', '67'], 1),
('Mathematics', 'What is the value of π (rounded)?', '3.14159', ARRAY['3.12159', '3.16159', '3.14259'], 1),

-- Medium (Difficulty 2)
('Mathematics', 'Solve: 3x = 27', '9', ARRAY['7', '8', '12'], 2),
('Mathematics', 'What is 40% of 200?', '80', ARRAY['60', '90', '100'], 2),
('Mathematics', 'Find the area of a square with side 9cm', '81 cm²', ARRAY['72 cm²', '90 cm²', '99 cm²'], 2),
('Mathematics', 'What is the perimeter of a rectangle 5×8?', '26', ARRAY['40', '24', '30'], 2),
('Mathematics', 'Calculate: 15² - 10²', '125', ARRAY['225', '100', '175'], 2),
('Mathematics', 'What is 3/4 as a decimal?', '0.75', ARRAY['0.34', '0.43', '0.25'], 2),
('Mathematics', 'Solve: 2x + 5 = 15', '5', ARRAY['10', '7', '8'], 2),

-- Hard (Difficulty 3)
('Mathematics', 'Simplify: 4(2x + 3)', '8x + 12', ARRAY['8x + 3', '6x + 12', '8x + 7'], 3),
('Mathematics', 'What is sin(30°)?', '0.5', ARRAY['0.707', '0.866', '1'], 3),
('Mathematics', 'Solve: x² - 5x + 6 = 0', 'x = 2 or 3', ARRAY['x = 1 or 6', 'x = -2 or -3', 'x = 0 or 5'], 3),
('Mathematics', 'What is log₁₀(1000)?', '3', ARRAY['10', '100', '1000'], 3),
('Mathematics', 'Find derivative: f(x) = x³ + 2x', '3x² + 2', ARRAY['x² + 2', '3x³ + 2x', 'x³ + 2'], 3),
('Mathematics', 'What is the sum of angles in a pentagon?', '540°', ARRAY['360°', '720°', '450°'], 3),

-- Expert (Difficulty 4)
('Mathematics', 'Calculate: ∫x² dx', 'x³/3 + C', ARRAY['2x + C', 'x³ + C', '2x²/2 + C'], 4),
('Mathematics', 'What is the derivative of e^x?', 'e^x', ARRAY['xe^(x-1)', 'ln(x)', 'x*e^x'], 4),
('Mathematics', 'Solve: lim(x→0) sin(x)/x', '1', ARRAY['0', '∞', 'undefined'], 4);

-- ==========================================
-- 6. INSERT SAMPLE QUESTIONS - PHYSICS
-- ==========================================

INSERT INTO questions (subject, question, correct_answer, wrong_answers, difficulty) VALUES
-- Easy (Difficulty 1)
('Physics', 'What is the SI unit of force?', 'Newton', ARRAY['Joule', 'Watt', 'Pascal'], 1),
('Physics', 'Speed of light in vacuum?', '3×10⁸ m/s', ARRAY['3×10⁶ m/s', '3×10⁷ m/s', '3×10⁹ m/s'], 1),
('Physics', 'What is the formula for kinetic energy?', '½mv²', ARRAY['mv', 'mv²', '2mv²'], 1),
('Physics', 'Acceleration due to gravity on Earth?', '9.8 m/s²', ARRAY['10.2 m/s²', '8.9 m/s²', '11.3 m/s²'], 1),
('Physics', 'What is Ohm''s Law?', 'V = IR', ARRAY['V = I/R', 'V = I + R', 'I = V + R'], 1),
('Physics', 'What is the SI unit of energy?', 'Joule', ARRAY['Newton', 'Watt', 'Volt'], 1),
('Physics', 'What is the formula for velocity?', 'v = d/t', ARRAY['v = t/d', 'v = d*t', 'v = d-t'], 1),

-- Medium (Difficulty 2)
('Physics', 'Calculate work done: F=10N, d=5m', '50 J', ARRAY['15 J', '2 J', '25 J'], 2),
('Physics', 'What is the momentum formula?', 'p = mv', ARRAY['p = ma', 'p = m/v', 'p = v/m'], 2),
('Physics', 'First law of thermodynamics?', 'Energy is conserved', ARRAY['Entropy increases', 'Heat flows hot to cold', 'Work equals heat'], 2),
('Physics', 'What is wavelength of visible light?', '400-700 nm', ARRAY['100-400 nm', '700-1000 nm', '1-100 nm'], 2),
('Physics', 'What is absolute zero?', '-273.15°C', ARRAY['-270°C', '-280°C', '-300°C'], 2),
('Physics', 'What is the speed of sound in air?', '343 m/s', ARRAY['300 m/s', '400 m/s', '500 m/s'], 2),
('Physics', 'Formula for centripetal force?', 'F = mv²/r', ARRAY['F = ma', 'F = mvr', 'F = mr/v²'], 2),

-- Hard (Difficulty 3)
('Physics', 'Calculate power: W=100J, t=5s', '20 W', ARRAY['500 W', '10 W', '25 W'], 3),
('Physics', 'What is Planck''s constant (approx)?', '6.63×10⁻³⁴ J·s', ARRAY['6.63×10⁻³² J·s', '3.14×10⁻³⁴ J·s', '9.8×10⁻³⁴ J·s'], 3),
('Physics', 'How many Maxwell equations are there?', '4', ARRAY['2', '3', '5'], 3),
('Physics', 'Formula for gravitational force?', 'F = Gm₁m₂/r²', ARRAY['F = ma', 'F = mv²/r', 'F = kx'], 3),
('Physics', 'What is the Doppler effect formula?', 'f'' = f(v±v₀)/(v±vₛ)', ARRAY['f'' = fv/c', 'f'' = f±v', 'f'' = f/v'], 3),
('Physics', 'What is Young''s modulus?', 'Stress/Strain', ARRAY['Force/Area', 'Length/Force', 'Strain/Stress'], 3),

-- Expert (Difficulty 4)
('Physics', 'What is Schrödinger equation type?', 'Wave equation', ARRAY['Force equation', 'Energy equation', 'Momentum equation'], 4),
('Physics', 'What is Heisenberg uncertainty?', 'ΔxΔp ≥ ℏ/2', ARRAY['ΔxΔp = 0', 'ΔxΔp = ℏ', 'ΔxΔp < ℏ'], 4),
('Physics', 'What is the fine structure constant?', '1/137', ARRAY['137', '1/299792458', 'π/2'], 4);

-- ==========================================
-- 7. VERIFY INSTALLATION
-- ==========================================

-- Check questions count by subject
SELECT subject, COUNT(*) as question_count, 
       MIN(difficulty) as min_difficulty, 
       MAX(difficulty) as max_difficulty
FROM questions 
GROUP BY subject;

-- ==========================================
-- SETUP COMPLETE!
-- ==========================================
