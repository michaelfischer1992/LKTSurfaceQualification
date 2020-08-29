function OffeneWorkbooks

% Alle Excel-Dokumente abspeichern und schließen! 
try
    %Check if an Excel server is running
    ex = actxGetRunningServer('Excel.Application');
catch ME
    disp(ME.message)
end

name=string(zeros(10,1));
if exist('ex','var')
    %Get the names of all open Excel files
    wbs = ex.Workbooks;

    %List the entire path of all excel workbooks that are currently open
    while wbs.Count > 0
        for i = 1:wbs.Count
            name(i,1) = wbs.Item(i).FullName;
            uiwait(msgbox({'Please close the following excel file(s):';' ';name(1:wbs.Count,1)}));
        end
    end 
end