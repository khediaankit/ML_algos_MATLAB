function [ U, V ] = myRecommender( rateMatrix, lowRank )
    % Please type your name here:
    format short e
    name = 'Khedia,Ankit';
    disp(name); % Do not delete this line.

    % Parameters
    maxIter = 1000; % Choose your own.
    learningRate =0.00009789; % 0.001001; % Choose your own.
  %  regularizer = 0.00001;%0.001; % Choose your own.
   % learningRate =0.0001; % 0.001001; % Choose your own.
     regularizer = 0.00001;%0.001;
    % Random initialization:
    [n1, n2] = size(rateMatrix);
    U = rand(n1, lowRank) / lowRank;
    V = rand(n2, lowRank) / lowRank;
    diff=10;
    i=1;
    %for i=1:maxIter
    while(diff>0.00001 && i<maxIter)
    U_old=U;
    V_old=V;
    M=U*V';
    M= rateMatrix-M;
    M=M.*(rateMatrix>0);
    V_mid=M'*U;
    U_mid=M*V;
    k=1-(2*regularizer*learningRate);
    V=k*V+2*learningRate*V_mid;
   % disp('V is');
    %disp(V);
    U=k*U+2*learningRate*U_mid;
    % Gradient Descent:
    i=i+1;
    diff=sum(sum((U-U_old).^2))+sum(sum((V-V_old).^2));
    end
    %disp(i);
    % IMPLEMENT YOUR CODE HERE.
end