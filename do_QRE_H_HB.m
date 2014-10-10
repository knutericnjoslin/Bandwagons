% Does the QRE thing for treatments H and HB

ttype=2; % set to 0 for H, 2 for HB

% Initial guesses for algorithm (for now: always uniform and symmetric)

p0=ones(1,7)/7;
q0=p0;

% p0=[1/100 1/100 1/100 94/100 1/100 1/100 1/100];
% q0=[1/100 1/100 1/100 94/100 1/100 1/100 1/100];

pgrid=ones(100,7)/7;
qgrid=pgrid;

for u=1:1:100
    tau=u/100;
    [p,q]=QREMB(p0,q0,tau,ttype);
    pgrid(u,:)=p;
    qgrid(u,:)=q;
end

