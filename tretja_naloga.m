podatki = table2array(readtable('Piscanci.csv','ReadVariableNames',false));
x = podatki(:,2);
Y = podatki(:,1);

X = [ones(size(x)),x];
beta = inv(X'*X)*X'*Y;


x1 = 0:22;
y0 = beta(1)*ones(1,size(x1,2)) + beta(2)*x1;
scatter(x,Y, "filled",'MarkerFaceColor','c')
hold on
plot(x1,y0)
xlabel('Dnevi')
ylabel('Teža v gramih')
hold off

% B NALOGA
p = 5;
q = 2;
n = 578;
pisc_pri_dieta1 = podatki(podatki(:,4)==1,:);
dieta1 = pisc_pri_dieta1(:,2);
pisc_pri_dieta2 = podatki(podatki(:,4)==2,:);
dieta2 = pisc_pri_dieta2(:,2);
pisc_pri_dieta3 = podatki(podatki(:,4)==3,:);
dieta3 = pisc_pri_dieta3(:,2);
pisc_pri_dieta4 = podatki(podatki(:,4)==4,:);
dieta4 = pisc_pri_dieta4(:,2);

%  blkdiag(dieta1,dieta2,dieta3,dieta4)  ustvari blocno diagonalno matriko
X2 = [ones(size(x,1),1),blkdiag(dieta1,dieta2,dieta3,dieta4)];

H = X2*inv(X2'*X2)*X2';
L = [1 0; 0 1; 0 1; 0 1; 0 1];
M = X2 * L;
K = M*inv(M'*M)*M';

A = (H-K)*Y;
B = (eye(n) - H)*Y;
F = norm(A)^2*(n-p)/((p-q)*norm(B)^2);

alpha1 = 0.05;
alpha2 = 0.01;
fish1 = finv(1-alpha1,p-q, n-p);
fish2 = finv(1-alpha2,p-q, n-p);

beta2 = inv(X2'*X2)*X2'*Y;

y1 = beta2(1)*ones(1,size(x1,2)) + beta2(2)*x1;
y2 = beta2(1)*ones(1,size(x1,2)) + beta2(3)*x1;
y3 = beta2(1)*ones(1,size(x1,2)) + beta2(4)*x1;
y4 = beta2(1)*ones(1,size(x1,2)) + beta2(5)*x1;
scatter(x,Y, "filled",'MarkerFaceColor','c','DisplayName','Podatki')
hold on
plot(x1,y1,'y','DisplayName','Dieta 1')
plot(x1,y2, 'r','DisplayName','Dieta 2')
plot(x1,y3, 'm','DisplayName','Dieta 3')
plot(x1,y4,'b','DisplayName','Dieta 4')
legend
xlabel('Dnevi')
ylabel('Teža v gramih')
hold off
