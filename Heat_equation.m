//La fonction f
f = @(x,y) x-y;

//resolve léquation : u_t = epsilon u_xx en 2D avec 3 conditions au bords
//epsilon est une constante

T=4;
dx = 0.05;
dt = dx.^2/2;

x1=0:dx:1;
y1=0:dx:1;
t=0:dt:T;

epsilon=0.05;
x1=x1;
y1=y1;

N=length(x1);


//implemente la valeur initiale

u=zeros(N);

for i=1:N
    for j=1:N
    u(i,j)=f(x1(i,1),y1(j,1));
    end
end

U=[];
for j=1:N
U=[U,u(j,:)];
end
U0=U;



//Conditions aux bords de Dirichlet

e = ones(N,1);
L1 = spdiags([e -4*e e], -1:1, N, N);%Matrice L1 de taille N,N tridiagonale
    
I=eye(N);


A1=[];
for i=1:N
A1=blkdiag(A1,L1); //Matrice diagonale par blocs
end

for i=1:N^2-N
     A1(i,N+i)=1;
     A1(N+i,i)=1;
end


//Conditions aux bords periodiques

P=zeros(N);
P(1,N)=1;
P(N,1)=1;
    
L3=L1+P; //On rend la matrice utilis� precedement p�riodique

A3=[];
for i=1:N
A3=blkdiag(A3,L3);
end

for i=1:N^2-N
     A3(i,N+i)=1;
     A3(N+i,i)=1;
end

for i=1:N
    A3(i,N^2-N+i)=1;
    A3(N^2-N+i,i)=1;
end




Chaleur=epsilon*dt/(dx^2); //equation de la chaleur




INN=eye(N^2);
    
// lambda=0.5 correspond a la methode de crank-nicolson

lambda=0.5;
n=1;

 B3=sparse((INN-Chaleur.*lambda.*A3)\(INN+(1-lambda).*Chaleur.*A3));
n0=size(U0);
U=zeros(n0(1),4);
for i=1:4
    T=i;
    t=i-1;
    while (t<T) 
    U1=B3*U0; 
    
    U0=U1;  
    t=t+dt;
    end   
    U(:,i)=U0;
end


n1=size(x1);
n2=size(y1);

for i=1:n1(1)
    for j=1:n2(1)
     
        x2(i,j)=x1(i);
        y2(i,j)=y1(j);
        u1(i,j)=U(N*(i-1)+j,1);
        u2(i,j)=U(N*(i-1)+j,2);
        u3(i,j)=U(N*(i-1)+j,3);
        u4(i,j)=U(N*(i-1)+j,4);
    end
end

// Solution graphique
subplot(2,2,1)
surf(x1,y1,u1);
title('t=0')

subplot(2,2,2)
surf(x1,y1,u2);
title('t=1')

subplot(2,2,3)
surf(x1,y1,u3);
title('t=2')

subplot(2,2,4)
surf(x1,y1,u4);
title('t=3')
