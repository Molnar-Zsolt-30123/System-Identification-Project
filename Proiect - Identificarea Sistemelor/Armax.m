%Metoda 2
t = Molnar(:,1);
u = Molnar(:,2);
y = Molnar(:,3);
figure; plot(t,u,t,y); shg


i5 = 53;   %inceputul u
i6 = 709;  %sfarsitul u
i7 = 56;   %inceputul y
i8 = 728;  %sfarsitul y

Te = t(2)-t(1);     %timpul esantioanelor
data_id=iddata(y(i5:i6),u(i5:i6),Te);
data_vd=iddata(y(i7:i8),u(i7:i8),Te);


%% identificare cu ARMAX
m_armax = armax(data_id,[2,2,2,1]); %nA,nB,nC,nk

%gradul de suprapunere
figure; compare(data_vd,m_armax); shg

% validarea statistica
figure; resid(data_vd,m_armax)

H_armax = tf(m_armax.B,m_armax.A,Te,'variable','z^-1');
%% identificare cu OE
m_oe_wu = oe(data_id,[2 2 1]);

%gradul de suprapunere
figure; resid(data_vd,m_oe_wu)

% validarea statistica
figure; compare(data_vd,m_oe_wu)
 
H_oe = c2d(H,Te,'zoh');