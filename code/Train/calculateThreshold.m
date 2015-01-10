
% performs worst-case analysis for each of m1,...,m5
% Xmin corresponds to the modulation data to be treated as min
%  for the worst-case analysis.
% Xmax is similar except the modulation to be treated as max
% p is the column of the data which corresponds to one of m1,...,m5
%  eg. p=2 => m1 since the first column corresponds to SNR
% init is the initial value utilized in finding the intersection
function [threshold, pp_min, pp_max] = calculateThreshold(Xmin, Xmax, p, init)

	[Xmin_snrdB Xmin_m] = aggregate(Xmin(:,1), Xmin(:,p), @(x) min(x));
	Xmin_m = cell2mat(Xmin_m);
	Xmin1 = [Xmin_snrdB Xmin_m];
	
	[Xmax_snrdB Xmax_m] = aggregate(Xmax(:,1), Xmax(:,p), @(x) max(x));
	Xmax_m = cell2mat(Xmax_m);
	Xmax1 = [Xmax_snrdB Xmax_m];
	
	pp_min = interp1(Xmin1(:,1), Xmin1(:,2), 'linear', 'pp');
	pp_max = interp1(Xmax1(:,1), Xmax1(:,2), 'linear', 'pp');
	x_intersect = fzero(@(x) ppval(pp_min,x) - ppval(pp_max,x), init);
	threshold = ppval(pp_min, x_intersect);
	
end

