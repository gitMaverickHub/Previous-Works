%%Problem 3

we = 2354.57;
wexe = 14.324;
weye = -2.26*10^(-3);
Be = 1.99824;
alphae = 0.017318;
De = 5.76*10^(-6);
ev = zeros(7);
er = zeros(7,5);

for v = 1:1:7
    Bv = Be - alphae * (v + 0.5);
    Dv = De;
    ev(v) = we * (v + 0.5) - wexe * (v + 0.5)^2 + weye * (v + 0.5)^3;
    for j = 1:1:5
        er(v,j) = Bv * (j + 1) - Dv * (j*(j + 1))^2;
    end
end

er
ev