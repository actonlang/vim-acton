" Vim indent file
" Language: Acton

" Only load this indent file when no other was loaded
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetActonIndent(v:lnum)
setlocal indentkeys+=<:>,=elif,=except,=finally

" Keep track of nested levels
let s:maxoff = 50

" Find backwards the closest open parenthesis/bracket/brace.
function! s:SearchParensPair()
  let line = line('.')
  let col = col('.')

  " Skip strings and comments
  let skip = "synIDattr(synID(line('.'), col('.'), 0), 'name') =~ '\\(String\\|Comment\\)$'"

  " Search for parentheses to start the syntax region
  call cursor(line, col)

  let parlnum = searchpair('(', '', ')', 'bW', skip)
  let parcol = col('.')

  let bracknum = searchpair('\[', '', '\]', 'bW', skip)
  let brackcol = col('.')

  let curlynum = searchpair('{', '', '}', 'bW', skip)
  let curlycol = col('.')

  " Return the closest match
  if parlnum > 0 && (bracknum < 1 || parlnum > bracknum) && (curlynum < 1 || parlnum > curlynum)
    return [parlnum, parcol]
  elseif bracknum > 0 && (curlynum < 1 || bracknum > curlynum)
    return [bracknum, brackcol]
  elseif curlynum > 0
    return [curlynum, curlycol]
  else
    return [-1, -1]
  endif
endfunction

function! GetActonIndent(lnum)
  " If this line is explicitly joined: If the previous line was also joined,
  " line it up with that one, otherwise add two 'shiftwidth'
  if getline(a:lnum - 1) =~ '\\$'
    if a:lnum > 1 && getline(a:lnum - 2) =~ '\\$'
      return indent(a:lnum - 1)
    endif
    return indent(a:lnum - 1) + &sw * 2
  endif

  " Get the line content
  let line = getline(a:lnum)
  let pline = getline(a:lnum - 1)

  " If we're at the start of the file, no indent
  if a:lnum == 1
    return 0
  endif

  " If the current line starts with a keyword that lines up with "try"
  if line =~ '^\s*\(except\|finally\)\>'
    let lnum = a:lnum - 1
    while lnum > 0
      if getline(lnum) =~ '^\s*\(try\|except\)\>'
        let ind = indent(lnum)
        return ind
      endif
      let lnum = lnum - 1
    endwhile
    return -1
  endif

  " If the current line starts with 'elif', line it up with 'if' or 'elif'
  if line =~ '^\s*elif\>'
    let lnum = a:lnum - 1
    while lnum > 0
      if getline(lnum) =~ '^\s*\(if\|elif\)\>'
        let ind = indent(lnum)
        return ind
      endif
      let lnum = lnum - 1
    endwhile
    return -1
  endif

  " Get indentation of previous line
  let ind = indent(a:lnum - 1)

  " Add a 'shiftwidth' after lines ending with a colon
  if pline =~ ':\s*$'
    let ind = ind + &sw
  endif

  " Subtract a 'shiftwidth' on 'else', 'elif', 'except', and 'finally'
  if line =~ '^\s*\(else\|elif\|except\|finally\)\>'
    let ind = ind - &sw
  endif

  return ind
endfunction
