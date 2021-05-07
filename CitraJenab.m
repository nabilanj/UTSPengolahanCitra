function varargout = CitraJenab(varargin)
% CitraJenab MATLAB code for CitraJenab.fig
%      CitraJenab, by itself, creates a new CitraJenab or raises the existing
%      singleton*.
%
%      H = CitraJenab returns the handle to a new CitraJenab or the handle to
%      the existing singleton*.
%
%      CitraJenab('CALLBAguCK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CitraJenab.M with the given input arguments.
%
%      CitraJenab('Property','Value',...) creates a new CitraJenab or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CitraJenab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CitraJenab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CitraJenab

% Last Modified by GUIDE v2.5 08-May-2021 05:45:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CitraJenab_OpeningFcn, ...
                   'gui_OutputFcn',  @CitraJenab_OutputFcn, ...
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


% --- Executes just before CitraJenab is made visible.
function CitraJenab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CitraJenab (see VARARGIN)

% Choose default command line output for CitraJenab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CitraJenab wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CitraJenab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in seacrh.
function seacrh_Callback(hObject, eventdata, handles)
% hObject    handle to seacrh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I;
global G;
[nama , alamat] = uigetfile({'*.jpg';'*.bmp';'*.png';'*.tif'},'Browse Image'); %mengambil data
I = imread([alamat,nama]); %membaca data yg dipilih
handles.image=I; %gambar terpilih disimpan ke I
guidata(hObject, handles); %mengarahkan gcbo ke objek yg fungsinya sedang di eksekusi
axes(handles.axes1); %akses akses1
imshow(I,[]); %menampilkan gambar
G=I; %menyimpan data I ke G, jd isinya sama G dg I, nanti G yang berubah karena image processingnya

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
[nama, alamat] = uiputfile({'*.png','PNG (*.PNG)';'*.jpg','JPG (*.jpg)'},'Save Image');
imwrite(G,fullfile(alamat,nama));
guidata(hObject, handles);

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
global I;
citra=handles.image; 
axes(handles.axes2);
cla;
imshow(citra); %membuat citra asli blm terkena filter tetap ada
axes(handles.axes4);
cla reset;
G=I;

% --- Executes on slider movement.
function Contrass_Callback(hObject, eventdata, handles)
% hObject    handle to Contrass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global G;
valueKon=get(handles.Contrass,'Value'); %ambil nilai kontras
valueCe=get(handles.brightness,'Value'); %ambil nilai cerah
set(handles.txtC,'String',valueKon); %tulis nilai kontras
citra=handles.image; %citra asli
cerah=citra+valueCe; %operasi kecerahan
kontras=valueKon*cerah; %operasi kontras, jd walaupun valueCe bernilai 0, kontras dinaikkan akan tetap memberikan efek, 
                        %tp kalo valueKon 0 maka kecerahan ditambah berapapun akan gelap
G=kontras; %tampilin citra setelah kena kontras
axes(handles.axes2); %tampilin di axes2
guidata(hObject, handles); 
imshow(G,[]); %menampilkan G dengan array agar dapat dilakukan perubahan efek scr langsung setelah citra terakhir
axes(handles.axes4); 
histogramRGB(G);

% --- Executes during object creation, after setting all properties.
function Contrass_CreateFcn(hObject, ~, handles)
% hObject    handle to Contrass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function brightness_Callback(hObject, ~, handles)
% hObject    handle to brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
valueK=get(handles.Contrass,'Value');
valueC=get(handles.brightness,'Value');
set(handles.txtB,'String',valueC);
citra=handles.image;
kontras=valueK*(citra+valueC); %operasi kontras, jd kalo valueK 0 maka kontras bernilai 0
cerah=kontras+valueC; %berhub dg koding kontras, jd ini jika nilai kontras ada maka penambahan cerah dilihat dr kontrasnya
G=cerah;
axes(handles.axes2);
guidata(hObject, handles);
imshow(G,[]);
axes(handles.axes4);
histogramRGB(G);

% --- Executes during object creation, after setting all properties.
function brightness_CreateFcn(hObject, ~, ~)
% hObject    handle to brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in red.
function red_Callback(hObject, eventdata, handles)
% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
axes(handles.axes2);
red = G(:,:,1); % Red channel
% Create an all black channel.
var = zeros(size(G, 1), size(G, 2), 'uint8');
% Create color versions of the individual color channels.
just_red = cat(3, red, var, var);
guidata(hObject,handles);
imshow(just_red);
axes(handles.axes4);
histogram(G(:),256,'FaceColor','r','EdgeColor','r')

% --- Executes on button press in green.
function green_Callback(hObject, eventdata, handles)
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
axes(handles.axes2);
green = G(:,:,2); % Green channel
% Create an all black channel.
var = zeros(size(G, 1), size(G, 2), 'uint8');
% Create color versions of the individual color channels.
just_green = cat(3, var, green, var);
guidata(hObject,handles);
imshow(just_green);
axes(handles.axes4);
%histogramRGB(G);
histogram(G(:),256,'FaceColor','g','EdgeColor','g')

% --- Executes on button press in blue.
function blue_Callback(hObject, eventdata, handles)
% hObject    handle to blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G;
axes(handles.axes2);
blue = G(:,:,3); % Blue channel
% Create an all black channel.
var = zeros(size(G, 1), size(G, 2), 'uint8');
% Create color versions of the individual color channels.
just_blue = cat(3, var, var, blue);
guidata(hObject,handles);
imshow(just_blue);
axes(handles.axes4);
%histogramRGB(G);
histogram(G(:),256,'FaceColor','b','EdgeColor','b')


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function txtC_Callback(hObject, eventdata, handles)
% hObject    handle to txtC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtC as text
%        str2double(get(hObject,'String')) returns contents of txtC as a double


% --- Executes during object creation, after setting all properties.
function txtC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtB_Callback(~, eventdata, handles)
% hObject    handle to txtB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtB as text
%        str2double(get(hObject,'String')) returns contents of txtB as a double


% --- Executes during object creation, after setting all properties.
function txtB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sharpness_Callback(hObject, eventdata, handles)
% hObject    handle to sharpness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global G;
valueSharp=get(handles.sharpness,'Value');
set(handles.txtS,'String',valueSharp);
citra=handles.image;
sharpen=imsharpen(citra,'Radius',2,'Amount',valueSharp); %Amount: how much sharpening you’re doing, ambil dr valueSharp
                        %Radius: the reach of the filter, in terms of how far from an edge the sharpening extends
                        %2 adl Nilai yg mengontrol ukuran wilayah di sekitar piksel tepi yang dipengaruhi oleh penajaman
                        %Standard deviation of the Gaussian lowpass filter=1
G=sharpen;
axes(handles.axes2);
guidata(hObject, handles);
imshow(G,[]);
axes(handles.axes4);
histogramRGB(G); %panggil fungsi histogram

% --- Executes during object creation, after setting all properties.
function sharpness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sharpness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function txtS_Callback(hObject, eventdata, handles)
% hObject    handle to txtS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtS as text
%        str2double(get(hObject,'String')) returns contents of txtS as a double


% --- Executes during object creation, after setting all properties.
function txtS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
