:echo ">^.^<"

" set relative line numbering with current line number
set number
set relativenumber

" line number colorings
hi LineNr cterm=none ctermfg=Gray ctermbg=none
hi CursorLineNr cterm=bold ctermfg=DarkMagenta ctermbg=none

let mapleader = " "

" move this file to a new tab group through vertical splitting
nnoremap <leader>v :vsplit<CR>

" edit and source vimrc
nnoremap <leader>ve :tabnew ~/.vimrc<CR>
nnoremap <leader>vs :so ~/.vimrc<CR>

" insert enter before or after line
nnoremap [<Space> O<Esc>
nnoremap ]<Space> o<Esc>

" insert enter before cursor
nnoremap <S-CR> i<CR><Esc>

" max line length indicator
set colorcolumn=100

" word wrap off
set nowrap

" always copy to clipboard if no register specified
set clipboard+=unnamedplus

" go shortcuts
" nnoremap gi :vsc Edit.GoToImplementation<CR>
" nnoremap gr :vsc Edit.FindAllReferences<CR>
" nnoremap gcc :vsc Edit.ToggleComment<CR>
" vnoremap gc :vsc Edit.ToggleComment<CR><Esc><Esc>
nnoremap gw <C-w>w

" clear and edit line at indentation
" nnoremap cc ^C

" remove highlights
nnoremap <leader>rh :noh<CR>

" easy fuzzy find files
nnoremap <leader>f :FZF<CR>

" use rg for fzf's text search, without fuzzy finding https://github.com/junegunn/fzf.vim#example-advanced-ripgrep-integration
nnoremap <leader>F :RG<CR>
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" resize vim windows when tmux pane is resized
autocmd VimResized * wincmd =

" nerdtree
nnoremap <leader>eo :NERDTreeToggle<CR>
nnoremap <leader>ef :NERDTreeFind<CR>

" move lines accomplished through AHK <A-jkhl> <A-arrow>

" arrow keys can be used through AHK <^+-jkhl> <arrow>, particularly useful for navigating vs2017's test explorer

" plugins (`:PlugInstall` to install)
call plug#begin("~/.vim/plugged")
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " requires brew install first?; makes sure to have latest binary
Plug 'junegunn/fzf.vim' " nice vim defaults for fzf
Plug 'preservim/nerdtree'
call plug#end()

