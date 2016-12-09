%% add_eeglab_path: Gets the EEGLAB functions
function add_eeglab_path(pathname)
% Gets the EEGLAB functions
% Bug: Maybe this function should not be here.
stuff = { ...
    pathname, ...
    strcat(pathname, '/functions'), ...
    strcat(pathname, '/functions/sigprocfunc'), ...
    strcat(pathname, '/functions/popfunc'), ...
    strcat(pathname, '/functions/studyfunc'), ...
    strcat(pathname, '/functions/timefreqfunc'), ...
    strcat(pathname, 'functions/adminfunc'), ...
};

for index = 1:length(stuff)
    addpath(stuff{index});
end
