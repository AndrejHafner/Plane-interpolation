function interpolation(V,len)
% interpolation(V,len) je funkcija, ki sprejme matriko V z z vrednostnimi neke funkcije
% in nato interpolira vrednosti znotraj posameznih enotskih kvadratov da dobimo zglajeno ravnino,
% ki se v točkah x/len ujema z točkami iz V
% V.. matrika ki predstavlja vrednosti neke funkcije
% len.. stevilo tock ki jih interpoliramo na enotskem kvadratu po x in y osi

% Definiramo izhodno matriko oz. matriko ki jo bomo uporabili za prikaz
izhod = zeros(size(V)(2)*len - 1 - len,size(V)(1)*len - 1 - len);

% Funkcija za pridobitev parcialnih odvodov po x in y na ne robnih delih matrike V
dfx = @(x,y) (x-y)/2;
dfy = @(x,y) (x-y)/2;

i_cnt = 1;
j_cnt = 1;

% Zanki, ki grest cez V in interpolirata vsak enotski kvadrat
for j = 1:size(V)(2) - 1

  j_cnt = 1;
  for i = 1:size(V)(1) - 1
        
    % a b c d
    data = [V(i,j),V(i+1,j),V(i,j+1),V(i+1,j+1)];
    
    dax = 0;
    dbx = 0;
    dcx = 0;
    ddx = 0;
    
    day = 0;
    dby = 0;
    dcy = 0;
    ddy = 0;
  
    % Izracunamo parcialne odvode - razlicno racunamo odvosni od tega ali so tocke v kotih ali na robovih matrike
    if(i == 1 && j == 1) 
        % Zgornji levi kot
        dax = V(i+1,j) - V(i,j);
        dbx = dfx(V(i,j),V(i+2,j));
        dcx = V(i+1,j+1) - V(i,j+1);
        ddx = dfx(V(i,j+1),V(i+2,j+1));
        
        day = V(i,j+1)-V(i,j);
        dby = V(i+1,j+1)-V(i+1,j);
        dcy = dfy(V(i,j),V(i,j+2));
        ddy = dfy(V(i+1,j),V(i+1,j+2));
    elseif((i == 1 && j == size(V)(2) - 1))
        % Spodnji levi kot    
        dax = V(i+1,j) - V(i,j);
        dbx = dfx(V(i,j),V(i+2,j));
        dcx = V(i+1,j+1) - V(i,j+1);
        ddx = dfx(V(i,j+1),V(i+2,j+1));
        
        day = dfy(V(i,j-1),V(i,j+1));
        dby = dfy(V(i+1,j-1),V(i+1,j+1));
        dcy = V(i,j+1)-V(i,j);
        ddy = V(i+1,j+1)-V(i+1,j);
    elseif((i == size(V)(1) - 1 && j == 1)) 
        % Sgornji desni kot    
        dax = dfx(V(i-1,j),V(i+1,j));
        dbx = V(i+1,j) - V(i,j);
        dcx = dfx(V(i-1,j+1),V(i+1,j+1));
        ddx = V(i+1,j+1)-V(i,j+1);
        
        day = V(i,j+1)-V(i,j);
        dby = V(i+1,j+1)-V(i+1,j);
        dcy = dfy(V(i,j),V(i,j+2));
        ddy = dfy(V(i+1,j),V(i+1,j+2));
    elseif((i == size(V)(1) - 1 && j == size(V)(2) - 1)) 
        % Spodnji desni kot    
        dax = dfx(V(i-1,j),V(i+1,j));
        dbx = V(i+1,j) - V(i,j);
        dcx = dfx(V(i-1,j+1),V(i+1,j+1));
        ddx = V(i+1,j+1)-V(i,j+1);
        
        day = dfy(V(i,j-1),V(i,j+1));
        dby = dfy(V(i+1,j-1),V(i+1,j+1));
        dcy = V(i,j+1)-V(i,j);
        ddy = V(i+1,j+1)-V(i+1,j);
    elseif(i == 1) 
        % X roben - levi rob
        dax = V(i+1,j)-V(i,j);
        dbx = dfx(V(i,j),V(i+2,j));
        dcx = V(i+1,j+1)-V(i,j+1);
        ddx = dfx(V(i,j+1),V(i+2,j+1));
        
        day = dfy(V(i,j-1),V(i,j+1));
        dby = dfy(V(i+1,j-1),V(i+1,j+1));
        dcy = dfy(V(i,j),V(i,j+2));
        ddy = dfy(V(i+1,j),V(i+1,j+2));  
    elseif(i == size(V)(1) - 1) 
        % X roben - desni rob
        dax = dfx(V(i-1,j),V(i+1,j));
        dbx = V(i+1,j)-V(i,j);
        dcx = dfx(V(i-1,j+1),V(i+1,j+1));
        ddx = V(i+1,j+1)-V(i,j+1);
        
        day = dfy(V(i,j-1),V(i,j+1));
        dby = dfy(V(i+1,j-1),V(i+1,j+1));
        dcy = dfy(V(i,j),V(i,j+2));
        ddy = dfy(V(i+1,j),V(i+1,j+2));;    
    elseif(j == 1) 
        %Y roben - zgornji rob
        dax = dfx(V(i-1,j),V(i+1,j));
        dbx = dfx(V(i,j),V(i+2,j));
        dcx = dfx(V(i-1,j+1),V(i+1,j+1));
        ddx = dfx(V(i,j+1),V(i+2,j+1));
        
        day = V(i,j+1)-V(i,j);
        dby = V(i+1,j+1)-V(i+1,j);
        dcy = dfy(V(i,j),V(i,j+2));
        ddy = dfy(V(i+1,j),V(i+1,j+2));
    elseif(j == size(V)(2) - 1) 
        %Y roben - spodnji rob
        dax = dfx(V(i-1,j),V(i+1,j));
        dbx = dfx(V(i,j),V(i+2,j));
        dcx = dfx(V(i-1,j+1),V(i+1,j+1));
        ddx = dfx(V(i,j+1),V(i+2,j+1));
        
        day = dfy(V(i,j-1),V(i,j+1));
        dby = dfy(V(i+1,j-1),V(i+1,j+1));
        dcy = V(i,j+1)-V(i,j);
        ddy = V(i+1,j+1)-V(i+1,j);
    else 
        % Ne robni primeri 
        dax = dfx(V(i-1,j),V(i+1,j));
        dbx = dfx(V(i,j),V(i+2,j));
        dcx = dfx(V(i-1,j+1),V(i+1,j+1));
        ddx = dfx(V(i,j+1),V(i+2,j+1));
        
        day = dfy(V(i,j-1),V(i,j+1));
        dby = dfy(V(i+1,j-1),V(i+1,j+1));
        dcy = dfy(V(i,j),V(i,j+2));
        ddy = dfy(V(i+1,j),V(i+1,j+2));
    endif
    
    % Pripravimo vektor za v interpolationFunction
    data = [data,dax,dbx,dcx,ddx,day,dby,dcy,ddy];
    
    % Izracunamo tocke za en enotski kvadrat
    unit_inter = interpolationFunction(data,len);
    
    % Dodamo vrednosti v izhodno matriko
    izhod(i_cnt:i_cnt+len-1,j_cnt:j_cnt+len-1) = unit_inter;
    
    % Sproti risemo na graf da ohranimo velikost
    figure(2);
    surf(linspace(0,1,len)+i,linspace(0,1,len)+j,unit_inter);
    title(["Interpolated plot of V for len=" num2str(len)],"fontsize",15);
    hold on
    
   
    j_cnt += len-1;
    
  endfor
  i_cnt += len-1;
  
endfor

% Prikazemo vrednosti
figure(1);
surf(V);
title("Plot of V","fontsize",15);

figure(2)
hold off
end

%!demo
%! z = [1,2,1;2,3,2;1,2,1];
%! interpolation(z,20);

