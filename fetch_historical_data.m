function [success, output] = fetch_historical_data(stockSymbol, from, to)
% fetch_historical_data: Fetch financial historical data from Yahoo! Server
% Usage: [success, output] = fetch_historical_data('0011.HK',
%                                     datenum(2017,1,1), datenum(2018,1,1))

% convert the time before we change dir
from_unix = date_to_unix_timestamp(from);
to_unix = date_to_unix_timestamp(to);

% save the current dir. we need to restore working directory after we have done
workDir = pwd();
cd('yahoo-financial-historical-fetcher/');

% random tmp file name
tmp_file = sprintf('tmp_%i.csv', floor(rand() * 10000));

% call node JS script
cmd = sprintf('node fetcher "%s" %i %i "../%s"', stockSymbol, from_unix, to_unix, tmp_file);
[status, output] = system(cmd);

% restore working directory
cd(workDir);

% assume fail if the exit code is not 0
if (status ~= 0) 
    delete(tmp_file);
    success = false;
    return;
end

stats = dir(tmp_file);
if (stats.bytes <= 1)
    delete(tmp_file);
    success = false;
    output = 'No data can be fetched.';
    return;
end

% read csv
output = csvread(tmp_file);
success = true;

% remove the tmp file
delete(tmp_file);

end
