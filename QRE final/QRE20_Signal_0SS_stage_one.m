function [p_0SS_1G]=QRE20_Signal_0SS_stage_one(p_go_0, tau, B2Y, B1Y, a, b, p_0SS_1SG_2G, p_0SS_1SS_2G, p_0G)

% Description: 

% Initialize vectors

tol=1e-8;
ksteps=0;
maxsteps=100;
dist=1;
allpha=1/2;

p_0SS_1G = p_go_0;

% Core: find QRE

while (ksteps<maxsteps) && (dist>tol)

    piexp_0SS_1Go=zeros(1,20);
    piexp_0SS_1Stay=zeros(1,20);
    
    for k=1:1:20
     for j=1:1:20
       piexp_0SS_1Go(1,k) = piexp_0SS_1Go(1,k) +... 
                                        ( p_0G(j)/sum(p_0G) )*(...
                                                                p_0SS_1G(1,j)*B2Y(k) + (1 - p_0SS_1G(1,j))*     (...
                                                                                                                p_0SS_1SG_2G(j)*B2Y(k) + (1 - p_0SS_1SG_2G(j))*B1Y(k,a,b)...
                                                                                                                )...
                                                                );
       piexp_0SS_1Stay(1,k) = piexp_0SS_1Stay(1,k) +... 
                                        ( p_0G(j)/sum(p_0G) )*(...
                                                                p_0SS_1G(1,j)*      (...
                                                                                    p_0SS_1SG_2G(k)*B2Y(k) + (1 - p_0SS_1SG_2G(k))*5 ...
                                                                                    )...
                                                               +(1 - p_0SS_1G(1,j))*(...
                                                                                     p_0SS_1SS_2G(j)*         (...
                                                                                                                p_0SS_1SS_2G(k)*B2Y(k) + (1 - p_0SS_1SS_2G(k))*5 ...
                                                                                                                )...
                                                                                    + (1 - p_0SS_1SS_2G(j))*  (...
                                                                                                                p_0SS_1SS_2G(k)*B1Y(k,a,b) + (1 - p_0SS_1SS_2G(k))*7 ...
                                                                                                                )...
                                                                                    )...
                                                                );                          
     end;
    end;   
    
    for i=1:1:20
        phat(1,i) = exp(tau*piexp_0SS_1Go(1,i))/(exp(tau*piexp_0SS_1Go(1,i)) + exp(tau*piexp_0SS_1Stay(1,i)));
    end;
        
    dist = max(abs(phat-p_0SS_1G));

    p_0SS_1G=allpha*p_0SS_1G+(1-allpha)*phat;
    
    ksteps=ksteps+1;

end


