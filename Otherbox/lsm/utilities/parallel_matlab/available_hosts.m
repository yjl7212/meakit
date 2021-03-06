function hosts=available_hosts(varargin)
% AVAILABLE_HOSTS returns hosts available for running parallel matlab processes.
%
% H = AVAILABLE_HOSTS returns the cell array H where H{2*i-1} is a
% hostname and H{2*i} is the number of matlab processes to start on
% the host H{2*i} (for i=1 to #hosts/2).
  
% $Author: tnatschl $
% $Date: 2003/08/22 09:35:23 $
% $Revision: 1.5 $
  
hosts = { ...
'figipc77' 1 ...
'figipc76' 2 ...
'figipc75' 1 ...
'figipc74' 1 ...
'figipc73' 2 ...
'figipc72' 2 ...
'figipc71' 2 ...
'figipc70' 2 ...
'figipc68' 1 ...
'figipc67' 1 ...
'figipc66' 0 ...
'figipc65' 1 ...
'figipc64' 0 ...
'figipc63' 0 ...
'figipc62' 0 ...
'figipc61' 0 ...
'figipc60' 1 ...
'figipc59' 0 ...
'figipc58' 0 ...
'figipc57' 0 ...
'figipc56' 0 ...
'figipc55' 0 ...
'figipc54' 0 ...
'figipc53' 0 ...
'figipc52' 0 ...
'figipc51' 1 ...
'figipc50' 0 ...
'figipc09' 0 ...
'figipc06' 0 ...
'figipc05' 0 ...
};

