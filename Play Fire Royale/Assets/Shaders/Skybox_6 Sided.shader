Shader "Skybox/6 Sided"
{
  Properties
  {
    _Tint ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
    [Gamma] _Exposure ("Exposure", Range(0, 8)) = 1
    _Rotation ("Rotation", Range(0, 360)) = 0
    [NoScaleOffset] _FrontTex ("Front [+Z]   (HDR)", 2D) = "grey" {}
    [NoScaleOffset] _BackTex ("Back [-Z]   (HDR)", 2D) = "grey" {}
    [NoScaleOffset] _LeftTex ("Left [+X]   (HDR)", 2D) = "grey" {}
    [NoScaleOffset] _RightTex ("Right [-X]   (HDR)", 2D) = "grey" {}
    [NoScaleOffset] _UpTex ("Up [+Y]   (HDR)", 2D) = "grey" {}
    [NoScaleOffset] _DownTex ("Down [-Y]   (HDR)", 2D) = "grey" {}
  }
  SubShader
  {
    Tags
    { 
      "PreviewType" = "Skybox"
      "QUEUE" = "Background"
      "RenderType" = "Background"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "PreviewType" = "Skybox"
        "QUEUE" = "Background"
        "RenderType" = "Background"
      }
      ZWrite Off
      Cull Off
      GpuProgramID 17018
      // m_ProgramMask = 6
      !!! *******************************************************************************************
      !!! Allow restore shader as UnityLab format - only available for DevX GameRecovery license type
      !!! *******************************************************************************************
      Program "vp"
      {
        SubProgram "gles hw_tier00"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _FrontTex;
          uniform mediump vec4 _FrontTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_FrontTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_FrontTex_HDR.x * ((_FrontTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _FrontTex;
          uniform mediump vec4 _FrontTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_FrontTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_FrontTex_HDR.x * ((_FrontTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _FrontTex;
          uniform mediump vec4 _FrontTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_FrontTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_FrontTex_HDR.x * ((_FrontTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _FrontTex_HDR;
          uniform lowp sampler2D _FrontTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_FrontTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _FrontTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _FrontTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _FrontTex_HDR;
          uniform lowp sampler2D _FrontTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_FrontTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _FrontTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _FrontTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _FrontTex_HDR;
          uniform lowp sampler2D _FrontTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_FrontTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _FrontTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _FrontTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
      }
      Program "fp"
      {
        SubProgram "gles hw_tier00"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
          
          "!!!!GLES3
          
          
          "
        }
      }
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "PreviewType" = "Skybox"
        "QUEUE" = "Background"
        "RenderType" = "Background"
      }
      ZWrite Off
      Cull Off
      GpuProgramID 94593
      // m_ProgramMask = 6
      !!! *******************************************************************************************
      !!! Allow restore shader as UnityLab format - only available for DevX GameRecovery license type
      !!! *******************************************************************************************
      Program "vp"
      {
        SubProgram "gles hw_tier00"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _BackTex;
          uniform mediump vec4 _BackTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_BackTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_BackTex_HDR.x * ((_BackTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _BackTex;
          uniform mediump vec4 _BackTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_BackTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_BackTex_HDR.x * ((_BackTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _BackTex;
          uniform mediump vec4 _BackTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_BackTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_BackTex_HDR.x * ((_BackTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _BackTex_HDR;
          uniform lowp sampler2D _BackTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_BackTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _BackTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _BackTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _BackTex_HDR;
          uniform lowp sampler2D _BackTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_BackTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _BackTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _BackTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _BackTex_HDR;
          uniform lowp sampler2D _BackTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_BackTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _BackTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _BackTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
      }
      Program "fp"
      {
        SubProgram "gles hw_tier00"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
          
          "!!!!GLES3
          
          
          "
        }
      }
      
    } // end phase
    Pass // ind: 3, name: 
    {
      Tags
      { 
        "PreviewType" = "Skybox"
        "QUEUE" = "Background"
        "RenderType" = "Background"
      }
      ZWrite Off
      Cull Off
      GpuProgramID 181541
      // m_ProgramMask = 6
      !!! *******************************************************************************************
      !!! Allow restore shader as UnityLab format - only available for DevX GameRecovery license type
      !!! *******************************************************************************************
      Program "vp"
      {
        SubProgram "gles hw_tier00"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _LeftTex;
          uniform mediump vec4 _LeftTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_LeftTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_LeftTex_HDR.x * ((_LeftTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _LeftTex;
          uniform mediump vec4 _LeftTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_LeftTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_LeftTex_HDR.x * ((_LeftTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _LeftTex;
          uniform mediump vec4 _LeftTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_LeftTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_LeftTex_HDR.x * ((_LeftTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _LeftTex_HDR;
          uniform lowp sampler2D _LeftTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_LeftTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _LeftTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _LeftTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _LeftTex_HDR;
          uniform lowp sampler2D _LeftTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_LeftTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _LeftTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _LeftTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _LeftTex_HDR;
          uniform lowp sampler2D _LeftTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_LeftTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _LeftTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _LeftTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
      }
      Program "fp"
      {
        SubProgram "gles hw_tier00"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
          
          "!!!!GLES3
          
          
          "
        }
      }
      
    } // end phase
    Pass // ind: 4, name: 
    {
      Tags
      { 
        "PreviewType" = "Skybox"
        "QUEUE" = "Background"
        "RenderType" = "Background"
      }
      ZWrite Off
      Cull Off
      GpuProgramID 247415
      // m_ProgramMask = 6
      !!! *******************************************************************************************
      !!! Allow restore shader as UnityLab format - only available for DevX GameRecovery license type
      !!! *******************************************************************************************
      Program "vp"
      {
        SubProgram "gles hw_tier00"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _RightTex;
          uniform mediump vec4 _RightTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_RightTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_RightTex_HDR.x * ((_RightTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _RightTex;
          uniform mediump vec4 _RightTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_RightTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_RightTex_HDR.x * ((_RightTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _RightTex;
          uniform mediump vec4 _RightTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_RightTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_RightTex_HDR.x * ((_RightTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _RightTex_HDR;
          uniform lowp sampler2D _RightTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_RightTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _RightTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _RightTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _RightTex_HDR;
          uniform lowp sampler2D _RightTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_RightTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _RightTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _RightTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _RightTex_HDR;
          uniform lowp sampler2D _RightTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_RightTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _RightTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _RightTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
      }
      Program "fp"
      {
        SubProgram "gles hw_tier00"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
          
          "!!!!GLES3
          
          
          "
        }
      }
      
    } // end phase
    Pass // ind: 5, name: 
    {
      Tags
      { 
        "PreviewType" = "Skybox"
        "QUEUE" = "Background"
        "RenderType" = "Background"
      }
      ZWrite Off
      Cull Off
      GpuProgramID 296784
      // m_ProgramMask = 6
      !!! *******************************************************************************************
      !!! Allow restore shader as UnityLab format - only available for DevX GameRecovery license type
      !!! *******************************************************************************************
      Program "vp"
      {
        SubProgram "gles hw_tier00"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _UpTex;
          uniform mediump vec4 _UpTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_UpTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_UpTex_HDR.x * ((_UpTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _UpTex;
          uniform mediump vec4 _UpTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_UpTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_UpTex_HDR.x * ((_UpTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _UpTex;
          uniform mediump vec4 _UpTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_UpTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_UpTex_HDR.x * ((_UpTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _UpTex_HDR;
          uniform lowp sampler2D _UpTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_UpTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _UpTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _UpTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _UpTex_HDR;
          uniform lowp sampler2D _UpTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_UpTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _UpTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _UpTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _UpTex_HDR;
          uniform lowp sampler2D _UpTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_UpTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _UpTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _UpTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
      }
      Program "fp"
      {
        SubProgram "gles hw_tier00"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
          
          "!!!!GLES3
          
          
          "
        }
      }
      
    } // end phase
    Pass // ind: 6, name: 
    {
      Tags
      { 
        "PreviewType" = "Skybox"
        "QUEUE" = "Background"
        "RenderType" = "Background"
      }
      ZWrite Off
      Cull Off
      GpuProgramID 331681
      // m_ProgramMask = 6
      !!! *******************************************************************************************
      !!! Allow restore shader as UnityLab format - only available for DevX GameRecovery license type
      !!! *******************************************************************************************
      Program "vp"
      {
        SubProgram "gles hw_tier00"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _DownTex;
          uniform mediump vec4 _DownTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_DownTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_DownTex_HDR.x * ((_DownTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _DownTex;
          uniform mediump vec4 _DownTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_DownTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_DownTex_HDR.x * ((_DownTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp float _Rotation;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp float tmpvar_1;
            tmpvar_1 = ((_Rotation * 3.141593) / 180.0);
            highp float tmpvar_2;
            tmpvar_2 = sin(tmpvar_1);
            highp float tmpvar_3;
            tmpvar_3 = cos(tmpvar_1);
            highp mat2 tmpvar_4;
            tmpvar_4[0].x = tmpvar_3;
            tmpvar_4[0].y = tmpvar_2;
            tmpvar_4[1].x = -(tmpvar_2);
            tmpvar_4[1].y = tmpvar_3;
            highp vec3 tmpvar_5;
            tmpvar_5.xy = (tmpvar_4 * _glesVertex.xz);
            tmpvar_5.z = _glesVertex.y;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_5.xzy;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
            xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _Tint;
          uniform mediump float _Exposure;
          uniform sampler2D _DownTex;
          uniform mediump vec4 _DownTex_HDR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            mediump vec3 c_1;
            lowp vec4 tmpvar_2;
            tmpvar_2 = texture2D (_DownTex, xlv_TEXCOORD0);
            mediump vec4 tmpvar_3;
            tmpvar_3 = tmpvar_2;
            c_1 = (((
              (_DownTex_HDR.x * ((_DownTex_HDR.w * (tmpvar_3.w - 1.0)) + 1.0))
             * tmpvar_3.xyz) * _Tint.xyz) * vec3(2.0, 2.0, 2.0));
            c_1 = (c_1 * _Exposure);
            mediump vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = c_1;
            gl_FragData[0] = tmpvar_4;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _DownTex_HDR;
          uniform lowp sampler2D _DownTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_DownTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _DownTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _DownTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _DownTex_HDR;
          uniform lowp sampler2D _DownTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_DownTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _DownTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _DownTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	float _Rotation;
          in highp vec4 in_POSITION0;
          in highp vec2 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec3 u_xlat2;
          float u_xlat3;
          void main()
          {
              u_xlat0.x = _Rotation * 0.0174532942;
              u_xlat1.x = cos(u_xlat0.x);
              u_xlat0.x = sin(u_xlat0.x);
              u_xlat2.x = (-u_xlat0.x);
              u_xlat2.y = u_xlat1.x;
              u_xlat2.z = u_xlat0.x;
              u_xlat0.x = dot(u_xlat2.zy, in_POSITION0.xz);
              u_xlat3 = dot(u_xlat2.yx, in_POSITION0.xz);
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * vec4(u_xlat3) + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Tint;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec4 _DownTex_HDR;
          uniform lowp sampler2D _DownTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_DownTex, vs_TEXCOORD0.xy);
              u_xlat16_1.x = u_xlat10_0.w + -1.0;
              u_xlat16_1.x = _DownTex_HDR.w * u_xlat16_1.x + 1.0;
              u_xlat16_1.x = u_xlat16_1.x * _DownTex_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = u_xlat16_1.xyz * _Tint.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(_Exposure);
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
      }
      Program "fp"
      {
        SubProgram "gles hw_tier00"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
          
          "!!!!GLES3
          
          
          "
        }
      }
      
    } // end phase
  }
  FallBack ""
}
