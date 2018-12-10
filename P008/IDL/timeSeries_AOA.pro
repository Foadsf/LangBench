;---------------------------------------------------
; Read data from 7305 netCDF-4 files and do plotting
;---------------------------------------------------

function calcPressureLevels, nlevs
;    """
;      This function takes the number of vertical levels
;      to read a file that contains the values of ak and bk.
;      It then computes the pressure levels using the formula:
;
;          0.5*(ak[l]+ak[l+1]) + 0.1*1.0e5*(bk[l]+bk[l+1])
;
;      Input Varialble:
;        nlevs: number of vertical levels
;
;      Returned Value:
;        phPa: pressure levels from bottom to top
;    """
    ak   = FLTARR(nlevs+1)
    bk   = FLTARR(nlevs+1)
    phPa = FLTARR(nlevs)

    fileName = STRTRIM(nlevs,1)+'-layer.p'

    OPENR, lun, fileName, /GET_LUN

    ; Read the header
    header = STRARR(2)
    READF, lun, header

    k = 0
    WHILE (NOT EOF(lun)) DO BEGIN
        READF, lun, dump, a, b
        ak[k] = a
        bk[k] = b
        k     = k + 1
    ENDWHILE
    FREE_LUN, lun

    For k = 0,nlevs-1 Do Begin
        phPa[k] = 0.50*((ak[k]+ak[k+1])+0.01*1.00e+05*(bk[k]+bk[k+1]))
    EndFor

    return, REVERSE(phPa)
end



pro timeSeries_AOA

    ; Start time
    ;-----------
    time0 = SYSTIME(/SECONDS)

    vName = 'aoa'
    begYear = 1990
    ;endYear = 1990
    endYear = 2009

    firstFile = 0
    ref_lat = -86.0

    numDays = 0

    refDIR = '/discover/nobackup/jkouatch/GEOS_CTM/ProductionRuns/runAOA/outFiles/TR/'

    coef = 365.5
    ; Loop over the years
    ;--------------------
    For year = begYear, endYear Do Begin
        ;print, "Processing files for Year:", year
        dirY = refDIR+'Y'+STRTRIM(year,1)

        listFiles = FILE_SEARCH(dirY+"/runAOA.TR."+STRTRIM(year,1)+"*_1200z.nc4")
        numDays = numDays + N_ELEMENTS(listFiles)

        ; Loop over the daily files
        ;--------------------------
        FOREACH file, listFiles Do Begin
            ; Open file
            ;----------
            nf = ncdf_open(file)

            ; Extract information if it is the first file
            ;--------------------------------------------
            IF (firstFile EQ 0) THEN BEGIN
               NCDF_VARGET,nf,'lat',lats
               NCDF_VARGET,nf,'lon',lons
               NCDF_VARGET,nf,'lev',levs
               nlons = (SIZE(lons, /Dimensions))[0]
               nlats = (SIZE(lats, /Dimensions))[0]
               nlevs = (SIZE(levs, /Dimensions))[0]

               levs = calcPressureLevels(nlevs)

               lat_index = Value_Locate(lats, ref_lat)
            ENDIF

            ; Read the daily average age of air
            ;----------------------------------
            NCDF_VARGET, nf, vName, var, $
                         OFFSET = [0, lat_index, 0, 0], $
                         COUNT  = [nlons, 1, nlevs, 1], $
                         STRIDE = [1, 1, 1, 1]
            var = var / coef

            ; Determine the zonal mean
            ;-------------------------
            tempVar = REVERSE(MEAN(var, DIMENSION=1))

            ; Stack the daily values into an existing array
            ;----------------------------------------------
            IF (firstFile EQ 0) THEN BEGIN
               firstFile = 1
               dataVal = tempVar
            ENDIF ELSE BEGIN
               dataVal = [dataVal, tempVar]
            ENDELSE
    
            ; Close file
            ;-----------
            ncdf_close, nf
        ENDFOREACH
    EndFor

    ; End time
    ;-----------
    time1 = SYSTIME(/SECONDS) - time0

    print, " "
    print, 'Elapsed Time for the time series calculations: ', time1

    IF (numDays EQ 7305) THEN BEGIN
       print, 'Successful reading of all the files'
    ENDIF ELSE BEGIN
       print, 'Only read ', numDays, ' files! Check your script.'
    ENDELSE

    return
end
