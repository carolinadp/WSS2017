(* ::Package:: *)

Package["ResistorProject`"]

PackageExport[prepareImage]

prepareImage[img_Image] := Module[{imgwbg, mag, ori, nbins, mat, total, angle},

    imgwbg = RemoveBackground[img];
    
    mag = GradientFilter[imgwbg, 1];

    ori = GradientOrientationFilter[imgwbg, 1, Method -> {"UndefinedOrientationValue" -> 0}];
    
    nbins = 180;

    mat = ImageCooccurrence[{mag, ImageAdjust[ori, {0,0,1}, \[Pi]/2 * {-1,1}]},
          nbins, {{1}}];

    total = Total[ mat * Range[0, 1-1/nbins, 1/nbins]];

    angle = Pi/2(1-(Position[total, Max[total]][[1,1]]-1/2)/(nbins/2));
    
    ImageRotate[imgwbg, angle, Masking->Full]
    

 ]
