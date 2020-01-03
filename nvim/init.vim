set encoding=utf-8
set termencoding=utf-8
scriptencoding utf-8

set shell=/bin/sh

let mapleader="\<space>"            " set <space> as the leader for mappings
nnoremap <space> <nop>
let maplocalleader = "\\"           " set `\` as the local leader for mappings
                                    "
                                    " local leader mappings should only be set
                                    " in ftplugin files

set mouse=a                         " mouse in Normal, Visual, Insert, Command
                                    " and Help mode

set nowrap                          " don't wrap long lines

set scrolloff=3                     " keep 3 lines visible above/below the
                                    " cursor when scrolling

set sidescrolloff=7                 " keep 7 characters visible to the
                                    " left/right of the cursor when scrolling

set sidescroll=1                    " scroll left/right one character at a
" time

set nojoinspaces                    " insert 1 space after joining `.?!`

set hidden                          " allow unsaved buffers to be hidden

set splitright                      " set default split behavior
set splitbelow                      " .

set undofile                        " persistent undo per file

set nohlsearch                      " search tweaks
set incsearch                       " .
set ignorecase                      " .
set smartcase                       " .
set nowrapscan                      " TODO: experiment

set timeoutlen=700                  " reduced sequence input timeout
set updatetime=300                  " reduced timeout before CursorHold
                                    " autocmd

set wildmenu                        " improved command-line completion
set wildmode=list:longest           " .
set wildignore+=vendor              " .
set wildignore+=*/tmp/*             " .
set wildignore+=*/target/*          " .

                                    " `formatoptions` can be overwritten by
                                    " ftplugin files and may need to be
                                    " duplicated in `after/ftplugin/<ft>.vim
                                    "
set formatoptions=tc                " wrap text and comments using textwidth
set formatoptions+=r                " continue comments on ENTER in I mode
set formatoptions+=q                " enable formatting of comments with gq
set formatoptions+=n                " detect lists for formatting
set formatoptions+=b                " wrap in I mode, don't wrap old lines
set formatoptions+=j                " remove comment leader when joining lines
set formatoptions-=o                " don't insert comment char on 'o' or 'O'

if has('nvim')                      " only works in neovim
    set inccommand=split            " show substitutions incrementally
endif

set diffopt+=iwhite                 " ignore whitespace in vimdiff
set diffopt+=algorithm:patience     " use better diff algorithm
set diffopt+=indent-heuristic       " more aesthetically pleasing diffs

set smartindent                     " c-like smart indentation
set tabstop=4                       " tab = 4 spaces
set expandtab                       " convert tabs to spaces
set shiftround                      " always round to nearest indent
set shiftwidth=4                    " number of spaces per indent

let g:sh_no_error=1                 " disable default vim sh linting

set cmdheight=2                     " better cmd details visibility

set termguicolors                   " true colors

set number                          " enable line numbers
set relativenumber                  " relative line numbers

set noshowmode                      " don't show mode (INSERT, etc) in cmd

set signcolumn=yes:2                " always show 2 "s ign" columns for linters

set list                            " show unwanted hidden characters
set listchars=nbsp:¬                " .
set listchars+=extends:»            " .
set listchars+=precedes:«           " .
set listchars+=trail:·              " .
set listchars+=tab:\ \              " don't show ^I for tabs

set synmaxcol=1000                  " reduce maximum colored columns

set shortmess+=a                    " short message formats
set shortmess+=c                    " no "match 1 of 2" messages
set shortmess+=W                    " no "written" when saving
set shortmess+=I                    " no intro message on startup
set shortmess+=F                    " no filename info on open file

" Cursor shapes: normal=block, insert=pipe, replace=underscore
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" Disable initial folds when opening file
set nofoldenable

" Use ripgrep for searching
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

call plug#begin()
Plug 'gruvbox-community/gruvbox'
call plug#end()

colorscheme gruvbox
