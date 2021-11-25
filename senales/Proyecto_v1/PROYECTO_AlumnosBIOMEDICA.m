
%**********************************************************
%PROYECTO PARA BIOMEDICOS
%************************************************************
%{ 
PASOS A REALIZAR EN EL PROYECTO:

A) Grafique la señal x1 en unidades de tiempo en el eje x
B) Grafique su transformada de fourier con unidades de Hz en el eje x
C) Diseñe un filtro que elimine el ruido de 60Hz. Grafique su 
respuesta en decibeles. 
D) Aplique el filtro a la señal (mediante convolución o ecuación de
diferencias) y grafique la señal limpia.

E) Aplique los pasos del A al D a la señal x2 para eliminar la línea basal

F) Aplique los pasos del A al D a la señal x3 para eliminar el ruido muscular
%}
%{
%PONDERACIÓN DE LA EVALUACIÓN 4:
%   -ENTREGA DE PROYECTO= 80%
%   -ENTREGA DE TRABAJO DE INVESTIGACIÓN DE APROXIMADAMENTE 20 HOJAS SOBRE LOS SUBTEMAS DE
%      LA UNIDAD 4=  20%  (incluye portada, índice, desarrollo de temas,
%      concluciones y bibliografía)
%    -TODO SE ENTREGA EN EQUIPO
%}

clear all
close all
%LAS SIGUIENTES INSTRUCCIONES CARGAN LAS SEÑALES ECG A LAS VARIABLES Xs

figure(1)
load ECG_RUIDO60.MAT  %Carga la señal ECG con ruido de 60 Hz
x1=ecg1;
load ECG_LB.MAT  %Carga la señal ECG con ruido de linea base
x2=ecg2;
load ECG_RUIDOMUS.MAT  %Carga la señal ECG con ruido muscular
x3=ecg3;
Fs=250;   %los archivos estan muestreados a 250 muestras por segundo

h=[0.125 0.5 0.75 0.75 0.5 0.125]; %Apximaciòn
g=[1, -28, 119, -184, 119, -28, 1]; %Detalle Wavelet

%%%%%%%%%%CARGAR FILTROS
%%%%%%%Filtros FIR con ventana blackman
load Filtro60  %Cargar el filtro
h1=Num;             %vector de coeficientes del filtro
load FiltroLineaBase%Cargar filtro de linea base
h2=Num2;            %vector de coeficientes del filtro
load Filtroruidomuscular %cargar filtro ruido muscular
h3=Num3;            %vector de coeficientes del filtro

%%%%%%%%%%%%MOSTRAR LAS SEÑALES
figure(1)
subplot(3,1,1)
plot(x1); grid; %graficar la señal x1 en unidades de tiempo en el eje x
xlabel('Unidades de Tiempo'); ylabel('Magnitud');
title('Señal con ruido de 60Hz');
subplot(3,1,2)
plot(x2); grid;
xlabel('Unidades de Tiempo'); ylabel('Magnitud');
title('Señal con ruido de línea base');
subplot(3,1,3)
plot(x3); grid;
xlabel('Unidades de Tiempo'); ylabel('Magnitud');
title('Señal con ruido muscular');

%%%%%%%%%%%%Filtro 60Hz
figure(2)
[db,mag,pha,grd,w] = freqz_m(h1,1); %TFTD de h1
subplot(2,2,1); plot(h1);grid; title('Filtro'); %Filtro quita ruido 60Hz
xlim([0,100]);
subplot(2,2,2); plot((w/pi)*Fs/2,mag);title('Magnitud');grid %Graficar la TFTD
xlabel('frecuencia en Hz'); xlim([0,Fs/2]);
subplot(2,2,3); plot((w/pi)*Fs/2,pha);title('Fase');grid %Graficar fase
xlabel('frecuencia en Hz'); xlim([0,Fs/2]);
subplot(2,2,4); plot((w/pi)*Fs/2,db);title('Magnitud en dB');grid %Respuesta en dB
axis([0 1 -100 10]); xlabel('frecuencia en Hz'); ylabel('Decibeles');
xlim([0,Fs/2]);

figure(3)
subplot(2,2,1); plot(x1); %Graficar señal original
title('Señal x1 original');
x1Filt=conv(x1,h1); %Convolucion para filtrar la se;al
subplot(2,2,2); plot(x1Filt); grid; %Graficar señal filtrada
title('Señal x1 filtrada');

[db,mag,pha,grd,w] = freqz_m(x1,1); %TFTD de x1
subplot(2,2,3); plot((w/pi)*Fs/2,mag);grid %Graficar el espectro de x1 original
title('Espectro de x1 original');

[db,mag,pha,grd,w] = freqz_m(x1Filt,1); %TFTD de x1
subplot(2,2,4); plot((w/pi)*Fs/2,mag);grid %Graficar el espectro de x1 filtrada
title('Espectro de x1 filtrada');

%%%%%%%%%%%%%%%%%%%%Filtro Línea de Base
%pasa altas 4hz
figure(4)
[db,mag,pha,grd,w] = freqz_m(h2,1); %TFTD de h2
subplot(2,2,1); plot(h2);grid; title('Filtro Línea de Base en x2'); %Filtro quita ruido línea de base
xlim([0,100]);
subplot(2,2,2); plot((w/pi)*Fs/2,mag);title('Magnitud');grid %Graficar la TFTD
xlabel('frecuencia en Hz'); xlim([0,Fs/2]);
subplot(2,2,3); plot((w/pi)*Fs/2,pha);title('Fase');grid %Graficar fase
xlabel('frecuencia en Hz'); xlim([0,Fs/2]);
subplot(2,2,4); plot((w/pi)*Fs/2,db);title('Magnitud en dB');grid %Respuesta en dB
axis([0 1 -100 10]); xlabel('frecuencia en Hz'); ylabel('Decibeles');
xlim([0,Fs/2]);

figure(5)
subplot(2,2,1); plot(x2); grid; %Graficar señal original
title('Señal x2 original');

x2Filt=conv(x2,h2); %Convolucion para filtrar la se;al
subplot(2,2,2); plot(x2Filt); grid; %Graficar señal filtrada
title('Señal x2 filtrada');

[db,mag,pha,grd,w] = freqz_m(x2,1); %TFTD de x2 original
subplot(2,2,3); plot((w/pi)*Fs/2,mag);grid %Graficar el espectro de x2 original
title('Espectro de x2 original');

[db,mag,pha,grd,w] = freqz_m(x2Filt,1); %TFTD de x2 filtrada
subplot(2,2,4); plot((w/pi)*Fs/2,mag);grid %Graficar el espectro de x2 filtrada
title('Espectro de x2 filtrada');

%%%%%%%%%%%%%%%%%Filtro Ruido Muscular
%%%%%%%%%ruido muscular rechaza banda 30Hz a 40 Hz
figure(6)
[db,mag,pha,grd,w] = freqz_m(h3,1); %TFTD de h2
subplot(2,2,1); plot(h3);grid; title('Filtro: Ruido Muscular para X3'); %Filtro quita ruido muscular
xlim([0,100]);
subplot(2,2,2); plot((w/pi)*Fs/2,mag);title('Magnitud');grid %Graficar la TFTD
xlabel('frecuencia en Hz'); xlim([0,Fs/2]);
subplot(2,2,3); plot((w/pi)*Fs/2,pha);title('Fase');grid %Graficar fase
xlabel('frecuencia en Hz'); xlim([0,Fs/2]);
subplot(2,2,4); plot((w/pi)*Fs/2,db);title('Magnitud en dB');grid %Respuesta en dB
axis([0 1 -100 10]); xlabel('frecuencia en Hz'); ylabel('Decibeles');
xlim([0,Fs/2]);

figure(7)
subplot(2,2,1); plot(x3); grid; %Graficar señal original
title('Señal x3 original');

x3Filt=conv(x3,h3); %Convolucion para filtrar la se;al
subplot(2,2,2); plot(x3Filt); grid; %Graficar señal filtrada
title('Señal x3 filtrada');

[db,mag,pha,grd,w] = freqz_m(x3,1); %TFTD de x3 original
subplot(2,2,3); plot((w/pi)*Fs/2,mag);grid %Graficar el espectro de x2 original
title('Espectro de x3 original');

[db,mag,pha,grd,w] = freqz_m(x3Filt,1); %TFTD de x3 filtrada
subplot(2,2,4); plot((w/pi)*Fs/2,mag);grid %Graficar el espectro de x2 filtrada
title('Espectro de x3 filtrada');


%Coeficientes
A1=conv(x1,h);
D1=conv(x1,g);

A2=conv(A1,h);
D2=conv(A1,g);

A3=conv(A2,h);
D3=conv(A2,g);

A4=conv(A3,h);
D4=conv(A3,g);




LD3=length(x1); %longitud de x1
Um3=max(D3)*0.8; %Valor de umbral, valor maximo de D3, reducido al 80%
pulso = 0; %iniciar el contador en cero
%Desplegar una marca en un valor que supere el umbral
for n=1:1:LD3
    if (D3(n) >= Um3 && Bandera ==1)    
        Bandera=0;  %bandera para entrar o no al if
        pulso = pulso+1;    %LLevar la cuenta
        x1(n)=x1(n)*1.1;    %Amplificar para una mejor visualización
        pos=n-3; %Variable auxiliar
        plot(pos,x1(pos),'dr'); %Desplegar marcas donde existe un pulso
    end
    if(D3(n)<Um3)
       Bandera = 1; %bandera para entrar o no al if anterior
    end
end 

FrecCar1 = pulso*10     %Mostrar el valor de los pulsos reales

LD3=length(x2); %longitud de x2
Um3=max(D3)*0.7; %Valor de umbral, valor maximo de D3, reducido al 80%
pulso = 0;  %iniciar el conteo de pulsos en cero
%Desplegar una marca en un valor que supere el umbral
for n=1:1:LD3
    if (D3(n) >= Um3 && Bandera ==1)    
        Bandera=0; %bandera para entrar o no al if
        pulso = pulso+1; %Contar los pulsos
        x2(n)=x2(n)*1.1; %Amplificar para una mejor visualización
        pos=n-3; %Variable auxiliar
        plot(pos,x2(pos),'dr'); %desplegar marcas donde existe un pulso
    end
    if(D3(n)<Um3)
       Bandera = 1; %bandera para entrar o no al if anterior
    end
end 

FrecCar2 = pulso*10 %conteo real de pulsos

LD3=length(x3); %longitud de x3
Um3=max(D3)*0.8; %Valor de umbral, valor maximo de
pulso = 0; %inicial el conteo en cero
%Desplegar una marca en un valor que supere el umbral
for n=1:1:LD3
    if (D3(n) >= Um3 && Bandera ==1)    
        Bandera=0;  %bandera para entrar o no al if
        pulso = pulso+1;    %llevar la cuenta de los pulsos
        x3(n)=x3(n)*1.1;    %amplificar la señal para una mejor visualización
        pos=n-4; %Variable auxiliar
        if pos ==58     %ajustar las marcas
           pos=57; 
        end
        if pos ==758    %ajustar las marcas
           pos=757; 
        end
        plot(pos,x3(pos),'dr'); %desplegar marcas donde existe un pulso
    end
    if(D3(n)<Um3)
       Bandera = 1; %bandera para entrar o no al if anterior
    end
end 

FrecCar3 = pulso*10 %Conteo real de pulsos



























