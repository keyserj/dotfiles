" plugins (`:PlugInstall` to install)
call plug#begin("~/.vim/plugged")
Plug 'altercation/vim-colors-solarized' " color theme
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " makes sure to have latest binary
Plug 'junegunn/fzf.vim' " nice vim defaults for fzf
Plug 'kana/vim-textobj-user' " required for ruby block extension
Plug 'nelstrom/vim-textobj-rubyblock' " not sure if worth because method txtobj exists already
Plug 'neoclide/coc.nvim', { 'branch': 'release' } " doesn't seem very worth yet
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rails' " doesn't seem very worth yet
Plug 'tpope/vim-surround'
" Plug 'xolox/vim-easytags'
" Plug 'xolox/vim-misc' " required for all xolox plugins
call plug#end()

" set relative line numbering with current line number
set number
set relativenumber

" line number colorings
hi LineNr cterm=none ctermfg=Gray ctermbg=none
hi CursorLineNr cterm=bold ctermfg=DarkMagenta ctermbg=none

" make spaces and tabs visible, with color
" (colors: https://vim.fandom.com/wiki/Xterm256_color_names_for_console_Vim)
set list
set listchars=tab:>\ ,space:·
hi Whitespace ctermfg=240

" hide message when changing buffers from unsaved file
set hidden

" popular color scheme
" set background=dark
" colorscheme solarized

" max line length indicator
set colorcolumn=101

" word wrap off
set nowrap

" always copy to clipboard if no register specified
set clipboard+=unnamedplus

" resize vim windows when tmux pane is resized
autocmd VimResized * wincmd =

" coc install extensions if not already install
let g:coc_global_extensions = ['coc-solargraph', 'coc-json']

" space as leader because it's the easiest to reach and useless in normal mode
let mapleader = " "

" move this file to a new tab group through vertical splitting
nnoremap <leader>v :vsplit<CR>

" edit and source vimrc
nnoremap <leader>ev :tabnew ~/.vimrc<CR>
nnoremap <leader>sv :so ~/.vimrc<CR>

" insert enter before or after line
nnoremap [<Space> O<Esc>
nnoremap ]<Space> o<Esc>

" insert enter before cursor
nnoremap <S-CR> i<CR><Esc>

" easier to list and switch buffers
nnoremap <leader>b :Buffers<CR>

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

" nerdtree
nnoremap <leader>et :NERDTreeToggle<CR>
nnoremap <leader>ef :NERDTreeFind<CR>

" move lines accomplished through AHK <A-jkhl> <A-arrow>

" arrow keys can be used through AHK <^+-jkhl> <arrow>, particularly useful for navigating vs2017's test explorer

