clc;
clear all
close all

%***********************************************************************
%VENTANAS
%Utilice las funciones boxcar, triang, hanning, hamming y blackman
%para graficar en cada caso el comportamiento en el dominuo de la frecuencia. 
%***********************************************************************
figure(1)
N=30;
w=boxcar(N);
subplot(2,2,1); stem(w); 
title('Ventana rectangular: Boxcar');
axis([-10 80 0 2]);
xlabel('n'), ylabel('w[n]');

[db,mag,pha,grd,w]=freqz_m(w,[1]);

subplot(2,2,2); plot(w/pi,mag);title('Magnitud');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,3); plot(w/pi,pha);title('Fase');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,4); plot(w/pi,db);title('Magnitud en dB');grid
axis([0 1 -100 10]); xlabel('frecuencia en unidades de pi'); ylabel('Decibeles')

%***********************Triang
figure(2)
N=30;
w=triang(N);
subplot(2,2,1); stem(w); 
title('Ventana rectangular: triang');
axis([-10 80 0 2]);
xlabel('n'), ylabel('w[n]');

[db,mag,pha,grd,w]=freqz_m(w,[1]);

subplot(2,2,2); plot(w/pi,mag);title('Magnitud');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,3); plot(w/pi,pha);title('Fase');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,4); plot(w/pi,db);title('Magnitud en dB');grid
axis([0 1 -100 10]); xlabel('frecuencia en unidades de pi'); ylabel('Decibeles')

%*************hanning
figure(3)
N=30;
w=hanning(N);
subplot(2,2,1); stem(w); 
title('Ventana rectangular: hanning');
axis([-10 80 0 2]);
xlabel('n'), ylabel('w[n]');

[db,mag,pha,grd,w]=freqz_m(w,[1]);

subplot(2,2,2); plot(w/pi,mag);title('Magnitud');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,3); plot(w/pi,pha);title('Fase');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,4); plot(w/pi,db);title('Magnitud en dB');grid
axis([0 1 -100 10]); xlabel('frecuencia en unidades de pi'); ylabel('Decibeles')

%*******************hamming
figure(4)
N=30;
w=hamming(N);
subplot(2,2,1); stem(w); 
title('Ventana rectangular: hamming');
axis([-10 80 0 2]);
xlabel('n'), ylabel('w[n]');

[db,mag,pha,grd,w]=freqz_m(w,[1]);

subplot(2,2,2); plot(w/pi,mag);title('Magnitud');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,3); plot(w/pi,pha);title('Fase');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,4); plot(w/pi,db);title('Magnitud en dB');grid
axis([0 1 -100 10]); xlabel('frecuencia en unidades de pi'); ylabel('Decibeles')

%**************************blackman
figure(5)
N=30;
w=blackman(N);
subplot(2,2,1); stem(w); 
title('Ventana rectangular: blackman');
axis([-10 80 0 2]);
xlabel('n'), ylabel('w[n]');

[db,mag,pha,grd,w]=freqz_m(w,[1]);

subplot(2,2,2); plot(w/pi,mag);title('Magnitud');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,3); plot(w/pi,pha);title('Fase');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,4); plot(w/pi,db);title('Magnitud en dB');grid
axis([0 1 -100 10]); xlabel('frecuencia en unidades de pi'); ylabel('Decibeles')

%***********************************************************************
%FILTRO PASA BAJAS IDEAL
%wc=frecuencia de corte
%M=longitud del filtro ideal
%***********************************************************************
%wp=0.15pi
%ws=0.45pi
%wc=0.3pi
%Rp=1db
%Rs=15db

figure(6)
wc=0.3*pi;
N=100;           %100
alpha=(N-1)/2;
n=0:1:(N-1);
m=n-alpha+eps;           %N�mero de presici�n eps=2^(-52).
h=sin(wc*m)./(pi*m);

subplot(2,2,1); stem(h); 
title('h[n] ideal');
%axis([-10 80 0 2]);
xlabel('n'), ylabel('h[n]');

[db,mag,pha,grd,w]=freqz_m(h,[1]);

subplot(2,2,2); plot(w/pi,mag);title('Magnitud');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,3); plot(w/pi,pha);title('Fase');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,4); plot(w/pi,db);title('Magnitud en dB');grid
axis([0 1 -100 10]);
xlabel('frecuencia en unidades de pi'); ylabel('Decibeles')

%***********************************************************************
%VENTANEO DEL FILTRO IDEAL

%***********************************************************************
figure(7)
hr=h.*hamming(N)';      %boxcar
subplot(2,2,1); stem(hr); 
title('h[n] real');
%axis([-10 80 0 2]);
xlabel('n'), ylabel('h[n]');

[db,mag,pha,grd,w]=freqz_m(hr,[1]);

subplot(2,2,2); plot(w/pi,mag);title('Magnitud');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,3); plot(w/pi,pha);title('Fase');grid
xlabel('frecuencia en unidades de pi'); 
subplot(2,2,4); plot(w/pi,db);title('Magnitud en dB');grid
axis([0 1 -100 10]);
xlabel('frecuencia en unidades de pi'); ylabel('Decibeles')

%***********************************************************************
%FILTRANDO UNA SE�AL
%***********************************************************************
%se genera la se�al
figure(8)
Fsenal=30; 
Fruido=40; 
Tsenal=1/Fsenal;
LonSenal=Tsenal*30;

Fsam=500; %Se�al cont�nua
t=0:1/Fsam:LonSenal;
A=15;
x=A*sin(2*pi*Fsenal*t);
B=6;
ruido=B*sin(2*pi*Fruido*t);
x=x+ruido;

tfin=LonSenal*0.3;
subplot(3,1,1); plot(t,x,'r'); axis([0, tfin, -max(x), max(x)]);

Fm=100;  %Se�al discreta
Tm=1/Fm;
td=0:Tm:LonSenal;
xd=A*sin(2*pi*Fsenal*td);
ruido=B*sin(2*pi*Fruido*td);
xd=xd+ruido;
subplot(3,1,2); stem(td,xd,'g'); 

[db,mag,pha,grd,w]=freqz_m(xd,[1]);
maxespec=max(mag);
subplot(3,1,3); plot(w/pi,mag);title('Magnitud');grid
xlabel('frecuencia en unidades de pi'); 

%Filtro pasa-bajas s�lo 30 Hz
%***********************************************************************
%FILTRO PASA BAJAS IDEAL
%wc=frecuencia de corte
%M=longitud del filtro ideal
wc=0.7*pi;
N=100;
alpha=(N-1)/2;
n=0:1:(N-1);
m=n-alpha+eps;           %N�mero de presici�n eps=2^(-52).
h=sin(wc*m)./(pi*m);
hr=h.*boxcar(N)';

%se aplica el filtro por convoluci�n
figure(9)
y=conv(hr,xd);
transitorio=2;
fin=length(y)-transitorio;
yestable=y(transitorio:1:fin);
subplot(2,1,1); plot(yestable);
axis([0 length(yestable), -max(x), max(x)]);

[db,mag,pha,grd,w]=freqz_m(yestable,[1]);

subplot(2,1,2); plot(w/pi,mag);title('Magnitud');grid
axis([0 max(w/pi), -maxespec, maxespec]);
xlabel('frecuencia en unidades de pi'); 

%Filtro pasa-bajas (Pasar ambas)
%***********************************************************************
%FILTRO PASA BAJAS IDEAL
%wc=frecuencia de corte
%M=longitud del filtro ideal
wc=0.9*pi;
N=100;
alpha=(N-1)/2;
n=0:1:(N-1);
m=n-alpha+eps;           %N�mero de presici�n eps=2^(-52).
h=sin(wc*m)./(pi*m);
hr=h.*boxcar(N)';


%se aplica el filtro por convoluci�n
figure(10)
y=conv(hr,xd);
transitorio=2;
fin=length(y)-transitorio;
yestable=y(transitorio:1:fin);
subplot(2,1,1); plot(yestable);
axis([0 length(yestable), -max(x), max(x)]);

[db,mag,pha,grd,w]=freqz_m(yestable,[1]);

subplot(2,1,2); plot(w/pi,mag);title('Magnitud');grid
axis([0 max(w/pi), -maxespec, maxespec]);
xlabel('frecuencia en unidades de pi'); 

%Filtro pasa-bajas (Rechazar ambas)
%***********************************************************************
%FILTRO PASA BAJAS IDEAL
%wc=frecuencia de corte
%M=longitud del filtro ideal
wc=0.5*pi;
N=100;
alpha=(N-1)/2;
n=0:1:(N-1);
m=n-alpha+eps;           %N�mero de presici�n eps=2^(-52).
h=sin(wc*m)./(pi*m);
hr=h.*boxcar(N)';

%se aplica el filtro por convoluci�n
figure(11)
y=conv(hr,xd);
transitorio=2;
fin=length(y)-transitorio;
yestable=y(transitorio:1:fin);
subplot(2,1,1); plot(yestable);
axis([0 length(yestable), -max(x), max(x)]);

[db,mag,pha,grd,w]=freqz_m(yestable,[1]);

subplot(2,1,2); plot(w/pi,mag);title('Magnitud');grid
axis([0 max(w/pi), -maxespec, maxespec]);
xlabel('frecuencia en unidades de pi'); 
