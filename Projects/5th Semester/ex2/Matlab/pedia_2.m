v1=1e3;
T1=1./v1;
t1=(0:T1/5:25*T1);
t1=t1.';

v2=5e3;
T2=1./v2;
t2=(0:T2/2:80*T2);
t2=t2.';

h0=1e-3;
h1=1e-4;
P0=1e-4;
d=2e-5;
R=5e6;
LW=1e-4;

figure(1)
[t1_sol, u1_sol]=ode45(@(t1,u1) (((h0+h1.*cos(2.*pi.*v1.*t1)).*u1./(LW*R)) + (((d*P0) - u1)./(h0+h1.*cos(2.*pi.*v1.*t1))).*(2.*pi.*v1.*h1.*sin(2.*pi.*v1.*t1))), t1, zeros(501,1));
plot(t1_sol,u1_sol);

figure(2)
[t2_sol, u2_sol]=ode45(@(t2,u2) (((h0+h1.*cos(2.*pi.*v2.*t2)).*u2./(LW*R)) + (((d*P0) - u2)./(h0+h1.*cos(2.*pi.*v2.*t2))).*(2.*pi.*v2.*h1.*sin(2.*pi.*v2.*t2))), t2, zeros(501,1));
plot(t2_sol,u2_sol);

v=exp(linspace(log(5e1),log(2e4),10));
v=v.';
T=1./v;
V=zeros(126,501,10);

for i=1:length(v)
    T=1./v(i);
    t=(0:T/5:25*T);
    t=t.';
    [t_sol, u_sol]=ode45(@(t,u) (((h0+h1.*cos(2.*pi.*v(i).*t)).*u./(LW*R)) + (((d*P0) - u(i))./(h0+h1.*cos(2.*pi.*v(i).*t))).*(2.*pi.*v(i).*h1.*sin(2.*pi.*v(i).*t))), t, zeros(501,1));
    usin=sin(u_sol);
    V(:,:,i)=usin;
end

B=permute(V,[3 1 2]);
C=squeeze(B(:,2,:));

figure(3)
semilogx(v,C);


