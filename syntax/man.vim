" options {{{
" man_italic_is_underline: italics are underlined instead
" }}}

" quit when a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

let s:cpo_save = &cpo
set cpo&vim

" use nroff as a base
runtime syntax/nroff.vim

" font modifiers {{{
" single char {{{
syn match manB /^\.\s*B\s/me=e-1 transparent nextgroup=manBword skipwhite
syn match manBword /\S\+/ contained nextgroup=manBword skipwhite
syn region manBword start=/"/hs=s+1 skip=/\\"/ end=/"/he=e-1 contained oneline
	\ nextgroup=manBword skipwhite

syn match manI /^\.\s*I\s/me=e-1 transparent nextgroup=manIword skipwhite
syn match manIword /\S\+/ contained nextgroup=manIword skipwhite
syn region manIword start=/"/hs=s+1 skip=/\\"/ end=/"/he=e-1 contained oneline
	\ nextgroup=manIword skipwhite
" }}}
" alternating {{{
syn match manBR /^\.\s*BR\s/me=e-1 transparent nextgroup=manB2R skipwhite
syn match manRB /^\.\s*RB\s/me=e-1 transparent nextgroup=manR2B skipwhite
syn match manB2R /\S\+/ contained nextgroup=manR2B skipwhite
syn region manB2R start=/"/hs=s+1 skip=/\\"/ end=/"/he=e-1 contained oneline
	\ nextgroup=manR2B skipwhite
syn match manR2B /\S\+/ contained nextgroup=manB2R skipwhite
syn region manR2B start=/"/hs=s+1 skip=/\\"/ end=/"/he=e-1 contained oneline
	\ nextgroup=manB2R skipwhite

syn match manIR /^\.\s*IR\s/me=e-1 transparent nextgroup=manI2R skipwhite
syn match manRI /^\.\s*RI\s/me=e-1 transparent nextgroup=manR2I skipwhite
syn match manI2R /\S\+/ contained nextgroup=manR2I skipwhite
syn region manI2R start=/"/hs=s+1 skip=/\\"/ end=/"/he=e-1 contained oneline
	\ nextgroup=manR2I skipwhite
syn match manR2I /\S\+/ contained nextgroup=manI2R skipwhite
syn region manR2I start=/"/hs=s+1 skip=/\\"/ end=/"/he=e-1 contained oneline
	\ nextgroup=manI2R skipwhite

syn match manIB /^\.\s*IB\s/me=e-1 transparent nextgroup=manI2B skipwhite
syn match manBI /^\.\s*BI\s/me=e-1 transparent nextgroup=manB2I skipwhite
syn match manI2B /\S\+/ contained nextgroup=manB2I skipwhite
syn region manI2B start=/"/hs=s+1 skip=/\\"/ end=/"/he=e-1 contained oneline
	\ nextgroup=manB2I skipwhite
syn match manB2I /\S\+/ contained nextgroup=manI2B skipwhite
syn region manB2I start=/"/hs=s+1 skip=/\\"/ end=/"/he=e-1 contained oneline
	\ nextgroup=manI2B skipwhite
" }}}
" }}}
" highlights {{{
" helper commands to type less {{{
command! -nargs=1 HiBold hi def <args> term=bold cterm=bold gui=bold
command! -nargs=1 HiItalic
	\ hi def <args> term=italic cterm=italic gui=italic
command! -nargs=1 HiUnderline
	\ hi def <args> term=underline cterm=underline gui=underline
command! -nargs=1 HiRoman hi def <args> term=NONE cterm=NONE gui=NONE
" }}}
HiBold manBword
HiBold manB2R
HiBold manB2I
HiRoman manR2B
HiRoman manR2I
if exists("man_italic_is_underline")
	HiUnderline manIword
	HiUnderline manI2R
	HiUnderline manI2B
else
	HiItalic manIword
	HiItalic manI2R
	HiItalic manI2B
endif
" }}}

let b:current_syntax = "man"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: foldmethod=marker
