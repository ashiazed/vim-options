"-----------------------------------------------------------------------------------------------------------------------
" Nerdtree Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/nerdtree/plugin/NERD_tree.vim'))
    let NERDTreeShowLineNumbers=1
    nnoremap <leader>n :NERDTreeTabsToggle<CR>
    nnoremap <leader>m :NERDTreeFind<CR>
    let NERDTreeDirArrows=0
    let NERDTreeMapOpenSplit = 's'
    let NERDTreeMapOpenVSplit = 'v'
    let NERDTreeWinSize = 40
    let NERDTreeIgnore = ['\.pyc$']
    let g:NERDTreeDirArrows = 1
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
endif


"-----------------------------------------------------------------------------------------------------------------------
" Emmet Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/emmet-vim/plugin/emmet.vim'))
  let g:use_emmet_complete_tag = 1
endif


"-----------------------------------------------------------------------------------------------------------------------
" Indent Lines Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/vim-indent-guides/plugin/indent_guides.vim'))
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_auto_colors = 0
  let g:indent_guides_exclude_filetypes =['help', 'nerdtree']
  let g:indent_guides_start_level = 2
  let g:indent_guides_guide_size = 1
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=0
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=0
endif


"-----------------------------------------------------------------------------------------------------------------------
" Vdebug Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/vdebug/plugin/vdebug.vim'))
  let g:vdebug_options = {
  \    "watch_window_style" : 'compact',
  \    "port" : 9000,
  \    "path_maps" : {
  \         "/vagrant": "/Users/codyhiar/Sites",
  \         "/var/www/html": "/Users/hiarc/Sites/inv/redis-api",
  \         "/ask/sites/investopedia.com/web": "/Users/hiarc/Sites/inv/www",
  \     },
  \}
  "Delete all breakpoints
  :command! BR BreakpointRemove *
endif
"-----------------------------------------------------------------------------------------------------------------------


"-----------------------------------------------------------------------------------------------------------------------
" Unite Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/unite.vim/plugin/unite.vim'))
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
if !empty(glob('plugged/supertab/plugin/supertab.vim'))
  let g:SuperTabMappingForward = '<tab>'
  let g:SuperTabMappingBackward = '<s-tab>'
  let g:SuperTabLongestHighlight = 0
  let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
endif
"-----------------------------------------------------------------------------------------------------------------------



"-----------------------------------------------------------------------------------------------------------------------
" Ultisnips
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/ultisnips/plugin/UltiSnips.vim'))
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
if !empty(glob('plugged/vim-fugitive/plugin/fugitive.vim'))
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
  nnoremap - [c
  nnoremap = ]c
endif

"-----------------------------------------------------------------------------------------------------------------------
" Python-Syntax 
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/python-syntax/syntax/python.vim'))
  let python_highlight_all = 1
endif



"-----------------------------------------------------------------------------------------------------------------------
" CtrlP Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/ctrlp.vim/plugin/ctrlp.vim'))
  let g:ctrlp_working_path_mode = 'a'
  let g:ctrlp_by_filename = 1
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
  hi CtrlP_Violet  ctermfg=4  ctermbg=8
endif

"-----------------------------------------------------------------------------------------------------------------------
" Flake8 Plugin
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/vim-flake8/autoload/flake8.vim'))
  autocmd FileType python map <buffer> <F9> :call Flake8()<CR>
  let g:flake8_show_in_gutter=1 
  autocmd BufWritePost *.py call Flake8()
endif


"-----------------------------------------------------------------------------------------------------------------------
" Markdown
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/vim-markdown/indent/markdown.vim'))
  let g:vim_markdown_folding_disabled=1
endif



"-----------------------------------------------------------------------------------------------------------------------
" Dev-icons
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/vim-devicons/plugin/webdevicons.vim'))
  let g:webdevicons_enable_nerdtree = 1
  let g:webdevicons_enable = 1
  let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  let g:DevIconsEnableFoldersOpenClose = 1
endif



"-----------------------------------------------------------------------------------------------------------------------
" Dash
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/dash.vim/plugin/dash.vim'))
  nnoremap K :Dash<CR>
endif



"-----------------------------------------------------------------------------------------------------------------------
" Deoplete
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/deoplete.nvim/plugin/deoplete.vim'))
  let g:deoplete#enable_at_startup = 1
endif


"-----------------------------------------------------------------------------------------------------------------------
" Neomake
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/neomake/plugin/neomake.vim'))
  autocmd! BufWritePost * Neomake
  let g:neomake_javascript_enabled_makers = ['eslint']
  "let g:neomake_verbose = 3
  "let g:neomake_open_list = 1
  let g:neomake_javascript_eslint_maker = {
      \ 'args': ['--no-color', '--format', 'compact', '--config', '~/.eslintrc.json'],
      \ 'errorformat': '%f: line %l\, col %c\, %m'
      \ }
endif



"-----------------------------------------------------------------------------------------------------------------------
" CamelCaseMotion
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/CamelCaseMotion/plugin/camelcasemotion.vim'))
  map <silent> ,w <Plug>CamelCaseMotion_w
  map <silent> ,e <Plug>CamelCaseMotion_e
  map <silent> ,b <Plug>CamelCaseMotion_b
endif



"-----------------------------------------------------------------------------------------------------------------------
" Vim JSON
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/vim-json/indent/json.vim'))
  let g:vim_json_syntax_conceal = 0
endif



"-----------------------------------------------------------------------------------------------------------------------
" Ack Searching
"-----------------------------------------------------------------------------------------------------------------------
if !empty(glob('plugged/ack.vim/plugin/ack.vim'))
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
