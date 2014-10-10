function [p_go]=QRE20_Signal_0GG_1SG_stage_two(p0, tau, B2Y)

% Description: 


% Initialize vectors

tol=1e-8;
ksteps=0;
maxsteps=100;
dist=1;
allpha=1/2;

p_go = p0;

% Core: find QRE

while (ksteps<maxsteps) && (dist>tol)

    piexp_0GG_1SG_2Go=zeros(1,20);
    piexp_0GG_1SG_2Stay=zeros(1,20);
    
    for k=1:1:20; 
       for j=1:1:20; 
       piexp_0GG_1SG_2Go(1,k) = piexp_0GG_1SG_2Go(1,k) + B2Y(k) ;
       piexp_0GG_1SG_2Stay(1,k) = piexp_0GG_1SG_2Stay(1,k) + 5 ;
       end;
    end;
    
    for i=1:1:20
        phat(1,i) = exp(tau*piexp_0GG_1SG_2Go(1,i))/(exp(tau*piexp_0GG_1SG_2Go(1,i)) + exp(tau*piexp_0GG_1SG_2Stay(1,i)));
    end;
        
    dist = max(abs(phat-p_go));

    p_go=allpha*p_go+(1-allpha)*phat;
    
    ksteps=ksteps+1;

end
