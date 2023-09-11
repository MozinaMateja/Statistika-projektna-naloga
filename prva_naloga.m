podatki = table2array(readtable('Kibergrad.csv','ReadVariableNames',false));

stevilo_otrok = podatki(:,3);
cetrt = podatki(:,5);

format long

% Za izpis vrednosti pobrisi ;

N = 43886; % stevilo vseh druzin
n = 400; % vzorec
slucajna_stevila = randi([1, size(stevilo_otrok,1)], 1,n); % nakljucni vzorec
nakljucni_otroci = podatki(slucajna_stevila,3);
M = mean(nakljucni_otroci); %povprecno stevilo otrok
M_vektor = M*ones(400,1); % stolpec dolzine 400

SE = sqrt((N-n)*sum((nakljucni_otroci - M_vektor).^2)/((n-1)*N*n)); %standardna napaka

alpha = 0.05; %stopnja tveganja
levo_desno = tinv(1-alpha/2,n-1)*SE; %inverz studenta
levo = M - levo_desno; %leva stran intervala
desno = M + levo_desno; %desna stran intervala

%%%%%%%%B NALOGA%%%%%%%%%%%%
n_1 = 400/(1 + (10390/10149) +(13457/10149) +(9890/10149)); %vzorci
n_2 = round(10390*n_1/10149);
n_3 = round(13457*n_1/10149);
n_4 = round(9890*n_1/10149);
n_1 = floor(n_1);
vektorn = [n_1, n_2, n_3,n_4];

sever1 = podatki(podatki(:,5)==1,:);
sever = sever1(:,3); %podatki o stevilu otrok na severnem delu
vzhod1 = podatki(podatki(:,5)==2,:);
vzhod = vzhod1(:,3); %podatki o stevilu otrok na vzhodnem delu
jug1 = podatki(podatki(:,5)==3,:);
jug = jug1(:,3); %podatki o stevilu otrok na južnem delu
zahod1 = podatki(podatki(:,5)==4,:);
zahod = zahod1(:,3); %podatki o stevilu otrok na zahodnem delu
vektorN = [size(sever,1), size(vzhod,1), size(jug,1), size(zahod,1)]; %vektor N_i

%  velikostni deleži
W1 = vektorN(1)/N; 
W2 = vektorN(2)/N;
W3 = vektorN(3)/N;
W4 = vektorN(4)/N;
W = [W1, W2, W3, W4]; %vektor velikostnih deležev

severne_stevilke = randi([1, size(sever,1)], 1,n_1);
sv1 = sever(severne_stevilke); %nakljucno izbrani predstavniki severnega dela
vzhodne_stevilke = randi([1, size(vzhod,1)], 1,n_2);
sv2 = vzhod(vzhodne_stevilke);
juzne_stevilke = randi([1, size(jug,1)], 1,n_3);
sv3 = jug(juzne_stevilke);
zahodne_stevilke = randi([1, size(zahod,1)], 1,n_4);
sv4 = zahod(zahodne_stevilke);

%  povprecno stevilo otrok v vsakem delu
povprecje_severa = mean(sv1) ;
povprecje_vzhoda = mean(sv2);
povprecje_juga = mean(sv3);
povprecje_zahoda = mean(sv4);
Xpovp = [povprecje_severa;povprecje_vzhoda;povprecje_juga;povprecje_zahoda]; %vektor povprecij
povprecje_vsega = W * Xpovp; %povprecno stevilo otrok v celotnem mestu

Mean_vec_s = povprecje_severa*ones(n_1,1); 
Mean_vec_v = povprecje_vzhoda*ones(n_2,1);
Mean_vec_j = povprecje_juga*ones(n_3,1);
Mean_vec_z = povprecje_zahoda*ones(n_4,1);

%  variance
var_s = (sum((sv1 - Mean_vec_s).^2))/(n_1 -1);
var_v = (sum((sv2 - Mean_vec_v).^2))/(n_2 -1);
var_j = (sum((sv3 - Mean_vec_j).^2))/(n_3 -1);
var_z = (sum((sv4 - Mean_vec_z).^2))/(n_4 -1);
variance = [var_s, var_v, var_j, var_z];

vsota = 0;
for i =1:4
    vsota = vsota + (variance(i)*(W(i).^2))/(vektorn(i));
end
SEdva = sqrt(vsota);   %cenilka za standardno napako

vsota2 = 0;
for i =1:4
    vsota2 = vsota2 + ((variance(i).^2)*(W(i)).^4)/((vektorn(i).^2)*(vektorn(i) - 1));
end
ni = SEdva^4/vsota2; % za studenta

levo_desno2 = tinv(1-alpha/2,ni)*SEdva; % dolzina polovicnega intervala
levo2 = povprecje_vsega - levo_desno2;
desno2 = povprecje_vsega + levo_desno2;

