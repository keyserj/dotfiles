:echo ">^.^<"

let mapleader = " "

"turn line numbers off so Relative Number extension can do its thing
:set nonumber

:nnoremap <leader>v :vsplit<CR>

"reload _vimrc
:nnoremap r :so ~/Documents/Coding_Projects_And_Competitions/dotfiles/_vimrc<CR>

"insert enter before or after line
:nnoremap [<Space> O<Esc>
:nnoremap ]<Space> o<Esc>

"insert enter before cursor
:nnoremap <S-CR> i<CR><Esc>l

"go shortcuts
:nnoremap gi :vsc Edit.GoToImplementation<CR>
:nnoremap gr :vsc Edit.FindAllReferences<CR>
:nnoremap gw <C-w>l