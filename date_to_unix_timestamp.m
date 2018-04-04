function unix_timestamp = date_to_unix_timestamp(date)
% date_to_unix_timestamp: Convert MATLAB serial date to UNIX timestamp
%   Usage: unix_timestamp = date_to_unix_timestamp(datenum(2017, 1, 1))

epoch_start_date = datenum(1970, 0, 1);
unix_timestamp = (date - epoch_start_date) * 24 * 60 * 60;
