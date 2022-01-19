" plugins (`:PlugInstall` to install)
call plug#begin("~/.vim/plugged")
Plug 'airblade/vim-gitgutter' " easy view/manage git changes while editing
Plug 'AndrewRadev/splitjoin.vim' " break/join language constructs i.e. loops, conditionals
Plug 'APZelos/blamer.nvim' " inline blame
Plug 'arthurxavierx/vim-caser' " coerce between cases (e.g. v + gsX - coerce to snake, dash, dot, space, camel, etc)
Plug 'christoomey/vim-tmux-navigator'
Plug 'dhruvasagar/vim-zoom' " zoom windows via <C-w> m
Plug 'elixir-editors/vim-elixir' " elixir syntax isn't built-in
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " makes sure to have latest binary
Plug 'junegunn/fzf.vim' " nice vim defaults for fzf
Plug 'junegunn/gv.vim' " better git log view
Plug 'ludovicchabant/vim-gutentags' " generate tags on file save
Plug 'morhetz/gruvbox' " colors
Plug 'neoclide/coc.nvim', { 'branch': 'release' } " autocomplete, language servers
Plug 'preservim/nerdtree' " file explorer
Plug 'rickhowe/diffchar.vim' " view modified diff lines by word rather than line
Plug 'rhysd/git-messenger.vim' " view details of commit
Plug 'moll/vim-bbye' " close buffer without closing window
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails' " doesn't seem very worth yet
Plug 'tpope/vim-rhubarb' " combine with Fugitive to GBrowse to github URL
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired' " complementary pairs of mappings ([q, [<space>, [e)
Plug 'vim-airline/vim-airline' " better-looking status bar
call plug#end()

" set relative line numbering with current line number
set number
set relativenumber

" use spaces when tabbing
set expandtab

" don't use hanging indent in ruby: https://vi.stackexchange.com/a/12299
let g:ruby_indent_assignment_style = 'variable'

" search case insensitive unless searching with capital letters
set ignorecase smartcase

" do not continue comment automatically on newlines
" autocmd needed because ftplugin/vim.vim runs when a file is loaded, and this
" must be run after that: https://vi.stackexchange.com/q/9366
autocmd FileType * set formatoptions-=ro

" use true colors
set termguicolors

" max line length indicator
set colorcolumn=101

" open vsplit to right and hsplit to bottom
set splitright
set splitbelow

" reduce delay for gitgutter (default 4000 ms) (note: also controls delay for writing swap file)
set updatetime=100

" make spaces and tabs visible
set list
set listchars=tab:>\ ,space:·

" hide message when changing buffers from unsaved file
set hidden

" word wrap off
set nowrap

" always copy to clipboard if no register specified
set clipboard+=unnamedplus

" set gruvbox color scheme - airline colorings only look good when autocmd is used?
autocmd vimenter * colorscheme gruvbox

" distinguish Comment coloring from blamer coloring
autocmd vimenter * highlight Comment guifg=#6A9F55

" spell check for text-based files
autocmd BufRead,BufNewFile *.txt,*.md,*.org setlocal spell
autocmd BufRead,BufNewFile *.txt setlocal wrap
autocmd BufRead,BufNewFile *.txt setlocal linebreak

" resize vim windows when tmux pane is resized
autocmd VimResized * wincmd =

" inline blame color
highlight default link Blamer Whitespace

" don't invert visual mode highlighting colors
let g:gruvbox_invert_selection = 0

" use relative dates for inline blame
let g:blamer_relative_time = 1

" quicker inline blame display
let g:blamer_delay = 500

" enable inline blame
let g:blamer_enabled = 1

" don't inline blame in visual mode... way too laggy
let g:blamer_show_in_visual_modes = 0

" wsl set up for starting browser
let g:netrw_browsex_viewer='cmd.exe /C start'

" coc install extensions if not already install
let g:coc_global_extensions = [ 'coc-solargraph', 'coc-json', 'coc-tsserver', 'coc-java', 'coc-go']

" anchor fzf to bottom of window
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }

" space as leader because it's the easiest to reach and useless in normal mode
let mapleader = " "

" save session, input [name].vim
nnoremap <leader>ss :mksession .vim<left><left><left><left>

" find and load session - not using fzf#wrap because can't think of reason to apply opts
nnoremap <leader>sf :call fzf#run({ 'source': 'ls \| grep .vim$', 'sink': 'source' }))<CR>

" open new vertical split
nnoremap <leader>v :vsplit<CR>

" edit and source vimrc
nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>sv :so ~/.vimrc<CR>

" insert enter before or after line
nnoremap [<Space> O<Esc>
nnoremap ]<Space> o<Esc>

" yank file path
nnoremap <leader>y :let @+ = expand("%")<CR>

" insert enter before cursor
nnoremap <S-CR> i<CR><Esc>

" install plugins
nnoremap <leader>pi :PlugInstall<CR>

" easier to list and switch buffers (fzf.vim)
nnoremap <leader>b :Buffers<CR>

" delete buffer without closing window (vim-bbye)
" function CloseBuffer()
"   Buffers
"   call feedkeys("\<CR>")
"   messages
" endfunction
" nnoremap <leader>q :call CloseBuffer()<CR>
" nnoremap <leader>q :Buffers<CR><ESC> | :messages
" nnoremap <leader>q :bd<CR>
nnoremap <leader>q :bp\|bd #<CR>

" remove highlights
nnoremap <leader>rh :noh<CR>

" easy fuzzy find files (fzf.vim)
nnoremap <leader>f :FZF<CR>

" go to alternate file (rails.vim)
nnoremap <leader>ga :A<CR>

" go to related file (rails.vim)
nnoremap <leader>gr :R<CR>

" rename word in file (angle-brackets to match only the whole word)
nnoremap <leader>rr "yyiw<CR>:%s/\<<C-R>y\>/<C-R>y/g<left><left>

" open current line on GitHub master latest commit (vim-fugitive)
nnoremap <leader>gom :GBrowse master:%<CR>
vnoremap <leader>gom :.GBrowse master:%<CR>

" view commit details (git-messenger.vim)
nnoremap <leader>c :GitMessenger<CR>

" open fugitive status (vim-fugitive)
nnoremap <leader>gs :Gstatus<CR>

" blame file (vim-fugitive)
nnoremap <leader>gb :Gblame<CR>

" git log (gv.vim)
nnoremap <leader>gl :GV<CR>

" git fetch && rebase (vim-fugitive)
" using vim-fugitive instead of zsh alias because apparently need
" to load all zshrc on every zsh command in order to do so... too slow
nnoremap <leader>grm :Git fetch<CR>:Git rebase origin/master<CR>

" git stash (vim-fugitive)
nnoremap <leader>gzs :Git stash<CR>

" git stash pop (vim-fugitive)
nnoremap <leader>gzp :Git stash pop<CR>

" pw should push 'weak' from :Gstatus (vim-fugitive)
autocmd FileType fugitive nnoremap <buffer> pw :Git push<CR>

" pf should push -f from :Gstatus (vim-fugitive)
autocmd FileType fugitive nnoremap <buffer> pf :Git push -f<CR>

" specify commit message from :Gstatus (vim-fugitive)
autocmd FileType fugitive nnoremap <buffer> c<Space> :Git commit -m ""<left>

" gri to interactive rebase onto pulled master
" gdf view diff for file, unstaged
" gdu view diff for all unstaged
" gds view diff for all staged
" gdc view diff for file from commit
" gdc view diff from commit
" blame before commit
" gcd view commit details

" toggle file explorer (nerdtree)
nnoremap <leader>et :NERDTreeToggle<CR>

" find file in file explorer (nerdtree)
nnoremap <leader>ef :NERDTreeFind<CR>

" override nerdtree C-j & C-k maps so tmux vim navigator can use
let g:NERDTreeMapJumpPrevSibling=""
let g:NERDTreeMapJumpNextSibling=""

" use ripper-tags for generating tags via gutentags
let g:gutentags_ctags_executable_ruby = 'ripper-tags'

" tags - generate for project files
nnoremap <leader>tp :Start ripper-tags -R --append<CR>

" tags - generate for gems in bundle
nnoremap <leader>tb :Start ripper-tags -R $(bundle list --paths) --append<CR>

" tab select first Coc option
inoremap <silent><expr> <TAB> pumvisible() ? coc#_select_confirm() : "<TAB>"

" use <C-SPACE> to trigger completion
inoremap <silent><expr> <C-SPACE> coc#refresh()

" format xml
nnoremap <leader>x :% !xmllint --format -<CR>
vnoremap <leader>x :!xmllint --format -<CR>

" use rg for fzf's text search, without fuzzy finding https://github.com/junegunn/fzf.vim#example-advanced-ripgrep-integration
nnoremap <leader>F :RG<CR>
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case -- %s || true'
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

" don't use special fold text
set foldtext=MyFoldText()
function MyFoldText()
  return getline(v:foldstart)
endfunction

" make alternate file always reference specs
" let g:rails_projections = {
" 			\ "app/*.rb": {
" 			\   "alternate": [
" 			\     "spec/**/{basename}_spec.rb"
" 			\   ]
" 			\ }}

" move lines accomplished through AHK <A-jkhl> <A-arrow>

" arrow keys can be used through AHK <^+-jkhl> <arrow>, particularly useful for navigating vs2017's test explorer
