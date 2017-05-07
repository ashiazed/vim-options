"-----------------------------------------------------------------------------------------------------------------------
" General Settings
"----------------------------------------------------------------------------------------------------------------------
filetype plugin on " Enable default plugins
let mapleader="\<Space>"
" Vim options that neovim has turned on but vim has off/ignores
set backspace=indent,eol,start
set nocompatible " Vim is non-compatible with vi. Neovim ignores this
set wildmenu " Turn on wildmenu for vim, Neovim defaults to on
set incsearch " Shows results for '/' search as you are typing the search
set hlsearch " After a '/' search, highlight the matches
" Regular settings
set path=** " Set path to look at all directories under current root
set wildignore=*/app/cache,*/vendor,*/env,*.pyc,*/venv,*/__pycache__ " Wildmenu will ignore these folder/file types
set expandtab " Expand tabs into spaces
set tabstop=4 " Default to 4 spaces
set shiftwidth=0 " Make shiftwidth value the same as tabstop
set history=1000 " Set number of ':' commands
set relativenumber " Use relative numbers in the sidebar
set number " Show line numbers in side bar
set nowrap " Turn off text wrapping long lines
set completeopt=menu,preview,noinsert " default is menu,preview. Don't insert text until selection is made
set wildmode=list:longest,full " wildmenu show list and completes longest, second tab completes full and cycles
set splitright " New windows split to the right of current one
set splitbelow " New windows split below the current one
set sessionoptions+=globals " Append globals to the default session options
set foldmethod=indent " Fold on Indent levels
" Custom status line
set statusline=
set statusline+=%1*\ %02c\                    " Color
set statusline+=%2*\ »                        " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
set statusline+=%3*\ %<%F\                    " File+path
set statusline+=%2*\«                         " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
set statusline+=%2*\ %=\ %l/%L\ (%02p%%)\     " Rownumber/total (%)
" Set spacing of file types
autocmd FileType html setlocal tabstop=2
autocmd FileType htmljinja setlocal tabstop=2
autocmd FileType htmldjango setlocal tabstop=2
autocmd FileType php setlocal tabstop=4
autocmd FileType python setlocal tabstop=4
autocmd FileType sh setlocal tabstop=4
autocmd FileType javascript setlocal tabstop=4
autocmd FileType json setlocal tabstop=4
autocmd FileType make setlocal tabstop=4 noexpandtab
autocmd FileType scss setlocal tabstop=2
autocmd FileType ledger setlocal tabstop=2
autocmd FileType vim setlocal tabstop=2
" Make netrw prettier
let g:netrw_banner = 0  " Hide the banner
let g:netrw_liststyle = 3     " Tree view
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " Hide dotfiles
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Color/Theming Options
"-----------------------------------------------------------------------------------------------------------------------
" 0 = dark background  // 1 = red
" 2 = green            // 3 = yellow
" 4 = light blue       // 5 = pink
" 6 = cyan             // 7 = beige
" 8 = dark blue        // 9 = orange
" 10 = dark grey       // 11 = grey
" 12 = light grey      // 13 = purple
" 14 = grey            // 15 = white
" 16 = black
syntax enable " Enable syntax highlighiting of files
colorscheme gruvbox " Set the colorscheme
set background=dark " Use dark colorscheme
" Set vimdiff colors, make it easier to read
highlight DiffAdd    cterm=BOLD ctermfg=NONE ctermbg=22
highlight DiffDelete cterm=BOLD ctermfg=NONE ctermbg=52
highlight DiffChange cterm=BOLD ctermfg=NONE ctermbg=23
highlight DiffText   cterm=BOLD ctermfg=NONE ctermbg=23
" Set syntax of files that vim doesn't recognize
au BufRead,BufNewFile *.twig set syntax=htmljinja
au BufRead,BufNewFile *.html set syntax=htmljinja
au BufNewFile,BufRead *.yml set filetype=yaml
au BufNewFile,BufRead *.sls set filetype=yaml
au BufNewFile,BufRead *.inc set filetype=php
au BufNewFile,BufRead *.module set filetype=php
au BufRead,BufNewFile *.ejs set syntax=htmljinja
au BufRead,BufNewFile *.md set filetype=markdown
" Highligh current cursorline
hi CursorLineNR cterm=bold ctermfg=226
" Status line colors  per mode 
hi User1 ctermfg=NONE  ctermbg=NONE cterm=bold
hi User3 ctermfg=NONE  ctermbg=NONE
hi User2 ctermfg=NONE  ctermbg=NONE
" Change gutter color
highlight SignColumn cterm=NONE ctermfg=0 ctermbg=8
" Highlight long lines at 80 mark
highlight ColorColumn ctermbg=cyan
au BufNewFile,BufRead * call matchadd('ColorColumn', '\%81v', 100)
" Highlight super long lines
au BufNewFile,BufRead * call matchadd('Error', '\%121v', 100)
" Disable background colors for transparency
hi Normal guibg=NONE ctermbg=NONE
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Vim vs Neovim settings
"-----------------------------------------------------------------------------------------------------------------------
if has('nvim')
  let $HOME='.vimcache'
  let $EditorDir='/root/.config/nvim/'
  let $SessionDir='.vimcache'
	silent! execute '!mkdir -p .vimcache/backup'
	" Set Backup dirs
	set backupdir=.vimcache/backup/
	set directory=.vimcache/swp/
  let g:syntastic_python_python_exec = '/usr/bin/python3'
  nnoremap <leader>er :call RestoreSession()<CR>
else
  let $EditorDir=$HOME.'/.vim/'
  let $SessionDir='.'
	" Set Backup dirs
  set backupdir=~/.vim/vim-files/backups/
  set directory=~/.vim/vim-files/swaps/
  let g:vimwiki_list = [{'path': '~/Wiki/wiki', 'path_html': '~/Wiki/wiki_html/', 'ext': '.wiki'}]
endif



"-----------------------------------------------------------------------------------------------------------------------
" Custom functions
"-----------------------------------------------------------------------------------------------------------------------
" Taken from ins-completion docs. Tab if only whitespace, autocomplete if there is text
function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-N>"
   endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>
" Ctags for python project
command! MakeTagsPython !ctags --languages=python --python-kinds=-i -R .
" Command for figuring out highlight group
map <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
" Turn off syntax highlighting
nnoremap <leader><leader> :noh<CR>
" Shortcut for creating a new tab
nnoremap <C-w>t :tabnew<CR>
" Formating a json file
com! Formatjson %!python -m json.tool
" Visually select pasted text
nnoremap gp `[v`]
" Yank withouth newline
nmap yY ^y$$
" Vimdiff commands
nnoremap <leader>du :diffupdate<CR>
nnoremap <leader>dd :diffget<CR>
nnoremap <leader>df :diffput<CR>
nnoremap _ [c
nnoremap = ]c
" Open folder of current file
nnoremap <leader>n :e %:p:h<CR>
" Function for saving session
function! SaveSession()
  :mksession! $SessionDir/session.vim
  :echo 'Session Saved!'
endfunction
nnoremap <leader>ee :call SaveSession()<CR>
" Function for restoring session
function! RestoreSession()
  :source $SessionDir/session.vim
endfunction
" Some very useful shortcuts for editing Ledger entries
" Copy the last entry
nnoremap <leader>ll G{jV}y}p10l
" Copy the current entry to the bottom
nnoremap <leader>lb {jV}yGp10l
" Copy the current entry to the next position
nnoremap <leader>ln {jV}y}p10l
" Jump down from line to replace dollar ammount
nnoremap <leader>ld j^f$lC
" Snippets
nnoremap <leader>,date :-1read !date +\%F<CR>
nnoremap <leader>,fabfile :-1read $EditorDir/plugged/vim-options/snippets/python/fabfile.py<CR>
nnoremap <leader>,cutf8 :-1read $EditorDir/plugged/vim-options/snippets/python/cutf8.py<CR>jf.i
nnoremap <leader>,pudb :-1read $EditorDir/plugged/vim-options/snippets/python/pudb.py<CR>V
nnoremap <leader>,pydef :-1read $EditorDir/plugged/vim-options/snippets/python/pydef.py<CR>/jump<CR>V12j
nnoremap <leader>,pyclass :-1read $EditorDir/plugged/vim-options/snippets/python/pyclass.py<CR>/jump<CR>
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Ack Searching
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/ack.vim/plugin/ack.vim'))
  nnoremap <leader>/ :call AckSearch()<CR>
  function! AckSearch()
    call inputsave()
    let term = input('Search: ')
    call inputrestore()
    if !empty(term)
        execute "Ack! '" . term . "'"
    endif
  endfunction
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Argwrap
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/vim-argwrap/plugin/argwrap.vim'))
	nnoremap <silent> <leader>a :ArgWrap<CR>
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" CamelCaseMotion
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/CamelCaseMotion/plugin/camelcasemotion.vim'))
  map <silent> ,w <Plug>CamelCaseMotion_w
  map <silent> ,e <Plug>CamelCaseMotion_e
  map <silent> ,b <Plug>CamelCaseMotion_b
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Fugitive
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/vim-fugitive/plugin/fugitive.vim'))
	" Command for toggling git status
  function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
      bd .git/index
    else
      Gstatus
    endif
  endfunction
  command ToggleGStatus :call ToggleGStatus()
  nnoremap <leader>gs :ToggleGStatus<CR>
  nnoremap <leader>gc :Gcommit --verbose<CR>
  nnoremap <leader>gd :Gdiff<CR>
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Indent Lines Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/vim-indent-guides/plugin/indent_guides.vim'))
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_auto_colors = 0
  let g:indent_guides_exclude_filetypes =['help', 'nerdtree']
  let g:indent_guides_start_level = 2
  let g:indent_guides_guide_size = 1
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=237
  autocmd VimEnter,Colorscheme * :IndentGuidesEnable
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Ledger
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/SimpylFold/ftplugin/python/SimpylFold.vim'))
  au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Nerdtree Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/nerdtree/plugin/NERD_tree.vim'))
  " Disable ? do I can fucking reverse search
  :autocmd FileType nerdtree silent! nunmap <buffer> ?
	let g:NERDTreeShowLineNumbers=1
	let g:NERDTreeDirArrows=0
	let g:NERDTreeWinSize = 40
	let g:NERDTreeIgnore = ['\.pyc$']
	let g:NERDTreeDirArrows = 1
	let g:NERDTreeDirArrowExpandable = '▸'
	let g:NERDTreeDirArrowCollapsible = '▾'
	let g:NERDTreeMapOpenSplit = 's'
	let g:NERDTreeMapPreviewSplit = 'gs'
	let g:NERDTreeMapOpenVSplit = 'v'
	let g:NERDTreeMapPreviewVSplit = 'gv'
endif
"-----------------------------------------------------------------------------------------------------------------------
 


"-----------------------------------------------------------------------------------------------------------------------
" Markdown
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/vim-markdown/indent/markdown.vim'))
  let g:vim_markdown_folding_disabled=1
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Python-Syntax 
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/python-syntax/syntax/python.vim'))
  let python_highlight_all = 1
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Syntastic
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/syntastic/plugin/syntastic.vim'))
  let g:syntastic_php_checkers = ['php', 'phpcs']
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_scss_checkers = ['sass_lint']
  let g:syntastic_php_phpcs_args = "--standard=".$HOME."/PEARish.xml,PSR2,Symfony2"
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_wq = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_aggregate_errors = 1
  let g:syntastic_mode_map = { 'mode': 'active' }
  function! ToggleSyntasticMode()
python << EOF
import vim
import ast
value = dict(vim.eval('g:syntastic_mode_map'))
vim.command('let l:syntastic_current_mode = \''+value['mode']+'\'')
EOF
    SyntasticToggleMode
    if l:syntastic_current_mode == 'passive'
      SyntasticCheck
      let g:syntastic_check_on_wq = 0
      let g:syntastic_check_on_open = 0
    else 
      let g:syntastic_check_on_wq = 1
      let g:syntastic_check_on_open = 1
    endif
  endfunction
  nnoremap <leader>s :call ToggleSyntasticMode()<CR>
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Taboo
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/taboo.vim/plugin/taboo.vim'))
  au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
  function! RenameTab()
    call inputsave()
    let term = input('Tabname: ')
    call inputrestore()
    if !empty(term)
      execute ":TabooRename " . term
    endif
  endfunction
  nnoremap <leader>r :call RenameTab()<CR>
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Vdebug Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/vdebug/plugin/vdebug.vim'))
  let g:vdebug_options = {
  \    "watch_window_style" : 'compact',
  \    "port" : 9000,
  \    "path_maps" : {
  \         "/var/www/html": "/Users/hiarc/myprojectdir",
  \     },
  \}
  "Delete all breakpoints
  :command! BR BreakpointRemove *
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Vim JSON
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob($EditorDir.'plugged/vim-json/indent/json.vim'))
  let g:vim_json_syntax_conceal = 0
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Basic movements (h, j, k, l) require a number prefix. Break bad habits
"-----------------------------------------------------------------------------------------------------------------------
function! DisableIfNonCounted(move) range
  if v:count
    return a:move
  else
    " You can make this do something annoying like:
    " echoerr "Count required!"
    " sleep 2
    return ""
  endif
endfunction

function! SetDisablingOfBasicMotionsIfNonCounted(on)
  let keys_to_disable = get(g:, "keys_to_disable_if_not_preceded_by_count", ["j", "k", "l", "h"])
  if a:on
    for key in keys_to_disable
      execute "noremap <expr> <silent> " . key . " DisableIfNonCounted('" . key . "')"
    endfor
    let g:keys_to_disable_if_not_preceded_by_count = keys_to_disable
    let g:is_non_counted_basic_motions_disabled = 1
  else
    for key in keys_to_disable
      try
        execute "unmap " . key
      catch /E31:/
      endtry
    endfor
    let g:is_non_counted_basic_motions_disabled = 0
  endif
endfunction

function! ToggleDisablingOfBasicMotionsIfNonCounted()
  let is_disabled = get(g:, "is_non_counted_basic_motions_disabled", 0)
  if is_disabled
    call SetDisablingOfBasicMotionsIfNonCounted(0)
  else
    call SetDisablingOfBasicMotionsIfNonCounted(1)
  endif
endfunction

command! ToggleDisablingOfNonCountedBasicMotions :call ToggleDisablingOfBasicMotionsIfNonCounted()
command! DisableNonCountedBasicMotions :call SetDisablingOfBasicMotionsIfNonCounted(1)
command! EnableNonCountedBasicMotions :call SetDisablingOfBasicMotionsIfNonCounted(0)

" Call this function to enable Hard Mode
"DisableNonCountedBasicMotions
