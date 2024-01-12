z=(-2:0.02:2); %z/λ

Z0=376.73;
K0=1;
fi=pi./4;

d=0.5;

E1 = (1/2).*Z0.*K0.*exp(1i.*(fi+2.*pi.*z)).*(-1+exp(-2.*1i.*2.*pi.*d));

E2 = (1/2).*Z0.*K0.*exp(1i.*(fi-2.*pi.*d)).*1i.*sin(2.*pi.*(z-d));

E = (z<=0).*E1 + (z>0).*(z<=d).*E2;

H1 = (-1/2).*K0.*exp(1i.*(fi+2.*pi.*z)).*(-1+exp(-2.*1i.*2.*pi.*d));

H2 = (-1/2).*K0.*exp(1i.*(fi-2.*pi.*d)).*cos(2.*pi.*(z-d));

H = (z<=0).*H1 + (z>0).*(z<=d).*H2;

figure(1)
plot(z,E);
hold on
title("E");
xline(0);
xline(d);

figure(2)
plot(z,H);
hold on
title("H");
xline(0);
xline(d);

