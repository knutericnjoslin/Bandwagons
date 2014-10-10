function [p_go]=QRE_FarrellAndSaloner_FlexibleUtilitySpecification_flexibleB2Y(p_go_0, tau, B2Y, B1Y, a, b, c, d)

% Calculate number of steps

tol=1e-8;
ksteps=0;
maxsteps=100;
dist=1;
allpha=1/2;

p_go = p_go_0;
piexp_go=zeros(1,10);
piexp_stay=zeros(1,10);

% Core: find QRE

while (ksteps<maxsteps) && (dist>tol)

    % Need to go through the 10 types--although some of the types have
    % slightly different expected utility. 
    
    % Utilities are denoted by own first period action first, then other
    % agent first period action is second. So U( stay | go) denotes if 
    % agent 1 stays in the first period but agent 2 goes in the first period.
    % Since it is a truncated game, we assume, for instance, if agent 1 has
    % a type "i"> 3 then the agent will follow. 
    
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
    
    for i=1:1:3
    for j=1:1:10
       if j<=3         %   Here, if agent of type i chooses "go" the agent of type j will not follow. Similarly, if the type j agent goes then the type i agent will not follow 
       piexp_go(1,i) = piexp_go(1,i) + p_go(1,i)*(1/10)*(p_go(1,j)*B2Y_flexible(i,c,d) + (1-p_go(1,j))*B1Y(i,a,b));
       piexp_stay(1,i) = piexp_stay(1,i) + (1 - p_go(1,i))*(1/10)*((p_go(1,j)*5 + (1-p_go(1,j))*7));
       else             %   for (j > 3) Here the type j agent will follow
       piexp_go(1,i) = piexp_go(1,i) + p_go(1,i)*(1/10)*(p_go(1,j)*B2Y_flexible(i,c,d) + (1-p_go(1,j))*B2Y_flexible(i,c,d));
       piexp_stay(1,i) = piexp_stay(1,i) + (1 - p_go(1,i))*(1/10)*((p_go(1,j)*5 + (1-p_go(1,j))*7));
       end;
    end;
    end;
    for i=4:1:10
    for j=1:1:10
       if j<=3         %   Here, if agent of type i chooses "go" the agent of type j will not follow. Similarly, if the type j agent goes then the type i agent will not follow 
       piexp_go(1,i) = piexp_go(1,i) + p_go(1,i)*(1/10)*(p_go(1,j)*B2Y_flexible(i,c,d) + (1-p_go(1,j))*B1Y(i,a,b)) ; 
       piexp_stay(1,i) = piexp_stay(1,i) + (1 - p_go(1,i))*(1/10)*((p_go(1,j)*B2Y_flexible(i,c,d) + (1-p_go(1,j))*7));
       else             %   for (j > 3) Here the type j agent will follow
       piexp_go(1,i) = piexp_go(1,i) + p_go(1,i)*(1/10)*(p_go(1,j)*B2Y_flexible(i,c,d) + (1-p_go(1,j))*B2Y_flexible(i,c,d));
       piexp_stay(1,i) = piexp_stay(1,i) + (1 - p_go(1,i))*(1/10)*((p_go(1,j)*B2Y_flexible(i,c,d) + (1-p_go(1,j))*7));
       end;
    end;
    end;
    
    for i=1:1:10
        phat(1,i) = exp(tau*piexp_go(1,i))/(exp(tau*piexp_go(1,i)) + exp(tau*piexp_stay(1,i)));
    end;
        
    dist = max(abs(phat-p_go));

    p_go=allpha*p_go+(1-allpha)*phat;
    
    ksteps=ksteps+1;

end
