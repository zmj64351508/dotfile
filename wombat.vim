" Maintainer:	Lars H. Nielsen (dengmao@gmail.com)
" Last Change:	January 22 2007

set background=light

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "wombat"


" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine guibg=#313131
  hi CursorColumn guibg=#313131
  hi MatchParen guifg=#f6f3e8 guibg=#857b6f gui=bold
  hi Pmenu 		guifg=#f6f3e8 guibg=#444444
  hi PmenuSel 	guifg=#000000 guibg=#cae682
endif

" General colors
hi Cursor 		guifg=#ffffff    guibg=#656565 gui=none
hi Normal 		guifg=#f6f3e8 guibg=#242424 gui=none
hi Normal 		guifg=#f6f3e8 guibg=#242424 gui=none
hi LineNr 		guifg=#857b6f guibg=#121212 gui=none
hi StatusLine 	guifg=#f6f3e8 guibg=#444444 gui=italic
hi StatusLineNC guifg=#857b6f guibg=#444444 gui=none
hi VertSplit 	guifg=#444444 guibg=#444444 gui=none
hi Folded 		guibg=#384048 guifg=#a0a8b0 gui=none
hi Title		guifg=#f6f3e8 guibg=NONE	gui=bold
hi Visual		guifg=#f6f3e8 guibg=#444444 gui=none
hi SpecialKey	guifg=#808080 guibg=#343434 gui=none
hi Search	guifg=#202020 guibg=#ffff00
hi MatchParen	guifg=#202020 guibg=#00ffff

" Vim diff
highlight DiffChange gui=none guibg=NONE
highlight DiffText gui=none guibg=#602a1d
highlight DiffDelete guibg=#4682b4
highlight DiffAdd guibg=#234162

" Syntax highlighting
hi Comment 		guifg=#7080a0 gui=italic
hi Todo 		guifg=#8f8f8f gui=italic
hi Constant 	guifg=#e5786d gui=none
hi String 		guifg=#ff69b4
hi Identifier 	guifg=#cae682 gui=none
hi Function 	guifg=#66ccff gui=bold
hi Type 		guifg=#cae682 gui=none
hi Statement 	guifg=#ffa500 gui=none
hi Keyword		guifg=#8ac6f2 gui=none
hi PreProc 		guifg=#da70d6 gui=none
hi Number		guifg=#e5786d gui=none
hi Special		guifg=#e7f6da gui=none


