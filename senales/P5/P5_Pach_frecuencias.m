clc;
close all;
clear all;

%Objetivo B (Pasos 1-5)
%Pasa Bajas
figure(1)
N=60; %Numero de muestras del filtro
t1=0.3; %Valor de transición
%Vector del filtro pasabajas en el dominio de la frecuencia
Hmag=[ 1 1 1 1 1 1 1 1 1 1, 1 1 1 1 1 t1 0 0 0 0, 0 0 0 0 0 0 0 0 0 0, 0 0 0 0 0 0 0 0 0 0, 0 0 0 0 t1 1 1 1 1 1, 1 1 1 1 1 1 1 1 1 1];     %P-BAJAS
subplot(3,2,1);stem(Hmag) %Grafica la forma del filtro
 
k=0:29;  %Numero de muestras positivas
fi1=(2*pi*k/N)*(N-1)/2; %Respuesta al impulso del filtro
k=-30:-1;  %Numero de muestras de la parte negativa
fi2=(2*pi*k/N)*(N-1)/2; %Respuesta al impulso del filtro
fi=[fi1, fi2]; %Define el filtro
% fi=[fi1, fi2]; usar para el pasa bajas y rechazabanda
%fi=[fi2, fi1]; %usar para el pasa altas y pasabanda
 
subplot(3,2,2); stem(fi) %Grafica la forma discreta del filtro
 
H=Hmag.*exp(j*fi); %Transformada de fourier del filtro
h=ifft(H);  %Transformada inversa de fourier
h=real(h);  %Respuesta al impulso del filtro
% se debe sacar la parte real para que stem lo grafique bien
subplot(3,2,3)
stem(real(h)) %Grafica la respuesta del filtro
 
[db,mag,pha,grd,w]=freqz_m(h,[1]); %Obtiene los parametros del filtro
 
subplot(3,2,4)
plot(w/pi,mag);title('Magnitud');grid %Grafica la magnitud del filtro
xlabel('frecuencia en unidades de pi'); 
subplot(3,2,5)
plot(w/pi,pha);title('Fase');grid %Grafica la fase del filtro
xlabel('frecuencia en unidades de pi'); 
subplot(3,2,6)
plot(w/pi,db);title('Magnitud en dB');grid %Grafica la magnitud db del filtro
axis([0 1 -100 10]); xlabel('frecuencia en unidades de pi'); ylabel('Decibeles')
 
%Pasa altas////////////////////////////////////////////////////////////
clc;
clear all
figure(2)
N=60; %Numero de muestras del filtro
t2=0.2;  %Valor de transición
Hmag=[0 0 0 0 0 0 0 0 0 0,0 0 0 0 0 0 0 0 0 0, 0 0 0 0 0 t2 1 1 1 1, 1 1 1 1 t2 0 0 0 0 0,  0 0 0 0 0 0 0 0 0 0,0 0 0 0 0 0 0 0 0 0];     %P-ALTAS
%Vector del filtro pasabajas en el dominio de la frecuencia
subplot(3,2,1); stem(Hmag) %Grafica la forma del filtro 
 
k=0:29; %Numero de muestras positivas
fi1=(2*pi*k/N)*(N-1)/2; %Respuesta al impulso del filtro
k=-30:-1; %Numero de muestras de la parte negativa
fi2=(2*pi*k/N)*(N-1)/2; %Respuesta al impulso del filtro
%fi=[fi1, fi2]; %usar para el pasa bajas y rechazabanda
fi=[fi2, fi1]; %Define el filtro
%usar para el pasa altas y pasabanda
subplot(3,2,2)
stem(fi) %Grafica la forma discreta del filtro
 
H=Hmag.*exp(j*fi); %Transformada de fourier del filtro
h=ifft(H); %Transformada inversa de fourier
h=real(h); %Respuesta al impulso del filtro
% se debe sacar la parte real para que stem lo grafique bien
subplot(3,2,3)
stem(real(h)) %Grafica la respuesta del filtro
 
[db,mag,pha,grd,w]=freqz_m(h,[1]); %Obtiene los parametros del filtro
 
subplot(3,2,4)
plot(w/pi,mag);title('Magnitud');grid %Grafica la magnitud del filtro
xlabel('frecuencia en unidades de pi'); 
subplot(3,2,5)
plot(w/pi,pha);title('Fase');grid %Grafica la fase del filtro
xlabel('frecuencia en unidades de pi'); 
subplot(3,2,6)
plot(w/pi,db);title('Magnitud en dB');grid %Grafica la magnitud db del filtro
axis([0 1 -100 10]); xlabel('frecuencia en unidades de pi'); ylabel('Decibeles')
 
%Pasa Banda///////////////////////////////////////////////////////
clc;
clear all
figure(3)
N=60; %Numero de muestras del filtro
t3=0.26; %Valor de transición
Hmag=[0 0 0 0 0,0 0 0 0 0 t3 1 1 1 1, 1 1 1 1 t3 0 0 0 0 0, 0 0 0 0 0, 0 0 0 0 0, 0 0 0 0 0 t3 1 1 1 1, 1 1 1 1 t3 0 0 0 0 0, 0 0 0 0 0];     %P-BANDA
%Vector del filtro pasabajas en el dominio de la frecuencia
subplot(3,2,1); stem(Hmag) %Grafica la forma del filtro 
 
k=0:29; %Numero de muestras positivas
fi1=(2*pi*k/N)*(N-1)/2; %Respuesta al impulso del filtro
k=-30:-1; %Numero de muestras de la parte negativa
fi2=(2*pi*k/N)*(N-1)/2; %Respuesta al impulso del filtro
%fi=[fi1, fi2]; %usar para el pasa bajas y rechazabanda
fi=[fi2, fi1]; %Define el filtro
%usar para el pasa altas y pasabanda
 
subplot(3,2,2)
stem(fi) %Grafica la forma discreta del filtro
H=Hmag.*exp(j*fi);  %Transformada de fourier del filtro
h=ifft(H); %Transformada inversa de fourier
h=real(h); %Respuesta al impulso del filtro
% se debe sacar la parte real para que stem lo grafique bien
subplot(3,2,3)
stem(real(h)) %Grafica la respuesta del filtro
 
[db,mag,pha,grd,w]=freqz_m(h,[1]); %Obtiene los parametros del filtro
 
subplot(3,2,4)
plot(w/pi,mag);title('Magnitud');grid  %Grafica la magnitud del filtro
xlabel('frecuencia en unidades de pi'); 
subplot(3,2,5)
plot(w/pi,pha);title('Fase');grid %Grafica la fase del filtro
xlabel('frecuencia en unidades de pi'); 
subplot(3,2,6)
plot(w/pi,db);title('Magnitud en dB');grid %Grafica la magnitud db del filtro
axis([0 1 -100 10]); xlabel('frecuencia en unidades de pi'); ylabel('Decibeles')
 
%Rechaza Banda/////////////////////////////////////////////////////////////
clc;
clear all
 
figure(4)
N=60; %Numero de muestras del filtro 
t4=0.27; %Valor de transición
Hmag=[1 1 1 1 1 , 1 1 1 1 1 t4 0 0 0 0, 0 0 0 0 t4 1 1 1 1 1, 1 1 1 1 1, 1 1 1 1 1, 1 1 1 1 1 t4 0 0 0 0, 0 0 0 0 t4 1 1 1 1 1, 1 1 1 1 1 ];     %R-BANDA
%Vector del filtro pasabajas en el dominio de la frecuencia
subplot(3,2,1); stem(Hmag) %Grafica la forma del filtro 
 
k=0:29; %Numero de muestras positivas
fi1=(2*pi*k/N)*(N-1)/2; %Respuesta al impulso del filtro
k=-30:-1; %Numero de muestras de la parte negativa
fi2=(2*pi*k/N)*(N-1)/2; %Respuesta al impulso del filtro
fi=[fi1, fi2]; %Define el filtro
%usar para el pasa bajas y rechazabanda
%fi=[fi2, fi1]; %usar para el pasa altas y pasabanda
 
subplot(3,2,2)
stem(fi) %Grafica la forma discreta del filtro
 
H=Hmag.*exp(j*fi); %Transformada de fourier del filtro
h=ifft(H); %Transformada inversa de fourier
h=real(h); %Respuesta al impulso del filtro 
% se debe sacar la parte real para que stem lo grafique bien
subplot(3,2,3)
stem(real(h)) %Grafica la respuesta del filtro
 
[db,mag,pha,grd,w]=freqz_m(h,[1]); %Obtiene los parametros del filtro
 
subplot(3,2,4)
plot(w/pi,mag);title('Magnitud');grid %Grafica la magnitud del filtro
xlabel('frecuencia en unidades de pi'); 
subplot(3,2,5)
plot(w/pi,pha);title('Fase');grid %Grafica la fase del filtro
xlabel('frecuencia en unidades de pi'); 
subplot(3,2,6)
plot(w/pi,db);title('Magnitud en dB');grid %Grafica la magnitud db del filtro
axis([0 1 -100 10]); xlabel('frecuencia en unidades de pi'); ylabel('Decibeles')
 
%Obetivo B (paso 6)
%Rechaza Banda//////////////////////////////////////////////////////////
clc;
clear all
 
figure(5)
N=60; %Número de muestras
t4=0.27; %Valor de transición
% 60 muestras de 0 a 2pi
%30 muestras de 0 a pi
% 0- 1100 Hz de 0 a Pi
%Conversion de frecuencia a muestras----> #muestra= Freq*30/1100
Hmag=[1 1 1 1 1 1 1 1 1 1, 1 1 1 1 1 1 1 1 1 1, t4 0 0 t4 1 1 1 1 1 1, 1 1 1 1 1 1 t4 0 0 t4, 1 1 1 1 1 1 1 1 1 1, 1 1 1 1 1 1 1 1 1 1];     %R-BANDA
%Vector del filtro pasabajas en el dominio de la frecuencia
subplot(3,2,1); stem(Hmag) %Grafica la forma del filtro 
 
k=0:29; %Numero de muestras positivas
fi1=(2*pi*k/N)*(N-1)/2; %Respuesta al impulso del filtro
k=-30:-1; %Numero de muestras de la parte negativa
fi2=(2*pi*k/N)*(N-1)/2; %Respuesta al impulso del filtro
fi=[fi1, fi2]; %Define el filtro
%usar para el pasa bajas y rechazabanda
%fi=[fi2, fi1]; %usar para el pasa altas y pasabanda
 
subplot(3,2,2)
stem(fi) %Grafica la forma discreta del filtro
 
H=Hmag.*exp(j*fi); %Transformada de fourier del filtro
h=ifft(H); %Transformada inversa de fourier
h=real(h); %Respuesta al impulso del filtro  
% se debe sacar la parte real para que stem lo grafique bien
subplot(3,2,3)
stem(real(h)) %Grafica la respuesta del filtro
 
[db,mag,pha,grd,w]=freqz_m(h,[1]); %Obtiene los parametros del filtro
 
subplot(3,2,4)
plot(w*1100/pi + 1000,mag);title('Magnitud');grid %Grafica la magnitud del filtro
xlabel('Frecuencia en Hz'); 
xlim([1000 2100]);
subplot(3,2,5)
plot(w*1100/pi + 1000,pha);title('Fase');grid %Grafica la fase del filtro
xlabel('Frecuencia en Hz'); 
xlim([1000 2100]);
subplot(3,2,6)
plot(w*1100/pi + 1000,db);title('Magnitud en dB');grid %Grafica la magnitud db del filtro
axis([1000 max(w*1100/pi + 1000), -100 10]); xlabel('Frecuencia en Hz'); ylabel('Decibeles')
 
%se genera la señal
figure(6)
Fsenal1=1700; %Frecuencia señal 1
Fsenal2=1800; %Frecuencia señal 2
Fsenal3=1900; %Frecuencia señal 3
Tsenal=1/Fsenal1; %Periodo señal
LonSenal=Tsenal*30; %Longitud señal
%Señal contínua
Fsam=22000; %Frecuencia muestreo contunua
Fsam=22000; %Frecuencia muestreo contunua
t=0:1/Fsam:LonSenal; %Tiempo continuo
A=35; %Amplitud señal 1
sen1=A*sin(2*pi*Fsenal1*t); %Señal 1
B=20; %Amplitud señal 2
sen2=B*sin(2*pi*Fsenal2*t); %Señal 2
C=35; %Amplitud señal 3
sen3=C*sin(2*pi*Fsenal3*t); %Señal 3
sen1=sen1+sen2+sen3; %Suma de las 3 señales
 
tfin=LonSenal*0.3; %Tiempo maximo
subplot(3,1,1); plot(t,sen1,'r'); axis([0, tfin, -max(sen1), max(sen1)]); %Grafica suma de las 3 señales
%Señal discreta
Fm=4000; %Frecuencia de muestreo
Tm=1/Fm; %Periodo de muestreo
td=0:Tm:LonSenal; %Tiempo discreto
sen1=A*sin(2*pi*Fsenal1*td); %Señal discreta 1
sen2=B*sin(2*pi*Fsenal2*td); %Señal discreta 2
sen3=C*sin(2*pi*Fsenal3*td); %Señal discreta 3
sen1=sen1+sen2+sen3; %Suma 3 señales discretas
subplot(3,1,2); stem(td,sen1,'g'); %Grafica suma de las 3 señales discretas
 
[db,mag,pha,grd,w]=freqz_m(sen1,[1]); %Obtiene los parametros de la señal
maxespec=max(mag);
 
subplot(3,1,3); plot(w*1100/pi + 1000,mag);title('Magnitud');grid %Grafica espectro de la señal
xlabel('Frecuencia en Hz'); 
 
%se aplica el filtro por convolución
figure(7)            
y=conv(h,sen1); %Aplica el filtro a la señal
transitorio=50; %Transitorio
fin=length(y)-transitorio; %Tiempo estable
yestable=y(transitorio:1:fin); %Señal discreta estable
subplot(2,1,1); 
plot(yestable); %Grafica la señal filtrada estable
axis([0 length(yestable), -max(sen1), max(sen1)]);
 
[db,mag,pha,grd,w]=freqz_m(yestable,[1]); %Obtiene los parametros de la señal filtrada
 
subplot(2,1,2); plot(w*1100/pi + 1000,mag);title('Magnitud');grid %Grafica espectro de la señal filtrada
axis([1000 max(w*1100/pi + 1000), -maxespec, maxespec]);
xlabel('Frecuencia en Hz');
