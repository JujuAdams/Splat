function __SplatClassModel() constructor
{
    __SPLAT_GLOBAL
    static __texture      = _global.__texture;
    static __vertexFormat = _global.__vertexFormat;
    static __imageDataMap = _global.__imageDataMap;
    
    __destroyed = false;
    __dirty = false;
    
    __buffer = buffer_create(__SPLAT_SPRITE_BYTE_SIZE*SPLAT_MAX_SPRITE_COUNT, buffer_fixed, 1);
    __vertexBuffer = vertex_create_buffer_from_buffer(__buffer, __vertexFormat);
    
    __spriteCount = 0;
    
    
    
    static __Destroy = function()
    {
        if (__destroyed) return;
        
        __destroyed = true;
        
        buffer_delete(__buffer);
        vertex_delete_buffer(__vertexBuffer);
        
        __buffer = undefined;
        __vertexBuffer = undefined;
    }
    
    static __Clear = function()
    {
        __spriteCount = 0;
        __dirty       = false;
        
        vertex_delete_buffer(__vertexBuffer);
        
        buffer_fill(__buffer, 0, buffer_u64, 0, buffer_get_size(__buffer));
        __vertexBuffer = vertex_create_buffer_from_buffer(__buffer, __vertexFormat);
    }
    
    static __Draw = function()
    {
        if (__dirty)
        {
            __dirty = false;
            
            vertex_delete_buffer(__vertexBuffer);
            __vertexBuffer = vertex_create_buffer_from_buffer(__buffer, __vertexFormat);
        }
        
        vertex_submit(__vertexBuffer, pr_trianglelist, __texture);
    }
    
    static __Splat = function(_sprite, _image, _x, _y, _xScale, _yScale, _angle, _colour, _alpha)
    {
        var _imageData = __imageDataMap[? __SPLAT_MAX_IMAGES*_sprite + _image];
        if (_imageData == undefined) __SplatError(sprite_get_name(_sprite), " not tagged with \"splat\" in the IDE");
        
        var _rgba = (_colour & 0xFFFFFF) | ((0xFF*_alpha) << 24)
        
        //Cache the UVs for speeeeeeeed
        var _u0 = _imageData.__u0;
        var _v0 = _imageData.__v0;
        var _u1 = _imageData.__u1;
        var _v1 = _imageData.__v1;
        
        //Scale up the image
        var _l = _xScale*_imageData.__left;
        var _t = _yScale*_imageData.__top;
        var _r = _xScale*_imageData.__right;
        var _b = _yScale*_imageData.__bottom;
        
        //Perform a simple 2D rotation in the y-axis
        var _sin = dsin(-_angle);
        var _cos = dcos(-_angle);
        
        var _ltX = _x + _l*_cos - _t*_sin;
        var _ltY = _y + _l*_sin + _t*_cos;
        var _rtX = _x + _r*_cos - _t*_sin;
        var _rtY = _y + _r*_sin + _t*_cos;
        var _lbX = _x + _l*_cos - _b*_sin;
        var _lbY = _y + _l*_sin + _b*_cos;
        var _rbX = _x + _r*_cos - _b*_sin;
        var _rbY = _y + _r*_sin + _b*_cos;
        
        var _buffer = __buffer;
        
        __spriteCount = (__spriteCount + 1) mod SPLAT_MAX_SPRITE_COUNT;
        buffer_seek(_buffer, buffer_seek_start, __spriteCount*__SPLAT_SPRITE_BYTE_SIZE);
        
        buffer_write(_buffer, buffer_f32, _ltX); buffer_write(_buffer, buffer_f32, _ltY); buffer_seek(_buffer, buffer_seek_relative, 4); buffer_write(_buffer, buffer_u32, _rgba); buffer_write(_buffer, buffer_f32, _u0); buffer_write(_buffer, buffer_f32, _v0);
        buffer_write(_buffer, buffer_f32, _lbX); buffer_write(_buffer, buffer_f32, _lbY); buffer_seek(_buffer, buffer_seek_relative, 4); buffer_write(_buffer, buffer_u32, _rgba); buffer_write(_buffer, buffer_f32, _u0); buffer_write(_buffer, buffer_f32, _v1);
        buffer_write(_buffer, buffer_f32, _rtX); buffer_write(_buffer, buffer_f32, _rtY); buffer_seek(_buffer, buffer_seek_relative, 4); buffer_write(_buffer, buffer_u32, _rgba); buffer_write(_buffer, buffer_f32, _u1); buffer_write(_buffer, buffer_f32, _v0);
        
        buffer_write(_buffer, buffer_f32, _rtX); buffer_write(_buffer, buffer_f32, _rtY); buffer_seek(_buffer, buffer_seek_relative, 4); buffer_write(_buffer, buffer_u32, _rgba); buffer_write(_buffer, buffer_f32, _u1); buffer_write(_buffer, buffer_f32, _v0);
        buffer_write(_buffer, buffer_f32, _lbX); buffer_write(_buffer, buffer_f32, _lbY); buffer_seek(_buffer, buffer_seek_relative, 4); buffer_write(_buffer, buffer_u32, _rgba); buffer_write(_buffer, buffer_f32, _u0); buffer_write(_buffer, buffer_f32, _v1);
        buffer_write(_buffer, buffer_f32, _rbX); buffer_write(_buffer, buffer_f32, _rbY); buffer_seek(_buffer, buffer_seek_relative, 4); buffer_write(_buffer, buffer_u32, _rgba); buffer_write(_buffer, buffer_f32, _u1); buffer_write(_buffer, buffer_f32, _v1);
        
        __dirty = true;
    }
}