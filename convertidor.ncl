begin
;***********************************************
; get variable names from grib file
;***********************************************
   grib_in  = addfile("./datViento.grib2","r")   
   names    = getfilevarnames(grib_in); extract all variable names 
;***********************************************
; create output netcdf file
;*********************************************** 
   system("rm out.nc") ; remove any pre-existing file
   ncdf_out = addfile("out.nc" ,"c")       ; create output netCDF file
;***********************************************
; loop through variables and output each to netcdf
;***********************************************
   do i = 0, dimsizes(names)-1  
   ncdf_out->$names(i)$ = grib_in->$names(i)$
   end do   
end
