-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Migrated from XFCE (keyboard-layout.xml, 2026-09-12):
--   ru first, us as secondary, switched with Ctrl+Shift,
--   compose on the right Alt, NumLock on, logitech keyboard model.
--
-- Note: omarchy uses compose:caps (CapsLock) for its quick-emoji shortcuts.
-- Moving compose to the right Alt (as XFCE had it) restores Caps Lock as a
-- normal caps key but drops the CapsLock-based emoji compose sequences.
hl.config({
  input = {
    kb_layout = "ru,us",
    kb_model = "logitech_base",
    kb_options = "grp:ctrl_shift_toggle,compose:ralt",
    numlock_by_default = true,
  },
})