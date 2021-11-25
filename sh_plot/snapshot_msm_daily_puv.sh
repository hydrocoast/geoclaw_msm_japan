#/bin/bash

## filenames
#grd="../ncfile_daily_puv/2018/0901_psea_00.nc"
if [ -z "$1" ]; then echo "No file specified."; exit 0; fi
grd="$1"
grdu=${grd//_psea_/_u_}
grdv=${grd//_psea_/_v_}

## check
if [ ! -e $grd ]; then echo "Not found: $grd"; exit 0; fi
if [ ! -e $grdu ]; then echo "Not found: $grdu"; exit 0; fi
if [ ! -e $grdv ]; then echo "Not found: $grdv"; exit 0; fi

## FONT set
gmt set FONT_TITLE 16p,Helvetica,black

## parse time from file
fbase=`basename $grd`
yyyy=$(basename `dirname $grd`)
mmdd=${fbase%%_*}
hh=${fbase//${mmdd}_psea_/}
hh=${hh//.nc/}
ymdh=$yyyy$mmdd$hh
ymdhtitle="${ymdh:0:4}-${ymdh:4:2}-${ymdh:6:2} ${ymdh:8:2}:00 UTC"

## output file
outps=${fbase//.nc/.ps}
outps=${outps//_psea/}

## lower cut
gmt grdmath $grdu $grdv R2 25 GT $grdu MUL = tmpu.grd=nf # 5 m/s 以上
gmt grdmath $grdu $grdv R2 25 GT $grdv MUL = tmpv.grd=nf # 5 m/s 以上

## parameters
proj="X10/`gmt grdinfo $grd -Cn -o0,1,2,3  | awk '{print 10*($4-$3)/($2-$1)}'`"
inc_x=`gmt grdinfo $grd -Cn -o6  | awk '{print 32*$1}'` # 32点おきにプロット
inc_y=`gmt grdinfo $grd -Cn -o7  | awk '{print 40*$1}'` # 40点おきにプロット
#echo $proj $inc_x $inc_y

## makecpt
cpt="tmp.cpt"
#gmt makecpt -Chaxby -I -T950/1020/5 -D > $cpt
gmt makecpt -Chaxby -I -T950/1020 -D > $cpt

## attributes
vecscale=0.05
vecatt="+a25+e+p1+h1+gblack+n1"
lw=0.5

### plot
gmt grdimage $grd -J$proj -Baf -BneSW+t"$ymdhtitle" -R$grd -C$cpt -K > $outps
gmt psscale -C$cpt -Bxa10 -By+lhPa -DJMR+w7.0/0.3+o1.0/0.0+e -J -R -K -O  >> $outps
gmt pscoast -J -R -W0.5,white -Dl -K -O >> $outps
gmt grdvector tmpu.grd tmpv.grd -W$lw -I$inc_x/$inc_y -Si$vecscale -Q$vecatt -T -J -R -K -O >> $outps
gmt psvelo -Y-1.5 -J -R -A$vecatt -Gblack -Se$vecscale/0.0/12 -W$lw  -P -O <<EOF >> $outps
# lon   lat     u1    u2  sig1  sig2  cor  (option) name 
126.0  24.0  20.00  0.00  0.00  0.00  0.0  20 m/s
EOF

gmt psconvert $outps -A+m0.5 -Tg
gmt psconvert $outps -A+m0.5 -Tf

rm $outps
rm $cpt
rm tmpu.grd tmpv.grd


