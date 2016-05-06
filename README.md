# Diffusion_VarA_SinTest
%1st attempt at varying A with time following a sine template.

clc; clear; 

% Arbitrary coefficient
A = 1;
D = 500; 

% Arbitrary time
t = 0.001;

% Define arbitrary plane
mat = zeros(300,300);
[row,col] = size(mat); 
distmat = zeros(size(mat));

% Define sinks and sources
mat(row/2,col/2) = 2; 
mat(row/2-15, col/2+15) = 1;
mat(row/2+110,col/2+20) = 1;

% explicitly states indices of sinks and sources
[srRow, srCol] = find(mat == 2);
[snRow, snCol] = find (mat == 1);

for ii = 1:row
    for jj = 1:col
        srcDistMat(ii,jj) = sqrt((ii-srRow)^2 + (jj-srCol)^2);
        snkDistMat(ii,jj) = sqrt((ii-snRow(1))^2 + (jj-snCol(1))^2);
    end
end

while t < 500
srcY = A*(sin(1.5*t+5))^2/(sqrt(4*pi*D*t))*exp(-srcDistMat.^2/(4*D*t));
snkY = -A*(sin(1.5*t-4))^2/(sqrt(4*pi*D*t))*exp(-snkDistMat.^2/(4*D*t));

Ymat = srcY+snkY;
clims=[-0.001,0.001];

figure(1) 
imagesc(Ymat,clims)

F = getframe(figure(1));
t = t+0.1;
end

