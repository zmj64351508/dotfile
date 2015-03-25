set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Bundle 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Bundle 'Valloric/YouCompleteMe'
"Bundle 'Syntastic'
"Bundle 'rking/ag.vim' 
Bundle 'Raimondi/delimitMate'
Bundle 'kien/ctrlp.vim'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'Lokaltog/vim-easymotion'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"Bundle 'rosenfeld/conque-term'
" Track the engine.
"Bundle 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
"Bundle 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" -------------Common vimrc start------------
"echo $VIMRUNTIME
"source $VIMRUNTIME/mswin.vim
source ~/.vim/magee.vim

" common
syntax on
filetype on
set nocompatible

" automatically read file when changed
set autoread

" indent
set autoindent
"filetype plugin off
"set smartindent

" tab expand and width
set tabstop=8
"set softtabstop=8
"set shiftwidth=8
set noexpandtab

" display setting
set showmatch
set hlsearch
set cursorline
" do not set lines and columns in console
if has("gui_running")
    set lines=35 columns=118
    set guioptions-=T
endif
set number
set nobackup
set display=lastline "display last line when it can't be display completely
set nolinebreak      "can break a word at the end of the line
set wrap
set foldmethod=syntax
set foldcolumn=4
set foldlevel=999
set mouse=a
set nomousehide

set autochdir "auto change directory to the file dir
set incsearch "dispaly search result when searching
"set laststatus=2     "display status bar
"set statusline=%m%r%F\ \|\ %Y,%{&fileencoding}\ \|%=\ %l/%L,%c
                            " 设置在状态行显示的信息如下：
                            " %f    当前的文件名
                            " %F    当前全路径文件名
                            " %m    当前文件修改状态
                            " %r    当前文件是否只读
                            " %Y    当前文件类型
                            " %{&fileformat}
                            "       当前文件编码
                            " %{&fileencoding}
                            "       中文编码
                            " %b    当前光标处字符的 ASCII 码值
                            " %B    当前光标处字符的十六进制值
                            " %l    当前光标行号
                            " %c    当前光标列号
                            " %V    当前光标虚拟列号 (根据字符所占字节数计算)
                            " %p    当前行占总行数的百分比
                            " %%    百分号
                            " %L    当前文件总行数
 
" gui font
set guifont=monospace\ 11

set ttymouse=xterm

if &term =~ "xterm"
" 256 colors
    let &t_Co = 256
" restore screen after quitting
    let &t_ti = "\<Esc>7\<Esc>[r\<Esc>[?47h"
    let &t_te = "\<Esc>[?47l\<Esc>8"
    if has("terminfo")
        let &t_Sf = "\<Esc>[3%p1%dm"
        let &t_Sb = "\<Esc>[4%p1%dm"
    else
        let &t_Sf = "\<Esc>[3%dm"
        let &t_Sb = "\<Esc>[4%dm"
    endif
endif

" show tab
set showtabline=3
function ShortTabLabel ()
    let bufnrlist = tabpagebuflist(v:lnum)
    let label = ''

    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let label = '+'
            break
        endif
    endfor

    let label .= bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction
set guitablabel=%{ShortTabLabel()}

function MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'

        " the label is made by MyTabLabel()
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999Xclose'
    endif

    return s
endfunction

function MyTabLabel(n)
    let label = ''
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    if getbufvar(winnr, "&modified")
        let label = '+'
    endif
    let label .= bufname(buflist[winnr - 1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction
set tabline=%!MyTabLine()

" c source file setting
set cino=:0

function OpenDefinationInTab(word)
	tabnew
	try
		exec 'cs find g ' . a:word
	catch /^Vim\%((\a\+)\)\=:E259/
		tabc
	endtry
endfunction

" diff specific setting
function SplitCenter()
    set noequalalways
    set equalalways
endfunction
" auto wrap 2 split window
autocmd FilterWritePre * if &diff | setlocal wrap< | endif
" auto center split window
autocmd VimResized * if &diff | call SplitCenter() | endif
if &diff
    "next and previous diff
    noremap <F1> [czz
    noremap <F2> ]czz
    set foldcolumn=1
else
    noremap <F1> <C-]>
    noremap <F2> :call OpenDefinationInTab(expand("<cword>"))<cr>
    " noremap <F2> :YcmCompleter GoTo<CR>zz
endif

" color
highlight CursorLine cterm=None ctermbg=None 
highlight DiffChange gui=None guibg=NONE
highlight DiffText gui=None guibg=lightred
highlight DiffDelete guibg=lightBlue

autocmd FileType c call HighlightCfunction()
autocmd FileType c++ call HighlightCfunction()
autocmd FileType java call HighlightCfunction()
function! HighlightCfunction()
     " c function highlight
     syn match cFunction "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
     syn match cFunction "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
     hi cFunction gui=Bold guifg=DarkBlue
endfunc


" some key map
nmap j gj
nmap k gk

noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz
noremap <C-left> :tabp<CR>
noremap <C-right> :tabn<CR>
noremap <C-S-left> :tabm -1<CR>
noremap <C-S-right> :tabm +1<CR>
noremap <C-h> :tabp<CR>
noremap <C-l> :tabn<CR>
noremap <C-j> :tabm -1<CR>
noremap <C-k> :tabm +1<CR>
noremap <C-up> :tabnew<CR>
nmap <A-.> :<up><CR>
noremap <F3> <C-o>
noremap <F4> <C-i>
noremap <F5> g*N
nnoremap <F6> :YcmForceCompileAndDiagnostics<CR>
" symbal
nmap <Leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" definition
nmap <Leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
" calling references
nmap <Leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <Leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <Leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <Leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap <Leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <Leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>

nnoremap <Leader>f :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
"nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

""""""""""ctags""""""""""""
set tags=tags;/

""""""""""cscope""""""""""""

"if has("cscope")  
"    set csto=0  
"    set cst  
"    set csverb  
"    set cspc=3  
"    "add any database in current dir  
"    if filereadable("GTAGS")  
"        cs add GTAGS
"    "else search cscope.out elsewhere  
"    else  
"       let cscope_file=findfile("GTAGS", ".;")  
"       let cscope_pre=matchstr(cscope_file, ".*/")  
"       if !empty(cscope_file) && filereadable(cscope_file)  
"           exe "cs add" cscope_file cscope_pre  
"       endif        
"     endif  
"endif  

"using GNU GLOBAL
set cscopeprg=gtags-cscope
"let g:GtagsCscope_Auto_Load = 1
"let g:GtagsCscope_Auto_Map = 1
"let g:GtagsCscope_Absolute_Path = 1



set csto=0  
set csverb  
set cst
"set cscopequickfix=c-,d-,e-,g-,i-,s-,t-

function! FindFiles(pat, ...)
     let path = ''
     for str in a:000
         let path .= str . ','
     endfor
  
     if path == ''
         let path = &path
     endif
  
     echo 'finding...'
     redraw
     call append(line('$'), split(globpath(path, a:pat), '\n'))
     echo 'finding...done!'
     redraw
endfunc

function! VimEnterCallback()
     for f in argv()
         "if fnamemodify(f, ':e') != 'c' && fnamemodify(f, ':e') != 'h' && fnamemodify(f, ':e') != 'java'
             "continue
         "endif
  
         call FindGtags(f)
     endfor
endfunc

function! FindGtags(f)
     let dir = fnamemodify(a:f, ':p:h')
     while 1
         let tmp = dir . '/GTAGS'
         if filereadable(tmp)
             set nocsverb
             exe 'cs add ' . tmp . ' ' . dir . ' -a'
             set csverb
             break
         elseif dir == '/'
             break
         endif
  
         let dir = fnamemodify(dir, ":h")
     endwhile
endfunc

function! UpdateGtags(f)
	let dir = fnamemodify(a:f, ':p:h')
	let fname = fnamemodify(a:f, ':p')
	let found = 0
	while 1
		let tmp = dir . '/GTAGS'
		if filereadable(tmp)
			let found = 1
			break
		elseif dir == '/'
			break
		endif
		let dir = fnamemodify(dir, ":h")
	endwhile
	if found == 1
		exe 'silent !cd ' . dir . ' && gtags --single-update ' . fname . '&'
	endif
endfunction
au VimEnter * call VimEnterCallback()
au BufAdd * call FindGtags(expand('<afile>'))
au BufWritePost * call UpdateGtags(expand('<afile>'))

""""""""""youcompleteme""""""""""""
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_complete_in_comments = 0
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"let g:ycm_collect_identifiers_from_tags_files = 1 may crash if tags file very
"huge
let g:ycm_seed_identifiers_with_syntax = 1
set completeopt-=preview "do not dispaly preview
"let g:ycm_add_preview_to_completeopt = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1

""""""""""syntastic""""""""""""
"set error or warning signs
"let g:syntastic_enable_signs = 0
"let g:syntastic_error_symbol = 'x'
"let g:syntastic_warning_symbol = '⚠'
"whether to show balloons
"let g:syntastic_enable_balloons = 1

""""""""""Ag""""""""""""
let g:aghighlight=1
let g:agprg="ag --column --smart-case"

""""""""""ultisnips""""""""""""
" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-j>'
"
"" better key bindings for UltiSnipsExpandTrigger
"let g:UltiSnipsExpandTrigger = "<tab>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

""""""""""delimitMate""""""""""""
let delimitMate_expand_cr = 1


""""""""""ctrlp""""""""""""
" open in new tabpage
"let g:ctrlp_prompt_mappings = {
  "\ 'AcceptSelection("e")': ['<c-r>'],
  "\ 'AcceptSelection("t")': ['<cr>', '<c-m>'],
  "\ }
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_depth = 40
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(o|exe|so|dll)$',
    \ }

let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_syntax_highlight = 1

""""""""""ctrlp""""""""""""
map ,, <Plug>(easymotion-prefix)

nmap f <Plug>(easymotion-f)
nmap F <Plug>(easymotion-F)
nmap t <Plug>(easymotion-t)
nmap T <Plug>(easymotion-T)
nmap w <Plug>(easymotion-iskeyword-w)
nmap W <Plug>(easymotion-W)
nmap b <Plug>(easymotion-iskeyword-b)
nmap B <Plug>(easymotion-B)
nmap e <Plug>(easymotion-iskeyword-e)
nmap E <Plug>(easymotion-E)
nmap ge <Plug>(easymotion-iskeyword-ge)
nmap gE <Plug>(easymotion-gE)
"nmap j <Plug>(easymotion-j)
"nmap k <Plug>(easymotion-k)
"nmap n <Plug>(easymotion-n)
"nmap N <Plug>(easymotion-N)
nmap s <Plug>(easymotion-s)

function UpdateAddress(start, end, step)
	for curline in range(a:start, a:end)
		let content = getline(curline)
		let content = printf("%s\t// 0x%x", content, (curline - a:start)*a:step)
		call setline(curline, content)
	endfor
endfunction
