clc;
clear all
close all
format short %despliegue compacto redondeado de las variables
%format long  %despliegue con más decimales

W_finpasa=0.55*pi; %Banda de paso
W_inirecha=0.85*pi; %Banda de rechazo
R_maxpasa=1;  %Rachazo máximo de banda de paso
R_minrecha=32; %Rechazo máximo de banda de rechazo

T=1;
Ome_finpasa=W_finpasa/T;    %Omega de paso
Ome_inirecha=W_inirecha/T;  %Omega de rechazo

N = ceil( (log10( (10^(R_maxpasa/10)-1) / (10^(R_minrecha/10)-1)) ) / ( 2 * log10(Ome_finpasa/Ome_inirecha) )  );

Ome_corte = Ome_finpasa/((10^(R_maxpasa/10)-1)^(1/(2*N))); %Frecuencia de corte

[zs,ps,k] = buttap(N);  %Filtro Butterworth
                   
ps = ps*Ome_corte;  
As = real(poly(ps)); 
B = real(poly(zs)); 
k = k*Ome_corte^N;
Bs = k*B; 

[r,pols,k] = residue(Bs,As); 
polz = exp(pols*T); 

[b,a] = residuez(r,polz,k); 
 
Bz = real(b); 
Az = real(a); 
              
figure(1)

[db,mag,pha,grd,w] = freqz_m(Bz,Az);

subplot(2,2,1); %Magnitud y frecuencia del filtro en unidades de pi
plot(w/pi,mag); 
title('Magnitud')
xlabel('frequencia en unidades de pi'); 
ylabel('|H(z)|'); 
axis([0,1,0,1])
set(gca,'XTickMode','manual','XTick',[0, Ome_corte/pi, 1]);
set(gca,'YTickmode','manual','YTick',[0, 0.7071, 1]); 
grid

subplot(2,2,2); plot(w/pi,pha/pi); title('Fase'); xlabel('frequencia en unidades de pi');   %Fase del filtro
ylabel('unidades de pi'); axis([0,1,-1,1]); 
set(gca,'XTickMode','manual','XTick',[0, Ome_corte/pi, 1]);
set(gca,'YTickmode','manual','YTick',[-1,0,1]); grid

subplot(2,2,3); plot(w/pi,db); title('Magnitud en dB'); xlabel('frequencia en unidades de pi');  %Magnitud del filtro en dB 20log(Mag)
ylabel('decibeles'); axis([0,1,-80,5]);
set(gca,'XTickMode','manual','XTick',[0, W_finpasa/pi, W_inirecha/pi,1]);
set(gca,'YTickmode','manual','YTick',[-R_minrecha, -R_maxpasa, 0]); grid

%Mostrar en pantalla las características del filtro
%Orden, frec de corte, polos y ceros etc
fprintf('\n////////////////////////////////////////////////////////////// \n')
fprintf('\n*** Especificaciones: Wp=%2.2fpi, Wr=%2.2fpi, Rp=%2.2f-dB, Rr=%2.2f-dB \n', W_finpasa/pi, W_inirecha/pi, R_maxpasa, R_minrecha )
fprintf('\n*** Orden del filtro = %2.0f \n',N)
fprintf('\n*** Frecuencia de corte = %2.4fpi \n',Ome_corte/pi)
fprintf('\n*** Ceros en S: \n'); zs
fprintf('\n*** Polos en S: \n'); ps
fprintf('\n*** Numerador de Ha(s):  \n'); Bs
fprintf('\n*** Denominador de Ha(s): S^%2.0f  S^%2.0f  ....... S^0 \n', N, N-1); As
fprintf('\n*** Numerador de Ha(z):  \n'); Bz
fprintf('\n*** Denominador de Ha(z): Z^0  ..... Z^-%2.0f  Z^-%2.0f  \n', N-1, N); Az

%Nota:
%format long   %Conciderar más decimales de los coeficientes para que converjan los filtros
%b=Bz          %Con format short se regresa al despliegue normal
%a=Az



