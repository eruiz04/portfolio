
clc
close all
clear all

%******Diseño Filtro Analógicos Chebyschev

FrecBP=2*pi*(3600);   %Frecuencia (rad/seg) en la banda de paso
FrecBR=2*pi*(1200);  %Frecuencia en la banda de rechazo
AteBP=3;    %Atenuación (db) máx. en la bp
AteBR=20;   %Atenuación mín. en la br
[N,Frecorte]=cheb1ord(FrecBP,FrecBR,AteBP,AteBR,'s');
[B,A] = cheby1(N,AteBP,Frecorte,'high','s');
figure(1)
Omega=0:100:(2*pi)*7000;
H=freqs(B,A,Omega);
db=20*log10(abs(H));
EjeHz=Omega/(2*pi);
semilogx(EjeHz,db);


title('Filtro pasa altas');
%subplot(2,2,1);
figure(2)

%%%%%polos y ceros

[z,p,k]=cheby1(N,AteBP,Frecorte,'high','s');
zplane(z,p);
grid on
title('Polos y ceros');
%subplot(2,1,2);
%%respuesta en frecuencia
figure(3)
[H,w]=freqs(B,A);
plot(w,abs(H));
title('Respuesta en frecuencia del filtro');
%subplot(2,2,3);


%*******************************************
%Graficación de la rebanada de Fourier
%*******************************************
figure(4)
bode(B,A)
%subplot(2,2,4);

figure(5)
a=0;
for sigma=-(2*pi)*7000:500:(2*pi)*7000;
    a=a+1;
    b=0;
    for omega=-(2*pi)*7000:500:(2*pi)*7000;
        b=b+1;
        s(b,a)=0+j*omega;
                
    end
end
R=roots(A)
Hs=B(1).*s.^2./( (s-R(1)).*(s-R(2)));
ejesig=real(s);
ejeome=imag(s);
mesh(ejesig,ejeome,20*log10(abs((Hs))));
%axis([-1 1 0 10000 0 -200])
xlabel('eje real (rad/seg)');
ylabel('eje imaginario (rad/seg)')
title('Rebanada de Fourier');
%figure(6)

figure(6)
%*******************************************
%Graficación en el Plano s
%*******************************************
a=0;
for sigma=-(2*pi)*7000:500:(2*pi)*7000;
    a=a+1;
    b=0;
    for omega=-(2*pi)*7000:500:(2*pi)*7000;
        b=b+1;
        s(b,a)=sigma+j*omega;
                
    end
end

R=roots(A)
R=R'
R
Hs=B(1).*s.^2./( (s-R(1)).*(s-R(2)) );
ejesig=real(s);
ejeome=imag(s);

mesh(ejesig,ejeome,abs(Hs));
%axis([-1000,1000,-1000,1000,-10,10]);
%axis([-0.01 0.01 -1 1 0 10])
xlabel('eje real (rad/seg)');
ylabel('eje imaginario (rad/seg)')


%figure(5)
sos=zp2sos(z,p,k);
%fvtool(sos);
