clc;
clear;
close all;

% Parámetros configurables
fm = 1000;  % Frecuencia de la señal moduladora (Hz)
fs = 20000;  % Frecuencia de muestreo (Hz) (Ajustable, aumentada)
d = 0.3;    % Ciclo de trabajo (tau / T) (Ajustable)

% Definición de la señal original
Tm = 1/fm;  
t = 0:Tm/500:2*Tm;  % Mayor resolución en el tiempo
x = sin(2*pi*fm*t); % Señal sinusoidal

% Muestreo de la señal
Ts = 1/fs;    % Periodo de muestreo
t_muestras = 0:Ts:max(t); % Instantes de muestreo
x_muestras = sin(2*pi*fm*t_muestras); % Muestras de la señal

% Gráfica de la modulación PAM
figure;
stem(t_muestras, x_muestras, 'g', 'LineWidth', 1.5); % Gráfica en rojo con más puntos
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Modulación PAM con Muestreo Instantáneo');
grid on;
