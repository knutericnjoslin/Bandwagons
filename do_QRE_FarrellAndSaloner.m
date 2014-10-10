p_go_0=ones(1,10)/2;   
phat=zeros(1,10);
pgrid=ones(1000,10);

a=-2;
b=4/3;
c= 2;
d=1;

for u=1:1:1000
    tau=u/1000;
    [p_go]=QRE_FarrellAndSaloner_FlexibleUtilitySpecification_flexibleB2Y(p_go_0, tau, @B2Y_flexible, @B1Y, a, b, c, d);
    pgrid(u,:)=p_go;
end

