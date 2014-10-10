% Does the cognitive hierarchy thing for Bernard, Reuben and Riedl (2011)
% specify initial low (p0) and high (q0) type distributions as well as tau
% also indicate treatment type (1=HE, 2=HB)
% Number of k-steps is determined automatically with error tolerance 1e-4

% for now: provide initial guess (p0,q0) - to be automatized later
% set ttype to 0 for H, 1 for HE, 2 for HB

function [p,q]=QREMB(p0,q0,tau,ttype)

m=1+1*logical(ttype==2); % to generate higher marginal benefit
% n=7+6*logical(ttype==1); % to extend high type choice set

% Calculate number of steps

tol=1e-8;
ksteps=0;
maxsteps=100;
dist=1;
allpha=1/2;

% Initialize basic vectors and matrices

pos=1:1:7;
choice=5*(pos-1);

ODDCHOICE=kron(choice,ones(7,7));
%ODDCHOICE=[choice(1)*ones(7,7) choice(2)*ones(7,7) choice(3)*ones(7,7) choice(4)*ones(7,7) choice(5)*ones(7,7) choice(6)*ones(7,7) choice(7)*ones(7,7)];
OTHERSSUM=repmat(5*((repmat(pos-1,7,1))'+repmat(pos-1,7,1)),1,7)+ODDCHOICE;

p=p0;
q=q0;

% Core: find QRE

while (ksteps<maxsteps) && (dist>tol)
    
    LL=repmat(p'*p,1,7);
    HH=repmat(q'*q,1,7);

    H=kron(q,ones(7,7));
    L=kron(p,ones(7,7));

    LLH=LL.*H;
    HHL=HH.*L;

    piexpH=zeros(1,7);
    piexpL=zeros(1,7);

        % This loop considers the payoff from contributing some amount (0, 1,
    % ..., 6). This first term gives the expected value associated with a  
    % choice i when the public good threshold isn't reached. Correspondingly,
    % the second term gives the expected value associated with choice i
    % when the public goods threshold is reached. The expected value is
    % simply the probability of a particular outcome by the payoff
    % associated with the outcome. 
    
    for i=1:1:7
        piexpH(1,i)=sum(sum(logical(OTHERSSUM<(60-choice(i))).*LLH))*(-choice(i))+(1-sum(sum(logical(OTHERSSUM<(60-choice(i))).*LLH)))*(30*m-choice(i));
        piexpL(1,i)=sum(sum(logical(OTHERSSUM<(60-choice(i))).*HHL))*(-choice(i))+(1-sum(sum(logical(OTHERSSUM<(60-choice(i))).*HHL)))*(30-choice(i));
    end

    phat = exp(tau*piexpL)/sum(exp(tau*piexpL));
    qhat = exp(tau*piexpH)/sum(exp(tau*piexpH));

    dist = max(abs([phat-p qhat-q]));

    p=allpha*p+(1-allpha)*phat;
    q=allpha*q+(1-allpha)*qhat;
    
    ksteps=ksteps+1;

end


