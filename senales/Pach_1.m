
clc
close all
clear all

a=0;
for sigma=-10:0.1:10;
    a=a+1;
    b=0;
    for omega=-10:0.1:10;
        b=b+1;
        s(b,a)=sigma+j*omega;
                
    end
end


R=1;  %mover entre 1 y 0.2 para no salir de rango
C=0.05;  
L=0.5;


H1=(1/(L*C) ) ./( s.^2+s/(R*C)+1/(L*C) );		%pasa bajas
H2=( s.^2) ./( s.^2+s/(R*C)+1/(L*C) );		%pasa altas
H3=((s./(R*C)) ./( s.^2+s/(R*C)+1/(L*C) ));		%pasa banda
H4=( s.^2+1/(L*C) ) ./( s.^2+s/(R*C)+1/(L*C) );				%Notch

figure(1)
ejesig=real(s);
ejeome=imag(s);
mesh(ejesig,ejeome,abs(H1));
%mesh(ejesig,ejeome,20*log10(abs(H)));
axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Pasa Bajas');

figure(2)
ejesig=real(s);
ejeome=imag(s);
mesh(ejesig,ejeome,abs(H2));
%mesh(ejesig,ejeome,20*log10(abs(H)));
axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Pasa Altas');

figure(3)
ejesig=real(s);
ejeome=imag(s);
mesh(ejesig,ejeome,abs(H3));
%mesh(ejesig,ejeome,20*log10(abs(H)));
axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Pasa Bandas');

figure(4)
ejesig=real(s);
ejeome=imag(s);
mesh(ejesig,ejeome,abs(H4));
%mesh(ejesig,ejeome,20*log10(abs(H)));
axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Notch (Rechaza Banda)');



%%%Otras graficas
figure(5)
a=0;
for sigma=-10:0.1:10;
    a=a+1;
    b=0;
    for omega=-10:0.1:10;
        b=b+1;
        sigma=0;
        s(b,a)=sigma+j*omega;
                
    end
end
H1=(1/(L*C) ) ./( s.^2+s/(R*C)+1/(L*C) );		%pasa bajas
ejesig=real(s);
ejeome=imag(s);
mesh(ejesig,ejeome,abs(H1));
%mesh(ejesig,ejeome,20*log10(abs(H)));
axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Pasa Bajas')

figure(6)
a=0;
for sigma=-10:0.1:10;
    a=a+1;
    b=0;
    for omega=-10:0.1:10;
        b=b+1;
        sigma=0;
        s(b,a)=sigma+j*omega;
                
    end
end

ejesig=real(s);
ejeome=imag(s);
H2=( s.^2) ./( s.^2+s/(R*C)+1/(L*C) );		%pasa altas
mesh(ejesig,ejeome,abs(H2));
%mesh(ejesig,ejeome,20*log10(abs(H)));
axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Pasa Bajas')

figure(7)
a=0;
for sigma=-10:0.1:10;
    a=a+1;
    b=0;
    for omega=-10:0.1:10;
        b=b+1;
        sigma=0;
        s(b,a)=sigma+j*omega;
                
    end
end

ejesig=real(s);
ejeome=imag(s);
H3=((s./(R*C)) ./( s.^2+s/(R*C)+1/(L*C)));		%pasa banda
mesh(ejesig,ejeome,abs(H3));
%mesh(ejesig,ejeome,20*log10(abs(H)));
axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Pasa Banda')


figure(8)
a=0;
for sigma=-10:0.1:10;
    a=a+1;
    b=0;
    for omega=-10:0.1:10;
        b=b+1;
        sigma=0;
        s(b,a)=sigma+j*omega;
                
    end
end

ejesig=real(s);
ejeome=imag(s);
H4=( s.^2+1/(L*C) ) ./( s.^2+s/(R*C)+1/(L*C) );				%Notch
mesh(ejesig,ejeome,abs(H4));
%mesh(ejesig,ejeome,20*log10(abs(H)));
axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Pasa Banda')



%%ultimas graficas
figure(9)
a=1;
    for omega=-10:0.1:10;
        w(a)=j*omega;
                a=a+1;
    end

RF=( 1/(L*C) ) ./( w.^2+w/(R*C)+1/(L*C) );
ejeome=imag(w);
plot(ejeome,abs(RF),'r');
hold on
C=1
RF=( 1/(L*C) ) ./( w.^2+w/(R*C)+1/(L*C) );
ejeome=imag(w);
plot(ejeome,abs(RF),'g');
%mesh(ejesig,ejeome,20*log10(abs(H)));
%axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Pasa Bajas')

figure(10)

a=1;
    for omega=-10:0.1:10;
        w(a)=j*omega;
                a=a+1;
    end


RF=( w.^2 ) ./( w.^2+w/(R*C)+1/(L*C) );
ejeome=imag(w);
plot(ejeome,abs(RF),'r');
hold on
C=1
RF=( w.^2 ) ./( w.^2+w/(R*C)+1/(L*C) );
ejeome=imag(w);
plot(ejeome,abs(RF),'g');
%mesh(ejesig,ejeome,20*log10(abs(H)));
%axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Pasa Altas')

figure(11)

a=1;
    for omega=-10:0.1:10;
        w(a)=j*omega;
                a=a+1;
    end


RF=( w./(R*C) ) ./( w.^2+w/(R*C)+1/(L*C) );
ejeome=imag(w);
plot(ejeome,abs(RF),'r');
hold on
C=1
RF=( w./(R*C) ) ./( w.^2+w/(R*C)+1/(L*C) );
ejeome=imag(w);
plot(ejeome,abs(RF),'g');
%mesh(ejesig,ejeome,20*log10(abs(H)));
%axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Pasa Banda')

figure(12)

a=1;
    for omega=-10:0.1:10;
        w(a)=j*omega;
                a=a+1;
    end


RF=( w.^2+1/(L*C) ) ./( w.^2+w/(R*C)+1/(L*C) );
ejeome=imag(w);
plot(ejeome,abs(RF),'r');
hold on
C=1
RF=( w.^2+1/(L*C) ) ./( w.^2+w/(R*C)+1/(L*C) );
ejeome=imag(w);
plot(ejeome,abs(RF),'g');
%mesh(ejesig,ejeome,20*log10(abs(H)));
%axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Rechaza banda')