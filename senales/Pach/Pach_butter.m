
clc
close all
clear all

%******Diseño Filtro Analógicos Butterworth
figure(1)
FrecBP=2*pi*(70);  %wp %Frecuencia (rad/seg) en la banda de paso
FrecBR=2*pi*(120); %ws %Frecuencia en la banda de rechazo
AteBP=1;  %rp  %Atenuación (db) máx. en la bp
AteBR=40; %rs  %Atenuación mín. en la br
[N,Frecorte]=buttord(FrecBP,FrecBR,AteBP,AteBR,'s');
[B,A] = butter(N,Frecorte,'low','s');

Omega=0:10:10000;
H=freqs(B,A,Omega);
db=20*log10(abs(H));
EjeHz=Omega/(2*pi);
semilogx(EjeHz,db);
title('Filtro Pasa Bajas');
figure(2)
%*******************************************
%Graficación en el Plano s
%*******************************************
a=0;
for sigma=-1500:10:1500;
    a=a+1;
    b=0;
    for omega=-1500:10:1500;
        b=b+1;
        s(b,a)=sigma+j*omega;
                
    end
end

R=roots(A)
R=R'
Hs=B(11)./( (s-R(1)).*(s-R(2)).*(s-R(3)).*(s-R(4)).*(s-R(5)).*(s-R(6)).*(s-R(7)).*(s-R(8)).*(s-R(9)).*(s-R(10)) );
ejesig=real(s);
ejeome=imag(s);

mesh(ejesig,ejeome,abs(Hs));
axis([-1000,1000,-1000,1000,-10,10]);
%axis([-0.01 0.01 -1 1 0 10])
xlabel('eje real (rad/seg)');
ylabel('eje imaginario (rad/seg)')

figure(3)
clear s;
%*******************************************
%Graficación de la rebanada de Fourier
%*******************************************
a=0;
for sigma=-20:10:20;
    a=a+1;
    b=0;
    for omega=-5000:10:5000;
        b=b+1;
        s(b,a)=0+j*omega;
                
    end
end

R=roots(A)

Hs=B(1,11)./( (s-R(1,1)).*(s-R(2,1)).*(s-R(3,1)).*(s-R(4,1)).*(s-R(5,1)).*(s-R(6,1)).*(s-R(7,1)).*(s-R(8,1)).*(s-R(9,1)).*(s-R(10,1)) );
ejesig=real(s);
ejeome=imag(s);

mesh(ejesig,ejeome,20*log10(abs(Hs)));
%axis([-1 1 0 10000 0 -200])
xlabel('eje real (rad/seg)');
ylabel('eje imaginario (rad/seg)')
title('Rebanada de Fourier');

figure(4)
bode(B,A)

figure(5)
[z,p,k]=butter(N,Frecorte,'low','s');
zplane(z,p);
grid on
title('Polos y ceros');