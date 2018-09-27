:echo ">^.^<"
:nnoremap <leader>ev :vsplit<CR>

"reload _vimrc
:nmap r :so ~/_vimrc<CR>

"insert enter before or after line
:nmap [<Space> O<Esc>
:nmap ]<Space> o<Esc>

"insert enter before cursor
:nmap <S-CR> i<CR><Esc>l

"paste before or after line, at indentation
:nmap P O<C-r>"<Esc>b^
:nmap p o<C-r>"<Esc>b^

"go shortcuts
:nmap gi :vsc Edit.GoToImplementation<CR>
:nmap gr :vsc Edit.FindAllReferences<CR>