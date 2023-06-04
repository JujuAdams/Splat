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