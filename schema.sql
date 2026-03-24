-- ============================================
-- Wordle-IT League — Supabase Schema
-- Esegui questo SQL nella Supabase SQL Editor
-- ============================================

-- Tabella risultati
CREATE TABLE results (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  player TEXT NOT NULL CHECK (player IN ('Dodo', 'Benni', 'Gabri')),
  played_date DATE NOT NULL,
  time_seconds INTEGER NOT NULL CHECK (time_seconds > 0),
  word TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(player, played_date)
);

-- Indici
CREATE INDEX idx_results_date ON results(played_date DESC);
CREATE INDEX idx_results_player ON results(player);

-- Row Level Security
ALTER TABLE results ENABLE ROW LEVEL SECURITY;

-- Tutti possono leggere
CREATE POLICY "Public read access"
  ON results FOR SELECT USING (true);

-- Tutti possono inserire (sito privato tra amici)
CREATE POLICY "Allow inserts"
  ON results FOR INSERT WITH CHECK (true);

-- Permettiamo update per correzioni
CREATE POLICY "Allow updates"
  ON results FOR UPDATE USING (true);

-- Permettiamo delete per errori
CREATE POLICY "Allow deletes"
  ON results FOR DELETE USING (true);
