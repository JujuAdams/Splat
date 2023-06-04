/// Creates a splatmap that spans the given coordinates in the room
/// Splats are internally subdivided into regions (see __SplatConfig())
/// 
/// A splatmap is returned as a struct, and this struct has the following methods:
/// 
/// .Destroy()
///     Destroys the splatmap, and frees all memory associated with it
///     N.B. You MUST call this function when discarding a splatmap otherwise you will have a memory leak!
/// 
/// .Draw(left, top, right, bottom)
///     Draws the given portion of the splatmap. The edges of the splatmap are not precise and sprites
///     may overlap the edges of the splat map slightly
/// 
/// .SplatExt(sprite, image, x, y, [xscale = 1], [yscale = 1], [angle = 0], [colour = white], [alpha = 1])
///     Adds a sprite to the splatmap
///     Any sprite that you want to add to a splatmap should be tagged with "splat" in the GameMaker IDE
///     All sprites that you want to add to a splatmap must be on the same texture page
/// 
/// .Clear()
///     Clears all sprites added to the splatmap
///     
/// 
/// 
/// @param x
/// @param y
/// @param width
/// @param height

function SplatMap(_x, _y, _width, _height)
{
    return new __SplatClassMap(_x, _y, _width, _height);
}