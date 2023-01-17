10 DIMpl(4): DIMal(18): gosub 13007
50 di$="abouseitiletstonlonuthnolexegezacebisousesarmaindireaeratenberalavetiedorquantisriono"

!- generate infinite levels using fibonacci sequence
60 input"planet number";pn
100 fa=0:fb=1
102 forgf=0topn
105 for s=0 to 3
110 f=fa+fb
115 iff>99999thenf=f-99998
123 num=f-int(f/10)*10
130 pl(s)=num
150 fa=fb:fb=f
155 rem ?pl(s)
157 next s
158 next gf

!- print name

161 pl$="welcome to "
162 for pa=0 to (int(pl(0)+pl(1)+pl(2))/10+1)
172 pl$=pl$+mid$(di$,pl(pa)*8+pl(pa+1)+1,2)
176 nextpa
178 ?gf:?pl$
189 ?" ";chr$(al(pl(3)+8))+chr$(150+int(pl(0)/2))+chr$(34+pl(0))
199 ?" ";chr$(al(pl(2)+8))+chr$(192+pl(1))
209 ?" ";chr$(al(pl(1)+8))+chr$(202+pl(2))
214 sh=int(pl(3)/2)
219 ?;chr$(al(pl(3)+pl(2)-2))chr$(162+sh)+chr$(211+int((pl(0)+pl(1))/2))+chr$(168+sh)
229 input tz$
239 if tz$="q"then end
400 goto102

!-where the spaceship frames are & color codes
13007forx=0to17:readal(x):next
14280data91,92,93,94,32,95,60,33
14290data28,30,31,156,158,159,156,30,159,31
14300return

