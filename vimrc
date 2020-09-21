:if !empty(glob('$HOME/.vim/local.vim'))
:   source $HOME/.vim/local.vim
:endif

set nocp """ nocompatible
set t_Co=256
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set copyindent
set hlsearch
set incsearch
set showcmd
set showmatch
set nowrap
set cpt-=i
set cpt-=t
set nu rnu " hybrid mode
set shiftround
"set ignorecase
set smartcase 
set hidden
"set backspace=indent,eol,start " caussing error in nvim
let mapleader = " "

:nnoremap <buffer><Leader>yy :%y<CR> """ copy all

"{{{ tab 
"" gt gT 3gt
nmap <Leader>tn :tabnew<cr>
nmap <Leader>tt :tabnew \| terminal<cr>
nmap <Leader>te :tabedit 
nmap <Leader>tc :tabclose<cr>
nmap <Leader>tm :tabmove<cr>
nmap <Leader>to :tabonly<cr>
"}}}

"{{{ netrw file browser
let g:netrw_banner=0
let g:netrw_browse_split=1
let g:netrw_winsize=25
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
"}}}

pa minpac
call minpac#init()
call minpac#add('lifepillar/vim-solarized8')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-commentary')
call minpac#add('SirVer/ultisnips')
call minpac#add('honza/vim-snippets')
call minpac#add('scrooloose/nerdtree')
call minpac#add('vimwiki/vimwiki')
call minpac#add('itchyny/lightline.vim')
call minpac#add('itchyny/calendar.vim')
call minpac#add('radenling/vim-dispatch-neovim')
call minpac#add('w0rp/ale')
call minpac#add('lervag/vimtex')
call minpac#add('godlygeek/tabular')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('justinmk/vim-sneak')
call minpac#add('salsifis/vim-transpose') " testing
call minpac#add('glacambre/firenvim', { 'type': 'opt', 'do': 'packadd firenvim | call firenvim#install(0)'})
"LSP language server protocal
call minpac#add('Vimjas/vim-python-pep8-indent')
call minpac#add('rhysd/vim-clang-format')
call minpac#add('junegunn/fzf')
call minpac#add('roxma/nvim-yarp')
call minpac#add('ncm2/ncm2')
call minpac#add('ncm2/ncm2-bufword')
call minpac#add('ncm2/ncm2-path')
call minpac#add('Shougo/deoplete.nvim') 
call minpac#add('deoplete-plugins/deoplete-jedi',
        \ {'do': '!git submodule update --init'})
call minpac#add('autozimu/LanguageClient-neovim',
        \ {'branch': 'next', 'do': '!bash install.sh'}) 
"optional packages
call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
call minpac#add('k-takata/minpac', {'type': 'opt'})
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

""" map terminal mode
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v> <Esc> <Esc>
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
  set clipboard+=unnamedplus
  set inccommand=nosplit
  let g:vimtex_compiler_progname = 'nvr'
endif

if has("autocmd")
    filetype plugin indent on
    syntax enable
    au FileType cpp setl sw=2 sts=2 expandtab
    au FileType python setl sw=4 sts=4 expandtab
    
    " clang-format, apt install clang-format
    autocmd FileType c,cpp,objc nnoremap <buffer><C-K> :<C-u>ClangFormat<CR>
    autocmd FileType c,cpp,objc vnoremap <buffer><C-K> :ClangFormat<CR>
    autocmd FileType c,cpp,objc nnoremap <buffer><C-J> :w<CR> :!make d<CR> :sp<CR> :te ./main <input00.txt <CR>

    " python run
    autocmd FileTYpe python nnoremap <buffer><C-J> :w<CR> :sp<CR> :te python3 "%"<CR>

    " shell run
    autocmd FileTYpe sh nnoremap <buffer><C-J> :w<CR> :sp<CR> :te bash "%"<CR>
    nnoremap <C-H>  :bd! <CR>

    au BufNewFile,BufRead *.py
        \ set tabstop=4
        \| set softtabstop=4
        \| set shiftwidth=4
        \| set textwidth=79
        \| set expandtab
        \| set fileformat=unix
        \| set foldmethod=indent
        \| set encoding=utf-8
        \| set foldlevel=99
        \| nnoremap <Leader><space> za
    
    " remove trailing spaces
    au FileType python,c,cpp,objc,ruby,php,java au BufWritePre <buffer> :call <SID>StripTrailingWhitespaces() 

    au BufNewFile,BufRead *.js, *.html, *.css
        \ set tabstop=2
        \| set softtabstop=2
        \| set shiftwidth=2

    " define *.make as makefile suffix
    au BufNewFile,BufRead *.make
        \ set filetype=make
endif

""" enhance `~` functionality
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

"""""""""""""""""""""""""""""""""""""""""""""
try 
    set background=dark
    colorscheme solarized8_high
    let g:solarized_termtrans=0  " non-transparent
    let g:solarized_termcolors=256
    """ for tmux:
    "   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    "   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
catch
endtry
"""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""
""" NERDTree
"""autocmd vimenter * NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""
""" ale plugin
let g:ale_completion_enabled   = 1
let g:ale_sign_column_always   = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter        = 0
let g:ale_linters = {'c': ['clang'], 'cpp': ['clang', 'g++']}
let g:ale_c_gcc_options = '-Wall -std=c99'
let g:ale_c_clang_options = '-Wall -std=c99'
let g:ale_cpp_clang_options = '-Wall -std=c++17'
let g:ale_cpp_gcc_options = '-Wall -std=c++17'
"""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""
""" vimiwiki plugin
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/notes/', 'syntax': 'markdown', 'ext': '.md', 'diary_rel_path': '.'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_use_calendar = 1
"""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""
""" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
"""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""
""" Tabularize
if exists(":Tabularize")
    nmap <Leader>t= :Tabularize /=<CR>
    vmap <Leader>t= :Tabularize /=<CR>
    nmap <Leader>t: :Tabularize /:\zs<CR>
    vmap <Leader>t: :Tabularize /:\zs<CR>
endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
"""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""
""" Strip Trailing Whitespaces
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    keepp %s/\s\+$//e
    call cursor(l, c)
endfun
"""""""""""""""""""""""""""""""""""""""""""""

"""""" deoplete
let g:deoplete#enable_at_startup = 1
"let g:python3_host_prog = expand('~/anaconda3/bin/python')

"""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""
""" Ultisnips
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<tab>'
" shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<c-j>'
" shortcut to go to previous position
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
" add additional snippets
"let g:UltiSnipsSnippetDirectories = [$HOME.'/github/yhren/CppMacros/vim_snippets', 'Ultisnips']
let g:UltiSnipsSnippetDirectories = [$HOME.'/github/yhren/CppMacros/vim_snippets']
" set list all snippets
let g:UltiSnipsListSnippets = '<c-l>'
"""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""
""" NCM2
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages

set shortmess+=c

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""
""" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ 'go': ['gopls'],
    \ 'cpp': ['clangd-10'],
    \ 'sh': ['bash-language-server', 'start'],
    \ }
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <C-K> :call LanguageClient#textDocument_formatting()<CR>
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
" Run gofmt on save
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
"""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""
""" firenvim
if exists('g:started_by_firenvim')
  packadd firenvim
endif
"""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""
""" vim-Transpose 
"    :Transpose (for character array transposition),
"    :TransposeWords (for word array transposition),
"    :TransposeTab (for tab-separated table transposition),
"    :TransposeCSV (for general delimited text transposition), and
"    :TransposeInteractive (for custom transposition).
"""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""
""" vimtex
let g:tex_flavor = 'latex'
"""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""
""" sneak (fast vim motion)
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
" s{char}{char} 2-char search. S, t, T
" 5s{char}{char} search within column
" 3dzqt to delete up to the third instance of "qt"
" ysz{char}{char}] surround with [ ] upto 
" replace f and t completely
map s <Plug>Sneak_s
map S <Plug>Sneak_S
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
"""""""""""""""""""""""""""""""""""""""""""""

syntax enable
