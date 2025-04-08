clc;
close all;
clear all;

% Parámetros de configuración
fm = 100000; % Frecuencia de muestreo de la señal original (Hz)
tm = 1/fm;   % Periodo de muestreo
ls = 200;    % Largo de la señal en muestras
f_c = 1000;  % Frecuencia de la señal sinusoidal (Hz)

% Vector de tiempo
t = (0:ls-1) * tm;

% Generación de la señal sinusoidal
m_t = sin(2 * pi * f_c * t);

% Gráfico de la señal sinusoidal
figure;
plot(t, m_t, 'b', 'LineWidth', 1.5);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal Sinusoidal (m(t))');
grid on;
hold on;
