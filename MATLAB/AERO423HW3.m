%% Problem 1-a

rVector = [-10063.829, -473.07, 12487.599];
vVector = [-.359, -4.950, .475];
mu = 398600;
r = sqrt(rVector(1)^2 + rVector(2)^2 + rVector(3)^2);
v = sqrt(vVector(1)^2 + vVector(2)^2 + vVector(3)^2);

a = mu / ((2*mu/r)-v^2);

hVector = cross(rVector,vVector);
eVector = (1/mu) .* (cross(vVector,hVector) - (mu/r) .* rVector);

e = sqrt(eVector(1)^2 + eVector(2)^2 + eVector(3)^2);

h = sqrt(hVector(1)^2 + hVector(2)^2 + hVector(3)^2);
hCheck = sqrt(mu*a*(1-e^2));

i = acos(hVector(3)/h) * 180/pi;

bigOmega = acos(-hVector(2)/(h*sin(i*pi/180))) * 180/pi
bigOmegaCheck = asin(hVector(1)/(h*sin(i*pi/180))) * 180/pi

littleOmega = asin(eVector(3)/sin(i*pi/180)) * 180/pi;

phi = acos(dot(transpose(eVector),rVector)/(e*r)) * 180/pi;
%% check to see if phi is within the upper or lower half of the orbit
phiCheck = dot(transpose(rVector),vVector);

%% Problem 1-b

h = 80000;
i = 51.2 * pi/180;
bigOmega = 250 * pi/180;
e = .00083;
littleOmega = 240 * pi/180;
theta = 15 * pi/180;

p = a * (1-e^2);
r = p / (1 + e*cos(theta));
ehat = [cos(bigOmega)*cos(littleOmega) - sin(bigOmega)*sin(littleOmega)*cos(i);
           sin(bigOmega)*cos(littleOmega) + cos(bigOmega)*sin(littleOmega)*cos(i);
           sin(littleOmega)*sin(i)];
qhat = [-cos(bigOmega)*sin(littleOmega) - sin(bigOmega)*cos(littleOmega)*cos(i);
           -sin(bigOmega)*sin(littleOmega) + cos(bigOmega)*cos(littleOmega)*cos(i);
           cos(littleOmega)*sin(i)];
hhat = [sin(bigOmega)*sin(i);
           -cos(bigOmega)*sin(i);
           cos(i)];

rVector = r*cos(theta).*ehat + r*sin(theta).*qhat;

r = sqrt(rVector(1)^2 + rVector(2)^2 + rVector(3)^2);
thetaDot = sqrt(mu*p)/(r^2);
rDot = (r^2) * e * sin(theta) * thetaDot / p;

vVector = (rDot*cos(theta) - r*thetaDot*sin(theta)) .* ehat + (rDot*sin(theta) + r*thetaDot*cos(theta)) .* qhat;

%% Problem 2

R = 13600;
k = 5;
beta = 10:1:350;

T0 = sqrt((R^3)/mu) * 2 * pi;
n0 = 2 * pi / T0;
T1 = T0 - beta .* (pi/180) ./ (k * n0);
a = nthroot(mu .* (T1 ./ (2*pi)).^2,3);
deltah = 2 .* (R - a);
deltav = 2 .* sqrt(mu/R) .* (1 - sqrt(2 .* (R - deltah) ./ (2*R - deltah)));
perigee = 2 .* a - R;

figure
plot(beta,deltav)
title('Total Delta v vs Beta')
xlabel('Beta (deg)')
ylabel('Total Delta v (km/s)')

figure
plot(beta,perigee)
title('Total Delta v vs Perigee Altitude of Transfer Orbit')
xlabel('Perigee Altitude of Transfer Orbit (km)')
ylabel('Total Delta v (km/s)')

%% Problem 3-a

T = 6000;
i = 98.43 * pi/180; % radians
bigOmega = 105 * pi/180; % radians
l = 28.5 * pi/180; % radians

azimuth = asin(cos(i)/cos(l)) * 180/pi; % degrees

rb = 6678;
mu = 398600;
a = nthroot(mu*(T/(2*pi))^2,3)
rc = a;
vb1 = sqrt(mu/rb)
h2 = sqrt(2*mu*rb*rc/(rb+rc))
vb2 = h2/rb
vc2 = h2/rc
dvb = vb2 - vb1
vc3 = sqrt(mu/rc)
dvc = sqrt(vc2^2 + vc3^2 - 2*vc2*vc3*cos(i))
dvtotal = dvb + dvc

%% Problem 3-b

i = 28 * pi/180;

%% Problem 4

altitudeInitial = 300;
mu = 398600.4415;
radiusEarth = 6378.135;
altitudeFinal = 3000;

ra = altitudeInitial + radiusEarth;
rc = altitudeFinal + radiusEarth;

syms rb
deltava = sqrt(2*mu*rb/(ra*(ra+rb))) - sqrt(mu/ra);
deltavb = sqrt(2*mu*rc/(rb*(rb+rc))) - sqrt(2*mu*ra/(rb*(ra+rb)));
deltavc = sqrt(mu/rc) - sqrt(2*mu*rb/(rc*(rb+rc)));
deltavTotal = deltava + deltavb + deltavc;
deltavTotalDerivative = diff(deltavTotal,rb);
rbnumerical = vpasolve(deltavTotalDerivative == 0,rb);

%{ 
I know the slides used fzero instead of vpasolve, but this is
essentially the same method made easier since. Now I can have MATLAB
symbolically differentiate deltavTotal with respect to rb and then
solve for rb
%}

deltavaNumerical = sqrt(2*mu*rbnumerical/(ra*(ra+rbnumerical))) - sqrt(mu/ra);
deltavbNumerical = sqrt(2*mu*rc/(rbnumerical*(rbnumerical+rc))) - sqrt(2*mu*ra/(rbnumerical*(ra+rbnumerical)));
deltavcNumerical = sqrt(mu/rc) - sqrt(2*mu*rbnumerical/(rc*(rbnumerical+rc)));
deltavTotalNumerical = deltavaNumerical + deltavbNumerical + deltavcNumerical;

%% Problem 5-a

RS = 1.433*10^9;
RM = 227.9*10^6;
muSun = 1.327*10^11;
atr = (RS + RM) / 2;
ttr = pi*sqrt((atr^3)/muSun);
TM = 1.881*365.256*23.9345*60*60;
nM = 2*pi/TM;
departureAngle = nM * ttr - pi;
departureAngle = rem(departureAngle,(2*pi));


%% Problem 5-b

muSaturn = 3.7931187*10^7;
muMars = 4.282837*10^4;
vinf1 = sqrt((muSun/RS)*(1 - sqrt(2*RM/(RS+RM))));
vinf2 = sqrt((muSun/RM)*(sqrt(2*RS/(RS+RM)) - 1));
rSaturn = 2*muSaturn / (vinf2^2);
rMars = 2*muMars / (vinf1^2);
dvsd = sqrt(vinf1^2+2*muSaturn/rSaturn) - sqrt(muSaturn/rSaturn);
dvmc = vinf1 / sqrt(2);
dvmd = sqrt(vinf2^2+2*muMars/rMars) - sqrt(muMars/rMars);
dvsc = vinf2 / sqrt(2);
deltavTotal = dvsd + dvmc + dvmd + dvsc;

%% Problem 5-c

TS = 29.46*365.256*23.9345*60*60;
nS = 2*pi/TS;
arrivalAngle = pi - nS*ttr;
twait = (-2*arrivalAngle + 2*pi*1)/(nM-nS);
twait = twait / (365.256*23.9345*60*60);