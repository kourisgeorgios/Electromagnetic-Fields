function [rte, tte, rtm, ttm] = fresnel_equations (theta1, epsilon1, epsilon2, nfig)
%
%  [rte, tte, rtm, ttm] = fresnel_equations (theta1, epsilon1, epsilon2, nfig)
%
%
%  Fresnel Equations Calculation
%
%    INPUTS
%    theta1   = vector of angles of incidence (deg)
%    epsilon1 = relative permittivities of region 1
%    epsilon2 = relative permittivities of region 2 [epsilon2 can be complex = (n-jk)^2]
%                    if k > 0 (in n-jk) this correspond to lossy material
%                    if k < 0 (in n-jk) this correspond to active (with gain) material
%    nfig     = initial figure number
%
%    OUTPUTS
%    rte      = reflection coefficient for TE Polarization
%    tte      = transmission coefficient for TE Polarization
%    rtm      = reflection coefficient for TM Polarization
%    ttm      = transmission coefficient for TM Polarization
%
%    Examples Cases:
%    [rte, tte, rtm, ttm] = fresnel_equations ([0:0.01:89.99], 1^2, 1.5^2, 1);  (lossless materials) (low-high)
%    [rte, tte, rtm, ttm] = fresnel_equations ([0:0.01:89.99], 1.5^2, 1^2, 1);  (lossless materials) (high-low)
%    [rte, tte, rtm, ttm] = fresnel_equations ([0:0.01:89.99], 1^2, (0.855-i*1.8955)^2, 1);  (lossy material2) 
%    [rte, tte, rtm, ttm] = fresnel_equations ([0:0.01:89.99], 1.7^2, (1.3+i*0.2)^2, 1);  (active material2)
%


theta1r = theta1*pi/180;
n1 = sqrt(epsilon1);
n2 = sqrt(epsilon2);
sin_theta2 = n1*sin(theta1r)./n2;
ii=find(abs(sin_theta2)>1);
cos_theta1 = cos(theta1r); 

cos_theta2 = sqrt(1-sin_theta2.^2);

if imag(n2) < 0                %  lossy region 2
   zaux = -i*n2*cos_theta2;
   if real(zaux) <= 0
      cos_theta2 = zaux/(-i*n2);
   else
      cos_theta2 = -zaux/(-i*n2);
   end
elseif imag(n2) > 0           %  active region 2
   zaux = -i*n2*cos_theta2;
   if real(zaux) <= 0
      cos_theta2 = -zaux/(-i*n2);
   else
      cos_theta2 = +zaux/(-i*n2);
   end
else                          %  above theta critical (real n2)
   cos_theta2(ii)= -cos_theta2(ii);
end


rte = (n1*cos_theta1-n2*cos_theta2)./(n1*cos_theta1+n2*cos_theta2);
tte = (2*n1*cos_theta1)./(n1*cos_theta1+n2*cos_theta2);
rtm = (n2*cos_theta1-n1*cos_theta2)./(n2*cos_theta1+n1*cos_theta2);
ttm = (2*n1*cos_theta1)./(n2*cos_theta1+n1*cos_theta2);
ttemax = max(abs(tte));
ttmmax = max(abs(ttm));

figure(nfig)

subplot(2,2,1)
plot(theta1,abs(rte),'b','LineWidth',1.5)
axis([0 90 0 1])
set(gca,'Fontsize',12,'Fontweight','bold')
xlabel('Angle \theta_1 (deg)','Fontsize',12)
ylabel('|r_{TE}|','Fontsize',12)
ylim([0,1.05])
title(['n_1 = ',num2str(sqrt(epsilon1)), '  n_2 = ',num2str(sqrt(epsilon2))],'Fontsize',11)
grid on

subplot(2,2,2)
plot(theta1,angle(rte)*180/pi,'b','LineWidth',1.5)
axis([0 90 -180 180])
set(gca,'Fontsize',12,'Fontweight','bold')
ylim([-200 200])
xlabel('Angle \theta_1 (deg)','Fontsize',12)
ylabel('Phase of r_{TE}','Fontsize',12)
title(['n_1 = ',num2str(sqrt(epsilon1)), '  n_2 = ',num2str(sqrt(epsilon2))],'Fontsize',11)
grid on

subplot(2,2,3)
plot(theta1,abs(rtm),'r','LineWidth',1.5)
axis([0 90 0 1])
set(gca,'Fontsize',12,'Fontweight','bold')
xlabel('Angle \theta_1 (deg)','Fontsize',12)
ylabel('|r_{TM}|','Fontsize',12)
ylim([0,1.05])
title(['n_1 = ',num2str(sqrt(epsilon1)), '  n_2 = ',num2str(sqrt(epsilon2))],'Fontsize',11)
grid on

subplot(2,2,4)
plot(theta1,angle(rtm)*180/pi,'r','LineWidth',1.5)
axis([0 90 -180 180])
set(gca,'Fontsize',12,'Fontweight','bold')
ylim([-200 200])
xlabel('Angle \theta_1 (deg)','Fontsize',12)
ylabel('Phase of r_{TM}','Fontsize',12)
title(['n_1 = ',num2str(sqrt(epsilon1)), '  n_2 = ',num2str(sqrt(epsilon2))],'Fontsize',11)
grid on

nfig = nfig+1;
figure(nfig)

subplot(2,2,1)
plot(theta1,abs(tte),'b','LineWidth',1.5)
axis([0 90 0 ttemax])
set(gca,'Fontsize',12,'Fontweight','bold')
xlabel('Angle \theta_1 (deg)','Fontsize',12)
ylabel('|t_{TE}|','Fontsize',12)
title(['n_1 = ',num2str(sqrt(epsilon1)), '  n_2 = ',num2str(sqrt(epsilon2))],'Fontsize',11)
grid on

subplot(2,2,2)
plot(theta1,angle(tte)*180/pi,'b','LineWidth',1.5)
axis([0 90 -180 180])
ylim([-200 200])
set(gca,'Fontsize',12,'Fontweight','bold')
xlabel('Angle \theta_1 (deg)','Fontsize',12)
ylabel('Phase of t_{TE}','Fontsize',12)
title(['n_1 = ',num2str(sqrt(epsilon1)), '  n_2 = ',num2str(sqrt(epsilon2))],'Fontsize',11)
grid on

subplot(2,2,3)
plot(theta1,abs(ttm),'r','LineWidth',1.5)
axis([0 90 0 ttmmax])
set(gca,'Fontsize',12,'Fontweight','bold')
xlabel('Angle \theta_1 (deg)','Fontsize',12)
ylabel('|t_{TM}|','Fontsize',12)
title(['n_1 = ',num2str(sqrt(epsilon1)), '  n_2 = ',num2str(sqrt(epsilon2))],'Fontsize',11)
grid on

subplot(2,2,4)
plot(theta1,angle(ttm)*180/pi,'r','LineWidth',1.5)
axis([0 90 -180 180])
ylim([-200 200])
set(gca,'Fontsize',12,'Fontweight','bold')
xlabel('Angle \theta_1 (deg)','Fontsize',12)
ylabel('Phase of t_{TM}','Fontsize',12)
title(['n_1 = ',num2str(sqrt(epsilon1)), '  n_2 = ',num2str(sqrt(epsilon2))],'Fontsize',11)
grid on

Refl_Power_TE = abs(rte).^2;
Tran_Power_TE = (real(n2.*cos_theta2)./(n1.*cos_theta1)).*(abs(tte).^2);
Refl_Power_TM = abs(rtm).^2;
Tran_Power_TM = (real(conj(n2).*cos_theta2)./(n1.*cos_theta1)).*(abs(ttm).^2);

nfig = nfig+1;
figure(nfig)


subplot(2,1,1)
plot(theta1,Refl_Power_TE,theta1,Tran_Power_TE,'Linewidth',1.5)
axis([0 90 0 1])
ylim([0,1.05])
legend('R','T')
legend boxoff
set(gca,'Fontsize',12,'Fontweight','bold')
xlabel('Angle \theta_1 (deg)','Fontsize',12)
ylabel('R and T Power','Fontsize',12)
title(['TE Polarization,','  n_1 = ',num2str(sqrt(epsilon1)), ',  n_2 = ',num2str(sqrt(epsilon2))],'Fontsize',11)
grid on

subplot(2,1,2)
plot(theta1,Refl_Power_TM,theta1,Tran_Power_TM,'Linewidth',1.5)
axis([0 90 0 1])
ylim([0,1.05])
legend('R','T')
legend boxoff
set(gca,'Fontsize',12,'Fontweight','bold')
xlabel('Angle \theta_1 (deg)','Fontsize',12)
ylabel('R and T Power','Fontsize',12)
title(['TM Polarization,','  n_1 = ',num2str(sqrt(epsilon1)), ',  n_2 = ',num2str(sqrt(epsilon2))],'Fontsize',11)
grid on

nfig = nfig+1;
figure(nfig)


subplot(2,1,1)
plot(theta1,Refl_Power_TE,'b',theta1,Refl_Power_TM,'r','Linewidth',1.5)
axis([0 90 0 1])
ylim([0,1.05])
set(gca,'Fontsize',12,'Fontweight','bold')
legend('TE','TM')
legend boxoff
xlabel('Angle \theta_1 (deg)','Fontsize',12)
ylabel('R_{TE} and R_{TM} Power','Fontsize',12)
title(['n_1 = ',num2str(sqrt(epsilon1)), ',  n_2 = ',num2str(sqrt(epsilon2))],'Fontsize',11)
grid on

subplot(2,1,2)
plot(theta1,Tran_Power_TE,'b',theta1,Tran_Power_TM,'r','Linewidth',1.5)
axis([0 90 0 1])
ylim([0,1.05])
set(gca,'Fontsize',12,'Fontweight','bold')
legend('TE','TM')
legend boxoff
xlabel('Angle \theta_1 (deg)','Fontsize',12)
ylabel('T_{TE} and T_{TM} Power','Fontsize',12)
title(['n_1 = ',num2str(sqrt(epsilon1)), ',  n_2 = ',num2str(sqrt(epsilon2))],'Fontsize',11)
grid on

nfig = nfig+1;
figure(nfig)

Tot_TE = Refl_Power_TE + Tran_Power_TE;
Tot_TM = Refl_Power_TM + Tran_Power_TM;
Bot = min(1-Tot_TE,1-Tot_TM);
Top = max(1-Tot_TE,1-Tot_TM);
plot(theta1,1-Tot_TE,'b',theta1,1-Tot_TM,'r','Linewidth',2)
set(gca,'Fontsize',12,'Fontweight','bold')

xlabel('Angle \theta_1 (deg)','Fontsize',12)
ylabel('1-(R+T) ','Fontsize',12)
title(['n_1 = ',num2str(sqrt(epsilon1)), ',  n_2 = ',num2str(sqrt(epsilon2))],'Fontsize',11)
grid on