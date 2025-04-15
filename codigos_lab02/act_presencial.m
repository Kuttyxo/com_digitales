% Parámetros
num_bits = 10^2; % Número de bits 
alpha_values = [0, 0.25, 0.5, 0.7]; % Valores de roll-off 
T = 1; % Período de símbolo normalizado
sps = 16; % Muestras por símbolo 
SNR_dB = 35; % Relación señal a ruido en dB 

% Generar bits aleatorios
bits = randi([0 1], num_bits, 1);

% Codificación NRZ-L
nrz = 2*bits - 1;


% Pulso Coseno Alzado
rolloff_filtering = @(alpha, T, t) (sinc(t/T) .* cos(pi*alpha*t/T)) ./ (1 - (2*alpha*t/T).^2 + eps);

% Bucle sobre los valores de roll-off
for i = 1:length(alpha_values)
    alpha = alpha_values(i);

    % Generar el pulso coseno alzado
    t = -10*T:1/sps:10*T;
    pulse = rolloff_filtering(alpha, T, t);

    % Upsample los bits para la transmisión
    upsampled_signal = upsample(nrz, sps);

    % Filtrar la señal con el pulso coseno alzado
    transmitted_signal = conv(upsampled_signal, pulse, 'same');

    % Agregar ruido AWGN
    noisy_signal = awgn(transmitted_signal, SNR_dB, 'measured');

    % Diagrama de Ojo
    figure;
    eyediagram(noisy_signal, 2*sps);
    title(['Diagrama de Ojo para \\alpha = ' num2str(alpha)]);
end

% Funciones Auxiliares
function y = sinc(x)
    y = ones(size(x));
    idx = (x ~= 0);
    y(idx) = sin(pi*x(idx)) ./ (pi*x(idx));
end
