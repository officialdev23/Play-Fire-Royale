Shader "Particles/Multiply"
{
  Properties
  {
    _MainTex ("Particle Texture", 2D) = "white" {}
    _InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "PreviewType" = "Plane"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Blend Zero SrcColor
      GpuProgramID 35107
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
          attribute vec4 _glesColor;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_COLOR = _glesColor;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 col_1;
            mediump vec4 prev_2;
            lowp vec4 tmpvar_3;
            tmpvar_3 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
            prev_2 = tmpvar_3;
            mediump vec4 tmpvar_4;
            tmpvar_4 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_2, prev_2.wwww);
            col_1 = tmpvar_4;
            gl_FragData[0] = col_1;
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
          attribute vec4 _glesColor;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_COLOR = _glesColor;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 col_1;
            mediump vec4 prev_2;
            lowp vec4 tmpvar_3;
            tmpvar_3 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
            prev_2 = tmpvar_3;
            mediump vec4 tmpvar_4;
            tmpvar_4 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_2, prev_2.wwww);
            col_1 = tmpvar_4;
            gl_FragData[0] = col_1;
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
          attribute vec4 _glesColor;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_COLOR = _glesColor;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 col_1;
            mediump vec4 prev_2;
            lowp vec4 tmpvar_3;
            tmpvar_3 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
            prev_2 = tmpvar_3;
            mediump vec4 tmpvar_4;
            tmpvar_4 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_2, prev_2.wwww);
            col_1 = tmpvar_4;
            gl_FragData[0] = col_1;
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
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in mediump vec4 in_COLOR0;
          in highp vec2 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_COLOR0 = in_COLOR0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump float u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_0.w * vs_COLOR0.w;
              u_xlat16_0 = vs_COLOR0 * u_xlat10_0 + vec4(-1.0, -1.0, -1.0, -1.0);
              SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
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
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in mediump vec4 in_COLOR0;
          in highp vec2 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_COLOR0 = in_COLOR0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump float u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_0.w * vs_COLOR0.w;
              u_xlat16_0 = vs_COLOR0 * u_xlat10_0 + vec4(-1.0, -1.0, -1.0, -1.0);
              SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
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
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in mediump vec4 in_COLOR0;
          in highp vec2 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_COLOR0 = in_COLOR0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump float u_xlat16_1;
          void main()
          {
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_0.w * vs_COLOR0.w;
              u_xlat16_0 = vs_COLOR0 * u_xlat10_0 + vec4(-1.0, -1.0, -1.0, -1.0);
              SV_Target0 = vec4(u_xlat16_1) * u_xlat16_0 + vec4(1.0, 1.0, 1.0, 1.0);
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "SOFTPARTICLES_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesColor;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp vec4 _ProjectionParams;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1 = _glesVertex;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = tmpvar_1.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp vec4 o_5;
            highp vec4 tmpvar_6;
            tmpvar_6 = (tmpvar_3 * 0.5);
            highp vec2 tmpvar_7;
            tmpvar_7.x = tmpvar_6.x;
            tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
            o_5.xy = (tmpvar_7 + tmpvar_6.w);
            o_5.zw = tmpvar_3.zw;
            tmpvar_2.xyw = o_5.xyw;
            highp vec4 tmpvar_8;
            tmpvar_8.w = 1.0;
            tmpvar_8.xyz = tmpvar_1.xyz;
            tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
            gl_Position = tmpvar_3;
            xlv_COLOR = _glesColor;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD2 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _ZBufferParams;
          uniform sampler2D _MainTex;
          uniform highp sampler2D _CameraDepthTexture;
          uniform highp float _InvFade;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            lowp vec4 tmpvar_1;
            tmpvar_1.xyz = xlv_COLOR.xyz;
            lowp vec4 col_2;
            mediump vec4 prev_3;
            highp float tmpvar_4;
            tmpvar_4 = clamp ((_InvFade * (
              (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w)))
             - xlv_TEXCOORD2.z)), 0.0, 1.0);
            tmpvar_1.w = (xlv_COLOR.w * tmpvar_4);
            lowp vec4 tmpvar_5;
            tmpvar_5 = (tmpvar_1 * texture2D (_MainTex, xlv_TEXCOORD0));
            prev_3 = tmpvar_5;
            mediump vec4 tmpvar_6;
            tmpvar_6 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_3, prev_3.wwww);
            col_2 = tmpvar_6;
            gl_FragData[0] = col_2;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "SOFTPARTICLES_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesColor;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp vec4 _ProjectionParams;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1 = _glesVertex;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = tmpvar_1.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp vec4 o_5;
            highp vec4 tmpvar_6;
            tmpvar_6 = (tmpvar_3 * 0.5);
            highp vec2 tmpvar_7;
            tmpvar_7.x = tmpvar_6.x;
            tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
            o_5.xy = (tmpvar_7 + tmpvar_6.w);
            o_5.zw = tmpvar_3.zw;
            tmpvar_2.xyw = o_5.xyw;
            highp vec4 tmpvar_8;
            tmpvar_8.w = 1.0;
            tmpvar_8.xyz = tmpvar_1.xyz;
            tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
            gl_Position = tmpvar_3;
            xlv_COLOR = _glesColor;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD2 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _ZBufferParams;
          uniform sampler2D _MainTex;
          uniform highp sampler2D _CameraDepthTexture;
          uniform highp float _InvFade;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            lowp vec4 tmpvar_1;
            tmpvar_1.xyz = xlv_COLOR.xyz;
            lowp vec4 col_2;
            mediump vec4 prev_3;
            highp float tmpvar_4;
            tmpvar_4 = clamp ((_InvFade * (
              (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w)))
             - xlv_TEXCOORD2.z)), 0.0, 1.0);
            tmpvar_1.w = (xlv_COLOR.w * tmpvar_4);
            lowp vec4 tmpvar_5;
            tmpvar_5 = (tmpvar_1 * texture2D (_MainTex, xlv_TEXCOORD0));
            prev_3 = tmpvar_5;
            mediump vec4 tmpvar_6;
            tmpvar_6 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_3, prev_3.wwww);
            col_2 = tmpvar_6;
            gl_FragData[0] = col_2;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "SOFTPARTICLES_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesColor;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp vec4 _ProjectionParams;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1 = _glesVertex;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = tmpvar_1.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp vec4 o_5;
            highp vec4 tmpvar_6;
            tmpvar_6 = (tmpvar_3 * 0.5);
            highp vec2 tmpvar_7;
            tmpvar_7.x = tmpvar_6.x;
            tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
            o_5.xy = (tmpvar_7 + tmpvar_6.w);
            o_5.zw = tmpvar_3.zw;
            tmpvar_2.xyw = o_5.xyw;
            highp vec4 tmpvar_8;
            tmpvar_8.w = 1.0;
            tmpvar_8.xyz = tmpvar_1.xyz;
            tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
            gl_Position = tmpvar_3;
            xlv_COLOR = _glesColor;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD2 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _ZBufferParams;
          uniform sampler2D _MainTex;
          uniform highp sampler2D _CameraDepthTexture;
          uniform highp float _InvFade;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            lowp vec4 tmpvar_1;
            tmpvar_1.xyz = xlv_COLOR.xyz;
            lowp vec4 col_2;
            mediump vec4 prev_3;
            highp float tmpvar_4;
            tmpvar_4 = clamp ((_InvFade * (
              (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w)))
             - xlv_TEXCOORD2.z)), 0.0, 1.0);
            tmpvar_1.w = (xlv_COLOR.w * tmpvar_4);
            lowp vec4 tmpvar_5;
            tmpvar_5 = (tmpvar_1 * texture2D (_MainTex, xlv_TEXCOORD0));
            prev_3 = tmpvar_5;
            mediump vec4 tmpvar_6;
            tmpvar_6 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_3, prev_3.wwww);
            col_2 = tmpvar_6;
            gl_FragData[0] = col_2;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "SOFTPARTICLES_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _ProjectionParams;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in mediump vec4 in_COLOR0;
          in highp vec2 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec4 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat2;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              gl_Position = u_xlat1;
              vs_COLOR0 = in_COLOR0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
              vs_TEXCOORD2.z = (-u_xlat0.x);
              u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
              u_xlat0.w = u_xlat0.x * 0.5;
              u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
              vs_TEXCOORD2.w = u_xlat1.w;
              vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _ZBufferParams;
          uniform 	float _InvFade;
          uniform highp sampler2D _CameraDepthTexture;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec4 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          void main()
          {
              u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
              u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
              u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
              u_xlat0.x = float(1.0) / u_xlat0.x;
              u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
              u_xlat0.x = u_xlat0.x * _InvFade;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0.w = u_xlat0.x * u_xlat10_1.w;
              u_xlat0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
              u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
              SV_Target0 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "SOFTPARTICLES_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _ProjectionParams;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in mediump vec4 in_COLOR0;
          in highp vec2 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec4 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat2;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              gl_Position = u_xlat1;
              vs_COLOR0 = in_COLOR0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
              vs_TEXCOORD2.z = (-u_xlat0.x);
              u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
              u_xlat0.w = u_xlat0.x * 0.5;
              u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
              vs_TEXCOORD2.w = u_xlat1.w;
              vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _ZBufferParams;
          uniform 	float _InvFade;
          uniform highp sampler2D _CameraDepthTexture;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec4 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          void main()
          {
              u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
              u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
              u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
              u_xlat0.x = float(1.0) / u_xlat0.x;
              u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
              u_xlat0.x = u_xlat0.x * _InvFade;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0.w = u_xlat0.x * u_xlat10_1.w;
              u_xlat0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
              u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
              SV_Target0 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "SOFTPARTICLES_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _ProjectionParams;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in mediump vec4 in_COLOR0;
          in highp vec2 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec4 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat2;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              gl_Position = u_xlat1;
              vs_COLOR0 = in_COLOR0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
              vs_TEXCOORD2.z = (-u_xlat0.x);
              u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
              u_xlat0.w = u_xlat0.x * 0.5;
              u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
              vs_TEXCOORD2.w = u_xlat1.w;
              vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _ZBufferParams;
          uniform 	float _InvFade;
          uniform highp sampler2D _CameraDepthTexture;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec4 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          void main()
          {
              u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
              u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
              u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
              u_xlat0.x = float(1.0) / u_xlat0.x;
              u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
              u_xlat0.x = u_xlat0.x * _InvFade;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0.w = u_xlat0.x * u_xlat10_1.w;
              u_xlat0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
              u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
              SV_Target0 = u_xlat0.wwww * u_xlat16_1 + vec4(1.0, 1.0, 1.0, 1.0);
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesColor;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp float xlv_TEXCOORD1;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            gl_Position = tmpvar_1;
            xlv_COLOR = _glesColor;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp float xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 col_1;
            mediump vec4 prev_2;
            lowp vec4 tmpvar_3;
            tmpvar_3 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
            prev_2 = tmpvar_3;
            mediump vec4 tmpvar_4;
            tmpvar_4 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_2, prev_2.wwww);
            col_1 = tmpvar_4;
            highp float tmpvar_5;
            tmpvar_5 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
            col_1.xyz = mix (vec3(1.0, 1.0, 1.0), col_1.xyz, vec3(tmpvar_5));
            gl_FragData[0] = col_1;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesColor;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp float xlv_TEXCOORD1;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            gl_Position = tmpvar_1;
            xlv_COLOR = _glesColor;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp float xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 col_1;
            mediump vec4 prev_2;
            lowp vec4 tmpvar_3;
            tmpvar_3 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
            prev_2 = tmpvar_3;
            mediump vec4 tmpvar_4;
            tmpvar_4 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_2, prev_2.wwww);
            col_1 = tmpvar_4;
            highp float tmpvar_5;
            tmpvar_5 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
            col_1.xyz = mix (vec3(1.0, 1.0, 1.0), col_1.xyz, vec3(tmpvar_5));
            gl_FragData[0] = col_1;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesColor;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp float xlv_TEXCOORD1;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            gl_Position = tmpvar_1;
            xlv_COLOR = _glesColor;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp float xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 col_1;
            mediump vec4 prev_2;
            lowp vec4 tmpvar_3;
            tmpvar_3 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
            prev_2 = tmpvar_3;
            mediump vec4 tmpvar_4;
            tmpvar_4 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_2, prev_2.wwww);
            col_1 = tmpvar_4;
            highp float tmpvar_5;
            tmpvar_5 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
            col_1.xyz = mix (vec3(1.0, 1.0, 1.0), col_1.xyz, vec3(tmpvar_5));
            gl_FragData[0] = col_1;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in mediump vec4 in_COLOR0;
          in highp vec2 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD1;
          vec4 u_xlat0;
          vec4 u_xlat1;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              gl_Position = u_xlat0;
              vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_COLOR0 = in_COLOR0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec3 u_xlat0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump float u_xlat16_3;
          void main()
          {
              u_xlat0.x = vs_TEXCOORD1;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_3 = u_xlat10_1.w * vs_COLOR0.w;
              u_xlat16_1 = vs_COLOR0 * u_xlat10_1 + vec4(-1.0, -1.0, -1.0, -1.0);
              u_xlat16_2.xyz = vec3(u_xlat16_3) * u_xlat16_1.xyz;
              SV_Target0.w = u_xlat16_3 * u_xlat16_1.w + 1.0;
              u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
              SV_Target0.xyz = u_xlat0.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in mediump vec4 in_COLOR0;
          in highp vec2 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD1;
          vec4 u_xlat0;
          vec4 u_xlat1;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              gl_Position = u_xlat0;
              vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_COLOR0 = in_COLOR0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec3 u_xlat0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump float u_xlat16_3;
          void main()
          {
              u_xlat0.x = vs_TEXCOORD1;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_3 = u_xlat10_1.w * vs_COLOR0.w;
              u_xlat16_1 = vs_COLOR0 * u_xlat10_1 + vec4(-1.0, -1.0, -1.0, -1.0);
              u_xlat16_2.xyz = vec3(u_xlat16_3) * u_xlat16_1.xyz;
              SV_Target0.w = u_xlat16_3 * u_xlat16_1.w + 1.0;
              u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
              SV_Target0.xyz = u_xlat0.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in mediump vec4 in_COLOR0;
          in highp vec2 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD1;
          vec4 u_xlat0;
          vec4 u_xlat1;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              gl_Position = u_xlat0;
              vs_TEXCOORD1 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_COLOR0 = in_COLOR0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec3 u_xlat0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump float u_xlat16_3;
          void main()
          {
              u_xlat0.x = vs_TEXCOORD1;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_3 = u_xlat10_1.w * vs_COLOR0.w;
              u_xlat16_1 = vs_COLOR0 * u_xlat10_1 + vec4(-1.0, -1.0, -1.0, -1.0);
              u_xlat16_2.xyz = vec3(u_xlat16_3) * u_xlat16_1.xyz;
              SV_Target0.w = u_xlat16_3 * u_xlat16_1.w + 1.0;
              u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
              SV_Target0.xyz = u_xlat0.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesColor;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp vec4 _ProjectionParams;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp float xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1 = _glesVertex;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = tmpvar_1.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp vec4 o_5;
            highp vec4 tmpvar_6;
            tmpvar_6 = (tmpvar_3 * 0.5);
            highp vec2 tmpvar_7;
            tmpvar_7.x = tmpvar_6.x;
            tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
            o_5.xy = (tmpvar_7 + tmpvar_6.w);
            o_5.zw = tmpvar_3.zw;
            tmpvar_2.xyw = o_5.xyw;
            highp vec4 tmpvar_8;
            tmpvar_8.w = 1.0;
            tmpvar_8.xyz = tmpvar_1.xyz;
            tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
            gl_Position = tmpvar_3;
            xlv_COLOR = _glesColor;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            xlv_TEXCOORD2 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _ZBufferParams;
          uniform sampler2D _MainTex;
          uniform highp sampler2D _CameraDepthTexture;
          uniform highp float _InvFade;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp float xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            lowp vec4 tmpvar_1;
            tmpvar_1.xyz = xlv_COLOR.xyz;
            lowp vec4 col_2;
            mediump vec4 prev_3;
            highp float tmpvar_4;
            tmpvar_4 = clamp ((_InvFade * (
              (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w)))
             - xlv_TEXCOORD2.z)), 0.0, 1.0);
            tmpvar_1.w = (xlv_COLOR.w * tmpvar_4);
            lowp vec4 tmpvar_5;
            tmpvar_5 = (tmpvar_1 * texture2D (_MainTex, xlv_TEXCOORD0));
            prev_3 = tmpvar_5;
            mediump vec4 tmpvar_6;
            tmpvar_6 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_3, prev_3.wwww);
            col_2 = tmpvar_6;
            highp float tmpvar_7;
            tmpvar_7 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
            col_2.xyz = mix (vec3(1.0, 1.0, 1.0), col_2.xyz, vec3(tmpvar_7));
            gl_FragData[0] = col_2;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesColor;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp vec4 _ProjectionParams;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp float xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1 = _glesVertex;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = tmpvar_1.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp vec4 o_5;
            highp vec4 tmpvar_6;
            tmpvar_6 = (tmpvar_3 * 0.5);
            highp vec2 tmpvar_7;
            tmpvar_7.x = tmpvar_6.x;
            tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
            o_5.xy = (tmpvar_7 + tmpvar_6.w);
            o_5.zw = tmpvar_3.zw;
            tmpvar_2.xyw = o_5.xyw;
            highp vec4 tmpvar_8;
            tmpvar_8.w = 1.0;
            tmpvar_8.xyz = tmpvar_1.xyz;
            tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
            gl_Position = tmpvar_3;
            xlv_COLOR = _glesColor;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            xlv_TEXCOORD2 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _ZBufferParams;
          uniform sampler2D _MainTex;
          uniform highp sampler2D _CameraDepthTexture;
          uniform highp float _InvFade;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp float xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            lowp vec4 tmpvar_1;
            tmpvar_1.xyz = xlv_COLOR.xyz;
            lowp vec4 col_2;
            mediump vec4 prev_3;
            highp float tmpvar_4;
            tmpvar_4 = clamp ((_InvFade * (
              (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w)))
             - xlv_TEXCOORD2.z)), 0.0, 1.0);
            tmpvar_1.w = (xlv_COLOR.w * tmpvar_4);
            lowp vec4 tmpvar_5;
            tmpvar_5 = (tmpvar_1 * texture2D (_MainTex, xlv_TEXCOORD0));
            prev_3 = tmpvar_5;
            mediump vec4 tmpvar_6;
            tmpvar_6 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_3, prev_3.wwww);
            col_2 = tmpvar_6;
            highp float tmpvar_7;
            tmpvar_7 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
            col_2.xyz = mix (vec3(1.0, 1.0, 1.0), col_2.xyz, vec3(tmpvar_7));
            gl_FragData[0] = col_2;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec4 _glesColor;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp vec4 _ProjectionParams;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp float xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1 = _glesVertex;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = tmpvar_1.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp vec4 o_5;
            highp vec4 tmpvar_6;
            tmpvar_6 = (tmpvar_3 * 0.5);
            highp vec2 tmpvar_7;
            tmpvar_7.x = tmpvar_6.x;
            tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
            o_5.xy = (tmpvar_7 + tmpvar_6.w);
            o_5.zw = tmpvar_3.zw;
            tmpvar_2.xyw = o_5.xyw;
            highp vec4 tmpvar_8;
            tmpvar_8.w = 1.0;
            tmpvar_8.xyz = tmpvar_1.xyz;
            tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
            gl_Position = tmpvar_3;
            xlv_COLOR = _glesColor;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            xlv_TEXCOORD2 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _ZBufferParams;
          uniform sampler2D _MainTex;
          uniform highp sampler2D _CameraDepthTexture;
          uniform highp float _InvFade;
          varying lowp vec4 xlv_COLOR;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp float xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            lowp vec4 tmpvar_1;
            tmpvar_1.xyz = xlv_COLOR.xyz;
            lowp vec4 col_2;
            mediump vec4 prev_3;
            highp float tmpvar_4;
            tmpvar_4 = clamp ((_InvFade * (
              (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD2).x) + _ZBufferParams.w)))
             - xlv_TEXCOORD2.z)), 0.0, 1.0);
            tmpvar_1.w = (xlv_COLOR.w * tmpvar_4);
            lowp vec4 tmpvar_5;
            tmpvar_5 = (tmpvar_1 * texture2D (_MainTex, xlv_TEXCOORD0));
            prev_3 = tmpvar_5;
            mediump vec4 tmpvar_6;
            tmpvar_6 = mix (vec4(1.0, 1.0, 1.0, 1.0), prev_3, prev_3.wwww);
            col_2 = tmpvar_6;
            highp float tmpvar_7;
            tmpvar_7 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
            col_2.xyz = mix (vec3(1.0, 1.0, 1.0), col_2.xyz, vec3(tmpvar_7));
            gl_FragData[0] = col_2;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _ProjectionParams;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in mediump vec4 in_COLOR0;
          in highp vec2 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD1;
          out highp vec4 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat2;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              gl_Position = u_xlat1;
              vs_COLOR0 = in_COLOR0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
              vs_TEXCOORD2.z = (-u_xlat0.x);
              u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
              u_xlat0.w = u_xlat0.x * 0.5;
              u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
              vs_TEXCOORD2.w = u_xlat1.w;
              vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _ZBufferParams;
          uniform 	float _InvFade;
          uniform highp sampler2D _CameraDepthTexture;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          void main()
          {
              u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
              u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
              u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
              u_xlat0.x = float(1.0) / u_xlat0.x;
              u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
              u_xlat0.x = u_xlat0.x * _InvFade;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0.w = u_xlat0.x * u_xlat10_1.w;
              u_xlat0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
              u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
              u_xlat16_2.xyz = u_xlat0.www * u_xlat16_1.xyz;
              SV_Target0.w = u_xlat0.w * u_xlat16_1.w + 1.0;
              u_xlat0.x = vs_TEXCOORD1;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
              SV_Target0.xyz = u_xlat0.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _ProjectionParams;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in mediump vec4 in_COLOR0;
          in highp vec2 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD1;
          out highp vec4 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat2;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              gl_Position = u_xlat1;
              vs_COLOR0 = in_COLOR0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
              vs_TEXCOORD2.z = (-u_xlat0.x);
              u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
              u_xlat0.w = u_xlat0.x * 0.5;
              u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
              vs_TEXCOORD2.w = u_xlat1.w;
              vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _ZBufferParams;
          uniform 	float _InvFade;
          uniform highp sampler2D _CameraDepthTexture;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          void main()
          {
              u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
              u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
              u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
              u_xlat0.x = float(1.0) / u_xlat0.x;
              u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
              u_xlat0.x = u_xlat0.x * _InvFade;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0.w = u_xlat0.x * u_xlat10_1.w;
              u_xlat0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
              u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
              u_xlat16_2.xyz = u_xlat0.www * u_xlat16_1.xyz;
              SV_Target0.w = u_xlat0.w * u_xlat16_1.w + 1.0;
              u_xlat0.x = vs_TEXCOORD1;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
              SV_Target0.xyz = u_xlat0.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _ProjectionParams;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in mediump vec4 in_COLOR0;
          in highp vec2 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD1;
          out highp vec4 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat2;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              gl_Position = u_xlat1;
              vs_COLOR0 = in_COLOR0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              vs_TEXCOORD1 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              u_xlat2 = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
              u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
              vs_TEXCOORD2.z = (-u_xlat0.x);
              u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
              u_xlat0.w = u_xlat0.x * 0.5;
              u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
              vs_TEXCOORD2.w = u_xlat1.w;
              vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _ZBufferParams;
          uniform 	float _InvFade;
          uniform highp sampler2D _CameraDepthTexture;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          void main()
          {
              u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
              u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
              u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
              u_xlat0.x = float(1.0) / u_xlat0.x;
              u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
              u_xlat0.x = u_xlat0.x * _InvFade;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0.w = u_xlat0.x * u_xlat10_1.w;
              u_xlat0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
              u_xlat16_1 = u_xlat0 + vec4(-1.0, -1.0, -1.0, -1.0);
              u_xlat16_2.xyz = u_xlat0.www * u_xlat16_1.xyz;
              SV_Target0.w = u_xlat0.w * u_xlat16_1.w + 1.0;
              u_xlat0.x = vs_TEXCOORD1;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat0.xxx * u_xlat16_2.xyz + vec3(1.0, 1.0, 1.0);
              SV_Target0.xyz = u_xlat0.xyz;
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
        SubProgram "gles hw_tier00"
        {
           Keywords { "SOFTPARTICLES_ON" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "SOFTPARTICLES_ON" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "SOFTPARTICLES_ON" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "SOFTPARTICLES_ON" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "SOFTPARTICLES_ON" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "SOFTPARTICLES_ON" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "FOG_LINEAR" "SOFTPARTICLES_ON" }
          
          "!!!!GLES3
          
          
          "
        }
      }
      
    } // end phase
  }
  FallBack ""
}
