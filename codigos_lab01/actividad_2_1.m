clc; clear; close all;

% Parámetros
fs = 1000;   % Frecuencia de muestreo (Hz)
t = 0:1/fs:1; % Vector de tiempo (1s)
f = 5;       % Frecuencia de la señal (Hz)
m_t = sin(2*pi*f*t); % Señal original

% Muestreo instantáneo (PAM)
minst_t = m_t;  

% Configuración de PCM
N = 7; % Número de bits (puedes cambiarlo)
L = 2^N; % Niveles de cuantización
m_max = max(abs(m_t)); % Amplitud máxima
delta = 2*m_max / L; % Paso de cuantización

% Cuantización
m_q = round(m_t/delta) * delta;  

% Gráfica 
figure;
hold on;
plot(t, m_t, 'b-', 'LineWidth', 1.5); % Señal original
plot(t, minst_t, 'g--', 'LineWidth', 1.2); % Muestreo instantáneo
plot(t, m_q, 'ro', 'MarkerSize', 3, 'MarkerFaceColor', 'r'); % PCM cuantizada

xlim([0 0.1]); 
ylim([-1.1 1.1]);
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal original, muestreo instantáneo y señal cuantificada PCM');
legend('Señal original m(t)', 'Muestreo instantáneo minst(t)', 'PCM cuantizada (N=7 bits)');
grid on;
hold off;
