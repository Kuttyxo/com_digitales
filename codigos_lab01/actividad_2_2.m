clc; clear; close all;

% Parámetros de la señal
fs = 1000; % Frecuencia de muestreo (Hz)
t = 0:1/fs:1; % Vector de tiempo de 1 segundo
f = 5; % Frecuencia de la señal (Hz)
x_original = sin(2*pi*f*t); % Señal original (onda senoidal)

% Cuantización con N=5 bits
N1 = 5;
L1 = 2^N1; % Niveles de cuantización
xq_5bits = round((x_original + 1) * (L1/2)) / (L1/2) - 1; % Señal cuantizada

% Cuantización con N=10 bits
N2 = 7;
L2 = 2^N2;
xq_10bits = round((x_original + 1) * (L2/2)) / (L2/2) - 1;

% Cálculo del error de cuantización
error_5bits = x_original - xq_5bits;
error_10bits = x_original - xq_10bits;

% Gráfico del error de cuantización
figure;
plot(t, error_5bits, 'r--o', 'LineWidth', 1, 'MarkerSize', 4); hold on;
plot(t, error_10bits, 'b--s', 'LineWidth', 1, 'MarkerSize', 4);
yline(0, 'k-', 'LineWidth', 1); % Línea en y=0 para referencia
xlabel('Tiempo [s]');
ylabel('Error de Cuantización');
title('Error de Cuantización en PCM');
legend('Error con N=5 bits', 'Error con N=7 bits');
grid on;
