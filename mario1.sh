#!/bin/bash -i




_version="1.0"


function TerminalSize {

	
	local _tmph=`tput lines`

	
	local _tmpw=`tput cols`

	
	if [ $_tmph -ne $_height ] || [ $_tmpw -ne $_width ]; then

		_height=$_tmph
		_width=$_tmpw

		ResizeScreen

	fi

}


function ResizeScreen {

	
	_widthMid=$((_width / 2))

	
	_initY=$((_height - _heightScreen))

	_spaceIni=""
	_spaceFim=""

	if [ $_width -gt 80 ]; then

		_i=$(( (( _width - 80 )) / 2 ))
		_f=$(( (( _width - 80 )) - _i ))
		_spaceIni=`printf "%${_i}s"`
		_spaceFim=`printf "%${_f}s"`
	fi
	
	((_s= _width*_height))

	_clearScreen=`printf "%${_s}s"`

	
	_spaceScreen=`printf "%${_width}s"`

	


		_screen+="$_spaceScreen"


	tput reset
	tput civis
	
	

	

	ClearScreen

	_scoreX=$((((_width-80))/2))

}


function ClearScreen {

	tput cup 0 0
	
	if [ $_color = "on" ]; then
		echo -ne "${_cor[1]}$_clearScreen"
	else
		echo -ne "\E[00;30;47m$_clearScreen"
	fi

	tput cup $_initY 0

}


function Loadphase1 {
	
	_sizephase=3000
	_btela=`printf "%${_sizephase}s"`

	_tamQuad=100

	_flagDraw[4]="█          ███"	

	_flagX=2883
	_flagY=6

	
	_enemyX=(0 200 350 500 650 900 1490 1750 2030 2450 2780) 
	_enemyPathIni=(0 150 320 460 610 880 1480 1710 2000 2330 2700)
	_enemyPathFim=(0 250 420 560 710 980 1580 1810 2100 2480 2800)

	
	_coin=(0 80 190 210 330 350 370 390 410 430 660 800 830 860 890 1010 1080 1150 1240 1260 1280 1370 1390 1410 1480 1500 1520 1540 1590 1650 1720 1810 1830 1850 1870 1890 2260 2290 2320 2350 2410 2540 2570 2600 2630)

	
	_block=(0 105 135 165 495 525 555 630 690 975 1035 1110 1305 1320 1335 1560 1620 1680 1785 1920 2010 2040 2070 2100 2130 2160 2385 2670 2760 2790)

	
	_cloud=(0 30 220 290 450 580 750 930 1180 1430 1740 1950 2180 2450 2720 2830 2965)

	
	_hole=(0 280 580 850 1420 1830 2300 2500)

	
	_mont=(0 35 150 210 390 520 740 810 960 1050 1180 1250 1360 1570 1780 1900 2060 2120 2350 2420 2580 2790) 

	_cloud[0]=${#_cloud[*]}
	_cloudY=(0)
	_cloudHeight=$_cloud[0]

	for (( _k=1; _k<_cloud[0]; _k++ )); do
		_cloudY[$_k]=2
	done

	_enemyX[0]=${#_enemyX[*]}
	_enemyWidth=16
	_enemyHeight=(0)
	_enemyY=(0)
	_enemyVelocX=(1)
	_enemySprite=(0)
	_enemyDead=(0)
	_aniEnemy=(0)

	
	for ((_k=1; _k<_enemyX[0]; _k++)); do

		_enemyVelocX[$_k]=${_enemyVelocX[0]}
		_enemySprite[$_k]=${_enemySprite[0]}
		_aniEnemy[$_k]=0
		_enemyDead[$_k]=0

	done

	_coin[0]=${#_coin[*]}
	_coinWidth=10
	_coinHeight=5
	_coinY=(9)
	_coinQ=(0)
	_coinSprite=(0)

	for ((_k=1; _k<_coin[0]; _k++)); do

		_tmp=$((_coin[_k] / _coinWidth))
		_coinY[$_k]=${_coinY[0]}
		_coinQ[$_tmp]=$_k
		_coinSprite[$_k]=${_coinSprite[0]}

	done


	_blockWidth=15
	_blockY=8
	_blockHeight=7
	_blockQ=(0)
	_block[0]=${#_block[*]}

	for ((_k=1; _k<_block[0]; _k++)); do

		_tmp=$((_block[_k] / _blockWidth))
		_blockQ[$_tmp]=$_k

	done

	_montWidth=30
	_mont[0]=${#_mont[*]}

	_hole[0]=${#_hole[*]}
	_holeWidth=25

	for (( _k=0; _k<=36; _k++ )); do	
		_phasel[$_k]="$_btela"
	done
	
	_tmp=$((_sizephase / 10))

	_phasel[37]=""
	_phasel[38]=""
	_phasel[39]=""

	for (( _k=0; _k<_tmp; _k++ )); do

		_phasel[37]+="${_floor1}"
		_phasel[38]+="${_floor2}"
		_phasel[39]+="${_floor1}"

	done

	for (( _k=1; _k<_cloud[0]; _k++ )); do
		
		_tmpPos=${_cloud[$_k]}

		_ind=${_cloudY[$_k]}

		for (( _l=_ind; _l<_ind + _cloudDraw[0]; _l++ )); do

			_tmp0=$(( _l - _ind + 1))			
			_tmp1=${#_cloudDraw[$_tmp0]}

			_f=$(( _tmpPos + _tmp1  ))

			_phasel[$_l]="${_phasel[$_l]:0:$_tmpPos}${_cloudDraw[$_tmp0]}${_phasel[$_l]:$_f}"
		done
	done












	for (( _k=1; _k<_mont[0]; _k++ )); do

		_montX=${_mont[$_k]}
		_tmp2=$(( _montX + _montWidth ))
		for (( _l=1; _l<=7; _l++ )); do
			_tmp=$((_l + 29 ))
			_phasel[$_tmp]="${_phasel[$_tmp]:0:$_montX}${_montDraw[$_l]}${_phasel[$_tmp]:$_tmp2}"
		done
	done

	for (( _k=1; _k<_block[0]; _k++ )); do

		_blockX=${_block[$_k]}
		_tmp2=$(( _blockX + _blockWidth ))

		_phasel[$((_blockY))]="${_phasel[$((_blockY))]:0:$_blockX}${_blockDraw[0]}${_phasel[$((_blockY))]:$_tmp2}"
		_phasel[$((_blockY+1))]="${_phasel[$((_blockY+1))]:0:$_blockX}${_blockDraw[1]}${_phasel[$((_blockY+1))]:$_tmp2}"
		_phasel[$((_blockY+2))]="${_phasel[$((_blockY+2))]:0:$_blockX}${_blockDraw[1]}${_phasel[$((_blockY+2))]:$_tmp2}"
		_phasel[$((_blockY+3))]="${_phasel[$((_blockY+3))]:0:$_blockX}${_blockDraw[1]}${_phasel[$((_blockY+3))]:$_tmp2}"
		_phasel[$((_blockY+4))]="${_phasel[$((_blockY+4))]:0:$_blockX}${_blockDraw[1]}${_phasel[$((_blockY+4))]:$_tmp2}"
		_phasel[$((_blockY+5))]="${_phasel[$((_blockY+5))]:0:$_blockX}${_blockDraw[1]}${_phasel[$((_blockY+5))]:$_tmp2}"
		_phasel[$((_blockY+6))]="${_phasel[$((_blockY+6))]:0:$_blockX}${_blockDraw[0]}${_phasel[$((_blockY+6))]:$_tmp2}"
	done

	for (( _k=1; _k<=_castle[0]; _k++ )); do

		((_tmp = _k + 5))
		_tmpL=${#_castle[$_k]}
		_tmpI=$((_sizephase-120))
		_tmpF=$((_tmpI + _tmpL))

		_phasel[$_tmp]="${_phasel[$_tmp]:0:$_tmpI}${_castle[$_k]}${_phasel[$_tmp]:$_tmpF}"
	done

}


function Drawhole {

	_ubound=${_hole[0]}

	for (( _k=1; _k < _ubound; _k++ )); do

		if [ $((_hole[_k] + _holeWidth)) -ge $_cameraX ] && [ ${_hole[$_k]} -le $((_cameraX + _width)) ]; then 

			_holeX=$(( _hole[_k] + _edgeWidth - _cameraX ))
			_holeL=$(( _holeX + _holeWidth ))

			_tmp=${_canvasC[0]}

			for (( _l=37; _l<40; _l++ )); do
				_canvas[$_l]="${_canvas[$_l]:0:$((_holeX-2))}${_holeDraw}${_canvas[$_l]:$((_holeL+2))}"

				if [ $_color = "on" ]; then
					_tmp=${_canvasC[0]}
					((_tmp++))
					_canvasC[$_tmp]=${_cor[2]}
					if [ $((_holeX - _edgeWidth)) -lt 0 ]; then
						_canvasP[$_tmp]=$((_width * _l))
					else
						_canvasP[$_tmp]=$(( (_width * _l) + _holeX - _edgeWidth ))
					fi
					((_tmp++))
					_canvasC[$_tmp]=${_cor[3]}
					if [ $((_holeL - _edgeWidth)) -gt $_width ]; then
						_canvasP[$_tmp]=$(( _width * (_l+1) ))
					else
						_canvasP[$_tmp]=$(( (_width * _l) + _holeL - _edgeWidth ))
					fi

					_canvasC[0]=$_tmp

				fi

			done


		fi
	done

}


function MontaCanvas {

	if [ $_jogX -lt $_widthMid ]; then

		_cameraX=0

	else 
		if [ $_jogX -ge $((_sizephase - _widthMid)) ]; then

			_cameraX=$((_sizephase - _width))

		else

			_cameraX=$((_jogX - _widthMid))
		fi
	fi

	 for (( _k=0; _k<_heightScreen; _k++ )); do

		_f=$(( _cameraX + _width -1))

		_canvas[$_k]="${_edgeScreen}${_phasel[$_k]:$_cameraX:$_width}${_edgeScreen}"

	done


}


function get_out {

	stty $_terminal
	
	tput cnorm

	tput sgr0

	
	tput reset

	
	
	
	
	if [ "$_erro" != "" ]; then
		echo -e $_erro
	fi
	
	
	exit
}


function InitGame {

	_score=0



	_jogLife=3

	Splash
	
}


function Score {

	((_score+=$1))

	if [ $_score -ge $_topScore ]; then
		_topScore=$_score
		SaveSettings
	fi	

}


function SaveSettings {

	echo "_topScore=$_topScore">.settings
	echo "_sound=$_sound">>.settings
	echo "_color=$_color">>.settings

}

function Splash {

	
	_screenGame="SPLASH"

	LoadColors

	
	_jogX=0
	_jogY=0
	_velocY=0
	_velocX=0

	_jogDead=false

	
	_jogAni=0
	_jogSprite=0

	
	_jogSide="D"

	
	for (( _y=0; _y<12; _y++ )); do

		_canvas[$_y]="${_edgeScreen}${_spaceScreen}${_edgeScreen}"

	done

	_canvas[12]="${_edgeScreen}${_spaceIni}                              █████                                             ${_spaceFim}${_edgeScreen}"
	_canvas[13]="${_edgeScreen}${_spaceIni}                             █░░░░M███                                          ${_spaceFim}${_edgeScreen}"
	_canvas[14]="${_edgeScreen}${_spaceIni}                            █░░░░░░░░░█                                         ${_spaceFim}${_edgeScreen}"
	_canvas[15]="${_edgeScreen}${_spaceIni}                            ███  █ ███                                          ${_spaceFim}${_edgeScreen}"
	_canvas[16]="${_edgeScreen}${_spaceIni}                           █  ██ █    █       X     0${_jogLife}                          ${_spaceFim}${_edgeScreen}"
	_canvas[17]="${_edgeScreen}${_spaceIni}                           █  ██  █   █                                         ${_spaceFim}${_edgeScreen}"
	_canvas[18]="${_edgeScreen}${_spaceIni}                            ██   █████                                          ${_spaceFim}${_edgeScreen}"
	_canvas[19]="${_edgeScreen}${_spaceIni}                             ██     █                                           ${_spaceFim}${_edgeScreen}"
	_canvas[20]="${_edgeScreen}${_spaceIni}                               █████                                            ${_spaceFim}${_edgeScreen}"

	for (( _y=21; _y<_heightScreen; _y++ )); do

		_canvas[$_y]="${_edgeScreen}${_spaceScreen}${_edgeScreen}"

	done
	
	Render

	Loadphase1

	sleep 1

	
	Play "background"

	
	_screenGame="GAME"

	_timeIni=$SECONDS
}


function GameOver {

	
	_screenGame="GAMEOVER"

	LoadColors

	
	for (( _y=0; _y<13; _y++ )); do

		_canvas[$_y]="${_edgeScreen}${_spaceScreen}${_edgeScreen}"

	done

	

	_canvas[13]="${_edgeScreen}$_spaceIni  ████    ████   ██   ██  ██████           ████   ██  ██  ██████  █████     ██  $_spaceFim${_edgeScreen}" 
	_canvas[14]="${_edgeScreen}$_spaceIni ██      ██  ██  ███ ███  ██              ██  ██  ██  ██  ██      ██  ██    ██  $_spaceFim${_edgeScreen}" 
	_canvas[15]="${_edgeScreen}$_spaceIni ██ ███  ██████  ██ █ ██  ████            ██  ██  ██  ██  ████    █████     ██  $_spaceFim${_edgeScreen}" 
	_canvas[16]="${_edgeScreen}$_spaceIni ██  ██  ██  ██  ██   ██  ██              ██  ██   ████   ██      ██  ██        $_spaceFim${_edgeScreen}"   
	_canvas[17]="${_edgeScreen}$_spaceIni  ████   ██  ██  ██   ██  ██████           ████     ██    ██████  ██  ██    ██  $_spaceFim${_edgeScreen}"  


	for (( _y=18; _y<_heightScreen; _y++ )); do

		_canvas[$_y]="${_edgeScreen}${_spaceScreen}${_edgeScreen}"

	done

	Render

	sleep 4

	LoadMenu
}


function GameWin {

	
	_screenGame="GAMEWIN"

	LoadColors

	
	for (( _y=0; _y<10; _y++ )); do

		_canvas[$_y]="${_edgeScreen}${_spaceScreen}${_edgeScreen}"

	done

	
 _canvas[10]="${_edgeScreen}${_spaceIni}      				You Won!     		 ${_spaceFim}${_edgeScreen}" 

	for (( _y=11; _y<50; _y++ )); do

		_canvas[$_y]="${_edgeScreen}${_spaceScreen}${_edgeScreen}"

	done

	Render

	sleep 4

	read -n1

	LoadMenu
}


function LoadMenu {

	if [ $_musicId ]; then
		Stop $_musicId
	fi

	
	_screenGame="MENU"

}


function MontaMenu {

	
	

	
	for (( _y=0; _y<26; _y++ )); do
		
		_canvas[$_y]="${_edgeScreen}${_spaceIni}${_menu[$_y]}${_spaceFim}${_edgeScreen}"

	done

	_tmpi=$((36+12-${#_topScore}))
	_canvas[26]="${_edgeScreen}${_spaceIni}${_menu[26]:0:$_tmpi}${_topScore}${_menu[26]:60}${_spaceFim}${_edgeScreen}"

	for (( _y=27; _y<_heightScreen; _y++ )); do
		
		_canvas[$_y]="${_edgeScreen}${_spaceIni}${_menu[$_y]}${_spaceFim}${_edgeScreen}"

	done

}

function LoadColors {

	if [ $_color = "off" ]; then
		return
	fi

	
	_canvasC=(0)
	_canvasP=(0)

	_tmp=0

	((_tmp++))
	_canvasC[$_tmp]=${_cor[1]}
	_canvasP[$_tmp]=0

	((_tmp++))
	_canvasC[$_tmp]=${_cor[2]}
	_canvasP[$_tmp]=$((_width * 2))

	case $_screenGame in

	"MENU")
		_tmp2=${#_spaceIni}
		for ((_k=5; _k<18; _k++)); do
			((_tmp++))
			_canvasC[$_tmp]=${_cor[0]}
			_canvasP[$_tmp]=$(((_width * _k) + _tmp2 + 15))
			((_tmp++))
			_canvasC[$_tmp]=${_cor[2]}
			_canvasP[$_tmp]=$(((_width * _k) + _tmp2 + 65))
		done

		((_tmp++))
		_canvasC[$_tmp]=${_cor[3]}
		_canvasP[$_tmp]=$((_width * 37))
		;;

	"GAME"|"DEAD"|"WIN"|"WINPOINT") 
		((_tmp++))
		_canvasC[$_tmp]=${_cor[3]}
		_canvasP[$_tmp]=$((_width * 37))
		;;

	esac

	_canvasC[0]=$_tmp

}


function Drawplayer {

	
	_tmpJogX=$((_jogX - (_cameraX - _edgeWidth)))
	_tmpIni=1

	if [ $((_jogY + _jogHeight -1)) -gt 39 ]; then
		_tmpJogHeight=$(( 40 - _jogY ))
	elif [ $_jogY -lt 0 ]; then
		_tmpJogHeight=$(( _jogHeight + _jogY ))
		_tmpIni=$((-_jogY +1))
	else
		_tmpJogHeight=$_jogHeight
	fi

	
	for (( _l=_tmpIni; _l<=_tmpJogHeight; _l++ )); do

		
		_tmp="_mario${_jogSide}${_jogSprite}[$_l]"

		
		_tmp="${!_tmp}"

		
		_tmpf=$((_tmpJogX+${#_tmp}))

		
		
		_tmpJogY=$(( _jogY+_l-1))		
		_canvas[$_tmpJogY]="${_canvas[$_tmpJogY]:0:$_tmpJogX}${_tmp}${_canvas[$_tmpJogY]:$_tmpf}"

	done
}


function DrawScore {

	
	
	
	
	_tmp=0

	
	
	_canvas[0]="${_edgeScreen}${_spaceIni}${_scoreTitle0}${_spaceFim}${_edgeScreen}"

	_tmpScore=${#_score}
	_tmpScorei=$((11 - _tmpScore))

	_tmpCoin=${#_coins}
	_tmpCoini=$((21 - _tmpCoin))

	_tmpTime=${#_time}
	_tmpTimei=$(( 37 - _tmpTime ))

	((_tmp+=_width))
	_canvas[1]="${_edgeScreen}${_spaceIni}${_scoreTitle1:0:$_tmpScorei}${_score}${_scoreTitle1:11:${_tmpCoini}}${_coins}${_scoreTitle1:32:$_tmpTimei}${_time}${_scoreTitle1:69}${_spaceFim}${_edgeScreen}"

	
	_texto="[s]sound:$_sound [c]color:$_color LPS:$_lps"


	_l=${#_texto}

	
	_pos=$((39))
	_canvas[$_pos]="${_edgeScreen}${_texto}${_canvas[$_pos]:$((_l + _edgeWidth))}${_edgeScreen}"

}


function Render {
	
	
	case $_screenGame in
	
	"GAME"|"DEAD"|"WIN"|"WINPOINT")
		MontaCanvas;;

	"MENU")
		MontaMenu;;

	esac


	case $_screenGame in

		"SPLASH"|"GAMEOVER"|"GAMEWIN")
			DrawScore
			;;

		"MENU")
			DrawScore
			_temp=0
			;;

		"GAME"|"DEAD"|"WIN"|"WINPOINT")
			Drawhole
			DrawScore
			DrawCoin
			DrawEnemy
			DrawFlag
			Drawplayer
			;;

	esac

	_screen=""

	for (( _k=0; _k<_heightScreen; _k++ )); do
		_canvas[$_k]="${_canvas[$_k]:$_edgeWidth:$_width}"
		_screen+="${_canvas[$_k]}"
	done

	if [ $_color = "on" ]; then



		BubbleSort








				



		for (( _k=_canvasC[0]; _k>0; _k-- )); do
			_screen="${_screen:0:${_canvasP[$_k]}}${_canvasC[$_k]}${_screen:${_canvasP[$_k]}}"
		done
	fi

	
	echo -ne "$_screen" 

	tput cup $_initY 0

}

function QuickSort {

	local _ini=$1
	local _fim=$2
	local _pivo=${_canvasP[$(( (_ini + _fim ) / 2 ))]}

	while [ $_ini -lt $_fim ]; do

		while [ ${_canvasP[$_ini]} -lt $_pivo ]; do
			((_ini++))
		done

		while [ ${_canvasP[$_fim]} -gt $_pivo ]; do
			((_fim--))
		done

		if [ $_ini -le $_fim ]; then
			local _aux=${_canvasP[$_ini]}
			_canvasP[$_ini]=${_canvasP[$_fim]}
			_canvasP[$_fim]=$_aux

			local _aux=${_canvasC[$_ini]}
			_canvasC[$_ini]=${_canvasC[$_fim]}
			_canvasC[$_fim]=$_aux

			((_ini++))
			((_fim--))
		fi

		if [ $_fim -gt $1 ]; then
			QuickSort $1 $_fim
		fi

		if [ $_ini -lt $2 ]; then
			QuickSort $_ini $2
		fi
	done

}


function BubbleSort {

	for (( _k=(_canvasC[0]); _k>1; _k-- )); do

		for (( _l=1; _l<_k; _l++ )); do
			
			(( _tmp= _l + 1 ))


			if [ $((_canvasP[$_l])) -gt $((_canvasP[$_tmp])) ]; then

				_tmpV=${_canvasP[$_tmp]} 
				_canvasP[$_tmp]=${_canvasP[$_l]} 
				_canvasP[$_l]=$_tmpV

				_tmpC=${_canvasC[$_tmp]} 
				_canvasC[$_tmp]=${_canvasC[$_l]} 
				_canvasC[$_l]=$_tmpC

			fi

		done

	done

}


function DrawCoin {

	((_tmp1=_cameraX / _coinWidth))
	((_tmp2=(_cameraX + _width) / _coinWidth))

	for (( _k=_tmp1; _k<=_tmp2; _k++)); do

		_tmpCoin=${_coinQ[$_k]}


		if [ $_k -eq 0 ] || [ -z $_tmpCoin ]; then
			continue
		else

			_coinX=${_coin[$_tmpCoin]}

			if [ $_coinX -gt 0 ]; then

				((_coinX-=(_cameraX-_edgeWidth)))

				((_coinSprite[_tmpCoin]++))

				if [ ${_coinSprite[$_tmpCoin]} -eq 6 ]; then
					_coinSprite[$_tmpCoin]=0
				fi

				((_tmpSp=_coinSprite[_tmpCoin]/2))

				
				for (( _l=1; _l<=_coinHeight; _l++ )); do

					
					_tmpS="_coinDraw${_tmpSp}[$_l]"

					
					_tmpS="${!_tmpS}"

					
					_tmpf=$((_coinX + _coinWidth))

					
					_tmpCoinY=$(( _coinY[_tmpCoin] + _l -1))		

					_canvas[$_tmpCoinY]="${_canvas[$_tmpCoinY]:0:$_coinX}${_tmpS}${_canvas[$_tmpCoinY]:$_tmpf}"

					if [ $_color = "on" ]; then

						_tmp=${_canvasC[0]}
						((_tmp++))
						_canvasC[$_tmp]=${_cor[4]}

						if [ $((_coinX - _edgeWidth)) -lt 0 ]; then
							_canvasP[$_tmp]=$((_width * _tmpCoinY))
						else
							_canvasP[$_tmp]=$(( (_width * _tmpCoinY) + _coinX - _edgeWidth ))
						fi

						((_tmp++))
						_canvasC[$_tmp]=${_cor[2]}
						if [ $((_tmpf - _edgeWidth)) -gt $_width ]; then
							_canvasP[$_tmp]=$(( _width * (_tmpCoinY+1) ))
						else
							_canvasP[$_tmp]=$(( (_width * _tmpCoinY) + _tmpf - _edgeWidth ))
						fi

						_canvasC[0]=$_tmp

					fi

				done

			fi
		fi

	done

}


function DrawFlag {

	if [ $_flagX -lt $(( _cameraX + _width )) ]; then

		for (( _k=1; _k<=_flagDraw[0]; _k++ )); do

			
			_tmpL=${#_flagDraw[$_k]}
			_tmpY=$(( _flagY + _k -1 ))
			_tmpX=$(( _flagX - _cameraX + _edgeWidth ))
			_tmpF=$(( _tmpX + _tmpL ))


			
			_canvas[$_tmpY]="${_canvas[$_tmpY]:0:$_tmpX}${_flagDraw[$_k]}${_canvas[$_tmpY]:$_tmpF}"

		done

		
	
	fi

}


function DrawEnemy {

	_ubound=${_enemyX[0]}

	for (( _k=1; _k < _ubound; _k++ )); do

		
		if [ $((_enemyX[_k] + _enemyWidth)) -ge $_cameraX ] && [ ${_enemyX[$_k]} -le $((_cameraX + _width)) ] && [ ${_enemySprite[$_k]} -le 6 ]; then 

			_tmpY="_gompa${_enemySprite[$_k]}[0]"
			_tmpY="${!_tmpY}"

			
			_tmpEnemyY=$((_enemyY[_k]))
			_tmpEnemyX=$(( _enemyX[_k] - (_cameraX - _edgeWidth)))

			
			for (( _l=1; _l<=_tmpY; _l++ )); do

				_tmpE="_gompa${_enemySprite[$_k]}[$_l]"
				_tmpE="${!_tmpE}"

				
				_tmpL=${#_tmpE}
				_tmpf=$(( _tmpEnemyX + _tmpL ))

				
				_canvas[$_tmpEnemyY]="${_canvas[$_tmpEnemyY]:0:$_tmpEnemyX}${_tmpE}${_canvas[$_tmpEnemyY]:$_tmpf}"

				
				((_tmpEnemyY++))
			done
		fi
	done

}


function ListenKey {

	
	_key=$(dd bs=3 count=1 2>/dev/null)	



	





	
	case $_key in

	$KEY_ENTER)
		case $_screenGame in

		"MENU")
			InitGame;;

		esac
		;;


	$KEY_ESC)
		case $_screenGame in

		"MENU")
			get_out ;;

		"GAME")
			LoadMenu;;

		esac
		;;
	
	$KEY_UP)
		case $_screenGame in

		"GAME")
			
			
			if [ $_velocY -eq 0 ] && [ $((_jogY+_jogHeight)) -eq $((_floor)) ]; then
				Play "jump"
				
				((_velocY=-6))
			fi
			;;
		esac
		;;

	$KEY_RIGHT)
		case $_screenGame in

		"GAME")
			
			
			((_velocX=4))
			;;
		esac
		;;

	$KEY_LEFT)
		case $_screenGame in

		"GAME")
			
			
			((_velocX=-4))
			;;
		esac
		;;

	"s")
		if [ $_sound = "off" ] ; then
			_sound="on"

			if [ $_screenGame = "GAME" ]; then
				Play "background"
			fi
		else
			_sound="off"

			if [  $_musicId ]; then
				Stop $_musicId
			fi
		fi
		SaveSettings
		;;

	"c")
		if [ $_color = "on" ]; then		
			_color="off"
		else
			_color="on"
		fi
		SaveSettings
		ClearScreen
		;;

	esac

	
	
	
	
	
	
}


function FPS {
	
	((_quadros++))

	
	_tempo2N=$((10#`date +%N`))
	
	
	



		




	
	
	_tmp=$((_tempo2N-_tempoN))

	
	if [ $_tmp -lt 0 ]; then
		((_tmp+=1000000000))


		if [ $_quadroRender -gt 5 ]; then		
			
			_lps=$_quadros
			_fps=$_quadroRender

			
			_quadros=0

			_quadroRender=0


		fi

	fi

	
	if [ $_tmp -ge 100000000 ]; then
		((_quadroRender++))

		_tempoN=$_tempo2N
		_next=true

		TerminalSize

		case $_screenGame in

		"GAME")
	
			_time=$(( _timeGame - (( SECONDS - _timeIni )) ))

			if [ $_time -eq 30 ]; then
				if [ $_quadroRender -eq 5 ]; then
					Play "timewarning"
				fi

			elif [ $_time -eq 27 ]; then
				if [ $_quadroRender -eq 5 ]; then
					Play "background"
				fi

			elif [ $_time -eq 0 ]; then
	
				Dead "time"
				_velocY=-5
				_jogSprite=0
				_jogSide="F"

			fi
			;;
		esac

	fi
}



function player {

	case $_screenGame in

	"WINPOINT")
		if [ $_time -gt 0 ]; then
			Score 10
			((_time--))
			Play "point"
		else
			GameWin
		fi
		;;

	"WIN")

		
		if [ $_velocY -ne 0 ] || [ $((_jogY - 1 + _jogHeight)) -ne $((_floor - 1)) ]; then	

			_jogSprite="2"
			((_velocY+=_gravidade))
			((_jogY+=_velocY))
			((_flagY=_jogY))
			
			if [ $((_jogY - 1 + _jogHeight)) -ge $((_floor)) ]; then
				_jogAni=0
				_jogSprite="0"
				((_jogY=_floor - _jogHeight))
				_velocY=0
				Play "worldcleared"
			fi
		elif [ $_jogX -lt 2927 ]; then
			((_jogX++))
			
			((_jogAni++))

			if [ $_jogAni -eq 2 ]; then
				_jogSprite=0
				_jogAni=0
			else
				_jogSprite=1
			fi
		else
			_jogX=3001
			_screenGame="WINPOINT"
		fi
		;;

	"GAME"|"DEAD")
		if [ $_jogDead = true ]; then
			((_velocY+=_gravidade))
			((_jogY+=_velocY))
			if [ $_jogY -gt 50 ]; then
				if [ $_jogLife -eq 0 ]; then
					sleep 1
					GameOver
				else
					sleep 2
					Splash
				fi
			fi

			return
		fi

		
		if [ $_velocX -ne 0 ]; then	
			
			if [ $_velocX -gt 0 ]; then
				((_jogX+=4))
			else
				((_jogX-=4))
			fi
			if [ $_velocX -lt 0 ]; then

				_jogSide="E"

				
				if [ $_jogX -lt 0 ]; then
					_jogX=0
				fi
				
				
				if [ $_velocY -eq 0 ]; then
					((_velocX++))
				fi

			else
				
				_jogSide="D"

				
				if [ $_jogX -gt $((_sizephase - _jogWidth)) ]; then
					_jogX=$((_sizephase - _jogWidth))
				fi

				
				if [ $_velocY -eq 0 ]; then
					((_velocX--))
				fi


			fi
				
			
			((_jogAni++))

			if [ $_jogAni -eq 2 ]; then
				_jogSprite=0
				_jogAni=0
			else
				_jogSprite=1
			fi
		else
			_jogAni=0
			_jogSprite=0
		fi	

		
		if [ $_velocY -ne 0 ] || [ $((_jogY - 1 + _jogHeight)) -ne $((_floor - 1)) ]; then	

			_jogSprite="2"
			((_velocY+=_gravidade))
			((_jogY+=_velocY))

			#verifica se o personagem atravessou o floor
			if [ $((_jogY - 1 + _jogHeight)) -ge $((_floor)) ]; then
				_jogAni=0
				_jogSprite="0"

				Collisionhole
				if [ $? -eq 0 ]; then
					((_jogY=_floor - _jogHeight))
					_velocY=0
				fi

			fi
		else
			Collisionhole
	
		fi

	;;

	esac

	if [ $_screenGame = "GAME" ]; then
		
		
		if [ $_jogSide = "D" ]; then
			_tmp2=$(( _jogX / _blockWidth ))
			_tmp1=$(( ((_jogX+15)) / _blockWidth ))
		else
			_tmp1=$(( _jogX / _blockWidth ))
			_tmp2=$(( ((_jogX+15)) / _blockWidth ))
		fi

		Collisionblock $_tmp1
		if [ $? -eq 0 ]; then
			Collisionblock $_tmp2
		fi
		
		
		CollisionCoin $(( _jogX / _coinWidth ))
		CollisionCoin $(( ((_jogX + 8)) / _coinWidth ))
		CollisionCoin $(( ((_jogX + 15)) / _coinWidth ))

		CollisionEnemy
		CollisionMastro

	fi


}

function CollisionMastro {

	if [ $((_jogX + _jogWidth)) -gt 2880 ]; then

		_screenGame="WIN"
		Play "flagpole"
		_flagY=$_jogY		
		_velocY=0
		_tmp=$(( ((21 - $_jogY) * 330) + 50 ))

		_tmpL=${#_tmp}
		((_tmpL+=2))

		_flagDraw[4]="${_flagDraw[4]:0:2}$_tmp${_flagDraw[4]:$_tmpL}"		

		Score $_tmp
		_jogX=$(( 2883 - _jogWidth))
	fi

}


function CollisionEnemy {

	
	_ubound=${_enemyX[0]}

	for (( _k=1; _k<_ubound; _k++ )); do

		
		if [ ${_enemyPathIni[$_k]} -lt $((_cameraX + _width)) ] && [ ${_enemyPathFim[$_k]} -gt $_cameraX ] && [ ${_enemySprite[$_k]} -lt 3 ]; then 
			if [ $_jogX -gt $((_enemyX[_k] + _enemyWidth -1)) ]; then
				_tmp=0 

			elif [ $_jogY -gt $((_enemyY[_k] + _enemyHeight[_k] -1)) ]; then
				_tmp=0

			elif [ $((_jogX + _jogWidth -1)) -lt ${_enemyX[$_k]} ]; then
				_tmp=0

			elif [ $((_jogY + _jogHeight -1)) -lt ${_enemyY[$_k]} ]; then
				_tmp=0

			
			
			elif [ $((_jogY + _jogHeight -1 - _velocY)) -lt ${_enemyY[$_k]} ]; then
				Play "enemy"
				Score 100				
				_jogY=$((_enemyY[_k] - _jogHeight)) 
				_velocY=-3
				_enemySprite[$_k]=2
				_enemyDead[$_k]=1
				return 1
			else
				Dead "enemy"
				_velocY=-5
				_jogSprite=0
				if [ $_jogSide = "D" ]; then
					((_jogX=_enemyX[_k] - _jogWidth))
				else
					((_jogX=_enemyX[_k] + _enemyWidth))
				fi
				_jogSide="F"
				return 1
			fi

			
		fi
	done

}


function CollisionCoin {

	_tmpQ=$1

	_tmp=${_coinQ[$_tmpQ]}

	if [ $_tmpQ -eq 0 ] || [ -z $_tmp ]; then
		return
	fi

	_coinX=${_coin[$_tmp]}

	if [ $_coinX -gt 0 ]; then

		if [ $_jogX -gt $((_coinX + _coinWidth)) ]; then
			return 0
		fi

		if [ $((_jogY)) -gt $((_coinY[_tmp] + _coinHeight)) ]; then
			return 0
		fi

		if [ $((_jogX + 15)) -lt $_coinX ]; then
			return 0
		fi

		if [ $((_jogY+_jogHeight)) -lt ${_coinY[$_tmp]} ]; then
			return 0
		fi

		Play "coin"
		_coin[$_tmp]=0
		GetCoin

		_tmp2=$(( _coinX + _coinWidth ))







		return 1
	fi

}


function GetCoin {

	((_coins++))
	Score 200

	if [ $_coins -gt 99 ]; then

		((_coins-=100))
		Play "up"
		((_jogLife++))
	fi

}


function Collisionblock {

	_tmpQ=$1
	
	_tmp=${_blockQ[$_tmpQ]}

	if [ $_tmpQ -eq 0 ] || [ -z $_tmp ]; then
		return 0
	fi

	_blockX=${_block[$_tmp]}

	if [ $_blockX -gt 0 ]; then

		if [ $_jogX -gt $((_blockX -1 + _blockWidth)) ]; then
			return 0
		fi

		if [ $((_jogY)) -gt $((_blockY -1 + _blockHeight)) ]; then
			return 0
		fi

		if [ $((_jogX -1 + _jogWidth)) -lt $_blockX ]; then
			return 0
		fi

		if [ $((_jogY -1 + _jogHeight)) -lt $_blockY ]; then
			return 0
		fi

		
		
		if [ $((_jogY - _velocY)) -lt $((_blockY -1 + _blockHeight)) ]; then

			if [ $_jogSide = "D" ]; then
				_jogX=$((_blockX - 16))
			else
				_jogX=$((_blockX + _blockWidth))
			fi
			_velocX=0
			return 1

		fi

		Play "block"
		Score 50
		_block[$_tmp]=0
		_jogY=$((_blockY + _blockHeight))
		_velocY=$((- _velocY))


		_tmp2=$(( _blockX + _blockWidth ))

		for (( _k=_blockY; _k<_blockY+_blockHeight; _k++ )); do
			_phasel[$_k]="${_phasel[$_k]:0:$_blockX}${_blockClear}${_phasel[$_k]:$_tmp2}"
		done

		return 1
	fi

}


function Collisionhole {

	for (( _k=1; _k<_hole[0]; _k++ )); do

		_holeX=${_hole[$_k]}

		if [ $((_jogX + (_jogWidth/2))) -gt $((_holeX+2)) ] && [ $((_jogX + (_jogWidth/2))) -lt $((_holeX + 2 + _holeWidth )) ]; then

			_jogX=$((_holeX + 2 +(_holeWidth/2) - (_jogWidth/2) ))
			Dead "hole"

			return 1
		fi

	done
	return 0
}


function Dead {

	
	_screenGame="DEAD"

	((_jogLife--))
	
	if [ $_jogLife = 0 ]; then
		Play "gameover"
	else
		Play "die"
	fi	

	_jogDead=true

	((_velocY+=_gravidade))
}


function Stop {

	kill -9 $1 1 2>/dev/null

}



function Play {

	if [ $_sound = "off" ]; then
		return
	fi

	case $1 in

		"worldcleared")
			canberra-gtk-play --file="worldcleared.ogg" 1 2>/dev/null&
			;;

		"flagpole")
			if [ $_musicId ]; then
				Stop $_musicId
			fi
			canberra-gtk-play --file="flagpole.ogg" 1 2>/dev/null&
			;;

		"timewarning")
			if [ $_musicId ]; then
				Stop $_musicId
			fi
			canberra-gtk-play --file="timewarning.ogg" 1 2>/dev/null&
			;;

		"gameover")
			if [ $_musicId ]; then
				Stop $_musicId
			fi
			canberra-gtk-play --file="gameover.ogg" 1 2>/dev/null&
			;;

		"die")
			if [ $_musicId ]; then
				Stop $_musicId
			fi
			canberra-gtk-play --file="die.ogg" 1 2>/dev/null&
			;;

		"background")
			if [ $_musicId ]; then
				Stop $_musicId
			fi

			canberra-gtk-play -l 99 -V 0 --file="world1-1.ogg" 1 2>/dev/null & _musicId="$!"
			
			;;

		"jump")
			canberra-gtk-play --file="jump.ogg" 1 2>/dev/null&;;

		"block")
			canberra-gtk-play --file="brick.ogg" 1 2>/dev/null&;;

		"point")
			canberra-gtk-play --file="coin.ogg" 1 2>/dev/null&;;

		"coin")
			canberra-gtk-play --file="coin.ogg" 1 2>/dev/null&;;

		"up")
			canberra-gtk-play --file="up.ogg" 1 2>/dev/null&;;

		"enemy")
			canberra-gtk-play --file="stomp.ogg" 1 2>/dev/null&;;
	esac

}

function MoveEnemy {

	case $_screenGame in

	"GAME")

		
		_ubound=${_enemyX[0]}

		for (( _k=1; _k<_ubound; _k++ )); do

			
			if [ ${_enemyPathIni[$_k]} -lt $((_cameraX + _width)) ] && [ ${_enemyPathFim[$_k]} -gt $_cameraX ] && [ ${_enemySprite[$_k]} -lt 6 ]; then 

				

				
				case ${_enemySprite[$_k]} in
				0)
					ChangeSpriteEnemy $_k
					_enemySprite[$_k]=1
					_aniEnemy=1

					;;
				1)	
					ChangeSpriteEnemy $_k
					((_enemySprite[_k]+=_aniEnemy))
					;;
				2)
					if [ ${_enemyDead[$_k]} -eq 1 ]; then
						_enemySprite[$_k]=3
					else
						ChangeSpriteEnemy $_k
						_enemySprite[$_k]=1
						_aniEnemy=-1
					fi
					;;
				3)
					_enemySprite[$_k]=4;;
				4)
					_enemySprite[$_k]=5;;
				5)
					_enemySprite[$_k]=6;;
				esac 

			fi


			_enemyHeight[$_k]="_gompa${_enemySprite[$_k]}[0]"	
			_enemyHeight[$_k]=${!_enemyHeight[$_k]}
			_enemyY[$_k]=$((_floor - _enemyHeight[$_k]))

		done
		
	esac
}

function ChangeSpriteEnemy {

	_k=$1


		((_enemyX[_k]+=_enemyVelocX[_k]))

		if [ $(( _enemyX[_k] + enemyWidth )) -gt $(( _enemyPathFim[_k] )) ] || [ ${_enemyX[$_k]} -lt ${_enemyPathIni[$_k]} ]; then
			(( _enemyVelocX[_k]=-_enemyVelocX[_k] ))
		fi


		_aniEnemy[$_k]=0



}




. .settings


_scoreTitle0="     MARIO                                   WORLD               TIME           "
_scoreTitle1="     000000                 @x00              1-1                 000           "




_montDraw[0]=7
_montDraw[1]="              ████████              "
_montDraw[2]="          ████        ████          "
_montDraw[3]="        ██                ██        "
_montDraw[4]="      ██           ██ ░░░░  ██      "
_montDraw[5]="    ██           ██       ░░  ██    "
_montDraw[6]="  ██                        ░░  ██  "
_montDraw[7]="██                            ░░  ██"


 _menu[0]="                                                                                "
 _menu[1]="                                                                                "
 _menu[2]="                                                                                "
 _menu[3]="                                                                                "
 _menu[4]="                                                                                "
 _menu[5]="               @                                                @               "
 _menu[6]="                    ██   ██   ████   █████   ██████   ████                      "
 _menu[7]="                    ███ ███  ██  ██  ██  ██    ██    ██  ██                     "
 _menu[8]="                    ██ █ ██  ██████  █████     ██    ██  ██                     "
 _menu[9]="                    ██   ██  ██  ██  ██  ██    ██    ██  ██                     "
_menu[10]="                    ██   ██  ██  ██  ██  ██  ██████   ████                      "
_menu[11]="                                                                                "
_menu[12]="                     █████   █████    ████    ████                              "
_menu[13]="                     ██  ██  ██  ██  ██  ██  ██                                 "
_menu[14]="                     █████   █████   ██  ██   ████                              "
_menu[15]="                     ██  ██  ██  ██  ██  ██      ██  ██                         "
_menu[16]="                     █████   ██  ██   ████    ████   ██                         "
_menu[17]="               @                                                @               "
_menu[18]="                                           2012 FATEC CARAPICUIBA               "
_menu[19]="                                                                                "
_menu[20]="                                                                                "
_menu[21]="                                                                                "
_menu[22]="                                                                                "
_menu[23]="                    P R E S S   E N T E R   T O   S T A R T                     "
_menu[24]="                                                                                "
_menu[25]="                                                                                "
_menu[26]="                                TOP - 0000000000                                "
_menu[27]="                                                                                "
_menu[28]="                                                                                "
_menu[29]="                                                                                "
_menu[30]="              ████████                                                          "
_menu[31]="          ████        ████                              █     █     █           "
_menu[32]="        ██                ██                           █ █   █ █   █ █          "
_menu[33]="      ██           ██ ░░░░  ██                        █   █ █   █ █   █         "
_menu[34]="    ██           ██       ░░  ██                     █     █     █     █        "
_menu[35]="  ██                        ░░  ██                  █                   █       "
_menu[36]="██                            ░░  ██               █                     █      "
_menu[37]="░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░"
_menu[38]="█░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░█"
_menu[39]="░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░░░░░██░░░░"

_flagDraw[0]=7
_flagDraw[1]="████"
_flagDraw[2]="█   ████"
_flagDraw[3]="█       ███"
_flagDraw[4]="█          ███"
_flagDraw[5]="█       ███"
_flagDraw[6]="█   ████"
_flagDraw[7]="████"

_castle[0]=31
 _castle[1]="  @@@"
 _castle[2]=" @@@@@                           ___     ___     ___     __     ___     ___     ___"
 _castle[3]="  @@@                           |░░░|   |░░░|   |░░░|   |░░|   |░░░|   |░░░|   |░░░|"
 _castle[4]="  | |                           |░░░|   |░░░|   |░░░|   |░░|   |░░░|   |░░░|   |░░░|"
 _castle[5]="  | |                           |░░|░░░░|░░░░|░░░░|░░░░|░░░|░░░░|░░░░|░░░░|░░░░|░░░|"
 _castle[6]="  | |                           |░░░░|░░░░|░░░░|░░░░|░░░░|░░░|░░░░|░░░░|░░░░|░░░░|░|"
 _castle[7]="  | |                           |░░|░░░░|██████░░░|░░░░|░░░|░░░░|░░░░██████░░░░|░░░|"
 _castle[8]="  | |                           |░░░░|░░░██████|░░░░|░░░░|░░░|░░░░|░░██████░|░░░░|░|"
 _castle[9]="  | |                           |░░|░░░░|██████░░░|░░░░|░░░|░░░░|░░░░██████░░░░|░░░|"
_castle[10]="  | |                           |░░░░|░░░██████|░░░░|░░░░|░░░|░░░░|░░██████░|░░░░|░|"
_castle[11]="  | |                           |░░|░░░░|██████░░░|░░░░|░░░|░░░░|░░░░██████░░░░|░░░|"
_castle[12]="  | |                 __     ___|░░░░___░██████|░░░░░___░░░░___░░░░░_██████░___░░░░|___     __"
_castle[13]="  | |                |░░|   |░░░|░░░|░░░|███|░░░|░░░|░░░|░░|░░░|░░░|░░░|███|░░░|░░░|░░░|   |░░|"
_castle[14]="  | |                |░░|   |░░░|░░░|░░░|░░░|░░░|░░░|░░░|░░|░░░|░░░|░░░|░░░|░░░|░░░|░░░|   |░░|"
_castle[15]="  | |                |░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░|"
_castle[16]="  | |                |░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░|"
_castle[17]="  | |                |░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░████████░░|░░░░|░░░░|░░░░|░░░░░░|░░░░|░░|"
_castle[18]="  | |                |░|░░░░|░░░░|░░░░|░░░░|░░░░|░░░████████████░░░|░░░░|░░░░|░░░░|░░░░|░░░░|░|"
_castle[19]="  | |                |░░░|░░░░|░░░░|░░░░|░░░░|░░░░|██████████████░░░░|░░░░|░░░░|░░░░░░|░░░░|░░|"
_castle[20]="  | |                |░|░░░░|░░░░|░░░░|░░░░|░░░░|░████████████████░|░░░░|░░░░|░░░░|░░░░|░░░░|░|"
_castle[21]="  | |                |░░░|░░░░|░░░░|░░░░|░░░░|░░░██████████████████░░|░░░░|░░░░|░░░░|░░░░|░░░░|"
_castle[22]="  | |                |░|░░░░|░░░░|░░░░|░░░░|░░░░████████████████████░░░░|░░░░|░░░░|░░░░|░░░░|░|"
_castle[23]="  | |                |░░░|░░░░|░░░░|░░░░|░░░░|░░████████████████████░|░░░░|░░░░|░░░░|░░░░|░░░░|"
_castle[24]="  | |                |░|░░░░|░░░░|░░░░|░░░░|░░░░████████████████████░░░░|░░░░|░░░░|░░░░|░░░░|░|"
_castle[25]="  | |                |░░░|░░░░|░░░░|░░░░|░░░░|░░████████████████████░|░░░░|░░░░|░░░░|░░░░|░░░░|"
_castle[26]="  | |                |░|░░░░|░░░░|░░░░|░░░░|░░░░████████████████████░░░░|░░░░|░░░░|░░░░|░░░░|░|"
_castle[27]="  | |                |░░░|░░░░|░░░░|░░░░|░░░░|░░████████████████████░|░░░░|░░░░|░░░░|░░░░|░░░░|"
_castle[28]="  | |                |░|░░░░|░░░░|░░░░|░░░░|░░░░████████████████████░░░░|░░░░|░░░░|░░░░|░░░░|░|"
_castle[29]=" _| |_               |░░░|░░░░|░░░░|░░░░|░░░░|░░████████████████████░|░░░░|░░░░|░░░░|░░░░|░░░░|"
_castle[30]="|░░░░░|              |░|░░░░|░░░░|░░░░|░░░░|░░░░████████████████████░░░░|░░░░|░░░░|░░░░|░░░░|░|"
_castle[31]="|░░░░░|              |░░░|░░░░|░░░░|░░░░|░░░░|░░████████████████████░|░░░░|░░░░|░░░░|░░░░|░░░░|"

_marioD0[0]=16
 _marioD0[1]=""
 _marioD0[2]="   █████"
 _marioD0[3]='  █░░░░M███'
 _marioD0[4]=' █░░░░░░░░░█'
 _marioD0[5]=' ███  █ ███'
 _marioD0[6]='█  ██ █    █'
 _marioD0[7]='█  ██  █   █'
 _marioD0[8]=' ██   █████'
 _marioD0[9]='  ██     █'
_marioD0[10]=' █░░██░░█'
_marioD0[11]='█░░░░██░░█'
_marioD0[12]='█░░░░█████'
_marioD0[13]=' █   ██ ██'
_marioD0[14]=' █  ░░░███'
_marioD0[15]='  █░░░░░█'
_marioD0[16]='   █████'

_marioE0[0]=16
 _marioE0[1]=""
 _marioE0[2]='    █████'
 _marioE0[3]=' ███M░░░░█'
 _marioE0[4]='█░░░░░░░░░█'
 _marioE0[5]=' ███ █  ███'
 _marioE0[6]='█    █ ██  █'
 _marioE0[7]='█   █  ██  █'
 _marioE0[8]=' █████   ██'
 _marioE0[9]='  █     ██'
_marioE0[10]='   █░░██░░█'
_marioE0[11]='  █░░██░░░░█'
_marioE0[12]='  █████░░░░█'
_marioE0[13]='  ██ ██   █'
_marioE0[14]='  ███░░░  █'
_marioE0[15]='   █░░░░░█'
_marioE0[16]='    █████'

_marioD1[0]=16
 _marioD1[1]='     █████'
 _marioD1[2]='    █░░░░M███'
 _marioD1[3]='   █░░░░░░░░░█'
 _marioD1[4]='   ███  █ ███'
 _marioD1[5]='  █  ██ █    █'
 _marioD1[6]='  █  ██  █   █'
 _marioD1[7]='   ██   █████'
 _marioD1[8]='   ███     █'
 _marioD1[9]=' ██░░░██░░███'
_marioD1[10]='█  ░░░░██░░█░█'
_marioD1[11]='█   ░░██████░ █'
_marioD1[12]=' █  ████ ██ █ █'
_marioD1[13]='  █████████░░█'
_marioD1[14]=' █░░██████░░░█'
_marioD1[15]=' █░░░█  █░░░█'
_marioD1[16]='  ███    ███'

_marioE1[0]=16
 _marioE1[1]='     █████'
 _marioE1[2]='  ███M░░░░█'
 _marioE1[3]=' █░░░░░░░░░█'
 _marioE1[4]='  ███ █  ███'
 _marioE1[5]=' █    █ ██  █'
 _marioE1[6]=' █   █  ██  █'
 _marioE1[7]='  █████   ██'
 _marioE1[8]='   █     ███'
 _marioE1[9]='  ███░░██░░░██'
_marioE1[10]=' █░█░░██░░░░  █'
_marioE1[11]='█ ░██████░░   █'
_marioE1[12]='█ █ ██ ████  █'
_marioE1[13]=' █░░█████████'
_marioE1[14]=' █░░░██████░░█'
_marioE1[15]='  █░░░█  █░░░█'
_marioE1[16]='   ███    ███'

_marioF0[0]=16
 _marioF0[1]='    ███████'
 _marioF0[2]='  ██░░░M░░░██'
 _marioF0[3]=' █░░░░███░░░░█'
 _marioF0[4]='  ███████████'
 _marioF0[5]=' █   █   █   █'
 _marioF0[6]='██    ░░░    ██'
 _marioF0[7]=' █ █████████ █'
 _marioF0[8]='█ █   █░█   ██'
 _marioF0[9]='█  ██ █░█ ██  █'
_marioF0[10]=' █ █░█████░░ █ █'
_marioF0[11]='  █░░░░░░░░█████'
_marioF0[12]=' ████░░░░░█░░░█'
_marioF0[13]='█░░░░█░░░█░░░░█'
_marioF0[14]=' █░░░░█████░░░█'
_marioF0[15]='  █░░░█    ███'
_marioF0[16]='   ███'

_marioD2[0]=16
 _marioD2[1]='     █████  ███'
 _marioD2[2]='    █░░░░M██   █'
 _marioD2[3]='   █░░░░░░░░█  █'
 _marioD2[4]='   ███  █ ███░█'
 _marioD2[5]='  █  ██ █    ░█'
 _marioD2[6]='  █  ██  █   ░█'
 _marioD2[7]='   ██   ██████'
 _marioD2[8]='    ██      ░█'
 _marioD2[9]='  █░░░█░░░█░█'
_marioD2[10]=' ███░░░█░░░████'
_marioD2[11]='█   █░░█ ██ █░░█'
_marioD2[12]='█   █░██████░░░█'
_marioD2[13]=' █░█████████░░█'
_marioD2[14]='█░░░████████░░█'
_marioD2[15]='█░░██████   ██'
_marioD2[16]=' ██ ███'

_marioE2[0]=16
 _marioE2[1]=' ███  █████'
 _marioE2[2]='█   ██M░░░░█'
 _marioE2[3]='█  █░░░░░░░░█'
 _marioE2[4]=' █░███ █  ███'
 _marioE2[5]=' █░    █ ██  █'
 _marioE2[6]=' █░   █  ██  █'
 _marioE2[7]='  ██████   ██'
 _marioE2[8]='  █░      ██'
 _marioE2[9]='   █░█░░░█░░░█'
_marioE2[10]=' ████░░░█░░░███'
_marioE2[11]='█░░█ ██ █░░█   █'
_marioE2[12]='█░░░██████░█   █'
_marioE2[13]=' █░░█████████░█'
_marioE2[14]=' █░░████████░░░█'
_marioE2[15]='  ██   ██████░░█'
_marioE2[16]='         ███ ██'



_marioD00=13
 _marioD01="    █████"
 _marioD02='   █░░░░M███'
 _marioD03='  █░░░░░░░░░█'
 _marioD04='  ███  █ ███'
 _marioD05=' █  ██ █    █'
 _marioD06=' █  ██  █   █'
 _marioD07='  ██   █████'
 _marioD08='   ██     █'
 _marioD09='  █   ██ ██'
_marioD010='  █  ░░░███'
_marioD011='   █░░░░░█'
_marioD012='    █████'

_marioE00=13
 _marioE01='     █████'
 _marioE02='  ███M░░░░█'
 _marioE03=' █░░░░░░░░░█'
 _marioE04='  ███ █  ███'
 _marioE05=' █    █ ██  █'
 _marioE06=' █   █  ██  █'
 _marioE07='  █████   ██'
 _marioE08='   █     ██'
 _marioE09='   ██ ██   █'
_marioE010='   ███░░░  █'
_marioE011='    █░░░░░█'
_marioE012='     █████'

_marioD10=13
 _marioD11='     █████'
 _marioD12='    █░░░░M███'
 _marioD13='   █░░░░░░░░░█'
 _marioD14='   ███  █ ███'
 _marioD15='  █  ██ █    █'
 _marioD16='  █  ██  █   █'
 _marioD17='   ██   █████'
 _marioD18='   ███     █'
 _marioD19='  █ ████ ██ █'
_marioD110='  █████████░░█'
_marioD111=' █░░██████░░░█'
_marioD112=' █░░░█  █░░░█'
_marioD113='  ███    ███'

_marioE10=13
 _marioE11='     █████'
 _marioE12='  ███M░░░░█'
 _marioE13=' █░░░░░░░░░█'
 _marioE14='  ███ █  ███'
 _marioE15=' █    █ ██  █'
 _marioE16=' █   █  ██  █'
 _marioE17='  █████   ██'
 _marioE18='   █     ███'
 _marioE19='  █ ██ ████ █'
_marioE110=' █░░█████████'
_marioE111=' █░░░██████░░█'
_marioE112='  █░░░█  █░░░█'
_marioE113='   ███    ███'

_marioD20=13
 _marioD21='     █████  ███'
 _marioD22='    █░░░░M██   █'
 _marioD23='   █░░░░░░░░█  █'
 _marioD24='   ███  █ ███░█'
 _marioD25='  █  ██ █    ░█'
 _marioD26='  █  ██  █   ░█'
 _marioD27='   ██   ██████'
 _marioD28='    ██      ░█'
 _marioD29='   ██████░░░█'
_marioD210='  █████████░░█'
_marioD211=' █░░███████░░█'
_marioD212='█░░██████  ██'
_marioD213=' ██ ███'

_marioE20=13
 _marioE21=' ███  █████'
 _marioE22='█   ██M░░░░█'
 _marioE23='█  █░░░░░░░░█'
 _marioE24=' █░███ █  ███'
 _marioE25=' █░    █ ██  █'
 _marioE26=' █░   █  ██  █'
 _marioE27='  ██████   ██'
 _marioE28='  █░      ██'
 _marioE29='   █░░░██████'
_marioE210='  █░░█████████'
_marioE211='  █░░███████░░█'
_marioE212='   ██   █████░░█'
_marioE213='         ███ ██'

_gompa0[0]=10                                 
 _gompa0[1]="       ████"
 _gompa0[2]="   ██████████"
 _gompa0[3]="  ███ >████< █"
 _gompa0[4]=" ████ █ ██ █ ██"
 _gompa0[5]="█████   ██   ███"
 _gompa0[6]=" ██████████████"
 _gompa0[7]="  █████░░░░███"
 _gompa0[8]="  ███░░░░░░ "
 _gompa0[9]="  ████░░░░██"
_gompa0[10]="   ████░░██"

_gompa1[0]=10
 _gompa1[1]="      ████"
 _gompa1[2]="   ██████████"
 _gompa1[3]="  ██ >████< ██"
 _gompa1[4]=" ███ █ ██ █ ███"
 _gompa1[5]="████   ██   ████"
 _gompa1[6]=" ██████████████"
 _gompa1[7]="  ████░░░░████"
 _gompa1[8]="     ░░░░░░"
 _gompa1[9]="   ██░░░░░░██"
_gompa1[10]="    ██░░░░██"

_gompa2[0]=10
 _gompa2[1]="     ████"
 _gompa2[2]="   ██████████"
 _gompa2[3]="  █ >████< ███"
 _gompa2[4]=" ██ █ ██ █ ████"
 _gompa2[5]="███   ██   █████"
 _gompa2[6]=" ██████████████"
 _gompa2[7]="  ███░░░░████"
 _gompa2[8]="     ░░░░░░███"
 _gompa2[9]="    ██░░░░████"
_gompa2[10]="     ██░░████"

_gompa3[0]=8                                   
 _gompa3[1]="    ████████"
 _gompa3[2]=" ███ >████< ███"
 _gompa3[3]="████ █ ██ █ ████"
 _gompa3[4]="████   ██   ████"
 _gompa3[5]=" █████░░░░█████"
 _gompa3[6]="     ░░░░░░"
 _gompa3[7]="   ███░░░░███"
 _gompa3[8]="    ███░░███"

_gompa3[0]=5                                                                   
 _gompa3[1]="   ████████████"
 _gompa3[2]=" ████ >████< ████"
 _gompa3[3]="█████ █ ██ █ █████"
 _gompa3[4]="   ███░░░░░░███"
 _gompa3[5]="    ███░░░░███"
 
_gompa4[0]=3                                                                   
 _gompa4[1]="   ████████████"
 _gompa4[2]="█████ █ ██ █ █████"
 _gompa4[3]="    ███░░░░███"

_cloudDraw[0]=13
 _cloudDraw[1]="               ███████"
 _cloudDraw[2]="             ██       ██" 
 _cloudDraw[3]="           ██           ██"
 _cloudDraw[4]="          █     █   █  ░  █"
 _cloudDraw[5]="      ████      █   █   ░  ████"
 _cloudDraw[6]="   ███                  ░      ███"
 _cloudDraw[7]=" ██                          ░   █"
 _cloudDraw[8]=" █                          ░    █"
 _cloudDraw[9]=" ██   ░░░░            ░    ░░ ███"
_cloudDraw[10]="   ███   ░░░░     ░    ░░░░░  █"
_cloudDraw[11]="      ████  ░░░░░░  ██      ██"
_cloudDraw[12]="          ██      ██  ██████"
_cloudDraw[13]="            ██████"


_coinDraw0[0]=5
_coinDraw0[1]="    @@    "
_coinDraw0[2]="  @@  @@  "
_coinDraw0[3]=" @  @@  @ "
_coinDraw0[4]="  @@  @@  "
_coinDraw0[5]="    @@    "

_coinDrawC[1]=${_cor[4]}
_coinDrawC[2]=${_cor[4]}
_coinDrawC[3]=${_cor[4]}
_coinDrawC[4]=${_cor[4]}
_coinDrawC[5]=${_cor[4]}

_coinDraw1[0]=5
_coinDraw1[1]="    @@    "
_coinDraw1[2]="   @  @   "
_coinDraw1[3]="  @ @@ @  "
_coinDraw1[4]="   @  @   "
_coinDraw1[5]="    @@    "

_coinDraw2[0]=5
_coinDraw2[1]="    @@    "
_coinDraw2[2]="    @@    "
_coinDraw2[3]="    @@    "
_coinDraw2[4]="    @@    "
_coinDraw2[5]="    @@    "


_floor1='░░░░██░░░░'
_floor2='█░░░░░░░░█'

_holeDraw="██                         ██"


_blockDraw[0]="███████████████"
_blockDraw[1]="█░░░░░░░░░░░░░█"
_blockClear="               "



_terminal=$(stty -g)





stty -echo -icanon -icrnl min 0


tput civis


KEY_ENTER=$(printf '\x0d')
KEY_BACKSPACE=$(printf '\x08')
KEY_ESC=$(printf '\x1b')
KEY_UP=$(echo -ne '\e[A')
KEY_LEFT=$(echo -ne '\e[D')
KEY_RIGHT=$(echo -ne '\e[C')
KEY_DOWN=$(echo -ne '\e[B')

if [ $TERM = "linux" ]; then
	_cor[0]="\E[00;37;41m"
	_cor[1]="\E[00;37;46m"
	_cor[2]="\E[00;30;46m"
	_cor[3]="\E[00;31;42m"
	_cor[4]="\E[00;33;46m"
	_cor[5]="\E[00;36;46m"
else
	_cor[0]="\E[01;37;41m"
	_cor[1]="\E[01;37;46m"
	_cor[2]="\E[02;30;46m"
	_cor[3]="\E[02;31;42m"
	_cor[4]="\E[01;33;46m"
	_cor[5]="\E[00;36;46m"
fi


_heightScreen=40
_widthScreen=80



_tempoN=0
_tempo2N=0


_next=false


_cameraX=0


_sizephase=0











_edgeWidth=30
_edgeScreen=`printf "%${_edgeWidth}s"`

_width=0
_height=0

TerminalSize

_score=0
_coins=0
_world="1-1"
_timeGame=300
_timeIni=0
_time=0


LoadMenu

_jogAni=0

_jogSprite=0


_jogSide="D"

_jogHeight=16
_jogWidth=16


_jogX=0
_jogY=0
_velocY=0
_velocX=0


_jogDead=false


_jogLife=0


_screenGame="MENU"


_gravidade=1


_floor=37


_quadroRender=0
_quadros=0
_lps=0
_fps=0


_clearBuffer=false




if [ $_height -lt $_heightScreen ] || [ $_width -lt $_widthScreen ]; then
	_erro="Terminal must be at least $_heightScreen lines x $_widthScreen columns!\nEncountered $_height lines x $_width columns."
	get_out
fi

ClearScreen

tput cup $(( _initY + 12 )) 0

 echo "$_spaceIni    			Developed by Shreyas,Nihar,Siddhant,Ritvik				                      "


read -n1

ClearScreen





_tempoN=$((10#`date +%N`))





while true; do

	FPS
	
	
	ListenKey

	if [ $_next = true ]; then
		LoadColors

		MoveEnemy

		player

		Render
	fi

	_next=false

done

