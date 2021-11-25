clc
close all

%h[n] = e^n/8 {u[n] - u[n-7]}
%x[n] = u[n] - u[n-5]


figure(1)
x=[1 1 1 1 1]; %Se�al x[n] = u[n] - u[n-5]
h=[exp(0/8) exp(1/8) exp(2/8) exp(3/8) exp(4/8) exp(5/8) exp(6/8)]; %Se�al h[n] = e^n/8{u[n]-u[n-7]
y=conv(h,x);
n=0:length(y)-1;   
stem(n,y); grid on
title('Convoluci�n x[n] y h[n] usando funci�n conv')

% figure(2)
% H=[h(1)    0     0    0 
%     h(2)  h(1)   0    0
%     0      h(2)  h(1) 0
%     0      0     h(2) h(1)
%     0      0     0    h(2)];
% y1=H*x';
% stem(n,y1);


figure(2)

lx=length(x);              %tama�o de x
lh=length(h);           %tama�o de y
h=[zeros(1,9) h zeros(1,10)];    %h[n]=0 para valores no definidos
x=[zeros(1,9) x zeros(1,10)];   %x[n]=0 para valores no definidos
y2=[zeros(1,25)];   %vector de resultados lleno en 0

subplot(3,1,1)
stem(x) %graficar x[n]
title('x[n] = u[n] - u[n-5]'), grid on
subplot(3,1,2)
stem(h)     %graficar h[n]
title('h[n] = e^n/8 {u[n] - u[n-7]}'),grid on

for n=0:1:lx+lh-1       %convoluci�n usando ciclos for
    temp=0;
    for k=0:1:(lx)
    p=x(k+10)*h(n-k+10);
    temp=p+temp;
    end
     
  y2(n+11)=temp;
end
%%y2 guarda resultado de la convoluci�n%%
subplot(3,1,3)
n1=0:1:length(y2)-1;
stem(n1,y2); grid on   %gr�fica del resultado
title('Convoluci�n x[n] y h[n] con ciclos for')



    