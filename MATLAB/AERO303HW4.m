%Problem 4 ------------------------------------------------------------
%Part a)

gamma = 1.4;
shockStrength = [0.05641; 0.663300; 2.14159];

pRatio = 1 + shockStrength;
m1 = sqrt(1 + ((gamma + 1) / (2 * gamma)) * shockStrength);
m2 = [0;0;0];
for i = 1:3
    m2(i,1) = sqrt((1 + ((gamma + 1)/(2 * gamma)) * shockStrength(i,1)) / (1+shockStrength(i,1)));
end
tRatio1 = 1 + (2 * (gamma - 1) * (m1(1,1).^2 - 1) * (gamma * m1(1,1).^2 + 1)) / ((gamma + 1).^2 * m1(1,1).^2);
tRatio2 = 1 + (2 * (gamma - 1) * (m1(2,1).^2 - 1) * (gamma * m1(2,1).^2 + 1)) / ((gamma + 1).^2 * m1(2,1).^2);
tRatio3 = 1 + (2 * (gamma - 1) * (m1(3,1).^2 - 1) * (gamma * m1(3,1).^2 + 1)) / ((gamma + 1).^2 * m1(3,1).^2);
pStagRatio = [0;0;0];
for j = 1:3
    pStagRatio(j,1) = (1 / ((1 + shockStrength(j,1)).^(1 / (gamma - 1)))) * ((1 + ((gamma + 1) / (2 * gamma)) * shockStrength(j,1))/(1 + ((gamma - 1) / (2 * gamma)) * shockStrength(j,1))).^(gamma / (gamma - 1));
end

%Part b)
approxM2 = [0;0;0];
for i = 1:3
    approxM2(i,1) = sqrt(1 - ((gamma-1)/(2*gamma)) * shockStrength(i,1));
end
approxTRatio = 1 + ((gamma-1)/gamma) * shockStrength;
approxPStagRatio = [0;0;0];
for i = 1:3
    approxPStagRatio(i,1) = 1 - ((gamma+1)/(12*gamma.^2)) * shockStrength(i,1).^3;
end