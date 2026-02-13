varying vec2 v_vTexcoord;

uniform vec2 u_vTexel;
uniform float u_light;

void main()
{
    // 对周围像素进行采样并加权
    vec4 color = (
        texture2D(gm_BaseTexture, v_vTexcoord + vec2( 2.0 * u_vTexel.x,  0.0)) +
        texture2D(gm_BaseTexture, v_vTexcoord + vec2(-2.0 * u_vTexel.x,  0.0)) +
        texture2D(gm_BaseTexture, v_vTexcoord + vec2( 0.0,  2.0 * u_vTexel.y)) +
        texture2D(gm_BaseTexture, v_vTexcoord + vec2( 0.0, -2.0 * u_vTexel.y)) +
        2.0 * texture2D(gm_BaseTexture, v_vTexcoord + vec2(  u_vTexel.x,   u_vTexel.y)) +
        2.0 * texture2D(gm_BaseTexture, v_vTexcoord + vec2( -u_vTexel.x,   u_vTexel.y)) +
        2.0 * texture2D(gm_BaseTexture, v_vTexcoord + vec2(  u_vTexel.x,  -u_vTexel.y)) +
        2.0 * texture2D(gm_BaseTexture, v_vTexcoord + vec2( -u_vTexel.x,  -u_vTexel.y))
    ) / 12.0;

    // 应用亮度叠加 (u_light) 并保持原有的 Alpha 通道
    gl_FragColor = vec4(color.rgb * u_light, color.a);
}