syntax on
filetype indent on

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

set autowrite

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

function! SaveConfig()
  if expand('%:p') == $HOME . '/.config/nvim/init.vim'
    echom expand('%:p')
    echom 'here'
    " source % <CR>
    w! /Users/lety02/Eine/vimrc-not-s/init.vim
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

" ysiw, ds
Plug 'tpope/vim-surround'

" interface
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
" Plug 'vim-airline/vim-airline'

Plug 'ctrlpvim/ctrlp.vim'

" dart plugine
" https://vimawesome.com/plugin/dart-vim-plugin
Plug 'dart-lang/dart-vim-plugin'
" replaced by coc-flutter
" Plug 'natebosch/vim-lsc'
" Plug 'natebosch/vim-lsc-dart'

" go plugins
Plug 'fatih/vim-go'
Plug 'andrewradev/splitjoin.vim'

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/seoul256.vim'

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

" ===colorize===
let g:lightline={
  \'colorscheme': 'seoul256'
  \}
let g:seoul256_background=233 " ~ 255(lightest)
colo seoul256

" ======= dart-vim config =======
" Enable HTML syntax highlighting
let dart_html_in_string=v:true
let g:dart_style_guide=2
let g:dart_format_on_save=1

nnoremap df :DartFmt<cr>

"lsc settingsc settingsc settingsc settings
let g:lsc_auto_map = v:true
" 'GoToDefinition': <C-]>,
" 'GoToDefinitionSplit': [<C-W>], <C-W><C-]>],
" 'FindReferences': gr,
" 'NextReference': <C-n>,
" 'PreviousReference': <C-p>,
" 'FindImplementations': gI,
" 'FindCodeActions': ga,
" 'Rename': gR,
" 'DocumentSymbol': go,
" 'WorkspaceSymbol': gS,
" 'SignatureHelp': gm,

""" ===== flutter ===== 
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

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
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1


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
