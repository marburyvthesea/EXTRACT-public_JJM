function rssGB = getRSSGB()
    pid = feature('getpid');

    if ismac
        % macOS: ps reports RSS in KB
        [st,out] = system(sprintf('ps -o rss= -p %d', pid));
        if st ~= 0
            rssGB = NaN; return
        end
        rssKB = str2double(strtrim(out));
        rssGB = rssKB/1024/1024;

    elseif isunix
        % Linux: /proc is available
        [st,out] = system("awk '/VmRSS/ {print $2}' /proc/self/status");
        if st ~= 0 || isempty(strtrim(out))
            rssGB = NaN; return
        end
        rssKB = str2double(strtrim(out));
        rssGB = rssKB/1024/1024;

    else
        rssGB = NaN;
    end
end