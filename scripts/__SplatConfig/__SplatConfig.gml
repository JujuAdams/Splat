//These two macros define the size of each region of a splatmap
//Higher numbers will reduce the number of draw calls overall, but may end up with sprites on the
//splatmap being drawn off-screen unnessarily. Smaller numbers will increase the density and
//accuracy of sprite-drawing but may end up with a lot of sprites being drawn. You will need to
//experiment with values to get the right value for your game, taking into account the aesthetic
//and performance impact
#macro SPLAT_REGION_WIDTH   100
#macro SPLAT_REGION_HEIGHT  100

//Defines the maxium number of sprites that can be drawn for each region of a splatmap
//Choose a higher number for more overlapping sprites, choose a smaller number for
//better performance
#macro SPLAT_MAX_SPRITE_COUNT  25

//All sprites drawn to a splatmap must be tagged with "splat" in the IDE
//When running from the IDE, you'll receive error messages when trying to use an untagged sprite
//with a splatmap, but when running from an executable (i.e. in production) then these errors won't
//occur (and instead the operation will silently fail). This might be inconvenient when working
//with a QA team, so this macro exists to force errors to help iron out any, otherwise silent,
//problems
#macro SPLAT_FORCE_MISSING_TAG_ERROR  false