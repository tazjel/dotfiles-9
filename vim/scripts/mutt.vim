set ft=mail
set textwidth=72
set formatoptions=tcql
set comments+="n:|"
set comments+="n:%"

nmap <silent> <f10> :call Mail_Next_Paragraph()<cr>

function! Mail_Erase_Sig()
	let i = 0
	while ((i <= line('$')) && (getline(i) !~ '^> *-- \=$'))
		let i = i + 1
	endwhile
	if (i != line('$') + 1)
		let j = i
		while (j < line('$') && (getline(j + 1) !~ '^-- $'))
			let j = j + 1
		endwhile
		while ((i > 0) && (getline(i - 1) =~ '^\(>\s*\)*$'))
			let i = i - 1
		endwhile
		exe 'normal! '.i.'Gd'.(j-1).'G'
	endif
endfunction

function! Mail_Del_Empty_Quoted()
	exe "normal :%s/^>[[:space:]\%\|\#>]\\+$//e\<CR>"
endfunction

function! Mail_Begining()
	let i = 0
	while ((i <= line('$')) && (getline(i) !~ '^> '))
		let i = i + 1
	endwhile
	while ((i <= line('$')) && (getline(i) =~ '^> '))
		let i = i + 1
	endwhile
	if (i != line('$') + 1)
		exe 'normal '.i.'gg'
	else
		while ((i > 1) && (getline(i) !~ '^-- $'))
			let i = i - 1
		endwhile
		exe 'normal '.(i - 1).'gg'
	endif
endfunction

function! Mail_Next_Paragraph()
	let i = line('.')
	while ((i <= line('$')) && (getline(i) !~ '^> '))
		let i = i + 1
	endwhile
	while ((i <= line('$')) && (getline(i) =~ '^> '))
		let i = i + 1
	endwhile
	if (i != line('$') + 1)
		exe 'normal '.i.'gg'
	endif
endfunction

silent call Mail_Erase_Sig()
silent call Mail_Del_Empty_Quoted()
silent call Mail_Begining()
