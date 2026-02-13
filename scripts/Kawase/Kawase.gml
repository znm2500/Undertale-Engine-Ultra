function Kawase(_width, _height, _maxIterations) constructor {
    __width = _width;
    __height = _height;
    __maxIterations = _maxIterations;

    __destroyed = false;
    __surfaceArray = array_create(_maxIterations + 1, undefined);

    var _w = __width;
    var _h = __height;
    var _i = 0;
    repeat(__maxIterations + 1) {
        var _struct = {
            __width: _w,
            __height: _h,
            __surface: -1,
            __texelWidth: 1,
            __texelHeight: 1,
        }

        __surfaceArray[@_i] = _struct;
        __CheckSurface(_struct);

        _w = _w div 2;
        _h = _h div 2; ++_i;
    }

    // --- 基础方法保持不变 ---

    static Destroy = function() {
        if (__destroyed) return;
        __destroyed = true;

        var _i = 0;
        repeat(array_length(__surfaceArray)) {
            surface_free(__surfaceArray[_i].__surface); ++_i;
        }
    }

    static GetWidth = function() {
        return __width;
    }

    static GetHeight = function() {
        return __height;
    }

    static GetMaxIterations = function() {
        return __maxIterations;
    }

    static GetSurface = function() {
        return __CheckSurface(__surfaceArray[0]);
    }

    // --- 增强版 Blur 方法：支持强度控制和亮度传递 ---
    static Blur = function(_iterations = __maxIterations, _strength = [1,1], _light = 1.1) {
        // 静态获取 Uniform，提升性能
        static _shd_kawase_down_vTexel = shader_get_uniform(shd_KawaseDown, "u_vTexel");
        static _shd_kawase_down_light  = shader_get_uniform(shd_KawaseDown, "u_light");
        static _shd_kawase_up_vTexel   = shader_get_uniform(shd_KawaseUp, "u_vTexel");
        static _shd_kawase_up_light    = shader_get_uniform(shd_KawaseUp, "u_light");
        static _identityMatrix = matrix_build_identity();

        if (__destroyed) return;
        if (_strength[0] <= 0 && _strength[1] <= 0) return;
        _iterations = clamp(_iterations, 0, __maxIterations);

        var _i = 0;
        repeat(_iterations + 1) {
            __CheckSurface(__surfaceArray[_i]); ++_i;
        }

        // 渲染状态备份
        var _oldBlendEnable = gpu_get_blendenable();
        var _oldTexFilter = gpu_get_tex_filter();
        var _oldTexRepeat = gpu_get_tex_repeat();
        var _oldShader = shader_current();
        var _oldBlendmodeSrc = gpu_get_blendmode_src();
        var _oldBlendmodeDest = gpu_get_blendmode_dest();
        var _oldMatrixWorld = matrix_get(matrix_world);

        gpu_set_blendenable(true);
        gpu_set_tex_filter(true);
        gpu_set_tex_repeat(false);
        gpu_set_blendmode_ext(bm_one, bm_zero);
        matrix_set(matrix_world, _identityMatrix);

        // --- Downsampling Pass (降采样) ---
        shader_set(shd_KawaseDown);
        shader_set_uniform_f(_shd_kawase_down_light, _light); // 设置默认亮度 1.1

        var _i = 1;
        repeat(_iterations) {
            var _preStruct = __surfaceArray[_i - 1];
            var _nextStruct = __surfaceArray[_i];

            var texelWidth = _preStruct.__texelWidth * _strength[0];
            var texelHeight = _preStruct.__texelHeight * _strength[1];

            surface_set_target(_nextStruct.__surface);
            shader_set_uniform_f(_shd_kawase_down_vTexel, texelWidth, texelHeight);
            draw_surface_stretched(_preStruct.__surface, 0, 0, _nextStruct.__width, _nextStruct.__height);
            surface_reset_target();
            ++_i;
        }

        // --- Upsampling Pass (升采样) ---
        shader_set(shd_KawaseUp);
        shader_set_uniform_f(_shd_kawase_up_light, _light); // 设置默认亮度 1.1

        var _i = _iterations;
        repeat(_iterations) {
            var _preStruct = __surfaceArray[_i];
            var _nextStruct = __surfaceArray[_i - 1];

            var texelWidth = _preStruct.__texelWidth * _strength[0];
            var texelHeight = _preStruct.__texelHeight * _strength[1];

            surface_set_target(_nextStruct.__surface);
            shader_set_uniform_f(_shd_kawase_up_vTexel, texelWidth, texelHeight);
            draw_surface_stretched(_preStruct.__surface, 0, 0, _nextStruct.__width, _nextStruct.__height);
            surface_reset_target();
            --_i;
        }

        // 渲染状态恢复
        gpu_set_blendenable(_oldBlendEnable);
        gpu_set_tex_filter(_oldTexFilter);
        gpu_set_tex_repeat(_oldTexRepeat);
        shader_set(_oldShader);
        gpu_set_blendmode_ext(_oldBlendmodeSrc, _oldBlendmodeDest);
        matrix_set(matrix_world, _oldMatrixWorld);
    }

    // --- 内部辅助方法 ---
    static __CheckSurface = function(_struct) {
        if (__destroyed) return;

        var _width = _struct.__width;
        var _height = _struct.__height;
        var _surface = _struct.__surface;
        var _newSurface = false;

        if (!surface_exists(_surface)) {
            _surface = surface_create(_width, _height);
            _newSurface = true;
        }

        if ((surface_get_width(_surface) != _width) || (surface_get_height(_surface) != _height)) {
            surface_free(_surface);
            _surface = surface_create(_width, _height);
            _newSurface = true;
        }

        if (_newSurface) {
            _struct.__surface = _surface;
            var _texture = surface_get_texture(_surface);
            // 这里乘以 0.5 是因为 Kawase 算法采样点通常位于像素中心偏移处
            _struct.__texelWidth = 0.5 * texture_get_texel_width(_texture);
            _struct.__texelHeight = 0.5 * texture_get_texel_height(_texture);
        }

        return _surface;
    }
}