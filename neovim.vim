if !exists('g:vscode') " Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Debug
" Plug 'puremourning/vimspector', {'tag':'*'}
" " swift
" Plug 'keith/swift.vim'
" kotlin
" Plug 'udalov/kotlin-vim'
"git 
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" install statusline
Plug 'itchyny/lightline.vim'
"Gruvbox theme
Plug 'morhetz/gruvbox'
"python linting
Plug 'dense-analysis/ale'
" comment out line of code
Plug 'tpope/vim-commentary'
" tagbar learn from LSP servers
Plug 'liuchengxu/vista.vim'
" Python specified text object

" syntax hightlight
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" color scheme
Plug 'junegunn/seoul256.vim'
"python indentation
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim' 
" Plug 'sheerun/vim-polyglot'
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'


" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }


" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'
" Initialize plugin system
call plug#end()
let g:lsc_auto_map = v:true
syntax on
let g:airline_theme='one'
"setting
"disable python 2 support
let g:loaded_python_provider = 0
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.8/bin/python3'
autocmd FileType python nnoremap <leader>y :0,$!yapf<Cr>
autocmd CompleteDone * pclose " To close preview window of deoplete automagically
nmap <C-n> :NERDTreeToggle<CR>

" if hidden is not set, TextEdit might fail.
set hidden
" hide default mode show
set noshowmode
" Set the background theme to dark
" git
" show gitgutter status
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

" set airline git vim
let g:airline#extensions#tabline#enabled = 1

" This line enables the true color support.
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set background=dark " for the dark version
"set background=light " for the light version
colorscheme onedark
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup fmt
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
" call CocFix
nnoremap <C-f> :CocFix<CR> 
nnoremap <leader>o :Files<CR> 
nnoremap <leader>p :Buffers<CR> 
" nnoremap <C-e> :e#<CR>
" Fix autofix problem of current line
nmap <leader>gf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" preview for fzf
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.vim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

" coc config 
let g:coc_global_extensions = [
      \ 'coc-emoji',
      \ 'coc-tsserver',
      \ 'coc-html',
      \ 'coc-python',
      \ 'coc-css',
      \ 'coc-json',
      \ 'coc-go',
      \ 'coc-eslint',
      \ 'coc-tslint-plugin',
      \ 'coc-prettier',
      \ 'coc-stylelint',
      \ 'coc-pyls',
      \ 'coc-java',
      \ 'coc-rls',
      \ 'coc-solargraph',
      \ 'coc-wxml',
      \ 'coc-xml',
      \ 'coc-yaml',
      \ 'coc-highlight',
      \ 'coc-emmet',
      \ 'coc-vimlsp',
      \ 'coc-tailwindcss',
      \ 'coc-svg',
      \ 'coc-angular',
      \ 'coc-snippets',
      \ 'coc-imselect',
      \ 'coc-yank',
      \ 'coc-pairs',
      \ 'coc-git',
      \ 'coc-lists',
      \ 'coc-diagnostic',
      \ 'coc-gitignore',
      \ 'coc-project',
      \ 'coc-post',
      \ 'coc-clock',
      \ 'coc-marketplace',
      \ 'coc-smartf',
      \ 'coc-tabnine',
      \ 'coc-jest',
      \ 'coc-calc',
      \ 'coc-webpack',
      \ 'coc-explorer',
      \ 'coc-svelte',
      \ 'coc-flutter',
      \ 'coc-zi',
      \ 'coc-spell-checker',
      \ 'coc-cspell-dicts',
      \ 'coc-actions',
      \ 'https://github.com/xabikos/vscode-react',
      \ 'https://github.com/xabikos/vscode-javascript'
      \]
" coc-explorer
noremap <silent> <leader>e :execute 'CocCommand explorer' .
      \ ' --toggle' .
      \ ' --position=floating' .
      \ ' --sources=file+'<CR>
" Open translators list with the current word
nnoremap <silent> <space>lt  :<C-u>CocList --input=<C-r>=expand('<cword>')<cr> --interactive translators<cr>
" Open yank list
nnoremap <silent> <space>ly  :<C-u>CocList -A --normal yank<cr>
" use <tab> for trigger completion and navigate next complete item
function! s:check_back_space() abort
  let l:col= col('.') - 1
  return !l:col|| getline('.')[l:col- 1]  =~# '\s'
endfunction
" Use K for show documentation in float window
nnoremap <silent> K :call CocActionAsync('doHover')<CR>
" status line set up
set statusline^=%{coc#status()}
set number relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" config for vim clap
let g:clap_layout = { 'relative': 'editor' }
" ============= Dart and flutter config ===========
call dart#ToggleFormatOnSave()
" flutter commands
nnoremap <silent> <space>cf  :<C-u>CocList --input=flutter. --normal commands<CR>
" ============== Python setting ================
" indentation
au BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
" folding
" au BufNewFile,BufRead *.py \
  " set foldmethod=indent
nnoremap <space> za
" specify lint filetype
let g:ale_linters = {
		\ 'python':['flake', 'pylint'],
		\}
let g:ale_fixers = {
		\ 'python' : ['yapf'],
		\}

nmap <F10> :ALEFix<CR>

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
	  \   'method': 'NearestMethodOrFunction'
      \ },
      \ }
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
"smart rename
nmap <leader>rn <Plug>(coc_rename)
" quick swap buffers file
"set theme gruvbox
autocmd vimenter * colorscheme gruvbox
"" Clean search (highlight)
nnoremap <silent> <ESC><ESC> :noh<cr>
endif
