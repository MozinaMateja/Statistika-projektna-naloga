skoki = 1:12;
frekvence = [48,31,20,9,6,5,4,2,1,1,2,1];
n = sum(frekvence);
stevilo_skokov = skoki * frekvence';

p = n/stevilo_skokov;  %cenilka za p
geom = @(x) p*(1-p).^(x-1); %funkcija za geometrijsko porazdelitev
lwtua = geom(skoki)*n;

plot(skoki, frekvence,'b-o','DisplayName','Frekvence')
hold on
plot(skoki, lwtua, 'm-o','DisplayName','Geometrijska porazdelitev')
legend
xlabel('Število skokov')
ylabel('Frekvenca')
hold off

norm(frekvence- lwtua, 'inf'); %največje odstopanje

p_nep = (n-1)/(skoki*frekvence' -1);