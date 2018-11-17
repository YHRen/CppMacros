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

syntax enable
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized


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
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-dispatch')
call minpac#add('radenling/vim-dispatch-neovim')
call minpac#add('w0rp/ale')
call minpac#add('altercation/vim-colors-solarized')
call minpac#add('rhysd/vim-clang-format')
call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
call minpac#add('k-takata/minpac', {'type': 'opt'})
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v> <Esc> <Esc>
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif

filetype plugin indent on
au FileType cpp setl sw=2 sts=2 expandtab
au FileType python setl sw=4 sts=4 et

" clang-format 
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>ck :<C-u>ClangFormat<CR>
autocmd FileTYpe c,cpp,objc vnoremap <buffer><Leader>ck :ClangFormat<CR>



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
