%=========================================================================
%                                                                     
%	TITLE: 
%       I2K.m				
%								
%	DESCRIPTION:						
%	    Performs Fourier transform
%
%	INPUT:								
%       N-dimensional data		
%
%	OUTPUT:							
%       N-dimensional data
%			
%	VERSION HISTORY:						
%	    120216SK INITIAL VERSION 
%
%=========================================================================

%=========================================================================
%	M A I N  F U N C T I O N
%=========================================================================
function data = I2K(data)

    if nargin<2, dim=[]; end
    numdims = ndims(data);
    idx = cell(1,numdims);
    for k = 1:numdims
        m = size(data,k);
        if m>1 & (isempty(dim) | ~isempty(find(k==dim))),
            p = bitshift(m,-1)+1;
            idx{k} = [p:m 1:p-1];
            clear p
        else
            idx{k} = [1:m];
        end
    end
    clear k m;
    data = data(idx{:}); 
    fftnumelements = 1;
    for k = 1:numdims
        m = size(data,k);
        if m>1 & (isempty(dim) | ~isempty(find(k==dim))),
            data = fft(data,[],k);
            fftnumelements = fftnumelements*m; 
        end
    end
    clear k m numdims;
    data(idx{:}) = data;
    clear idx;
    data = data/fftnumelements;

end


%=========================================================================
%=========================================================================
            