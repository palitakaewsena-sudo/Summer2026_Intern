%% 20 GHz 1-Bit Reconfigurable Reflectarray Coding Pattern Generator
% Author: Graduate Electromagnetic & Metasurface Researcher
% Description: This script generates 1-bit coding patterns (e.g., 01100110,
%              01001011, 00110011) for an 8x8 reconfigurable reflectarray 
%              operating at 20 GHz (K-band). It implements complex-plane 
%              vector-distance phase quantization to map continuous phase designs
%              to the discrete states of PIN-diode-integrated unit cells.
%              Additionally, it calculates and visualizes the far-field 
%              scattering patterns (Array Factor) using discrete Fourier 
%              transforms and analytical summation.

clc;
clear;
close all;

%% 1. System and Material Parameters
f = 20e9;                   % Operating Frequency: 20 GHz (K-band)
c = 2.99792458e8;           % Speed of light in vacuum (m/s)
lambda = c / f;             % Free-space wavelength (m) (~15 mm)
p = 7.5e-3;                 % Cell period (m) (7.5 mm = 0.5 * lambda)
k = 2 * pi / lambda;        % Free-space wave number (rad/m)

% Substrate Properties (Rogers RO4003C)
epsilon_r = 3.55;           % Relative permittivity
tan_delta = 0.0027;         % Loss tangent
h_substrate = 1.524e-3;     % Substrate thickness (e.g., 60 mil / 1.524 mm)

% Copper Conductivity
sigma_cu = 5.8e7;           % Conductivity of copper (S/m)

fprintf('--- Metasurface & Substrate Parameters ---\n');
fprintf('Operating Frequency: %.2f GHz\n', f / 1e9);
fprintf('Wavelength: %.2f mm\n', lambda * 1e3);
fprintf('Cell Period: %.2f mm (%.2f*lambda)\n', p * 1e3, p / lambda);
fprintf('Substrate: Rogers RO4003C (er = %.2f, tanD = %.4f)\n\n', epsilon_r, tan_delta);

%% 2. 1-Bit Phase States (MLP7140-11 PIN Diode @ 20 GHz)
% Normal Incidence Measured/Simulated Reflection Phases
phi_OFF_deg = -68.43;       % State 0 (PIN Diode OFF)
phi_ON_deg = 113.57;        % State 1 (PIN Diode ON)
phase_diff_deg = abs(phi_ON_deg - phi_OFF_deg);

fprintf('--- 1-Bit Phase States (MLP7140-11) ---\n');
fprintf('State 0 (OFF): %.2f deg\n', phi_OFF_deg);
fprintf('State 1 (ON) : %.2f deg\n', phi_ON_deg);
fprintf('Phase Difference: %.2f deg (Ideal: 180.00 deg)\n\n', phase_diff_deg);

% Convert phases to radians
phi_OFF = deg2rad(phi_OFF_deg);
phi_ON = deg2rad(phi_ON_deg);

%% 3. Defining Coding Configurations (8x8 Array)
M = 8;                      % Number of elements along X-axis
N = 8;                      % Number of elements along Y-axis

% Example 1D coding sequences requested by user
seq1 = [0, 1, 1, 0, 0, 1, 1, 0];  % 01100110
seq2 = [0, 1, 0, 0, 1, 0, 1, 1];  % 01001011
seq3 = [0, 0, 1, 1, 0, 0, 1, 1];  % 00110011

% Let's select one sequence to construct the 8x8 coding matrix
% We can construct a 1D gradient metasurface or a 2D chessboard metasurface
selected_seq = seq1; % Default: 01100110 for beam-splitting/steering demonstration

% Construct 8x8 Coding Matrix (1D Gradient along X, uniform along Y)
coding_matrix = repmat(selected_seq', 1, N);

fprintf('--- 8x8 Coding Matrix (Pattern: 01100110) ---\n');
disp(coding_matrix);

%% 4. Complex-Plane Vector-Distance Phase Quantization
% Suppose we have an ideal continuous phase profile required for a specific
% beam steering direction (theta_s, phi_s).
theta_s = deg2rad(25);      % Desired steering elevation angle: 25 degrees
phi_s = deg2rad(0);         % Desired steering azimuthal angle: 0 degrees

continuous_phase = zeros(M, N);
for m = 1:M
    for n = 1:N
        % Position of each element relative to array center
        x_pos = (m - (M + 1)/2) * p;
        y_pos = (n - (N + 1)/2) * p;
        
        % Generalized Snell's Law phase compensation formula
        continuous_phase(m, n) = -k * (x_pos * sin(theta_s) * cos(phi_s) + y_pos * sin(theta_s) * sin(phi_s));
    end
end

% Perform Complex-Plane Vector-Distance Quantization
% We minimize the Euclidean distance: |exp(j*phi_req) - exp(j*phi_actual)|
quantized_bits = zeros(M, N);
quantized_phase = zeros(M, N);

v_OFF = exp(1i * phi_OFF);  % Phasor for OFF state (0)
v_ON = exp(1i * phi_ON);    % Phasor for ON state (1)

for m = 1:M
    for n = 1:N
        v_req = exp(1i * continuous_phase(m, n));
        
        % Calculate Euclidean distances in complex plane
        d_OFF = abs(v_req - v_OFF);
        d_ON = abs(v_req - v_ON);
        
        if d_OFF < d_ON
            quantized_bits(m, n) = 0;
            quantized_phase(m, n) = phi_OFF;
        else
            quantized_bits(m, n) = 1;
            quantized_phase(m, n) = phi_ON;
        end
    end
end

fprintf('--- Beam Steering Continuous Phase (deg) ---\n');
disp(round(rad2deg(continuous_phase)));
fprintf('--- Quantized 1-Bit Coding Bits for 25-deg Steering ---\n');
disp(quantized_bits);

%% 5. Far-Field Scattering Pattern Calculation (Array Factor)
% Angular range for far-field calculation
theta_range = deg2rad(-90:1:90);
phi_range = deg2rad(0); % Co-polarization plane (x-z plane)

% Initialize Array Factor (AF)
AF = zeros(length(theta_range), 1);

for t_idx = 1:length(theta_range)
    th = theta_range(t_idx);
    sum_val = 0;
    for m = 1:M
        for n = 1:N
            x_pos = (m - (M + 1)/2) * p;
            y_pos = (n - (N + 1)/2) * p;
            
            % Phasor summing for specific coding pattern (using 01100110 or quantized_bits)
            % Let's plot for the 01100110 pattern coding matrix
            bit = coding_matrix(m, n);
            if bit == 0
                phase_val = phi_OFF;
            else
                phase_val = phi_ON;
            end
            
            % Spatial phase factor + unit cell reflection phase
            sum_val = sum_val + exp(1i * phase_val) * exp(1i * k * (x_pos * sin(th) * cos(phi_range) + y_pos * sin(th) * sin(phi_range)));
        end
    end
    AF(t_idx) = sum_val;
end

% Normalize Array Factor
AF_db = 20 * log10(abs(AF) / max(abs(AF)));

%% 6. Visualization
figure('Color', [1 1 1]);

% Plot 1: 1-Bit Phasors in Complex Plane
subplot(1, 2, 1);
plot(cos(phi_OFF), sin(phi_OFF), 'ro', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'State 0 (OFF)');
hold on;
plot(cos(phi_ON), sin(phi_ON), 'bs', 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', 'State 1 (ON)');
th_circle = 0:0.01:2*pi;
plot(cos(th_circle), sin(th_circle), 'k--', 'LineWidth', 1, 'DisplayName', 'Unit Circle');
grid on;
axis equal;
xlabel('Real [exp(j\phi)]');
ylabel('Imag [exp(j\phi)]');
title('1-Bit Complex Phasor States');
legend('Location', 'best');
xlim([-1.2 1.2]);
ylim([-1.2 1.2]);

% Plot 2: 2D Far-Field Scattering Pattern for 01100110
subplot(1, 2, 2);
plot(rad2deg(theta_range), AF_db, 'LineWidth', 2, 'Color', [0 0.4470 0.7410]);
grid on;
xlabel('Observation Angle \theta (deg)');
ylabel('Normalized Scattering Power (dB)');
title('Far-Field Scattering Pattern for 01100110');
ylim([-35 0]);
xlim([-90 90]);

sgtitle('20 GHz Reconfigurable Reflectarray Analysis (1-Bit Phase Control)');

% Print confirmation
fprintf('Coding pattern analysis completed. Plots generated successfully.\n');
