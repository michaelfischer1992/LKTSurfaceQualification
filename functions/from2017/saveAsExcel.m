

function saveAsExcel
% Figure
S.fh = figure('units','pixels',...
    'position',[500 500 200 100],...
    'menubar','none',...
    'numbertitle','off',...
    'resize','off');
% Editbox
S.ls = uicontrol('style','edit',...
    'unit','pix',...
    'position',[10 50 180 40],...
    'fontsize',14,...
    'string','');
% SaveAs button
S.pb = uicontrol('style','push',...
    'units','pix',...
    'position',[30 10 140 30],...
    'fontsize',14,...
    'string','Save As',...
    'callback',@pb_call);

      function pb_call(varargin)
          % First open an Excel Server
          Excel = actxserver('Excel.Application');
          % set(Excel, 'Visible', 1);

          % Insert a new workbook
          Workbooks = Excel.Workbooks;
          Workbook = invoke(Workbooks, 'Add');

          % Make the second sheet active
          Sheets = Excel.ActiveWorkBook.Sheets;
          sheet1 = get(Sheets, 'Item', 1);
          invoke(sheet1, 'Activate');

          % Get a handle to the active sheet
          Activesheet = Excel.Activesheet;

          % Put a MATLAB array into Excel
          A = [1 2; 3 4];
          ActivesheetRange = get(Activesheet,'Range','A1:B2');
          set(ActivesheetRange, 'Value', A);

          Workbook.SaveAs([cd '\' get(S.ls,'string') '.xlsx'])

          % Quit Excel
          invoke(Excel, 'Quit');

          % End process
          delete(Excel);
      end
  end

