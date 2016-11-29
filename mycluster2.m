function [pw,pd,p ] = mycluster2( bow, K )
%
% Your goal of this assignment is implementing your own text clustering algo.
%
% Input:
%     bow: data set. Bag of words representation of text document as
%     described in the assignment.
%
%     K: the number of desired topics/clusters. 
%
% Output:
%     class: the assignment of each topic. The
%     assignment should be 1, 2, 3, etc. 
%
% For submission, you need to code your own implementation without using
% any existing libraries

% YOUR IMPLEMENTATION SHOULD START HERE!
%centroid = datasample(unique(bow,'rows'),K,'Replace',false);
%disp(bow);
%disp(centroid);
format short e
bow=full(bow);
%size(bow)
nw=size(bow,2);
doc_s=size(bow,1);

pz=rand(1,K);
pz= pz*(1/sum(pz(:)));
pw_cond_z=rand(nw,K);
%pw_cond_z=diag(1./sum(pw_cond_z,2))*pw_cond_z;
pw_cond_z=pw_cond_z*diag(1./sum(pw_cond_z,1));
pd_cond_z=rand(doc_s,K);
%pd_cond_z=diag(1./sum(pd_cond_z,2))*pd_cond_z;
pd_cond_z=pd_cond_z*diag(1./sum(pd_cond_z,1));
pz_cond_dw(K,nw,doc_s)=0;

for j=1:20
 for i=1:K
    %%%%%%%%%
  %  temp=
    pz_cond_dw(i,:,:)=(pw_cond_z(:,i)*(pd_cond_z(:,i))')*pz(i);
 end
    sum_n= sum(pz_cond_dw,1);
    pz_cond_dw = bsxfun(@rdivide,pz_cond_dw, sum_n);

    %reclac
 for i=1:K
    %%%%%%%%%
   % size(bow')
   % size(squeeze(pz_cond_dw(i,:,:)))
    int_score= bow'.*squeeze(pz_cond_dw(i,:,:));
    %disp(int_score);
    sum_k= sum(int_score(:));
   % disp(sum_k);
   % disp(sum(int_score,2));
    pw_cond_z(:,i)=sum(int_score,2)/sum_k;
  %  pw_cond_z(:,i)=pw_cond_z(:,i)/sum(pw_cond_z(:,i));
    pd_cond_z(:,i)=(sum(int_score,1)/sum_k)';
 %   pd_cond_z(:,i)=pd_cond_z(:,i)/sum(pd_cond_z(:,i));
    pz(i)=sum_k;
 end   
    pz=pz/sum(pz(:));
   % pw_cond_z=diag(1./sum(pw_cond_z,2))*pw_cond_z;
    % pd_cond_z=diag(1./sum(pd_cond_z,2))*pd_cond_z;
    %%%%%%%


 
end
 p=pz;
    pw=pw_cond_z;
   % pw=pw_cond_z*diag(1./sum(pw_cond_z,1));
    pd=pd_cond_z;
%disp(p);
%disp(pw);
%disp(sum(pw,1));
%disp(pd);
fl=load('nips.mat');
fileID = fopen('result.txt','w');
show_topics(pw,fl.wl,fileID);
fclose(fileID);
end

