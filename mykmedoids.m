function [ class, centroid ] = mykmedoids( pixels, K )
if(K > size(pixels,1))
    K = size(pixels,1);
end
if(K > size(unique(pixels,'rows'),1))
    K = size(unique(pixels,'rows'),1);
end 
%
% Your goal of this assignment is implementing your own K-medoids.
% Please refer to the instructions carefully, and we encourage you to
% consult with other resources about this algorithm on the web.
%
% Input:
%     pixels: data set. Each row contains one data point. For image
%     dataset, it contains 3 columns, each column corresponding to Red,
%     Green, and Blue component.
%
%     K: the number of desired clusters. Too high value of K may result in
%     empty cluster error. Then, you need to reduce it.
%
% Output:
%     class: the class assignment of each data point in pixels. The
%     assignment should be 1, 2, 3, etc. For K = 5, for example, each cell
%     of class should be either 1, 2, 3, 4, or 5. The output should be a
%     column vector with size(pixels, 1) elements.
%
%     centroid: the location of K centroids in your result. With images,
%     each centroid corresponds to the representative color of each
%     cluster. The output should be a matrix with size(pixels, 1) rows and
%     3 columns. The range of values should be [0, 255].
%     
%
% You may run the following line, then you can see what should be done.
% For submission, you need to code your own implementation without using
% the kmeans matlab function directly. That is, you need to comment it out.

centroid = datasample(unique(pixels,'rows'),K,'Replace',false);
IDX = knnsearch(centroid,pixels,'distance','cityblock');
class=IDX';

disscore=zeros(K,1);
for i=1:K
    idxlist=find(class==i);
       diffs = bsxfun(@minus, pixels(idxlist',:), centroid(i,:));
       distance = sum(sum(abs(diffs), 2));
       disscore(i)=distance;
      for kc=1:100
    %  if(size(idxlist)>1)
%       disp(i);
%       disp(size(idxlist));
%       disp(centroid(i,:));
      rnd= datasample(idxlist,1);
      rand_pix=pixels(rnd,:);
     % else
     %  rand_pix = centroid(i,:);
     % end
      diffs = bsxfun(@minus, pixels(idxlist',:), rand_pix);
       distance = sum(sum(abs(diffs), 2));
  %    disp(distance);
      if (distance<disscore(i))
           centroid(i,:)=rand_pix;
           disscore(i)=distance;
      end
      end
    end
   % disp('part 1 median done');
%    [minval minidx]=min(score) 
%    centroid1(i,:)=pixels(idxlist(minidx));
%end
%disp('part 1 median done');
      %  fprintf(fileID,'the centroid tot val  %d %d %d an size %d\n',centroid1(i,:),totals );
       % disp(centroid1(i,:));
 
  %disp(centroid1);
count=0;
while(count<=50)
 %   centroid=centroid1;
  %  disp('here again');
    IDX = knnsearch(centroid,pixels,'distance','cityblock');
    %disp(IDX);
    class=IDX';
% for i=1:size(pixels,1)
%   
%        diffs = bsxfun(@minus, pixels(i,:), centroid);
%        dist = sum(abs(diffs), 2);
%        [val ind]= min(dist);
%        class(i)= ind;
% end

%calculating median
for i=1:K
    idxlist=find(class==i);
    for k1=1:100
     %if(size(idxlist)>1)
      rnd= datasample(idxlist,1);
      rand_pix=pixels(rnd,:);
      %else
       %rand_pix = centroid(i,:);
      %end
      diffs = bsxfun(@minus, pixels(idxlist',:), rand_pix);
       distance = sum(sum(abs(diffs), 2));
   % disp(distance);
      if (distance<disscore(i))
           centroid(i,:)=rand_pix;
           disscore(i)=distance;
      end
    end
    end

      %  fprintf(fileID,'the centroid tot val  %d %d %d an size %d\n',centroid1(i,:),totals );
       % disp(centroid1(i,:));
       count=count+1;
end 
 % disp(centroid);
%centroid=centroid1;



%disp(class);
%disp pixels;
%[class, centroid] = [0,0]
%
% Your goal of this assignment is implementing your own K-means.
%
% Input:
%     pixels: data set. Each row contains one data point. For image
%     dataset, it contains 3 columns, each column corresponding to Red,
%     Green, and Blue component.
%
%     K: the number of desired clusters. Too high value of K may result in
%     empty cluster error. Then, you need to reduce it.
%
% Output:
%     class: the class assignment of each data point in pixels. The
%     assignment should be 1, 2, 3, etc. For K = 5, for example, each cell
%     of class should be either 1, 2, 3, 4, or 5. The output should be a
%     column vector with size(pixels, 1) elements.
%
%     centroid: the location of K centroids in your result. With images,
%     each centroid corresponds to the representative color of each
%     cluster. The output should be a matrix with size(pixels, 1) rows and
%     3 columns. The range of values should be [0, 255].
%     
%
% You may run the following line, then you can see what should be done.
% For submission, you need to code your own implementation without using
% the kmeans matlab function directly. That is, you need to comment it out.

 % [class, centroid] = kmeans(pixels, K);
 %fclose(fileID);

	%[class, centroid] = kmeans(pixels, K);
    class=class'
end