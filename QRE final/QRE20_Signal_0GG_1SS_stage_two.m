function [p_0GG_1SS_2G]=QRE20_Signal_0GG_1SS_stage_two(p0, tau, B2Y, B1Y, a, b, p_0G, p_0GG_1G)

% Description: 


% Initialize vectors

tol=1e-8;
ksteps=0;
maxsteps=100;
dist=1;
allpha=1/2;

p_0GG_1SS_2G = p0;

% Core: find QRE

while (ksteps<maxsteps) && (dist>tol)

    piexp_0GG_1SS_2Go=zeros(1,20);
    piexp_0GG_1SS_2Stay=zeros(1,20);
    
    for k=1:1:20; 
       for j=1:1:20; 
       piexp_0GG_1SS_2Go(1,k) = piexp_0GG_1SS_2Go(1,k) + ( ((1-p_0GG_1G(j))*(p_0G(j)/sum(p_0G)))/sum( (1-p_0GG_1G).*((p_0G)/sum(p_0G))) )*( p_0GG_1SS_2G(1,j)*B2Y(k) + (1-p_0GG_1SS_2G(1,j))*B1Y(k,a,b)) ;
       piexp_0GG_1SS_2Stay(1,k) = piexp_0GG_1SS_2Stay(1,k) + ( ((1-p_0GG_1G(j))*((p_0G(j))/sum(p_0G)))/sum((1-p_0GG_1G).*((p_0G)/sum(p_0G))) )*( p_0GG_1SS_2G(1,j)*5 + (1-p_0GG_1SS_2G(1,j))*7) ;
       end;
    end;
    
    for i=1:1:20
        phat(1,i) = exp(tau*piexp_0GG_1SS_2Go(1,i))/(exp(tau*piexp_0GG_1SS_2Go(1,i)) + exp(tau*piexp_0GG_1SS_2Stay(1,i)));
    end;
        
    dist = max(abs(phat-p_0GG_1SS_2G));

    p_0GG_1SS_2G=allpha*p_0GG_1SS_2G+(1-allpha)*phat;
    
    ksteps=ksteps+1;

end
