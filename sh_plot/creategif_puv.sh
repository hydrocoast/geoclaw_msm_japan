#!/bin/bash
usage_exit() {
        echo "Usage: $0 [-r fps] directory_msmfig " 1>&2
        exit 1
}

## optional arg
while getopts r:h OPT
do
    case $OPT in
        r)  fps=$OPTARG
            ;;
        h)  usage_exit
            ;;
        \?) usage_exit
            ;;
    esac
done
if [ -z "$fps" ]; then
    fps=3
fi
shift $((OPTIND - 1))

if [ -z "$1" ]; then usage_exit ; fi
figdir="$1"
if [ -d $figdir]; then echo "Not found: directory $figdir" ; exit 0; fi


gifdir="_gif"
if [ ! -d $gifdir ]; then mkdir $gifdir ; fi

ffmpeg -i $figdir/MSM${figdir}S_%*.png -vf palettegen palette.png -y
ffmpeg -r $fps -i $figdir/MSM${figdir}S_%*.png -i palette.png -filter_complex paletteuse  $gifdir/MSM${figdir}.gif -y
\rm palette.png

