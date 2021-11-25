clc
close all   %cierra ventanas 


%y[n]-0.7*y[n-1]=1.2*x[n]

figure(1)

a=5;                        %Condición inicial y[n-1]=a
x=[0 0 0 0  1 0 0 0 0];     %Señal x[n]
y=[0 0 0 a  0 0 0 0 0];     %Señal y[n] con condición inicial y[n-1]=a


for n=5:1:9        
    %despeje y[n]
    y(n)=1.2*x(n) + 0.7*y(n-1);     %y[n] para n>=0
end

for n=4:-1:2
    %despeje y[n-1]
    y(n-1)=(y(n) - 1.2*x(n))/0.7;   %y[n] para n<0
end

k=-4:1:4;       %grafica n de -4 a 4
stem(k,y); grid on     %Graficar la %Señal y[n] 
title('P3. Ecuaciones de diferencias')
