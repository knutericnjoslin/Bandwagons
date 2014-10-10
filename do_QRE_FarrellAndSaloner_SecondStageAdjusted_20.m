p_go_0=ones(1,20)/2;   
phat=zeros(1,20);
pgrid=ones(200,20);

a=0;
b=1;

for u=1:1:200
    tau=u/10;
    [p_go]=QRE_FarrellAndSaloner_SecondStageAdjusted_20(p_go_0, tau, @B2Y_20, @B1Y_20, a, b);
    pgrid(u,:)=p_go;
end

