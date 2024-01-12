%b
[x,y] = meshgrid(0:0.05:2,0:0.05:2);

Jx=(1./(x+y).^2).*(-2*x.^2.*y.*log(x.^2+y.^2)-2.*y.^3);
Jy=(1./(x+y).^2).*(-2*y.^2.*x.*log(x.^2+y.^2)+2.*y.^2.*x);
J_magn=(Jx.^2 + Jy.^2).^0.5;

figure(1)
surf(x,y,J_magn);

figure(2)
contour(x,y,J_magn,[0:0.05:1]);

%c
figure(3)
quiver(x,y,Jx,Jy);

figure(4)
streamslice(x,y,Jx,Jy);

figure(5)
streamline(x,y,Jx,Jy,x,y);