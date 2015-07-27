-- this add-on simply opens a file dialog, then outputs the name of the selected text file to the status bar and console.
-- This is not very useful, but illustrates how easily V-REP can be customized using add-ons.
-- Add-on functions can easily be used to write importers/exporters

selectedFile=simFileDialog(0,"Please select a vrep csv formatted cut file","","","Cut file","csv") -- open the file dialog in "open file" mode

if selectedFile then
	msg="You selected the file: "..selectedFile
    
    --- split path into path component, filename, extension
    --- from: https://stackoverflow.com/questions/5243179/what-is-the-neatest-way-to-split-out-a-path-name-into-its-components-in-lua
    filepath,filename,extension = string.match(selectedFile, "(.-)([^\\/]-%.?([^%.\\/]*))$")
    filenameNoExt = string.gsub(filename, '\.'..extension..'$','')

    require "grl"

    MyPathHandle = grl.loadPathFile(selectedFile,filenameNoExt,nil)

	--point1 = {0.324854,-0.825006,0.215077,-0,0,math.pi,1.000000,0,15,0.500000,0.500000} --Orientation should be in radian
	--point2 = {0.424805,-0.750010,0.215113,-0.000000,0.000000,math.pi,1.000000,0,15,0.5,0.5}

	bone=simGetObjectHandle('FemurBone')

    -- This is the position/orientation 
    -- relative to the bone where the cut file
    -- will be placed. Change these numbers to modify
    -- placement programmatically

    -- @todo perhaps these offsets should be parameters or loaded from a file?
	cutFilePosition = {0,0.028,-0.18}
	cutFileOrientation = {math.pi,math.pi,0}
    
    grl.setPoseRelativeToParent(MyPathHandle,bone,cutFilePosition,cutFileOrientation)
else
	msg="You didn't select any file"
end

simAddStatusbarMessage(msg) -- print to the statusbar
print(msg) -- print to the console
