function Z = interpolationFunction(data, len)
% Z = interpolationFunction(data, len) vrne matriko Z velikosti len x len
% ki vsebuje interpolirane vrednosti za enotski kvadrat podan v data
% data... tocke a,b,c,d enotskega kvadrata in njihovi parcialni odvodi po x in y
% len... stevilo tock ki jih interpoliramo znotraj enotskega kvadrata po x in y osi
  
% Pridobimo podatke iz data
a = data(1);
b = data(2);
c = data(3);
d = data(4);
 
ay = data(9);
by = data(10);
cy = data(11);
dy = data(12);
 
ax = data(5);
bx = data(6);
cx = data(7);
dx = data(8);

% Polinom, ki ustreza pogojem: p(0) = 1 , p'(0) = 0 , p(1) = 0 , p'(1) = 0 
pol = @(x) 2*x^3 - 3*x^2 + 1;  

% Definiramo delne funkcije (partition of unity)  
fA = @(x, y) a + ax * x + ay * y;
fB = @(x, y) b + bx * (x - 1) + by * y;
fC = @(x, y) c + cx * x + cy*(y - 1);
fD = @(x, y) d + dx * (x - 1) + dy * (y - 1);

% Definiramo utezi za posamezno tocko (vecji vpliv tocke, blizje ko smo te tocki)  
wA = @(x, y) pol(x) * pol(y);
wB = @(x, y) (1 - pol(x)) * pol(y);
wC = @(x, y) pol(x) * (1 - pol(y));
wD = @(x, y) (1 - pol(x)) * (1-pol(y));

% Definiramo funkcijo s katero bomo interpolirali  
f = @(x, y) fA(x, y) * wA(x, y) + fB(x, y) * wB(x, y) + fC(x, y) * wC(x, y) + fD(x, y) * wD(x, y);
 
x = 0;
y = 0;

% Korak s katerem povecujemo x in y 
step = 1/(len-1);

% Interpolacija
for i = 1 : len

  x = 0;   
  for j = 1 : len 
  
    Z(i, j) = f(x, y);      
    x += step;
    
  end   
  y += step;   
  
end
endfunction

%!demo
%! mat = [1,2,2,1,1,1,-1,-1,1,-1,1,-1];
%! z = interpolationFunction(mat,10)
%! figure(1)
%! surf([1,2;2,1]);
%! figure(2);
%! surf(z);
      
    
  
  