%d
x4=0:0.02:3;
y4=0:0.02:3;
[xa,ya]=meshgrid(x4,y4);

ph0=pi./6;
c1=cos(ph0);
c2=sin(ph0);
s=1.5;
s_=1./1.5;
R1=((xa-s.*c1).^2+(ya-s.*c2).^2).^(0.5);
R2=((xa+s.*c1).^2+(ya-s.*c2).^2).^(0.5);
R3=((xa+s.*c1).^2+(ya+s.*c2).^2).^(0.5);
R4=((xa-s.*c1).^2+(ya+s.*c2).^2).^(0.5);

R1_=((xa-s_.*c1).^2+(ya-s_.*c2).^2).^(0.5);
R2_=((xa+s_.*c1).^2+(ya-s_.*c2).^2).^(0.5);
R3_=((xa+s_.*c1).^2+(ya+s_.*c2).^2).^(0.5);
R4_=((xa-s_.*c1).^2+(ya+s_.*c2).^2).^(0.5);

F=(1./R1)-(1./R2)+(1./R3)-(1./R4)-(s./R1_)+(s./R2_)-(s./R3_)+(s./R4_);
F=F.*(xa.^2+ya.^2>=1);


figure(1)
colorbar
surface(xa,ya,F);
shading interp;
caxis([0 15]);
colormap(parula(50));
hold on
line([0 0], [1 3], 'color', 'red', 'LineWidth', 6);
line([1 3], [0 0], 'color', 'red', 'LineWidth', 6);
hold on
ththth = (0.01:0.002:pi/2-0.01);
xxx = cos(ththth);
yyy = sin(ththth);
plot(xxx,yyy,'o','color','red');

figure(2);
v=[0.001,0.01,0.05,0.1:0.1:1,1.25,1.5,2,3,5,10];
contour(xa,ya,F,v);

%e
figure(3)
[EX,EY] = gradient(F);
EX=-EX;
EY=-EY;
EX2=EX./sqrt(EX.^2+EY.^2);
EY2=EY./sqrt(EX.^2+EY.^2);
quiver(xa,ya,EX2,EY2,0.3);

hold on
line([0 0], [1 3], 'color', 'red', 'LineWidth', 6);
line([1 3], [0 0], 'color', 'red', 'LineWidth', 6);
hold on
ththth = (0.01:0.002:pi/2-0.01);
xxx = cos(ththth);
yyy = sin(ththth);
plot(xxx,yyy,'o','color','red');

figure(4)
streamslice(xa,ya,EX,EY);
axis tight

hold on
line([0 0], [1 3], 'color', 'red', 'LineWidth', 6);
line([1 3], [0 0], 'color', 'red', 'LineWidth', 6);
hold on
ththth = (0.01:0.002:pi/2-0.01);
xxx = cos(ththth);
yyy = sin(ththth);
plot(xxx,yyy,'o','color','red');

%f
figure(5)
rr = 1:0.01:3;
thth = (0:0.01:pi/2);
[rn thn] = meshgrid(rr,thth);
c1n=rn.*cos(thn);
c2n=rn.*sin(thn);

R1n=((c1n-s.*c1).^2+(c2n-s.*c2).^2).^(0.5);
R2n=((c1n+s.*c1).^2+(c2n-s.*c2).^2).^(0.5);
R3n=((c1n+s.*c1).^2+(c2n+s.*c2).^2).^(0.5);
R4n=((c1n-s.*c1).^2+(c2n+s.*c2).^2).^(0.5);

R1n_=((c1n-s_.*c1).^2+(c2n-s_.*c2).^2).^(0.5);
R2n_=((c1n+s_.*c1).^2+(c2n-s_.*c2).^2).^(0.5);
R3n_=((c1n+s_.*c1).^2+(c2n+s_.*c2).^2).^(0.5);
R4n_=((c1n-s_.*c1).^2+(c2n+s_.*c2).^2).^(0.5);

EXn=((c1n-s)./R1n.^3)-((c1n+s)./R2n.^3)+((c1n+s)./R3n.^3)-((c1n-s)./R4n.^3)-(s.*(c1n-s_)./R1n_.^3)+(s.*(c1n+s_)./R2n_.^3)-(s.*(c1n+s_)./R3n_.^3)+(s.*(c1n-s_)./R4n_.^3);
EYn=((c2n-s)./R1n.^3)-((c2n-s)./R2n.^3)+((c2n+s)./R3n.^3)-((c2n+s)./R4n.^3)-(s.*(c2n-s_)./R1n_.^3)+(s.*(c2n-s_)./R2n_.^3)-(s.*(c2n+s_)./R3n_.^3)+(s.*(c2n+s_)./R4n_.^3);
sigma=c1n.*EXn+c2n.*EYn;
phi=rad2deg(thn);
plot(phi,sigma);
