% Initialize vectors

tol=1e-5;
ksteps=0;
maxsteps=40;
dist=1;
allpha=1/2;
noise=15;

p_go_0=ones(1,20)/2;  
% Initially no errors in the second stage
p2_match_go = [0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
p2_match_stay = [0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1];

p_GO_1=ones(1,20)/2;

a=0;
b=1;

while (ksteps<maxsteps) && (dist>tol)

for u=1:1:200;
    tau=u/10;
    [p_go]=QRE20_SecondStageErrors(p_go_0, tau, @B2Y_20, @B1Y_20, a, b, p2_match_go, p2_match_stay);
    p_GO_1_grid(u,:)=p_go;
end;

for u=1:1:200
    tau=u/10;
    [p_go]=QRE20_SecondStage_Match_Go(p_go_0, tau, @B2Y_20, p_GO_1_grid(noise,:));
    p_GO_2_grid(u,:)=p_go;
end

for u=1:1:200
    tau=u/10;
    [p_go]=QRE20_SecondStage_Match_Stay(p_go_0, tau, @B2Y_20, @B1Y_20, a, b, p_GO_1_grid(noise,:));
    p_STAY_2_grid(u,:)=p_go;
end


p2_match_go = p_GO_2_grid(noise, :);
p2_match_stay = p_STAY_2_grid(noise, :);

dist = max(abs(p_GO_1 - p_GO_1_grid(noise,:)));

p_GO_1 = allpha*p_GO_1 + (1 - allpha)*p_GO_1_grid(noise,:) ;

ksteps=ksteps+1;

end;


plot(1:20, p_GO_1_grid(noise,:))