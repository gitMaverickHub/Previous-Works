% knowns --------------------------------------------------------!!!!!

P1 = 101300;
T1 = 288;
V1 = 181;
R = 287.16;
Dtip = 0.76;
Dhub = 0.46;
angVel = 8900 * 2*pi/60; %RPM to radians/s
gamma = 1.4;

% Part a --------------------------------------------------------!!!!!

% Radial Locations

r = 0.5.*(Dtip - Dhub).*[0.25;0.5;0.75] + 0.5.*Dhub;

% Equations -----------------------------------------------------

% Location 1
U = r.*angVel;
beta1 = atan(U./V1).*180./pi; % radians to degrees
W1 = sqrt(V1.^2 + U.^2);

% Location 1.5
beta15 = beta1 - 15; % degrees
WU15 = V1.*tan(beta15.*pi./180); % beta15 converted to radians (not globally)
W15 = sqrt(V1.^2 + WU15.^2);
VU15 = U - WU15;
V15 = sqrt(VU15.^2 + V1.^2);
alpha15 = atan(VU15./V1).*180./pi; % radians to degrees

% Location 2
alpha2 = [0;0;0];
for i = 1:3
    if alpha15(i) > 12
        alpha2(i) = alpha15(i)-12; % degrees
    end
end
alpha2;
V2 = V1./cos(alpha2.*pi./180); % alpha2 converted to radians (not globally)

% Part c ---------------------------------------------------------!!!!!

rtip = [.28625; .32375; .38];
rhub = [.23; .28625; .32375];
mdot = P1./(R.*T1) .* pi.*(rtip.^2 - rhub.^2) .* V1;
P = mdot.*U.*(-VU15);
Pc = sum(P);

% Part d ---------------------------------------------------------!!!!!

cp = gamma/(gamma-1) * R;
h01 = cp.*T1 + V1.^2./2;
wc = P./mdot;
h02 = h01 + abs(wc);

% Part e ---------------------------------------------------------!!!!!

T01 = h01./cp;
T02 = h02./cp;
totalPRatio = (T02./T01).^(gamma./(gamma-1));

% Part f ---------------------------------------------------------!!!!!

reaction = (W1.^2 - W15.^2)./(2 .* (abs(wc) + (V1.^2 - V2.^2)./2));

flowCoeff = V1./U;

workCoeff = -(2.*(h02-h01))./(U.^2);

M1 = W1./sqrt(gamma.*R.*T1);
h1 = h01 - V1.^2./2;
h15 = (W1.^2 - W15.^2)./2 + h1;
T15 = h15./cp;
M15blade = W15./sqrt(gamma.*R.*T15);
M15vane = V15./sqrt(gamma.*R.*T15);
T2 = (h02 - V2.^2./2)./cp;
M2 = V2./sqrt(gamma.*R.*T2);

deHaller = W15./W1