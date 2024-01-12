%c
e0 = 8.85419e-12;
m0 = pi*4e-7;

f = (1e9:1e4:1.5e9);

d = 1;
k = 2*pi*sqrt(e0*m0).*f;
Z = sqrt(m0/e0);

num=size(k,2);

A(1,1,:) = exp(-j*d.*k);
A(1,2,:) = exp(j*d.*k);
A(1,3,:) = zeros(1,num);
A(1,4,:) = zeros(1,num);

A(2,1,:) = ones(1,num);
A(2,2,:) = ones(1,num);
A(2,3,:) = -ones(1,num);
A(2,4,:) = -ones(1,num);

A(3,1,:) = zeros(1,num);
A(3,2,:) = zeros(1,num);
A(3,3,:) = exp(j*d.*k);
A(3,4,:) = exp(-j*d.*k);

A(4,1,:) = 1/Z.*ones(1,num);
A(4,2,:) = -1/Z.*ones(1,num);
A(4,3,:) = -1/Z.*ones(1,num);
A(4,4,:) = 1/Z.*ones(1,num);

for i=1:num
        deter(i)=det(A(:,:,i));
end

figure(1)
plot(f,abs(deter));

B = [0; 0; 0; 1];
for i=1:num
    X(i,:) = B \ A(:,:,i);
end

E2_pos=X(:,2);

figure(2)
plot(f,E2_pos);

%d
f1=1.15e9;
k1 = 2*pi*sqrt(e0*m0).*f1;
A1=[exp(-j*d*k1) exp(j*d*k1) 0 0; 1 1 -1 -1; 0 0 exp(j*d*k1) exp(-j*d*k1); 1/Z -1/Z -1/Z 1/Z];
x1=B\A1;

z=(-1.5:0.001:1.5);

E1 = x1(1).*exp(-j*k1.*z) + x1(2).*exp(j*k1.*z);

E2 = x1(3).*exp(-j*k1.*z) + x1(4).*exp(j*k1.*z);

E = (z>=0).*(z<=d).*E1 + (z<0).*(z>=-d).*E2;

H1 = x1(1)./Z.*exp(-j*k1.*z) - x1(2)./Z.*exp(j*k1.*z);

H2 = x1(3)./Z.*exp(-j*k1.*z) - x1(4)./Z.*exp(j*k1.*z);

H = (z>=0).*(z<=d).*H1 + (z<0).*(z>=-d).*H2;

figure(3)
plot(z,real(E));
hold on
title("Re{E}");
xline(-d);
xline(0);
xline(d);

figure(4)
plot(z,imag(E));
hold on
title("Im{E}");
xline(-d);
xline(0);
xline(d);

figure(5)
plot(z,real(H));
hold on
title("Re{H}");
xline(-d);
xline(0);
xline(d);

figure(6)
plot(z,imag(H));
hold on
title("Im{H}");
xline(-d);
xline(0);
xline(d);

%same for f1=1.05e9