function [p_go]=QRE20_SecondStageErrors(p_go_0, tau, B2Y, B1Y, a, b, p2_match_go, p2_match_stay)

% Description: 

% Initialize vectors

tol=1e-8;
ksteps=0;
maxsteps=100;
dist=1;
allpha=1/2;

p_go = p_go_0;

% Core: find QRE

while (ksteps<maxsteps) && (dist>tol)

    piexp_go=zeros(1,20);
    piexp_stay=zeros(1,20);
    
    for i=1:1:6
     for j=1:1:20
       if (j <= 6)         %   Here, if agent of type i chooses "go" the agent of type j will not follow. Similarly, if the type j agent goes then the type i agent will not follow 
       piexp_go(1,i) = piexp_go(1,i) + (1/20)*( p_go(1,j)*B2Y(i) + (1 - p_go(1,j) )*( p2_match_go(j)*B2Y(i) + (1-p2_match_go(j))*B1Y(i,a,b) ) );
       piexp_stay(1,i) = piexp_stay(1,i) + (1/20)*( p_go(1,j)*( p2_match_go(i)*B2Y(i) + (1 - p2_match_go(i))*5 ) + (1 - p_go(1,j))*( p2_match_stay(i)*( p2_match_stay(j)*B2Y(i) + (1-p2_match_stay(j))*B1Y(i,a,b) ) + (1 - p2_match_stay(i))*( p2_match_stay(j)*5 + (1-p2_match_stay(j))*7 ) ) );                       
       else                %   for (j > 3) Here the type j agent will follow
       piexp_go(1,i) = piexp_go(1,i) + (1/20)*( p_go(1,j)*B2Y(i) + (1 - p_go(1,j) )*( p2_match_go(j)*B2Y(i) + (1-p2_match_go(j))*B1Y(i,a,b) ) );
       piexp_stay(1,i) = piexp_stay(1,i) + (1/20)*( p_go(1,j)*( p2_match_go(i)*B2Y(i) + (1 - p2_match_go(i))*5 ) + (1 - p_go(1,j))*( p2_match_stay(i)*( p2_match_stay(j)*B2Y(i) + (1-p2_match_stay(j))*B1Y(i,a,b) ) + (1 - p2_match_stay(i))*( p2_match_stay(j)*5 + (1-p2_match_stay(j))*7 ) ) );    
       end;
     end;
    end;
    for i=7:1:20
     for j=1:1:20
       if (j <= 6)        %   Here, if agent of type i chooses "go" the agent of type j will not follow. Similarly, if the type j agent goes then the type i agent will not follow 
       piexp_go(1,i) = piexp_go(1,i) + (1/20)*( p_go(1,j)*B2Y(i) + (1 - p_go(1,j) )*( p2_match_go(j)*B2Y(i) + (1-p2_match_go(j))*B1Y(i,a,b) ) );
       piexp_stay(1,i) = piexp_stay(1,i) + (1/20)*( p_go(1,j)*( p2_match_go(i)*B2Y(i) + (1 - p2_match_go(i))*5 ) + (1 - p_go(1,j))*( p2_match_stay(i)*( p2_match_stay(j)*B2Y(i) + (1-p2_match_stay(j))*B1Y(i,a,b) ) + (1 - p2_match_stay(i))*( p2_match_stay(j)*5 + (1-p2_match_stay(j))*7 ) ) );    
       else   %   for (j > 3) Here the type j agent will follow
       piexp_go(1,i) = piexp_go(1,i) + (1/20)*( p_go(1,j)*B2Y(i) + (1 - p_go(1,j) )*( p2_match_go(j)*B2Y(i) + (1-p2_match_go(j))*B1Y(i,a,b) ) );
       piexp_stay(1,i) = piexp_stay(1,i) + (1/20)*( p_go(1,j)*( p2_match_go(i)*B2Y(i) + (1 - p2_match_go(i))*5 ) + (1 - p_go(1,j))*( p2_match_stay(i)*( p2_match_stay(j)*B2Y(i) + (1-p2_match_stay(j))*B1Y(i,a,b) ) + (1 - p2_match_stay(i))*( p2_match_stay(j)*5 + (1-p2_match_stay(j))*7 ) ) );    
       end;
     end;
     end;
   
    
    for i=1:1:20
        phat(1,i) = exp(tau*piexp_go(1,i))/(exp(tau*piexp_go(1,i)) + exp(tau*piexp_stay(1,i)));
    end;
        
    dist = max(abs(phat-p_go));

    p_go=allpha*p_go+(1-allpha)*phat;
    
    ksteps=ksteps+1;

end
