%Problem 3 part a

aoa = pi/18;
Tbs = [cos(aoa) 0 sin(aoa); 0 1 0; -sin(aoa) 0 cos(aoa)];
Tsb = transpose(Tbs);
IB = 32.2 * [1400 0 300; 0 25000 0; 300 0 27000];
Is = Tbs * IB * Tsb

P = cos(pi/18) * pi/2;
R = sin(pi/18) * pi/2;

Ix = Is(1,1);
Iy = Is(3,3);

M0 = R * P * (Ix - Iy)
