set nocompatible              " be iMproved, required
filetype off                  " required

"{{{ Vundle
" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" Plugin 'VundleVim/Vundle.vim'
" " Plugin 'octol/vim-cpp-enhanced-highlight'
" Plugin 'tpope/vim-fugitive'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'scrooloose/syntastic'
" " Plugin 'kien/ctrlp.vim'
" " Plugin 'plasticboy/vim-markdown'
" Plugin 'itchyny/lightline.vim'
" " Plugin 'vim-airline/vim-airline'
" " Plugin 'vim-airline/vim-airline-themes'
" Plugin 'tomasr/molokai'
" Plugin 'aklt/plantuml-syntax'
" Plugin 'scrooloose/vim-slumlord'
" All of your Plugins must be added before the following line
" call vundle#end()            " required
filetype plugin indent on    " required
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"}}}


set nocp
set nu
set t_Co=256
set tabstop=2
set shiftwidth=2
set noexpandtab
set expandtab
set autoindent
set hlsearch
set showcmd
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
execute pathogen#infect()
syntax enable
set background=light
if has('gui_running')
  " colorscheme solarized
	colorscheme molokai
else
	colorscheme default
  set background=dark
  let g:solarized_termtrans = 1
  let g:solarized_termcolors=256
  let g:solarized_visibility="high"
  let g:solarized_contrast="high"
	" colorscheme solarized
	colorscheme molokai
endif

map<C-K> :pyf /Users/yren2/.vim/clang-format.py<cr>
map <F2> :.s/\w\+,/"\0:", \0/g <CR>

let g:ycm_python_binary_path = '/usr/bin/python3'
let g:molokai_original = 1

" {{{ for syntasitc
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" }}}

"{{{
" FINDING FILES:
set path+=**
set wildmenu
set wildmode=longest:list,full
"}}}

" TAG JUMPING: ctr-] ctr-t
command! MakeTags !ctags -R .

" HIGHLIGHTS: 
" ^x^f
" ^x^]
" " ^n and ^p

"{{{ netrw file browser
let g:netrw_banner=0
let g:netrw_browse_split=1
let g:netrw_winsize=25
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
"}}}

"{{{ for lightline plugin
"
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'Dracula',
      \}
"}}}

" SNIPPETS:
" Read a file into current cursor. :h read
nnoremap ,main :-1read $HOME/.compete/CppMacros/macros.h<CR>G
nnoremap ,enum :-1read $HOME/.vim/snippets/cpp/enum.h<CR>
nnoremap ,stratergy :-1read $HOME/.vim/snippets/cpp/stratergy.h<CR>
nnoremap ,observer :-1read $HOME/.vim/snippets/cpp/observer.h<CR>
nnoremap ,decorator :-1read $HOME/.vim/snippets/cpp/decorator.h<CR>
nnoremap ,command :-1read $HOME/.vim/snippets/cpp/command.h<CR>

nnoremap ,trie :-1read $HOME/.vim/snippets/cpp/data_structures/tries.h<CR>
nnoremap ,fenwick :-1read $HOME/.vim/snippets/cpp/data_structures/fenwick.h<CR>

" MAKE:
" can do other things
autocmd Filetype tex setlocal makeprg=pdflatex\ %
autocmd Filetype python setlocal makeprg=python\ %
" set makeprg=make
"
"
" Help: 
" help i_foo
" help c_bar
" :cn :cl :
" helpgrep
"

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
