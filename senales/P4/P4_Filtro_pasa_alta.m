clc;
clear all
close all
%*************************************************************************
rho=0:0.001:2;
omega=-pi:0.1:pi;
z=rho'*exp(j*omega);
%-------------------------Polos y Ceros para el Mesh-----------------------
p1=0.6*exp(-j*2*pi/3);
p2=0.6*exp(-j*2*-pi/3);
p3=0.6*exp(-j*5*pi/6);
p4=0.6*exp(-j*5*-pi/6);

c1=0.6*exp(-j*pi/6);
c2=0.6*exp(-j*-pi/6);
c3=0.6*exp(-j*pi/3);
c4=0.6*exp(-j*-pi/3);
%-------------------------------Funcion H(z)-------------------------------
%Hz=(z-c1).*(z-c2)./((z-p1).*(z-p2));
%Hz=(z-c1)./((z-p1).*(z-p2));
Hz=(z-c1).*(z-c2).*(z-c3).*(z-c4)./((z-p1).*(z-p2).*(z-p3).*(z-p4));
%--------------------Grafica de Magnitud de H(z) (Mesh)--------------------
figure(1)
x=real(z);
y=imag(z);
mesh(x,y,abs(Hz));
title('Grafica de la magnitud de H(z)');

%---------------------------Polos y Ceros (x vs y)-------------------------
figure(2);
hold on
plot(real(c1),imag(c1),'bo')
plot(real(c2),imag(c2),'bo')
plot(real(c3),imag(c3),'bo')
plot(real(c4),imag(c4),'bo')

plot(real(p1),imag(p1),'rx')
plot(real(p2),imag(p2),'rx')
plot(real(p3),imag(p3),'rx')
plot(real(p4),imag(p4),'rx')

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
%Hz=(z-c1)./((z-p1).*(z-p2));
Hz=(z-c1).*(z-c2).*(z-c3).*(z-c4)./((z-p1).*(z-p2).*(z-p3).*(z-p4));
plot(omega,abs(Hz));
title('Grafica de la magnitud de H(z)');
xlabel('Frecuencia w'); ylabel('Magnitud de H(z)');