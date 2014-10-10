% Initialize vectors

tol=1e-5;
ksteps=0;
maxsteps=40;
dist=1;
allpha=1/2;
noise=15;

a=0;
b=1;

p_go_0 = 0.5*ones(1,20);
p0 = 0.5*ones(1,20);

% Initial guesses (close to predictions from model)

% p_0G = [0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1];
% p_0GG_1G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
% p_0GS_1G = [0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1]; 
% p_0SG_1G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1]; 
% p_0SS_1G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1]; 
% p_0GG_1SG_2G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
% p_0GG_1SS_2G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1]; 
% p_0GS_1SG_2G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
% p_0GS_1SS_2G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1];
% p_0SG_1SG_2G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
% p_0SG_1SS_2G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1];                          
% p_0SS_1SG_2G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
% p_0SS_1SS_2G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1];  

% p_0G = [0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1];
% p_0GG_1G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
% p_0GS_1G = [0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1]; 
% p_0SG_1G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1]; 
% p_0SS_1G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1]; 
% p_0GG_1SG_2G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
% p_0GG_1SS_2G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1]; 
% p_0GS_1SG_2G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
% p_0GS_1SS_2G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1];
% p_0SG_1SG_2G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
% p_0SG_1SS_2G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1];                          
% p_0SS_1SG_2G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
% p_0SS_1SS_2G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1];  

p_0G = [0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1];
p_0GG_1G = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
p_0GS_1G = [0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1]; 
p_0SG_1G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; 
p_0SS_1G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; 
p_0GG_1SG_2G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
p_0GG_1SS_2G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; 
p_0GS_1SG_2G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
p_0GS_1SS_2G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
p_0SG_1SG_2G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
p_0SG_1SS_2G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];                          
p_0SS_1SG_2G = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
p_0SS_1SS_2G = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];  



while (ksteps<maxsteps) && (dist>tol)

for u=1:1:200;
    tau=u/10;
    [p_0G] = QRE20_Signal_stage_zero(   p_go_0,...
                                        p_0GG_1G, p_0GS_1G, p_0SG_1G, p_0SS_1G,...
                                        p_0GG_1SG_2G, p_0GG_1SS_2G,...
                                        p_0GS_1SG_2G, p_0GS_1SS_2G,...
                                        p_0SG_1SG_2G, p_0SG_1SS_2G,...
                                        p_0SS_1SG_2G, p_0SS_1SS_2G,...
                                        tau, @B2Y_20, @B1Y_20, a, b);
    p_0G_grid(u,:)=p_0G;
end;
% p_0G = p_0G_grid(noise, :);

    
% ### p_0GG_1G
for u=1:1:200;
    tau=u/10;
    [p_0GG_1G]=QRE20_Signal_0GG_stage_one(p_go_0, tau, @B2Y_20, @B1Y_20, a, b, p_0GG_1SG_2G, p_0GG_1SS_2G, p_0G_grid(noise,:));
    p_0GG_1G_grid(u,:)=p_0GG_1G;
end;
% p_0GG_1G = p_0GG_1G_grid(noise, :);

% ### p_0GS_1G
for u=1:1:200;
    tau=u/10;
    [p_0GS_1G]=QRE20_Signal_0GS_stage_one(p_go_0, tau, @B2Y_20, @B1Y_20, a, b, p_0SG_1G, p_0GS_1SG_2G, p_0SG_1SG_2G, p_0SG_1SS_2G, p_0GS_1SS_2G, p_0G_grid(noise,:));
    p_0GS_1G_grid(u,:)=p_0GS_1G;
end;
% p_0GS_1G = p_0GS_1G_grid(noise, :);

% ### p_0SG_1G
for u=1:1:200;
    tau=u/10;
    [p_0SG_1G]=QRE20_Signal_0SG_stage_one(p_go_0, tau, @B2Y_20, @B1Y_20, a, b, p_0GS_1G, p_0GS_1SG_2G, p_0SG_1SG_2G, p_0SG_1SS_2G, p_0GS_1SS_2G, p_0G_grid(noise,:));
    p_0SG_1G_grid(u,:)=p_0SG_1G;
end;
% p_0SG_1G = p_0SG_1G_grid(noise, :);

% ### p_0SS_1G
for u=1:1:200;
    tau=u/10;
    [p_0SS_1G]=QRE20_Signal_0SS_stage_one(p_go_0, tau, @B2Y_20, @B1Y_20, a, b, p_0SS_1SG_2G, p_0SS_1SS_2G, p_0G_grid(noise,:));
    p_0SS_1G_grid(u,:)=p_0SS_1G;
end;
% p_0SS_1G = p_0SS_1G_grid(noise, :);




% p_0GG_1SG_2G, p_0GG_1SS_2G,...
% p_0GS_1SG_2G, p_0GS_1SS_2G,...
% p_0SG_1SG_2G, p_0SG_1SS_2G,...
% p_0SS_1SG_2G, p_0SS_1SS_2G,...


% ### p_0GG_1SG_2G
for u=1:1:200;
    tau=u/10;
    [p_go]=QRE20_Signal_0GG_1SG_stage_two(p0, tau, @B2Y_20);
    p_0GG_1SG_2G_grid(u,:)=p_go;
end;
% p_0GG_1SG_2G =  p_0GG_1SG_2G_grid(noise, :);

% ### p_0GG_1SS_2G
for u=1:1:200;
    tau=u/10;
    [p_0GG_1SS_2G]=QRE20_Signal_0GG_1SS_stage_two(p0, tau, @B2Y_20, @B1Y_20, a, b, p_0G_grid(noise,:), p_0GG_1G_grid(noise,:));
    p_0GG_1SS_2G_grid(u,:)=p_0GG_1SS_2G;
end;
% p_0GG_1SS_2G =  p_0GG_1SS_2G_grid(noise, :);

% ### p_0GS_1SG_2G,
for u=1:1:200;
    tau=u/10;
    [p_go]=QRE20_Signal_0GS_1SG_stage_two(p0, tau, @B2Y_20);
    p_0GS_1SG_2G_grid(u,:)=p_go;
end;
% p_0GS_1SG_2G =  p_0GS_1SG_2G_grid(noise, :);

% ### p_0GS_1SS_2G
for u=1:1:200;
    tau=u/10;
    [p_0GS_1SS_2G]=QRE20_Signal_0GS_1SS_stage_two(p0, tau, @B2Y_20, @B1Y_20, a, b, p_0G_grid(noise,:), p_0SG_1G_grid(noise,:));
    p_0GS_1SS_2G_grid(u,:)=p_0GS_1SS_2G;
end;
% p_0GS_1SS_2G =  p_0GS_1SS_2G_grid(noise, :);

 % ### p_0SG_1SG_2G
for u=1:1:200;
    tau=u/10;
    [p_go]=QRE20_Signal_0SG_1SG_stage_two(p0, tau, @B2Y_20);
    p_0SG_1SG_2G_grid(u,:)=p_go;
end;
% p_0SG_1SG_2G =  p_0SG_1SG_2G_grid(noise, :);

% ### p_0SG_1SS_2G
for u=1:1:200;
    tau=u/10;
    [p_0SG_1SS_2G]=QRE20_Signal_0SG_1SS_stage_two(p0, tau, @B2Y_20, @B1Y_20, a, b, p_0G_grid(noise,:), p_0GS_1G_grid(noise,:));
    p_0SG_1SS_2G_grid(u,:)=p_0SG_1SS_2G;
end;
% p_0SG_1SS_2G =  p_0SG_1SS_2G_grid(noise, :);
  
% ### p_0SS_1SG_2G
for u=1:1:200;
    tau=u/10;
    [p_go]=QRE20_Signal_0SS_1SG_stage_two(p0, tau, @B2Y_20);
    p_0SS_1SG_2G_grid(u,:)=p_go;
end;
% p_0SS_1SG_2G =  p_0SS_1SG_2G_grid(noise, :);

% ### p_0SS_1SS_2G
for u=1:1:200;
    tau=u/10;
    [p_0SG_1SS_2G]=QRE20_Signal_0SS_1SS_stage_two(p0, tau, @B2Y_20, @B1Y_20, a, b, p_0G_grid(noise,:), p_0SS_1G_grid(noise,:));
    p_0SS_1SS_2G_grid(u,:)=p_0SS_1SS_2G;
end;
% p_0SS_1SS_2G =  p_0SS_1SS_2G_grid(noise, :);
 





% MAKE THIS A VECTOR OF FIRST STAGE ACTIONS
dist = max(abs(p_0G - p_0G_grid(noise,:)));

p_0G = allpha*p_0G + (1 - allpha)*p_0G_grid(noise,:) ; 
p_0GG_1G = allpha*p_0GG_1G + (1 - allpha)*p_0GG_1G_grid(noise,:) ; 
p_0GS_1G = allpha*p_0GS_1G + (1 - allpha)*p_0GS_1G_grid(noise,:) ; 
p_0SG_1G = allpha*p_0SG_1G + (1 - allpha)*p_0SG_1G_grid(noise,:) ; 
p_0SS_1G = allpha*p_0SS_1G + (1 - allpha)*p_0SS_1G_grid(noise,:) ;
p_0GG_1SG_2G = allpha*p_0GG_1SG_2G + (1 - allpha)*p_0GG_1SG_2G_grid(noise,:) ; 
p_0GG_1SS_2G = allpha*p_0GG_1SS_2G + (1 - allpha)*p_0GG_1SS_2G_grid(noise,:) ;
p_0GS_1SG_2G = allpha*p_0GS_1SG_2G + (1 - allpha)*p_0GS_1SG_2G_grid(noise,:) ;
p_0GS_1SS_2G = allpha*p_0GS_1SS_2G + (1 - allpha)*p_0GS_1SS_2G_grid(noise,:) ;
p_0SG_1SG_2G = allpha*p_0SG_1SG_2G + (1 - allpha)*p_0SG_1SG_2G_grid(noise,:) ;
p_0SG_1SS_2G = allpha*p_0SG_1SS_2G + (1 - allpha)*p_0SG_1SS_2G_grid(noise,:) ;                           
p_0SS_1SG_2G = allpha*p_0SS_1SG_2G + (1 - allpha)*p_0SS_1SG_2G_grid(noise,:) ; 
p_0SS_1SS_2G = allpha*p_0SS_1SS_2G + (1 - allpha)*p_0SS_1SS_2G_grid(noise,:) ; 


ksteps=ksteps+1;


end;

plot(1:20, p_0G_grid(noise,:))