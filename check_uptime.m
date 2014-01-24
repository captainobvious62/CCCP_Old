function uptime = check_uptime(station,network,channel,location,time)
general_settings
check_savename = sprintf('%s/%s/DATA_%s_%s.mat',base_folder,check_folder,station,channel);
exists = 2;
while exists == 2;
    if exist(check_savename,'file') == 2
        load(check_savename)
        exists = 0;
        for i = 1:length(check.Channels)
            if datenum(time) >= check.uptime(i,1) && datenum(time) <= check.uptime(i,2)
                exists = 1;
                if isempty(check.downtime) == 0
                    for n = 1:length(check.downtime)
                        if datenum(time) >= check.downtime(n,1) && datenum(time) <= check.downtime(n,2)
                            exists = 0;
                        end
                    end
                end
                
            end
        end
    elseif exist(check_savename,'file') == 0
        %This is here because the idiot IRIS network decided it would be a
        %good idea to switch channel nomenclature midyear
        exists = 2;
        gatherCheck
    end
end
uptime = exists;