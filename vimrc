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
set wrap linebreak
set cpt-=i
set cpt-=t
set nu rnu " hybrid mode
set shiftround
set smartcase 
set hidden
let mapleader = " "

:nnoremap <buffer><Leader>yy :%y<CR> """ copy all

"{{{ tab 
"" gt gT 3gt
nmap <Leader>tn :tabnew<cr>
nmap <Leader>tt :tabnew \| terminal<cr> i
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
"let g:netrw_list_hide=netrw_gitignore#Hide()
"}}}

pa minpac
call minpac#init()
call minpac#add('lifepillar/vim-solarized8')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-commentary')
call minpac#add('SirVer/ultisnips')
call minpac#add('honza/vim-snippets')
call minpac#add('vimwiki/vimwiki')
call minpac#add('itchyny/lightline.vim')
call minpac#add('lervag/vimtex')
call minpac#add('godlygeek/tabular')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('justinmk/vim-sneak')
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
call minpac#add('voldikss/vim-translator')
call minpac#add('dbeniamine/cheat.sh-vim')
call minpac#add('glacambre/firenvim', { 'type': 'opt', 'do': 'packadd firenvim | call firenvim#install(0)'})
if exists('g:started_by_firenvim')
  packadd firenvim
endif


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
  " disable line numbers in temrinal mode
  au TermOpen * setlocal nonu nornu
endif

if has("autocmd")
    filetype plugin indent on
    syntax enable
    au FileType cpp setl sw=2 sts=2 expandtab
    au FileType python setl sw=4 sts=4 expandtab
    
    " clang-format, apt install clang-format
    autocmd FileType c,cpp,objc nnoremap <buffer><C-K> :<C-u>ClangFormat<CR>
    autocmd FileType c,cpp,objc vnoremap <buffer><C-K> :ClangFormat<CR>
    autocmd FileType c,cpp,objc nnoremap <buffer><C-;> :w<CR> :!make d<CR> :sp<CR> :te ./main <input00.txt <CR>

    " python run
    autocmd FileType python nnoremap <buffer><C-;> :w<CR> :sp<CR> :te python3 "%"<CR>

    " shell run
    autocmd FileType sh nnoremap <buffer><C-J> :w<CR> :sp<CR> :te bash "%"<CR>
    " nnoremap <C-H>  :bd! <CR>

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

    " grey out comment in jsonc
    au FileType json syntax match Comment +\/\/.\+$+
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
catch
endtry
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
    nnoremap <Leader>t :Tabularize /
    vnoremap <Leader>t :Tabularize /
    " nmap <Leader>t= :Tabularize /=<CR>
    " vmap <Leader>t= :Tabularize /=<CR>
    " nmap <Leader>t: :Tabularize /:\zs<CR>
    " vmap <Leader>t: :Tabularize /:\zs<CR>
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

"""""""""""""""""""""""""""""""""""""""""""""
""" Ultisnips
let g:UltiSnipsExpandTrigger='<c-i>'
" shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<c-j>'
" shortcut to go to previous position
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
" add additional snippets
let g:UltiSnipsSnippetDirectories = [$HOME.'/github/yhren/CppMacros/vim_snippets']
" set list all snippets
let g:UltiSnipsListSnippets = '<c-l>'
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
" map f <Plug>Sneak_f
" map F <Plug>Sneak_F
" map t <Plug>Sneak_t
" map T <Plug>Sneak_T
"""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""
""" vim-translator
"   <C-w>p to jump into the float window
nnoremap <silent> ]t <Plug>TranslateW
let g:translator_target_lang='zh'
let g:translator_default_engines=['google', 'haici', 'youdao']
let g:translator_window_max_width=0.7
let g:translator_window_max_height=0.7
"""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""
""" cheat.sh 
" Vim command used to open new buffer
" let g:CheatSheetReaderCmd='new"'
" Cheat sheet file type
let g:CheatSheetFt='markdown'
" Program used to retrieve cheat sheet with its arguments
let g:CheatSheetUrlGetter='curl --silent'
" Flag to add cookie file to the query
let g:CheatSheetUrlGetterIdFlag='-b'
" cheat sheet base url
let g:CheatSheetBaseUrl='https://cht.sh'
" cheat sheet settings do not include style settings neiter comments,
" see other options below
let g:CheatSheetUrlSettings='q'
" cheat sheet pager
let g:CheatPager='less -R'
" pygmentize theme used for pager output, see :CheatPager :styles-demo
" let g:CheatSheetPagerStyle=rrt
" Show comments in answers by default
" (setting this to 0 means giving ?Q to the server)
let g:CheatSheetShowCommentsByDefault=1
" Stay in origin buffer (set to 0 to keep focus on the cheat sheet buffer)
let g:CheatSheetStayInOrigBuf=1
" cheat sheet buffer name
let g:CheatSheetBufferName="_cheat"
" Default selection in normal mode (line for whole line, word for word under cursor)
let g:CheatSheetDefaultSelection="line"
" Default query mode
" 0 => buffer
" 1 => replace (do not use or you might loose some lines of code)
" 2 => pager
" 3 => paste after query
" 4 => paste before query
let g:CheatSheetDefaultMode=0
" Path to cheat sheet cookie
let g:CheatSheetIdPath=expand('~/.cht.sh/id')
" Make plugin silent by  setting bellow variable to 1
let g:CheatSheetSilent=0
"""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""
""" CoC
" coc extension list
let g:coc_global_extensions = ['coc-yank', 'coc-yaml', 'coc-word',
            \'coc-vimtex', 'coc-tsserver', 'coc-toml', 'coc-todolist',
            \'coc-texlab', 'coc-snippets', 'coc-rust-analyzer', 'coc-python',
            \'coc-pyright', 'coc-marketplace', 'coc-markdownlint', 'coc-json',
            \'coc-html', 'coc-highlight', 'coc-git', 'coc-explorer',
            \'coc-diagnostic', 'coc-cmake', 'coc-clangd', 'coc-translator']

" :CocUpdate 
set cmdheight=1
set updatetime=300
set shortmess+=c
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
nnoremap <Leader>cld :<C-u>CocList diagnosis<cr>
nnoremap <Leader>cle :<C-u>CocList extensions<cr>
nnoremap <Leader>cfg <c-w><c-n>:CocConfig<Cr>

""" coc-todo
nnoremap <Leader>clt :<C-u>CocList todolist<cr>
nnoremap <Leader>tdc :CocCommand todolist.create
nnoremap <Leader>tdu :CocCommand todolist.upload
nnoremap <Leader>tdd :CocCommand todolist.download
" :CocCommand todolist.create: create a new todo
" :CocCommand todolist.upload: upload todolist to gist
" :CocCommand todolist.download: download todolist from gist
" :CocCommand todolist.export: export todolist as a json/yaml file
" :CocCommand todolist.closeNotice: close notifications
" :CocCommand todolist.clear: clear all todos
" :CocCommand todolist.browserOpenGist: open todolist gist in gist.github.com
" :CocList todolist: to open the todolist <Tab>

""" coc-explorer
" press ? to show mapping help
nnoremap <Leader>e :CocCommand explorer<CR>

"""""""""""""""""""""""""""""""""""""""""""""
