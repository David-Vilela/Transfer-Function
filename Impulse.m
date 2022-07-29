%%%Questão 1
x=[-9 -6 -4 -2 0 2 4];
y=[30.1 10.1 8.9 5.9 5 3.9 4.01];
p=polyfit(x,y,4);
f=polyval(p,x);
c=corr(y,f)
%c = 0.9975
%f =  30.0172   10.7283    7.7017    6.6310    5.1943    3.5084    4.1291
xi=-3;
yi6=30.0172*xi^6;
yi5=10.7283*xi^5;
yi4=7.7017*xi^4;
yi3=6.6310*xi^3;
yi2=5.1943*xi^2;
yi1=3.5084*xi;
yi0=4.1291;
yi=yi0+yi1+yi2+yi3+yi4+yi5+yi6
%yi = 1.9761e+04
%%%Questão 2
T=0.5;
k = 0:6;
u = ones(length(k),1);
y = [0.9141; 0.9890; 1.0273; 1.0153; 0.9962; 0.9928; 0.9985];
data=iddata(y,u,T);
na = 2;
nb = 1;
nk = 1;
m=arx(data, 'na',na,'nb',nb,'nk',nk)

%               0.9606 z^-2
%y1:  -----------------------------
%     1 - 0.4099 z^-1 + 0.3705 z^-2

Gz = tf ([0.906],[1 -0.4099 0.3705], 0.5)
%%%%b0=0.906; a1=-0.4099; a0=0.3705;
%%%Questão 3
y = [0.6000 -1.5400 1.3620 -1.1642 0.9933 -0.8474 0.7229 -0.6167 0.5261 -0.4489 0.3829 -0.3267 0.2787 -0.2378 0.2028 -0.1730 0.1476 -0.1259  0.1074];
T= 0.4;
M=4;
N=4;
for i=1:N
 for j=1:M
 H1(i,j)=y(i+j-1);
 end
end
[u,s,v]=svd(H1);
n=2;
u1=(u(:,1:n))';
v1=v(1:n,:);
s1=s(1:n,1:n);
for i=1:N
 for j=1:M
 H2(i,j)=y(i+j);
 end
end
Ob=(sqrt(s1)*u1)';
Ct=sqrt(s1)*v1;
A = pinv(Ob)*H2*pinv(Ct);
B = Ct(:,1);
C = Ob(1,:);
D = 0;
sis=ss(A,B,C,D,T);
t = (0:19)*T;
y_estimado=impulse(sis,t);
y=[0 y];
yt=y';
e = sqrt(mean((y_estimado - yt)).^2)
sisMF = feedback(sis,1);
impulse(sisMF,"r")
hold on
stairs(t, y_estimado, "b*")
[n, d] = ss2tf(A,B,C,D);
Gs = tf(n,d);
Gz = tf(n,d,T)
