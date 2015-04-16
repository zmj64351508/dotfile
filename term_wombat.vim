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
highlight CursorLine guibg=#313131 ctermbg=236 cterm=NONE
highlight CursorColumn guibg=#313131 ctermbg=236
highlight MatchParen guifg=#f6f3e8 guibg=#857b6f gui=bold ctermfg=255 ctermbg=244 cterm=bold
highlight Pmenu guifg=#f6f3e8 guibg=#444444 ctermfg=255 ctermbg=238
highlight PmenuSel guifg=#000000 guibg=#cae682 ctermfg=16 ctermbg=149
endif

" General colors
highlight Cursor guifg=#ffffff guibg=#656565 gui=NONE ctermfg=231 ctermbg=241 cterm=NONE
highlight Normal guifg=#f6f3e8 guibg=#242424 gui=NONE ctermfg=255 ctermbg=235 cterm=NONE
highlight Normal guifg=#f6f3e8 guibg=#242424 gui=NONE ctermfg=255 ctermbg=235 cterm=NONE
highlight LineNr guifg=#857b6f guibg=#121212 gui=NONE ctermfg=244 ctermbg=233 cterm=NONE
highlight StatusLine guifg=#f6f3e8 guibg=#444444 gui=italic ctermfg=255 ctermbg=238
highlight StatusLineNC guifg=#857b6f guibg=#444444 gui=NONE ctermfg=244 ctermbg=238 cterm=NONE
highlight VertSplit guifg=#444444 guibg=#444444 gui=NONE ctermfg=238 ctermbg=238 cterm=NONE
highlight Folded guifg=#a0a8b0 guibg=#384048 gui=NONE ctermfg=248 ctermbg=238 cterm=NONE
highlight Title guifg=#f6f3e8 guibg=NONE gui=bold ctermfg=255 cterm=bold
highlight Visual guifg=#f6f3e8 guibg=#444444 gui=NONE ctermfg=255 ctermbg=238 cterm=NONE
highlight SpecialKey guifg=#808080 guibg=#343434 gui=NONE ctermfg=244 ctermbg=236 cterm=NONE
highlight Search guifg=#202020 guibg=#ffff00 ctermfg=234 ctermbg=226
highlight MatchParen guifg=#202020 guibg=#00ffff ctermfg=234 ctermbg=51

" Vim diff
highlight DiffChange guibg=NONE gui=NONE cterm=NONE
highlight DiffText guibg=#602a1d gui=NONE ctermbg=52 cterm=NONE
highlight DiffDelete guibg=#4682b4 ctermbg=67
highlight DiffAdd guibg=#234162 ctermbg=24

" Syntax highlighting
highlight Comment guifg=#7080a0 gui=italic ctermfg=67
highlight Todo guifg=#8f8f8f gui=italic ctermfg=246
highlight Constant guifg=#e5786d gui=NONE ctermfg=203 cterm=NONE
highlight String guifg=#ff69b4 ctermfg=205
highlight Identifier guifg=#cae682 gui=NONE ctermfg=149 cterm=NONE
highlight Function guifg=#66ccff gui=bold ctermfg=117 cterm=bold
highlight Type guifg=#cae682 gui=NONE ctermfg=149 cterm=NONE
highlight Statement guifg=#ffa500 gui=NONE ctermfg=214 cterm=NONE
highlight Keyword guifg=#8ac6f2 gui=NONE ctermfg=117 cterm=NONE
highlight PreProc guifg=#da70d6 gui=NONE ctermfg=170 cterm=NONE
highlight Number guifg=#e5786d gui=NONE ctermfg=203 cterm=NONE
highlight Special guifg=#e7f6da gui=NONE ctermfg=230 cterm=NONE


