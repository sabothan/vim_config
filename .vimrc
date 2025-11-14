"-------------------------------------------------------------------------------
" Configure the handling of VIMs temporary and swap files
"-------------------------------------------------------------------------------
set backupdir=$TEMPDIR//
set directory=$TEMPDIR//

"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
  "Custom popup menu with snippet support
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

  " Color scheme for vim 
  Plug 'morhetz/gruvbox'

  " Display a status line at the bottom of each vim window
  Plug 'vim-airline/vim-airline' 
  Plug 'vim-airline/vim-airline-themes' 
  
  " This plugin provides extended matching for the % operator.
  Plug 'adelarsq/vim-matchit'

  " Plugin to mark merge-conflicts in color
  Plug 'rhysd/conflict-marker.vim'
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
set nocindent
set tabstop=4 "Number of spaces a <TAB> counts for"
set shiftwidth=4
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

" Command to insert a new line at the current cursor position
nnoremap <leader>o i<CR><Esc>


"-------------------------------------------------------------------------------
" Appearance, window, format, ...
"-------------------------------------------------------------------------------
set bg=dark "Set background color"
colorscheme gruvbox "set gruvbox as color scheme"
set number "Enable line numbering
set hlsearch "Always highlight the search matches"
set laststatus=2 "last window will always have a status line"
set statusline+=%F "define content of status line"
set cursorline " Highlight the current line
syntax on "Enable syntax highlighting"
highlight Normal ctermbg=None

" Increase window width by 5 columns
nnoremap <Leader>w+ :vertical resize +5<CR>

" Decrease window width by 5 columns
nnoremap <Leader>w- :vertical resize -5<CR>


"-------------------------------------------------------------------------------
" Highlight Git conflict markers (GitLab-style)
"
" conflict-marker.vim default mappings
"
" Normal mode (when cursor is inside a conflict block):
"   co   ‚Üí choose ours      (keep current branch, delete theirs + markers)
"   ct   ‚Üí choose theirs    (keep incoming branch, delete ours + markers)
"   cb   ‚Üí choose both      (keep ours + theirs, delete markers)
"   cB   ‚Üí choose both (ours first)
"   cn   ‚Üí choose none      (delete everything, leave empty block)
"
" Text objects (for operators like d, y, v):
"   ic   ‚Üí inner conflict   (just the conflicting lines)
"   ac   ‚Üí a conflict       (whole block including markers)
"
" Example: `vic` selects the inner conflict, `dac` deletes the whole block.
"-------------------------------------------------------------------------------

" Don‚Äôt use default Diff* highlight groups
let g:conflict_marker_highlight_group = ''

let g:conflict_marker_begin = '^<<<<<<<\+ .*$'
let g:conflict_marker_common_ancestors = '^|||||||\+ .*$'
let g:conflict_marker_end   = '^>>>>>>>\+ .*$'

augroup ConflictMarkerHighlights
  autocmd!
  autocmd VimEnter,ColorScheme * call s:ConflictMarkerColors()
augroup END

function! s:ConflictMarkerColors() abort
  " Conflict marker lines (<<<<<<<, >>>>>>>)
  highlight ConflictMarkerBegin ctermbg=52  guibg=#6e1e1e guifg=#ffffff
  highlight ConflictMarkerEnd   ctermbg=52  guibg=#6e1e1e guifg=#ffffff

  " Separator (=======)
  highlight ConflictMarkerSeparator ctermbg=238 guibg=#444444 guifg=#f0f0f0

  " Our changes (green, like GitLab "ours")
  highlight ConflictMarkerOurs  ctermbg=22  guibg=#1f4523 guifg=#d1f5d3

  " Their changes (blue, like GitLab "theirs")
  highlight ConflictMarkerTheirs ctermbg=24 guibg=#1e3f66 guifg=#d3e5f5

  " Common ancestor (neutral gray/purple)
  highlight ConflictMarkerCommonAncestorsHunk ctermbg=240 guibg=#3f3f3f guifg=#e0e0e0
endfunction


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

" Automatically refresh NERDTree when focusing to the window
autocmd BufEnter NERD_tree_* | execute 'normal R'

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

"-------------------------------------------------------------------------------
" GitGutter
"-------------------------------------------------------------------------------
" To ensure that signs are always up-to-date, you can set up an autocmd  
" to refresh vim-gitgutter whenever the file is saved or the buffer changes
autocmd BufWritePost,TextChanged,TextChangedI * GitGutter


"-------------------------------------------------------------------------------
" Conquer of Completion: CoC
"-------------------------------------------------------------------------------

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
set signcolumn=yes

" Map <tab> for trigger completion, completion confirm, snippet expand and jump like VSCode
" NOTE: There's always complete item selected by default, you may want to enable no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin before putting this into your config
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ CheckBackspace() ? "\<TAB>" :
  \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'

" Use `ge` and `gE` to navigate diagnostic errors
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
" Checkout <:h coc-config-diagnostics> for further info
nmap <silent> ge <Plug>(coc-diagnostic-next-error)
nmap <silent> gE <Plug>(coc-diagnostic-prev-error)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gD <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Scroll viewport normally; if a CoC float is scrollable, scroll the float instead
if (has('nvim-0.4.0') || has('patch-8.2.0750')) && exists('*coc#float#has_scroll')

  " --- Normal mode ---
  nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll()
        \ ? coc#float#scroll(1)
        \ : "\<C-e>"      " scroll window down one line
  nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll()
        \ ? coc#float#scroll(0)
        \ : "\<C-y>"      " scroll window up one line

  " --- Visual mode ---
  " (keeps selection while you scroll the viewport)
  vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll()
        \ ? coc#float#scroll(1)
        \ : "\<C-e>"
  vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll()
        \ ? coc#float#scroll(0)
        \ : "\<C-y>"

  " --- Insert mode ---
  " Use <C-o> to execute one Normal-mode scroll without leaving Insert
  inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll()
        \ ? "\<C-r>=coc#float#scroll(1)\<CR>"
        \ : "\<C-o>\<C-e>"
  inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll()
        \ ? "\<C-r>=coc#float#scroll(0)\<CR>"
        \ : "\<C-o>\<C-y>"

endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Option to toggle the visibility of inlay hints (descriptions of the
" argumants in a function e.g. foo(arg1: 'hello'):
nnoremap <leader>hint :CocCommand document.toggleInlayHint<CR>
