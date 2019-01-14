:echo ">^.^<"

:set number
:set hlsearch
:set incsearch

let mapleader = " "

" move this file to a new tab group through vertical splitting
:nnoremap <leader>v :vsplit<CR><C-w>hZZ

" edit and source vimrc
:nnoremap <leader>ev :tabnew ~/_vimrc<CR>
:nnoremap <leader>sv :so ~/_vimrc<CR>

" insert enter before or after line
:nnoremap [<Space> O<Esc>
:nnoremap ]<Space> o<Esc>

" insert enter before cursor
:nnoremap <S-CR> i<CR><Esc>l

" go shortcuts
:nnoremap gi :vsc Edit.GoToImplementation<CR>
:nnoremap gr :vsc Edit.FindAllReferences<CR>
:nnoremap gw <C-w>w
:nnoremap gcc :vsc Edit.ToggleComment<CR>
:vnoremap gc :vsc Edit.ToggleComment<CR><Esc><Esc>

" manually mapping tab traversal because it doesn't work with vs2019 yet
:nnoremap gt :vsc Window.NextTab<CR>
:nnoremap gT :vsc Window.PreviousTab<CR>

" clear and edit line at indentation
:nnoremap cc ^C

" remove highlights
:nnoremap <leader>rh :noh<CR>

" move lines accomplished through AHK <A-jkhl> <A-arrow>

" arrow keys can be used through AHK <^+-jkhl> <arrow>, particularly useful for navigating vs2017's test explorer