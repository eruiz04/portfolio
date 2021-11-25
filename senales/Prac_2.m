                                     %Practica 2
    % 1) Defina una se�al senoidal con frecuencia de 100 Hz, muestreada a 220
    % muestras/segundo. Grafique 6 ciclos de la se�al
    % 2) Implemente un algoritmo que calcule la transformada de Fourier de tiempo
    % discreta (TFTD) mediante ciclos for.
    % 3) Aplique el algoritmo del paso 2 a la se�al del paso 1 y grafique la magnitud y
    % la fase con respeto a la frecuencia.
    % 4) Muestree la se�al del paso 1 con una frecuencia de muestreo menor, y otra
    % mayor, que 200 m/s y aplique la TFTD. Grafique las magnitudes. Explique qu�
    % sucede con los espectros de frecuencia cuando la se�al es sub-muestreada y
    % sobre-muestreada; escr�balo en la secci�n de resultados.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%grafica 6 ciclos%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)

Fsenal=100;  %90hz
Tsenal=1/Fsenal;    %periodo de la se�al
LonSenal=Tsenal*6;     %longitud se�al, 6 ciclos
t=0:0.001:LonSenal;     %tiempo para 6 ciclos
x=sin(2*pi*Fsenal*t);   %se�al senoidal
subplot(3,2,1); plot(t,x,'b'); axis([0, LonSenal, -1.5, 1.5]); grid %graficar
xlabel('Tiempo');ylabel('Voltaje');title('1) Se�al Senoidal');
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%muestreo se�al%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Fm=220;     %frec muestreo
Tm=1/Fm;    %periodo, tiempo muestreo
td=0:Tm:LonSenal;   %tiempo discreto
xd=sin(2*pi*Fsenal*td);     %se�al discreta
hold on; subplot(3,2,1); stem(td,xd,'k*'); hold off; %graficar

%%%%%%%%%%%%%%%%%%%%%%%%grafica espigas, muestreo de la senal%%%%%%%%%%
Lon_n=length(xd);   
n=1:1:Lon_n;    %tiempo discreto
subplot(3,2,2); stem(n,xd,'k'); axis([0, Lon_n, -1.5, 1.5]); grid %graficar
deltaw = 0.01;      %10 milirad/seg
w=0:deltaw:2*pi;  %funcion delta
xlabel('Tiempo');ylabel('Voltaje');title('2) Se�al Senoidal Muestreada');

%%%%%%%%%%%%%%ciclo for para transf de fourier%%%%%%%%%%%%%
for col=1:1:length(w)
    for fil=1:1:length(xd)
        matriz(fil,col) = exp(-1j*n(fil)*w(col));   %llenado de matriz
    end
end

X = xd*matriz;      %transf fourier
magX = abs(X); %magnitud serie de fourier



%%%%%%%%%%%%%%%%%%%grafica transf fourier con ciclo for%%%%%%%%%%%%%%
%figure(2)
ejeHz=(Fm/2)*w/pi;  %dominio de la frecuencia
subplot(3,2,3);     %posicion grafica
plot(ejeHz,magX,'c'); grid     %graficar
xlabel('frecuencia (Hz)'); title('3) Tranformada de Fourier con For'); ylabel('Magnitud')



%%%%%%%%%%%%%%%%%%fourier con transformada de matlab%%%%%%%%%%%%%%

%figure(3)
X1=fft(xd,length(w));   %transformada rapida de fourier
magX1=abs(X1);  %magnitud transformada
ejeHz=(Fm/2)*w/pi;  %dominio de la frecuencia
subplot(3,2,4);     %posicion grafica
plot(ejeHz,magX1,'m'); grid    %graficar
xlabel('frecuencia (Hz)'); title('4) Tranformada de Fourier con TFTD'); ylabel('Magnitud')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%senal sub-muestreada%%%%%%%%%%%%%%%%%%%%%%%
Fmenor=100;     %frecuencia menor de muestreo
Tm1=1/Fmenor;   %periodo 

td1=0:Tm1:LonSenal;     %tiempo discreto
xd1=sin(2*pi*Fsenal*td1);   %se�al sub muestreada
X2=fft(xd1,length(w));  %transf fourier
magX1=abs(X2);      %magnitud transf fourier
ejeHz=((Fmenor)/2)*w/pi;    %dominio de la frecuencia
subplot(3,2,5); %posicion de la grafica
plot(ejeHz,magX1,'g'); grid  %graficar
xlabel('frecuencia (Hz)'); title('5) Se�al sub-muestreada'); ylabel('Magnitud')

%%%%%%%%%%%%%%%%%%%%%%%%%%senal sobre muestreada%%%%%%%%%%%%%%%%%%%%%%%%%%
Fmayor=600;     %frec muestreo mayor
Tm2=1/Fmayor;       %periodo 
td2=0:Tm2:LonSenal;     %tiempo discreto
xd2=sin(2*pi*Fsenal*td2);       %se�al a muestrear
X3=fft(xd2,length(w));  %transf de fourier
magX1=abs(X3);      %magnitud de la transformada
ejeHz=((Fmayor)/2)*w/pi;        %dominio de la frecuencia
subplot(3,2,6); %posicion de la grafica
plot(ejeHz,magX1,'r'); grid     %graficar
xlabel('frecuencia (Hz)'); title('6) Se�al sobre-muestreada'); ylabel('Magnitud')

