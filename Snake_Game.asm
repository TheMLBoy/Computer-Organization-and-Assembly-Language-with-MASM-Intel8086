.model small
.stack 300h
.data	
	str db "Game Paused !$"
	str1 db "To go Back, press (R/r) or to exit (E/e).$ "
	str5 db "Snake Game. $"
	str6 db "Enter your Name : $" 
	str7 db "Welcome to the Snake Game$"
	str8 db "Welcome $"
	str9 db ", Please Enter choice : $"
	str10 db "Main Menu$"
	str11 db "1. Play Game$"
	str12 db "2. View Instructions$"
	str13 db "3. Exit$"
	str14 db "Instructions$"
	str15 db "1. Use left/down/right/up arrow keys or a,s,d,w to move left,down,right,up$"
	str3 db  "   respectively.$"
	str16 db "2. On getting a Fruit, you'll get points according to level.$"
	str2 db  "3. To pause game anytime, press P/p.$"
	str4 db  "4. To exit Game anytime press Esc.$"
	str17 db "5. When snake come into contact with its part or with the boundry, then Game is over.$"	
	str18 db "Thanks for Playing Game. $"
	str19 db "Have a Good Day. $"
	str20 db "Press any key to Continue... $"
	str21 db "Score : $"
	str22 db "Game Over !!! $"
	str23 db "Your Score = $"
	str24 db "Want to Play again (y/n) : $"
	str25 db "1. Easy Level $"
	str26 db "2. Medium Level$"
	str27 db "3. Expert Level $"
	str28 db "Enter Choice :  $"
	strS db "1. Stage 1 $"
	strS2 db "2. Stage 2 $"
	
	strrr db "Presented By : $"
	strr db "Muhammad Rehan Farooq $"
	strr1 db "Hafiz Hamza Sohail $"
	strr2 db "BCSF15M532$"
	strr3 db "BCSF15M541$"
	
	Score dw 0
	s dw 0
	name1 db 50 dup('$')
	row db 0
	col db 0
	count db 0
	randVal db 0
	FruitX db 0
	FruitY db 0
	SnakeX db 0
	SnakeY db 0
	var db 0
	soundVal db 0
	delayTime db 5
	SnakeArray db 1000 dup ('$')
	SnakeArrayX db 1000 dup('$')
	SnakeArrayY db 1000 dup('$')
	tmp1 db 0
	tmp2 db 0
	tmp3 db 0
	chk db 2
	stage db 0
	i db 0
	var2 dw 0
.code
	main proc
		mov ax,@data
		mov DS,ax
		mov ES,ax
		
		Call Pres
		Call ClearScreen
		Call MenuDisplay
		
		mov row,4
		mov col,30
		Call CursorPosition
		mov dx,offset str5
		mov ah,09h
		INT 21h
	;Enter Name:
		mov row,5
		mov col,22
		Call CursorPosition
		mov dx,offset str6
		mov ah,09h
		INT 21h
		
		mov row,6
		mov col,22
		Call CursorPosition
		mov dx,offset str7
		mov ah,09h
		INT 21h
		
		mov row,5
		mov col,40
		Call CursorPosition
		mov cx,10
		mov SI,offset name1
	again:	
		mov ah,01h
		INT 21h
		
		cmp al,13
		JE exit
		
		mov [SI],al
		INC SI
		DEC cx
		jnz again
	exit:
		
		mov row,9
		mov col,32
		Call CursorPosition
		
		mov dx,offset str10
		mov ah,09h
		INT 21h
		
		mov row,10
		mov col,30
		Call CursorPosition
		
		mov dx,offset str11
		mov ah,09h
		INT 21h
		
		mov row,11
		mov col,30
		Call CursorPosition
		
		mov dx,offset str12
		mov ah,09h
		INT 21h
		
		mov row,12
		mov col,30
		Call CursorPosition
		
		mov dx,offset str13
		mov ah,09h
		INT 21h
		
		mov row,14
		mov col,20
		Call CursorPosition
		
		mov dx,offset str8
		mov ah,09h
		INT 21h
		
		mov SI,offset name1
	ag:
		mov bl,[SI]
		cmp bl,'$'
		JE ex
		
		mov dl,[SI]
		mov ah,02h
		INT 21h
		
		INC SI
		jmp ag
	ex:
		mov dx,offset str9
		mov ah,09h
		INT 21h
	ag1:	
		mov row,14
		mov col,62
		Call CursorPosition
		
		mov ah,01h
		INT 21h
		
		cmp al,'1'
		JAE a
		
		mov row,14
		mov col,57
		Call CursorPosition
		
		mov dl,' '
		mov ah,02h
		INT 21h
		
		jmp ag1
	a:
		cmp al,'3'
		JBE b
		
		mov row,14
		mov col,57
		Call CursorPosition
		
		mov dl,' '
		mov ah,02h
		INT 21h
		
		jmp ag1
	b:
		cmp al,'1'
		JE play
		
		cmp al,'2'
		JE Rul1
		
		cmp al,'3'
		JE exitMenu
	Rul1:
		jmp Rul
		
	exitMenu:
		jmp exitGame
		
	play:
		Call MakeNULL
		Call StageMsg
		Call LevelMsg
		Call ClearScreen
		Call Logo
		
		mov row,2
		mov col,10
		Call CursorPosition
		mov dx,offset str21
		mov ah,09h
		INT 21h
		
		mov row,2
		mov col,20
		Call DisplayScore
		
		mov row,0Ch
		mov col,27h
		mov SnakeX,0Ch
		mov SnakeY,27h
		Call CursorPosition
		mov SI,offset SnakeArray
		mov bl,'O'
		mov [SI],bl
		mov dl,[SI]
		mov ah,02h
		INT 21h
		mov bl,'o'
		INC SI
		mov [SI],bl
		mov dl,[SI]
		mov ah,02h
		INT 21h
		
		mov SI,offset SnakeArrayX
		mov bh,0Ch
		mov [SI],bh
		INC SI
		mov [SI],bh
		mov SI,offset SnakeArrayY
		mov bh,27h
		mov [SI],bh
		INC SI
		mov bh,28h
		mov [SI],bh
		
		cmp stage,1
		JE reh1
		
		cmp stage,2
		JE er
		
	reh1:
		Call Boundery
		Call Fruit
		Call MovLeft
		jmp pr
	er:
		Call BounderyS2
		Call FruitS2
		Call MovLeftS2
	pr:	
		mov row,6
		mov col,15
		Call CursorPosition
		mov dx,offset str24
		mov ah,09h
		INT 21h
		
		mov row,6
		mov col,42
		Call CursorPosition
	dr:	
		mov ah,01h
		INT 21h
		
		cmp al,'Y'
		JE true
		
		cmp al,'y'
		JE true
		
		cmp al,'N'
		JE exitGame
		
		cmp al,'n'
		JE exitGame
		
		mov row,6
		mov col,42
		Call CursorPosition
		mov dl,' '
		mov ah,02h
		INT 21h
		jmp dr
	True:
		Call ClearScreen
		mov i,0
		Call Menu
		jmp ag1
		jmp ak
	Rul:
		Call Rule
		jmp ag1
	exitGame:
		Call ClearScreen
		Call MenuDisplay
		
		mov row,4
		mov col,22
		Call CursorPosition
		mov dx,offset str18
		mov ah,09h
		INT 21h	
		
		mov row,5
		mov col,22
		Call CursorPosition
		mov dx,offset str19
		mov ah,09h
		INT 21h	
		
		mov row,9
		mov col,10
		Call CursorPosition
	ak:
		mov ah,4Ch
		INT 21h
	main ENDP
	
	CursorPosition proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		mov ah,02h
		XOR bh,bh				;page 0
		mov dh,row				;variable (x-coordinate)
		mov dl,col				;variable (y-coordinate)
		INT 10h
	
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	
	ret
	CursorPosition ENDP
	
	StageMsg proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		Call ClearScreen
		mov row,8
		mov col,30
		Call CursorPosition
		
		mov dx,offset strS
		mov ah,09h
		INT 21h 
		
		mov row,10
		mov col,30
		Call CursorPosition
		
		mov dx,offset strS2
		mov ah,09h
		INT 21h 
		
		mov row,13
		mov col,25
		Call CursorPosition
		
		mov dx,offset str28
		mov ah,09h
		INT 21h 
	cgjS:	
		mov row,13
		mov col,40
		Call CursorPosition
		
		mov ah,01h
		INT 21h
		
		cmp al,'1'
		JE ch1S
		
		cmp al,'2'
		JE ch2S
	
		mov row,13
		mov col,40
		Call CursorPosition
		mov dl,' '
		mov ah,2h
		INT 21h
		jmp cgjS
		
	ch1S:
		mov stage,1
		jmp sta
	ch2S:
		mov stage,2
	sta:
		
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	StageMsg ENDP
	
	LevelMsg proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		Call ClearScreen
		mov row,8
		mov col,30
		Call CursorPosition
		
		mov dx,offset str25
		mov ah,09h
		INT 21h 
		
		mov row,10
		mov col,30
		Call CursorPosition
		
		mov dx,offset str26
		mov ah,09h
		INT 21h 
		
		mov row,12
		mov col,30
		Call CursorPosition
		
		mov dx,offset str27
		mov ah,09h
		INT 21h 
		
		mov row,15
		mov col,25
		Call CursorPosition
		
		mov dx,offset str28
		mov ah,09h
		INT 21h 
	cgj:	
		mov row,15
		mov col,40
		Call CursorPosition
		
		mov ah,01h
		INT 21h
		
		cmp al,'1'
		JE ch1
		
		cmp al,'2'
		JE ch2
		
		cmp al,'3'
		JE ch3
		
		mov row,15
		mov col,40
		Call CursorPosition
		mov dl,' '
		mov ah,2h
		INT 21h
		jmp cgj
		
	ch1:
		mov delayTime,5
		mov s,3
		jmp exl
	ch2:
		mov delayTime,3
		mov s,5
		jmp exl
	ch3:
		mov delayTime,2
		mov s,7
		jmp exl
	exl:
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	LevelMsg ENDP
	
	RandNO proc
		
		mov ah,0
		int 1ah
	
		mov al,dl
		mov bl,randVal
		mov ah,0
		div bl
		
	ret 
	RandNO ENDP
	
	Fruit proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		PUSH SI
		PUSH DI
		
	frst:	
		mov randVal,20
		Call RandNO
		cmp ah,3
		JBE btz
		mov row,ah
		jmp bgh
	btz:
		Add ah,4
		mov row,ah
	bgh:	
		mov FruitX,ah
		
		mov randVal,74
		Call RandNO
		
		cmp ah,4
		JBE btz1
		mov col,ah
		jmp bgh1
	btz1:
		ADD ah,5
		mov col,ah
	bgh1:
		mov FruitY,ah
		INC FruitX
		INC FruitY
		INC col
		INC row
		Call CursorPosition
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov bx,offset SnakeArray
	agh:	
		mov ch,[bx]
		cmp ch,'$'
		JE ec
		
		mov ch,[SI]
		mov cl,[DI]
		
		cmp ch,FruitX
		JE fc
		jmp fc2
	fc:
		cmp cl,FruitY
		JE fc1
		jmp fc2
	fc1:
		jmp frst
		
	fc2:
		INC SI
		INC DI
		INC Bx
		jmp agh
		
	ec:
		mov ch,FruitX
		mov row,ch
		mov ch,FruitY
		mov col,ch
		Call CursorPosition
		mov dl,'@'
		mov ah,02h
		INt 21h
		
		POP DI
		POP SI
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	Fruit ENDP
	
	DisplayScore Proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
	
		Call CursorPosition
		cmp score,0
		JE bty
		
		mov bx,Score
		Call DecimalOutput
		jmp cvz
	bty:
		mov dl,'0'
		mov ah,02h
		INT 21h
	cvz:
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	DisplayScore ENDP
	
	MakeNULL proc
		PUSH ax
		PUSH bx
		PUSH cx
		PUSH dx
		mov stage,0
		mov score,0
		mov chk,2
		mov al,'$'
		
		mov cx,1000
		mov DI,offset SnakeArrayX
		rep STOSB
		
		mov cx,1000
		mov DI,offset SnakeArrayY
		rep STOSB
		
		mov cx,1000
		mov DI,offset SnakeArray
		rep STOSB
		
		POP dx
		POP cx
		POP bx
		POP ax
	
	ret
	MakeNULL ENDP
	
	delay proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		mov ah,00
		int 1Ah
		mov bx,dx

	jmp_delay:
		int 1Ah
		sub dx,bx
		cmp dl,delayTime
		jl jmp_delay
		
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	delay endp
	
	Sound proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		PUSH SI
		PUSH DI
		
		mov dx,2000
		mov bx,1
		mov al,soundVal
		OUT 43h,al
	freq:
		mov ax,bx
		OUT 42h,al
		mov al,ah
		OUT 42h,al
		
		IN al,61h
		Or al,00000011b
		OUT 61h,al
		
		mov cx,100
	dely:
		LOOP dely
		
		INC Bx
		DEC Dx
		JNZ freq
		
		IN al,61h
		AND al,11111100b
		OUT 61h,al
		
		POP DI
		POP SI
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	Sound ENDP
	
	ENDL proc
	
		mov dl,13
		mov ah,02h
		INT 21h
		mov dl,10
		mov ah,02h
		INT 21h
	ret
	ENDL ENDP

	ShiftSnake Proc
		
	eag:
		mov al,[DI]
		mov col,al
		mov al,[SI]
		mov row,al
		Call CursorPosition
		
		mov dl,[bx]
		mov ah,02h
		INT 21h
		
		INC bx
		INC SI
		INC DI
		mov al,[bx]
		cmp al,'$'
		JE ei
		
		mov ah,[SI]
		mov al,[DI]
		mov ch,SnakeX
		mov cl,SnakeY
		mov [SI],ch
		mov [DI],cl
		mov SnakeX,ah
		mov SnakeY,al
		jmp eag
	ei:
	
	ret
	ShiftSnake ENDP
	
	MovLeft proc
	az:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov al,[SI]
		mov SnakeX,al
		mov row,al
		mov al,[DI]
		mov SnakeY,al
		DEC al
		mov col,al
		mov [DI],al
		
		cmp col,4
		JE exe14
		
		Call delay
		Call ShiftSnake
		jmp exc
		
	exe14:
		jmp exe
	
	exc:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		
		mov ch,[SI]
		mov cl,[DI]
	avb:	
		INC SI
		INC DI
		INC bx
		
		mov bh,[bx]
		cmp bh,'$'
		JE exo
		
		cmp ch,[SI]
		JE iso
		jmp avb
	
	iso:
		cmp cl,[DI]
		JE iso1
		jmp avb
		
	iso1:
		jmp exe14
	
	azcx:
		jmp az
	
	exo:	
		
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov bx,offset SnakeArray
		mov ch,FruitX
		mov cl,FruitY
		
		
		cmp [SI],ch
		JE fr
		jmp avz1
	fr:	
		cmp [DI],cl
		JE frr
		jmp avz1
	frr:
		mov soundVal,10101010b
		Call Sound
		Call Fruit
		mov cx,s
		ADD Score,cx
		mov row,2
		mov col,20
		Call DisplayScore
	ggL:	
		mov ch,[bx]
		cmp ch,'$'
		JE g
		
		INC SI
		INC DI
		INC bx
		jmp ggL
	g:
		mov al,SnakeX
		mov [SI],al
		mov al,SnakeY
		mov [DI],al
		mov al,'o'
		mov [bx],al
	apk:
		jmp avz
	
	avz1:
		mov ah,SnakeX
		mov al,SnakeY
		mov row,ah
		mov col,al
		Call CursorPosition
		mov dl,' '
		mov ah,02h
		INT 21h
		
	avz:
		mov ah,01h
		INT 16h
		JZ azcx
		
		mov ah,00h
		INT 16h
		
		cmp al,'s'
		JE dn
		cmp al,'w'
		JE ga
		cmp al,'P'
		JE ps
		cmp al,'p'
		JE ps
		
		cmp al,0
		JE azx	
	azx:
		cmp ah,48h
		JE ga
		
		cmp ah,50h
		JE dn
		
		cmp ah,01h
		JE exe
		
		jmp az
	ga:
		Call MovUP
		jmp exeee
	dn:
		Call MovDown
		jmp exeee
	ps:
		Call Pausee
		jmp azcx
	exe:
		Call GameOver
	
	exeee:
		
	ret
	MovLeft ENDP
	
	MovUP proc
	azU:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov al,[SI]
		mov SnakeX,al
		DEC al
		mov row,al
		mov [SI],al
		mov al,[DI]
		mov SnakeY,al
		mov col,al
		
		cmp row,3
		JE exe14U
		
		Call delay
		Call ShiftSnake
		jmp excU
		
	exe14U:
		jmp exeU
	
	excU:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		
		mov ch,[SI]
		mov cl,[DI]
	avbU:	
		INC SI
		INC DI
		INC bx
		
		mov bh,[bx]
		cmp bh,'$'
		JE exoU
		
		cmp ch,[SI]
		JE isoU
		jmp avbU
	
	isoU:
		cmp cl,[DI]
		JE iso1U
		jmp avbU
		
	iso1U:
		jmp exe14U
	
	azcxU:
		jmp azU
	
	exoU:
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov bx,offset SnakeArray
		mov ch,FruitX
		mov cl,FruitY
		
		cmp [SI],ch
		JE frU
		jmp avz1U
	frU:	
		cmp [DI],cl
		JE frrU
		jmp avz1U
	frrU:
		mov soundVal,10101010b
		Call Sound
		Call Fruit
		mov cx,s
		ADD Score,cx
		mov row,2
		mov col,20
		Call DisplayScore
	ggU:	
		mov ch,[bx]
		cmp ch,'$'
		JE gU
		
		INC SI
		INC DI
		INC bx
		jmp ggU
	gU:		
		mov al,SnakeX
		mov [SI],al
		mov al,SnakeY
		mov [DI],al
		mov al,'o'
		mov [bx],al
	apkU:
		jmp avzU
	
	avz1U:
		mov ah,SnakeX
		mov al,SnakeY
		mov row,ah
		mov col,al
		Call CursorPosition
		mov dl,' '
		mov ah,02h
		INT 21h
		
	avzU:	
		mov ah,01h
		INT 16h
		JZ azcxU
		
		mov ah,00h
		INT 16h
		
		cmp al,'d'
		JE dnU
		cmp al,'a'
		JE gaU
		cmp al,'P'
		JE psU
		cmp al,'p'
		JE psU
		cmp al,0
		JE azxU
	azxU:
		cmp ah,4Bh
		JE gaU
		
		cmp ah,4Dh
		JE dnU
		
		cmp ah,01h
		JE exeU
		
		jmp azU
	gaU:
		Call MovLeft
		jmp exeeeU
	dnU:
		Call MovRight
		jmp exeeeU
	psU:
		Call Pausee
		jmp azcxU
	exeU:
		Call ClearScreen
		Call GameOver
		
	exeeeU:
	
	ret 
	MovUP ENDP
	
	MovRight Proc
		
	azR:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov al,[SI]
		mov SnakeX,al
		mov row,al
		mov al,[DI]
		mov SnakeY,al
		INC al
		mov col,al
		mov [DI],al
		
		cmp col,75
		JE exe14R
		
		Call delay
		Call ShiftSnake
		jmp excR
		
	exe14R:
		jmp exeR
	
	excR:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		
		mov ch,[SI]
		mov cl,[DI]
	avbR:	
		INC SI
		INC DI
		INC bx
		
		mov bh,[bx]
		cmp bh,'$'
		JE exoR
		
		cmp ch,[SI]
		JE isoR
		jmp avbR
	
	isoR:
		cmp cl,[DI]
		JE iso1R
		jmp avbR
		
	iso1R:
		jmp exe14R
	
	azcxR:
		jmp azR
	
	exoR:	
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov bx,offset SnakeArray
		mov ch,FruitX
		mov cl,FruitY
		
		cmp [SI],ch
		JE frRi
		jmp avz1R
	frRi:	
		cmp [DI],cl
		JE frrRi
		jmp avz1R
	frrRi:
		mov soundVal,10101010b
		Call Sound
		Call Fruit
		mov cx,s
		ADD Score,cx
		mov row,2
		mov col,20
		Call DisplayScore
	
	ggR:	
		mov ch,[bx]
		cmp ch,'$'
		JE gR
		
		INC SI
		INC DI
		INC bx
		jmp ggR
	gR:		
		mov al,SnakeX
		mov [SI],al
		mov al,SnakeY
		mov [DI],al
		mov al,'o'
		mov [bx],al
	apkR:
		jmp avzR
	
	avz1R:
		mov ah,SnakeX
		mov al,SnakeY
		mov row,ah
		mov col,al
		Call CursorPosition
		mov dl,' '
		mov ah,02h
		INT 21h
		
	avzR:	
		mov ah,01h
		INT 16h
		JZ azcxR
		
		mov ah,00h
		INT 16h
		
		cmp al,'s'
		JE dnR
		cmp al,'w'
		JE gaR
		cmp al,'P'
		JE psR
		cmp al,'p'
		JE psR
		cmp al,0
		JE azxR
	azxR:
		cmp ah,48h
		JE gaR
		
		cmp ah,50h
		JE dnR
		
		cmp ah,01h
		JE exeR
		
		jmp azR
	gaR:
		
		Call MovUP
		jmp exeeeR
	dnR:
		Call MovDown
		jmp exeeeR
	psR:
		Call Pausee
		jmp azcxR
	exeR:
		Call ClearScreen
		Call GameOver
	
	exeeeR:
	ret
	MovRight ENDP
	
	
	MovDown proc
		
	azD:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov al,[SI]
		mov SnakeX,al
		INC al
		mov row,al
		mov [SI],al
		mov al,[DI]
		mov SnakeY,al
		mov col,al
		
		cmp row,21
		JE exe14D
		
		Call delay
		Call ShiftSnake
		jmp excD
		
	exe14D:
		jmp exeD
	
	excD:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		
		mov ch,[SI]
		mov cl,[DI]
	avbD:	
		INC SI
		INC DI
		INC bx
		
		mov bh,[bx]
		cmp bh,'$'
		JE exoD
		
		cmp ch,[SI]
		JE isoD
		jmp avbD
	
	isoD:
		cmp cl,[DI]
		JE iso1D
		jmp avbD
		
	iso1D:
		jmp exe14D
	
	azcxD:
		jmp azD
	
	exoD:	
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov bx,offset SnakeArray
		mov ch,FruitX
		mov cl,FruitY
		
		cmp [SI],ch
		JE frD
		jmp avz1D
	frD:	
		cmp [DI],cl
		JE frrD
		jmp avz1D
	frrD:
		mov soundVal,10101010b
		Call Sound
		Call Fruit
		mov cx,s
		ADD Score,cx
		mov row,2
		mov col,20
		Call DisplayScore
	
	ggD:	
		mov ch,[bx]
		cmp ch,'$'
		JE gD
		
		INC SI
		INC DI
		INC bx
		jmp ggD
	gD:		
		mov al,SnakeX
		mov [SI],al
		mov al,SnakeY
		mov [DI],al
		mov al,'o'
		mov [bx],al
	apkD:
		jmp avzD
	
	avz1D:
		mov ah,SnakeX
		mov al,SnakeY
		mov row,ah
		mov col,al
		Call CursorPosition
		mov dl,' '
		mov ah,02h
		INT 21h
		
	avzD:	
		mov ah,01h
		INT 16h
		JZ azcxD
		
		mov ah,00h
		INT 16h
		
		cmp al,'d'
		JE dnD
		cmp al,'a'
		JE gaD
		cmp al,'P'
		JE psD
		cmp al,'p'
		JE psD
		cmp al,0
		JE azxD
	azxD:
		cmp ah,4Bh
		JE gaD
		
		cmp ah,4Dh
		JE dnD
		
		cmp ah,01h
		JE exeD
		jmp azD
	gaD:
		Call MovLeft
		jmp exeeeD
	dnD:
		Call MovRight
		jmp exeeeD
	psD:
		Call Pausee
		jmp azcxD
	exeD:
		Call ClearScreen
		Call GameOver
	
	exeeeD:
	ret
	MovDown ENDP
	
	GameOver proc
		mov soundVal,10110110b
		Call Sound
		Call ClearScreen
		Call MenuDisplay
		
		mov row,4
		mov col,15
		Call CursorPosition
		mov dx,offset str22
		mov ah,09h
		INT 21h
		
		mov row,5
		mov col,15
		Call CursorPosition
		mov dx,offset str23
		mov ah,09h
		INT 21h
		
		mov row,5
		mov col,28
		Call DisplayScore
	ret
	GameOver ENDP
	
	ClearScreen proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		mov ah,06h
		mov al,0 		;Scroll all lines
		mov cx,0		;Upper corner
		mov Dx,184Fh	;lower corner
		mov bh,4BH
		INT 10h
	
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	ClearScreen ENDP
	
	Pausee proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		Call ClearScreen
		Call MenuDisplay
		
		mov row,4
		mov col,15
		Call CursorPosition
		mov dx,offset str
		mov ah,09h
		INT 21h
		
		mov row,5
		mov col,15
		Call CursorPosition
		mov dx,offset str1
		mov ah,09h
		INT 21h
		
		mov row,6
		mov col,15
		Call CursorPosition
		mov dx,offset str28
		mov ah,09h
		INT 21h
		
		mov row,6
		mov col,30
		Call CursorPosition
	paus:	
		mov ah,01h
		INT 21h
		
		cmp al,'R'
		JE res
		cmp al,'r'
		JE res
		cmp al,'E'
		JE ey
		cmp al,'e'
		JE ey
		
		mov row,6
		mov col,30
		Call CursorPosition
		mov dl,' '
		mov ah,02h
		INT 21h
		jmp paus
	ey:
		Call ClearScreen
		Call GameOver
		jmp pr
	res:
		Call ClearScreen
		Call Boundery	
		Call Logo
		
		mov row,2
		mov col,10
		Call CursorPosition
		mov dx,offset str21
		mov ah,09h
		INT 21h
		
		mov row,2
		mov col,20
		Call DisplayScore
		
		mov ch,FruitX
		mov row,ch
		mov ch,FruitY
		mov col,ch
		Call CursorPosition
		mov dl,'@'
		mov ah,02h
		INT 21h
		
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret 
	Pausee ENDP
	
	PauseeS2 proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		Call ClearScreen
		Call MenuDisplay
		
		mov row,4
		mov col,15
		Call CursorPosition
		mov dx,offset str
		mov ah,09h
		INT 21h
		
		mov row,5
		mov col,15
		Call CursorPosition
		mov dx,offset str1
		mov ah,09h
		INT 21h
		
		mov row,6
		mov col,15
		Call CursorPosition
		mov dx,offset str28
		mov ah,09h
		INT 21h
		
		mov row,6
		mov col,30
		Call CursorPosition
	pausS2:	
		mov ah,01h
		INT 21h
		
		cmp al,'R'
		JE resS2
		cmp al,'r'
		JE resS2
		cmp al,'E'
		JE eyS2
		cmp al,'e'
		JE eyS2
		
		mov row,6
		mov col,30
		Call CursorPosition
		mov dl,' '
		mov ah,02h
		INT 21h
		jmp paus
	eyS2:
		Call ClearScreen
		Call GameOver
		jmp pr
	resS2:
		Call ClearScreen
		Call BounderyS2	
		Call Logo
		
		mov row,2
		mov col,10
		Call CursorPosition
		mov dx,offset str21
		mov ah,09h
		INT 21h
		
		mov row,2
		mov col,20
		Call DisplayScore
		
		mov ch,FruitX
		mov row,ch
		mov ch,FruitY
		mov col,ch
		Call CursorPosition
		mov dl,'@'
		mov ah,02h
		INT 21h
		
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret 
	PauseeS2 ENDP
	
	Menu proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		Call MenuDisplay
		
		mov row,4
		mov col,30
		Call CursorPosition
		mov dx,offset str5
		mov ah,09h
		INT 21h
		
		mov row,5
		mov col,22
		Call CursorPosition
		mov dx,offset str6
		mov ah,09h
		INT 21h
		
		mov row,6
		mov col,22
		Call CursorPosition
		mov dx,offset str7
		mov ah,09h
		INT 21h
		
		mov row,5
		mov col,40
		Call CursorPosition
		
		mov SI,offset name1
	ag2:
		mov bl,[SI]
		cmp bl,'$'
		JE ex2
		
		mov dl,[SI]
		mov ah,02h
		INT 21h
		
		INC SI
		jmp ag2
	ex2:
		mov row,9
		mov col,32
		Call CursorPosition
		
		mov dx,offset str10
		mov ah,09h
		INT 21h
		
		mov row,10
		mov col,30
		Call CursorPosition
		
		mov dx,offset str11
		mov ah,09h
		INT 21h
		
		mov row,11
		mov col,30
		Call CursorPosition
		
		mov dx,offset str12
		mov ah,09h
		INT 21h
		
		mov row,12
		mov col,30
		Call CursorPosition
		
		mov dx,offset str13
		mov ah,09h
		INT 21h
		
		mov row,14
		mov col,20
		Call CursorPosition
		
		mov dx,offset str8
		mov ah,09h
		INT 21h
		
		mov SI,offset name1
	ag11:
		mov bl,[SI]
		cmp bl,'$'
		JE ex11
		
		mov dl,[SI]
		mov ah,02h
		INT 21h
		
		INC SI
		jmp ag11
	ex11:
		mov dx,offset str9
		mov ah,09h
		INT 21h
	
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	Menu ENDP
	
	Rule Proc
		
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		Call ClearScreen
		
		mov row,3
		mov col,30
		Call CursorPosition
		mov dx,offset str14
		mov ah,09h
		INT 21h
		
		mov row,5
		mov col,1
		Call CursorPosition
		mov dx,offset str15
		mov ah,09h
		INT 21h
		
		mov row,6
		mov col,1
		Call CursorPosition
		mov dx,offset str3
		mov ah,09h
		INT 21h
		
		mov row,8
		mov col,1
		Call CursorPosition
		mov dx,offset str16
		mov ah,09h
		INT 21h
		
		mov row,10
		mov col,1
		Call CursorPosition
		mov dx,offset str2
		mov ah,09h
		INT 21h
		
		mov row,12
		mov col,1
		Call CursorPosition
		mov dx,offset str4
		mov ah,09h
		INT 21h	
		
		mov row,14
		mov col,1
		Call CursorPosition
		mov dx,offset str17
		mov ah,09h
		INT 21h	
		
		mov row,17
		mov col,10
		Call CursorPosition
		mov dx,offset str20
		mov ah,09h
		INT 21h	
		
		mov ah,00h
		INT 16h
		Call ClearScreen
		Call Menu
		
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret 
	Rule ENDP
	
	MenuDisplay Proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		mov row,3
		mov col,12
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,49
		mov bl,0CBh
		INT 10h
		mov ch,4
		mov count,3
	agt:		
		mov row,ch
		mov col,12
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,2
		mov bl,0CBh
		INT 10h
		
		mov ch,row
		INC ch
		DEC count
		jnz agt
		
		mov row,7
		mov col,12
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,49
		mov bl,0CBh
		INT 10h
		
		mov count,3
		mov ch,4
	agbv:
		mov row,ch
		mov col,59
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,2
		mov bl,0CBh
		INT 10h
		
		mov ch,row
		INC ch
		DEC count
		jnz agbv
		
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	MenuDisplay ENDP
	
	Boundery Proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		mov row,3
		mov col,4
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,72
		mov bl,4BH
		INT 10h
		
		mov row,21
		mov col,4
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,72
		mov bl,4BH
		INT 10h
		
		mov ch,4
	agb:
		mov row,ch
		mov col,4
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,1
		mov bl,4BH
		INT 10h
		
		mov ch,row
		INC ch
		cmp ch,21
		JE exb
		jmp agb
	exb:
		mov ch,4
	agb1:	
		mov row,ch
		mov col,75
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,1
		mov bl,4BH
		INT 10h
		
		mov ch,row
		INC ch
		cmp ch,21
		JE exb1
		jmp agb1
	exb1:	
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	Boundery ENDP
	
	BounderyS2 Proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		mov row,4
		mov col,4
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,68
		mov bl,4Bh
		INT 10h
		
		mov row,11
		mov col,13
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,50
		mov bl,4Bh
		INT 10h
		
		mov row,18
		mov col,4
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,68
		mov bl,4Bh
		INT 10h
		
		mov ch,5
		mov count,4
	agbS2:
		mov row,ch
		mov col,4
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,2
		mov bl,4Bh
		INT 10h
		
		mov ch,row
		INC ch
		DEC count
		jnz agbS2	
	
		mov ch,5
		mov count,4
	agb1S2:	
		mov row,ch
		mov col,70
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,2
		mov bl,4Bh
		INT 10h
		
		mov ch,row
		INC ch
		DEC count
		jnz agb1S2
		
		mov ch,14
		mov count,4
	agb2S2:	
		mov row,ch
		mov col,70
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,2
		mov bl,4Bh
		INT 10h
		
		mov ch,row
		INC ch
		DEC count
		jnz agb2S2
	
		mov ch,14
		mov count,4
	agb3S2:	
		mov row,ch
		mov col,4
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,2
		mov bl,4Bh
		INT 10h
		
		mov ch,row
		INC ch
		DEC count
		jnz agb3S2
	
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	BounderyS2 ENDP
	
	DecimalOutput proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		mov ax,bx
		mov bx,10
		mov cx,0
	aa11:
		mov dx,0
		cmp ax,0
		JE exittt
		
		Div Bx
		PUSH dx
		inc cx
		jmp aa11
	exittt:
		POP dx
		ADD dl,48
		mov ah,02h
		INT 21h
		DEC cx
		jnz exittt
	
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret 
	DecimalOutput endp

	FruitS2 proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		PUSH SI
		PUSH DI
		
	frstS2:
		mov randVal,17
		Call RandNO
		cmp ah,5
		JBE btzS2
		mov row,ah
		jmp bghS2
	btzS2:
		Add ah,6
		mov row,ah
	bghS2:	
		mov FruitX,ah
		
		mov randVal,69
		Call RandNO
		
		cmp ah,6
		JBE btz1S2
		mov col,ah
		jmp bgh1S2
	btz1S2:
		ADD ah,5
		mov col,ah
	bgh1S2:
		mov FruitY,ah
		INC FruitX
		INC FruitY
		mov ch,FruitX
		mov cl,FruitY
		
		mov var,13
		
		cmp ch,4
		JE fovS2
		
		cmp ch,18
		JE fovS2
		
		cmp ch,11
		JE fov1S2
		jmp fvhS2
	fov1S2:
		cmp var,64
		JE fvhS2
		
		cmp cl,var
		JE fovS2
		
		INC var
		jmp fov1S2
	fovS2:
		jmp fov2S2
	
	fvhS2:	
		mov var,5
	fceS2:
		cmp var,9
		JE fbhrS2
		
		cmp ch,var
		JE fcfS2
		
		INC var
		jmp fceS2
	fcfS2:
		cmp cl,4
		JE fovS2
		
		cmp cl,5
		JE fovS2
		INC var
		jmp fceS2
	fbhrS2:
		mov var, 5
	fce1S2:
		cmp var,9
		JE fbhr1S2
		
		cmp ch,var
		JE fcf1S2
		
		INC var
		jmp fce1S2
	fcf1S2:
		cmp cl,70
		JE fovS2
		
		cmp cl,71
		JE fovS2
		INC var
		jmp fce1S2
	fbhr1S2:
		mov var,14
	fce2S2:
		cmp var,18
		JE fbhr2S2
		
		cmp ch,var
		JE fcf2S2
		
		INC var
		jmp fce2S2
	fcf2S2:
		cmp cl,70
		JE fovS2
		
		cmp cl,71
		JE fovS2
		INC var
		jmp fce2S2
	fbhr2S2:
		mov var, 14
	fce3S2:
		cmp var,18
		JE fbhr3S2
		
		cmp ch,var
		JE fcf3S2
		
		INC var
		jmp fce3S2
	fcf3S2:
		cmp cl,4
		JE fov2S2
		
		cmp cl,5
		JE fov2S2
		INC var
		jmp fce3S2
	fbhr3S2:
		jmp fbhr4S2
	fov2S2:	
		jmp frstS2
	fbhr4S2:	
		
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov bx,offset SnakeArray
	aghS2:	
		mov ch,[bx]
		cmp ch,'$'
		JE ecS2
		
		mov ch,[SI]
		mov cl,[DI]
		
		cmp ch,FruitX
		JE fcS2
		jmp fc2S2
	fcS2:
		cmp cl,FruitY
		JE fc1S2
		jmp fc2S2
	fc1S2:
		jmp frstS2
	fc2S2:
		INC SI
		INC DI
		INC Bx
		jmp aghS2
	ecS2:
		mov ch,FruitX
		mov row,ch
		mov ch,FruitY
		mov col,ch
		Call CursorPosition
		mov dl,'@'
		mov ah,02h
		INt 21h
		
		POP DI
		POP SI
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	FruitS2 ENDP
	
	Pass proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		PUSH SI
		PUSH DI

		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov ch,[SI]
		mov cl,[DI]
		mov var,9
	dobS2:	
		cmp var,14
		JE brS2
		
		cmp ch,var
		JE czS2
		INC var
		jmp dobS2
	czS2:
		cmp cl,4
		JE lrS2
		
		cmp cl,70
		JE rlS2
		
		INC var
		Jmp dobS2
	lrS2:
		mov bh,[SI]
		mov row,bh
		mov bh,[DI]
		mov col,bh
		mov bh,70
		mov [DI],bh
		Call CursorPosition
		mov dl,' '
		mov ah,02h
		INT 21h
		jmp brS2
	rlS2:
		mov bh,[SI]
		mov row,bh
		mov bh,[DI]
		mov col,bh
		mov bh,4
		mov [DI],bh
		Call CursorPosition
		mov dl,' '
		mov ah,02h
		INT 21h
		jmp brS2
	brS2:
		POP DI
		POP SI
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	Pass ENDP
	
	MovLeftS2 proc
	azS2:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov al,[SI]
		mov SnakeX,al
		mov row,al
		mov al,[DI]
		mov SnakeY,al
		DEC al
		mov col,al
		mov [DI],al
		
		Call IsOver
		cmp chk,0
		JE exe14S2
		
		Call delay
		Call ShiftSnake
		jmp excS2
	exe14S2:
		jmp exeS2
	excS2:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		
		mov ch,[SI]
		mov cl,[DI]
	avbS2:	
		INC SI
		INC DI
		INC bx
		
		mov bh,[bx]
		cmp bh,'$'
		JE exoS2
		
		cmp ch,[SI]
		JE isoS2
		jmp avbS2
	isoS2:
		cmp cl,[DI]
		JE iso1S2
		jmp avbS2
	iso1S2:
		jmp exe14S2
	azcxS2:
		jmp azS2
	exoS2:	
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov bx,offset SnakeArray
		mov ch,FruitX
		mov cl,FruitY
	
		cmp [SI],ch
		JE frS2
		jmp avz1S2
	frS2:	
		cmp [DI],cl
		JE frrS2
		jmp avz1S2
	frrS2:
		mov soundVal,10101010b
		Call Sound
		Call FruitS2
		mov cx,s
		ADD Score,cx
		mov row,2
		mov col,20
		Call DisplayScore
	ggLS2:	
		mov ch,[bx]
		cmp ch,'$'
		JE gS2
		
		INC SI
		INC DI
		INC bx
		jmp ggLS2
	gS2:
		mov al,SnakeX
		mov [SI],al
		mov al,SnakeY
		mov [DI],al
		mov al,'o'
		mov [bx],al
	apkS2:
		jmp avzS2
	avz1S2:
		mov ah,SnakeX
		mov al,SnakeY
		mov row,ah
		mov col,al
		Call CursorPosition
		mov dl,' '
		mov ah,02h
		INT 21h
	avzS2:
		Call Pass
		mov ah,01h
		INT 16h
		JZ azcxS2
		
		mov ah,00h
		INT 16h
		
		cmp al,'s'
		JE dnS2
		cmp al,'w'
		JE gaS2
		cmp al,'P'
		JE psS2
		cmp al,'p'
		JE psS2
		
		cmp al,0
		JE azxS2	
	azxS2:
		cmp ah,48h
		JE gaS2
		
		cmp ah,50h
		JE dnS2
		
		cmp ah,01h
		JE exeS2
		jmp azS2
	gaS2:
		Call MovUPS2
		jmp exeeeS2
	dnS2:
		Call MovDownS2
		jmp exeeeS2
	psS2:
		Call PauseeS2
		jmp azcxS2
	exeS2:
		Call GameOver
	exeeeS2:
	ret
	MovLeftS2 ENDP
	
	MovUPS2 proc
	azUS2:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov al,[SI]
		mov SnakeX,al
		DEC al
		mov row,al
		mov [SI],al
		mov al,[DI]
		mov SnakeY,al
		mov col,al
		
		Call IsOver
		cmp chk,0
		JE exe14US2
		
		Call delay
		Call ShiftSnake
		jmp excUS2
	exe14US2:
		jmp exeUS2
	excUS2:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		
		mov ch,[SI]
		mov cl,[DI]
	avbUS2:	
		INC SI
		INC DI
		INC bx
		
		mov bh,[bx]
		cmp bh,'$'
		JE exoUS2
		
		cmp ch,[SI]
		JE isoUS2
		jmp avbUS2
	isoUS2:
		cmp cl,[DI]
		JE iso1US2
		jmp avbUS2
	iso1US2:
		jmp exe14US2
	azcxUS2:
		jmp azUS2
	exoUS2:	
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov bx,offset SnakeArray
		mov ch,FruitX
		mov cl,FruitY
		
		cmp [SI],ch
		JE frUS2
		jmp avz1US2
	frUS2:	
		cmp [DI],cl
		JE frrUS2
		jmp avz1US2
	frrUS2:
		mov soundVal,10101010b
		Call Sound
		Call FruitS2
		mov cx,s
		ADD Score,cx
		mov row,2
		mov col,20
		Call DisplayScore
	ggUS2:	
		mov ch,[bx]
		cmp ch,'$'
		JE gUS2
		
		INC SI
		INC DI
		INC bx
		jmp ggUS2
	gUS2:		
		mov al,SnakeX
		mov [SI],al
		mov al,SnakeY
		mov [DI],al
		mov al,'o'
		mov [bx],al
	apkUS2:
		jmp avzUS2
	avz1US2:
		mov ah,SnakeX
		mov al,SnakeY
		mov row,ah
		mov col,al
		Call CursorPosition
		mov dl,' '
		mov ah,02h
		INT 21h
	avzUS2:	
		Call Pass
		mov ah,01h
		INT 16h
		JZ azcxUS2
		
		mov ah,00h
		INT 16h
		
		cmp al,'d'
		JE dnUS2
		cmp al,'a'
		JE gaUS2
		cmp al,'P'
		JE psUS2
		cmp al,'p'
		JE psUS2
		cmp al,0
		JE azxUS2
	azxUS2:
		cmp ah,4Bh
		JE gaUS2
		
		cmp ah,4Dh
		JE dnUS2
		
		cmp ah,01h
		JE exeUS2
		jmp azUS2
	gaUS2:
		Call MovLeftS2
		jmp exeeeUS2
	dnUS2:
		Call MovRightS2
		jmp exeeeUS2
	psUS2:
		Call PauseeS2
		jmp azcxUS2
	exeUS2:
		Call ClearScreen
		Call GameOver
	exeeeUS2:
	ret 
	MovUPS2 ENDP
	
	MovRightS2 Proc
	azRS2:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov al,[SI]
		mov SnakeX,al
		mov row,al
		mov al,[DI]
		mov SnakeY,al
		INC al
		mov col,al
		mov [DI],al
		
		Call IsOver
		cmp chk,0
		JE exe14RS2
		
		Call delay
		Call ShiftSnake
		jmp excRS2
	exe14RS2:
		jmp exeRS2
	excRS2:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		
		mov ch,[SI]
		mov cl,[DI]
	avbRS2:	
		INC SI
		INC DI
		INC bx
		
		mov bh,[bx]
		cmp bh,'$'
		JE exoRS2
		
		cmp ch,[SI]
		JE isoRS2
		jmp avbRS2
	isoRS2:
		cmp cl,[DI]
		JE iso1RS2
		jmp avbRS2
	iso1RS2:
		jmp exe14RS2
	azcxRS2:
		jmp azRS2
	exoRS2:	
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov bx,offset SnakeArray
		mov ch,FruitX
		mov cl,FruitY
		
		cmp [SI],ch
		JE frRiS2
		jmp avz1RS2
	frRiS2:	
		cmp [DI],cl
		JE frrRiS2
		jmp avz1RS2
	frrRiS2:
		mov soundVal,10101010b
		Call Sound
		Call FruitS2
		mov cx,s
		ADD Score,cx
		mov row,2
		mov col,20
		Call DisplayScore
	ggRS2:	
		mov ch,[bx]
		cmp ch,'$'
		JE gRS2
		
		INC SI
		INC DI
		INC bx
		jmp ggRS2
	gRS2:		
		mov al,SnakeX
		mov [SI],al
		mov al,SnakeY
		mov [DI],al
		mov al,'o'
		mov [bx],al
	apkRS2:
		jmp avzRS2
	avz1RS2:
		mov ah,SnakeX
		mov al,SnakeY
		mov row,ah
		mov col,al
		Call CursorPosition
		mov dl,' '
		mov ah,02h
		INT 21h
	avzRS2:
		Call Pass
		mov ah,01h
		INT 16h
		JZ azcxRS2
		
		mov ah,00h
		INT 16h
		
		cmp al,'s'
		JE dnRS2
		cmp al,'w'
		JE gaRS2
		cmp al,'P'
		JE psRS2
		cmp al,'p'
		JE psRS2
		cmp al,0
		JE azxRS2
	azxRS2:
		cmp ah,48h
		JE gaRS2
		
		cmp ah,50h
		JE dnRS2
		
		cmp ah,01h
		JE exeRS2
		jmp azRS2
	gaRS2:
		Call MovUPS2
		jmp exeeeRS2
	dnRS2:
		Call MovDownS2
		jmp exeeeRS2
	psRS2:
		Call PauseeS2
		jmp azcxRS2
	exeRS2:
		Call ClearScreen
		Call GameOver
	exeeeRS2:
	ret
	MovRightS2 ENDP
	
	MovDownS2 proc
	azDS2:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov al,[SI]
		mov SnakeX,al
		INC al
		mov row,al
		mov [SI],al
		mov al,[DI]
		mov SnakeY,al
		mov col,al
		
		Call IsOver
		cmp chk,0
		JE exe14DS2
		
		Call delay
		Call ShiftSnake
		jmp excDS2
	exe14DS2:
		jmp exeDS2
	excDS2:
		mov Bx,offset SnakeArray
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		
		mov ch,[SI]
		mov cl,[DI]
	avbDS2:	
		INC SI
		INC DI
		INC bx
		
		mov bh,[bx]
		cmp bh,'$'
		JE exoDS2
		
		cmp ch,[SI]
		JE isoDS2
		jmp avbDS2
	isoDS2:
		cmp cl,[DI]
		JE iso1DS2
		jmp avbDS2
	iso1DS2:
		jmp exe14DS2
	azcxDS2:
		jmp azDS2
	exoDS2:
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov bx,offset SnakeArray
		mov ch,FruitX
		mov cl,FruitY
		
		cmp [SI],ch
		JE frDS2
		jmp avz1DS2
	frDS2:	
		cmp [DI],cl
		JE frrDS2
		jmp avz1DS2
	frrDS2:
		mov soundVal,10101010b
		Call Sound
		Call FruitS2
		mov cx,s
		ADD Score,cx
		mov row,2
		mov col,20
		Call DisplayScore
	ggDS2:	
		mov ch,[bx]
		cmp ch,'$'
		JE gDS2
		
		INC SI
		INC DI
		INC bx
		jmp ggDS2
	gDS2:		
		mov al,SnakeX
		mov [SI],al
		mov al,SnakeY
		mov [DI],al
		mov al,'o'
		mov [bx],al
	apkDS2:
		jmp avzDS2
	avz1DS2:
		mov ah,SnakeX
		mov al,SnakeY
		mov row,ah
		mov col,al
		Call CursorPosition
		mov dl,' '
		mov ah,02h
		INT 21h
	avzDS2:	
		Call Pass
		mov ah,01h
		INT 16h
		JZ azcxDS2
		
		mov ah,00h
		INT 16h
		
		cmp al,'d'
		JE dnDS2
		cmp al,'a'
		JE gaDS2
		cmp al,'P'
		JE psDS2
		cmp al,'p'
		JE psDS2
		cmp al,0
		JE azxDS2
	azxDS2:
		cmp ah,4Bh
		JE gaDS2
		
		cmp ah,4Dh
		JE dnDS2
		
		cmp ah,01h
		JE exeDS2
		jmp azDS2
	gaDS2:
		Call MovLeftS2
		jmp exeeeDS2
	dnDS2:
		Call MovRightS2
		jmp exeeeDS2
	psDS2:
		Call PauseeS2
		jmp azcxDS2
	exeDS2:
		Call ClearScreen
		Call GameOver
	exeeeDS2:
	ret
	MovDownS2 ENDP

	IsOver proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		PUSH SI
		PUSH DI
		
		mov SI,offset SnakeArrayX
		mov DI,offset SnakeArrayY
		mov ch,[SI]
		mov cl,[DI]
		mov var,13
		
		cmp ch,4
		JE ov
		
		cmp ch,18
		JE ov
		
		cmp ch,11
		JE ov1
		jmp vh
	ov1:
		cmp var,63
		JE vh
		
		cmp cl,var
		JE ov
		
		INC var
		jmp ov1
	ov:
		jmp ov2
	vh:	
		mov var,5
	ce:
		cmp var,9
		JE bhr
		
		cmp ch,var
		JE cf
		
		INC var
		jmp ce
	cf:
		cmp cl,4
		JE ov
		
		cmp cl,5
		JE ov
		INC var
		jmp ce
	bhr:
		mov var, 5
	ce1:
		cmp var,9
		JE bhr1
		
		cmp ch,var
		JE cf1
		
		INC var
		jmp ce1
	cf1:
		cmp cl,70
		JE ov
		
		cmp cl,71
		JE ov
		INC var
		jmp ce1
	bhr1:
		mov var,14
	ce2:
		cmp var,18
		JE bhr2
		
		cmp ch,var
		JE cf2
		
		INC var
		jmp ce2
	cf2:
		cmp cl,70
		JE ov
		
		cmp cl,71
		JE ov
		INC var
		jmp ce2
	bhr2:
		mov var, 14
	ce3:
		cmp var,18
		JE bhr3
		
		cmp ch,var
		JE cf3
		
		INC var
		jmp ce3
	cf3:
		cmp cl,4
		JE ov2
		
		cmp cl,5
		JE ov2
		INC var
		jmp ce3
	bhr3:
		mov chk,1
		jmp bhr4
	ov2:	
		mov chk,0
	bhr4:
		POP DI
		POP SI
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	IsOver ENDP
		
	Logo proc
		PUSH Ax
		PUSH Bx
		PUSH Cx
		PUSH Dx
		
		mov tmp3,12
		mov SI,offset str5
		mov col,32
	aw:	
		mov row,1
		Call CursorPosition
		mov al,[si]
		XOR bh,bh
		mov ah,09h
		mov cx,1
		mov bl,0CBH
		INT 10h
		INC SI
		INC col
		DEC tmp3
		jnz aw
		
		POP Dx
		POP Cx
		POP Bx
		POP Ax
	ret
	Logo ENDP
	
	Pres proc
	
		Call ClearScreen
		Call Boundery
		
		mov row,5
		mov col,30
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,18
		mov bl,0CBH
		INT 10h
		
		mov row,7
		mov col,30
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,18
		mov bl,0CBH
		INT 10h
		
		mov ch,6
	agbp:
		mov row,ch
		mov col,30
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,1
		mov bl,0CBH
		INT 10h
		
		mov ch,row
		INC ch
		cmp ch,7
		JE exbp
		jmp agbp
	exbp:
		mov ch,6
	agb1p:	
		mov row,ch
		mov col,47
		Call CursorPosition
		
		mov al,'*'
		XOR bh,bh
		mov ah,09h
		mov cx,1
		mov bl,0CBH
		INT 10h
		
		mov ch,row
		INC ch
		cmp ch,7
		JE exb1p
		jmp agb1p
	exb1p:	
		
		mov row,6
		mov col,34
		Call CursorPosition
		mov dx,offset str5
		mov ah,09h
		INT 21h
		
		mov row,12
		mov col,11
		Call CursorPosition
		mov dx,offset strrr
		mov ah,09h
		INT 21h

		mov row,14
		mov col,18
		Call CursorPosition
		mov dx,offset strr
		mov ah,09h
		INT 21h
		
		mov row,16
		mov col,18
		Call CursorPosition
		mov dx,offset strr1
		mov ah,09h
		INT 21h
		
		mov row,14
		mov col,45
		Call CursorPosition
		mov dx,offset strr2
		mov ah,09h
		INT 21h
		
		mov row,16
		mov col,45
		Call CursorPosition
		mov dx,offset strr3
		mov ah,09h
		INT 21h
		
		
		mov row,19
		mov col,10
		Call CursorPosition
		mov dx,offset str20
		mov ah,09h
		INT 21h	
		
		mov ah,00h
		INT 16h
	
	ret 
	Pres ENDP
	
END main