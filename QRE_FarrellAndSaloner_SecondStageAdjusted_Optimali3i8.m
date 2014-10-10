function [p_go]=QRE_FarrellAndSaloner_SecondStageAdjusted_Optimali3i8(p_go_0, tau, B2Y, B1Y, a, b)

% Initialize vectors

tol=1e-8;
ksteps=0;
maxsteps=100;
dist=1;
allpha=1/2;

p_go = p_go_0;

% Core: find QRE

while (ksteps<maxsteps) && (dist>tol)

    piexp_go=[0,0,0,0,0,0,1,1,1,1];
    piexp_stay=[1,1,1,1,1,1,0,0,0,0];
    
    % Need to go through the 10 types--although some of the types have
    % slightly different expected utility. 
    
    % Utilities for types i=0.5, 1.5, and 2,5
    % U_(i<3)(stay | stay) = 7
    % U_(i<3)(stay | go) = 5
    % U_(i<3)(go | stay) = i
    % U_(i<3)(go | go) = i + 2
    
    % Utilities for types i=3.5, 4.5, 5,5, 6.5, 7.5, 8.5, 9.5
    % U_(i>3)(stay | stay) = 7
    % U_(i>3)(stay | go) = i + 2
    % U_(i>3)(go | stay) = i
    % U_(i>3)(go | go) = i + 2
    
    %     p_go=ones(1,10)/2;   
    %     phat=zeros(1,10);
    %     piexp_go=zeros(1,10);
    %     piexp_stay=zeros(1,10);
    

    for i=4:1:7
     for j=1:1:10
       if (j<4)        %   Here, if agent of type i chooses "go" the agent of type j will not follow. Similarly, if the type j agent goes then the type i agent will not follow 
       piexp_go(1,i) = piexp_go(1,i) + (1/10)*B1Y(i,a,b) ; 
       piexp_stay(1,i) = piexp_stay(1,i) + (1/10)*7;
       elseif(j > 3) &&  (j < 8)   %   for (j > 3) Here the type j agent will follow
       piexp_go(1,i) = piexp_go(1,i) + (1/10)*(p_go(1,j)*B2Y(i) + (1-p_go(1,j))*B2Y(i));
       piexp_stay(1,i) = piexp_stay(1,i) + (1/10)*((p_go(1,j)*B2Y(i) + (1-p_go(1,j))*7));
       else
       piexp_go(1,i) = piexp_go(1,i) + (1/10)*(B2Y(i));
       piexp_stay(1,i) = piexp_stay(1,i) + (1/10)*(B2Y(i));    
       end;
     end;
    end;
   
    phat=[0,0,0,0,0,0,0,1,1,1];
    for i=4:1:7
        phat(1,i) = exp(tau*piexp_go(1,i))/(exp(tau*piexp_go(1,i)) + exp(tau*piexp_stay(1,i)));
    end;
        
    dist = max(abs(phat-p_go));

    p_go=allpha*p_go+(1-allpha)*phat;
    
    ksteps=ksteps+1;

end
