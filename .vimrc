set number  " print line number
set title  " print filename
set showmatch  " print {}
syntax on  " color code
set expandtab  " change tab -> space(4)
set tabstop=4  " indent space -> 4
set shiftwidth=4  " >> ot << space -> 4
set smartindent  " auto indent
set ignorecase  " Uppercase/Lowercase 
set smartcase  " Search difference if Uppecase exists
set wrapscan  " Search start if end
set whichwrap=h,l  "no move up down when h, l
set hlsearch  " high right
set incsearch  " searching 
set laststatus=2  " print status bar continuous 
set autoindent  " auto indent
set showcmd
set background=dark
set ruler
set statusline=%F%m%h%w\ %<[ENC=%{&fenc!=''?&fenc:&enc}]\ [FMT=%{&ff}]\ [TYPE=%Y]\ %=[CODE=0x%02B]\ [POS=%l/%L(%02v)]   
set nrformats=  " 8 shinsuu -> 10 shinsuu
set history=200
set nocompatible
set hidden
set clipboard=unnamedplus

set cursorline
highlight Cursorline cterm=NONE ctermfg=NONE ctermbg=black
set cursorcolumn
highlight Cursorcolumn cterm=NONE ctermfg=NONE ctermbg=black

nnoremap <Leader>c :<C-u>setlocal cursorline! cursorcolumn!<CR>
hi CursorLineNr term=bold cterm=NONE ctermfg=255 ctermbg=NONE

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

filetype plugin on

runtime macros/matchit.vim

xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

nnoremap & :&&<CR>
xnoremap & :&&<CR>

command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
