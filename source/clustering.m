function [ idx, centroids, score, wt, td ] = clustering( varargin )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

	ut = varargin{1};
	k = varargin{2};
	pc = varargin{3};
	
	% calc TF-IDF matrix based on TF matrix 
	tf = log(1+ut);
	%0.5+0.5*t.*repmat(max(t,[],2),1,size(t,2)) % other tf method
	idf = log(size(ut,1)./(1+sum(ut>0)));	
	tfidf = tf.*repmat(idf, size(ut,1),1);
	%dw = log(1+tfidf);
	%dw = dw./norm(dw);
	

	[coeff,score,latent,tsquared,explained,mu] = pca(tfidf,'NumComponents', pc);	
	[idx,centroids, sumd, td] = kmeans(score,k,'Distance','cosine');

	ori=centroids*coeff';
	
	[i,wt]=sort(ori,2, 'descend');
end

