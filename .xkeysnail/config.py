# -*- coding: utf-8 -*-
# https://github.com/mooz/xkeysnail/blob/master/example/config.py

import re
from xkeysnail.transform import *

# [Global modemap] Change modifier keys as in xmodmap
define_modmap({
    Key.CAPSLOCK: Key.LEFT_CTRL
})

# [Multipurpose modmap] Give a key two meanings. A normal key when pressed and
# released, and a modifier key when held down with another key. See Xcape,
# Carabiner and caps2esc for ideas and concept.
define_multipurpose_modmap({
        # Target key: [single, pressed with other keys]
        Key.SPACE: [Key.SPACE, Key.LEFT_SHIFT],
        Key.LEFT_ALT: [Key.SPACE, Key.LEFT_ALT],
        Key.LEFT_ALT: [Key.MUHENKAN, Key.LEFT_ALT],
        Key.RIGHT_ALT: [Key.HENKAN, Key.RIGHT_ALT],
})

# define_keymap(true, {
# }, "Esc")


# # Emacs-like keybindings in non-Emacs applications
# define_keymap(lambda wm_class: wm_class not in ("Emacs", "URxvt"), {
#     # Cursor
#     # K("C-h"): with_mark(K("backspace")),
#     # # Beginning/End of line
#     # K("C-a"): with_mark(K("home")),
#     # K("C-e"): with_mark(K("end")),
#     # Newline
#     # K("C-j"): K("enter"),
#     # Kill line
#     # K("C-k"): [K("Shift-end"), K("C-x"), set_mark(False)],
# }, "Emacs-like keys")
