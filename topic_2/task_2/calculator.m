function varargout = calculator2(varargin)
% CALCULATOR2 MATLAB code for calculator2.fig
%      CALCULATOR2, by itself, creates a new CALCULATOR2 or raises the existing
%      singleton*.
%
%      H = CALCULATOR2 returns the handle to a new CALCULATOR2 or the handle to
%      the existing singleton*.
%
%      CALCULATOR2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALCULATOR2.M with the given input arguments.
%
%      CALCULATOR2('Property','Value',...) creates a new CALCULATOR2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before calculator2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to calculator2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help calculator2

% Last Modified by GUIDE v2.5 09-Jan-2022 08:21:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calculator2_OpeningFcn, ...
                   'gui_OutputFcn',  @calculator2_OutputFcn, ...
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


% --- Executes just before calculator2 is made visible.
function calculator2_OpeningFcn(hObject, eventdata, handles, varargin)
set(handles.left_error_result,'String','');
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to calculator2 (see VARARGIN)

% Choose default command line output for calculator2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes calculator2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = calculator2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in left_op_list.
function left_op_list_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));
set(handles.left_operator , 'String' , contents{get(hObject,'Value')});
% hObject    handle to left_op_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns left_op_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from left_op_list


% --- Executes during object creation, after setting all properties.
function left_op_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to left_op_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in left_equal.
function left_equal_Callback(hObject, eventdata, handles)
par1 = get(handles.num1, 'String');
par2 = get(handles.num2, 'String');

set(handles.left_error_result,'String','');
set(handles.left_result , 'String' , '');

par1_d = str2double(par1);
par2_d = str2double(par2);

if isnan(par1_d)    
    set(handles.left_error_result,'String','First Parameter is Empty or Not a Number!');
    uiwait(errordlg('First Parameter is Empty or Not a Number!', 'wrong input'));
elseif isnan(par2_d)
    set(handles.left_error_result,'String','Second Parameter is Empty or Not a Number!');
    uiwait(errordlg('Second Parameter is Empty or Not a Number!', 'wrong input'));
else
    operation = get(handles.left_operator , 'String');
    equation_str = strcat(par1,operation,par2);
    result = str2sym(equation_str);
    
    if isinf(result)
        set(handles.left_error_result,'String','You are dividing by Zero!');
        uiwait(errordlg('You are dividing by Zero!', 'wrong input'));
    else
        set(handles.left_result , 'String' , string(result));
    end
end
% hObject    handle to left_equal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function num1_Callback(hObject, eventdata, handles)
% hObject    handle to num1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num1 as text
%        str2double(get(hObject,'String')) returns contents of num1 as a double


% --- Executes during object creation, after setting all properties.
function num1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num2_Callback(hObject, eventdata, handles)
% hObject    handle to num2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num2 as text
%        str2double(get(hObject,'String')) returns contents of num2 as a double


% --- Executes during object creation, after setting all properties.
function num2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function equation_input_Callback(hObject, eventdata, handles)
% hObject    handle to equation_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of equation_input as text
%        str2double(get(hObject,'String')) returns contents of equation_input as a double


% --- Executes during object creation, after setting all properties.
function equation_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to equation_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x_axis_input_Callback(hObject, eventdata, handles)
% hObject    handle to x_axis_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_axis_input as text
%        str2double(get(hObject,'String')) returns contents of x_axis_input as a double


% --- Executes during object creation, after setting all properties.
function x_axis_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_axis_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_axis_input_Callback(hObject, eventdata, handles)
% hObject    handle to y_axis_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_axis_input as text
%        str2double(get(hObject,'String')) returns contents of y_axis_input as a double


% --- Executes during object creation, after setting all properties.
function y_axis_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_axis_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in right_op_list.
function right_op_list_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));
set(handles.right_operator , 'String' , contents{get(hObject,'Value')});

% hObject    handle to right_op_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns right_op_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from right_op_list


% --- Executes during object creation, after setting all properties.
function right_op_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to right_op_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in right_equal.
function right_equal_Callback(hObject, eventdata, handles)
set(handles.right_error_result,'String','');
set(handles.right_result , 'String' , '');
set(handles.right_result,'String','');

vec1 = get(handles.x_axis_input, 'String');
vec2 = get(handles.y_axis_input, 'String');

vec1_n = str2num(vec1);
vec2_n = str2num(vec2);

if ~isvector(vec1_n)
    set(handles.right_error_result, 'String', 'Input 1 must be Vectors!');
    return
end

if ~isvector(vec2_n)
    set(handles.right_error_result, 'String', 'Input 2 must be Vectors!');
    return
end

if length(vec1_n) ~= length(vec2_n)
    set(handles.right_error_result, 'String', 'Vectors must be the same length!');
    return
end

operation = get(handles.right_operator , 'String');
if operation=='*' | operation=='/'
    equation_str = strcat(vec1,'.',operation,vec2);
else
    equation_str = strcat(vec1,operation,vec2);
end
result = str2sym(equation_str);
%disp(string(result));
disp(class(char(result)));
set(handles.right_result , 'String' , string(char(result)));
%disp(class(get(handles.right_result, 'String')));

%{
if isnan(vec1_d)    
    set(handles.right_error_result,'String','First Parameter is Empty or Not a Number!');
    uiwait(errordlg('First Parameter is Empty or Not a Number!', 'wrong input'));
elseif isnan(par2_d)
    set(handles.right_error_result,'String','Second Parameter is Empty or Not a Number!');
    uiwait(errordlg('Second Parameter is Empty or Not a Number!', 'wrong input'));
else
    operation = get(handles.right_operator , 'String');
    equation_str = strcat(vec1,operation,vec2);
    result = str2sym(equation_str);
    
    if isinf(result)
        set(handles.right_error_result,'String','You are dividing by Zero!');
        uiwait(errordlg('You are dividing by Zero!', 'wrong input'));
    else
        set(handles.right_result , 'String' , string(result));
    end
end
%}


% hObject    handle to right_equal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in enter.
function enter_Callback(hObject, eventdata, handles)

vec1 = str2num(get(handles.x_axis_input, 'String'));
vec2 = str2num(get(handles.y_axis_input, 'String'));
operation = get(handles.plotting_options, 'SelectedObject');

switch get(operation, 'Tag')
    case 'x_axis'
        vec2 = 1:1:length(vec1);
        plot(vec1, vec2);
        
    case 'y_axis'
        plot(handles.plot_output, vec2);
        
    case 'xy_axis'
        if length(vec1) ~= length(vec2)
            set(handles.right_error_result, 'String', 'Vectors must be the same length!');
            
        else
            plot(handles.plot_output, vec1, vec2);
        end
        
    case 'resultant'
        plot(handles.plot_output, str2num(string(get(handles.right_result, 'String'))));
       
        
    case 'sine'
        plot(handles.plot_output, sind(0:0.1:360));
        
    case 'cosine'
        plot(handles.plot_output, cosd(0:0.1:360));
        
    case 'equation'        
        x = 1:0.1:10;
        y = 1:0.1:10;
        eq = get(handles.equation_input, 'String'); 
        axes(handles.plot_output);
        %plot(eval(eq));
        ezplot(eq);
        
    otherwise
        plot(handles.plot_output, plot(0, 0));
end
% hObject    handle to enter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)
plot(handles.plot_output, plot(0, 0));
% hObject    handle to delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
