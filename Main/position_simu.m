function varargout = position_simu(varargin)
% POSITION_SIMU MATLAB code for position_simu.fig
%      POSITION_SIMU, by itself, creates a new POSITION_SIMU or raises the existing
%      singleton*.
%
%      H = POSITION_SIMU returns the handle to a new POSITION_SIMU or the handle to
%      the existing singleton*.
%
%      POSITION_SIMU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POSITION_SIMU.M with the given input arguments.
%
%      POSITION_SIMU('Property','Value',...) creates a new POSITION_SIMU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before position_simu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to position_simu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help position_simu

% Last Modified by GUIDE v2.5 01-Feb-2019 02:19:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @position_simu_OpeningFcn, ...
                   'gui_OutputFcn',  @position_simu_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before position_simu is made visible.
function position_simu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to position_simu (see VARARGIN)


% Choose default command line output for position_simu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.axes1);
image = imread('platform.png');
h1 = imshow(image);
set(h1, 'ButtonDownFcn', @sendData);
set(gcf,'WindowButtonMotionFcn',@getMousePos);
% button_load_Callback(hObject, eventdata, handles);

% UIWAIT makes position_simu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = position_simu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_x_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x as text
%        str2double(get(hObject,'String')) returns contents of edit_x as a double


% --- Executes during object creation, after setting all properties.
function edit_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y as text
%        str2double(get(hObject,'String')) returns contents of edit_y as a double


% --- Executes during object creation, after setting all properties.
function edit_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_z as text
%        str2double(get(hObject,'String')) returns contents of edit_z as a double


% --- Executes during object creation, after setting all properties.
function edit_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_phi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phi as text
%        str2double(get(hObject,'String')) returns contents of edit_phi as a double


% --- Executes during object creation, after setting all properties.
function edit_phi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in button_send.
function button_send_Callback(hObject, eventdata, handles)
% hObject    handle to button_send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x_str = get(findobj('tag','edit_x'), 'string');
y_str = get(findobj('tag','edit_y'), 'string');
z_str = get(findobj('tag','edit_z'), 'string');
phi_str = get(findobj('tag','edit_phi'), 'string');
x = str2double(x_str);
y = str2double(y_str);
z = str2double(z_str);
phi = str2double(phi_str);
init(x,y,z,phi);

function sendData(objHandle, eventdata)
x_str = get(findobj('tag','edit_x'), 'string');
y_str = get(findobj('tag','edit_y'), 'string');
z_str = get(findobj('tag','edit_z'), 'string');
phi_str = get(findobj('tag','edit_phi'), 'string');
x = str2double(x_str);
y = str2double(y_str);
z = str2double(z_str);
phi = str2double(phi_str);
init(x,y,z,phi);

function getMousePos(src, event)
pt = get(gca,'CurrentPoint');
z = pt(1,1) / 1.181;
x = 1150 - pt(1,2) / 1.181;
if x >= 0 && x <= 1150 && z >= 0 && z <= 2100
    set(findobj('tag','edit_z'), 'string', num2str(z));
    set(findobj('tag','edit_x'), 'string', num2str(x));
end
