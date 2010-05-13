"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set guioptions=egmrLtTAci
set fileformat=unix
scriptencoding utf-8
set encoding=UTF-8
set fileencoding=utf-8
set gfn=Inconsolata\ 12
set langmenu=en

colorscheme mustang

set number "show line numer in left

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

"backups!
"set directory=~/.swp//

"set nowrap      dont wrap lines
"wrap lines at convenient points
set wrap linebreak textwidth=0
"statusline setup
set statusline=%f       "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

"indent settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"display tabs and trailing spaces
set list
set listchars=tab:\ \ ,extends:>,precedes:<

set formatoptions-=o "dont continue comment when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
    "darkspectrum is a terminal-friendly colorscheme
    colorscheme darkspectrum
else
    if has("gui_gnome")
        "set term=builtin_xterm
        colorscheme mustang
    else
        set t_Co=256
        set guitablabel=%M%t
        set lines=40
        set columns=115
    endif
    if has("gui_mac") || has("gui_macvim")
        set guifont=Monaco:h8
    endif
    if has("gui_win32") || has("gui_win32s")
        set guifont=Monaco:h8
                                "set enc=utf-8
    endif
endif

nmap <silent> <Leader>p :NERDTreeToggle<CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to bufexplorer
nnoremap <C-B> :BufExplorer<cr>

"map to fuzzy finder text mate stylez
nnoremap <c-f> :FuzzyFinderFile<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal g`\""
        endif
    end
endfunction

"define :HighlightExcessColumns command to highlight the offending parts of
"lines that are "too long". where "too long" is defined by &textwidth or an
"arg passed to the command
command! -nargs=? HighlightExcessColumns call s:HighlightExcessColumns('<args>')
function! s:HighlightExcessColumns(width)
    let targetWidth = a:width != '' ? a:width : &textwidth
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth+1) . 'v/'
    else
        echomsg "HighlightExcessColumns: set a &textwidth, or pass one in"
    endif
endfunction

set ts=2
set number

au Filetype html,xml,xsl source ~/.vim/plugin/closetag.vim

"map to fuzzy finder text mate stylez
nnoremap <c-f> :FuzzyFinderTextMate<CR>

let g:fuzzy_ignore = "*.svn"
let g:fuzzy_ignore = "*.swp"
let g:fuzzy_ignore = "*.jpg"
let g:fuzzy_ignore = "*.gif"
let g:fuzzy_ignore = "*~"

"snipmate setup
try
  source ~/.vim/snippets/support_functions.vim
catch
  source $HOMEPATH\vimfiles\snippets\support_functions.vim
endtry
autocmd vimenter * call s:SetupSnippets()
function! s:SetupSnippets()

    "if we're in a rails env then read in the rails snippets
    if filereadable("./config/environment.rb")
        call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
        call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
    endif

    call ExtractSnips("~/.vim/snippets/html", "eruby")
    call ExtractSnips("~/.vim/snippets/html", "xhtml")
    call ExtractSnips("~/.vim/snippets/html", "php")
endfunction

"set guifont="Monaco 14"

" Backups & Files
"set backup                     " Enable creation of backup file.
"set backupdir=~/.vim/backups " Where backups will go.
"set directory=~/.vim/tmp     " Where temporary files will go.

"ruby
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"improve autocomplete menu color
highlight Pmenu ctermbg=238 gui=bold

nnoremap <c-d> <c-x><c-o><CR>

let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_browser_command = 'opera %URL% &'




""
""MY CUSTOM COMMANDS
""
"Set to auto read when a file is changed from the outside
set autoread
"Set mapleader
let mapleader = ","
let g:mapleader = ","
"Fast saving
nmap <leader>w :w!<cr>
"Set 4 lines to the curors - when moving vertical..
set so=4
set magic
"No sound on errors.
set noerrorbells
set novisualbell
set switchbuf=usetab

"Move a line of text using control

nmap <c-j> mz:m+<cr>`z
nmap <c-k> mz:m-2<cr>`z
vmap <c-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <c-k> :m'<-2<cr>`>my`

noremap <c-h> <gv
noremap <c-l> >gv
vmap <c-h> <gv
vmap <c-l> >gv
"Shift + arrows make a selection like in traditional editors
imap <s-right> <esc>v
imap <s-left> <esc>v
map <s-right> <esc>v
map <s-left> <esc>v

imap <s-up> <esc>V
imap <s-down> <esc>V
map <s-up> <esc>V
map <s-down> <esc>V

vmap <s-down> <down>
vmap <s-up> <up>
vmap <s-left> <left>
vmap <s-right> <right>
"" nie trać zaznaczenia prz < i >
noremap < <gv
noremap > >gv

" wyszukiwanie TYLKO w zaznaczonym fragmencie:
vnoremap	/				<ESC>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap	?				<ESC>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

" szukanie we wszystkich plikach:
nmap		<F8>				:while !search( @/, "W") \| bnext \| endwhile<CR>



let g:ctags_regenerate = 0 
let generate_tags = 1
set wrapscan

function WriteAndCloseTab()
    w
    tabc
endfunction

au BufRead,BufNewFile *.js set ft=javascript syntax=jquery
au BufRead,BufNewFile *.sass set ft=css syntax=sass
au BufRead,BufNewFile *.scss set ft=css syntax=sass

nnoremap <f3> :set invpaste paste?<cr>
set pastetoggle=<f3>
set showmode

if &term =~ '^\(xterm\|screen\)$' && $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

if has("gui_running")
  colorscheme cobalt
  set guifont="Bitstream\ Vera\ Sans\ Mono\ 12"
else
  colorscheme cobalt
endif
set tabstop=2
set encoding=utf8
set autoindent
set smartindent
set ignorecase
set smartcase
set cursorline
set nocursorcolumn
""set list
set listchars=eol:¬,trail:•,tab:»-
"tabs
map <C-t> :tabnew<cr>
imap <c-left> <Esc>:tabp<cr>
imap <c-right> <Esc>:tabn<cr>
map <c-left> :tabp<cr>
map <c-right> :tabn<cr>
map <c-q> :tabc<cr>
"nerdcommenter
map <silent>c<space> <esc>:call NERDComment(0, "toggle")<cr>
vmap <silent>c<space> <esc>:call NERDComment(1, "toggle")<cr>
imap <silent>c<space> <esc>:call NERDComment(0, "toggle")<cr>i

map <c-o> :NERDTreeToggle <CR>
imap <C-s> <Esc> :w<CR>

"normal copy/paste
map <C-a> <esc>ggVG
vmap <C-c> "+y<Esc>i
imap <C-v> <Esc>"+pi
vmap <C-x> "+x<Esc>i
imap <C-y> <Esc>ddi
vmap <c-z> <Esc>uv
imap <c-z> <Esc>ui
map <p> P

"go to given tab

map <a-1> <Esc>1gt
map <a-2> <Esc>2gt
map <a-3> <Esc>3gt
map <a-4> <Esc>4gt
map <a-5> <Esc>5gt
map <a-6> <Esc>6gt
map <a-7> <Esc>7gt
map <a-8> <Esc>8gt
map <a-9> <Esc>9gt
map <a-w> <Esc>:wq<cr>
imap <a-w> <Esc>:wq<cr>
vmap <a-w> <Esc>:wq<cr>
"nice movement in line wrap mode
function! ScreenMovement(movement)
  if &wrap
    return "g" . a:movement
  else
    return a:movement
  endif
endfunction

onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")

noremap <F4> :set hlsearch! hlsearch?<CR>
nnoremap <F5> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
syntax match NonText "^\ +"
"autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
"au BufAdd,BufNewFile,BufRead * nested tab sball


 vmap <backspace> dd
 map <c-u> <esc>:u<cr>
 vmap <c-u> <esc>:u <cr><cr>v

command W w !sudo tee % >/dev/null
command WQ wq


" easier to reach, overrides TOP and BOTTOM of screen
map H ^
map L $

" display line up/down (not actual)
map <up> gk
map <down> gj

" search next/previous -- center in page
nmap n nzz
nmap N Nzz
nmap <backspace> i<backspace>

imap <a-left> <esc>:bprevious<cr>
map <a-left> :bprevious<cr>
vmap <a-left> <esc>:bprevious<cr>


imap <a-right> <esc>:bnext<cr>
map <a-right> :bnext<cr>
vmap <a-right> <esc>:bnext<cr>

set clipboard=unnamed

command! -nargs=* -complete=file -bang Rename :call Rename("<args>", "<bang>")

function! Rename(name, bang)
  let l:curfile = expand("%:p")
  let v:errmsg = ""
  silent! exe "saveas" . a:bang . " " . a:name
  if v:errmsg =~# '^$\|^E329'
    if expand("%:p") !=# l:curfile && filewritable(expand("%:p"))
      silent exe "bwipe! " . l:curfile
      if delete(l:curfile)
        echoerr "Could not delete " . l:curfile
      endif
    endif
  else
    echoerr v:errmsg
  endif
endfunction
