#!/bin/bash
export NCARG_ROOT=/usr/local

echo Iniciando descarga

fecha=$(date +"%Y%m%d")
hora=$(date +%H)
echo $fecha

echo $hora
rm datViento.grib2
if [ "$hora" -lt 06 ]; then
wget http://www.ftp.ncep.noaa.gov/data/nccf/com/gfs/prod/"gfs."$fecha"00"/gfs.t00z.wafs_grb45f06.grib2
 
mv gfs.t00z.wafs_grb45f06.grib2 datViento.grib2
fi

if [ "$hora" -lt 12 ]; then
wget http://www.ftp.ncep.noaa.gov/data/nccf/com/gfs/prod/"gfs."$fecha"06"/gfs.t06z.wafs_grb45f06.grib2

mv gfs.t06z.wafs_grb45f06.grib2 datViento.grib2
fi

if [ "$hora" -lt 18 ]; then
wget http://www.ftp.ncep.noaa.gov/data/nccf/com/gfs/prod/"gfs."$fecha"12"/gfs.t12z.wafs_grb45f06.grib2

mv gfs.t12z.wafs_grb45f06.grib2 datViento.grib2
fi
if [ "$hora" -ge 18 ]; then
wget http://www.ftp.ncep.noaa.gov/data/nccf/com/gfs/prod/"gfs."$fecha"18"/gfs.t18z.wafs_grb45f06.grib2
echo termino descarga 

mv gfs.t18z.wafs_grb45f06.grib2 datViento.grib2

echo Iniciando convertidor

fi
ncl convertidor.ncl

echo Fin convertidor

echo Iniciando extraccion de variables

rm TVientosVar.js
ncdump -v lat_0,lon_0,UGRD_P0_L6_GLL0,VGRD_P0_L6_GLL0 out.nc > TVientosVar.js

echo Fin extraccion de variables

echo Iniciando tratamiento de archivo

sed  -i  's/{/ /' TVientosVar.js
sed  -i  's/}/ /' TVientosVar.js
sed  -i  's/=/=[/' TVientosVar.js
sed  -i  's/;/];/' TVientosVar.js
sed '1,170d' TVientosVar.js > TVientoVar.js

echo Fin de tratamiento

echo Abriendo archivo :D

firefox vientos.html


echo BYE X.X

exit
