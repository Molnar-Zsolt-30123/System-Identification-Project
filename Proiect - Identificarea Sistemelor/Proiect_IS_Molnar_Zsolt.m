t = Molnar(:,1);
u = Molnar(:,2);
y = Molnar(:,3);
%x = Molnar(:,4);
figure; plot(t,u,t,y);

i1=156; %u jos
i2=164; %u sus

i3=159; %y jos
i4=167; %y sus

k = mean(y)/mean(u);                    %factorul de proportionalitate
Mr = (y(i4)-y(i3))/((u(i2)-u(i1))/k);   %modulul de rezonanta

tita = sqrt((Mr-sqrt(Mr^2-1))/2/Mr);    %factorul de amortizare

Tr = 2*(t(i4)-t(i3));                   %Perioada de rezonanta 
wr = 2*pi/Tr;

wn = wr/sqrt(1-2*tita^2);               %Pulsația la rezonanțǎ

H=(tf(k*wn^2,[1 2*tita*wn wn^2]));      %Functia de transfer
%[num, den] = tfdata(H,'v');

%validarea datelor folosind spatiul starilor
A=[0,1;-wn^2,-2*tita*wn];
B=[0;k*wn^2];
C=[1,0];
D=0;
 
sys=ss(A,B,C,D);
ysim=lsim(sys,u,t,[y(1),(y(2)-y(1))/(Tr/2)]);
figure
plot(t,y,t,ysim)

J=norm(y-ysim)/sqrt(length(y));         %eroarea medie patratica
Empn=norm(y-ysim)/norm(y-mean(y));      %eroarea medie patratica normalizata
