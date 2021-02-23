syntax on
filetype indent on

set encoding=UTF-8
set guifont=Hurmit_Nerd_Font:h11

set nobackup
set nowritebackup
set cmdheight
set updatetime=300
set nu
set title
set showmatch
set foldenable
set autoindent smartindent
set ts=2	
set expandtab
set shiftwidth=2
set noswapfile
" set foldmethod=expr
" set foldexpr=getline(v:lnum)[0]==\"\\t\"
set foldmethod=indent
set autowrite

" use system clipboard
set clipboard=unnamedplus

set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 

let mapleader=';'

" capital W is also w
nnoremap :W :w

" use ;; for escape
" http://vim.wikia.com/wiki/Avoid_the_escape_key
inoremap ;; <Esc>

"TODO : change all folder paths 
"
" ;ec Edit Config
nnoremap <silent> <leader>ec :tabnew ~/.config/nvim/init.vim<CR> 

nnoremap <leader>vs :silent exec "!open 1://file/" . expand("%:p") . ":" . line(".") . ":" . col(".")<cr>:redraw!<cr>

" terminal
nmap <leader>T :sp<bar>term<cr><c-w>J:resize10<cr>
tnoremap <Esc> <C-\><C-n>

"TODO : change all folder paths 
function! SaveConfig()
  let b:path=$HOME . '/.config/nvim/'
  let b:vimrc=$HOME . '/.config/nvim/init.vim'
  let b:mirrorpath=$HOME . '/Eine/vimrc-not-s/'
  " if expand('%:p') == $HOME . '/.config/nvim/init.vim'
  echom b:path
  echom expand(':p')
  if expand('%:p') == b:vimrc
    echom 'here'
    " source % <CR>
    w! /Users/lety02/Eine/vimrc-not-s/init.vim
    execute "!grep map " . b:vimrc . " > " . b:mirrorpath . "key.txt"
    echom '::::::save done::::::'
    let b:timenow=strftime("%c")
    echom b:timenow 
    !git -C /Users/lety02/Eine/vimrc-not-s/ add .
    !git -C /Users/lety02/Eine/vimrc-not-s/ commit -m "$(date)"
    !git -C /Users/lety02/Eine/vimrc-not-s/ push
    echom '::::::git done::::::'
  else
    echom '=====THIS IS NOT VIM CONFIG FILE====='
  endif
endfunction

" ;sc Save Config(mandatory, not optional)
nnoremap <silent> <leader>sc :source %<CR>:call SaveConfig()<CR>

" need vim-plug
call plug#begin('~/.vim/plugged')

 " gc[c] for toggle comment
Plug 'tpope/vim-commentary' 

" insert, delete, change
" ysiw, ds, cs
Plug 'tpope/vim-surround'

" git
Plug 'tpope/vim-fugitive'

" interface
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

Plug 'ctrlpvim/ctrlp.vim'

" test
Plug 'vim-test/vim-test'

" async
Plug 'skywind3000/asyncrun.vim'

" dart plugins
" https://vimawesome.com/plugin/dart-vim-plugin
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
" replaced by coc-flutter
" Plug 'natebosch/vim-lsc'
" Plug 'natebosch/vim-lsc-dart'

Plug 'beeender/Comrade'

" go plugins
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go'}
Plug 'andrewradev/splitjoin.vim'

" for svelte
Plug 'evanleck/vim-svelte', {'branch': 'main', 
      \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
" post install (yarn install | npm install) then load plugin only for editing supported files
" Plug 'prettier/vim-prettier', { 'do': 'yarn install',
"   \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'svelte'] }

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/seoul256.vim'

Plug 'ryanoasis/vim-devicons'
call plug#end()

"""tab config
" tn for NewTab
nnoremap tn :tabnew<CR>
" tt for nexTTab
nnoremap tt :tabnext<CR>
" tc for CloseTab
nnoremap tc :tabclose<CR>

" clear search-highlights using `<C-l>`
nnoremap <C-l> :nohlsearch<CR>	   
								
" nerdtree config
" tagbar config
" let NERDTreeWinPos = 'left'
" let g:tagbar_position = 'rightbelow'
" nnoremap nt :NERDTreeToggle<CR>:TagbarToggle<CR>
nnoremap nt :NERDTreeToggle<CR>
nnoremap tb :TagbarToggle<CR>

let g:NERDTreeShowLineNumbers=1
let g:NERDTreeHighlightCursorline=1

" ===== NERDCommenter settings =====
"
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCustomDelimiters = { 'html': { 'left': '' } }

" Align comment delimiters to the left instead of following code indentation
let g:NERDDefaultAlign = 'left'

fu! NERDCommenter_before()
  if (&ft == 'html') || (&ft == 'svelte')
    let g:ft = &ft
    let cfts = context_filetype#get_filetypes()
    if len(cfts) > 0
      if cfts[0] == 'svelte'
        let cft = 'html'
      elseif cfts[0] == 'scss'
        let cft = 'css'
      else
        let cft = cfts[0]
      endif
      exe 'setf ' . cft
    endif
  endif
endfu

fu! NERDCommenter_after()
  if (g:ft == 'html') || (g:ft == 'svelte')
    exec 'setf ' . g:ft
    let g:ft = ''
  endif
endfu


" === colorize ===
let g:lightline={
  \'colorscheme': 'seoul256'
  \}
let g:seoul256_background=233 " ~ 255(lightest)
colo seoul256

hi Quote ctermbg=109 guifg=#83a598

" test
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = 'asyncrun_background_term'
" let test#strategy = "neovim"

" let test#neovim#term_position = "belowright"
" let test#neovim#term_position = "vert"
let test#neovim#term_position = "bo 10"

" how to get out (C-o)
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

" ======= dart-vim config =======
" Enable HTML syntax highlighting
let dart_html_in_string=v:true
let g:dart_style_guide=2
let g:dart_format_on_save=1

nnoremap df :DartFmt<cr>

let g:lsc_auto_map = v:true

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

""" ===== flutter ===== 

" run / pub get / devices / 
autocmd FileType dart nnoremap <leader>r :CocCommand flutter.run<CR>
      " \ :CocCommand flutter.dev.openDevLog<CR>
autocmd FileType dart nnoremap <leader>g :CocCommand flutter.pub.get<CR>
autocmd FileType dart nnoremap <leader>d :CocCommand flutter.devices<CR>

" hotReload / openDevLog
autocmd FileType dart nnoremap <leader>fr :CocCommand flutter.dev.hotReload<CR>
autocmd FileType dart nnoremap <leader>fR :CocCommand flutter.dev.hotRestart<CR>
autocmd FileType dart nnoremap <leader>l :CocCommand flutter.dev.openDevLog<CR>
autocmd FileType dart nnoremap <leader>q :CocCommand flutter.dev.quit<CR>

" dart devtools
autocmd FileType dart nnoremap <leader>fT :CocCommand flutter.dev.openProfiler<CR>

"Emulator Android
" autocmd FileType dart nnoremap <leader>Ea 

" toggle outline
autocmd FileType dart nnoremap ol :CocCommand flutter.toggleOutline<CR>

command! -nargs=1 Nf call s:BlocStart(<q-args>)<CR>

" == flutter bloc == 
" make bloc files
function! s:BlocStart(name)
  " current file 
  let dir = expand('%:h')
  echom a:name
  echom dir
  execute "e ". dir . '/'. a:name .'_bloc'
  execute "e ". dir . '/'. a:name .'_event'
  execute "e ". dir . '/'. a:name .'_state'
endfunction

" ===== coc config ===== 
" complete by enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
                                          \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" move next by tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" coc snippet config Edit Snippet
nnoremap <silent> <leader>es :split<CR>:CocCommand snippets.editSnippets<CR>

hi! CocErrorSign guifg=#d1666a

""" ===== go =====
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 

let g:go_test_timeout = '10s'

autocmd FileType go nmap <leader>r :GoRun<CR>
" autocmd FileType go nnoremap gb :GoBuild<CR>
"
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  else
    echom "this is not go file"
  endif
endfunction

" build or test
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
" test this function
autocmd FileType go nmap <leader>t :GoTestFunc<CR>
" :GoPlay
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>cb <Plug>(go-coverage-browser)
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
autocmd FileType go nmap <leader>d :GoDecls<CR>
autocmd FileType go nmap <leader>dd :GoDeclsDir<CR>
autocmd FileType go nmap <leader>fv :'<,'>GoFreevars<CR>
" :GoRename []
" :GoImpl

let g:go_auto_type_info = 1
" let g:go_auto_sameids = 1

" https://github.com/fatih/vim-go/issues/2923
let g:go_gpls_enabled=0
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0
let g:go_def_mode = 'godef'
" :GoDecls :GoDeclsDir
let g:go_decls_includes = "func,type"
" let g:go_decls_includes = "func"


" WARNING: maybe slow in very large codebases
let g:go_fmt_command = "goimports"
" let g:go_fmt_fail_silently = 1
" let g:go_addtags_transform = "camelcase"
" let g:go_textobj_include_function_doc = 0

" By default it'll run go vet, golint and errcheck concurrently. gometalinter collects all the outputs and normalizes it to a common format.
"
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_command='gopls'
let g:go_gopls_staticcheck=1
let g:go_metalinter_deadline = "5s"

let g:go_rename_command='gopls'

" C-j to jump in snippet result
" errp, fn, ff, ln, lf

" splitjoin
" gS to split
" gJ to join
" Use ctrl-] or gd to jump to a definition, locally or globally
" Use ctrl-t to jump back to the previous location
" ]] -> jump to next function
" [[ -> jump to previous function

" highlighting for go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

"quickfix 
let g:go_list_type = "quickfix"

"jump between errors
autocmd FileType go nnoremap cj :cnext<CR>
autocmd FileType go nnoremap ck :cprevious<CR>
"quit
autocmd FileType go nnoremap cq :cclose<CR>

" ====== svelte ======

" Prettier Settings
" let g:prettier#quickfix_enabled = 0
" let g:prettier#autoformat_require_pragma = 0
" au BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json PrettierAsync

nmap <leader>ff <Plug>(coc-format-selected)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('')
  else
    call CocAction('doHover')
 endif
endfunction

" devicon
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_ctrlp = 1
