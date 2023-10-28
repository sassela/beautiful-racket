# til
- language oriented programming
- source to source compiler / transpiler made of:
	- reader: source code -> s-expressions
		- every reader must export a `read-syntax` function: describing a module
	- expander: s-expressions -> racket
	- s-expression is the intermediate representation
- in racket, everything is true `#t`, including `0` and `null` except `#f`
- `quote` or `'` turns expression into a `datum`
- `datum` syntax object (so we can treat code as data)
- macros: `datum`-> `datum`. a.k.a syntax transformers
- reader responsible for code form
- expander responsible for code meaning
- every expander must export `#%module-begin`
- pattern variable matches each line of code passed to a macro
	- e.g. `(define-macro (macro-name HANDLE-EXPR ...) ...)`
- `unquote` or `#'` turns code into a syntax object

## projects
small projects to try afterwards, to prove to myself I've understood what I'm reading
- https://github.com/racket/racket/wiki/Easy-bugs-to-fix
- [Typed Racket](https://github.com/racket/typed-racket/issues?q=is%3Aissue+is%3Aopen+sort%3Areactions-%2B1-desc+label%3A%22good+first+issue%22)
- [Racket](https://github.com/racket/racket/issues?q=is%3Aopen+is%3Aissue+label%3A%22good+first+issue%22+sort%3Areactions-%2B1-desc)
	- https://github.com/racket/racket/issues/4325
- [Missing Rosetta Code solutions?](https://www.rosettacode.org/wiki/Tasks_not_implemented_in_Racket)
