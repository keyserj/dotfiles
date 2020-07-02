" plugins (`:PlugInstall` to install)
call plug#begin("~/.vim/plugged")
Plug 'airblade/vim-gitgutter' " easy view/manage git changes
Plug 'APZelos/blamer.nvim' " show blame inline
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " makes sure to have latest binary
Plug 'junegunn/fzf.vim' " nice vim defaults for fzf
Plug 'kana/vim-textobj-user' " required for ruby block extension
Plug 'nelstrom/vim-textobj-rubyblock' " not sure if worth because method txtobj exists already
Plug 'neoclide/coc.nvim', { 'branch': 'release' } " doesn't seem very worth yet
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails' " doesn't seem very worth yet
Plug 'tpope/vim-surround'
" Plug 'xolox/vim-easytags'
" Plug 'xolox/vim-misc' " required for all xolox plugins
call plug#end()

" set relative line numbering with current line number
set number
set relativenumber

" spell check for text-based files
autocmd BufRead,BufNewFile *.txt,*.md,*.org setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal wrap
autocmd BufRead,BufNewFile *.txt setlocal linebreak

" don't use special fold text
set foldtext=MyFoldText()
function MyFoldText()
  return getline(v:foldstart)
endfunction
" use relative dates for inline blame
let g:blamer_relative_time = 1

" quicker inline blame display
let g:blamer_delay = 500

" enable inline blame
let g:blamer_enabled = 1

" inline blame color
hi Blamer ctermfg=240

" open vsplit to right and hsplit to bottom
:set splitright
:set splitbelow

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

" max line length indicator
set colorcolumn=101

" word wrap off
set nowrap

" always copy to clipboard if no register specified
set clipboard+=unnamedplus

" gitgutter update quicker
set updatetime=100

" neat gitgutter features
" * shows which lines have been modified in gutter (not super clear on own)
" * line numbers change color to highlight changes less intrusively than
" highlighting... but the coloring is based on the CursorLineNr highlight...
" * fold all file except changes, pretty neat, but would be outshined by easy
" diff display
" * ]c [c to jump between changes in buffer

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

" remove highlights
nnoremap <leader>rh :noh<CR>

" easy fuzzy find files
nnoremap <leader>f :FZF<CR>

" nerdtree
nnoremap <leader>et :NERDTreeToggle<CR>
nnoremap <leader>ef :NERDTreeFind<CR>

" tab select first Coc option
inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" use <C-SPACE> to trigger completion
inoremap <silent><expr> <C-SPACE> coc#refresh()

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

" go to definition
function! s:GoToDefinition()
  if CocAction('jumpDefinition')
    return v:true
  endif

  " no idea why `execute("normal g\<C-]>")` doesn't work here...
  " nor why `let x = [below line]` doesn't work
  execute(":tjump " . expand("<cword>"))
  " execute("normal g\<C-]>")
endfunction

nnoremap <silent> gd :call <SID>GoToDefinition()<CR>

" delete buffers conveniently
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
  \ }))

" create parent directories when writing to file if they don't exist
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" move lines accomplished through AHK <A-jkhl> <A-arrow>

" arrow keys can be used through AHK <^+-jkhl> <arrow>, particularly useful for navigating vs2017's test explorer

