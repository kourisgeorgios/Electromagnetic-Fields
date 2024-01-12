%b
[x,y] = meshgrid(-2:0.2:2,-2:0.2:2);

Rtx_b=7/8*x+(1-(sqrt(3)/8)*y);
Rty_b=(1-(sqrt(3)/8)*x)+3/8*x;

Rt_magn_b=norm([Rtx_b Rty_b]);

E0_b=1.5/(2*pi*Rt_magn_b.^2);

Ex_b=E0_b.*Rtx_b;
Ey_b=E0_b.*Rty_b;

figure(1)
quiver(x,y,Ex_b,Ey_b, 1);

figure(2)
streamslice(x,y,Ex_b,Ey_b);

%c
[x,z] = meshgrid(-2:0.1:2,-2:0.1:2);

Rtx_c=(7/8*x)+0.5-(sqrt(3)/16)+(7*z/4);
Rtz_c=(7/4*x)+0.5-(sqrt(3)/8)+z./2;

Rt_magn_c=norm([Rtx_c Rtz_c]);

E0_c=1.5/(2*pi*Rt_magn_c.^2);

Ex_c=E0_c.*Rtx_c;

%z<1
Ez_c1=-0.5+E0_c.*Rtz_c;

%z>1
Ez_c2=0.5+E0_c.*Rtz_c;

Ez_c=Ez_c1.*(x<1)+Ez_c2.*(x>1);

figure(3)
quiver(x,z,Ex_c,Ez_c, 1);

figure(4)
streamslice(x,z,Ex_c,Ez_c);


