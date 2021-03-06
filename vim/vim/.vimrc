let g:author   = "wangkun"
let g:email    = "wangkun@playcrab.com"
" 自动重新加载vimrc，修改后

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set nobackup   " do not keep a backup file, use versions instead
set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch  " do incremental searching
set autoindent " always set autoindenting on

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" add by Wangkun.
let mapleader = ';'
" pathogen启用
execute pathogen#infect()
" 如果打开的窗口只剩nerdtree 则关闭vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" nerdtree 开关
map <F2> :NERDTreeToggle<CR>
" z健用来切换窗口
nmap w <C-w><C-w><C-w>_
" 左边数字栏开关//能不能一键切换？
nnoremap <F3> :NumbersToggle<CR>

" encoding
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,cp936,gb18030,big5,euc-cn,euc-jp,euc-kr,latin1
set termencoding=utf-8
" set fileencoding of new file to utf-8
setglobal fenc=utf-8
" <TAB> 自动转换为4个空格
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

syntax enable
set background=dark
colorscheme solarized
let g:solarized_termcolors=256


" tag bar 配置
nmap <F4> :TagbarToggle<CR>

" vim-over 全局替换预览; 进入预览模式
nmap <F10> :OverCommandLine<CR>

" vim-markdown 语法高亮等
let g:vim_markdown_folding_disabled=1
"let g:vim_markdown_initial_foldlevel=1
"key mapping
"]]: go to next header
"[[: go to previous header
"][: go to next sibling header if any
"[]: go to previous sibling header if any
"]c: go to Current header
"]u: go to parent header (Up)

" Tabularize 配置，对齐文本
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>    "等号对齐
nmap <Leader>a: :Tabularize /:\zs<CR> "冒号后面的空格对齐
vmap <Leader>a: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>

" 左边的缩进指示
nmap <F5> :IndentGuidesToggle<CR>
let g:indent_guides_guide_size  = 1
let g:indent_guides_start_level = 2

"tab的快捷键，gt gT切换tab
nmap nt :tabnew %:h<CR>
nmap <SPACE> gT

"restore view 自动记录上次光标，折叠等
set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\.vim']


"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'


" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.

"let g:neocomplcache_dictionary_filetype_lists = {
    "\ 'default' : '',
    "\ 'vimshell' : $HOME.'/.vimshell_hist',
    "\ 'scheme' : $HOME.'/.gosh_completions'
        "\ }

" Define keyword"
"if !exists('g:neocomplcache_keyword_patterns')
    "let g:neocomplcache_keyword_patterns = {}
"endif
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
  "return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"endfunction
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
"if !exists('g:neocomplcache_omni_patterns')
  "let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
"let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" Plugin key-mappings.
"imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:neosnippet#enable_snipmate_compatibility = 1

let g:tmuxline_preset           = 'tmux'
let g:airline_left_sep          = '▶'
let g:airline_right_sep         = '◀'
let g:airline_detect_modified   = 1
let g:airline_detect_paste      = 1
let g:airline_inactive_collapse = 1
let g:airline_section_b         = "%m%r%h%y"
let g:airline_section_gutter    = ""
let g:airline_section_warning   = "%{getcwd()}"

set laststatus=2 "总是显示状态栏"
"let g:bufferline_echo = 0
set pastetoggle=<F6>
