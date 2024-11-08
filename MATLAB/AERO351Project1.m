% Given ------------------------------------------------------------

a = 5;
b = 7;
c = 8;
d = 4;
A = 100*a;
B = .01*b;
C = .4*c;
D = 10*d;

% H = 10000+A meters %unnecessary for code
M = .8+B;
OPR = 40+C;
T03  = 1400+D; % Kelvin
pressureRatioDiffuser = 0.98;
fanEfficiency = .84;
compressorEfficiency = .87;
pressureRatioFan = 1.7;
BPR = 5.5;
aMassFlowRate = 50; % kg/s
pressureDrop = .03;
combustionEfficiency = .91;
R = .28716; % kJ/(kg*K)
LHV = 43500; % kJ/kg
minL = 14.66;
HPTEfficiency = .92;
LPTEfficiency = .93;
gg5Efficiency = .97;
fan5Efficiency = .99;

% from Appendix A using H

pa = .244744; % bar
Ta = 219.9; % Kelvin
a = 297.275; % m/s

% Inlet --------------------------------------------------------------

u = M*a;

ha  = interpolation(Ta,219.16,220.16,219.1,220); % kJ/(kg*K)
h0a = ha*1000 + u.^2/2; % J/(kg*K)
h0a = h0a/1000; % kJ/(kg*K)

s0a = sMethod(Ta,pa,219.16,220.16,6.3885,6.3927);
p0a = pMethod(h0a,s0a,253.2,254.2,6.5311,6.5350);

p01 = pressureRatioDiffuser * p0a;
h01 = h0a;
s01 = sMethod(h01,p01,253.2,254.2,6.5311,6.5350);

% Fan ----------------------------------------------------------------

s02fi = s01;
p02fi = pressureRatioFan * p01;
s02fibar = hMethodPart1(s02fi,p02fi);
h02fi = interpolation(s02fibar,6.6819,6.6854,294.3,295.3);

p02f = p02fi;
h02f = (h02fi-h01)/fanEfficiency + h01;
s02f = sMethod(h02f,p02f,302.3,303.3,6.7088,6.7121);

s5fi = s02f;
p5fi = p01;
s5fibar = hMethodPart1(s5fi,p5fi);
h5fi = interpolation(s5fibar,6.5542,6.5581,259.2,260.2);

p5f = p5fi;
h05f = h02f;
c5fi = sqrt(2*(h05f-h5fi)*1000);
c5f = fan5Efficiency*c5fi;
h5f = h05f*1000 - c5f.^2/2; % J/(kg*K)
h5f = h5f/1000; % kJ/(kg*K)
s5f = sMethod(h5f,p5f,260.2,261.2,6.5581,6.5619);

% Gas Generator ------------------------------------------------------

s02i = s01;
p02 = OPR * p01;
p02i = p02;
sbar = hMethodPart1(s02i,p02i);
h02i = interpolation(sbar,7.6124,7.6139,738.1,739.2);

h02 = (h02i-h01)/compressorEfficiency + h01;
s02 = sMethod(h02,p02,809.9,811.0,7.7029,7.7043);

p03 = p02 * (1-pressureDrop);
h03air = interpolation(T03,1439.16,1440.16,1562.2,1565.5);
h03lambda1 = interpolation(T03,1439.16,1440.16,1695.5,1696.8);
lambda = (h03lambda1*(1+minL) - combustionEfficiency*LHV - h03air*minL)/(minL*(h02-h03air));
r = (1+minL)/(1+lambda*minL);
q = (lambda-1)*minL/(1+lambda*minL);
h03 = r*h03lambda1 + q*h03air; % or h03lambda
s03lambda1bar = interpolation(T03,1439.16,1440.16,8.7556,8.7565);
s03airbar = interpolation(T03,1439.16,1440.16,8.3951,8.3960);
s03bar = r*s03lambda1bar + q*s03airbar;
s03 = s03bar - R*log(p03); % or s03lambda

s04hi = s03;
wc = h02-h01;
wHPT = wc/(1+(1/(lambda*minL)));
h04hi = -wHPT/HPTEfficiency + h03;
% %iterate to find temp and use with p method to find p
T04hia = interpolation(h04hi,1013.1,1014.2,971.16,972.16);
T04hilambda1 = interpolation(h04hi,1013.1,1014.4,914.16,915.16);
T04hiiter1 = r*T04hilambda1 + q*T04hia;
h04hilambda1iter1 = interpolation(T04hiiter1,953.16,954.16,1061.7,1063);
h04hiaiter1 = interpolation(T04hiiter1,953.16,954.16,992.7,993.8);
fT04hiiter1 = h04hi - r*h04hilambda1iter1 - q*h04hiaiter1;
fT04hiiter2 = h04hi - r*1058 - q*989.3;
T04hiiter3 = interpolation(0,fT04hiiter2,fT04hiiter1,950.16,T04hiiter1);
h04hiaiter3 = interpolation(T04hiiter3,952.16,953.16,991.5,992.7);
h04hilambda1iter3 = interpolation(T04hiiter3,952.16,953.16,1060.5,1061.7);
fT04hiiter3 = h04hi - r*h04hilambda1iter3 - q*h04hiaiter3;
T04hi = T04hiiter3;
s04hilambda1bar = interpolation(T04hi,952.16,953.16,8.2184,8.2197);
s04hiabar = interpolation(T04hi,952.16,953.16,7.912,7.9132);
s04hibar = r*s04hilambda1bar + q*s04hiabar;
p04hi = exp(-(s04hi-s04hibar)/R);

p04h = p04hi;
h04h = h03 - wHPT;
%iterate to find temp and use with s method to find s
T04ha = interpolation(h04h,1060.9,1062.1,1014.16,1015.16);
T04hlambda1 = interpolation(h04h,1060.6,1061.7,952.16,953.16);
T04hiter1 = r*T04hlambda1 + q*T04ha;
h04hlambda1iter1 = interpolation(T04hiter1,994.16,995.16,1113.2,1114.4);
h04haiter1 = interpolation(T04hiter1,994.16,995.16,1039.2,1040.3);
fT04hiter1 = h04h - r*h04hlambda1iter1 - q*h04haiter1;
fT04hiter2 = h04h - r*1108.2 - q*1034.7;
T04hiter3 = interpolation(0,fT04hiter2,fT04hiter1,990.16,T04hiter1);
h04haiter3 = interpolation(T04hiter3,992.16,993.16,1036.9,1038.1);
h04hlambda1iter3 = interpolation(T04hiter3,992.16,993.16,1110.7,1111.9);
fT04hiter3 = h04h - r*h04hlambda1iter3 - q*h04haiter3;
T04h = T04hiter3;
s04hlambda1bar = interpolation(T04h,992.16,993.16,8.2698,8.2711);
s04habar = interpolation(T04h,992.16,993.16,7.9587,7.9599);
s04hbar = r*s04hlambda1bar + q*s04habar;
s04h = s04hbar - R*log(p04h);

s04li = s04h;
wf = h02f - h01;
wLPT = BPR*wf/(1+(1/(lambda*minL)));
h04li = -wLPT/LPTEfficiency + h04h;
% %iterate to find temp and use with p method to find p
T04lia = interpolation(h04li,773.9,775,756.16,757.16);
T04lilambda1 = interpolation(h04li,774.7,775.9,717.16,718.16);
T04liiter1 = r*T04lilambda1 + q*T04lia;
h04lilambda1iter1 = interpolation(T04liiter1,744.16,745.16,806.7,807.9);
h04liaiter1 = interpolation(T04liiter1,744.16,745.16,793.5,794.6);
fT04liiter1 = h04li - r*h04lilambda1iter1 - q*h04liaiter1;
fT04liiter2 = h04li - r*804.3 - q*758.7;
T04liiter3 = interpolation(0,fT04liiter2,fT04liiter1,742.16,T04liiter1);
h04liaiter3 = interpolation(T04liiter3,742.16,743.16,758.7,759.8);
h04lilambda1iter3 = interpolation(T04liiter3,742.16,743.16,804.3,805.5);
fT04liiter3 = h04li - r*h04lilambda1iter3 - q*h04liaiter3;
fT04liiter4 = h04li - r*805.5 - q*759.8;
T04liiter5 = interpolation(0,fT04liiter4,fT04liiter3,743.16,T04liiter3);
h04liaiter5 = interpolation(T04liiter5,743.16,744.16,759.8,760.9);
h04lilambda1iter5 = interpolation(T04liiter5,743.16,744.16,805.5,806.7);
fT04liiter5 = h04li - r*h04lilambda1iter5 - q*h04liaiter5;
T04li = T04liiter5;
s04lilambda1bar = interpolation(T04li,743.16,744.16,7.9172,7.9188);
s04liabar = interpolation(T04li,743.16,744.16,7.6375,7.6389);
s04libar = r*s04lilambda1bar + q*s04liabar;
p04li = exp(-(s04li-s04libar)/R);

p04l = p04li;
h04l = h04h - wLPT;
%iterate to find temp and use with s method to find s
T04la = interpolation(h04l,794.6,795.7,775.16,776.16);
T04llambda1 = interpolation(h04l,794.8,796,734.16,735.16);
T04liter1 = r*T04llambda1 + q*T04la;
h04llambda1iter1 = interpolation(T04liter1,761.16,762.16,827,828.2);
h04laiter1 = interpolation(T04liter1,761.16,762.16,779.4,780.5);
fT04liter1 = h04l - r*h04llambda1iter1 - q*h04laiter1;
fT04liter2 = h04l - r*827 - q*779.4;
T04liter3 = interpolation(0,fT04liter2,fT04liter1,761.16,T04liter1);
h04laiter3 = interpolation(T04liter3,761.16,762.16,779.4,780.5);
h04llambda1iter3 = interpolation(T04liter3,761.16,762.16,827,828.2);
fT04liter3 = h04l - r*h04llambda1iter3 - q*h04laiter3;
T04l = T04liter3;
s04llambda1bar = interpolation(T04l,761.16,762.16,7.9456,7.9472);
s04labar = interpolation(T04l,761.16,762.16,7.6648,7.6663);
s04lbar = r*s04llambda1bar + q*s04labar;
s04l = s04lbar - R*log(p04l);

p5i = pa;
s5i = s04l;
%iterate to find temp and use with h method to find h
s5ibar = s5i + R*log(p5i);
T5ia = interpolation(s5ibar,7.3809,7.3827,584.16,585.16);
T5ilambda1 = interpolation(s5ibar,7.3809,7.3833,464.16,465.16);
T5iiter1 = r*T5ilambda1 + q*T5ia;
s5ilambda1iter1 = interpolation(T5iiter1,545.16,546.16,7.5596,7.5617);
s5iaiter1 = interpolation(T5iiter1,545.16,546.16,7.3089,7.3109);
fT5iiter1 = s5ibar - r*s5ilambda1iter1 - q*s5iaiter1;
fT5iiter2 = s5ibar - r*7.5554 - q*7.3051;
T5iiter3 = interpolation(0,fT5iiter2,fT5iiter1,543.16,T5iiter1);
s5ilambda1iter3 = interpolation(T5iiter3,541.16,542.16,7.5512,7.5533);
s5iaiter3 = interpolation(T5iiter3,541.16,542.16,7.3012,7.3031);
fT5iiter3 = s5ibar - r*s5ilambda1iter3 - q*s5iaiter3;
T5i = T5iiter3;
h5ilambda1 = interpolation(T5i,541.16,542.16,572,573.1);
h5ia = interpolation(T5i,541.16,542.16,545.5,546.6);
h5i = r*h5ilambda1 + q*h5ia;

p5 = p5i;
c5i = sqrt(2*(h04l-h5i)*1000);
c5 = c5i * gg5Efficiency;
h5 = h04l*1000 - c5.^2/2; % J/(kg*K)
h5 = h5/1000; % kJ/(kg*K)
%iterate to find temp and use with s method to find s
T5lambda1 = interpolation(h5,567.5,568.7,537.16,538.16);
T5a = interpolation(h5,567.4,568.4,562.16,563.16);
T5iter1 = r*T5lambda1 + q*T5a;
h5lambda1iter1 = interpolation(T5iter1,554.16,555.16,586.6,587.8);
h5aiter1 = interpolation(T5iter1,554.16,555.16,559,560.1);
fT5iter1 = h5 - r*h5lambda1iter1 - q*h5aiter1;
fT5iter2 = h5 - r*586.6 - q*559;
T5iter3 = interpolation(0,fT5iter2,fT5iter1,554.16,T5iter1);
h5lambda1iter3 = interpolation(T5iter3,554.16,555.16,586.6,587.8);
h5aiter3 = interpolation(T5iter3,554.16,555.16,559,560.1);
fT5iter3 = h5 - r*h5lambda1iter3 - q*h5aiter3;
T5 = T5iter3;
s5lambda1bar = interpolation(T5,554.16,555.16,7.5779,7.5800);
s5abar = interpolation(T5,554.16,555.16,7.3259,7.3278);
s5bar = r*s5lambda1bar + q*s5abar;
s5 = s5bar - R*log(p5);

% Questions ----------------------------------------------------------

% part a is hand drawn to match this matrix

MollierDiagram = [s01,s02fi,s02f,s5fi,s5f,s02i,s02,s03,s04hi,s04h,s04li,s04l,s5i,s5;...
                  h01,h02fi,h02f,h5fi,h5f,h02i,h02,h03,h04hi,h04h,h04li,h04l,h5i,h5];
MollierDiagram = transpose(MollierDiagram);

% part b

thermalEfficiency = (h03-h5-(h02-h01))/(h03-h02);
Tsp = (1+1/(lambda*minL))*c5 - u;
T = Tsp * aMassFlowRate;
TSFC = 3600/(lambda*minL*Tsp); 

% part c

aColdMassFlowRate = aMassFlowRate*BPR/(BPR+1)
Tfan = aColdMassFlowRate * c5f
Tcore = T - Tfan
Tratio = Tfan/Tcore

% Functions ----------------------------------------------------------

function sbar = hMethodPart1(s1,p1)
    R = .28716;
    sbar = R*log(p1) + s1;
end
function s1 = sMethod(h1,p1,hunder,hover,sunder,sover)
    R = .28716;
    sbar = interpolation(h1,hunder,hover,sunder,sover)
    s1 = sbar - R*log(p1);
end
function p1 = pMethod(h1,s1,hunder,hover,sunder,sover)
    R = .28716;
    sbar = interpolation(h1,hunder,hover,sunder,sover)
    p1 = exp(-(s1-sbar)/R);
end
function y = interpolation(x,x1,x2,y1,y2)
    
    y = y1 + (x-x1)*(y2-y1)/(x2-x1);

end