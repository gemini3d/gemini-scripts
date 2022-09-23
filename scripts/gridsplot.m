
% %TOHOKU-LIKE GRID
% dtheta=7.5;
% dphi=8.5;    %to make sure we encapsulate the neutral grid long. extent
% lp=50;
% lq=350;
% lphi=30;
% altmin=80e3;
% %glat=43.95;    %WRONG!!!
% glat=42.45;
% glon=143.4;
% gridflag=1;


% %GEOGRAPHICALLY CORRECT TOHOKU GRID
% dtheta=9;
% dphi=15;    %to make sure we encapsulate the neutral grid long. extent
% lp=50;
% %lp=350;    %4 km resolution
% %lq=150;
% lq=1000;
% %lq=1500;    %3-5km grid resolution
% lphi=30;
% %lphi=350;   %3-5km res.
% altmin=80e3;
% glat=42.45;
% glon=143.4;
% gridflag=1;


% %A THINNER TOHOKU GRID
% dtheta=7.5;
% dphi=12;
% lp=50;
% lq=250;
% lphi=50;
% altmin=80e3;
% glat=42.45;
% glon=143.4;
% gridflag=1;

% %CHILE 2015 GRID
% dtheta=8;
% dphi=14;
% lp=50;
% lq=250;
% lphi=50;
% altmin=80e3;
% glat=17.0;
% glon=288.2;
% gridflag=1;

% %NEPAL 2015 GRID
% dtheta=8;
% dphi=14;
% lp=100;
% lq=100;
% lphi=100;
% altmin=80e3;
% glat=35.75;
% glon=84.73;
% gridflag=1;

% %MOORE, OK GRID (FULL)
% dtheta=25;
% dphi=35;
% lp=100;
% lq=350;
% lphi=100;
% altmin=80e3;
% glat=39;
% glon=262.51;
% gridflag=0;

% %MOORE, OK GRID (PARTIAL)
% dtheta=15;
% dphi=20;
% lp=150;
% lq=500;
% lphi=25;
% altmin=80e3;
% glat=39;
% glon=262.51;
% gridflag=0;

% %RISR LOWRES GRID (CARTESIAN)
% xdist=1e6;
% ydist=1e6;
% lxp=50;
% lyp=50;
% glat=75.6975;
% glon=360.0-94.8322;
% gridflag=0;
% I=90;

% %NEW ZEALAND EXAMPLE
% p.dtheta=17.5;
% p.dphi=8.5;
% p.lp=256;
% p.lq=256;
% p.lphi=10;
% p.altmin=80e3;
% p.glat=-45.85;
% p.glon=173.077;
% p.gridflag=1;

% %% Equatorial grid, disturbance ESF runs
% p.dtheta=4.5;
% p.dphi=24;
% p.lp=256;
% p.lq=256;
% p.lphi=144;
% p.altmin=80e3;
% p.glat=8.35;
% p.glon=360-76.9;     %Jicamarca
% p.gridflag=1;
% p.flagsource=0;
% p.iscurv=true;

%% EQuatorial grid, equilibrium runs
%p.dtheta=5.75;
%p.dtheta=7.75;
%p.dphi=30;
%p.lp=128;
%p.lq=256;
%p.lphi=48;
%p.altmin=80e3;
%p.glat=12;

%% ESF tests
%p.dtheta=3.5;
p.dtheta=4.5;    % puts boundary farther away
p.dphi=34;
%p.lp=522;
p.lp=256;
p.lq=256;
%p.lphi=580;
p.lphi=288;
p.altmin=80e3;
p.glat=8.35;
p.glon=360-76.9;     %Jicamarca
p.gridflag=1;
p.flagsource=0;
p.iscurv=true;

%RUN THE GRID GENERATION CODE
if ~exist('xg', 'var')
    xg= gemini3d.grid.tilted_dipole(p);
end


%PLOT THE OUTLINES OF THE DIPOLE GRID - THIS VERSION USES MLAT,MLON.,ALT. COORDS.
figure;
Re=6370e3;
mlat=90-xg.theta*180/pi;
dphi=max(xg.phi(:))-min(xg.phi(:));
mlon=xg.phi*180/pi;
alt=xg.alt/1e3;
hold on;

LW=2;
altlinestyle=':';

plot3(mlat(:,1,1),mlon(:,1,1),alt(:,1,1),'LineWidth',LW);
plot3(mlat(:,1,end),mlon(:,1,end),alt(:,1,end),altlinestyle,'LineWidth',LW);
plot3(mlat(:,end,1),mlon(:,end,1),alt(:,end,1),'LineWidth',LW);
h=plot3(mlat(:,end,end),mlon(:,end,end),alt(:,end,end),altlinestyle,'LineWidth',LW);
linecolor=h.Color;

x=squeeze(mlat(1,:,1));
y=squeeze(mlon(1,:,1));
z=squeeze(alt(1,:,1));
plot3(x,y,z,'LineWidth',LW);

x=squeeze(mlat(1,:,end));
y=squeeze(mlon(1,:,end));
z=squeeze(alt(1,:,end));
plot3(x,y,z,altlinestyle,'LineWidth',LW);

x=squeeze(mlat(end,:,1));
y=squeeze(mlon(end,:,1));
z=squeeze(alt(end,:,1));
plot3(x,y,z,'LineWidth',LW);

x=squeeze(mlat(end,:,end));
y=squeeze(mlon(end,:,end));
z=squeeze(alt(end,:,end));
plot3(x,y,z,altlinestyle,'LineWidth',LW);

ix3=floor(xg.lx(3)/2);
x=squeeze(mlat(1,1,1:ix3));
y=squeeze(mlon(1,1,1:ix3));
z=squeeze(alt(1,1,1:ix3));
plot3(x,y,z,'LineWidth',LW);

x=squeeze(mlat(1,1,ix3:xg.lx(3)));
y=squeeze(mlon(1,1,ix3:xg.lx(3)));
z=squeeze(alt(1,1,ix3:xg.lx(3)));
plot3(x,y,z,altlinestyle,'LineWidth',LW);

x=squeeze(mlat(1,end,1:ix3));
y=squeeze(mlon(1,end,1:ix3));
z=squeeze(alt(1,end,1:ix3));
plot3(x,y,z,'LineWidth',LW);

x=squeeze(mlat(1,end,ix3:xg.lx(3)));
y=squeeze(mlon(1,end,ix3:xg.lx(3)));
z=squeeze(alt(1,end,ix3:xg.lx(3)));
plot3(x,y,z,altlinestyle,'LineWidth',LW);

x=squeeze(mlat(end,1,1:ix3));
y=squeeze(mlon(end,1,1:ix3));
z=squeeze(alt(end,1,1:ix3));
plot3(x,y,z,'LineWidth',LW);

x=squeeze(mlat(end,1,ix3:xg.lx(3)));
y=squeeze(mlon(end,1,ix3:xg.lx(3)));
z=squeeze(alt(end,1,ix3:xg.lx(3)));
plot3(x,y,z,altlinestyle,'LineWidth',LW);

x=squeeze(mlat(end,end,1:ix3));
y=squeeze(mlon(end,end,1:ix3));
z=squeeze(alt(end,end,1:ix3));
plot3(x,y,z,'LineWidth',LW);

x=squeeze(mlat(end,end,ix3:xg.lx(3)));
y=squeeze(mlon(end,end,ix3:xg.lx(3)));
z=squeeze(alt(end,end,ix3:xg.lx(3)));
plot3(x,y,z,altlinestyle,'LineWidth',LW);

xlabel('magnetic latitude (deg.)');
ylabel('magnetic longitude (deg.)');
zlabel('altitidue (km)');
%set(gca,'XTickLabel',{},'YTickLabel',{},'ZTickLabel',{});    %removes tick labels - useful for AI


%GO BACK AND MAKE ALL LINES THE SAME COLOR
h=gca;
lline=numel(h.Children);
for iline=1:16    %the last three children are the surface and text label objects
    h.Children(iline).Color=[0 0 0];
end



%GEOGRAPHIC COORDINATES OF NEUTRAL SOURCE
% %TOHOKU
% sourcelat=38.429575;
% sourcelong=142.734757;

% %CHILE 2015
% sourcelat=-31.57;
% sourcelong=360-71.654;

% %NEPAL 2015
% sourcelat=28.17;
% sourcelong=85.48;

% %MOORE OK
% sourcelat=35.3;
% sourcelong=360-97.7;

% %CARTESIAN GRID
% sourcelat=glat;
% sourcelong=glon;

% %NEW ZEALAND
% sourcelat = -42.757;
% sourcelong = 173.077;
% zmax=500;
% rhomin=0;
% rhomax=950;

%% ESF tests
[sourcelat,sourcelong]=gemini3d.geomag2geog(pi/2,354*pi/180);

[sourcetheta,sourcephi]= gemini3d.geog2geomag(sourcelat,sourcelong);
sourcemlat=90-sourcetheta*180/pi;
sourcemlon=sourcephi*180/pi;
hold on;
plot3(sourcemlat,sourcemlon,0,'ro','MarkerSize',16);


%NOW CREATE A NEUTRAL GRID AND OVERPLOT IT
zmin=0;
%%zmax=750;    %most earthquakes
zmax=660;    %Moore, OK
lz=330;
%lz=750;
rhomin=0;
%rhomax=750;    %most earthquakes
rhomax=1800;    %Moore, OK
lrho=750;
zn=linspace(zmin,zmax,lz);
rhon=linspace(rhomin,rhomax,lrho);
rn=6370+zn;    %geocentric distance (in km)

%meanth=mean(xg.theta(xg.lx(1),:,floor(xg.lx(3)/2)))+4.25*pi/180;   %N lowlat, TD model
%meanphi=mean(xg.phi(xg.lx(1),floor(xg.lx(3)/2),:));
%meanphi=meanphi+dphi/2;
drho=rhomax-rhomin;                                %radius of circle, in kilometers, describing perp. directions of axisymmetric model
xn=linspace(-1*drho,drho,100);           %N-S distance spanned by neutral model ("fake" number of grid points used here)
dthetan=(max(xn(:))-min(xn(:)))/rn(1);   %equivalent theta coordinates of the neutral mesh (used in the plot of grid)
thetan=linspace(sourcetheta-dthetan/2,sourcetheta+dthetan/2,100);    %theta coordinates of N-S distance specified
phinhalf1=sourcephi+sqrt((dthetan/2)^2-(thetan-sourcetheta).^2);
phinhalf2=sourcephi-sqrt((dthetan/2)^2-(thetan-sourcetheta).^2);
mlatn=90-thetan*180/pi;
mlonnhalf1=phinhalf1*180/pi;
mlonnhalf2=phinhalf2*180/pi;

hold on;
plot3(mlatn,real(mlonnhalf1),zn(1)*ones(size(mlatn)),altlinestyle,'LineWidth',LW);
plot3(mlatn,real(mlonnhalf2),zn(1)*ones(size(mlatn)),'LineWidth',LW);
plot3(mlatn,real(mlonnhalf1),zn(end)*ones(size(mlatn)),altlinestyle,'LineWidth',LW);
plot3(mlatn,real(mlonnhalf2),zn(end)*ones(size(mlatn)),'LineWidth',LW);
plot3(min(mlatn)*ones(size(zn)),sourcephi*ones(size(zn))*180/pi,zn,'LineWidth',LW);
plot3(max(mlatn)*ones(size(zn)),sourcephi*ones(size(zn))*180/pi,zn,'LineWidth',LW);
hold off;


%GO BACK AND MAKE ALL NEUTRAL GRID LINES THE SAME COLOR
h=gca;
lline=numel(h.Children);
for iline=1:6    %the line objects for each axis are added in a "stack" fashion (last in first out)
    h.Children(iline).Color=linecolor;
%    h.Children(iline).LineWidth=0.60;
end

FS=12;
set(gca,'FontSize',FS);
grid on;
set(gca,'LineWidth',LW-0.5)
view(1,2);


%CARTESIAN NEUTRAL GRID
%{
dz=72e3;
drho=72e3;

lz=9;
lrho=6;

zn=linspace(0,lz*dz,lz)';
rhon=linspace(0,lrho*drho,lrho);
xn=[-1*fliplr(rhon),rhon(2:lrho)];
lx=numel(xn);
yn=xn;          %all based off of axisymmetric model
rn=zn+6370e3;   %convert altitude to geocentric distance

dtheta=(max(xn(:))-min(xn(:)))/rn(1);    %equivalent theta coordinates of the neutral mesh
dphi=(max(yn(:))-min(yn(:)))/rn(1);      %should be a sin(theta) there?
thetan=linspace(meanth-dtheta/2,meanth+dtheta/2,2*lx-1);    %fudge this to make it look good.
phin=linspace(meanphi-dphi/2,meanphi+dphi/2,2*lx-1);
[THETAn,PHIn,Rn]=meshgrid(thetan,phin,rn);

MLATn=90-THETAn*180/pi;
MLONn=PHIn*180/pi;
Zn=(Rn-6370e3)/1e3;

hold on;
plot3(MLATn(:,end,1),MLONn(:,end,1),Zn(:,end,1),'LineWidth',LW);
h=plot3(MLATn(:,end,end),MLONn(:,end,end),Zn(:,end,end),'LineWidth',LW);
linecolor=h.Color;    %grab the color of the second line
plot3(MLATn(:,1,1),MLONn(:,1,1),Zn(:,1,1),'LineWidth',LW);
plot3(MLATn(:,1,end),MLONn(:,1,end),Zn(:,1,end),'LineWidth',LW);
plot3(squeeze(MLATn(1,:,1)),squeeze(MLONn(1,:,1)),squeeze(Zn(1,:,1)),'LineWidth',LW);
plot3(squeeze(MLATn(1,:,end)),squeeze(MLONn(1,:,end)),squeeze(Zn(1,:,end)),'LineWidth',LW);
plot3(squeeze(MLATn(end,:,1)),squeeze(MLONn(end,:,1)),squeeze(Zn(end,:,1)),altlinestyle,'LineWidth',LW);
plot3(squeeze(MLATn(end,:,end)),squeeze(MLONn(end,:,end)),squeeze(Zn(end,:,end)),altlinestyle,'LineWidth',LW);
plot3(squeeze(MLATn(1,1,:)),squeeze(MLONn(1,1,:)),squeeze(Zn(1,1,:)),'LineWidth',LW);
plot3(squeeze(MLATn(1,end,:)),squeeze(MLONn(1,end,:)),squeeze(Zn(1,end,:)),'LineWidth',LW);
plot3(squeeze(MLATn(end,1,:)),squeeze(MLONn(end,1,:)),squeeze(Zn(end,1,:)),altlinestyle,'LineWidth',LW);
plot3(squeeze(MLATn(end,end,:)),squeeze(MLONn(end,end,:)),squeeze(Zn(end,end,:)),altlinestyle,'LineWidth',LW);
%}

%print -dpng 3Datmosionos_grid.png;
%print -depsc2 -painters 3Datmosionos_grid.eps;
%print -dpdf -painters 3Datmosionos_grid.pdf;


if (license('test','Map_Toolbox'))
%    figure;
%    thetarange=[pi/2-max(mlat(:))*pi/180,pi/2-min(mlat(:))*pi/180];
%    phirange=[min(mlon(:))*pi/180,max(mlon(:))*pi/180];
%    [glatrange,glonrange]=gemini3d.geomag2geog(thetarange,phirange);
%    glatrange=sort(glatrange);
%    glonrange=sort(glonrange);
%    glatrange(1)=glatrange(1)-10;
%    glatrange(2)=glatrange(2)+10;
%    glonrange(1)=glonrange(1)-10;
%    glonrange(2)=glonrange(2)+10;
%    worldmap(glatrange,glonrange);
%    load coastlines;
%    plotm(coastlat,coastlon);

  hold on;
  ax=axis;
  load coastlines;
  [thetacoast,phicoast]= gemini3d.geog2geomag(coastlat,coastlon);
  mlatcoast=90-thetacoast*180/pi;
  mloncoast=phicoast*180/pi;
%  mlatcoast=sort(mlatcoast);
%  mloncoast=sort(mloncoast);
  plot3(mlatcoast,mloncoast,zeros(size(mlatcoast)),'k-');
%  axis(ax);    %reset axis
end
