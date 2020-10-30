mrefiles=file_search('mrefiles/sofia*mre')
nfiles=n_elements(mrefiles)

set_plot,'ps'
device,filename='SOFIAfits.eps',encapsulated=0,/color 
!p.font=0
tek_color
pcircle
!p.multi=[0,3,3]

for i=0,nfiles-1 do begin
    npro=120
    retname=mrefiles[i]
    zreadmre,retname,npro,nspec,latlon,ny,nx,varident,nvar,xdat,ydat,ngeom,nconv,ny2
    k=where(ydat[1,*] ge 300 and ydat[1,*] le 600)    
    tit='SOFIA Fits'+string(latlon[0])
    plot,ydat[1,k],ydat[2,k],thick=2,xtitle='Wavenumber [cm!u-1!n]',$
	ytitle='Radiance [nW/cm!u2!n/sr/cm!u-1!n]',xthick=2,ythick=2,$
	xs=1,title=tit,psym=8,symsize=0.25,ys=1
	
    errplot,ydat[1,k],ydat[2,k]-ydat[3,k],ydat[2,k]+ydat[3,k]
    
    oplot,ydat[1,k],ydat[5,k],color=2,thick=2
    
    
    if i eq 0 then eqm='mrefiles/fp+0.05_1.mre'
    if i eq 1 then eqm='mrefiles/fp+0.05_2.mre'    
    if i eq 2 then eqm='mrefiles/fp+0.05_3.mre'    
 zreadmre,eqm,npro,nspec,latlon,ny,nx,varident,nvar,xdat,ydat,ngeom,nconv,ny2
 
 oplot,ydat[1,k],ydat[5,k],color=4,thick=2

    if i eq 0 then eqm='mrefiles/fp-0.05_1.mre'
    if i eq 1 then eqm='mrefiles/fp-0.05_2.mre'    
    if i eq 2 then eqm='mrefiles/fp-0.05_3.mre'    
 zreadmre,eqm,npro,nspec,latlon,ny,nx,varident,nvar,xdat,ydat,ngeom,nconv,ny2
 
 oplot,ydat[1,k],ydat[5,k],color=3,thick=2

    
endfor


for i=0,nfiles-1 do begin
    npro=120
    retname=mrefiles[i]
    zreadmre,retname,npro,nspec,latlon,ny,nx,varident,nvar,xdat,ydat,ngeom,nconv,ny2
    wn_wl=0
    zrad2brightness,ydat[1,*],ydat[2,*]*1e-9,TB1,wn_wl
    zrad2brightness,ydat[1,*],ydat[5,*]*1e-9,TB2,wn_wl
    zrad2brightness,ydat[1,*],(ydat[2,*]+ydat[3,*])*1e-9,TBu,wn_wl
    zrad2brightness,ydat[1,*],(ydat[2,*]-ydat[3,*])*1e-9,TBl,wn_wl


    k=where(ydat[1,*] ge 300 and ydat[1,*] le 600)    
    tit='SOFIA Fits'+string(latlon[0])
    plot,ydat[1,k],TB1[k],thick=2,xtitle='Wavenumber [cm!u-1!n]',$
	ytitle='Brightness Temperature [K]',xthick=2,ythick=2,$
	xs=1,title=tit,ys=1,/nodata,yr=[110,135]
	
    errplot,ydat[1,k],TBl,TBu,color=170
    oplot,ydat[1,k],TB1[k],psym=8,symsize=0.25
    oplot,ydat[1,k],TB2[k],color=2,thick=2
    
    if i eq 0 then eqm='mrefiles/fp+0.05_1.mre'
    if i eq 1 then eqm='mrefiles/fp+0.05_2.mre'    
    if i eq 2 then eqm='mrefiles/fp+0.05_3.mre'   
    zreadmre,eqm,npro,nspec,latlon,ny,nx,varident,nvar,xdat,ydat,ngeom,nconv,ny2
    zrad2brightness,ydat[1,*],ydat[5,*]*1e-9,TBe,wn_wl
    
    oplot,ydat[1,k],TBe[k],color=4,thick=2

    if i eq 0 then eqm='mrefiles/fp-0.05_1.mre'
    if i eq 1 then eqm='mrefiles/fp-0.05_2.mre'    
    if i eq 2 then eqm='mrefiles/fp-0.05_3.mre'   
    zreadmre,eqm,npro,nspec,latlon,ny,nx,varident,nvar,xdat,ydat,ngeom,nconv,ny2
    zrad2brightness,ydat[1,*],ydat[5,*]*1e-9,TBe,wn_wl
    
    oplot,ydat[1,k],TBe[k],color=3,thick=2
    
endfor


device,/close
end
