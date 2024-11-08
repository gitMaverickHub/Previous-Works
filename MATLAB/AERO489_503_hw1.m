p = 101325;
kB = 1.381.*10.^(-23);
me = 9.109.*10.^(-31);
h = 6.626.*10.^(-34);
Ui = 1.602.*10.^(-18);
T = 10700:1:10800;
LHS = 0.16.*p./(kB.*T);
RHS = 2.*(((2.*pi.*me.*kB.*T).^(3/2))./(h.^3)).*exp(-Ui./(kB.*T));
figure
plot(T,LHS,'r',T,RHS,'b')
legend('LHS','RHS')
title('Temp vs Particle Density part a')
xlabel('Temperature (K)')
ylabel('Particle Density per Meter Cubed')

Ui = 12.*1.602.*10^(-19);
T = 12400:1:12500;
LHS = 0.16.*p./(kB.*T);
RHS = 2.*(((2.*pi.*me.*kB.*T).^(3/2))./(h.^3)).*exp(-Ui./(kB.*T));
figure
plot(T,LHS,'r',T,RHS,'b')
legend('LHS','RHS')
title('Temp vs Particle Density part c')
xlabel('Temperature (K)')
ylabel('Particle Density per Meter Cubed')
