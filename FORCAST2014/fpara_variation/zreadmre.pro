 pro zreadmre,retname,npro,nspec,latlon,ny,nx,varident,nvar,xdat,ydat,ngeom,nconv,ny2




;npro=120
openr,1,retname

 nspec = 1
 readf,1,nspec
 iplot=nspec

;readsvp,nsvp,idsvp,svp

 for ip = 0,iplot-1 do begin
   itmp = intarr(5)
   readf,1,itmp
   ngeom = itmp(1)
   nconv = itmp(2)
   nx = itmp(3)
   ny = itmp(4)
   
   ny2=ny/ngeom
   
   latlon = fltarr(2)
   readf,1,latlon
   head=''
   for i=1,2 do begin
    readf,1,head
   endfor

   ydat = dblarr(7,ny)
   xdat = fltarr(4,nx)
   readf,1,ydat
   
   readf,1,head
   readf,1,head
   res=strsplit(head,' ',/extract)
   nvar=res[2]
   
   istart=0


   for ivar=0,nvar-1 do begin
        head=' '
        readf,1,head
        varident_n=fltarr(3)
        readf,1,varident_n
        itype = varident_n(2)
   
     for i=1,2 do begin
      readf,1,head
     endfor
     print,'ITYPE: ',itype
     case itype of
      0: np = npro
      1: np = 2
      2: np = 1
      3: np = 1
      4: np = 3
      7: np=2
      9: np=3
      11: np=2
      20: np=2
     endcase
     xdat1 = fltarr(6,np)
     readf,1,xdat1
     for j=0,np-1 do xdat(*,istart+j)=xdat1(2:5,j)

     istart=istart+np

   endfor


endfor




close,1
return
end
