"COMMON -----
set background=light

"tab setting
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent

"FILE -----
set autoread
set hidden
set noswapfile
set nobackup

syntax on

set cursorline
set number
set incsearch
set clipboard+=unnamed

set completeopt=longest,menuone,preview

map <C-S-l> gt
map <C-S-h> gT

imap <C-j> <esc>

"PLUGIN SET UP
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" file open
NeoBundle 'Shougo/unite.vim'
" file open etc
NeoBundle 'Shougo/neomru.vim'
" dir tree view
NeoBundle 'scrooloose/nerdtree'
" for git 
NeoBundle 'tpope/vim-fugitive'
" for rails
NeoBundle 'tpope/vim-rails'
" for ruby end
NeoBundle 'tpope/vim-endwise'
" make tags file
NeoBundle 'szw/vim-tags'
" for coffee script
NeoBundle 'kchmck/vim-coffee-script'
" for scala
NeoBundle 'derekwyatt/vim-scala'
" for markdown
NeoBundle 'plasticboy/vim-markdown'
" for preview
NeoBundle 'kannokanno/previm'
" for browser
NeoBundle 'tyru/open-browser.vim'
" for Eclim
NeoBundle 'ervandew/eclim', {'build': {'mac': 'ant -Declipse.home=/opt/homebrew-cask/Caskroom/eclipse-java/4.4.2/eclipse -Dvim.files='.escape(expand('~/.vim/bundle/eclim'), '')}}
" for tcomment_vim
NeoBundle 'tomtom/tcomment_vim'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

"Unit.vim setting
let g:unit_enable_insert=1

"buffer list
noremap <C-p> :Unite buffer<CR>
"file list
noremap <C-n> :Unite -buffer-name=file file<CR>
"file menu
noremap <C-z> :Unite file_mru<CR>

"NERDTree setting
nnoremap <silent><C-e> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1
autocmd VimEnter * execute 'NERDTree'

"fugitive setting
autocmd QuickFIxCmdPost *grep* cwindow

set statusline+=%{fugitive#statusline()}

"vim-tags setting
let g:vim_tags_project_tags_command = "/usr/local/bin/ctags --langmap=RUBY:.rb --exclude='*.js' --exclude='.git*' -f ~/.tags -R `pwd` 2>/dev/null"
let g:vim_tags_gems_tags_command = "/usr/local/bin/ctags --langmap=RUBY:.rb --exclude='*.js' --exclude='.git*' -f ~/.Gemfile.lock.tags -R `bundle show --paths` 2>/dev/null"

"vim-coffee-script
au BufRead,BufNewFile,BufReadPre *.coffee  set filetype=coffee
autocmd FileType coffee  setlocal sw=4 sts=4 ts=4

"markdwon setting
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a Firefox'

"preview 
noremap po :PrevimOpen<CR>

"eclim
autocmd FileType java nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
autocmd FileType java nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
autocmd FileType java nnoremap <silent> <buffer> <C-H> :JavaSearchContext<cr>
let g:EclimCompletionMethod = 'omnifunc'

set tags+=$HOME/.tags
set tags+=$HOME/.Gemfile.lock.tags
