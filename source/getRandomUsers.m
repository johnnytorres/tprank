function [ indexes, follower, friend ] = getRandomUsers( type )

	global profiles links tweets distances
    [rRelation,cRelation] = find(links==1);
	uRelations = unique(rRelation);
	
% 	f = profiles(uRelations,3);
% 		q = quantile(f,0.1);
% 		i = find(f<q);
% 		i = i(randi(size(i,1)));
% 		friend = uRelations(i);
% 		follower = cRelation(find(rRelation==friend));
% 
% 		follower_links = links(:, follower);
% 		subset = find(follower_links==0);
	
	%q1 = quantile(profiles(rRelation,3),0.1);
	%friend = profiles(rRelation,3)
	%[val, i] = min(profiles(uRelations,3));
	%friend = uRelations(i);
	%follower = cRelation(find(rRelation==friend));

    %follower_links = links(:, follower);
    %subset = find(follower_links==0);
    %subset = profiles(:,1);
	
    
    if type <= 6
		
		index = 3;	% get twitterers based on number of followers
		
		if type >3
			index = 2;  % get twitterers based on number of tweets
		end
			
		f = profiles(uRelations,index);
		% find 10 percentil of relationships
		q = quantile(f,0.1); 
		i = find(f<q);
		
		if type == 2 || type == 5
			% find interquartil relationships
			q1 = quantile(f,0.25);
			q3 = quantile(f,0.75);
			i = find(f>q1 & f<q3);
		end
		if type == 3 || type == 6
			% find 90 percentil of relationships
			q = quantile(f,0.9);
			i = find(f>q);
		end 	
		
		i = i(randi(size(i,1)));
		friend = uRelations(i);
		follower = cRelation(find(rRelation==friend));
		% get all users based in prior percentil
		f = profiles(:,index);
        
		i = find(f<q);
		
		if type == 2 || type == 5
			i = find(f>q1 & f<q3);
		end
		if type == 3 || type == 6
			i = find(f>q);
		end 
		
		% filter only non friends
		follower_links = links(:, follower);
		subset = find(follower_links==0);
		% intersect twitterers in quantile and non friends
        indexes = intersect(i, subset);
        return ;
    end
    
   	% distances
	if type > 6 && type < 10
		
		d = distances(links==1);
		q = quantile(d,0.1);
		[r,c]= find(links==1 & distances >0 & distances< q);	
		
		if type == 8
			% find interquartil relationships
			q1 = quantile(d,0.25);
			q3 = quantile(d,0.75);
			[r,c]= find(links==1 & distances >q1 & distances< q3);	
		end
		if type == 9
			% find 90 percentil of relationships
			q = quantile(d,0.9);
			[r,c]= find(links==1 & distances > q);	
		end 
		
		
		i = randi(size(r,1));
		friend = r(i);
		follower = c(i);
		
		d = distances(:,follower);
		
		if type == 9
			q = quantile(d, 0.1);
			i = find(d<q);
		end
		
		
		if type == 8
			q1 = quantile(d,0.25);
			q3 = quantile(d,0.75);
			i = find(d>q1 & d<q3);
		end
		if type == 7
			q = quantile(d,0.9);
			i = find(d>q);
		end 
		
		%q1 = quantile(d,0.1);
		%q3 = quantile(d,0.9);
		%i = find(d>q1 & d<q3);


		% filter only non friends
		follower_links = links(:, follower);
		subset = find(follower_links==0);
		% intersect twitterers in quantile and non friends
        indexes = intersect(i, subset);
        return ;
	end
	
% 		% follower with most friends
% %  	if type==10 || type == 11
% %  		follower = find(sum(links)==max(sum(links)));
% %  		friends = find(links(:,follower)==1);
% %  		numRelations = size(friends,1);
% %  		uIndex = randi(numRelations);
% %  		friend = friends(uIndex);
% %  	end

        
	
	i = randi(size(rRelation,1));
	friend = rRelation(i);
	follower = cRelation(i);
	
	% find 10 percentil based on most followers
	f = profiles(:,3);
	q = quantile(f,0.9); 
	i = find(f>q);
		
	indexes = i;
	
end

