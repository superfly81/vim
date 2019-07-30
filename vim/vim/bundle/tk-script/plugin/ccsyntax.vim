
if !exists('*CoffeesynCHK')
	function! CoffeesynCHK()
		set makeprg="~/jsl -nologo -nofilelisting -nosummary -nocontext -conf ~/bin/jsl.conf -process %"
		set errorformat=%f(%l):\ %m
		ccl
		let winnum = winnr() " get current window number
		let linenum = line('.')
		let colnum = col('.')
		let cmd =  "%!coffee -c -s  | sed 's/^/".substitute(bufname("%"), '/', '\\/', "g")."/g' >~/.vimerr; cat"
		"echo cmd
		silent execute cmd
		silent cf ~/.vimerr
		cw 
		" open the error window if it contains error
		" return to the window with cursor set on the line of the first error (if any)
		execute winnum . "wincmd w"
		silent undo
		silent cf
		if 0 >= len(getqflist())
			w
			call cursor(linenum, colnum)
			"echo "no error"
		else
			echo "error" 
			"!cat  .vimerr 
		endif
	endfunction
endif

if !exists('*JSsynCHK')
	function! JSsynCHK()
		set makeprg="~/jsl -nologo -nofilelisting -nosummary -nocontext -conf ~/bin/jsl.conf -process %"
		set errorformat=%f(%l):\ %m
		ccl
		let winnum = winnr() " get current window number
		let linenum = line('.')
		let colnum = col('.')
		let cmd =  "%!jsl -nologo -nofilelisting -nosummary -nocontext -conf ~/bin/jsl.conf -stdin | sed 's/^/".substitute(bufname("%"), '/', '\\/', "g")."/g' >~/.vimerr; cat"
		"echo cmd
		silent execute cmd
		silent cf ~/.vimerr

		cw 
		" open the error window if it contains error
		" return to the window with cursor set on the line of the first error (if any)
		execute winnum . "wincmd w"
		silent undo
		silent cf
		if 0 >= len(getqflist())
			w
			call cursor(linenum, colnum)
			"echo "no error"
		else
			echo "error" 
			"!cat  .vimerr 
		endif
	endfunction
endif

if !exists('*PHPsynCHK')
	function! PHPsynCHK()
		set keywordprg="help"
		set errorformat=%m\ in\ %f\ on\ line\ %l
		ccl
		let winnum = winnr() " get current window number
		let linenum = line('.')
		let colnum = col('.')
		let cmd="%!php -l -f /dev/stdin | sed 's/\\/dev\\/stdin/".substitute(bufname("%"), '/', '\\/', "g")."/g' > ~/.vimerr; cat"
		"echo cmd

		silent execute cmd
		silent cf ~/.vimerr
		cw 
		" open the error window if it contains error
		" return to the window with cursor set on the line of the first error (if any)
		execute winnum . "wincmd w"
		silent undo
		silent cf
		if 1 == len(getqflist())
			w
			call cursor(linenum, colnum)
			"echo "no error"
		else
			"echo "error" 
		endif
	endfunction
endif
function! Check_Syntax()
	if &filetype == 'php'
		call PHPsynCHK()
	elseif &filetype == 'javascript'
		:call JSsynCHK()
	"elseif &filetype == 'sh'
	"	execute '!bash -x %'
	elseif &filetype == 'coffee'
		":call CoffeesynCHK()
		:make
		:w
	else
		:w
	endif
endfunction

function! Execute_Script()
	if &filetype == 'php'
		execute '!php %'
	elseif &filetype == 'python'
		execute '!python %'
	elseif &filetype == 'sh'
		execute '!bash -x %'
	elseif &filetype == 'javascript'
		execute '!node %'
	elseif &filetype == 'coffee'
		:CoffeeRun
	endif
endfunction

function! Test_Script()
	if &filetype == 'php'
		execute '!phpunit  %'
	elseif &filetype == 'python'
		echo "notet python"
	elseif &filetype == 'sh'
		echo "notet sh"
	elseif &filetype == 'javascript'
		execute '!mocha  --require should --reporter spec %'
	elseif &filetype == 'coffee'
		echo "notet javascript"
	endif
endfunction



function! TestUnitFunc()
	if &filetype == 'php'
        execute '[[f(b:!phpunit --filter test<C-R><C-W> tests/unittest/%:t:rTest.php' 
	elseif &filetype == 'python'
		echo "notet python"
	elseif &filetype == 'sh'
		echo "notet sh"
	elseif &filetype == 'javascript'
		execute '!mocha  --require should --reporter spec %'
	elseif &filetype == 'coffee'
		echo "notet javascript"
	endif
endfunction

function! SelfUnitFunc()
	if &filetype == 'php'
		execute '[[f(b:!phpunit --filter <C-R><C-W> %'
	elseif &filetype == 'python'
		echo "notet python"
	elseif &filetype == 'sh'
		echo "notet sh"
	elseif &filetype == 'javascript'
		execute '!mocha  --require should --reporter spec %'
	elseif &filetype == 'coffee'
		echo "notet javascript"
	endif
endfunction


function! ToUnitFile()
	if &filetype == 'php'
		execute 'sp tests/unittest/%:t:rTest.php'
	elseif &filetype == 'python'
		echo "notet python"
	elseif &filetype == 'sh'
		echo "notet sh"
	elseif &filetype == 'javascript'
		execute '!mocha  --require should --reporter spec %'
	elseif &filetype == 'coffee'
		echo "notet javascript"
	endif

endfunction

au!  BufWriteCmd  *     call Check_Syntax()
"map <leader>c :call Check_Syntax()   <CR>
"map <leader>e :call Execute_Script()   <CR>
"map <leader>T :call Test_Script()   <CR>


"执行当前单测函数
map <leader>t [[f(b:!phpunit --filter <C-R><C-W> %<cr>
"map <leader>T  :call SelfUnitFunc() <cr>

"map tu :sp tests/unittest/%:t:rTest.php <cr>
map tu  :call ToUnitFile() <cr>

"在原函数里执行单测
"map tf [[f(b:!phpunit --filter test<C-R><C-W> tests/unittest/%:t:rTest.php <cr>

"map tr [[f(b:!phpunit  tests/unittest/%:t:rTest.php <cr>

