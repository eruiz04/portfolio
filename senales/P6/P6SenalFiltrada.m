clc
clear all
close all

%se genera la señal
figure(1)
Fsenal1=25; %Frecuencia señal 1
A=70; %Amplitud señal 1
Fsenal2=45; %Frecuencia señal 2
B=45; %Amplitud señal 2
Fruido=100; %Frecuencia señal 3
C=20; %Amplitud señal 3
Tsenal=1/Fsenal1; %Periodo señal
LonSenal=Tsenal*15; %Longitud señal
%Señal contínua
Fsam=500; %Frecuencia muestreo contunua
t=0:1/Fsam:LonSenal; %Tiempo continuo
sen1=A*sin(2*pi*Fsenal1*t); %Señal 1
sen2=B*sin(2*pi*Fsenal2*t); %Señal 2
sen3=C*sin(2*pi*Fruido*t); %Señal 3
sen1=sen1+sen2+sen3; %Suma de las 3 señales
 
tfin=LonSenal*0.3; %Tiempo maximo
subplot(3,1,1); plot(t,sen1,'r'); axis([0, tfin, -max(sen1), max(sen1)]); %Grafica suma de las 3 señales
%Señal discreta
Fm=500; %Frecuencia de muestreo
Tm=1/Fm; %Periodo de muestreo
td=0:Tm:LonSenal; %Tiempo discreto
sen1=A*sin(2*pi*Fsenal1*td); %Señal discreta 1
sen2=B*sin(2*pi*Fsenal2*td); %Señal discreta 2
sen3=C*sin(2*pi*Fruido*td); %Señal discreta 3
sen1=sen1+sen2+sen3; %Suma 3 señales discretas
subplot(3,1,2); stem(td,sen1,'g'); %Grafica suma de las 3 señales discretas
axis([0, tfin, -max(sen1), max(sen1)]);
 
[db,mag,pha,grd,w]=freqz_m(sen1,[1]); %Obtiene los parametros de la señal
maxespec=max(mag);
 
subplot(3,1,3); plot(w*250/pi,mag);title('Magnitud');grid %Grafica espectro de la señal
axis([0, 125, -maxespec, maxespec]);
xlabel('Frecuencia en Hz'); 

%%%%%%%%%%%%%%%%%%FILTRO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wp=0.5*pi;  %Banda de paso
wa=0.6*pi;  %Banda de rechazo
Rp=1;       %Rechazo máximo de banda de paso
Ra=40;      %Rechazo mínimo de banda de rechazo

Fs=1; T=1/Fs;
omegap=(2/T)*tan(wp/2);
omegaa=(2/T)*tan(wa/2);

[Bs,As]=afd_butt(omegap,omegaa,Rp,Ra); %Filtro Butterworth

[b,a]=bilinear(Bs,As,Fs); %Transformación Bilineal

figure(2); subplot(1,1,1)
[db,mag,pha,grd,w] = freqz_m(b,a); %obtiene los parámetros del filtro

subplot(2,2,1); plot(w/pi,mag); title('Magnitud')%Magnitud y frecuencia en unidades de pi del filtro
xlabel('frequencia en unidades de pi'); ylabel('|H|'); axis([0,1,0,1])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]); %Colocar cursores
set(gca,'YTickmode','manual','YTick',[0,0.7071,1]); grid

subplot(2,2,2); plot(w/pi,pha/pi); title('Fase') %fase y frecuencia en unidades de pi del filtro
xlabel('frequencia en unidades de pi'); ylabel('unidades de pi'); axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);    %Colocar cursores
set(gca,'YTickmode','manual','YTick',[-1,0,1]); grid

subplot(2,2,4); plot(w*250/pi,mag); title('Magnitud') %Obtener la frcuencia en Hz en lugar de unidades de pi
xlabel('frecuencia en Hz'); ylabel('|H|'); axis([0,250,0,1])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);    %Colocar cursores
set(gca,'YTickmode','manual','YTick',[0,0.7071,1]); grid

subplot(2,2,3); plot(w/pi,db); title('Magnitud en dB'); %Magnitud en dB 20log(Mag)
xlabel('frequencia en unidades de pi'); ylabel('decibeles'); axis([0,1,-80,5]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);    %Colocar cursores
set(gca,'YTickmode','manual','YTick',[-30,-1,0]); grid

%%%%%%%%%%%%%%%FILTRADO%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)            
y=conv(b,sen1); %Aplica el filtro a la señal
transitorio=50; %Transitorio
fin=length(y)-transitorio; %Tiempo estable
yestable=y(transitorio:1:fin); %Señal discreta estable
subplot(2,1,1); 
plot(yestable); %Grafica la señal filtrada estable
axis([0 length(yestable), -max(sen1)*6, max(sen1)*6]);
 
[db,mag,pha,grd,w]=freqz_m(yestable,[1]); %Obtiene los parametros de la señal filtrada
 maxespec_yestable=max(mag); %Valor máximo del espectro de Y estable
subplot(2,1,2); plot(w*250/pi,mag);title('Magnitud');grid %Grafica espectro de la señal filtrada
axis([0, 125, -maxespec_yestable, maxespec_yestable]);
xlabel('Frecuencia en Hz');

