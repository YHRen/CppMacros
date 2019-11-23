set nu
set nocp """ nocompatible
set t_Co=256
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set hlsearch
set showcmd
set cpt-=i
set cpt-=t
set background=dark
set relativenumber
let mapleader = ","

:imap <C-d> <C-[>diwi
:imap <C-f> <C-[>dwi
:imap <C-g> <C-[>d$i
:nnoremap <buffer><Leader>yy :%y<CR> """ copy all

try 
    colorscheme solarized
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
catch
endtry

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
call minpac#add('Shougo/deoplete.nvim') 
call minpac#add('SirVer/ultisnips')
call minpac#add('honza/vim-snippets')
call minpac#add('scrooloose/nerdtree')
call minpac#add('vimwiki/vimwiki')
call minpac#add('dpelle/vim-LanguageTool')
call minpac#add('itchyny/calendar.vim')
call minpac#add('radenling/vim-dispatch-neovim')
call minpac#add('w0rp/ale')
call minpac#add('lervag/vimtex')
call minpac#add('godlygeek/tabular')
call minpac#add('Vimjas/vim-python-pep8-indent')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('altercation/vim-colors-solarized')
call minpac#add('rhysd/vim-clang-format')
call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
call minpac#add('k-takata/minpac', {'type': 'opt'})
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

" map terminal mode
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
    autocmd FileTYpe c,cpp,objc vnoremap <buffer><C-K> :ClangFormat<CR>
    autocmd FileTYpe c,cpp,objc nnoremap <buffer><C-J> :w<CR> :!make d<CR> :sp<CR> :te ./main <input00.txt <CR>

    " python run
    autocmd FileTYpe python nnoremap <buffer><C-J> :w<CR> :sp<CR> :te python3 "%"<CR>

    nnoremap <C-H>  :bd! <CR>

    au BufNewFile,BufRead *.py
        \ set tabstop=4
        \| set softtabstop=4
        \| set shiftwidth=4
        \| set textwidth=79
        \| set expandtab
        \| set autoindent
        \| set fileformat=unix

    au BufNewFile,BufRead *.js, *.html, *.css
        \ set tabstop=2
        \| set softtabstop=2
        \| set shiftwidth=2
endif

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


" what is this for???
au FileType cpp nnoremap <buffer><Leader>gp 59Gp<CR>
"""""""""""""""""""""""""""""""""""""""""""""

""" NERDTree
"""autocmd vimenter * NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""


""" ale plugin
let g:ale_completion_enabled   = 1
let g:ale_sign_column_always   = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter        = 0
let g:ale_linters = {'c': ['clang'], 'cpp': ['clang', 'g++']}
let g:ale_c_gcc_options = '-Wall -std=c99'
let g:ale_c_clang_options = '-Wall -std=c99'
let g:ale_cpp_clang_options = '-Wall -std=c++17'
let g:ale_cpp_gcc_options = '-Wall -std=c++17'
"""""""""""""""""""""""""""""""""""""""""""""

""" vimiwiki plugin
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/notes/', 'syntax': 'markdown', 'ext': '.md', 'diary_rel_path': '.'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_use_calendar = 1
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

"""""" deoplete
let g:deoplete#enable_at_startup = 1
"""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""

""" LanguageTool
""" Usage: 
"""   :LanguageToolCheck
"""   :lne next error
:let g:languagetool_jar='$HOME/.bin/LanguageTool-4.7/languagetool-commandline.jar'
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

syntax enable
