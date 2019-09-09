set nu
set nocp
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

try 
    colorscheme solarized
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
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
call minpac#add('vimwiki/vimwiki')
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


" common cpp snippets
au FileType cpp nnoremap <buffer><Leader>gp 59Gp<CR>
au FileType cpp nnoremap <buffer><Leader>uf :<C-u>r ~/github/yhren/CppMacros/data_structures/uf.h<CR>13jo
au FileType cpp nnoremap <buffer><Leader>trie :<C-u>r ~/github/yhren/CppMacros/data_structures/trie.h<CR>12jo
au FileType cpp nnoremap <buffer><Leader>sieve :<C-u>r ~/github/yhren/CppMacros/number_theory/sieve.h<CR>11jo
au FileType cpp nnoremap <buffer><Leader>prime :<C-u>r ~/github/yhren/CppMacros/number_theory/is_prime.h<CR>7jo
au FileType cpp nnoremap <buffer><Leader>t2g :<C-u>r ~/github/yhren/CppMacros/graph_theory/t2g.h<CR>25jo
au FileType cpp nnoremap <buffer><Leader>rabinkarp :<C-u>r ~/github/yhren/CppMacros/strings/rabin_karp.h<CR>16jo
au FileType cpp nnoremap <buffer><Leader>suffixarray :<C-u>r ~/github/yhren/CppMacros/strings/suffix_array.h<CR>24jo

" to remove markdown italic
" autocmd FileType markdown |
"       \hi def link markdownItalic              NONE |
"       \hi def link markdownItalicDelimiter     NONE |
"       \hi def link markdownBold                NONE |
"       \hi def link markdownBoldDelimiter       NONE |
"       \hi def link markdownBoldItalic          NONE |
"       \hi def link markdownBoldItalicDelimiter NONE


"" timestamp toggle
""" credit: https://www.codesections.com/blog/vim-timestamped/
let g:time_stamp_enabled = 0
let g:time_stamp_start = 0
command! TimeStampToggle call TimeStampToggle()

function TimeStampToggle()
  let g:time_stamp_enabled = !g:time_stamp_enabled
  let g:time_stamp_start = strftime("%s") 
     " Time in seconds since the Unix epoch
endfunction

inoremap <expr> <CR> g:time_stamp_enabled ? "\<ESC>:call TimeStamp()\<CR>a" : "\<CR>"

function! TimeStamp()
     let l:current_sec = printf("%02d", strftime("%s") - g:time_stamp_start)
     let l:current_min = 0
     let l:current_hr  = 0

     while l:current_sec >= 60
       let l:current_sec -= 60
       let l:current_min += 1
     endwhile

     while l:current_min >= 60
       let l:current_min -= 60
       let l:current_hr  += 1
     endwhile

     let l:current_sec = printf("%02d", l:current_sec)
     let l:current_min = printf("%02d", l:current_min)
     let l:current_hr  = printf("%02d", l:current_hr)

     " Go to the beginning of the line,
     " print the current zero-padded time,
     " print `  -  ` as a separator
     " and move the cursor over for the next line (with separator)
     execute "normal! 0i\<SPACE>\<ESC>0dwi\
           \<C-R>=l:current_hr\<CR>:\<C-R>=l:current_min\<CR>:\<C-R>=l:current_sec \<CR>\
           \<SPACE>\<SPACE>—\<SPACE>\<SPACE>\<ESC>o\<SPACE>\<SPACE>\<SPACE>\<SPACE>\
           \<SPACE>\<SPACE>\<SPACE>\<SPACE>\<SPACE>\<SPACE>\<SPACE>\<SPACE>\<SPACE>"

 endfunction

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

syntax enable
"""let g:solarized_termcolors=256
"""let g:solarized_termtrans=1
"""colorscheme solarized
