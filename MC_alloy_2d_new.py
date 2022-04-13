import matplotlib.pyplot as plt
import numpy as np

 
def init_lattice(l):
    '''Create a lxl lattice with random spin configuration'''    
    lattice = (2*np.random.random_integers(0,1,size=(l,l))-1)    
    return lattice


def deltaE(i,j,i1,j1):
    '''Energy difference for a spin exchange of 2 neighbours'''
    # periodic  boundary condtions
    SD = lattice[(i - 1) % l, j] + lattice[(i + 1) % l, j] + \
          lattice[i, (j - 1) % l] + lattice[i, (j + 1) % l]
    SD1 = lattice[(i1 - 1) % l, j1] + lattice[(i1 + 1) % l, j1] + \
          lattice[i1, (j1 - 1) % l] + lattice[i1, (j1 + 1) % l]
    var=2*J*lattice[i,j]*(SD-SD1)+4*J
    return var

def move(i,j,i1,j1): # Montecarlo Move
    dE = deltaE(i, j, i1, j1)     
    if dE < 0:
        lattice[i, j] = -lattice[i, j]
        lattice[i1, j1] = -lattice[i1, j1]
        return 
    if np.random.random() < np.exp(-dE*beta):
        lattice[i, j] = -lattice[i, j]
        lattice[i1, j1] = -lattice[i1, j1]
        return 
    return 
 
global lattice,J,beta,l
J=1
l=100   # lenght of the lattice
n= l * l  # number of sites
K=1      # parameter for the MC
T =.22
beta=1./T  # K_B =1
# random initial conditions
lattice = init_lattice(l)

T=0.95
beta=1./T  # K_B =1
nit = 20 # number of iterations
print("temperature",T)
    
for t in range(0,nit):
        mc=0
        while mc < n*K: # K MC steps is n*K moves
            # the data are more independent
            i,j= np.random.randint(l), np.random.randint(l)
            inn=np.random.random_integers(0,1)
            iu = 2*np.random.random_integers(0,1)-1
            if inn != 0:
                i1,j1=i+iu,j                
            else:
                i1,j1=i,j+iu           
            i1,j1 =i1 %l,j1 %l
            if lattice[i, j]*lattice[i1, j1] <0 :
                move(i,j,i1,j1)
                mc+=1
              

plt.matshow(lattice)
plt.xlabel("i")
plt.ylabel("j")
plt.title("Binary Alloy 2d -- T = 0.95*J/KB  -- 20 MCs")
plt.xlim(0,l)
plt.ylim(0,l)
plt.savefig('Alloy2d.T095_N100.20MC.png')
plt.show()

