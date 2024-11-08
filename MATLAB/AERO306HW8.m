% Problem 1 part c ------------------------------------------------------

syms s

EI = 100;
L = 10;

Pcr = (96.*EI.*L.^3 - 48.*EI.*s.*L.^2 + 8.*EI.*s.^2.*L)./((288./5).*L.^5 - 48.*s.*L.^4 + (32./3).*s.^2.*L.^3);

firstDerPcr = diff(Pcr,s) == 0;

sPcrExtrema = double(solve(firstDerPcr,s));

secondDerPcr = diff(diff(Pcr,s),s);

minORmax = double(subs(secondDerPcr,s,sPcrExtrema(1)));

% graph to verify
Pcr = @(s) (96.*EI.*L.^3 - 48.*EI.*s.*L.^2 + 8.*EI.*s.^2.*L)./((288./5).*L.^5 - 48.*s.*L.^4 + (32./3).*s.^2.*L.^3);
s = 0:20;
plot(s,Pcr(s))

% Problem 7 -------------------------------------------------------------

% finding h functions ---------------------------------------------------

syms a x

eqn1 = int(((x-3).^2./a + 1).^2,x,0,6) == 100;
aConcavea = double(solve(eqn1,a));

eqn2 = int((-(x-3).^2./a + 9/a + 1).^2,x,0,6) == 100; 
aConvexa = double(solve(eqn2,a)); 

eqn3 = int(((x-6).^2./a + 12./a).^2,x,0,6) == 100;
bConcavea = double(solve(eqn3,a));

eqn4 = int((a*x-8*a).^2,x,0,6) == 100;
bLineara = double(solve(eqn4,a));

eqn5 = int((-x.^2./a+48./a).^2,x,0,6) == 100;
bConvexa = double(solve(eqn5,a));

eqn6 = int((x.^2./a+12./a).^2,x,0,6) == 100;
cConcavea = double(solve(eqn6,a));

eqn7 = int((a*x+2*a).^2,x,0,6) == 100;
cLineara = double(solve(eqn7,a));

eqn8 = int((-(x-6).^2./a + 48./a).^2,x,0,6) == 100;
cConvexa = double(solve(eqn8,a));

aConcaveh = (x-3).^2./aConcavea(2) + 1;
aLinearh = sqrt(100/6);
aConvexh = -(x-3).^2./aConvexa(2) + 9./aConvexa(2) + 1;

bConcaveh = (x-6).^2./bConcavea(2) + 12./bConcavea(2);
bLinearh = bLineara(1) - 8.*bLineara(1);
bConvexh = -x.^2./bConvexa(2) + 48./bConvexa(2);

cConcaveh = x.^2./cConcavea(2) + 12./cConcavea(2);
cLinearh = cLineara(2).*x + 2.*cLineara(2);
cConvexh = -(x-6)./cConvexa(2) + 48./cConvexa(2);

% Finding Pcr ------------------------------------------------------------

aConcavePcr = double(MaxLoad(aConcaveh));
aLinearPcr = double(MaxLoad(aLinearh));
aConvexPcr = double(MaxLoad(aConvexh));

bConcavePcr = double(MaxLoad(bConcaveh));
bLinearPcr = double(MaxLoad(bLinearh));
bConvexPcr = double(MaxLoad(bConvexh));

cConcavePcr = double(MaxLoad(cConcaveh));
cLinearPcr = double(MaxLoad(cLinearh));
cConvexPcr = double(MaxLoad(cConvexh));

function Pcr = MaxLoad(h)

syms P x

L = 10;
E = 10.^6;

I = h.^4./12;

Ksigma = -P.*L.^3.*[4./3, 3./2.*L, 8./5.*L.^2;...
                   3./2*L, 9./5.*L.^2, 2.*L.^3;...
                   8./5.*L.^2, 2.*L.^3, 16./7.*L.^4];

Ko = E.*int(I.*[4, 12.*x, 24.*x.^2;...
                12.*x, 36.*x.^2, 72.*x.^3;...
                24.*x.^2, 72.*x.^2, 144.*x.^4],x,0,L);

K = Ko + Ksigma;

eqn = det(K) == 0;

Pcr = solve(eqn,P);
    
end