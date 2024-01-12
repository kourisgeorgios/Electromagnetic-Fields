%c
[x,y] = meshgrid(0:0.05:2,0:0.05:1);

Jx=(y+1);
Jy=zeros(21,41);
J_magn=Jx;

figure(1)
surf(x,y,J_magn);

figure(2)
Jmin=1;
Jmax=2;
contour(x,y,J_magn,[1:0.2:2]);

%d
figure(3)
quiver(x,y,Jx,Jy);

figure(4)
streamslice(x,y,Jx,Jy);
