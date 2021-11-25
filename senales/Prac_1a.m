    %Mi primer programa :v
%Practica 1

clear all   %limpia variables
clc  %limpia vent comandos
close all  %cierra las fig

fm=1000;    %frec muestreo, 1000 (muestras/seg)
tm= 1/fm;   %periodo de muestreo (seg/muestras)
n=0:tm:3;   %se genera vector de tiempo discreto (seg)
f=2;
fi=-pi/2;       %fase
V=sin(2*pi*f*(-1)*n + fi);       %n/2 se ensancha, 2n se contrae 
%figure(1)
subplot(3,2,1)  %lugar 1 de grafica
plot(n,V,'r'); %grafica señal seno en  tiempo discreto
grid on
xlabel('Tiempo');
ylabel('Voltaje');
title('Señal Uno: Seno');

%Cuadrada
A=1;    %amplitud
w=2*pi;     %periodo señal
sq= A*square(w*n);  %señal cuadrada
subplot(3,2,2) %lugar 2 de la grafoca
plot(n,sq,'b'); %grafica señal cuadrada en  tiempo discreto
grid on
xlabel('Tiempo');
ylabel('Voltaje');
title('Señal Dos: Cuadrada');

%Exponencial
x=(0:0.001:5);      %vector de tiempo
%y=(x.*(exp(x)));    %xe^x
y=((exp(x)));   %señal exponencial
subplot(3,2,3) 
plot(x,y,'b');
grid on
xlabel('Tiempo');
ylabel('Amplitud');
title('Señal Tres: Exponencial');

%Impulso
t = (-1:0.01:1)';   %vector de tiempo
impulse = t==0;     %señal impulso
subplot(3,2,4)
plot(t,impulse,'b');
grid on
xlabel('Tiempo');
ylabel('Amplitud');
title('Señal Cuatro: Impulso');

%Diente de sierra
sierra= A*sawtooth(w*n);        %señal diente de sierra
subplot(3,2,5)
plot(n,sierra,'b');
grid on
xlabel('Tiempo');
ylabel('Amplitud');
title('Señal Cinco: Diente de Sierra');

%la hicimos en clase
tau=-100e-3;
I=3*exp(n/tau);
%figure(2)
subplot(3,2,6);
plot(n,I,'g');
grid on
xlabel('Tiempo');
ylabel('Voltaje');
title('Señal ejemplo de clase');
