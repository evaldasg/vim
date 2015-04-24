" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible
set t_Co=256
" colorscheme Tomorrow-Night-Eighties
colorscheme base16-solarized
" set background=light
let base16colorspace=256  " Access colors present in 256 colorspace

" Leader
let mapleader = ","

let g:localvimrc_ask = 0

set backspace=2   " Backspace deletes like most programs in insert mode

set notimeout
set ttimeout
set timeoutlen=100
set updatetime=1000

set directory=~/.vim/swp//
set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//

set undofile
set noswapfile    		" http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=256          	" Store lots of :cmdline history
set ruler         		" show the cursor position all the time
set showmatch  			" Show matching brackets.
set showcmd       		" display incomplete commands
set incsearch     		" do incremental searching
set laststatus=2  		" Always display the status line
set autowrite     		" Automatically :write before running commands
set hidden              	" Buffers can exist in the background
set completeopt=longest,menuone
set laststatus=2 		" Always show status line.
set number
set numberwidth=3
set noacd			" Automatically change the current working directory to the parent of whatever file is currently active in Eclipse
set showcmd             	" Show incomplete cmds down the bottom
set tabstop=2 			" Tabs are 2 spaces
set shiftwidth=2 		" Tabs under smart indent
set expandtab

set noea
" Set this to the name of your terminal that supports mouse codes.
" Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
set ttymouse=xterm2
" gvim specific
set mousehide  " Hide mouse after chars type
set ttyfast " Send more characters for redraws
set mouse=a " Enable mouse use in all modes

set wildignore=*.png,*.jpg,*.xcf,*.wav,log/*,tmp/*,coverage/*
set clipboard=autoselect,unnamed " Enable autoselect clipboard

set pastetoggle=<F2>

set path+=./lib,./spec
set swb=useopen
set tags+=tags;/,./gems.tags;/,gems.tags;/

" Search Settings
" ===============
set incsearch        " Find the next match as we type the search
set hlsearch         " Hilight searches by default
set viminfo='100,f1  " Save up to 100 marks, enable capital marks
set ignorecase       " (ic) ignores case in search patterns

noremap ; :
noremap Y y$
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

" Quicker window movement
" =======================
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" ctrlp settings
nmap <Leader>o :CtrlP<CR>
let g:ctrlp_use_caching = 0
let g:ctrlp_custom_ignore = { 'dir': '\v(tmp|coverage)$' }
let g:ctrlp_reuse_window = 'NERD'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<cr>', '<c-y>', '<2-LeftMouse>'],
    \ 'CreateNewFile()':      []
    \ }

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" CoffeeScript settings
au FileType coffee setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript nnoremap <leader>d odebugger;<esc>:w<CR>
autocmd FileType coffeescript nnoremap <leader>d odebugger<esc>:w<CR>

" Ruby settings
au BufRead,BufNewFile Guardfile,Gemfile.personal,Vagrantfile,*.arb,*.cr set ft=ruby
autocmd FileType ruby,eruby,scss,css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType ruby nnoremap <leader>d obinding.pry<esc>:w<CR>

" JST settings
autocmd FileType jst setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" " YAML settings
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" NERDTREE settings
map <leader>n :e %:p:h<CR>

" Autoformat json file. Requires `sudo cpan JSON::XS`
map <leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
" nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
" nnoremap <Leader>s :call RunNearestSpec()<CR>
" nnoremap <Leader>l :call RunLastSpec()<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Tab completion
" ==============
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Remove empty lines
" ==================
function TrimEndLines()
  let save_cursor = getpos(".")
  :silent! %s#\($\n\s*\)\+\%$##
  call setpos('.', save_cursor)
endfunction

au BufWritePre * call TrimEndLines()

" Highlight all instances of word under cursor, when idle.
" ========================================================
" Useful when studying strange source code.
" Type <leader>h to toggle highlighting on/off.
nnoremap <leader>h :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: OFF'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction
