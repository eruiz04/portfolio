clc;
clear all
close all
%*************************************************************************
rho=0:0.001:2;
omega=-pi:0.1:pi;
z=rho'*exp(j*omega);
%-------------------------Polos y Ceros para el Mesh-----------------------
p1=0.7*exp(-j*pi/18);
p2=0.7*exp(-j*-pi/18);
c1=0.7*exp(-j*3*pi/4);
%c2=0.7*exp(-j*-3*pi/4);
%-------------------------------Funcion H(z)-------------------------------
%Hz=(z-c1).*(z-c2)./((z-p1).*(z-p2));
Hz=(z-c1)./((z-p1).*(z-p2));
%--------------------Grafica de Magnitud de H(z) (Mesh)--------------------
figure(1)
x=real(z);
y=imag(z);
mesh(x,y,abs(Hz));
title('Grafica de la magnitud de H(z)');
figure(2);
hold on
plot(real(c1),imag(c1),'bo')
%plot(real(c2),imag(c2),'bo')
plot(real(p1),imag(p1),'rx')
plot(real(p2),imag(p2),'rx')
%---------------------------Polos y Ceros (x vs y)-------------------------
angulo=-pi:0.1:pi;
r=1;
circulo=r*exp(-j*angulo);
plot(real(circulo),imag(circulo),'y-');
axis([-1.5 1.5 -1.5 1.5]);
xlabel('Parte real de z'); title('Distribución de polos (x) y ceros (o)'); ylabel('Parte imaginaria de z')
hold off
figure(3);
omega=0:0.1:pi;
z=1*exp(j*omega);
%--------------------------Respuesta en Frecuencia-------------------------
%Hz=(z-c1).*(z-c2)./((z-p1).*(z-p2));
Hz=(z-c1)./((z-p1).*(z-p2));
plot(omega,abs(Hz));
title('Grafica de la magnitud de H(z)');





