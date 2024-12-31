" Vim syntax file
" Language: Acton

if exists('b:current_syntax')
    finish
endif

syntax case match

" Keywords
syntax keyword actonStatement   def class actor protocol extension var
syntax keyword actonStatement   return break continue pass raise yield from
syntax keyword actonStatement   import as global nonlocal assert await async del
syntax keyword actonStatement   lambda is in

syntax keyword actonConditional if elif else
syntax keyword actonRepeat      for while
syntax keyword actonException   try except finally with

" Effect System
syntax keyword actonEffect      proc mut pure action

" Constants
syntax keyword actonConstant    True False None NotImplemented
syntax match actonEllipsis      "\.\.\."

" Operators
syntax match actonOperator      "[-+*/%@|&^=<>!~]"
syntax match actonOperator      "\<is not\>"
syntax match actonOperator      "\<not in\>"
syntax match actonOperator      ":"
syntax match actonOperator      "->"
syntax match actonOperator      "=>"

syntax keyword actonOperator    and or not in is

" Numbers
syntax match actonNumber        "\<0x[0-9a-fA-F]\+\>"
syntax match actonNumber        "\<0o[0-7]\+\>"
syntax match actonNumber        "\<\d\+\>"
syntax match actonFloat         "\<\d\+\.\d*\([eE][+-]\=\d\+\)\=\>"
syntax match actonFloat         "\.\d\+\([eE][+-]\=\d\+\)\=\>"
syntax match actonComplex       "\<\d\+[jJ]\>"
syntax match actonComplex       "\<\d\+\.\d*\([eE][+-]\=\d\+\)\=[jJ]\>"

" Strings
syntax region actonString       start=+'+ skip=+\\'+ end=+'+ contains=actonEscape
syntax region actonString       start=+"+ skip=+\\"+ end=+"+ contains=actonEscape
syntax region actonTripleString start=+'''+ end=+'''+
syntax region actonTripleString start=+"""+ end=+"""+
syntax region actonRawString    start=+r'+ end=+'+ contains=actonEscape
syntax region actonRawString    start=+r"+ end=+"+ contains=actonEscape
syntax region actonBytesString  start=+b'+ end=+'+ contains=actonEscape
syntax region actonBytesString  start=+b"+ end=+"+ contains=actonEscape

" String Escapes
syntax match actonEscape        +\\[abfnrtv'"\\]+ contained
syntax match actonEscape        "\\\o\{1,3}" contained
syntax match actonEscape        "\\x\x\{2}" contained
syntax match actonEscape        "\\\(u\x\{4}\|U\x\{8}\)" contained

" Comments
syntax match actonComment       "#.*$" contains=actonTodo
syntax keyword actonTodo        TODO FIXME XXX contained

" Function and Type Names
syntax match actonFunction      "\<\h\w*\>\ze\s*("
syntax match actonClass         "^\s*\<\%(class\|actor\|protocol\|extension\)\>\s\+\zs\h\w*"
syntax match actonDecorator     "@\h\w*"

" Type Variables and Annotations
syntax match actonTypeVar       "\<[A-Z]\d*\>"
syntax match actonTypeAnnotation ":\s*\zs[A-Z][a-zA-Z0-9_]*"

" Define the highlighting
highlight default link actonStatement        Statement
highlight default link actonConditional      Conditional
highlight default link actonRepeat           Repeat
highlight default link actonException        Exception
highlight default link actonEffect           Keyword
highlight default link actonOperator         Operator
highlight default link actonConstant         Constant
highlight default link actonEllipsis         Special
highlight default link actonNumber           Number
highlight default link actonFloat            Float
highlight default link actonComplex          Number
highlight default link actonString           String
highlight default link actonTripleString     String
highlight default link actonRawString        String
highlight default link actonBytesString      String
highlight default link actonEscape           Special
highlight default link actonComment          Comment
highlight default link actonTodo             Todo
highlight default link actonFunction         Function
highlight default link actonClass            Type
highlight default link actonDecorator        PreProc
highlight default link actonTypeVar          Type
highlight default link actonTypeAnnotation   Type

let b:current_syntax = 'acton'
