-- Highlight todo, notes, etc in comments
-- these keywords need to be followed by `:`
-- PERF: optimized
-- HACK: hacky
-- TODO: update in the future
-- NOTE: keep in mind
-- FIX: this should be fixed
-- WARNING: beware
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
}
