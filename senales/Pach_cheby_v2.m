clc 
clear all
close all

Ts=2;       %oscilacion
wp=2*pi*3600;   %paso
ws=2*pi*1200;   %rechazo
rs=20;      %atenuacion minima db
rp=3;       %atenuacion maxima propuesta db
fm=2*pi*7200;

wp=wp/fm;
ws=ws/fm;

%Wp=tan(wp/2);
%Ws=tan(ws/2);
%Wn es la frecuencia de corte
[N,Wn]=cheb1ord(wp,ws,rp,rs,'s');
[b,a]=cheby1(N,rp,Wn,'high','s');

%%%%%polos y ceros
figure(1)
[z,p,k]=cheby1(N,rp,Wn,'high','s');
zplane(z,p);
grid on
title('Polos y ceros');

figure(2)
[H,w]=freqs(b,a);
subplot(311);plot(w,abs(H));grid on

%diseñando en dominio digital
title('Espectro de magnitud del filtro Chebyshev Pasa Altas');
xlabel('Frecuencia angular analoga, \Omega (rad/s)');
[Nd,Wnd]=cheb1ord(wp/pi,ws/pi,rp,rs); %frec normalizada
[bd,ad]=cheby1(Nd,rp,Wnd);
[HD,WD]=freqz(bd,ad);
subplot(312);
plot(WD/pi,abs(HD)); grid on

%convirtiendo de analogico a digital
xlabel('Freuencia, rad/\pi');
title('Filtro digital CHebyshev H(\omega) Pasa Altas');
[bdd,add]=bilinear(b,a,1/Ts);
[HDD,WDD]=freqz(bdd,add);
subplot(313);
plot(WDD/pi,abs(HDD));
grid on
xlabel('Frecuencia, rad/\pi');
title('filtro digital chebyshev H(\omega) Pasa Altas');

