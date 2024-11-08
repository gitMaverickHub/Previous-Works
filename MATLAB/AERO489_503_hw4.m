syms ep ep1 ep2 kTe

f = ep*exp(-ep/(kTe));

integrable_part = int(f,ep,ep1,ep2);

kTe = 0.1:0.1:10;

C = 6.692*10^5;

%% Vibration

sigma = 0.5; 

ep1 = 1;

ep2 = 5;

kVibration = C .* (sigma./((kTe).^(3/2))) ...
             .* ((kTe .* exp(-ep2./kTe) .* (ep2 + kTe)) - ...
             (kTe .* exp(-ep1./kTe) .* (ep1 + kTe)));

figure
hold on
title('Vibration')
ylabel('Rate Coefficient for Vibration (cm^3/s)')
xlabel('Electron Temperature (eV)')
semilogy(kTe,kVibration)
grid on
set(gca, 'YScale', 'log')
hold off

%% Attachment

sigma = 0.004; 

ep1 = 4;

ep2 = 9;

kAttachment = C .* (sigma./((kTe).^(3/2))) ...
             .* ((kTe .* exp(-ep2./kTe) .* (ep2 + kTe)) - ...
             (kTe .* exp(-ep1./kTe) .* (ep1 + kTe)));

figure
hold on
title('Attachment')
ylabel('Rate Coefficient for Attachment (cm^3/s)')
xlabel('Electron Temperature (eV)')
plot(kTe,kAttachment)
grid on
set(gca, 'YScale', 'log')
hold off

%% Electronic Excitation

sigma = 1; 

ep1 = 8;

% ep2 = infinity

kElectronExcitation = C .* (sigma./((kTe).^(3/2))) ...
             .* ((0) - ... % Note that this terms turns to 0 when ep2 is infinity
             (kTe .* exp(-ep1./kTe) .* (ep1 + kTe)));

figure
hold on
title('Electronic Excitation')
ylabel('Rate Coefficient for Electronic Excitation (cm^3/s)')
xlabel('Electron Temperature (eV)')
plot(kTe,kElectronExcitation)
grid on
set(gca, 'YScale', 'log')
hold off

%% Ionization

sigma = 1.2; 

ep1 = 14;

% ep2 = infinity

kIonization = C .* (sigma./((kTe).^(3/2))) ...
             .* ((0) - ... % Note that this terms turns to 0 when ep2 is infinity
             (kTe .* exp(-ep1./kTe) .* (ep1 + kTe)));

figure
hold on
title('Ionization')
ylabel('Rate Coefficient for Ionization (cm^3/s)')
xlabel('Electron Temperature (eV)')
plot(kTe,kIonization)
grid on
set(gca, 'YScale', 'log')
hold off

%% Momentum Transfer

syms ep kTe

f_momentum_transfer = sqrt(ep) * exp(-ep/kTe);

integrable_part_momentum_transfer = int(f_momentum_transfer,ep,0,inf);

vm = 1.186*10^(-9);

figure
hold on
title('Momentum Transfer')
ylabel('Momentum Transfer Frequency (1/s)')
xlabel('Electron Temperature (eV)')
xlim([0 10]);
ylim([0 2*10^(-9)]);
yline(vm)
grid on
hold off