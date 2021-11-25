
close all
clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%ejercicio 1%%%%%%%%%%%%%%%%%%%%%%%%
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


H=(1/(L*C) ) ./( s.^2+s/(R*C)+1/(L*C) );		%pasa bajas

figure(1)
ejesig=real(s);
ejeome=imag(s);
mesh(ejesig,ejeome,abs(H));
%mesh(ejesig,ejeome,20*log10(abs(H)));
axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Pasa Bajas');



%%%%%%%%%%%%%%%%%%%%%%%%%%Rebanada de Fourier%%%%%%%%%%%%
figure(3)
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
H=(1/(L*C) ) ./( s.^2+s/(R*C)+1/(L*C) );		%pasa bajas
ejesig=real(s);
ejeome=imag(s);
mesh(ejesig,ejeome,abs(H));
%mesh(ejesig,ejeome,20*log10(abs(H)));
axis([-10 10 -10 10 -2 3])
xlabel('eje real');
ylabel('eje imaginario')
title('Pasa Bajas')


%%%%%%%%%%%%%%%%inciso 2
%%%%%%%%%%%%%%%%%%%%%varias frecuencias de corte%%%%%%%%%%%%%

figure(2)
a=1;
    for omega=-100:5:100;
        w(a)=j*omega;
                a=a+1;
    end
    
subplot(2,2,1)    
R=1;  %mover entre 1 y 0.2 para no salir de rango
C=0.05;  
L=0.5;

RF=( 1/(L*C) ) ./( w.^2+w/(R*C)+1/(L*C) );
ejeome=imag(w);
plot(ejeome,abs(RF),'b');             %frecuencia 1
xlabel('eje real');
ylabel('eje imaginario')
title('Plano de LaPlace: Pasa Bajas R=1')

subplot(2,2,2)  
R=0.3;  %mover entre 1 y 0.2 para no salir de rango
C=0.05;  
L=0.5;

RF=( 1/(L*C) ) ./( w.^2+w/(R*C)+1/(L*C) );
ejeome=imag(w);
plot(ejeome,abs(RF),'b');             %frecuencia 2
xlabel('eje real');
ylabel('eje imaginario')
title('Plano de LaPlace: Pasa Bajas R=0.3')

subplot(2,2,3)  
R=0.6;  %mover entre 1 y 0.2 para no salir de rango
C=0.05;  
L=0.5;

RF=( 1/(L*C) ) ./( w.^2+w/(R*C)+1/(L*C) );
ejeome=imag(w);
plot(ejeome,abs(RF),'b');             %frecuencia 2
xlabel('eje real');
ylabel('eje imaginario')
title('Plano de LaPlace: Pasa Bajas R=0.6')

subplot(2,2,4)  
R=0.8;  %mover entre 1 y 0.2 para no salir de rango
C=0.05;  
L=0.5;

RF=( 1/(L*C) ) ./( w.^2+w/(R*C)+1/(L*C) );
ejeome=imag(w);
plot(ejeome,abs(RF),'b');             %frecuencia 2
xlabel('eje real');
ylabel('eje imaginario')
title('Plano de LaPlace: Pasa Bajas 0.8')