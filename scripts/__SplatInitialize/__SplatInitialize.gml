#macro __SPLAT_GLOBAL  static _global = __SplatGlobal();

#macro __SPLAT_SPRITE_BYTE_SIZE  144
#macro __SPLAT_MAX_IMAGES        1000

__SplatInitialize();

function __SplatInitialize()
{
    static _initialized = false;
    if (_initialized) return;
    _initialized = true;
    
    var _global = __SplatGlobal();
    
    vertex_format_begin();
    vertex_format_add_position_3d();  // 3*4
    vertex_format_add_colour();       // 4
    vertex_format_add_texcoord();     // 2*4
    _global.__vertexFormat = vertex_format_end(); //24 per vertex, 72 per tri, 144 per quad
    
    //Cache texture page index information for every image of every sprite
    var _textureIndex = undefined;
    var _firstSprite  = undefined;
    
    var _imageDataMap = _global.__imageDataMap;
    var _sprite = 0;
    while(sprite_exists(_sprite))
    {
        var _tags = asset_get_tags(_sprite, asset_sprite);
        var _i = 0;
        repeat(array_length(_tags))
        {
            if (string_lower(_tags[_i]) == "splat")
            {
                var _number = sprite_get_number(_sprite);
                if (_number > __SPLAT_MAX_IMAGES) __SplatError("Image number cannot exceed ", __SPLAT_MAX_IMAGES, " (", sprite_get_name(_sprite), ")");
                
                var _framesArray = sprite_get_info(_sprite).frames;
                var _image = 0;
                repeat(_number)
                {
                    if (_textureIndex == undefined)
                    {
                        _firstSprite = _sprite;
                        _textureIndex = _framesArray[_image].texture;
                        _global.__texture = sprite_get_texture(_sprite, _image);
                    }
                    else if (_textureIndex != _framesArray[_image].texture)
                    {
                        __SplatError("All sprites tagged for use with Splat must be on the same texture page\n- Texture page derived from ", sprite_get_name(_firstSprite), "\n- Failed on ", sprite_get_name(_sprite));
                    }
                    
                    var _uvs = sprite_get_uvs(_sprite, _image);
                    
                    var _left   = -sprite_get_xoffset(_sprite) + _uvs[4];
                    var _top    = -sprite_get_yoffset(_sprite) + _uvs[5];
                    var _right  = _left + _uvs[6]*sprite_get_width(_sprite);
                    var _bottom = _top + _uvs[7]*sprite_get_height(_sprite);
                    
                    _imageDataMap[? __SPLAT_MAX_IMAGES*_sprite + _image] = {
                        __left:   _left,
                        __top:    _top,
                        __right:  _right,
                        __bottom: _bottom,
                        
                        __u0: _uvs[0],
                        __v0: _uvs[1],
                        __u1: _uvs[2],
                        __v1: _uvs[3],
                    };
                    
                    ++_image;
                }
                
                break;
            }
            
            ++_i;
        }
        
        ++_sprite;
    }
    
    if (_textureIndex == undefined)
    {
        __SplatError("No sprite assets have been tagged with \"splat\" in the IDE");
    }
}