% Problem 1c graph

x = 0:1:40;
r = 8.431;
k1 = 0.4;
k2 = 4;
E1 = 0.4.*cos(k1.*x);
E2 = 0.4.*cos(k2.*x);
B = 4*10^(-5);
vExB1 = E1.*(1.-0.25.*(k1.^2).*(r.^2))./B;
vExB2 = E2.*(1.-0.25.*(k2.^2).*(r.^2))./B;
figure
plot(x,vExB1,'r',x,vExB2,'b')
legend('k = 0.4','k = 4')
title('x vs Maximim Drift Velocity')
xlabel('Maximum Drift Velocity (m/s)')
ylabel('x (m)')

% Problem 2b graph

a = 0:0.01:0.1;
B = 0.3;
kT = 0.3; % in eV, keeping eV allows me to drop e term in Emax formula
n0 = 10^(-13);
Emax = 2.*0.3.*exp(-0.5)./(a.*sqrt(2));
vExB = Emax./B;
figure
plot(a,vExB)
title('Radius vs Maximum Drift Velocity')
xlabel('Radius (m)')
ylabel('Maximum Drift Velocity (m/s)')