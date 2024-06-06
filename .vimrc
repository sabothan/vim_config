" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
  "Custom popup menu with snippet support
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " NERDTree (navigation sidebar"
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
  Plug 'HerringtonDarkholme/yats.vim' 

  " React syntax highlighting and indenting plugin for vim. Also supports the typescript tsx file.
  Plug 'maxmellon/vim-jsx-pretty'

  " This plugin provides extended matching for the % operator.
  "Plug 'https://github.com/adelarsq/vim-matchit'
  Plug 'adelarsq/vim-matchit'

  " Github themes for neovim
  "Plug 'projekt0n/github-nvim-theme', { 'tag': 'v0.0.7' }
call plug#end()

set bg=dark
set hlsearch "Always highlight the search matches"
set backspace=indent,eol,start "allow backspacing over everything in insert mode (including automatically inserted indentation, line breaks and start of insert)
set mouse=a "Enable mouse support for vim
set ignorecase "set search to not be case-sensitive
set incsearch "show partial matches when searching
set belloff=all "disable 'error' sound effect"
set foldmethod=indent "Lines with the same indent level will be collapled: toggle with <za>(single level), <zA>(includinngn sublevels)
set number "Enable line numbering
set nosmarttab
set cindent
set tabstop=4 "Number of spaces a <TAB> counts for"
set shiftwidth=2
set expandtab "always uses spaces instead of tab characters
set laststatus=2
set statusline+=%F  
    

nmap <leader>n :NERDTreeFocus<CR>
nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
nnoremap gb :ls<CR>:b<Space>
nnoremap ge yiw:%s/<C-r>0//g<Left><Left>
nnoremap = <C-w>>
noremap <Leader>y "+y
noremap <Leader>p "+p
vmap <Leader>y "+y
vmap <Leader>p "+p
nnoremap <leader>r @:


nnoremap - <C-w><
tnoremap <Esc> <C-\><C-n>
inoremap <C-BS> <C-w>

" Increase window width by 5 columns
nnoremap <Leader>w+ :vertical resize +5<CR>

" Decrease window width by 5 columns
nnoremap <Leader>w- :vertical resize -5<CR>
nnoremap <Leader>t :tabs<CR>

let g:NERDTreeGitStatusWithFlags = 1
let g:airline_theme='gruvbox'
colorscheme gruvbox
"syntax enable
highlight Normal ctermbg=None
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
"let g:vim_jsx_pretty_colorful_config = 1


let mapleader = ","
let g:mapleader = ","



let g:airline_theme='dark'
let g:airline_powerline_fonts = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",  
    "\ "Modified"  : "#d9bf91",  
    "\ "Renamed"   : "#51C9FC",  
    "\ "Untracked" : "#FCE77C",  
    "\ "Unmerged"  : "#FC51E6",  
    "\ "Dirty"     : "#FFBD61",  
    "\ "Clean"     : "#87939A",   
    "\ "Ignored"   : "#808080",    
"\}                         


let g:NERDTreeIgnore = ['^node_modules$']

" vim-prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync


" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')


" sync open file with NERDTree
" " Check if NERDTree is open or active
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
"autocmd BufEnter * call SyncTree()
autocmd BufRead * call SyncTree()

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-html',
  \ 'coc-clangd',
  \ 'coc-java',
  \ ]
" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d


" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')


" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"


nnoremap <Esc>tC :call NERDComment(0, "toggle")<CR>
vnoremap <Esc>tC :call nerdcommenter#Comment(0, "toggle")<CR>

nnoremap <D-/> :call NERDComment(0, "toggle")<CR>
vnoremap <D-/> :call nerdcommenter#Comment(0, "toggle")<CR>
