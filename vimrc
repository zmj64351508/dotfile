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
Bundle 'rking/ag.vim' 
Bundle 'Raimondi/delimitMate'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
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

" indent
set autoindent
"set smartindent

" tab expand and width
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" display setting
set showmatch
set hlsearch
set cursorline
set lines=35 columns=118
set number
set nobackup
set display=lastline "display last line when it can't be display completely
set nolinebreak      "can break a word at the end of the line
set wrap
set foldmethod=syntax
set foldcolumn=4
set foldlevel=999
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

" show tab
set showtabline=3
function ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
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

" c source file setting
set cino=:0

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
    noremap <F2> :YcmCompleter GoTo<CR>
endif

" color
highlight CursorLine cterm=None ctermbg=None 
highlight DiffChange gui=None guibg=NONE
highlight DiffText gui=None guibg=lightred
highlight DiffDelete guibg=lightBlue

" some key map
nmap j gj
nmap k gk

noremap <C-u> <C-u>zz
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
noremap <F5> g*
nnoremap <F6> :YcmForceCompileAndDiagnostics<CR>

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
     exe 'silent !cd ' . dir . ' && global -u &> /dev/null &'
endfunction
au VimEnter * call VimEnterCallback()
au BufAdd * call FindGtags(expand('<afile>'))
au BufWritePost * call UpdateGtags(expand('<afile>'))

""""""""""youcompleteme""""""""""""
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
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
let g:ctrlp_max_depth = 40
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(o|exe|so|dll)$',
    \ }


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
