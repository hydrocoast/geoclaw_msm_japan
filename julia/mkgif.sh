#/bin/bash

ffmpeg -i fig/gmtstorm_%03d.png -vf palettegen palette.png
ffmpeg -r 6 -i fig/gmtstorm_%03d.png -i palette.png -filter_complex paletteuse gmtstorm.gif
