

%*************************************************************************
%DISEÑO DE FILTROS FIR POR EL MÉTODO DE MUESTREO EN FRECUENCIA
%*************************************************************************
clc;
clear all
close all


%for t=0.01:0.01:1

figure(1)

N=40;
%Sugerencia: usar valores con una muestra de transición de 0.39 para N=33)
%Sugerencia: usar valores con dos muestras de transición de 0.66 y 0.056 para N=65)
%Use la siguiente plantilla cambiando los unos por los valores deseados
%Hmag=[ 1 1 1 1 1 1 1 1 1 1, 1 1 1 1 1 1 1 1 1 1, 1 1 1 1 1 1 1 1 1 1, 1 1 1 1 1 1 1 1 1 1];  
t=1;
Hmag=[ 1 1 1 1 1 t 0 0 0 0, 0 0 0 0 0 0 0 0 0 0, 0 0 0 0 0 0 0 0 0 0, 0 0 0 0 t 1 1 1 1 1];     %P-BAJAS



subplot(3,2,1)
stem(Hmag)


k=0:19;
fi1=(2*pi*k/N)*(N-1)/2;
k=-20:-1;
fi2=(2*pi*k/N)*(N-1)/2;
fi=[fi1, fi2]; %usar para el pasa bajas y rechazabanda
%fi=[fi2, fi1]; %usar para el pasa altas y pasabanda

subplot(3,2,2)
stem(fi)


H=Hmag.*exp(j*fi); 
h=ifft(H);
h=real(h); % se debe sacar la parte real para que stem lo grafique bien
subplot(3,2,3)
stem(real(h))


[db,mag,pha,grd,w]=freqz_m(h,[1]);


subplot(3,2,4)
plot(w/pi,mag);title('Magnitud');grid
xlabel('frecuencia en unidades de pi'); 
subplot(3,2,5)
plot(w/pi,pha);title('Fase');grid
xlabel('frecuencia en unidades de pi'); 
subplot(3,2,6)
plot(w/pi,db);title('Magnitud en dB');grid
axis([0 1 -100 10]); xlabel('frecuencia en unidades de pi'); ylabel('Decibeles')

%t
%pause


%end




