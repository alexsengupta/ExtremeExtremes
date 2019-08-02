from netCDF4 import Dataset
import numpy as np
#import matplotlib.pyplot as plt
#from mpl_toolkits.basemap import Basemap
from datetime import date
import os
import shutil
import datetime
import sys

# NB only works from the command line e.g. python regions_MHW_pc90.py regional_data/avhrr-only-v2.0to30.-10to10.1981.2016.nc
# as need to pass file as argument
# Files will be run on Raijin at /g/data1a/e14/asg561/MHW


# Load marineHeatWaves definition module 
import marineHeatWaves90 as mmhw

# load input file name from parallel_process_MHW_regional_blocks.sh (batch calling routine) 
for arg in sys.argv:
 file=arg

os.chdir('/g/data1a/e14/asg561/MHW')
# load file data
fh = Dataset(file, mode='r')
lon = fh.variables['lon'][:]
lat = fh.variables['lat'][:]
time = fh.variables['time'][:]
t=date(1978,1,1).toordinal()+time
t=t.astype(int)


sst_units = fh.variables['sst'].units
#HEATWAVE=np.zeros((len(t),len(lat),len(lon))) # MHW 
SEVERITY=np.zeros((len(t),len(lat),len(lon))) # severity 
ANOMALY=np.zeros((len(t),len(lat),len(lon)))  # SSTA 
#SST_TMP=np.zeros((len(t),len(lat),len(lon)))  # SST
CLIMATOLOGY=np.zeros((366,len(lat),len(lon)))  # long term mean daily climatology (smoothed)
CLIMATOLOGYpc90=np.zeros((366,len(lat),len(lon)))  # 90th percentile climatology (smoothed)
#CLIMATOLOGY366=np.zeros((366,len(lat),len(lon)))  # long term mean daily climatology (smoothed)

# destination filename
fstart, fend=file.split(".",1)

dst='/g/data1a/e14/asg561/MHW/mhw_data_90pc/mhw_severity.pc90.'+fend

if not os.path.isfile(dst):
    print(dst) 
    #for mylat in range(0,5):
    for mylat in range(0,len(lat)):    
        sst_lat = fh.variables['sst'][ : , 0, mylat,: ]
        # convert masked array to normal array with filled values
        if type(sst_lat).__name__ == 'MaskedArray':
            sst_lat=sst_lat.filled()

        # remove data prior to 1982
        #sst_lat=sst_lat[ti,:]

        print(mylat)
        for mylon in range(0,len(lon)):
            #print(mylon)
            sst=sst_lat[:,mylon]
            # check if sst is empty
            if not all(x == sst[0] for x in sst):
                mhws, clim = mmhw.detect(t, sst)

                #heatwave=sst-clim['thresh'] #ssta above threshold                       
                #heatwave[heatwave<0] = np.nan #remove non MHW regions

                anomaly=sst-clim['seas'] # ssta 
                #anomaly[heatwave<0] = np.nan #remove non MHW regions              

		# creat time series MHWbool that is 1 for MHW, NaN otherwise
                N = mhws['n_events']
		MHWbool = np.zeros((len(t)))
		MHWbool[:] = np.nan
		for ev0 in np.arange(0, N, 1):  
			t1 = mhws['index_start'][ev0]
			t2 = mhws['index_end'][ev0]
			MHWbool[t1:t2+1] = 1

		sev=clim['thresh']-clim['seas']
                sev=np.divide(anomaly,sev)
		# only retain MHW events
		sev = sev * MHWbool
 
                SEVERITY[:,mylat,mylon]= sev
                #HEATWAVE[:,mylat,mylon]= heatwave # maybe remove
                ANOMALY[:,mylat,mylon]= anomaly
                #SST_TMP[:,mylat,mylon]= sst  # temp only
                
                # isolate leap year for saving
                ti = np.where((t >= date(1984,1,1).toordinal()) & (t <= date(1984,12,31).toordinal()) )[0]
                tmp=clim['seas']
                CLIMATOLOGY[:,mylat,mylon]= tmp[ti] # extract 1 (leap) year
                #CLIMATOLOGY[:,mylat,mylon]= clim['seas']
                tmp=clim['thresh']
                CLIMATOLOGYpc90[:,mylat,mylon]= tmp[ti] # extract 1 (leap) year

            ## END mylon loop
    ## END mylat loop 
    fh.close()

    # open a new netCDF file for writing.
    ncfile = Dataset(dst,'w')
    # create the x and y dimensions.
    ncfile.history = 'Created in regional_MHW_hdd4_anomaly.py pctile=90'+str(datetime.datetime.now())
    ncfile.createDimension('lon',len(lon))
    ncfile.createDimension('lat',len(lat))
    ncfile.createDimension('time',None)
    ncfile.createDimension('time366',None)

    # create the variable .
    #mhw = ncfile.createVariable('mhw','f4',('time','lat','lon'))
    severity = ncfile.createVariable('severity','f4',('time','lat','lon'))
    ssta = ncfile.createVariable('ssta','f4',('time','lat','lon'))
    #climatology = ncfile.createVariable('climatology','f4',('time','lat','lon'))
    climatology90 = ncfile.createVariable('climatology90','f4',('time366','lat','lon'))
    climatology = ncfile.createVariable('climatology','f4',('time366','lat','lon'))
    #sst_ = ncfile.createVariable('sst_','f4',('time','lat','lon')) # temp only
    lats = ncfile.createVariable('lat','f4',('lat',))
    lons = ncfile.createVariable('lon','f4',('lon',))
    time = ncfile.createVariable('time','f4',('time',))
    time366 = ncfile.createVariable('time366','f4',('time366',))
    lats.units = 'degrees_north'
    lons.units = 'degrees_east'
    time.units = 'days since 01-01-01 00:00:00'
    time366.units = 'days since 01-01-01 00:00:00' # need to correct this
    #mhw.units='degrees C'
    #mhw.long_name='Daily sea surface temperature anomaly above MHW threshold'
    ssta.units='degrees C'
    ssta.long_name='Daily sea surface temperature anomaly'
    #sst_.units='degrees C'  # temp only
    #sst_.long_name='Daily sea surface temperature' # temp only
    #climatology.units='degrees C'
    #climatology.long_name='Climatological sea surface temperature'
    climatology90.units='degrees C'
    climatology90.long_name='90pc Climatological sea surface temperature'
    climatology.units='degrees C'
    climatology.long_name='Climatological sea surface temperature'
    severity.units='ratio SSTA/(CLIM90-CLIMseas)'
    severity.long_name='MHW Severity'

    # write data to variable.
    lats[:] = lat
    lons[:] = lon
    time[:] = t-1 # for some reason dates are out by 1 day; minus 1 to correct
    time366[:] = t[ti]-1  # for some reason dates are out by 1 day; minus 1 to correct
    #mhw[:] = HEATWAVE
    severity[:] = SEVERITY
    ssta[:] = ANOMALY
    #sst_[:] = SST_TMP # temp only
    #climatology[:] = CLIMATOLOGY
    climatology90[:] = CLIMATOLOGYpc90
    climatology[:] = CLIMATOLOGY
    # close the file.
    ncfile.close()
    print('*** SUCCESS writing netcdf file ***')
    ## END if dst file exists
    del ssta,  ANOMALY, ncfile, fh

