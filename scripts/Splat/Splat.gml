/// @param sprite
/// @param image
/// @param x
/// @param y
/// @param [xscale=1]
/// @param [xscale=1]
/// @param [angle=0]
/// @param [colour=white]
/// @param [alpha=1]

function Splat(_sprite, _image, _x, _y, _xscale = 1, _yscale = 1, _angle = 0, _colour = c_white, _alpha = 1)
{
    __SPLAT_GLOBAL
    
    if (array_length(_global.__splatMapArray) <= 0) __SplatError("No splatmap exists (call SplatMap() first)");
    
    _global.__splatMapArray[0].SplatExt(_sprite, _image, _x, _y, _xscale, _yscale, _angle, _colour, _alpha);
}