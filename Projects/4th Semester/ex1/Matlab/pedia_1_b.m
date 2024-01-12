%b
[x,y] = meshgrid(-0.5:0.05:1,0:0.05:1);

Jx=(x.*y./(x.^2+y.^2).^(3/2));
Jy=(1./(x.^2+y.^2)).*((y.^2).*(1-(1./(x.^2+y.^2).^(1/2)))+x.^2);
J_magn=(Jx.^2 + Jy.^2).^0.5;

figure(1)
surf(x,y,J_magn);

figure(2)
contour(x,y,J_magn,[0.25:0.25:5]);

%c
figure(3)
quiver(x,y,Jx,Jy);

figure(4)
streamslice(x,y,Jx,Jy);

figure(5)
streamline(x,y,Jx,Jy,x,y);