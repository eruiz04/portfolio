%**********************************************************
%PROYECTO PARA BIOMEDICOS
%************************************************************


%LAS SIGUIENTES INSTRUCCIONES CARGAN LAS SEÑALES ECG A LAS VARIABLES Xs

clear all
close all


figure(1)

load ECG_RUIDO60.MAT  %Carga la señal ECG con ruido de 60 Hz
x1=ecg1;

load ECG_LB.MAT  %Carga la señal ECG con ruido de linea base
x2=ecg2;

load ECG_RUIDOMUS.MAT  %Carga la señal ECG con ruido muscular
x3=ecg3;

figure(1)       %señal con ruido 60
plot(x1); grid;
title('señal con ruido 60Hz')
figure(2)       %señal con ruido de linea base
plot(x2); grid;
title('señal con ruido linea base')

figure(3)       %señal con ruido muscular
plot(x3); grid;
title('señal con ruido muscular')

fs=250;   %los archivos estan muestreados a 250 muestras por segundo

h=[0.125 0.5 0.75 0.75 0.5 0.125]; %Apximaciòn
g=[1, -28, 119, -184, 119, -28, 1]; %Detalle Wavelet

figure(4)
subplot(2,1,1);
plot(h);  
title('señal de suavizado')
%graficar h
subplot(2,1,2);
plot(g);        %graficar g
title('señal wavelet diseñado de un sombrero mexicano')


%Coeficientes
A1=conv(x1,h);
D1=conv(x1,g);

A2=conv(A1,h);
D2=conv(A1,g);

A3=conv(A2,h);
D3=conv(A2,g);

A4=conv(A3,h);
D4=conv(A3,g);

%Mostrar coeficienes de aproximacion
figure(5);
subplot(4,1,1);
plot(A1);
title('coeficientes de aproximacion para la señal 1')

subplot(4,1,2);
plot(A2);

subplot(4,1,3);
plot(A3);

subplot(4,1,4);
plot(A4);

%Mostrar coeficientes de detalle
figure(6);
subplot(4,1,1);
plot(D1);
title('coeficientes detalle para la señal 1');

subplot(4,1,2);
plot(D2);

subplot(4,1,3);
plot(D3);

subplot(4,1,4);
plot(D4);


%Freq cardiaca 90pulsos/min
%Conteo de pulsos
figure(7)
plot(x1); %que la señal permanezca mostrada
title('señal con ruido 60Hz antes del filtrado')

hold on;
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Coeficientes
A1=conv(x2,h);
D1=conv(x2,g);

A2=conv(A1,h);
D2=conv(A1,g);

A3=conv(A2,h);
D3=conv(A2,g);

A4=conv(A3,h);
D4=conv(A3,g);

%Mostrar coeficienes de aproximacion
figure(8);
subplot(4,1,1);
title('coeficientes de aproximacion para la señal 2');
plot(A1);

subplot(4,1,2);
plot(A2);

subplot(4,1,3);
plot(A3);

subplot(4,1,4);
plot(A4);

%Mostrar coeficientes de detalle
figure(9);
subplot(4,1,1);
plot(D1);
title('coeficente de detalle para la señal 2')

subplot(4,1,2);
plot(D2);

subplot(4,1,3);
plot(D3);

subplot(4,1,4);
plot(D4);


%Freq cardiaca 90pulsos/min
%Conteo de pulsos 
figure(10)
plot(x2);
title('linea basal antes del umbral')%que la señal permanezca mostrada
hold on;
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Coeficientes
A1=conv(x3,h);
D1=conv(x3,g);

A2=conv(A1,h);
D2=conv(A1,g);

A3=conv(A2,h);
D3=conv(A2,g);

A4=conv(A3,h);
D4=conv(A3,g);

%Mostrar coeficienes de aproximacion
figure(11);
subplot(4,1,1);
plot(A1);
title('coefientes de aproximacion para ruido muscular ')
subplot(4,1,2);
plot(A2);

subplot(4,1,3);
plot(A3);

subplot(4,1,4);
plot(A4);

%Mostrar coeficientes de detalle
figure(12);
subplot(4,1,1);
plot(D1);
title('coefientes de detalle para linea de base para ruido muscular ')

subplot(4,1,2);
plot(D2);

subplot(4,1,3);
plot(D3);

subplot(4,1,4);
plot(D4);


%Freq cardiaca 90pulsos/min
%Conteo de pulsos
figure(13)
plot(x3);   %que la señal permanezca mostrada
title('señal de ruido muscular antes de pasar por el umbral')
hold on;
LD3=length(x3); %longitud de x3
Um3=max(D3)*0.9; %Valor de umbral, valor maximo de D3, reducido al 80%
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