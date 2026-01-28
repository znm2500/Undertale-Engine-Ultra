varying vec2 v_vTexcoord;

uniform vec2 u_vTexel;
uniform float u_light;

void main()
{
    // 五点采样加权平均（中心点权重为 4，四周各为 1）
    vec4 color = (
        4.0 * texture2D(gm_BaseTexture, v_vTexcoord) +
        texture2D(gm_BaseTexture, v_vTexcoord + vec2( u_vTexel.x,  0.0)) +
        texture2D(gm_BaseTexture, v_vTexcoord + vec2(-u_vTexel.x,  0.0)) +
        texture2D(gm_BaseTexture, v_vTexcoord + vec2( 0.0,  u_vTexel.y)) +
        texture2D(gm_BaseTexture, v_vTexcoord + vec2( 0.0, -u_vTexel.y))
    ) / 8.0;

    // 输出最终颜色，应用亮度系数
    gl_FragColor = vec4(color.rgb * u_light, color.a);
}