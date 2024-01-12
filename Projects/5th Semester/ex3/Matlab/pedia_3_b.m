c=linspace(0,360,360);
a1=0.02;
L1=-(a1*a1/4).*(cos(c).*(-2/15)+sin(c).*(-2/sqrt(5))+(sin(c)-2.*cos(c)).*(2/15));
figure(1)
plot(c,L1);
title("a=0.02");

figure(2)
a2=0.5;
L2=-(a2*a2/4).*(cos(c).*(-2/15)+sin(c).*(-2/sqrt(5))+(sin(c)-2.*cos(c)).*(2/15));
plot(c,L2);
title("a=0.5");
