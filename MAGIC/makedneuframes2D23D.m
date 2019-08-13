cwd = fileparts(mfilename('fullpath'));
gemini_root = [cwd, filesep, '../../GEMINI/'];
addpath([gemini_root, filesep, 'script_utils'])

indir='~/zettergmdata/simulations.MAGIC/tohoku//'
%indir='~/zettergmdata/simulations.MAGIC/okx2/old/'
%indir='~/neutral_sims/chile06052017/'
%indir='~/neutral_sims/2016mooreOK/'
%indir='/media/data/chile2015_0.5MSIS/'
%indir='/media/data/nepal/'
loc='';
%simlab='chile'
%simlab='nepal'
simlab='strong'
simlab='';

%outdir=['~/simulations/mooreOK_neutrals/'];
%outdir=['~/simulations/chile2015_0.5_neutrals/'];
%outdir='~/simulations/nepal2015_neutrals/'
%outdir='~/zettergmdata/simulations/input/mooreOKx2_neutrals/'
outdir='~/zettergmdata/simulations/input/tohoku3D_neutrals/'
mkdir([outdir]);

%ymd0=[2015,09,16];
%UTsec0=82473;
%dtneu=4;

%ymd0=[2013,05,20];
%UTsec0=71100;
%dtneu=6;

%ymd0=[2015,4,24];
%UTsec0=22285;
%dtneu=4;

%% TOHOKU EXAMPLE
ymd0=[2011,3,11];
UTsec0=20783;
dtneu=4;


%% LOAD THE DATA FROM AN INPUT SIMULATION
if ~exist('velx')
    load([indir,'/velx',simlab,loc,'.mat']);
    load([indir,'/velz',simlab,loc,'.mat']);
    load([indir,'/temp',simlab,loc,'.mat']);
    load([indir,'/dox2s',simlab,loc,'.mat']);
    load([indir,'/dnit2s',simlab,loc,'.mat']);
    load([indir,'/doxs',simlab,loc,'.mat']);
%    load([indir,'/dox2',simlab,loc,'.mat']);
%    load([indir,'/dnit2',simlab,loc,'.mat']);
%    load([indir,'/dox',simlab,loc,'.mat']);
end
[lt,lrhon,lzn]=size(velx);


%% CREATE A 3D DATA SET OUT OF THE INPUT
%input grid
dzn=1e3;
drhon=1e3;
zn=0:dzn:(lzn-1)*dzn;
rhon=0:drhon:(lrhon-1)*drhon;

%output grid
lx=256;
ly=256;
lz=256;
x=linspace(-1*max(rhon),max(rhon),lx);
y=linspace(-1*max(rhon),max(rhon),ly);
z=linspace(min(zn),max(zn),lz);
[X,Z,Y]=meshgrid(x,z,y);
RHO=sqrt(X.^2+Y.^2);
PHI=atan2(Y,X);

%% CYCLE THROUGH INTERPOLATE, ROTATE, AND OUTPUT
ymd=ymd0;
UTsec=UTsec0;
for it=1:lt
    velrhonow=squeeze(velx(it,:,:));     %note that these are organized as t,rho,z - the fortran code wants z,rho
    velrhonow=permute(velxnow,[2, 1]);
    velrho3D=interp2(zn,rhon,velxnow,Z(:),RHO(:));
    velrho3D=reshape(velx3D,[lz,lx,ly]);
    
    velx3D=-1*velrho3D.*sin(PHI);
    vely3D=velrho3D.*cos(PHI);
    
    velznow=squeeze(velz(it,:,:));
    velznow=permute(velznow,[2, 1]);
    velz3D=interp2(zn,rhon,velznow,Z(:),RHO(:));
    velz3D=reshape(velz3D,[lz,lx,ly]);
    
    tempnow=squeeze(temp(it,:,:));
    tempnow=permute(tempnow,[2, 1]);
    temp3D=interp2(zn,rhon,tempnow,Z(:),RHO(:));
    temp3D=reshape(temp3D,[lz,lx,ly]);
    
    dox2snow=squeeze(dox2s(it,:,:));
    dox2snow=permute(dox2snow,[2, 1]);
    dox2s3D=interp2(zn,rhon,dox2snow,Z(:),RHO(:));
    dox2s3D=reshape(dox2s3D,[lz,lx,ly]);
    
    dnit2snow=squeeze(dnit2s(it,:,:));
    dnit2snow=permute(dnit2snow,[2, 1]);
    dnit2s3D=interp2(zn,rhon,dnit2snow,Z(:),RHO(:));
    dnit2s3D=reshape(dnit2s3D,[lz,lx,ly]);
    
    doxsnow=squeeze(doxs(it,:,:));
    doxsnow=permute(doxsnow,[2, 1]);    
    doxs3D=interp2(zn,rhon,doxsnow,Z(:),RHO(:));
    doxs3D=reshape(doxs3D,[lz,lx,ly]);    
    
    filename=datelab(ymd,UTsec);
    filename=[outdir,filename,'.dat']
    fid=fopen(filename,'w');
    fwrite(fid,doxs3D,'real*8');
    fwrite(fid,dnit2s3D,'real*8');
    fwrite(fid,dox2s3D,'real*8');
    fwrite(fid,velx3D,'real*8');
    fwrite(fid,vely3D,'real*8');
    fwrite(fid,velz3D,'real*8');
    fwrite(fid,temp3D,'real*8');
    fclose(fid);
    
    [ymd,UTsec]=dateinc(dtneu,ymd,UTsec);
end %for


%% CREATE A FILE WITH THE NEUTRAL SIMULATION SIZE
%system(['rm -rf ',outdir,'/*.dat'])
filename=[outdir,'simsize.dat']
fid=fopen(filename,'w');
fwrite(fid,lx,'integer*4');
fwrite(fid,ly,'integer*4');
fwrite(fid,lz,'integer*4');
fclose(fid);

