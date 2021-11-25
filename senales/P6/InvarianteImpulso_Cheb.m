clc;
clear all
close all

wp=0.55*pi; %Frecuencia mínima de banda de bajo
wa=0.85*pi; %F máx de banda de rechazo
Rp=1;   %Rechazo máximo de la banda de paso
Ra=32;  %R mín de la banda de rechao

T=1;
omegap=wp/T;
omegaa=wa/T;

[Bs,As]=afd_chb1(omegap,omegaa,Rp,Ra);

[b,a]=imp_invr(Bs,As,T); %Invariante a impulso

figure(1); subplot(1,1,1)
[db,mag,pha,grd,w] = freqz_m(b,a); %Sacar las características del filtro

subplot(2,2,1); plot(w/pi,mag); title('Magnitud') %Magnitud y frecuencia en unidades de pi del filtro
xlabel('frequencia en unidades de pi'); ylabel('|H|'); axis([0,1,0,1])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[0,0.7071,1]); grid

subplot(2,2,2); plot(w/pi,pha/pi); title('Fase') %Fase y frecuancia en unidades de pi del filtro
xlabel('frequencia en unidades de pi'); ylabel('unidades de pi'); axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[-1,0,1]); grid

subplot(2,2,3); plot(w/pi,db); title('Magnitud en dB'); %Magnitud del filtro 20log(Mag)
xlabel('frequencia en unidades de pi'); ylabel('decibeles'); axis([0,1,-80,5]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[-30,-3]); grid
set(gca,'YTickLabelMode','manual','YTickLabel',['Rechazo';'   Paso']) 
%Nota: el tamaño de las etiquetas debe ser del mismo número de espacios,
%que definen el tamaño del arreglo.


