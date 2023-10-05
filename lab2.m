clc;
clear ;
close all;
%%%%%%%%%%%%%%%%%%%%%%%C/A code with phase tap(3,8)%%%%%%%%%%%%%%%%%%%%%%%

% Register1
SR1 = [1 1 1 1 1 1 1 1 1 1]; % Initial fill of first shift register
SR1_code = zeros(1,1023); % Output code vector of SR1

for i = 1:1023
    %a5od xor been 3 w 8 w arg3ha lel element el  awlany w a5od el output
    %mn el element el 10 w a3ml circular shift
    new_bit = xor(SR1(3), SR1(10)); % XOR of 3rd and 8th memory elements
    SR1_code(i) = SR1(10); % Output of SR1 is the 10th memory element
    SR1 = circshift(SR1,1); % Shift the register
    SR1(1) = new_bit; % Update the first memory element
end

% Register2
SR2 = [1 1 1 1 1 1 1 1 1 1]; % Initial fill of second shift register
SR2_code = zeros(1,1023); % Output code vector of SR2

for i = 1:1023
    %nafs el klam bzbt bs output 7a5do mn xor el 3 wel 8 msh el 10
    SR2_code(i) = SR2(10); % Output of SR2 is the 10th memory element
    new_bit = xor(SR2(2), xor(SR2(3), xor(SR2(6), xor(SR2(8), xor(SR2(9), SR2(10)))))); % XOR of selected memory elements
    SR2 = circshift(SR2,1); % Shift the register
    SR2(1) = new_bit; % Update the first memory element
end

CA_code_1 = xor(SR1_code,SR2_code); % XOR between SR1 and SR2 to get C/A code 1

% Autocorrelation calculation
CA_code_1 = CA_code_1'; % Transpose the code
CA_code_1 = 2 * CA_code_1 - 1; % Change 1/0 to 1/-1

autocorrelation_1 = zeros(1,1023);

for shift = 0:1022
    shifted_code = circshift(CA_code_1,shift); % Shifted version of C/A code 1
    autocorrelation_1(shift+1) = CA_code_1' * shifted_code;
end

figure
stem(autocorrelation_1)
grid on
xlabel('Shifts');
xlim([0,1023]);
ylabel('Value of Correlations');
title('1023 Chip Gold Code (3,8) Autocorrelation')

%%%%%%%%%%%%%%C/A code with phase tap (2,6)%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Register1
SR1 = [1 1 1 1 1 1 1 1 1 1]; % Initial fill of first shift register
SR1_code = zeros(1,1023); % Output code vector of SR1

for i = 1:1023
    SR1_code(i) = SR1(10); % Output of SR1 is the 10th memory element
    new_bit = xor(SR1(2), SR1(6)); % XOR of 2nd and 6th memory elements
    SR1 = circshift(SR1,1); % Shift the register
    SR1(1) = new_bit; % Update the first memory element
end

% Register2
SR2 = [1 1 1 1 1 1 1 1 1 1]; % Initial fill of second shift register
SR2_code = zeros(1,1023); % Output code vector of SR2

for i = 1:1023
    SR2_code(i) = SR2(10); % Output of SR2 is the 10th memory element
    new_bit = xor(SR2(2), xor(SR2(3), xor(SR2(6), xor(SR2(8), xor(SR2(9), SR2(10)))))); % XOR of selected memory elements
    SR2 = circshift(SR2,1); % Shift the register
    SR2(1) = new_bit; % Update the first memory element
end

CA_code_2 = xor(SR1_code,SR2_code); % XOR between SR1 and SR2 to get C/A code 2


% Autocorrelation calculation
CA_code_2 = CA_code_2'; % Transpose the code
CA_code_2 = 2 * CA_code_2 - 1; % Change 1/0 to 1/-1

autocorrelation_2 = zeros(1,1023);

for shift = 0:1022
    shifted_code = circshift(CA_code_2,shift); % Shifted version of C/A code 2
    autocorrelation_2(shift+1) = CA_code_2' * shifted_code;
end

figure
stem(autocorrelation_2)
grid on
xlabel('Shifts');
xlim([0,1023]);
ylabel('Value of Correlations');
title('1023 Chip Gold Code (2,6) Autocorrelation')

%%%%%%%%%%%%Cross Correlation between first and second C/A codes %%%%%%%%%%

cross_correlation = zeros(1,1023);

for shift = 0:1022
    shifted_code_1 = circshift(CA_code_1,shift); % Shifted version of C/A code 1
    cross_correlation(shift+1) = CA_code_2' * shifted_code_1;
end

figure
stem(cross_correlation)
grid on
xlabel('Shifts');
xlim([0,1022]);
ylabel('Value of Correlations');
title('Gold Code (3,8) and Gold Code (2,6) Cross-Correlation')