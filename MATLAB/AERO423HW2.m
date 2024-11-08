M = 59.78;
e = 0.25;
E0 = 100;  % Initial E guess
E1 = E0 - (E0-e*sin(E0*pi/180)-M)/(1-e*cos(E0*pi/180));
tol = 0.1; % tolerance
E = E0;
n = 0;
while abs(E1-E0) > tol
   E = cat(1,E,E1);
   n = cat(1,n,length(n));
   temp = E1 - (E1-e*sin(E1*pi/180)-M)/(1-e*cos(E1*pi/180));
   E0 = E1;
   E1 = temp;
end
figure
plot(n,E)
title('Iterations vs Eccentricity')
xlabel('Iteration')
ylabel('Eccentricity (degrees)')
