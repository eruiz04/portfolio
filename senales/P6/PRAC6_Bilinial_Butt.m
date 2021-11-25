clear all
close all

wp=0.55*pi; %Banda de paso
wa=0.85*pi; %Banda de rechazo
Rp=1;       %Rechazo máximo de banda de paso
Ra=32;      %Rechazo mínimo de banda de rechazo

Fs=1; T=1/Fs;
omegap=(2/T)*tan(wp/2); %Relación de ángulos de la transformación bilineal
omegaa=(2/T)*tan(wa/2);

[Bs,As]=afd_butt(omegap,omegaa,Rp,Ra); %Filtro Butterworth

[b,a]=bilinear(Bs,As,Fs);   %Transformación bilineal

figure(1); subplot(1,1,1)   
[db,mag,pha,grd,w] = freqz_m(b,a);  %Propiedades del filtro

subplot(2,2,1); plot(w/pi,mag); title('Magnitud') %Magnitud y frecuencia en unidades de pi del filtro
xlabel('frequencia en unidades de pi'); ylabel('|H|'); axis([0,1,0,1])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[0,0.7071,1]); grid

subplot(2,2,2); plot(w/pi,pha/pi); title('Fase') %fase y frecuencia en unidades de pi del filtro
xlabel('frequencia en unidades de pi'); ylabel('unidades de pi'); axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[-1,0,1]); grid

subplot(2,2,3); plot(w/pi,db); title('Magnitud en dB'); %Magnitud en dB 20log(Mag)
xlabel('frequencia en unidades de pi'); ylabel('decibeles'); axis([0,1,-80,5]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[-30,-1,0]); grid

