runtime colors/gruvbox.vim
hi Normal ctermbg=NONE

" color scheme settings
let g:gruvbox_italic=1
let g:gruvbox_italicize_comments = 0
let g:gruvbox_undercurl = 0
let g:gruvbox_number_column = 'bg0'
let g:gruvbox_improved_warnings = 1

" switch command-line error from bright red bg to no bg and white text
hi! ErrorMsg guifg=#fbf1c7 guibg=#fb4934, gui=NONE

" hide the `~` characters after EOF
hi! EndOfBuffer guifg=#282828

" hide the background of the first column (sign column)
hi! SignColumn guibg=#282828 guifg=#282828

" hide the background of the cursor line number column and make the integer
" white
hi! CursorLineNr guibg=#282828 guifg=#83a598
