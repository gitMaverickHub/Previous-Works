%Problem 2

aM1 = 5;
bM1 = 6;
cM1 = 7;
dM1 = 8;

aB = 44.4270;
bB = 48.5904;
cB = 51.7868;
dB = 54.3409;

anormalM1 = normalM1(aM1,aB);
bnormalM1 = normalM1(bM1,bB);
cnormalM1 = normalM1(cM1,cB);
dnormalM1 = normalM1(dM1,dB);

adelta = delta(aM1,aB);
bdelta = delta(bM1,bB);
cdelta = delta(cM1,cB);
ddelta = delta(dM1,dB);

anormalM2 = 0.4512;
bnormalM2 = 0.4236;
cnormalM2 = 0.4090;
dnormalM2 = 0.4004;

aM2 = M2(anormalM2,aB,adelta);
bM2 = M2(bnormalM2,bB,bdelta);
cM2 = M2(cnormalM2,cB,cdelta);
dM2 = M2(dnormalM2,dB,ddelta);

function NACA1135M1 = normalM1(M1,beta)
    NACA1135M1 = M1*sin(beta*pi/180);
end

function trueM2 = M2(NACA1135M2,beta,delta)
    trueM2 = NACA1135M2/sin((beta*pi/180)-(delta*pi/180));
end

function deflectionAngle = delta(M1,beta)
    deflectionAngle = (180/pi)*2*cot(beta*pi/180)*...
        ((M1.^2*(sin(beta*pi/180)).^2-1)/(M1.^2*(1.4+cos(2*beta*pi/180))+2));
end