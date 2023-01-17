
100clr:print"loading data"

!-(d)ay c)olonists (h)ab (l)food (lc)launch count (ox)ygen (fu)el production (fl)fuel
!-(w)ater (p)ower (s)ci-labs (r)overs (m)aterials (te)ch(micros) dr(o)nes
!- sol(a)r (b)atteries (g)ardens (f)orge sabat(i)er or(e) (mm)ars mapped (np)newplanet (sd)spaceship direction

101pn=0:S=3:R=1:M=34:te=12:O=3:A=23:B=32:G=10:F=4:I=5:e=2:D=0:lc=0:X=rnd(-TI):ox=50:fu=50:fl=2000:np=0:sd=0:mc=189
102gosub12000
103gosub11200:gosub9200
104goto817

!-return from exploring check which scene and go there

110ifxp=1orxc=1thenreturn
120onscgoto2000,2005,2105,2220,2220

!- clearing screen and playing sound

817print"{clear}":poke36878,10:poke36879,10
820forT=210to254
830poke36874,T
850forD=1to2
860nextD:nextT
870poke36878,0
880poke36874,0

TODO align with planet descriptions
1002gosub11300

!-hab rate, food rate, water, powerloss rate, colonist death rate

1006hr=1:lr=1:wr=1:ps=-1

!-pl = hab power / ps = food power / pu = water power / q=daytime / mt=maxtime / la=launchbool?
!-pw=power state / dn=day/night / mt=time rate(100: normal, increase 4 difficulty)

1010pl=25:ps=25:pu=50:sc=2:uc=200:q=0:mt=10:la=1:pw=1

!-n$ = newsfeed

1015n$(0)="welcome to":n$(1)=pl$:n$(2)="commander":pz=p
1025gosub2000

!-update loop 121E(4638)
!-sys4609 updating and rendering guages

!-1030 gosub4000
!-1035 pn=pn+1:lt=6
!-1040 gosub 4025
!-1045 goto1030

1050sys(4609)
1058nb$=n$(0)

!-
!-?"{home}{space*20}{left*20}";peek(50);peek(49);peek(52);peek(51)

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

1084ifn$(0)<>nb$thengosub1130
1085gosub1090
1086goto1050

toDOdotheyneedtobefunctionsprint
!-update functions: if key was pressed, goto input / if vitals changed then update / buffer vitals

1090kc$="":getkc$:ifkc$<>""thenpoke36878,15:poke36876,230:poke36876,0:gosub2260
1100return
1110ifint(p)<>qporint(h)<>qhorint(w)<>qworint(l)<>qlthengosub2150
1115ifsc=4thenprint"{home}{down*3}{right*5}";fl
1120return
1125qp=int(p):qh=int(h):qw=int(w):ql=int(l):return

!-update news

toDOmakesureoktoremove
1130goto2000

!-2.activities menu

2000sc=2
2002ifn$(0)=""thenn$(0)="we await your":n$(1)="instructions..."
2004?"{clear}";:gosub2005:goto2093

2005print"{white}{126}-------------------->";
2010print"/                    /";
2020print"/                    /";
2030print"/                    /";
2040print"{127}------------------{125}-?";
2050print"                   ";chr$(al(pt(1)+9))+chr$(34+pt(0));
2060print"{down}{left}";chr$(al(pt(2)+9))+chr$(192+pt(1));
2070print"{down}{left}";chr$(202+pt(2));
2080sh=int(pt(3)/2)
2090print"{down}{left*2}";chr$(al(pt(0)+9))+chr$(162+sh)+chr$(211+int((pt(0)+pt(1))/2))+chr$(168+sh)
2091print"{white}{home}{down}{right}";n$(0);"{home}{down*2}{right}";n$(1)
2092print"{home}{down*3}{right}";n$(2);::return


2093print"{home}{white}{down*7}{blue}p{white}rocess ore{141}{blue}h{white}arvest food{141}";
2094print"{blue}l{white}aunch{141}{blue}b{white}uild{141}{blue}d{white}ivert power{141}";
2095print"{blue}i{white}nventory{141}{blue}m{white}ine{141}{blue}r{white}epair habitat{141}{blue}e{white}xplore"
2097forx=0to2:n$(x)="":next
2099gosub2130:return

!-/3. build menu

2100sc=3
2105print"{clear} resin";tab(15);"{178}";m;"{141} tech";tab(15);"{177}";te;"{141}"
2106print"    {purple}cost";tab(15);"{178}   {177}"
2107forzx=0to8:print"{white}{141}";zx+1;" ";b$(zx+40);tab(14);"{purple}"b%(zx*2);tab(18);b%((zx*2)+1)"{white}";
2110nextzx
2115print"{141}"

!-display guages tags

2130print"{home}{down*19}{yellow}habi{141}{green}food{141}{blue}water{141}{cyan}power";
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

2185kc=peek(197):poke4638,int(h/100*255):poke4639,int(l/100*255):poke4640,int(w/100*255):poke4641,int(p/100*255)
2190kc=peek(197):sys(4609):return

!-4. power menu

2210sc=4
2215print"{clear}{141}{yellow}@@@@@{white}power plant{white}@@@@@@{141}";"fuel:     tons{141}{141}assign power:{141}{141} 1.ship fuel:{yellow}":printfu;"percent power{141}{141}{white} 2.habitat:{yellow}":printox;"percent power"
2216print"{141}{white}press space to change{141}     power state"
2217print"{141}{yellow}@@@@@@@@@@@@@@@@@@@@@@{white}"
2218gosub2130
2219return

!- 5. inventory

2220print"{clear}{141} resin";tab(16);"{178}";m;"{141} tech";tab(16);"{177}";t;"{141}"
2230forjj=0to8:printb$(40+jj);tab(16);ws(jj*4):nextjj
2240gosub2130:return

!- intepret input
!- first combine sc number and input into a string for checking

2260a$=str$(sc)+kc$
2270ifsc=6thengosub4020:ifnp=1thennp=0:gosub11300:sd=1:gosub9200:gosub2000
2280ifa$=" 1a"thengosub2000
2282ifa$=" 2m"thengosub3000
2285ifa$=" 2r"thengosub3300
2288ifa$=" 2p"thengosub3600
2290ifa$=" 2h"thengosub3700
2300ifa$=" 2l"thengosub4000
2310ifa$=" 2b"thengosub2100
2320ifa$=" 2d"thengosub2210
2325ifa$=" 2i"thengosub2220
2328ifa$=" 2e"thengosub4200
2338ifa$=" 31"thenbm=0:gosub5000
2348ifa$=" 32"thenbm=1:gosub5000
2358ifa$=" 33"thenbm=2:gosub5000
2364ifa$=" 34"thenbm=3:gosub5000
2367ifa$=" 35"thenbm=4:gosub5000
2368ifa$=" 36"thenbm=5:gosub5000
2370ifa$=" 37"thenbm=6:gosub5000
2380ifa$=" 38"thenbm=7:gosub5000
2390ifa$=" 39"thenbm=8:gosub5000
2395ifa$=" 4 "thengosub5500
2400ifkc$="a"thengosub2000
2410ifkc$="i"thengosub2220
2490return

!- ****************process changes***************************

2500q=q+1:ifq>mtthengosub2544

!- check for event - change 0.001 to a higher number for more likely events

2518ifrnd(1)<.001thengosub9000

!- check keybuffer

2522kc=peek(197)

!- deplete vitals based on depletion rates. play with this for balanced gameplay

2526pz=(pz+(ps/50)):h=h-abs(hr*(pl/(250-ox))):w=w-abs(wr*(pu/250)):l=l-abs(lr*(ps/250)):kc=peek(197)

!- Check fuel production
2527fl=int(fl+(fu/100))
2534iffl>1000andla=0thenla=1:n$(0)="enough fuel for":n$(1)="launch has been":n$(2)="manufactured":gosub2000
2540return

!- add a day, warn user of low vitals.

2544d=d+1:q=0:p=p+int((a+b)*0.03)
2552ifh<10orl<10orw<10orp<10thenn$(0)="vitals low!":gosub2130
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
2800n$(0)="built "+b$(40+x):gosub7000
2810gosub120:return

!- **********************************************************


!- mine

3000ifr<2thenn$(0)="2 rovers needed":goto3018
3010q=q+10:w=w-2:p=p-5:x=int(rnd(1)*6)
3012ifrnd(1)<0.5thene=e+x:n$(0)=str$(x)+"t ore mined":goto3018
3015n$(0)=str$(x)+"t ice mined":w=w+(x*10)
3018gosub2130
3020return

!- repair

3300q=q+20:w=w-2:p=p-5:x=int(rnd(1)*10):h=h+x:ifh>100thenh=100
3320n$(0)="hab now"+str$(h)+"%"
3325gosub2130
3330return

!- process ore

3600ife<1thengoto3645
3610q=q+10:w=w-3:p=p-5:m=m+int(e/2):e=0
3620n$(0)=str$(m)+"x new resin"
3625gosub2130
3635return
3645n$(0)="no ore to process":goto3625

!- harvest

3700q=q+10:w=w-5:x=int(rnd(1)*10):l=l+x
3715n$(0)="food harvested"
3718gosub2130
3720return

!- launch (scene 6)

4000sc=6:ifla=0thengoto4180:gosub2130
4005print"{clear}launch systems active"
4010print"{141}fuel:";fl;"tons{141}within range{141}{141}    planet";tab(15);"{blue}w {green}e {cyan}r{white}"

!- buffer current planet stats - current planet name, stats, ID -- MIGHT NOT NEED

4012pb$=pl$:forx=0to3:pb(x)=pt(x):next:cpn=pn

!- calc in range systems based on fuel **need to set MAX FUEL DEPOTS

4014iz=int((fl-1000)/200)+1:ii=0:fc=fa:fd=fb
4015fory=(cpn+1)to(iz+cpn):ii=ii+1:gosub11200:printii;tab(4);pl$;tab(14);"{blue}"pt(0)"{left}{green}"pt(1)"{left}{cyan}"pt(3)"{white}":next

4019print"{141}select to launch":pl$=pb$:forx=0to3:pt(x)=pb(x):next:pn=cpn:fa=fc:fb=fd:return

!- launch selection

4020lt=asc(kc$)-48:iflt>iithen return
4025fory=(cpn+1)to(cpn+lt):gosub11200:next
4030print"{clear}departing for":printpl$:forx=0to3000:next
4050np=1:return

4180n$(0)="not enough fuel":gosub2000
4190return

!- explore

4200tt=mt:mt=20:xp=0:xc=1:fx=1:sx=15
4202poke36878,10:poke36877,180
4210print"{clear}{yellow}@@@@@@@exploring@@@@@@planet ";pl$;"{141}";
4213gosub4900
4215?mm;"percent mapped{141}";:gosub4900
4223?"{141}{141}{141}{141}{141}     {175}{176}      {141}{141}":gosub4900:?"  press any key to  {return}   return to base     ";
4224gosub4900
4225b=peek(197)
4228gosub1125
4230gosub2500
4235gosub2130
4236gosub4500:rem do sfx
4238ifxp=1thenxp=0:goto4202
4240ifrnd(1)<0.05thengosub4310:gosub 2005:forx=0to4000:nextx:goto4210
4250a=peek(197)
4255ifa<>bthenmt=tt:gosub2000:?"{white}";:poke36877,0:xp=0:xc=0:return
4265gosub1110

!- mountain range animation

4270ifmc=160thenmc=191:goto4290
4272ifmc=191andrnd(1)<0.6thenmc=190:goto4290
4273ifmc=191thenmc=189:goto4290
4275ifmc=190thenmc=160:goto4290
4280ifmc=189thenmc=190 
4290ln$=mid$(ln$,2,21)
4295ln$=ln$+chr$(mc)
4297?"{home}{down}{down}{down}{down}{down}{down}{down}{141}{red}";:?ln$;"{141}{141}{141}";
4300goto4225

!- rewards

4310 mm=mm+0.2
4311 x=rnd(1)*3
4312 if x<1 then n$(0)="we have found a"
4313 if x<2 then n$(0)="and here there are"
4314 if x<3 then n$(0)="behold! there is a"
4316 n$(0)="we chanced upon a"
4318 x=int(rnd(1)*19):y=int(rnd(1)*19)+20:z=int(2*rnd(1))+1
4319 n$(1)=b$(x)+b$(y):x$=str$(z)
4320 if x<4 then n$(2)=x$+"power lost":p=p-z:return
4330 if x<7 then n$(2)=x$+"+water":w=w+z:return
4340 if x<12 then n$(2)=x$+"+fuel":fl=fl+z:return
4350 if x<15 then n$(2)=x$+"+power":p=p+z:return
4360 if x<16 then n$(2)=x$+"+resin":m=m+z:return
4370 if x<18 then n$(2)=x$+"+tech":te=te+z:return
4375 n$(2)=x$+"+food":l=l+z:return




4500iffx=0thensx=sx+1
4510iffx=1thensx=sx-1
4520ifsx=13andfx=0thenfx=1
4530ifsx=4andfx=1thenfx=0
4540poke36878,sx
4550return

4900?"{yellow}@@@@@@@@@@@@@@@@@@@@@@{white}";:return

!- building (bm= item to build)

5000mc=b%(bm*2):tc=b%((bm*2)+1)
5018ifws((bm*4)+3)=1thenn$(0)="in progress":goto5034
5020ifmc>mandtc>tthenn$(0)="under resourced"
5025ifmc>mthenn$(0)="need more mat."
5028iftc>tethenn$(0)="need more tech"
!- if enough resources, then build
5029ifmc<=mandtc<=tethengosub5040
5034gosub2130:return
5040n$(0)="building "+b$(40+bm)+str$(bm)
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
6070gosub6130:print"{red}"n$(0)
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
7015print"{white}"n$(0)
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
9035ifx=2thenps=ps+3
9045ifx=3thenps=ps-1:c=c-5
9055ifx=4thenwr=wr-3:c=c+100:cr=cr-20
9065ifx=5thenhr=hr-3:cr=cr-10
9075ifx=6thenc=c-20
9085ifx=7thenc=c-5:p=p-2:r=r-1
9095ifx=8thenc=c-20
9098ifx=9andla>1thenreturn
9102ifx=9thenm=m+20:w=w+20:t=t+20:c=c+100:la=la+1
9110n$(0)=b$(x)
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
9280print"{down}{down}{down}{down}{down}{down}{down}"
9300print"{red}{191}{190} {191}{190} {191}{189}{190}{191}{190}{191}{189}{190}{191}{190}{191}{190}  {191}{189}";
9310poke36878,10:poke36877,180
9320print"{home}{white}"tab(5);
9330ifsd=1thengosub9535:return

!- down


9335forxx=1to17
9340forx=0to3
9350printchr$(al(x));"{left}";"{down}";chr$(al(4+x));"{left}{up}";
9370fora=0to100:nexta
9380nextx
9390print"{up} {down}{left} {down}{left}";
9400nextxx:printchr$(91);
9410poke36878,0:poke36877,0
9420return

!- up

9535?"{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}";
9537forxx=1to17
9540forx=3to0step-1
9550printchr$(al(x));"{left}{down}";chr$(al(4+x));"{left}{up}";
9560z=xx*(x+1):z=cos({pi}+((z*{pi})/136))
9570fora=0toint(z*-200):nexta
9580nextx
9590print"{down} {up}{up}{left}";
9600nextxx:printchr$(91);
9610poke36878,0:poke36877,0
9620sd=0:return


!- end state

11000poke36877,0
11002print"{141}without ";
11005ifp<1thenprint"power"
11006ifw<1thenprint"water"
11007ifl<1thenprint"food"
11008ifh<1thenprint"habitat"
11010print"you perished..."
11015print"{141}hit a key to try again"
11020a=peek(197)
11025ifpeek(197)<>athenclr:gosub12000:goto100
11028forx=0to3:poke4634+x,128:next
11030goto11025

!- create planet

toDOremOVE BEFORE LAUNCH
!- get planet ID numbers using fib sequence
!-11100fa=0:fb=1
!-11101forgf=0topn
!-11105forx=0to3
!-11110fi=fa+fb
!-11115iffi>99999thenfi=fi-99998
!-11123num=fi-int(fi/10)*10
!-11130pt(x)=num
!-11150fa=fb:fb=fi
!-11157nextx
!-11158nextgf

!- build planet name
11161pl$=""
11162forx=0to(int((pt(0)+pt(1)+pt(2))/9))
11172pl$=pl$+mid$(di$,pt(x)*7+pt(x+1)+1,2)
11176next

11180return


!- increase planet +1

!- inc planet ID numbers +1 using fib sequence
11200pn=pn+1
11205forz=0to3
11210fi=fa+fb
11215iffi>99999thenfi=fi-99998
11223num=fi-int(fi/10)*10
11230pt(z)=num
11250fa=fb:fb=fi
11257next
11260gosub11161
11280return

!- set up new planet stats

11300H=pt(0)*10:L=pt(1)*10:W=pt(2)*10:P=pt(3)*10:mm=1
11310 return

12000rem this was where we poked in char&asm

!- we no longer need char and asm code so now initialize variables

!- fibonacci sequence
12002fa=0:fb=1:pn=1:dimpb(3)

!- strings: above first 20 are random event adjectives, next 20 are nounds, rest are buildable objects

12005data"mental","viral","piercing","fluxal","liquid","chemical","leachable","resonal","hypereal","gravity","plasma","pressure"
12008data"glittering","vibrating","sparkling","crystal","viscous","metal","gaseous","organic"
12010data"storm","hurricane","void","well","heap","construct","ruin","rift","wind","rip"
12015data"supplicant","solvent","powder","sand","regolith","mass","canyon","river","mountain","coast"
12020data"drone","rover","solar pnl","batteries"
12030data"growspace","forge","sab plant","tech","habitat"
12040dimb$(49)



12060forx=0to48:readb$(x):nextx

!- ints below for each inventory item [(begin amount, material cost, tech cost),(),.]

12080data2,1,1,5,5,1,1,1,1,2,0,0,0,2,1,0,30,3,0,2,1,0,1,1
12090dimb%(23)
12100forx=0to23:readb%(x):next

!- below for each buildable item [(number of, time remaining ,isBuilding?),(),.]

12120data3,0,0,0,0,0,0,0,23,0,0,0,32,0,0,0,10,0,0,0,4,0,0,0,5,0,0,0,12,0,0,0,2,0,0,0
12130dimws(35)
12140forx=0to35:readws(x):next


!- finish data entry

!-where the spaceship frames are & color codes
13005dimpt(4):dimal(18)
13007forx=0to17:readal(x):next
14280data91,92,93,94,32,95,60,33
14290data28,30,31,156,158,159,156,30,159,31

!- planet names string, mountain range

14300di$="abouseitiletstonlonuthnolexegezacebisousesarmaindireaeratenberalavetiedorquantisriono"
14400dimn$(3)
14410ln$="{191}{190} {191}{190} {191}{189}{190}{191}{190}{191}{189}{190}{191}{190}{191}{190}  {191}{189}" 


15000return


!- asm loader if needed for debugging
#region
!-==============================================
!-16000 REM GENERATED ML LOADER
!-16015 ?"{down}{down}loadingML...{up}";
!-16017 SA = 4609
!-16020 FOR N = 0 TO 302
!-16030 READ A% : POKE SA+N,A%: NEXT N
!-16040 return
!-16060 DATA 76,42,18,32,32,116,117,97
!-16070 DATA 246,234,160,160,0,6,28,50
!-16080 DATA 72,88,110,132,154,176,0,1
!-16090 DATA 2,80,0,0,0,208,176,128
!-16100 DATA 32,0,0,0,0,2,0,0
!-16110 DATA 0,32,49,18,32,110,18,96
!-16120 DATA 162,0,142,39,18,174,39,18
!-16130 DATA 189,30,18,141,41,18,188,26
!-16140 DATA 18,204,41,18,240,13,204,41
!-16150 DATA 18,144,19,189,26,18,136,152
!-16160 DATA 157,26,18,232,224,4,240,17
!-16170 DATA 142,39,18,76,54,18,188,26
!-16180 DATA 18,200,152,157,26,18,76,84
!-16190 DATA 18,32,152,18,96,24,162,0
!-16200 DATA 32,18,19,32,172,18,32,236
!-16210 DATA 18,32,182,18,24,173,38,18
!-16220 DATA 105,1,141,38,18,24,173,39
!-16230 DATA 18,105,1,141,39,18,201,4
!-16240 DATA 240,4,76,113,18,96,96,169
!-16250 DATA 2,141,25,18,169,2,141,38
!-16260 DATA 18,169,0,141,39,18,162,0
!-16270 DATA 160,0,96,174,39,18,189,14
!-16280 DATA 18,141,25,18,96,174,35,18
!-16290 DATA 189,4,18,168,173,34,18,109
!-16300 DATA 25,18,170,152,157,161,17,96
!-16310 DATA 162,0,173,38,18,201,5,240
!-16320 DATA 11,157,162,149,232,224,33,240
!-16330 DATA 4,76,203,18,96,238,38,18
!-16340 DATA 173,162,149,105,34,141,162,149
!-16350 DATA 76,203,18,173,25,18,170,169
!-16360 DATA 0,168,169,160,192,0,240,3
!-16370 DATA 157,161,17,173,38,18,157,161
!-16380 DATA 149,232,157,161,149,202,204,34
!-16390 DATA 18,176,5,232,200,76,243,18
!-16400 DATA 96,174,39,18,189,26,18,24
!-16410 DATA 74,74,74,74,141,34,18,189
!-16420 DATA 26,18,41,15,74,141,35,18
!-16430 DATA 96,169,147,32,210,255,96
!-
!-==============================================
#endregion