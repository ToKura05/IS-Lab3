clear;

% Sukurti spindulio tipo baziniu funkciju tinkla
% vienas iejimas

x = 0.1:1/22:1;

% isejimas

y = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))/2;

% turime neuronu tinkla su vienu iejimu. Du neuronai pasleptame sluoksnyje,
% kuriu spindulio funkcijos - Gauso funkcijos. Isejime - vienas neuronas,
% kurio aktyvavimo funkcija - tiesine.

% Skaiciuojami pirmo sluoksnio parametrai - rysiu svoriu koeficientu nera
% Antro sluosnio rysiu svoriu koeficientai

w11_2 = randn(1);
w12_2 = randn(1);
w0 = randn(1);

% Nubraizius tikra funkcija, parenkami Gauso funkciju parametrai - centrai
% bei spinduliai

fplot(@(x) (1 + 0.6*sin(2*pi*(x)/0.7) + 0.3*sin(2*pi*(x)))/2, [0.1 1], 'r');
hold on;
c1 = 0.2; c2 = 0.9;
r1 = 0.15; r2 = 0.15;

% Mokymo zingsnis
n = 0.1;

% Iteruojame per visus pavyzdzius
for i = 1:length(x)
    % Gauso f-jos
    fi_1 = exp(-((x(i)-c1)^2)/(2*r1^2));
    fi_2 = exp(-((x(i)-c2)^2)/(2*r2^2));
    
    % pasvertoji suma isejimo neuronui
    
    v1_2 = w11_2*fi_1+w12_2*fi_2 + w0;
    y1_2(i) = v1_2;
    
    e(i) = y(i) - y1_2(i);
    w11_2 = w11_2 + n*e(i)*fi_1;
    w12_2 = w12_2 + n*e(i)*fi_2;
    w0  = w0  + n*e(i);
end

e_sum = sumabs(e);

% Kartojame mokyma, kol klaidu suma taps pakankamai maza, pvz 300000 kartu
for iterations = 1: 300000
    for i = 1:length(x)
    % Gauso f-jos
    fi_1 = exp(-((x(i)-c1)^2)/(2*r1^2));
    fi_2 = exp(-((x(i)-c2)^2)/(2*r2^2));
    
    % pasvertoji suma isejimo neuronui
    
    v1_2 = w11_2*fi_1+w12_2*fi_2 + w0;
    y1_2(i) = v1_2;
    
    e(i) = y(i) - y1_2(i);
    w11_2 = w11_2 + n*e(i)*fi_1;
    w12_2 = w12_2 + n*e(i)*fi_2;
    w0  = w0  + n*e(i);
    end
end

% braizomas tinklo isejimas po apmokymo
plot(x,y1_2,'bO');
hold on;
legend("Tikslus sinusoides grafikas","SBF tinklo išėjimas");
