
clc
close all
clear all

%******Diseño Filtro Analógicos Cheby
figure(1)
Rp=3;       %oscilacion
Wp=2*pi*3600;   %paso
Ws=2*pi*1200;   %rechazo
Rs=20;      %atenuacion minima db
Rp=1;       %atenuacion maxima propuesta db

[b,a]=cheby1(6,Rp,Wp,'high','s');
[z,p,k]=cheby1(6,Rp,Wp,'high','s')
%[n,Wn]=cheb1ord(Wp,Ws,Rp,Rs,'s');
%[b,a]=cheby1(n,Rs,Wn);
subplot(2,1,1);
zplane(z,p);
H=zpk(z,p,k);
[h,w]=freqs(b,a,200);
subplot(2,1,2);
n=20*log(abs(h));
plot(w/(2*pi),n);
xlabel('Hz');
ylabel('Ganancia en dB');
xlim([0 16000]);
title('cheby pasa altas');






