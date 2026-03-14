function [h, w, t] = get_movie_size_h5ormat(M)
    if iscell(M)
        [~,~,ext] = fileparts(M{1});
        
        if strcmpi(ext, '.mat')
            mf = matfile(M{1});
            sz = size(mf, M{2});
            h=sz(1);
            w=sz(2);
            t=sz(3);

        elseif any(strcmpi(ext, {'.h5','.hdf5'}))
            [path, dataset] = parse_movie_name(M);
            movie_info = h5info(path, dataset);
            movie_size = num2cell(movie_info.Dataspace.Size);
            [h, w, t] = deal(movie_size{:});

        else
            error('Unsupported extension for file-backed movie: %s', ext)
        end 
    
    else
        [h, w, t] = size(M);
    end
end