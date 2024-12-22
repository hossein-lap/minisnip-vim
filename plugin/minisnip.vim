" minisnip - lightweight and minimal snippet plugin
" Maintainer:  Jorengarenar <https://joren.ga>

if exists('g:loaded_minisnip') | finish | endif
let s:cpo_save = &cpo | set cpo&vim

let g:minisnip_dirs     = get(g:, 'minisnip_dirs', [])
let g:minisnip_trigger  = get(g:, 'minisnip_trigger', '<C-e>')
let g:minisnip_complkey = get(g:, 'minisnip_complkey', '<C-x><C-u>')
let g:minisnip_extends  = get(g:, 'minisnip_extends', {})
let g:minisnip_ext      = get(g:, 'minisnip_ext', 'snip')
let g:minisnip_local    = get(g:, 'minisnip_local', ".minisnip")

let g:minisnip_delimChg = get(g:, 'minisnip_delimChg', '$' )
let g:minisnip_descmark = get(g:, 'minisnip_descmark', '?' )
let g:minisnip_opening  = get(g:, 'minisnip_opening',  '<{')
let g:minisnip_closing  = get(g:, 'minisnip_closing' , '}>')
let g:minisnip_refmark  = get(g:, 'minisnip_refmark',  '~' )
let g:minisnip_evalmark = get(g:, 'minisnip_evalmark', '!' )
let g:minisnip_finalTag = get(g:, 'minisnip_finalTag', '+' )
let g:minisnip_noskip   = get(g:, 'minisnip_noskip',   '`' )
let g:minisnip_named    = get(g:, 'minisnip_named',    '@' )
let g:minisnip_exppat   = get(g:, 'minisnip_exppat',   '\w\+')

inoremap <silent> <script> <expr> <Plug>(minisnip) minisnip#trigger()
snoremap <silent> <script> <expr> <Plug>(minisnip) minisnip#trigger()
nnoremap <silent> <script> <expr> <Plug>(minisnip) minisnip#clear()

if !empty(g:minisnip_trigger)
  execute "imap <unique> ".g:minisnip_trigger." <Plug>(minisnip)"
  execute "smap <unique> ".g:minisnip_trigger." <Plug>(minisnip)"
  execute "nmap <unique> ".g:minisnip_trigger." <Plug>(minisnip)"
endif

if g:minisnip_complkey == '<C-x><C-u>'
  set completefunc=minisnip#completeFunc
elseif !empty(g:minisnip_complkey)
  execute 'inoremap <expr> '.g:minisnip_complkey
        \ .' pumvisible() ? "\<C-n>" : "\<C-r>=minisnip#completeMapping()\<CR>"'
endif

augroup minisnip
  au!
  execute "au BufRead,BufNewFile *.".g:minisnip_ext." setf snip"
  au FileType snip setlocal noexpandtab
  au FileType snip exec "inoremap <buffer> ".g:minisnip_trigger." ".g:minisnip_trigger
  au FileType snip exec "snoremap <buffer> ".g:minisnip_trigger." ".g:minisnip_trigger
  au FileType snip exec "syntax match Comment /^".g:minisnip_descmark.".*/"
  au FileType snip exec "syntax match Comment /^".g:minisnip_delimChg.".*/"
  au FileType snip exec "syntax match Keyword /" . g:minisnip_opening . "/"
  au FileType snip exec "syntax match Keyword /" . g:minisnip_closing . "/"
augroup END

let g:loaded_minisnip = 1
let &cpo = s:cpo_save | unlet s:cpo_save
