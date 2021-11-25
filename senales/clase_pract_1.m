%Mi primer programa :v
%Practica 1

clear all   %limpia variables
clc  %limpia vent comandos
close all  %cierra las fig

fm=1000;    %frec muestreo, 1000 (muestras/seg)
tm= 1/fm;   %periodo de muestreo (seg/muestras)
n= 0:tm:3;   %se genera vector de tiempo discreto (seg)
f=10;
fi=0;
V=sin(2*pi*f*n + fi);

plot(n,V,'ob');

%completar para cuadrada, exp, rectpuls y sawtooth

