%% ConvertEDF2ASCII: Converts EDF+ files to ASCII files
function [ok] = ConvertEDF2ASCII(filename, ismultiple)
addpath(strcat(cd, '/edfp2ascii'));
ok = translate_edf2ascii(filename, ismultiple);