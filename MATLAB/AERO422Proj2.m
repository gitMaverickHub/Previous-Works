s = tf('s');
Pnum = 160*(s+2.5)+(s+0.7);
Pdenom = (s^2+5*s+40)*(s^2+0.03*s+0.06);
P = Pnum/Pdenom;

figure(1);
rlocus(P);

K = 2.5;
dc = (s+4)/(s+28);
C = K*dc; %For Lead Compensator
Gyr = minreal((C*P)/(1+C*P));
Z = ((C*P)/(1+C*P));

figure(2);
step(Gyr);
figure(3);
rlocus(Z);

disp('Overshoot = 6.16%');
disp('rise time = 0.957');
