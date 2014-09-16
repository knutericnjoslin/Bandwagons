% Initialize vectors

tol=1e-5;
ksteps=0;
maxsteps=40;
dist=1;
allpha=1/2;
noise=20;

p_go_0=ones(1,20)/2;  
p2_error = [0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1]; % Second stage error rate
phat=zeros(1,20);
p_GO_1_grid=repmat(0.5, 200, 20);
p_GO_1_hat=p_GO_1_grid(noise, :);

a=0;
b=1;

while (ksteps<maxsteps) && (dist>tol)

for u=1:1:200;
    tau=u/10;
    [p_go]=QRE20_SecondStageErrors(p_go_0, tau, @B2Y_20, @B1Y_20, a, b, p2_error);
    p_GO_1_grid(u,:)=p_go;
end;

for u=1:1:200
    tau=u/10;
    [p_go]=QRE20_SecondStage_Match_Go(p_go_0, tau, @B2Y_20, @B1Y_20, a, b, p_GO_1_grid(noise+30,:));
    p_GO_2_grid(u,:)=p_go;
end

for u=1:1:200
    tau=u/10;
    [p_go]=QRE20_SecondStage_Match_Stay(p_go_0, tau, @B2Y_20, @B1Y_20, a, b, p_GO_1_grid(noise,:));
    p_STAY_2_grid(u,:)=p_go;
end

p_hat(1, 1:12) =  p_GO_2_grid(noise, 1:12);
p_hat(1, 13:20) = p_STAY_2_grid(noise, 13:20);

dist = max(abs(p_GO_1_hat - p_GO_1_grid(noise,:)));

p_GO_1_hat = p_GO_1_grid(noise,:);

p2_error=allpha*p2_error+(1-allpha)*phat;

ksteps=ksteps+1;

end;


plot(1:20, p_GO_1_grid(noise,:))