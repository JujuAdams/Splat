/// @param x
/// @param y
/// @param width
/// @param height

function __SplatClassMap(_x, _y, _width, _height) constructor
{
    __SPLAT_GLOBAL
    static __splatMapArray = _global.__splatMapArray;
    array_push(__splatMapArray, self);
    
    __destroyed = false;
    
    __pixelX      = _x;
    __pixelY      = _y;
    __pixelWidth  = _width;
    __pixelHeight = _height;
    
    __regionWidth  = ceil(__pixelWidth  / SPLAT_REGION_WIDTH );
    __regionHeight = ceil(__pixelHeight / SPLAT_REGION_HEIGHT);
    __regionCount  = __regionWidth*__regionHeight;
    
    __modelArray = array_create(__regionCount);
    
    var _i = 0;
    repeat(__regionCount)
    {
        __modelArray[@ _i] = new __SplatClassModel();
        ++_i;
    }
    
    
    
    static Destroy = function()
    {
        if (__destroyed) return;
        
        __destroyed = true;
        
        var _i = 0;
        repeat(array_length(__splatMapArray))
        {
            var _splatMap = __splatMapArray[_i];
            if (_splatMap == self)
            {
                array_delete(__splatMapArray, _i, 1);
            }
            else
            {
                ++_i;
            }
        }
        
        var _i = 0;
        repeat(__regionCount)
        {
            __modelArray[_i].__Destroy();
            ++_i;
        }
    }
    
    static Clear = function()
    {
        if (__destroyed) return;
        
        var _i = 0;
        repeat(__regionCount)
        {
            __modelArray[_i].__Clear();
            ++_i;
        }
    }
    
    /// @param left
    /// @param top
    /// @param right
    /// @param bottom
    static Draw = function(_pixelLeft, _pixelTop, _pixelRight, _pixelBottom)
    {
        if (__destroyed) return;
        
        var _left   = clamp((_pixelLeft   - __pixelX) div SPLAT_REGION_WIDTH,  0, __regionWidth-1 );
        var _top    = clamp((_pixelTop    - __pixelY) div SPLAT_REGION_HEIGHT, 0, __regionHeight-1);
        var _right  = clamp((_pixelRight  - __pixelX) div SPLAT_REGION_WIDTH,  0, __regionWidth-1 );
        var _bottom = clamp((_pixelBottom - __pixelY) div SPLAT_REGION_HEIGHT, 0, __regionHeight-1);
        
        var _width  = 1 + _right - _left;
        var _height = 1 + _bottom - _top;
        
        var _y = _top;
        repeat(_height)
        {
            var _x = _left;
            repeat(_width)
            {
                __modelArray[_x + _y*__regionWidth].__Draw();
                ++_x;
            }
            
            ++_y;
        }
    }
    
    /// @param sprite
    /// @param image
    /// @param x
    /// @param y
    /// @param [xscale=1]
    /// @param [xscale=1]
    /// @param [angle=0]
    /// @param [colour=white]
    /// @param [alpha=1]
    static SplatExt = function(_sprite, _image, _x, _y, _xscale = 1, _yscale = 1, _angle = 0, _colour = c_white, _alpha = 1)
    {
        if (__destroyed) return;
        
        var _regionX = clamp((_x - __pixelX) div SPLAT_REGION_WIDTH,  0, __regionWidth-1 );
        var _regionY = clamp((_y - __pixelY) div SPLAT_REGION_HEIGHT, 0, __regionHeight-1);
        
        __modelArray[_regionX + _regionY*__regionWidth].__Splat(_sprite, _image, _x, _y, _xscale, _yscale, _angle, _colour, _alpha);
    }
}