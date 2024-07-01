# supermemo_vim_ahk

This repository provides an AutoHotkey script to emulate Vim functionalities in SuperMemo.

## To Do

Documentation is in progress! Keybindings are similar to Vim, with notable exceptions such as `q` for extract and `z` for cloze. For example, `zt.` clozes until a full stop, and `qip` extracts inner paragraph. Includes [vim-sneak](https://github.com/justinmk/vim-sneak) for advanced motions.

## Legend

- **<C-{key}>**: `Ctrl + {key}`
- **<M-{key}>**: `Meta (Alt) + {key}`
- **<S-{key}>**: `Shift + {key}`
- **<leader>**: `'` key
- **<CR>**: `Enter` key

Press `<C-M-r>` to reload the script if needed.

## Cheat Sheet

### First Steps

#### Motions

- `h`: left
- `j`: down
- `k`: up
- `l`: right
- `w`: next word (`Ctrl + Right`)
- `b`: previous word (`Ctrl + Left`)
- `e`: end of current word
- `ge`: end of previous word

#### Modes

- `i`: insert mode
- `a`: insert mode after the cursor (append)
- `v`: visual mode
- `:`: command mode
- `<C-[>` / `CapsLock` / `Esc`: normal mode

### Find Character(s)

- `f{character}`: find next `{character}`
- `F{character}`: find previous `{character}`
- `t{character}`: find next `{character}` but put caret before it
- `T{character}`: find previous `{character}` but put caret before it
- `s{2 characters}`: find next `{2 characters}`
- `S{2 characters}`: find previous `{2 characters}` (in visual mode it's `<M-s>`)
- `;`: repeat last search
- `,`: repeat last search in reverse

### Horizontal and Vertical Movement

- `0` / `^`: start of a line
- `$` / `g_`: end of a line
- `}`: jump paragraphs down
- `{`: jump paragraphs up
- `<C-d>`: down 10 lines
- `<C-u>`: up 10 lines
- `+`: start of the next line
- `-`: start of the previous line

## Searching

### HTML Specific

- `<C-M-f>`: search using IE's search window

### HTML and Plain-text

- `/`: normal search
- `?`: visual search
- `<M-/>`: cloze search
- `<M-S-/>`: cloze search with a cloze hinter
- `gn`: repeat last search and go to visual mode
- `n/N`: search next/previous
- `*`: search the word under the cursor

## Move Faster with Counts

- `{count}{motion}`: repeat motion
- Examples: `2w`, `4f"`, `3/cucumber`

## Editing

### Text Objects

- `{operator}{count}{motion}`: operations on text
- Examples: `diw`, `dip`, `ciw`

### Repeat Last Change

- `.`: repeat last change

## Character Editing Commands

- `x`: delete a character after the cursor
- `X`: delete character before the cursor
- `~`: switch case of the character after the cursor

## Undo and Redo

- `u`: undo last change
- `<C-R>`: redo last undo
- `{count}u`: undo last {count} changes

## Inserting Text

- `I`: insert mode at the beginning of a line
- `A`: insert mode at the end of a line
- `o`: insert new line below current line
- `O`: insert new line above current line

## Visual Mode

- `V`: line-wise visual mode
- `<C-V>`: paragraph-wise visual mode
- `{trigger visual mode}{motion}{operator}`: visual mode operations

## Copying and Pasting

- `y{motion}`: yank (copy) text covered by motion
- `p`: put (paste) after cursor
- `P`: paste at the cursor
- `yy` / `Y`: copy line
- `yyp`: duplicate line
- `ddp`: swap lines
- `xp`: swap characters

## SuperMemo Specific

### Browsing and Navigation

- `gg`: go to top
- `G`: go to bottom
- `{count}gg`: go to {count}th line
- `gU`: click the source button
- `gS`: open link in IE
- `gs`: open link in default browser
- `g0`: go to root element
- `g$`: go to last element
- `gc`: go to next component
- `gC`: go to previous component
- `h`: scroll left
- `j` / `<C-e>`: scroll down
- `k` / `<C-y>`: scroll up
- `l`: scroll right
- `d`: scroll down 2 times
- `u`: scroll up 2 times
- `0`: scroll to top left
- `$`: scroll to top right
- `r`: reload (go to top element and back)
- `p`: play (`Ctrl + F10`)
- `P`: play video in default system player / edit script component
- `n`: add topic (`M-N`)
- `N`: add item (`M-A`)
- `x`: delete element/component (`Delete` key)
- `<C-i>`: download images (`Ctrl + F8`)
- `f`: open links
- `F`: open links in background
- `<M-f>`: open multiple links
- `<M-S-f>`: open links in IE
- `<C-M-S-f>`: open multiple links in IE
- `yf`: copy links
- `yv`: select texts
- `yc`: go to texts
- `X`: Done!
- `J` / `ge`: go down elements
- `K` / `gE`: go up elements
- `gu` / `<M-u>`: go to parents
- `H` / `<M-h>`: go back in history
- `L` / `<M-l>`: go forward in history
- `b`: open browser
- `o`: open favourites
- `t`: click first text component
- `yy`: copy reference link
- `ye`: duplicate current element
- `{count}g{`: go to the {count}th paragraph
- `{count}g}`: go to the {count}th paragraph on screen
- `m`: set read point
- `` ` ``: go to read point
- `<M-m>`: clear read point
- `<M-S-j>`: go to next sibling (`M-S-PgDn`)
- `<M-S-k>`: go to previous sibling (`M-S-PgUp`)
- `\`: SuperMemo search (`Ctrl + F3`)

#### In Plan Window

- `s`: switch plans
- `b`: begin (`M-B`)

#### In Tasklist Window

- `s`: switch tasklists

### Normal Mode, Editing

- `H`: click the top of the text
- `M`: click the middle of the text
- `L`: click the bottom of the text
- `{count}<leader>q`: add `>` to {count} lines
- `gx`: open hyperlink in current caret position (`gX` to open in IE)
- `gs`: open current file in Vim
- `gf`: open current file in Notepad
- `>>`: increase indent
- `<<`: decrease indent
- `gU`: click the source button
- `<leader><M-{number}>` / `{Numpad}`: [Naess's priority script](https://raw.githubusercontent.com/rajlego/supermemo-ahk/main/naess%20priorities%2010-25-2020.png)

### Visual Mode

- `.`: selected text becomes \[...\]
- `<C-h>`: parse HTML (`Ctrl + Shift + 1`)
- `<M-a>`: add HTML tag
- `m`: highlight (**m**ark)
- `q`: extract (**q**uote)
- `Q`: extract with priority
- `<C-q>`: extract and stay in the extracted element
- `z`: cloze
- `<C-z>`: cloze and stay in the clozed item
- `Z`: cloze hinter
- `<CapsLock-z>`: cloze and delete \[...\]
- `H`: select until the top of the text on screen
- `M`: select until the middle of the text on screen
- `L`: select until the bottom of the text on screen

### Shortcuts (Any Mode)

- `<C-M-.>`: find \[...\] and insert
- `<C-M-c>`: change default concept group

(`RC`: Right Control; `RS`: Right Shift; `RA`: Right Alt)

- `<RC-RS-BS> / <RA-RS-BS>`: delete element and keep learning
- `<RC-RS-\> / <RA-RS-\>`: Done! and keep learning
- `<C-M-S-g>`: change current element's concept group
