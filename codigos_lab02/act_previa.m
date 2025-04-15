% Parámetros iniciales
f0 = 1; % Ancho de banda de 6 dB (elegimos 1 para normalizar)
alpha_values = [0, 0.25, 0.75, 1]; % Valores de roll-off a evaluar
t = -5:0.01:5; % Vector de tiempo
f = -2:0.001:2; % Vector de frecuencia (-2B a 2B)

% Preparamos las figuras
figure(1); clf; % Para respuesta al impulso (solo t >= 0)
figure(2); clf; % Para respuesta en frecuencia

for alpha = alpha_values
    % Calculamos parámetros según ecuaciones 11-13
    f_delta = alpha * f0;
    B = f0 + f_delta; % Ancho de banda absoluto (ecuación 11)
    f1 = f0 - f_delta; % (ecuación 12)
    
    % Respuesta en frecuencia (ecuación 10)
    He_f = zeros(size(f));
    for i = 1:length(f)
        if abs(f(i)) < f1
            He_f(i) = 1;
        elseif (abs(f(i)) >= f1) && (abs(f(i)) < B)
            He_f(i) = 0.5 * (1 + cos(pi*(abs(f(i)) - f1)/(2*f_delta)));
        else
            He_f(i) = 0;
        end
    end
    
    % Respuesta al impulso (ecuación 14)
    he_t = zeros(size(t));
    for i = 1:length(t)
        if t(i) == 0
            he_t(i) = 2*f0; % Límite cuando t->0
        else
            term1 = sin(2*pi*f0*t(i)) / (2*pi*f0*t(i));
            term2 = cos(2*pi*f_delta*t(i)) / (1 - (4*f_delta*t(i))^2);
            he_t(i) = 2*f0 * term1 * term2;
        end
    end
    
    % Graficamos respuesta al impulso (solo t >= 0)
    figure(1);
    plot(t(t>=0), he_t(t>=0), 'DisplayName', sprintf('α = %.2f', alpha));
    hold on;
    
    % Graficamos respuesta en frecuencia
    figure(2);
    plot(f, He_f, 'DisplayName', sprintf('α = %.2f', alpha));
    hold on;
end

% Ajustamos las gráficas de respuesta al impulso
figure(1);
title('Respuesta al impulso del filtro coseno alzado (t ≥ 0)');
xlabel('Tiempo (t)');
ylabel('h_e(t)');
legend('show');
grid on;

% Ajustamos las gráficas de respuesta en frecuencia
figure(2);
title('Respuesta en frecuencia del filtro coseno alzado');
xlabel('Frecuencia (f)');
ylabel('H_e(f)');
legend('show');
grid on;
xlim([-2 2]); % -2B a 2B