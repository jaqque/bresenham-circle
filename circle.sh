#!/bin/sh
# Bresenham's Circle
# Totally cribbed from https://iq.opengenus.org/bresenhams-circle-drawing-algorithm/

plot() {
   # Look ma! Globals!
   printf "$format" $(( Xc + x )) $(( Yc + y ))
   printf "$format" $(( Xc + x )) $(( Yc - y ))
   printf "$format" $(( Xc - x )) $(( Yc + y ))
   printf "$format" $(( Xc - x )) $(( Yc - y ))
   printf "$format" $(( Xc + y )) $(( Yc + x ))
   printf "$format" $(( Xc + y )) $(( Yc - x ))
   printf "$format" $(( Xc - y )) $(( Yc + x ))
   printf "$format" $(( Xc - y )) $(( Yc - x ))
}


while [ "$*" ]; do
   case "$1" in
      # Look ma! No error checking!
      -r) R="$2";  shift; shift ;;
      -x) Xc="$2"; shift; shift ;;
      -y) Yc="$2"; shift; shift ;;
      -f) format="$2"; shift; shift ;;
      -h|--help) echo "No help"; exit ;;
      *) echo "Use --help. You need it"; exit 1 ;;
   esac
done

[ "$R" ]  || R=100
[ "$Xc" ] || Xc=0
[ "$Yc" ] || Yc=0
[ "$format" ] || format='(%d,%d)\n'

x=0
y=$(( R ))
d=$(( 3 - 2 * R ))

plot
while [ $y -ge $x ]; do
   x=$(( x+1 ))
   if [ $d -gt 0 ]; then
      y=$(( y-1 ))
      d=$(( d + 4 * (x - y) + 10 ))
   else
      d=$(( d + 4 * x + 6 ))
   fi
   plot
done
