"-----------------------------------------------------------------------------------------------------------------------
" User Preferences
"-----------------------------------------------------------------------------------------------------------------------
filetype plugin indent on " Make sure indenting works
let mapleader="\\" " Set map leader
set omnifunc=syntaxcomplete#Complete " Set Autocomplete
set expandtab " Expand tabs into spaces
set tabstop=2 " Number of space that tab counts for
set shiftwidth=2 " Number of spaces for each autoindent
set textwidth=0 " Maximium width of text that is being inserted. 0 disables it
set history=1000 " Set history of : commands
set autoindent " Copy the indentation from the previous line
set cindent " Get ammount of indent according to C indent rules
set relativenumber " Use relative numbers
set number " Show line numbers
set nowrap " Turn off TextWrapping
set completeopt=longest,menuone " Autocomplete options
set wildmode=longest,list " Completion mode for wildchar
set backspace=indent,eol,start " Backspace over everything in insert mode
set laststatus=2 " Show the status bar always
set wildignore=*/app/cache,*/vendor,*/env,*.pyc,*/venv " Ignore useless files
set splitright " Horizontal Splits go to the right
set splitbelow " Vertical  Splits go underneath
set incsearch " Move cursor to matched string
set hlsearch  " Turn off highlight search
set sessionoptions+=tabpages,globals " Include tab names in sessions
set backup
set background=dark
set statusline=
set statusline+=%1*\ %02c\                    "Colnr
set statusline+=%2*\ »                        "RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
set statusline+=%3*\ %<%F\                    "File+path
set statusline+=%2*\«
set statusline+=%2*\ %=\ %l/%L\ (%02p%%)\             "Rownumber/total (%)
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Specific settings for Neovim/Vim
"-----------------------------------------------------------------------------------------------------------------------
if has('nvim')
  let EditorDir=$HOME.'/.config/nvim/'
  let CacheDir='./.vimcache/'
   " Create the dirs
 silent! execute '!mkdir -p '.CacheDir.'backup'
 " Set Backup dirs
 set backupdir=./.vimcache/backup/
 set directory=./.vimcache/swp/
 let g:ctrlp_clear_cache_on_exit = 0
 let g:ctrlp_cache_dir = CacheDir.'ctrlp'
 let g:deoplete#sources#jedi#python_path = '/usr/bin/python3'
 let g:syntastic_python_python_exec = '/usr/bin/python3'
else
  " Vim Options
  let EditorDir=$HOME.'/.vim/'
  let CacheDir=$HOME.'/.vim/vim-files/'
  set lazyredraw "Stops flashing from command above and helps save on processing
	set backupdir=~/.vim/vim-files/backups/
	set directory=~/.vim/vim-files/swaps/
	let g:vimwiki_list = [{'path': '~/Wiki/wiki', 'path_html': '~/Wiki/wiki_html/', 'ext': '.markdown'}]
endif
"-----------------------------------------------------------------------------------------------------------------------
  


"-----------------------------------------------------------------------------------------------------------------------
" Custom Mappings
"-----------------------------------------------------------------------------------------------------------------------
" Turn off syntax highlighting
nnoremap <leader><space> :noh<CR>
" Hardcore Mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
" Highlighting in vim leaves your cursor wherever you ended at
:vmap y ygv<ESC>
" Formating a json file
com! Formatjson %!python -m json.tool
" Command for figuring out highlight group
map <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
" Faster saving
noremap <leader>w :update<CR>
" Faster quiting
noremap <leader>q :quit!<CR>
" Visually select pasted text
nnoremap gp `[v`]
" Yank withouth newline
nmap yY ^y$
" Window switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-]> <C-w><C-]>
nnoremap <C-w>t :tabnew<CR>
" allows incsearch highlighting for range commands
cnoremap <leader>t <CR>:t''<CR>
cnoremap <leader>T <CR>:t''<CR>ddkP
cnoremap <leader>m <CR>:m''<CR>
cnoremap <leader>M <CR>:m''<CR>ddkP
cnoremap <leader>d <CR>:d<CR>``
function! SaveSession()
  :mksession! CacheDir.'session.vim'
  :echo 'Session Saved!'
endfunction

function! RestoreSession()
  :source CacheDir.'session.vim'
endfunction
nnoremap <leader>ee :call SaveSession()<CR>
nnoremap <leader>er :call RestoreSession()<CR>
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" FileType Options
"-----------------------------------------------------------------------------------------------------------------------
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null " File ident on xml files
autocmd FileType html set tabstop=2|set shiftwidth=2
autocmd FileType htmljinja set tabstop=2|set shiftwidth=2
autocmd FileType python set tabstop=4|set shiftwidth=4
autocmd FileType php set tabstop=4|set shiftwidth=4 noexpandtab!
autocmd FileType sh set tabstop=4|set shiftwidth=4
autocmd FileType make set tabstop=4|set shiftwidth=4 noexpandtab
autocmd FileType haskell set tabstop=8|set shiftwidth=4|set softtabstop=4
au BufRead,BufNewFile *.twig set syntax=htmljinja
au BufRead,BufNewFile *.html set syntax=htmljinja
au BufNewFile,BufRead *.yml set filetype=yaml
au BufNewFile,BufRead *.sls set filetype=yaml
au BufNewFile,BufRead *.inc set filetype=php
au BufNewFile,BufRead *.module set filetype=php
au BufRead,BufNewFile *.ejs set syntax=htmljinja
au BufRead,BufNewFile *.md set filetype=markdown
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Color/Theming Options
"-----------------------------------------------------------------------------------------------------------------------
" Solarized cterm colors
" 0 = almost dark blue // 1 = red
" 2 = green            // 3 = yellow
" 4 = light blue       // 5 = pink
" 6 = cyan             // 7 = beige
" 8 = dark blue        // 9 = orange
" 10 = dark grey       // 11 = grey
" 12 = light grey      // 13 = purple
" 14 = grey            // 15 = white
" 16 = black
"
"Colorscheme
colorscheme gruvbox
" Vim diff Colors
highlight DiffAdd    cterm=BOLD ctermfg=NONE ctermbg=22
highlight DiffDelete cterm=BOLD ctermfg=NONE ctermbg=52
highlight DiffChange cterm=BOLD ctermfg=NONE ctermbg=23
highlight DiffText   cterm=BOLD ctermfg=NONE ctermbg=23
" Highligh current cursorline
hi CursorLineNR cterm=bold ctermfg=226
" Status line colors  per mode 
hi User1 ctermfg=226  ctermbg=8 cterm=bold
hi User3 ctermfg=4  ctermbg=0
hi User2 ctermfg=6  ctermbg=0
" Change gutter color
highlight SignColumn cterm=NONE ctermfg=0 ctermbg=8
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Nerdtree Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/nerdtree/plugin/NERD_tree.vim'))
    nnoremap <leader>n :NERDTreeTabsToggle<CR>
    nnoremap <leader>m :NERDTreeFind<CR>
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
" Emmet Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/emmet-vim/plugin/emmet.vim'))
  let g:use_emmet_complete_tag = 1
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Indent Lines Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/vim-indent-guides/plugin/indent_guides.vim'))
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
" Vdebug Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/vdebug/plugin/vdebug.vim'))
  let g:vdebug_options = {
  \    "watch_window_style" : 'compact',
  \    "port" : 9000,
  \    "path_maps" : {
  \         "/vagrant": "/Users/codyhiar/Sites",
  \         "/var/www/html": "/Users/hiarc/Sites/inv/redis-api",
  \         "/ask/sites/investopedia.com/web": "/src",
  \         "/ask/sites/inv-taxonomy-service": "/src",
  \     },
  \}
  "Delete all breakpoints
  :command! BR BreakpointRemove *
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Unite Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/unite.vim/plugin/unite.vim'))
  let g:unite_enable_start_insert = 1
  let g:unite_split_rule = "botright"
  let g:unite_force_overwrite_statusline = 0
  let g:unite_winheight = 10
  let g:unite_source_history_yank_enable = 1
  let g:unite_source_rec_max_cache_files=5000
  let g:unite_source_rec_async_command =
  \ ['ack', '-f', '--nofilter']
  " Check to see if the plugin is loaded before callinging
  if exists('g:loaded_unite')
      call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
            \ 'ignore_pattern', join([
            \ '\.git/',
            \ ], '\|'))
      call unite#filters#matcher_default#use(['matcher_fuzzy'])
      call unite#filters#sorter_default#use(['sorter_rank'])
  endif
  nnoremap <space>s :<C-u>Unite -buffer-name=buffer buffer -winheight=40<cr>
  nnoremap <space>y :<C-u>Unite -buffer-name=yank history/yank -quick-match -max-multi-lines=1 -winheight=40<cr>
  " Custom mappings for the unite buffer
  autocmd FileType unite call s:unite_settings()
  function! s:unite_settings()
    " Enable navigation with control-j and control-k in insert mode
    let b:SuperTabDisabled=1
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    imap <silent><buffer><expr> <C-x> unite#do_action('split')
    imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  endfunction
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" SuperTab Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/supertab/plugin/supertab.vim'))
  let g:SuperTabMappingForward = '<tab>'
  let g:SuperTabMappingBackward = '<s-tab>'
  let g:SuperTabLongestHighlight = 0
  let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Ultisnips
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/ultisnips/plugin/UltiSnips.vim'))
  let g:UltiSnipsEditSplit="vertical"
  let g:UltiSnipsListSnippets="<c-s>"
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-k>"
  let g:UltiSnipsJumpBackwardTrigger="<c-l>"
  :command! SNIPS tabnew ~/.config/nvim/plugged/vim-snippets/snippets
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Fugitive 
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/vim-fugitive/plugin/fugitive.vim'))
  nnoremap <leader>gc :Gcommit --verbose<CR>
  nnoremap <leader>gd :Gdiff<CR>
  nnoremap <leader>gl :Glog<CR>
  nnoremap <leader>gb :Gblame<CR>
  function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
      bd .git/index
    else
      Gstatus
    endif
  endfunction
  command ToggleGStatus :call ToggleGStatus()
  nnoremap <leader>gs :ToggleGStatus<CR>
  " Diff commands
  nnoremap <leader>du :diffupdate<CR>
  nnoremap <leader>dd :diffget<CR>
  nnoremap <leader>df :diffput<CR>
  nnoremap _ [c
  nnoremap = ]c
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Python-Syntax 
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/python-syntax/syntax/python.vim'))
  let python_highlight_all = 1
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" CtrlP Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/ctrlp.vim/plugin/ctrlp.vim'))
  let g:ctrlp_working_path_mode = 'a'
  let g:ctrlp_map = '<Space>p'
  let g:ctrlp_status_func = {
    \ 'main': 'CtrlP_main_status',
    \ 'prog': 'CtrlP_progress_status',
    \ }
  let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
  " Arguments: focus, byfname, s:regexp, prv, item, nxt, marked
  "            a:1    a:2      a:3       a:4  a:5   a:6  a:7
  fu! CtrlP_main_status(...)
    let regex = a:3 ? '%#CtrlP_Violet#regex %*' : ''
    let prv = '%#CtrlP_Purple# '.a:4.' %*'
    let item = '%#CtrlP_IPurple# '.a:5.' %*'
    let nxt = '%#CtrlP_Purple# '.a:6.' %*'
    let byfname = '%#CtrlP_Violet# '.a:2.' %*'
    let dir = '%#CtrlP_Purple# '.fnamemodify(getcwd(), ':~').' %*'
    retu prv . item . nxt . '%#CtrlP_Violet#%=%*%<' . byfname . regex . dir
  endf
  fu! CtrlP_progress_status(...)
    let len = '%#Function# '.a:1.' %*'
    let dir = ' %=%<%#LineNr# '.getcwd().' %*'
    retu len.dir
  endf
  hi CtrlP_Purple  ctermfg=7 ctermbg=4
  hi CtrlP_IPurple ctermfg=4  ctermbg=7
  hi CtrlP_Violet  ctermfg=7  ctermbg=8
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Markdown
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/vim-markdown/indent/markdown.vim'))
  let g:vim_markdown_folding_disabled=1
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Dev-icons
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/vim-devicons/plugin/webdevicons.vim'))
  let g:webdevicons_enable_nerdtree = 1
  let g:webdevicons_enable = 1
  let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:DevIconsEnableFoldersOpenClose = 1
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Dash
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/dash.vim/plugin/dash.vim'))
  nnoremap K :Dash<CR>
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Deoplete
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/deoplete.nvim/plugin/deoplete.vim'))
  let g:deoplete#enable_at_startup = 1
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" CamelCaseMotion
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/CamelCaseMotion/plugin/camelcasemotion.vim'))
  map <silent> ,w <Plug>CamelCaseMotion_w
  map <silent> ,e <Plug>CamelCaseMotion_e
  map <silent> ,b <Plug>CamelCaseMotion_b
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Vim JSON
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/vim-json/indent/json.vim'))
  let g:vim_json_syntax_conceal = 0
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Ack Searching
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/ack.vim/plugin/ack.vim'))
  nnoremap <space>/ :call AckSearch()<CR>
  function! AckSearch()
    call inputsave()
    let term = input('Search: ')
    call inputrestore()
    if !empty(term)
        execute "Ack '" . term . "'"
    endif
  endfunction
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Syntastic
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/syntastic/plugin/syntastic.vim'))
  let g:syntastic_php_checkers = ['php', 'phpcs']
  let g:syntastic_php_phpcs_args = "--standard=".$HOME."/PEARish.xml,PSR2,Symfony2"
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 1
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
    endif
  endfunction
  nnoremap <leader>s :call ToggleSyntasticMode()<CR>
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Toggle List
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/vim-togglelist/plugin/togglelist.vim'))
  noremap <leader>[ :lprevious<CR>
  noremap <leader>] :lnext<CR>
  noremap <leader>p :ll<CR>
  " Disable the mapping it overwrites leader q
  let g:toggle_list_no_mappings = 1
  nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" SimplyFold
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/SimpylFold/ftplugin/python/SimpylFold.vim'))
  let g:SimpylFold_docstring_preview = 1
  " Needed for some issues
  autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
  autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
  nnoremap <space>a za
endif
"-----------------------------------------------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------------------------------------------
" Ledger
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/SimpylFold/ftplugin/python/SimpylFold.vim'))
  au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
endif
"-----------------------------------------------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------------------------------------------
" Taboo
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob(EditorDir.'plugged/taboo.vim/plugin/taboo.vim'))
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

" Call this function to enable God Mode
"DisableNonCountedBasicMotions
