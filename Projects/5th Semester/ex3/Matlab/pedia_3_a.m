M0=1;
a=1;
x_a=-3:3/25:3;
y_a=-3:3/25:3;
[x_mesh,y_mesh]=meshgrid(x_a,y_a);
theta=eps:pi/32:pi;
xx=cos(theta);
yy=sin(theta);
lengthL=length(x_a);

A_m=zeros(51);
for iter1=1:lengthL
    for iter2=1:lengthL
        x_1=x_mesh(iter1,iter2);
        y_1=y_mesh(iter1,iter2);
        A_m(iter1,iter2)=integral(@(phi2)cos(phi2).*log(1./(((x_1)^2+(y_1)^2+1-(2*((x_1.*cos(phi2))+(y_1.*sin(phi2))))).^(1/2))),0,pi); 
    end
end

figure(1)
surface(x_mesh,y_mesh,A_m); 
shading interp
colorbar

figure(2)
contour(x_mesh,y_mesh,A_m,2.7*(0.1:0.05:2.2));
hold on
plot(xx,yy,'Color','R');
plot((-a:a/20:a),(-a:a/20:a)*0,'Color','R');

Bx_magn=zeros(51);
By_magn=zeros(51);
Hx_ind=zeros(51);
Hy_ind=zeros(51);
for iter1=1:lengthL
    for iter2=1:lengthL
           x_1=x_mesh(iter1,iter2);
           y_1=y_mesh(iter1,iter2);
           Bx_magn(iter1,iter2)=-integral(@(phi2)(cos(phi2).*(y_1-sin(phi2)))./((x_1)^2+(y_1)^2+1-(2*((x_1.*cos(phi2))+(y_1.*sin(phi2))))),0,pi);
           By_magn(iter1,iter2)=integral(@(phi2)(cos(phi2).*(x_1-cos(phi2)))./((x_1)^2+(y_1)^2+1-(2*((x_1.*cos(phi2))+(y_1.*sin(phi2))))),0,pi);
      if (sqrt(x_1^2+y_1^2)>1 || y_1<0)
          Hx_ind(iter1,iter2)=Bx_magn(iter1,iter2)/mi0;
          Hy_ind(iter1,iter2)=By_magn(iter1,iter2)/mi0;
      else
          Hx_ind(iter1,iter2)=Bx_magn(iter1,iter2)/mi0;
          Hy_ind(iter1,iter2)=By_magn(iter1,iter2)/mi0;
      end
    end
end

figure(3)
streamslice(x_mesh,y_mesh,Bx_magn,By_magn);
hold on
plot (xx,yy,'Color','R');
plot((-a:a/20:a),(-a:a/20:a)*0,'Color','R');

figure(4)
streamslice(x_mesh,y_mesh,Hx_ind,Hy_ind);
hold on
plot (xx,yy,'Color','R');
plot((-a:a/20:a),(-a:a/20:a)*0,'Color','R');
