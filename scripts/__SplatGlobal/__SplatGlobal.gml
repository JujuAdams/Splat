function __SplatGlobal()
{
    static _struct = {
        __splatMapArray: [],
        __imageDataMap:  ds_map_create(),
        __texture:       undefined,
        __vertexFormat:  undefined,
        __releaseMode:   (GM_build_type != "run"),
    };
    
    return _struct;
}