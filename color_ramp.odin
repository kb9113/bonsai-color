package color

import "core:math"
import "base:intrinsics"

ColorRampNode :: struct($T : typeid)
{
    color : T,
    t : f64
}

eval_color_ramp :: proc(color_ramp : []ColorRampNode($T), t : f64) -> T
    where T == LinearRGBColor || T == LinearRGBAColor || T == XYZColor
{
    if t < color_ramp[0].t
    {
        return color_ramp[0].color
    }
    for i in 1..<len(color_ramp)
    {
        if t < color_ramp[i].t
        {
            local_t := (t - color_ramp[i - 1].t) / (color_ramp[i].t - color_ramp[i - 1].t)
            return math.lerp(color_ramp[i - 1].color, color_ramp[i].color, local_t)
        }
    }
    return color_ramp[len(color_ramp) - 1].color
}
