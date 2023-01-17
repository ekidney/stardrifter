1 DIMx%(12),y%(12):goto63

!- damage

2 printd$+"{white}"+sr$(0):forl=0to300:next:?d$:return

!- set course

3 ifdm$(2)<>g$thengosub2:return
4 ?d$;:input"course";a$:a=val(left$(a$,4)):b=(int(a/45-.5)+1)*π/4
5 ?d$;:input"factor";b$:c=.1*(val(left$(b$,1))-1)+1.5
6 tx=-c*cos(b):ty=c*sin(b):im=1:?d$:gosub21:return

!- own phasers

7 ifdm$(4)<>g$thengosub2:return
8 ?d$;:input"p/angle";a$:b=val(a$)*π/180:gosub21:a=cos(b):b=-sin(b)
9 fork=1to6step.5:xd=int(10+k*1.42*a+.5):yd=int(9+k*1.42*b+.5):sl=22*yd+xd
10 ifpeek(sc+sl)=90thengosub12
11 pokesc+sl,46:pokeco+sl,6:pokesc+sl,32:pokeco+sl,0:next:?d$:v(0)=v(0)-100:return

!- enemy destroyed

12 pokesc+sl,218:pokeco+sl,1:forl=6to12:ifxd<>x%(l)oryd<>y%(l)or(peek(898+l)<>90)then15
13 poke898+l,32:poke911+l,0:en%=en%-1:en%=en%=1:pokes,((16*en%)AND112)OR(PEEK(s)AND143)
14 v(3)=v(3)-1:v(2)=v(2)+1
15 next:return

!- shield

16 ifdm$(1)<>g$thengosub2:return
17 ?d$;:input"shield";a$:a=int(val(a$)):ifa<0thena=0
18 ifa>9999thena=9999
19 k=(SGN(v(0)+v(1)-a)+1)/2:v(0)=k*(v(0)+v(1)-a):v(1)=k*a+(1-k)*(v(0)+v(1))
20 ?d$:return

!- scanner legends

21 ?p$spc(13)"{white}status"+st$;:?spc(14)sr$(1)+sl$;:?" ram jet";
22 ifim=0then?"{reverse on}off{reverse off}";
23 ifim=1then?"{reverse on}off{reverse off}";
24 ?spc(3)"{white}report{white}"+re$+"{home}";:pokesc+208,43:pokeco+208,1:return

!- ship hit

25 k=int(600*rnd(1)):v(1)=v(1)-k:ifv(1)<0thenal=2
26 pokecv,3:ifv(1)>3000andk<400then29
27 k=int(5*rnd(1))+1:ifdm$(k)=o$thendm$(k)=r$
28 ifdm$(k)=g$thendm$(k)=o$
29 fork=0to100:next:pokecv,8:return

!- reports

30 ?"{clear}";:pokecv,30:?"{cyan}{**4}{purple}computer data{cyan}{**5}{blue}";:fori=0to5:k=13-len(mr$(i))
31 ?mr$(i)+right$(left$(s$,k-1)+str$(v(i)),k)"{reverse on} {reverse off}"tab(14)sr$(i)+dm$(i)+"{blue}";
32 next:fori=1to4:?m$(i):m$(t)=w$:next:?"{cyan}*****{purple}sensor  scan{cyan}*****{blue}";
33 forvs=9to0step-1:?right$(str$(vs),1);:forus=0to6:z=828+10*us+vs:k=peek(z)and128
34 if(abs(xs-us)>1orabs(ys-vs)>1)and(k<>128)ormi=1then?"{black}{reverse on}   {reverse off}{blue}";:goto39
35 pokez,peek(z)or128:c(0)=peek(z)and3:c(1)=(peek(z)and12)/4:c(2)=(peek(z)and112)/16
36 fork=1to3:ifz=sb%(k)then?"{green}":
37 next:ifz=sthen?"{reverse on}";
38 fork=0to2:?right$(str$(c(k)),1);:next:?"{blue}{reverse off}";
39 nextus:nextvs:fork=0to6:?spc(2)right$(str$(k),1);:next:ifmi=1oral>0thenreturn
40 geta$:ifa$<>chr$(32)then40
41 ?"{home}":pokecv,8:return

!- docked

42 v(0)=30000:v(1)=5000:fori=1to5:dm$(i)=g$:next:re$=g$:sl$=g$:st$=g$:dc%=0
43 m$(1)="docked":m$(2)="repairs complete":m$(3)="seek out and destroy":return

!- warp

44 ifdm$(5)<>g$thengosub2:return
45 ?D$;:ifv(0)<5000then?"low energy":forl=0to300:next:?d$:return
46 input"sector/x";a$:?d$;:input"sector/y";b$:?d$
47 xd=val(left$(a$,1)):yd=val(left$(b$,1))
48 if(xs-xd)^2+(ys-yd)^2>10then?d$+"{white}out of range":forl=0to300:next:?d$:return
49 xs=xd:ys=yd:s=828+10*xs+ys:v(0)=v(0)-5000:wi=1:im=0:dd%=int(10*rnd(1))+dd%
50 c(0)=peek(s)and3:c(1)=(peek(s)and12)/4:c(2)=(peek(s)and112)/16:pokes,peek(s)or128
51 q1=ss%*(10*xs+ys+1):fori=0to12:q2=q1-439*int(q1/439)
52 q3=q2+208-439*int((q2+208)/439):q1=15*q2
53 y%(i)=int(q3/22):x%(i)=q3-22*y%(i):poke898+i,32:poke911+i,0
54 ifi<3andi<c(0)thenpoke898+i,46:poke911+i,5
55 ifi>2andi-3<c(1)thenpoke898+i,46:poke911+i,7
56 ifi>5andi-6<c(2)thenpoke898+i,90:poke911+i,2
57 next:en%=c(2):fori=1to3:ifs=sb%(i)thenpoke901,102:poke914,3
58 next:pokevo,15:pokes4,214:a=0:b=22:c=1:ifmi=1thenpokecv,8:?"{clear}"
59 fori=atonstepc:pokes3,230+i:poke36864,12+i:poke36865,38+i
60 poke36866,22+w-i:poke36867,174-2*i:next:?"{clear}":a=22-a:b=22-b:c=-c:ifa=22then59
61 pokes4,0:pokevo,0:ifmi=1thenmi=2:wi=1:gosub21:goto92
62 return

!- initialize variables and strings

63 ?"{clear}":t0=ti:g0%=2500+int(500*rnd(1)):v(4)=g0%:v(5)=v(4):mi=1:w=peek(36866)and128
64 r$="{red}{reverse on}  {reverse off}{white}":o$="{yellow}{reverse on}  {reverse off}{white}":g$="{green}{reverse on}  {reverse off}{white}":p$="{home}{down*20}"
65 s$="             ":w$="":d$=p$+s$+p$
66 sc=4*w+64*(peek(36869)and112):co=37888+4*w:vo=36878:s3=36876:s4=s3+1:cv=36879

!- initialize string arrays

67 data"energy "," damage ","shield ","shield","enemy(des)","ramjet","enemy(est)"
68 data"fusion","date/log","phaser","date/gmt","warp  "
69 fori=0to5:readmr$(i):readsr$(i):next:m$(4)="stand by":gosub42:gosub30

!- construct galaxy

70 ss%=int(438*rnd(1))+1:forus=0to6:forvs=0to9:q1=int(4*rnd(1))*-(rnd(2)<.7)
71 q2=int(3*rnd(1))+1:q3=(int(6*rnd(1))+2)*-(rnd(2)<.3):v(3)=v(3)+q3:q0=q1+4*q2+16*q3
72 z=828+10*us+vs:pokez,q0and127:nextvs:nextus:fori=1to3
73 sb%(i)=828+int(24*rnd(1))+23*(i-1):next:xd=int(7*rnd(1)):yd=int(10*rnd(1)):goto49

!- repair damage

74 fori=1to5:ifdm$(i)=o$andrnd(i)<.2thendm$(i)=g$
75 next:fori=2to5step3:ifdm$(i)=r$thendm$(i)=o$
76 next:ifdm$(2)=o$thenim=0
77 st$=g$:ifv(0)<5000thenst$=0$:re$=o$:ifv(0)<0thenal=3
78 sl$=g$:ifv(1)<3000thensl$=o$:ifv(1)<1500thensl$=r$
79 fori=1to5:ifdm$(i)=o$thena$=o$
80 ifdm$(i)=r$thena$=r$:i=5
81 next:ifa$=o$ora$=r$thenst$=a$:re$=a$
82 ifen%>0thenst$=r$

!- update reports

83 v(0)=v(0)-int(22*(tx^2+ty^2)):dd%=dd%+1:ifv(3)=0thenrun
84 ifdm$(3)=g$ordm$(3)=o$thenv(0)=v(0)+200:ifdm$(3)=g$thenv(0)=v(0)+200
85 gosub21:v(4)=g0%+int((ti-t0)/3600):v(5)=v(4)+dd%:ifv(0)>10e4thenv(0)=10e4

!- get control

86 geta$:ifa$="w"thenim=0:gosub44:gosub21:wi=1
87 ifa$="p"thengosub7
88 ifa$="s"thengosub16
89 ifa$="d"andim=1thenim=0:gosub21
90 ifa$="c"thengosub3:gosub21
91 ifa$="r"thengosub30:re$=g$:gosub21

!- move/print
!- scanner

92 ifim=0thentx=0:ty=0
93 fori=0to12:sl=22*y%(i)+x%(i):ifx%(i)=10andy%(i)=9and(peek(898+i)=102)thendc%=1
94 ifsl>=0andsl<440and(sl<>208)andpeek(898+i)<>32thenpokesc+sl,32:pokeco+sl,0
95 x%(i)=x%(i)+int(tx+.5):y%(i)=y%(i)+int(ty+.5)
96 ifx%(i)<0orx%(i)>21ory%(i)<0ory%(i)>19or(peek(898+i)=32)then98
97 sl=22*y%(i)+x%(i):pokesc+sl,peek(898+i):pokeco+sl,peek(911+i)
98 next:ifdc%=1thengosub42:gosub30:re$=g$:im=0:gosub21:goto74

!- move/print enemy

99 ifwi=1oren%=0then109
100 fori=6to12:sl=22*y%(i)+x%(i)
101 ifsl>=0andsl<440and(sl<>208)andpeek(898+i)<>32thenpokesc+sl,32:pokeco+sl,0
102 ifpeek(898+i)<>32thenx%(i)=x%(i)+sgn(10-x%(i)):y%(i)=y%(i)+sgn(9-y%(i))
103 ifx%(i)=10andy%(i)=9and(peek(898+i)=90)thenal=1
104 ifx%(i)<0orx%(i)>21ory%(i)<0ory%(i)>19or(peek(898+i)=32)then106
105 sl=22*y%(i)+x%(i):pokesc+sl,peek(898+i):pokeco+sl,peek(911+i)

!- enemy phasers

106 next:fori=6to12:ifpeek(911+i)<>2or((x%(i)-10)^2+(y%(i)-9)^2)>75then108
107 if(rnd(1))<.4thengosub25
108 next
109 wi=0:ifal=0then74
110 m$(2)="ship destroyed":gosub30:pokecv,112:fori=0to2000:next:?"{clear}":pokecv,27








