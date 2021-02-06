if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let g:rc_dir = expand('~/.vim/rc')
execute 'set runtimepath^=' . fnamemodify(s:dein_dir . "/repos/github.com/Shougo/dein.vim", ':p')

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(g:rc_dir . "/dein.toml", {'lazy': 0})
  call dein#load_toml(g:rc_dir . "/dein_lazy.toml", {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax on  " enable

if dein#check_install()
  call dein#install()
endif

" for tomasr/molokai
set t_Co=256
colorscheme molokai

" vim-fugitive
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit<CR><CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gs :Gstatus<CR>

" for lambdalisue/fern.vim
nnoremap <leader>fr :Fern . -reveal=%<CR><CR>
nnoremap <leader>fd :Fern . -reveal=% -drawer<CR><CR>

" for junegunn/fzf.vim
nnoremap <leader>fz :Files<CR>
nnoremap <leader>fb :Buffers<CR>

set number  " print line number
set title  " print filename
set showmatch  " print {}
" syntax on  " color code
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
set statusline=%F%m%h%w\ %<[ENC=%{&fenc!=''?&fenc:&enc}]\ [FMT=%{&ff}]\ [TYPE=%Y]\ %=[CODE=0x%02B]\ [POS=%l/%L(%02v)]\ %{fugitive#statusline()}
set nrformats=  " 8 shinsuu -> 10 shinsuu
set history=200
set hidden
" set clipboard=unnamedplus  " Ubuntu
set clipboard+=unnamed  " Mac
" set nocompatible

set cursorline
highlight Cursorline cterm=NONE ctermfg=NONE ctermbg=black
set cursorcolumn
highlight Cursorcolumn cterm=NONE ctermfg=NONE ctermbg=black

nnoremap <Leader>c :<C-u>setlocal cursorline! cursorcolumn!<CR>
hi CursorLineNr term=bold cterm=NONE ctermfg=Red ctermbg=NONE

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
