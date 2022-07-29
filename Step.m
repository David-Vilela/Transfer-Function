%{
 GRUPO:
    - Alex Júnior Guimarães - 17.2.1471
    - David Augusto Rocha Vilela Torres - 15.2.1168
    - Júlia Miranda Valente - 19.2.1381
    - Juliana Lourenço dos Santos Silva - 20.2.0003
    - Vitor Matos Soares - 17.2.1367
%}

% ### QUESTÃO 01 ###
 
 % instrumentos de primeira ordem

% inserindo dados da tabela
% tempo
t = xlsread ('dados1ordem.xlsx','A:A') %apos usar esse comando selecionar coluna correta para cada
% saidas amostradas do sistema lento
qoL=xlsread ('dados1ordem.xlsx','B:B') 
% saidas amostradas do sistema rapido
qoR=xlsread ('dados1ordem.xlsx','C:C')

%Aplicando procedimento no sistema Lento

% transformada Z
% pela análise do gráfico
% degrau unitario
qis = 1
% constante K
K = 1
Zl = log(1-(qoL/(qis*K)))

% plotando as amostras pela resposta do sistema ao degrau
figure(1)
plot(t,qoL,'blue.')
title('Resposta ao degrau - Sistema Lento')
xlabel('tempo (s)')
ylabel('qoLento')
% sistema acomoda em 1 em regime permanente, logo K = 1
K = 1

% plotando Z x t (transformada z)
figure(2)
plot(t,Zl,'red.')
title('Gráfico Z x t - Sistema Lento')
xlabel('tempo (s)')
ylabel('qoLento')

%{
 temos que (dz/dt) = (-1/tal), logo tal = -1 / (dz/dt)
 graficamente sabemos que dz/dt é o coeficiente angular
 do gráfico Z x t
%}

%calculando de (dz/dt)
dz = polyfit(t,Zl,1)
% constante de tempo do sistema lento
talL = -1 / dz(1)

% temos então a seguinte função de transferencia
ftL = tf([K*1],[talL 1])
% resposta do sistema lento ao degrau
figure(3)
step(ftL)
title('Resposta ao degrau - Sistema Lento')

 
%Aplicando procedimento no sistema Rápido
%***************
% transformada Z
% transformada Z
% pela análise do gráfico
% degrau unitario
qis = 1
% constante K
K = 1
Zr = log(1-(qoR/(qis*K)))

% plotando as amostras pela resposta do sistema ao degrau
figure(4)
plot(t,qoR,'blue.')
title('Resposta ao degrau - Sistema Rápido')
xlabel('tempo (s)')
ylabel('qoLento')
% sistema acomoda em 1 em regime permanente, logo K = 1
K = 1

% plotando Z x t (transformada z)
figure(5)
plot(t,Zr,'red.')
title('Gráfico Z x t - Sistema Rápido')
xlabel('tempo (s)')
ylabel('qoLento')

%{
 temos que (dz/dt) = (-1/tal), logo tal = -1 / (dz/dt)
 graficamente sabemos que dz/dt é o coeficiente angular
 do gráfico Z x t
%}

%calculando de (dz/dt)
dz = polyfit(t,Zr,1)
% constante de tempo do sistema lento
talR = -1 / dz(1)

% temos então a seguinte função de transferencia
ftR = tf([K*1],[talR 1])
% resposta do sistema lento ao degrau
figure(6)
step(ftR)
title('Resposta ao degrau - Sistema Rápido')


% ### QUESTÃO 02 ###

% instrumentos de segunda ordem

% inserindo dados da tabela
% tempo
t = xlsread ('dados2aordem.xlsx','A:A')
% saídas amostradas
qo=xlsread ('dados2aordem.xlsx','B:B')

% plotando resposta do sistema a um degrau
figure(7)
plot(t,qo,'blue.')
title('Resposta ao degrau - Sistema de 2º Ordem')
xlabel('tempo (s)')
ylabel('qo')

% período T
T = 0.42 - 0.185

A = 0.9
% overshoot
a = 1.507 - A

% determinação de dzeta - quociente de amortecimento
dz = sqrt(1/(pi/((log(a/A))^2) + 1))
% freq. natural não amortecida
wn = (2*pi)/(T*sqrt(1-dz^2))

% testando wn e dz estimados
tf2 = tf([wn^2],[1 2*dz*wn wn^2])
figure(8)
plot(t,qo,'blue.')
hold on
step(tf2)
title('Resposta ao degrau - Sistema de 2º ordem')



