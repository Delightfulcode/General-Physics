! cube   afficher les cond init

implicit none
integer t, tmax, i, j, p, n, k, L, r ! k=1,2,3 = x,y,z
parameter (tmax=500, p=5, n=p**3)
real(8) ri (0:2,1:3,1:n) ! vecteur ri(t)
real(8) vi (1:3,1:n) ! nb aléa pour vitesses aléa
real(8) rij(1:3,1:n,1:n)	!Distance molécules
real(8) Fij(1:3,1:n,1:n)	!Force d'intéraction
real(8) Fi(1:3,1:n) !pour vitesse alé v(k,i)=composante vitesse alea
real (8) h1, v0
real(8) tfin, h2 !h2=h*h
real(8) rij2(1:n,1:n) 
parameter (tfin = 100.0, h2 = (tfin/tmax)**2)
 
parameter (L=1.09*p)  ! 1,09 < 2¹/⁶ Epot initiale
parameter (v0=0.12) ! Energie cinétique initiale

!initialisation
 forall (k=1:3,i=1:n) ri(0,k,i)=modulo((i-1)/p**(k-1),p)*(L/p)! la ligne continue
do i=1,n
	write(6+i,*) real(ri(0,:,i))
end do  

call random_number (vi) ! vi=3n, nbr aléa E [0,1[ comme p*1.0/m
forall (k=1:3) vi(k,:)=vi(k,:)-sum(vi(k,:)/n) ! soustraction de la vitesse centre de masse
ri(1,:,:)=ri(0,:,:)+v0*sqrt(h2)*vi  !cubique simple
Fij=0

!evolution
do t=1, tmax
forall (i=1:n,j=1:n, i<j) 
rij (:,i,j) = ri(1,:,i)-ri(1,:,j) !vecteur qui va de j à i
rij2 (i,j) = sum(rij(:,i,j)**2)
Fij(:,i,j) = h2*rij(:,i,j)*(2*rij2(i,j)**(-7)-rij2(i,j)**(-4))
Fij(:,j,i)=-Fij(:,i,j) !3ème loi de Newton
end forall 

forall(k=1:3, i=1:n) Fi(k,i)=sum(Fij(k,i,:))
ri(2,:,:)=2*ri(1,:,:)-ri(0,:,:)+h2*Fi(:,:)
ri(0,:,:)=ri(1,:,:)
ri(1,:,:)=ri(2,:,:)


do i=1,n
	write(6+i,*) real(ri(1,:,i))
end do  
enddo
end


!xi = mod(i-1, p)
!yi = mod((i-1)/p, p)
!zi = mod((i-1)/p², p)
!Fij(:,i,j) = h2 * rij(:,i,j) * (2*rij(i,j)**(-7) - rij²(i,j)**(-4))

!xi = mod(i-1, p)
!yi = mod((i-1)/p, p)
!zi = mod((i-1)/p², p)
