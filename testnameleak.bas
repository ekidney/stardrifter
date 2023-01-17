1goto10:fori=0to100
2eq=({pi}+((i*{pi})/200))

3z=cos({pi}+((i*{pi})/88)):z=int(z*-1000):?x

5nexti
9end

10dimal(8):forx=0to7:al(x)=49+x:next

9335?"{clear}      {down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}";
9330forxx=1to16
9340forx=3to0step-1
9350printchr$(al(x));"{left}{down}";chr$(al(4+x));"{left}{up}";
9360z=xx*(x+1):z=cos({pi}+((z*{pi})/88))
9370fora=0toint(z*-200):nexta
9380nextx
9390print"{down} {up}{up}{left}";
9400nextxx:printchr$(91);
9410poke36878,0:poke36877,0
9420end