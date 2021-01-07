colorscheme industry
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

set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1 

let mapleader=';'

" use ;; for escape
" http://vim.wikia.com/wiki/Avoid_the_escape_key
inoremap ;; <Esc>

" ;ec Edit Config
nnoremap <silent> <leader>ec :e ~/.config/nvim/init.vim<CR> 

"TODO : change the folder
function! SaveConfig()
  " source % <CR>
  w! /Users/lety02/Eine/vimrc-not-s/init.vim
  echom '::::::save done::::::'
  let timenow=strftime("%c")
  echo timenow 
  !git -C /Users/lety02/Eine/vimrc-not-s/ add .
  !git -C /Users/lety02/Eine/vimrc-not-s/ commit -m timenow
  !git -C /Users/lety02/Eine/vimrc-not-s/ push master origin
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
Plug 'vim-airline/vim-airline'

" https://vimawesome.com/plugin/dart-vim-plugin
Plug 'dart-lang/dart-vim-plugin'
Plug 'natebosch/vim-lsc'
Plug 'natebosch/vim-lsc-dart'

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

