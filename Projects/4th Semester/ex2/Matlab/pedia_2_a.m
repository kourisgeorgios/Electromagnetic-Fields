
%b
[x,y] = meshgrid(-1:0.1:1,0:0.1:1);

J0=exp(-sqrt(x.^2+y.^2))./(sqrt(x.^2+y.^2));
Jx=-J0.*y;
Jy=J0.*x;

figure(1)
quiver(x,y,Jx,Jy);

figure(2)
streamslice(x,y,Jx,Jy);

figure(3)
streamline(x,y,Jx,Jy,x,y);

%d
H=exp(-sqrt(x.^2+y.^2));

figure(4)
surface(x,y,H);
shading interp
