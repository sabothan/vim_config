"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
  "Custom popup menu with snippet support
  "Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " NERDTree (navigation sidebar)
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

  " Custom icons for vim plugins (e.g. NERDTree) 
  Plug 'ryanoasis/vim-devicons'

  " A Vim plugin which shows a git diff in the sign column. It shows which lines have been added, modified, or removed. 
  Plug 'airblade/vim-gitgutter'

  " Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
  Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files

  " The NERD commenter provides many different commenting operations and styles which are invoked via key mappings and 
  " a menu. These operations are available for most filetypes.
  Plug 'scrooloose/nerdcommenter' 

  " Provides mappings to move between vim panes and tmux splits "
  Plug 'christoomey/vim-tmux-navigator'
    "<ctrl-h> - Left
    "<ctrh-j> - Down
    "<ctrl-k> - Up
    "<ctrl-l> - Right
    "<ctrl-\> - Previous split

  " Color scheme for vim 
  Plug 'morhetz/gruvbox'

  " Display a status line at the bottom of each vim window
  Plug 'vim-airline/vim-airline' 
  Plug 'vim-airline/vim-airline-themes' 
  
  " TypeScript syntax highlithing"
  "Plug 'HerringtonDarkholme/yats.vim' 

  " React syntax highlighting and indenting plugin for vim. Also supports the typescript tsx file.
  "Plug 'maxmellon/vim-jsx-pretty'
  
  " This plugin provides extended matching for the % operator.
  Plug 'adelarsq/vim-matchit'
call plug#end()

"-------------------------------------------------------------------------------
" General
"-------------------------------------------------------------------------------
" Specify <Leader> key
let mapleader = ","
let g:mapleader = ","

set backspace=indent,eol,start "allow backspacing over everything in insert mode (including automatically inserted indentation, line breaks and start of insert)
set mouse=a "Enable mouse support for vim
set ignorecase "set search to not be case-sensitive
set incsearch "show partial matches when searching
set belloff=all "disable 'error' sound effect"
set foldmethod=indent "Lines with the same indent level will be collapled: toggle with <za>(single level), <zA>(includinngn sublevels)
set nosmarttab 
set cindent
set tabstop=4 "Number of spaces a <TAB> counts for"
set shiftwidth=2
set expandtab "always uses spaces instead of tab characters

" Map 'yank' and 'paste' to PRIMARY(*, copy-on-select, paste with middle mouse), CLIPBOARD(*, copy with ^+c, paste with ^+v)"
noremap <Leader>y "+y
noremap <Leader>p "+p
"noremap <Leader>Y "*y
"noremap <Leader>P "*p
vmap <Leader>y "+y
vmap <Leader>p "+p

" In a nutshell, by allowing hidden buffers with set hidden, you're telling Vim that you can have unsaved worked that's not displayed on your screen.
set hidden

" If this many [ms] nothing is typed, then the swap file will be written to disk (see crash-recovery)"
set updatetime=300

" This option helps to avoid hit-enter prompts caused by file messages.
" Here: don't give |ins-completion-menu| messages.
set shortmess+=c

nnoremap <Leader>t :tabs<CR> "List tab pages and the windows they contain"

nnoremap <leader>r @:

nnoremap - <C-w><
tnoremap <Esc> <C-\><C-n>
inoremap <C-BS> <C-w>

" Specify an external tool to use for listing files instead of using VIM's 
" globpath(). Use %s in place of targed directory:
"   >> let g:ctrlp_user_command = ''
" You can also use 'grep', 'findstr', etc. to filter the results. Example:
"   >> let g:ctrlp_user_command = 'find %s -type f | grep -v -P "\.jpg$|/tmp/"'
" Use a version control listing command when inside a repository, this is 
" faster when scanning large projects:
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


"-------------------------------------------------------------------------------
" Appearance, window, format, ...
"-------------------------------------------------------------------------------
set bg=dark "Set background color"
colorscheme gruvbox "set gruvbox as color scheme"
set number "Enable line numbering
set hlsearch "Always highlight the search matches"
set laststatus=2 "last window will always have a status line"
set statusline+=%F "define content of status line"
syntax on "Enable syntax highlighting"
highlight Normal ctermbg=None
set signcolumn=yes "always show signcolumns

" Increase window width by 5 columns
nnoremap <Leader>w+ :vertical resize +5<CR>

" Decrease window width by 5 columns
nnoremap <Leader>w- :vertical resize -5<CR>


"-------------------------------------------------------------------------------
" vim-airline
"-------------------------------------------------------------------------------
"let g:airline_theme='dark'
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1                  


"-------------------------------------------------------------------------------
" NERDTree
"-------------------------------------------------------------------------------
nmap <leader>n :NERDTreeFocus<CR>
nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

let NERDTreeShowHidden=1 "Always show hidden files within NERDTree"
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']


" sync open file with NERDTree
" Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufRead * call SyncTree()

nnoremap <Esc>tC :call NERDComment(0, "toggle")<CR>
vnoremap <Esc>tC :call nerdcommenter#Comment(0, "toggle")<CR>

nnoremap <D-/> :call NERDComment(0, "toggle")<CR>
vnoremap <D-/> :call nerdcommenter#Comment(0, "toggle")<CR>
