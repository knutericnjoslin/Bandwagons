function [p_go]=QRE20_SecondStage_Match_Stay(p0, tau, B2Y, B1Y, a, b, p_go_1)

% Description: 


% Initialize vectors

tol=1e-8;
ksteps=0;
maxsteps=100;
dist=1;
allpha=1/2;

p_go = p0;

% The QRE estimation

while (ksteps<maxsteps) && (dist>tol)

    piexp_go=zeros(1,20);
    piexp_stay=zeros(1,20);
    
%     for i=1:1:20
%      for j=1:1:20
%        piexp_go(1,i) = piexp_go(1,i) + ((1 - p_go_1(j))/sum(1 - p_go_1(j))) * ( p_go(1,j)*B2Y(i) + (1-p_go(1,j))*B1Y(i,a,b) );
%        piexp_stay(1,i) = piexp_stay(1,i) + ((1 - p_go_1(j)))/sum(1 - p_go_1(j)) * ( p_go(1,j)*5 + (1-p_go(1,j))*7 );
%      end;
%     end;
   
    for i=1:1:20
     for j=1:1:20
       piexp_go(1,i) = piexp_go(1,i) + ((1 - p_go_1(j))/sum(1 - p_go_1)) * ( p_go(1,j)*B2Y(i) + (1-p_go(1,j))*B1Y(i,a,b) );
       piexp_stay(1,i) = piexp_stay(1,i) + ((1 - p_go_1(j)))/sum(1 - p_go_1) * ( p_go(1,j)*5 + (1-p_go(1,j))*7 );
     end;
    end;
    
    for i=1:1:20
        phat(1,i) = exp(tau*piexp_go(1,i))/(exp(tau*piexp_go(1,i)) + exp(tau*piexp_stay(1,i)));
    end;
        
    dist = max(abs(phat-p_go));

    p_go=allpha*p_go+(1-allpha)*phat;
    
    ksteps=ksteps+1;

end
