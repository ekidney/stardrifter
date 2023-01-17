
100print"loading data"
102gosub12000
104goto810

!-return from exploring check which scene and go there

110ifxp=1orxc=1thenreturn
120onscgoto1140,2005,2105,2220,2220

!-start game by clearing screen and playing sound

810print"{clear}":poke36878,10:poke36879,10
820forT=210to254
830poke36874,T
850forD=1to2
860nextD:nextT
870poke36878,0
880poke36874,0

!-(d)ay c)olonists (h)ab (l)food (lc)launch count (ox)ygen (fu)el
!-(w)ater (p)ower (s)ci-labs (r)overs (m)aterials (te)ch(micros) dr(o)nes
!- sol(a)r (b)atteries (g)ardens (f)orge sabat(i)er or(e) (mm)ars mapped

1000D=234:lc=0:X=rnd(-TI):ox=50:fu=50:fl=0
1002H=40+int(rnd(1)*60):L=40+int(rnd(1)*60):W=40+int(rnd(1)*60):P=40+int(rnd(1)*60):S=3:R=1
1005M=34:te=12:O=3:A=23:B=32:G=10:F=4:I=5:e=0:mm=1

!-hab rate, food rate, water, powerloss rate, colonist death rate

1006hr=1:lr=1:wr=1:pt=-1

!-pl = hab power / ps = food power / pu = water power / q=daytime / mt=maxtime / la=launchbool?
!-pw=power state / dn=day/night / mt=time rate(increase 4 difficulty)

1010pl=25:ps=25:pu=50:sc=1:uc=200:q=0:mt=100:la=0:pw=1

!-n$ = newsfeed

1015n$="welcome commander":pz=p
1025gosub1138

!-update loop 121E(4638)
!-sys4609 updating and rendering guages

1050sys(4609)
1058nb$=n$

!- insert for debug ?"{home}{space*3}{left*3}";kb;"";q

!-buffer vitals = power/water/food/habitat

1065gosub1125:sys(4609)

!-process changes

1070gosub2500:sys(4609)

!-BG tasks

1080gosub2600

!-update vital graph if changed

1081gosub1110

!-check if a key has been pressed

toDOneededprint
1083ifkb<>peek(197)thengosub1090

!-check if there's a new message, if so go and display it, key check, loop update

1084ifn$<>nb$thengosub1130
1085gosub1090
1086goto1050

toDOdotheyneedtobefunctionsprint
!-update functions: if key was pressed, goto input / if vitals changed then update / buffer vitals

1090getkc$:ifkc$<>""thenpoke36878,15:poke36876,230:poke36876,0:gosub2260
1100return
1110ifint(p)<>qpokeRint(h)<>qhorint(w)<>qworint(l)<>qlthengosub2150
1120return
1125qp=int(p):qh=int(h):qw=int(w):ql=int(l):return

!-update news

1130print"{home}{down*17}{cm +*20}{left*20}";n$;:return

!-scene 1: monitor

1138sc=1
1140print"{clear}{white}{141}  gov.2121{141}  systems online{141}{141}"
1150print"{141}  i:inventory{141}{141}  a:activities"
1160gosub1130:gosub2130
1180return

!-2.activities menu

2000sc=2
2005print"{clear}{white}{141}activities{141}{141}1 mine for ore & ice{141}2 repair habitat{141}3 process ore{141}4 harvest food{141}"
2010print"5 launch{141}6 build{141}7 divert power{141}8 monitor{141}{blue}9 explore{white}{141}"
2020gosub1130:gosub2130:return

!-/3. build menu

2100sc=3
2105print"{clear} resin";tab(15);"{cm +}";m;"{141} tech";tab(15);"X";te;"{141}"
2106print"    {purple}cost";tab(15);"{cm +}   X"
2107forzx=0to8:print"{white}{141}{reverse on}"zx+1"{reverse off}"b$(zx+10);tab(14);"{purple}"b%(zx*2);tab(18);b%((zx*2)+1)"{white}";
2110nextzx
2115print"{141}"

!-display guages tags

2130print"{home}{down*19}{yellow}habi{141}{green}food{141}{blue}water{141}{cyan}power";
2138ifsc=4thenprint"{home}{down*3}{right*7}fff";fl
2140return

!-have a look in vitals, kill player if level is below 3 decimal (<1%)

2150ifpeek(4634)<3orpeek(4635)<3orpeek(4636)<3orpeek(4637)<3thengosub11000:rem if p<1 OR l<1 OR w<1 OR p<1 then gosub 11000: rem death by zero

!-keep vitals from moving over 100%

2151ifp>100thenp=100
2152ifh>100thenh=100
2153ifl>100thenl=100
2154ifw>100thenw=100

!-keep vitals from going into negative

2164ifp<0thenp=0
2174ifh<0thenh=0
2180ifl<0thenl=0
2182ifw<0thenw=0

!-convert vitals to decimal and store in memory addresses determined by asm routines

2185kc=peek(197):poke14138,int(h/100*255):poke14139,int(l/100*255):poke14140,int(w/100*255):poke14141,int(p/100*255)
2190kc=peek(197):sys(4609):return

!-4. power menu

2210sc=4
2215print"{clear}{141}sabatier plant{141}{141}";"fuel:";fl;"{141}produce:{141}1.rocket fuel:"fu"%{141}2.oxygen:"ox"%"
2217print"{141}hit 1 to change{141}power state"
2218gosub2130
2219return

!- 5. inventory

2220print"{clear}{141} materials";tab(15);"{cm +}";m;"{141} tech";tab(16);"X";t;"{141}"
2230forjj=0to8:printb$(10+jj);tab(16);ws(jj*4):nextjj
2240gosub2130:return

!- intepret input
!- first combine sc number and input into a string for checking

2260a$=str$(sc)+kc$
2280ifa$=" 11"thengosub2000
2282ifa$=" 21"thengosub3000
2285ifa$=" 22"thengosub3300
2288ifa$=" 23"thengosub3600
2290ifa$=" 24"thengosub3700
2300ifa$=" 25"thengosub4000
2310ifa$=" 26"thengosub2100
2320ifa$=" 27"thengosub2210
2325ifa$=" 28"thengosub1138
2328ifa$=" 29"thengosub4200
2338ifa$=" 31"thenbm=0:gosub5000
2348ifa$=" 32"thenbm=1:gosub5000
2358ifa$=" 33"thenbm=2:gosub5000
2364ifa$=" 34"thenbm=3:gosub5000
2367ifa$=" 35"thenbm=4:gosub5000
2368ifa$=" 36"thenbm=5:gosub5000
2370ifa$=" 37"thenbm=6:gosub5000
2380ifa$=" 38"thenbm=7:gosub5000
2390ifa$=" 39"thenbm=8:gosub5000
2395ifa$=" 41"thengosub5500
2400ifkc$="a"thengosub2000
2410ifkc$="i"thengosub2220
2490return

!- process changes

2500q=q+1:ifq>mtthengosub2544

!- check for event - change 0.001 to a higher number for more likely events

2518ifrnd(1)<.001thengosub9000

!- check keybuffer

2522kc=peek(197)

!- deplete vitals based on depletion rates. play with this for balanced gameplay

2526pz=(pz+(pt/50)):h=h-abs(hr*(pl/(250-ox))):w=w-abs(wr*(pu/250)):l=l-abs(lr*(ps/250)):kc=peek(197)
2527fl=fl+(1*(fu/25))
2529return

!- add a day, warn user of low vitals.

2544d=d+1:q=0:p=p+int((a+b)*0.03)
2552ifh<10orl<10orw<10orp<10thenn$="vitals low!":gosub2130
2560return

!-
!- process background activity i.e building things
!-

!- cycle through all items to check progress - 7 sets of 4 paramters

2600forx=0to7:xq=x*4

!- if item is building, remove time left, check if items are finished

2620ifws(xq+3)=1thenws(xq+2)=(ws(xq+2))-1:gosub2700
2625kc=peek(197)
2630nextx
2640return
2700ifws(xq+2)=0andws(xq+3)=1thenws(xq)=ws(xq)+1:ws(xq+3)=0:gosub2800
2710return
2800n$="built "+b$(10+x):gosub7000
2810gosub120:return

!- mine

3000ifr<2thenn$="2 rovers needed":goto3018
3010q=q+10:w=w-2:p=p-5:x=int(rnd(1)*6)
3012ifrnd(1)<0.5thene=e+x:n$=str$(x)+"t ore mined":goto3018
3015n$=str$(x)+"t ice mined":w=w+(x*10)
3018gosub2130
3020return

!- repair

3300q=q+20:w=w-2:p=p-5:x=int(rnd(1)*10):h=h+x:ifh>100thenh=100
3320n$="hab now"+str$(h)+"%"
3325gosub2130
3330return

!- process

3600ife<1thengoto3645
3610q=q+10:w=w-3:p=p-5:m=m+int(e/2):e=0
3620n$=str$(m)+"x new resin"
3625gosub2130
3635return
3645n$="no ore to process":goto3625

!- harvest

3700q=q+10:w=w-5:x=int(rnd(1)*10):l=l+x
3715n$="food now"+str$(l)+"%"
3718gosub2130
3720return

!- launch

4000ifla=0thengoto4180
4015ifp>50thenn$="need more power"
4020n$="launching..."
4030gosub7000:gosub120
4170return
4180n$="no ship!":gosub2130
4190return

!- explore

4200tt=mt:mt=20:xp=0:xc=1:fx=1:sx=15
4202poke36878,10:poke36877,180
4205ex$="setting out"
4210print"{clear}exploring...{141}{141}"mm"% mars mapped{141}{141}";ex$;"!{return}{return}press any key to{return}return to base"
4225b=peek(197)
4228gosub1125
4230gosub2500
4235gosub2130
4236gosub4500:rem do sfx
4238ifxp=1thenxp=0:goto4202
4240ifrnd(1)<0.05thenmm=mm+0.2:onint(rnd(1)*10)goto4310,4320,4330,4340,4350,4360,4370,4380,4390,4400
4250a=peek(197)
4255ifa<>bthenmt=tt:gosub2000:poke36877,0:xp=0:xc=0:return
4265gosub1110
4300goto4225
4310ex$="found water":w=w+10:goto4210
4320ex$="colony established":c=c+100:goto4210
4330ex$="beautiful caves":goto4210
4340ex$="ancient structure":goto4210
4350ex$="invasive species":c=c-20:goto4210
4360ex$="curious dust":goto4210
4370ex$="more rocks":goto4210
4380ex$="mountain":goto4210
4390ex$="endless plain":goto4210
4400ex$="unpassable ridge":goto4210
4500iffx=0thensx=sx+1
4510iffx=1thensx=sx-1
4520ifsx=13andfx=0thenfx=1
4530ifsx=4andfx=1thenfx=0
4540poke36878,sx
4550return

!- building (bm= item to build)

5000mc=b%(bm*2):tc=b%((bm*2)+1)
5018ifws((bm*4)+3)=1thenn$="in progress":goto5034
5020ifmc>mandtc>tthenn$="under resourced"
5025ifmc>mthenn$="need more mat."
5028iftc>tethenn$="need more tech"
!- if enough resources, then build
5029ifmc<=mandtc<=tethengosub5040
5034gosub2130:return
5040n$="building "+b$(10+bm)+str$(bm)
5050m=m-mc:te=te-tc
!- go to experimental building
5051gosub5200
!- build the thing
5052onbm+1gosub5070,5080,5090,5100,5110,5120,5130,5140,5150
5055gosub2500:gosub2100
5060return
5070o=o+1:return
5080r=r+1:return
5090a=a+1:return
5100b=b+1:return
5110g=g+1:return
5120f=f+1:return
5130i=i+1:return
5140te=te+1:return
5150H=H+20:return
5200ws((bm*4)+1)=ws((bm*4)+1)+1
5205ws((bm*4)+3)=1
!- timeTaken 20 for all objects (temp)
5210ws((bm*4)+2)=20
5220return

!- sabatier (unfinished)

5500pw=pw+1
5520ifpw>5thenpw=1
5530ifpw=1thenfu=100:ox=0:hr=hr+2
5540ifpw=2thenfu=75:ox=25:hr=hr+1
5550ifpw=3thenfu=25:ox=75
5560ifpw=4thenfu=0:ox=100:hr=hr-1
5562ifpw=5thenfu=0:ox=0:hr=hr-2
5565gosub2210
5570return

!- when bad things happen play sound, display news, shake screen

6000print"{clear}"
6060forxx=15to0step-1
6070gosub6130:print"{red}"n$
6080next
6090poke36865,38:poke36864,12:poke36878,0
6100poke36874,0:poke36875,0:poke36877,0
6105poke36879,10:formx=0to1000:next
6110gosub120:return
6130poke36878,xx:poke36877,200+xx*rnd(1)
6140poke36874,129:poke36875,190+xx
6150poke36865,38+4*(4*rnd(l)-2)
6160poke36864,12+2*(2*rnd(l)-2)
6170ifxx=15thenpoke36879,112:formx=0to100:next
6180poke36879,27
6190return

!- when GOOD things happen play sound, show news

7000print"{clear}"
7015print"{white}"n$
7020poke36878,15
7030forfx=4to0step-1:poke36878,fx
7040forfy=1to100:next
7050forfz=220to240:poke36876,fz:next:next
7060poke36876,0
7070poke36878,0
7100return

!- random events

9000x=int(rnd(1)*10)
9015ifx=0thenhr=hr+3:h=h-1:c=c-20:a=a-2:b=b-2
9025ifx=1thenwr=wr+3:g=g-1:cr=cr+20
9035ifx=2thenpt=pt+3
9045ifx=3thenpt=pt-1:c=c-5
9055ifx=4thenwr=wr-3:c=c+100:cr=cr-20
9065ifx=5thenhr=hr-3:cr=cr-10
9075ifx=6thenc=c-20
9085ifx=7thenc=c-5:p=p-2:r=r-1
9095ifx=8thenc=c-20
9098ifx=9andla>1thenreturn
9102ifx=9thenm=m+20:w=w+20:t=t+20:c=c+100:la=la+1
9110n$=b$(x)
9115ifx>5thengosub7000:goto9120
9118gosub6000
9120gosub110:q=q+1000:xp=1:return


!- landing

9200print"{clear}{down}{down}      {white}."
9210print"  ."
9220print"{down}    ."
9230print"                ."
9240print"."
9260print"    .             ."
9270print"               ."
9280print"{down}"
9300print"{red}{168}{169} {168}{169} {168}{40}{40}{40}{168}{169}{168}{169}{169}{168}{40}{169}  {168}{169}";
9310poke36878,10:poke36877,180
9320print"{home}{white}"tab(5);
9330forxx=0to10:za=(xx*xx*10):zb=(xx+1)*(xx+1)*10
9340forx=0to3
9350printchr$(al(x));"{left}";"{down}";chr$(al(4+x));"{left}{up}";
9360z=za+((zb-za)*(x/4))
9370fora=0toz:nexta
9380nextx
9390print"{up} {down}{left} {down}{left}";
9400nextxx:printchr$(91);
9410poke36878,0:poke36877,0
9420return

!- end state

11000poke36877,0:print"{clear}the colony survived{141}"d-234"days."
11002print"yet without ";
11005ifp<1thenprint"power";
11006ifw<1thenprint"water";
11007ifl<1thenprint"food";
11008ifh<1thenprint"habitat"
11010print"it perished"
11015print"{141}hit a key to try again"
11020a=peek(197)
11025ifpeek(197)<>athenclr:gosub12005:goto820
11028forx=0to3:poke4634+x,128:next
11030goto11025



!- poke in new characters and asm

12000 rem this was where we poked in char&asm

!- we no longer need char and asm code so now assign variables
12005data"fire storm!","disease!","dust storm!","riot","disappearances","rover crash!"
12010data"med. discovery!","tech discovery!","celebration!","supplies!"
12020data"drone","rover","solar panels","batteries"
12030data"growspace","forge","sab plant","tech","habitat"
12040dimb$(19)

!- strings: first 10 are random events, rest are buildable objects

12060forx=0to18:readb$(x):nextx

!- ints below for each inventory item [(begin amount, material cost, tech cost),(),.]

12080data2,1,1,5,5,1,1,1,1,2,0,0,0,2,1,0,30,3,0,2,1,0,1,1
12090dimb%(23)
12100forx=0to23:readb%(x):next

!- below for each buildable item [(number of, time remaining ,isBuilding?),(),.]

12120data3,0,0,0,0,0,0,0,23,0,0,0,32,0,0,0,10,0,0,0,4,0,0,0,5,0,0,0,12,0,0,0,2,0,0,0
12130dimws(35)
12140forx=0to35:readws(x):next
12150dimba$(7)

!- below are characters for guages

12170forx=0to7:readba$(x):next
12180data" ","{cm g}","{cm h}","{cm j}","{cm k}","{reverse on}{cm l}{reverse off}","{reverse on}{cm n}{reverse off}","{reverse on}{cm m}{reverse off}"

!- finish data entry

!-where the spaceship frames are
13007forx=0to7:readal(x):next
14280data91,92,93,94,32,95,60,33
15000return



