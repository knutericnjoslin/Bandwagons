p_go_0=ones(1,10)/2;   
phat=zeros(1,10);
pgrid=ones(200,10);

a=12/5;
b=3/5;

for u=1:1:200
    tau=u/10;
    [p_go]=QRE_FarrellAndSaloner_ExtraOutput(p_go_0, tau, @B2Y, @B1Y, a, b);
    pgrid(u,:)=p_go;
end

