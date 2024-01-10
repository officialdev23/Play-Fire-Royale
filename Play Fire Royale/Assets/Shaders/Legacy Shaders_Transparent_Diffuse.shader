Shader "Legacy Shaders/Transparent/Diffuse"
{
  Properties
  {
    _Color ("Main Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    LOD 200
    Pass // ind: 1, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "FORWARDBASE"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 200
      ZWrite Off
      Blend SrcAlpha OneMinusSrcAlpha
      ColorMask  -1
      GpuProgramID 47968
      // m_ProgramMask = 6
      !!! *******************************************************************************************
      !!! Allow restore shader as UnityLab format - only available for DevX GameRecovery license type
      !!! *******************************************************************************************
      Program "vp"
      {
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            xlv_TEXCOORD2 = tmpvar_1;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            lowp vec4 c_7;
            lowp vec4 c_8;
            lowp float diff_9;
            mediump float tmpvar_10;
            tmpvar_10 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_9 = tmpvar_10;
            c_8.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_9);
            c_8.w = tmpvar_6.w;
            c_7.w = c_8.w;
            c_7.xyz = c_8.xyz;
            gl_FragData[0] = c_7;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            xlv_TEXCOORD2 = tmpvar_1;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            lowp vec4 c_7;
            lowp vec4 c_8;
            lowp float diff_9;
            mediump float tmpvar_10;
            tmpvar_10 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_9 = tmpvar_10;
            c_8.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_9);
            c_8.w = tmpvar_6.w;
            c_7.w = c_8.w;
            c_7.xyz = c_8.xyz;
            gl_FragData[0] = c_7;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            xlv_TEXCOORD2 = tmpvar_1;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            lowp vec4 c_7;
            lowp vec4 c_8;
            lowp float diff_9;
            mediump float tmpvar_10;
            tmpvar_10 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_9 = tmpvar_10;
            c_8.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_9);
            c_8.w = tmpvar_6.w;
            c_7.w = c_8.w;
            c_7.xyz = c_8.xyz;
            gl_FragData[0] = c_7;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform mediump vec4 unity_SHAr;
          uniform mediump vec4 unity_SHAg;
          uniform mediump vec4 unity_SHAb;
          uniform mediump vec4 unity_SHBr;
          uniform mediump vec4 unity_SHBg;
          uniform mediump vec4 unity_SHBb;
          uniform mediump vec4 unity_SHC;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            highp vec3 tmpvar_4;
            tmpvar_4 = normalize((_glesNormal * tmpvar_3));
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            mediump vec3 normal_5;
            normal_5 = tmpvar_4;
            mediump vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = normal_5;
            mediump vec3 res_7;
            mediump vec3 x_8;
            x_8.x = dot (unity_SHAr, tmpvar_6);
            x_8.y = dot (unity_SHAg, tmpvar_6);
            x_8.z = dot (unity_SHAb, tmpvar_6);
            mediump vec3 x1_9;
            mediump vec4 tmpvar_10;
            tmpvar_10 = (normal_5.xyzz * normal_5.yzzx);
            x1_9.x = dot (unity_SHBr, tmpvar_10);
            x1_9.y = dot (unity_SHBg, tmpvar_10);
            x1_9.z = dot (unity_SHBb, tmpvar_10);
            res_7 = (x_8 + (x1_9 + (unity_SHC.xyz * 
              ((normal_5.x * normal_5.x) - (normal_5.y * normal_5.y))
            )));
            mediump vec3 tmpvar_11;
            tmpvar_11 = max (((1.055 * 
              pow (max (res_7, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
            ) - 0.055), vec3(0.0, 0.0, 0.0));
            res_7 = tmpvar_11;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_4;
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_11);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            lowp vec4 c_7;
            lowp vec4 c_8;
            lowp float diff_9;
            mediump float tmpvar_10;
            tmpvar_10 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_9 = tmpvar_10;
            c_8.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_9);
            c_8.w = tmpvar_6.w;
            c_7.w = c_8.w;
            c_7.xyz = (c_8.xyz + (tmpvar_6.xyz * xlv_TEXCOORD3));
            gl_FragData[0] = c_7;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform mediump vec4 unity_SHAr;
          uniform mediump vec4 unity_SHAg;
          uniform mediump vec4 unity_SHAb;
          uniform mediump vec4 unity_SHBr;
          uniform mediump vec4 unity_SHBg;
          uniform mediump vec4 unity_SHBb;
          uniform mediump vec4 unity_SHC;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            highp vec3 tmpvar_4;
            tmpvar_4 = normalize((_glesNormal * tmpvar_3));
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            mediump vec3 normal_5;
            normal_5 = tmpvar_4;
            mediump vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = normal_5;
            mediump vec3 res_7;
            mediump vec3 x_8;
            x_8.x = dot (unity_SHAr, tmpvar_6);
            x_8.y = dot (unity_SHAg, tmpvar_6);
            x_8.z = dot (unity_SHAb, tmpvar_6);
            mediump vec3 x1_9;
            mediump vec4 tmpvar_10;
            tmpvar_10 = (normal_5.xyzz * normal_5.yzzx);
            x1_9.x = dot (unity_SHBr, tmpvar_10);
            x1_9.y = dot (unity_SHBg, tmpvar_10);
            x1_9.z = dot (unity_SHBb, tmpvar_10);
            res_7 = (x_8 + (x1_9 + (unity_SHC.xyz * 
              ((normal_5.x * normal_5.x) - (normal_5.y * normal_5.y))
            )));
            mediump vec3 tmpvar_11;
            tmpvar_11 = max (((1.055 * 
              pow (max (res_7, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
            ) - 0.055), vec3(0.0, 0.0, 0.0));
            res_7 = tmpvar_11;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_4;
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_11);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            lowp vec4 c_7;
            lowp vec4 c_8;
            lowp float diff_9;
            mediump float tmpvar_10;
            tmpvar_10 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_9 = tmpvar_10;
            c_8.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_9);
            c_8.w = tmpvar_6.w;
            c_7.w = c_8.w;
            c_7.xyz = (c_8.xyz + (tmpvar_6.xyz * xlv_TEXCOORD3));
            gl_FragData[0] = c_7;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform mediump vec4 unity_SHAr;
          uniform mediump vec4 unity_SHAg;
          uniform mediump vec4 unity_SHAb;
          uniform mediump vec4 unity_SHBr;
          uniform mediump vec4 unity_SHBg;
          uniform mediump vec4 unity_SHBb;
          uniform mediump vec4 unity_SHC;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            highp vec3 tmpvar_4;
            tmpvar_4 = normalize((_glesNormal * tmpvar_3));
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            mediump vec3 normal_5;
            normal_5 = tmpvar_4;
            mediump vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = normal_5;
            mediump vec3 res_7;
            mediump vec3 x_8;
            x_8.x = dot (unity_SHAr, tmpvar_6);
            x_8.y = dot (unity_SHAg, tmpvar_6);
            x_8.z = dot (unity_SHAb, tmpvar_6);
            mediump vec3 x1_9;
            mediump vec4 tmpvar_10;
            tmpvar_10 = (normal_5.xyzz * normal_5.yzzx);
            x1_9.x = dot (unity_SHBr, tmpvar_10);
            x1_9.y = dot (unity_SHBg, tmpvar_10);
            x1_9.z = dot (unity_SHBb, tmpvar_10);
            res_7 = (x_8 + (x1_9 + (unity_SHC.xyz * 
              ((normal_5.x * normal_5.x) - (normal_5.y * normal_5.y))
            )));
            mediump vec3 tmpvar_11;
            tmpvar_11 = max (((1.055 * 
              pow (max (res_7, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
            ) - 0.055), vec3(0.0, 0.0, 0.0));
            res_7 = tmpvar_11;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_4;
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_11);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            lowp vec4 c_7;
            lowp vec4 c_8;
            lowp float diff_9;
            mediump float tmpvar_10;
            tmpvar_10 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_9 = tmpvar_10;
            c_8.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_9);
            c_8.w = tmpvar_6.w;
            c_7.w = c_8.w;
            c_7.xyz = (c_8.xyz + (tmpvar_6.xyz * xlv_TEXCOORD3));
            gl_FragData[0] = c_7;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	mediump vec4 unity_SHAr;
          uniform 	mediump vec4 unity_SHAg;
          uniform 	mediump vec4 unity_SHAb;
          uniform 	mediump vec4 unity_SHBr;
          uniform 	mediump vec4 unity_SHBg;
          uniform 	mediump vec4 unity_SHBb;
          uniform 	mediump vec4 unity_SHC;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          mediump vec4 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat12;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat12 = inversesqrt(u_xlat12);
              u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
              vs_TEXCOORD1.xyz = u_xlat0.xyz;
              u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
              u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
              u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
              u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
              u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
              u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
              u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
              u_xlat0.w = 1.0;
              u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
              u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
              u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
              u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
              u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
              u_xlat0.xyz = log2(u_xlat16_2.xyz);
              u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
              u_xlat0.xyz = exp2(u_xlat0.xyz);
              u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
              u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
              vs_TEXCOORD3.xyz = u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_3.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_0) + u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	mediump vec4 unity_SHAr;
          uniform 	mediump vec4 unity_SHAg;
          uniform 	mediump vec4 unity_SHAb;
          uniform 	mediump vec4 unity_SHBr;
          uniform 	mediump vec4 unity_SHBg;
          uniform 	mediump vec4 unity_SHBb;
          uniform 	mediump vec4 unity_SHC;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          mediump vec4 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat12;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat12 = inversesqrt(u_xlat12);
              u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
              vs_TEXCOORD1.xyz = u_xlat0.xyz;
              u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
              u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
              u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
              u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
              u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
              u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
              u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
              u_xlat0.w = 1.0;
              u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
              u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
              u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
              u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
              u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
              u_xlat0.xyz = log2(u_xlat16_2.xyz);
              u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
              u_xlat0.xyz = exp2(u_xlat0.xyz);
              u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
              u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
              vs_TEXCOORD3.xyz = u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_3.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_0) + u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	mediump vec4 unity_SHAr;
          uniform 	mediump vec4 unity_SHAg;
          uniform 	mediump vec4 unity_SHAb;
          uniform 	mediump vec4 unity_SHBr;
          uniform 	mediump vec4 unity_SHBg;
          uniform 	mediump vec4 unity_SHBb;
          uniform 	mediump vec4 unity_SHC;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          mediump vec4 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat12;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat12 = inversesqrt(u_xlat12);
              u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
              vs_TEXCOORD1.xyz = u_xlat0.xyz;
              u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
              u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
              u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
              u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
              u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
              u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
              u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
              u_xlat0.w = 1.0;
              u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
              u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
              u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
              u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
              u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
              u_xlat0.xyz = log2(u_xlat16_2.xyz);
              u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
              u_xlat0.xyz = exp2(u_xlat0.xyz);
              u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
              u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
              vs_TEXCOORD3.xyz = u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_3.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_0) + u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform sampler2D unity_DynamicLightmap;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            mediump vec3 tmpvar_7;
            lowp vec4 tmpvar_8;
            tmpvar_8 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            tmpvar_7 = pow (((unity_DynamicLightmap_HDR.x * tmpvar_8.w) * tmpvar_8.xyz), unity_DynamicLightmap_HDR.yyy);
            lowp vec4 c_9;
            lowp vec4 c_10;
            lowp float diff_11;
            mediump float tmpvar_12;
            tmpvar_12 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_11 = tmpvar_12;
            c_10.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_11);
            c_10.w = tmpvar_6.w;
            c_9.w = c_10.w;
            c_9.xyz = (c_10.xyz + (tmpvar_6.xyz * tmpvar_7));
            gl_FragData[0] = c_9;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform sampler2D unity_DynamicLightmap;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            mediump vec3 tmpvar_7;
            lowp vec4 tmpvar_8;
            tmpvar_8 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            tmpvar_7 = pow (((unity_DynamicLightmap_HDR.x * tmpvar_8.w) * tmpvar_8.xyz), unity_DynamicLightmap_HDR.yyy);
            lowp vec4 c_9;
            lowp vec4 c_10;
            lowp float diff_11;
            mediump float tmpvar_12;
            tmpvar_12 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_11 = tmpvar_12;
            c_10.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_11);
            c_10.w = tmpvar_6.w;
            c_9.w = c_10.w;
            c_9.xyz = (c_10.xyz + (tmpvar_6.xyz * tmpvar_7));
            gl_FragData[0] = c_9;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform sampler2D unity_DynamicLightmap;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            mediump vec3 tmpvar_7;
            lowp vec4 tmpvar_8;
            tmpvar_8 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            tmpvar_7 = pow (((unity_DynamicLightmap_HDR.x * tmpvar_8.w) * tmpvar_8.xyz), unity_DynamicLightmap_HDR.yyy);
            lowp vec4 c_9;
            lowp vec4 c_10;
            lowp float diff_11;
            mediump float tmpvar_12;
            tmpvar_12 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_11 = tmpvar_12;
            c_10.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_11);
            c_10.w = tmpvar_6.w;
            c_9.w = c_10.w;
            c_9.xyz = (c_10.xyz + (tmpvar_6.xyz * tmpvar_7));
            gl_FragData[0] = c_9;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump float u_xlat16_10;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
              u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_10 = max(u_xlat16_10, 0.0);
              u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump float u_xlat16_10;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
              u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_10 = max(u_xlat16_10, 0.0);
              u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump float u_xlat16_10;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
              u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_10 = max(u_xlat16_10, 0.0);
              u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform sampler2D unity_DynamicLightmap;
          uniform sampler2D unity_DynamicDirectionality;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            mediump vec3 normalWorld_7;
            normalWorld_7 = tmpvar_3;
            mediump vec4 realtimeDirTex_8;
            mediump vec3 tmpvar_9;
            lowp vec4 tmpvar_10;
            tmpvar_10 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            lowp vec4 tmpvar_11;
            tmpvar_11 = texture2D (unity_DynamicDirectionality, xlv_TEXCOORD5.zw);
            realtimeDirTex_8 = tmpvar_11;
            lowp vec4 dirTex_12;
            dirTex_12 = realtimeDirTex_8;
            lowp vec3 y_13;
            y_13 = (dirTex_12.xyz - 0.5);
            lowp float tmpvar_14;
            tmpvar_14 = max (0.0001, dirTex_12.w);
            tmpvar_9 = ((pow (
              ((unity_DynamicLightmap_HDR.x * tmpvar_10.w) * tmpvar_10.xyz)
            , unity_DynamicLightmap_HDR.yyy) * (
              dot (normalWorld_7, y_13)
             + 0.5)) / tmpvar_14);
            lowp vec4 c_15;
            lowp vec4 c_16;
            lowp float diff_17;
            mediump float tmpvar_18;
            tmpvar_18 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_17 = tmpvar_18;
            c_16.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_17);
            c_16.w = tmpvar_6.w;
            c_15.w = c_16.w;
            c_15.xyz = (c_16.xyz + (tmpvar_6.xyz * tmpvar_9));
            gl_FragData[0] = c_15;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform sampler2D unity_DynamicLightmap;
          uniform sampler2D unity_DynamicDirectionality;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            mediump vec3 normalWorld_7;
            normalWorld_7 = tmpvar_3;
            mediump vec4 realtimeDirTex_8;
            mediump vec3 tmpvar_9;
            lowp vec4 tmpvar_10;
            tmpvar_10 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            lowp vec4 tmpvar_11;
            tmpvar_11 = texture2D (unity_DynamicDirectionality, xlv_TEXCOORD5.zw);
            realtimeDirTex_8 = tmpvar_11;
            lowp vec4 dirTex_12;
            dirTex_12 = realtimeDirTex_8;
            lowp vec3 y_13;
            y_13 = (dirTex_12.xyz - 0.5);
            lowp float tmpvar_14;
            tmpvar_14 = max (0.0001, dirTex_12.w);
            tmpvar_9 = ((pow (
              ((unity_DynamicLightmap_HDR.x * tmpvar_10.w) * tmpvar_10.xyz)
            , unity_DynamicLightmap_HDR.yyy) * (
              dot (normalWorld_7, y_13)
             + 0.5)) / tmpvar_14);
            lowp vec4 c_15;
            lowp vec4 c_16;
            lowp float diff_17;
            mediump float tmpvar_18;
            tmpvar_18 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_17 = tmpvar_18;
            c_16.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_17);
            c_16.w = tmpvar_6.w;
            c_15.w = c_16.w;
            c_15.xyz = (c_16.xyz + (tmpvar_6.xyz * tmpvar_9));
            gl_FragData[0] = c_15;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform sampler2D unity_DynamicLightmap;
          uniform sampler2D unity_DynamicDirectionality;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            mediump vec3 normalWorld_7;
            normalWorld_7 = tmpvar_3;
            mediump vec4 realtimeDirTex_8;
            mediump vec3 tmpvar_9;
            lowp vec4 tmpvar_10;
            tmpvar_10 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            lowp vec4 tmpvar_11;
            tmpvar_11 = texture2D (unity_DynamicDirectionality, xlv_TEXCOORD5.zw);
            realtimeDirTex_8 = tmpvar_11;
            lowp vec4 dirTex_12;
            dirTex_12 = realtimeDirTex_8;
            lowp vec3 y_13;
            y_13 = (dirTex_12.xyz - 0.5);
            lowp float tmpvar_14;
            tmpvar_14 = max (0.0001, dirTex_12.w);
            tmpvar_9 = ((pow (
              ((unity_DynamicLightmap_HDR.x * tmpvar_10.w) * tmpvar_10.xyz)
            , unity_DynamicLightmap_HDR.yyy) * (
              dot (normalWorld_7, y_13)
             + 0.5)) / tmpvar_14);
            lowp vec4 c_15;
            lowp vec4 c_16;
            lowp float diff_17;
            mediump float tmpvar_18;
            tmpvar_18 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_17 = tmpvar_18;
            c_16.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_17);
            c_16.w = tmpvar_6.w;
            c_15.w = c_16.w;
            c_15.xyz = (c_16.xyz + (tmpvar_6.xyz * tmpvar_9));
            gl_FragData[0] = c_15;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          uniform lowp sampler2D unity_DynamicDirectionality;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_13;
          mediump float u_xlat16_14;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(unity_DynamicDirectionality, vs_TEXCOORD6.zw);
              u_xlat16_2.xyz = u_xlat10_0.xyz + vec3(-0.5, -0.5, -0.5);
              u_xlat16_0.x = max(u_xlat10_0.w, 9.99999975e-05);
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
              u_xlat16_13 = u_xlat16_13 + 0.5;
              u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
              u_xlat16_0.xyz = u_xlat16_1.xyz / u_xlat16_0.xxx;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
              u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_14 = max(u_xlat16_14, 0.0);
              u_xlat16_3.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          uniform lowp sampler2D unity_DynamicDirectionality;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_13;
          mediump float u_xlat16_14;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(unity_DynamicDirectionality, vs_TEXCOORD6.zw);
              u_xlat16_2.xyz = u_xlat10_0.xyz + vec3(-0.5, -0.5, -0.5);
              u_xlat16_0.x = max(u_xlat10_0.w, 9.99999975e-05);
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
              u_xlat16_13 = u_xlat16_13 + 0.5;
              u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
              u_xlat16_0.xyz = u_xlat16_1.xyz / u_xlat16_0.xxx;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
              u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_14 = max(u_xlat16_14, 0.0);
              u_xlat16_3.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          uniform lowp sampler2D unity_DynamicDirectionality;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_13;
          mediump float u_xlat16_14;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(unity_DynamicDirectionality, vs_TEXCOORD6.zw);
              u_xlat16_2.xyz = u_xlat10_0.xyz + vec3(-0.5, -0.5, -0.5);
              u_xlat16_0.x = max(u_xlat10_0.w, 9.99999975e-05);
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
              u_xlat16_13 = u_xlat16_13 + 0.5;
              u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
              u_xlat16_0.xyz = u_xlat16_1.xyz / u_xlat16_0.xxx;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
              u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_14 = max(u_xlat16_14, 0.0);
              u_xlat16_3.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp vec4 unity_4LightPosX0;
          uniform highp vec4 unity_4LightPosY0;
          uniform highp vec4 unity_4LightPosZ0;
          uniform mediump vec4 unity_4LightAtten0;
          uniform mediump vec4 unity_LightColor[8];
          uniform mediump vec4 unity_SHAr;
          uniform mediump vec4 unity_SHAg;
          uniform mediump vec4 unity_SHAb;
          uniform mediump vec4 unity_SHBr;
          uniform mediump vec4 unity_SHBg;
          uniform mediump vec4 unity_SHBb;
          uniform mediump vec4 unity_SHC;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            mediump vec3 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp vec3 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            highp vec3 tmpvar_6;
            tmpvar_6 = normalize((_glesNormal * tmpvar_5));
            tmpvar_1.xyz = tmpvar_4;
            highp vec3 lightColor0_7;
            lightColor0_7 = unity_LightColor[0].xyz;
            highp vec3 lightColor1_8;
            lightColor1_8 = unity_LightColor[1].xyz;
            highp vec3 lightColor2_9;
            lightColor2_9 = unity_LightColor[2].xyz;
            highp vec3 lightColor3_10;
            lightColor3_10 = unity_LightColor[3].xyz;
            highp vec4 lightAttenSq_11;
            lightAttenSq_11 = unity_4LightAtten0;
            highp vec3 col_12;
            highp vec4 ndotl_13;
            highp vec4 lengthSq_14;
            highp vec4 tmpvar_15;
            tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
            highp vec4 tmpvar_16;
            tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
            highp vec4 tmpvar_17;
            tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
            lengthSq_14 = (tmpvar_15 * tmpvar_15);
            lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
            lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
            highp vec4 tmpvar_18;
            tmpvar_18 = max (lengthSq_14, vec4(1e-6, 1e-6, 1e-6, 1e-6));
            lengthSq_14 = tmpvar_18;
            ndotl_13 = (tmpvar_15 * tmpvar_6.x);
            ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
            ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
            highp vec4 tmpvar_19;
            tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
            ndotl_13 = tmpvar_19;
            highp vec4 tmpvar_20;
            tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
              (tmpvar_18 * lightAttenSq_11)
            ))));
            col_12 = (lightColor0_7 * tmpvar_20.x);
            col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
            col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
            col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
            tmpvar_2 = col_12;
            mediump vec3 normal_21;
            normal_21 = tmpvar_6;
            mediump vec3 ambient_22;
            mediump vec4 tmpvar_23;
            tmpvar_23.w = 1.0;
            tmpvar_23.xyz = normal_21;
            mediump vec3 res_24;
            mediump vec3 x_25;
            x_25.x = dot (unity_SHAr, tmpvar_23);
            x_25.y = dot (unity_SHAg, tmpvar_23);
            x_25.z = dot (unity_SHAb, tmpvar_23);
            mediump vec3 x1_26;
            mediump vec4 tmpvar_27;
            tmpvar_27 = (normal_21.xyzz * normal_21.yzzx);
            x1_26.x = dot (unity_SHBr, tmpvar_27);
            x1_26.y = dot (unity_SHBg, tmpvar_27);
            x1_26.z = dot (unity_SHBb, tmpvar_27);
            res_24 = (x_25 + (x1_26 + (unity_SHC.xyz * 
              ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
            )));
            mediump vec3 tmpvar_28;
            tmpvar_28 = max (((1.055 * 
              pow (max (res_24, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
            ) - 0.055), vec3(0.0, 0.0, 0.0));
            res_24 = tmpvar_28;
            ambient_22 = (tmpvar_2 + max (vec3(0.0, 0.0, 0.0), tmpvar_28));
            tmpvar_2 = ambient_22;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_6;
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD3 = ambient_22;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            lowp vec4 c_7;
            lowp vec4 c_8;
            lowp float diff_9;
            mediump float tmpvar_10;
            tmpvar_10 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_9 = tmpvar_10;
            c_8.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_9);
            c_8.w = tmpvar_6.w;
            c_7.w = c_8.w;
            c_7.xyz = (c_8.xyz + (tmpvar_6.xyz * xlv_TEXCOORD3));
            gl_FragData[0] = c_7;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp vec4 unity_4LightPosX0;
          uniform highp vec4 unity_4LightPosY0;
          uniform highp vec4 unity_4LightPosZ0;
          uniform mediump vec4 unity_4LightAtten0;
          uniform mediump vec4 unity_LightColor[8];
          uniform mediump vec4 unity_SHAr;
          uniform mediump vec4 unity_SHAg;
          uniform mediump vec4 unity_SHAb;
          uniform mediump vec4 unity_SHBr;
          uniform mediump vec4 unity_SHBg;
          uniform mediump vec4 unity_SHBb;
          uniform mediump vec4 unity_SHC;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            mediump vec3 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp vec3 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            highp vec3 tmpvar_6;
            tmpvar_6 = normalize((_glesNormal * tmpvar_5));
            tmpvar_1.xyz = tmpvar_4;
            highp vec3 lightColor0_7;
            lightColor0_7 = unity_LightColor[0].xyz;
            highp vec3 lightColor1_8;
            lightColor1_8 = unity_LightColor[1].xyz;
            highp vec3 lightColor2_9;
            lightColor2_9 = unity_LightColor[2].xyz;
            highp vec3 lightColor3_10;
            lightColor3_10 = unity_LightColor[3].xyz;
            highp vec4 lightAttenSq_11;
            lightAttenSq_11 = unity_4LightAtten0;
            highp vec3 col_12;
            highp vec4 ndotl_13;
            highp vec4 lengthSq_14;
            highp vec4 tmpvar_15;
            tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
            highp vec4 tmpvar_16;
            tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
            highp vec4 tmpvar_17;
            tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
            lengthSq_14 = (tmpvar_15 * tmpvar_15);
            lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
            lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
            highp vec4 tmpvar_18;
            tmpvar_18 = max (lengthSq_14, vec4(1e-6, 1e-6, 1e-6, 1e-6));
            lengthSq_14 = tmpvar_18;
            ndotl_13 = (tmpvar_15 * tmpvar_6.x);
            ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
            ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
            highp vec4 tmpvar_19;
            tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
            ndotl_13 = tmpvar_19;
            highp vec4 tmpvar_20;
            tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
              (tmpvar_18 * lightAttenSq_11)
            ))));
            col_12 = (lightColor0_7 * tmpvar_20.x);
            col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
            col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
            col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
            tmpvar_2 = col_12;
            mediump vec3 normal_21;
            normal_21 = tmpvar_6;
            mediump vec3 ambient_22;
            mediump vec4 tmpvar_23;
            tmpvar_23.w = 1.0;
            tmpvar_23.xyz = normal_21;
            mediump vec3 res_24;
            mediump vec3 x_25;
            x_25.x = dot (unity_SHAr, tmpvar_23);
            x_25.y = dot (unity_SHAg, tmpvar_23);
            x_25.z = dot (unity_SHAb, tmpvar_23);
            mediump vec3 x1_26;
            mediump vec4 tmpvar_27;
            tmpvar_27 = (normal_21.xyzz * normal_21.yzzx);
            x1_26.x = dot (unity_SHBr, tmpvar_27);
            x1_26.y = dot (unity_SHBg, tmpvar_27);
            x1_26.z = dot (unity_SHBb, tmpvar_27);
            res_24 = (x_25 + (x1_26 + (unity_SHC.xyz * 
              ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
            )));
            mediump vec3 tmpvar_28;
            tmpvar_28 = max (((1.055 * 
              pow (max (res_24, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
            ) - 0.055), vec3(0.0, 0.0, 0.0));
            res_24 = tmpvar_28;
            ambient_22 = (tmpvar_2 + max (vec3(0.0, 0.0, 0.0), tmpvar_28));
            tmpvar_2 = ambient_22;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_6;
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD3 = ambient_22;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            lowp vec4 c_7;
            lowp vec4 c_8;
            lowp float diff_9;
            mediump float tmpvar_10;
            tmpvar_10 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_9 = tmpvar_10;
            c_8.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_9);
            c_8.w = tmpvar_6.w;
            c_7.w = c_8.w;
            c_7.xyz = (c_8.xyz + (tmpvar_6.xyz * xlv_TEXCOORD3));
            gl_FragData[0] = c_7;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp vec4 unity_4LightPosX0;
          uniform highp vec4 unity_4LightPosY0;
          uniform highp vec4 unity_4LightPosZ0;
          uniform mediump vec4 unity_4LightAtten0;
          uniform mediump vec4 unity_LightColor[8];
          uniform mediump vec4 unity_SHAr;
          uniform mediump vec4 unity_SHAg;
          uniform mediump vec4 unity_SHAb;
          uniform mediump vec4 unity_SHBr;
          uniform mediump vec4 unity_SHBg;
          uniform mediump vec4 unity_SHBb;
          uniform mediump vec4 unity_SHC;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            mediump vec3 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp vec3 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            highp vec3 tmpvar_6;
            tmpvar_6 = normalize((_glesNormal * tmpvar_5));
            tmpvar_1.xyz = tmpvar_4;
            highp vec3 lightColor0_7;
            lightColor0_7 = unity_LightColor[0].xyz;
            highp vec3 lightColor1_8;
            lightColor1_8 = unity_LightColor[1].xyz;
            highp vec3 lightColor2_9;
            lightColor2_9 = unity_LightColor[2].xyz;
            highp vec3 lightColor3_10;
            lightColor3_10 = unity_LightColor[3].xyz;
            highp vec4 lightAttenSq_11;
            lightAttenSq_11 = unity_4LightAtten0;
            highp vec3 col_12;
            highp vec4 ndotl_13;
            highp vec4 lengthSq_14;
            highp vec4 tmpvar_15;
            tmpvar_15 = (unity_4LightPosX0 - tmpvar_4.x);
            highp vec4 tmpvar_16;
            tmpvar_16 = (unity_4LightPosY0 - tmpvar_4.y);
            highp vec4 tmpvar_17;
            tmpvar_17 = (unity_4LightPosZ0 - tmpvar_4.z);
            lengthSq_14 = (tmpvar_15 * tmpvar_15);
            lengthSq_14 = (lengthSq_14 + (tmpvar_16 * tmpvar_16));
            lengthSq_14 = (lengthSq_14 + (tmpvar_17 * tmpvar_17));
            highp vec4 tmpvar_18;
            tmpvar_18 = max (lengthSq_14, vec4(1e-6, 1e-6, 1e-6, 1e-6));
            lengthSq_14 = tmpvar_18;
            ndotl_13 = (tmpvar_15 * tmpvar_6.x);
            ndotl_13 = (ndotl_13 + (tmpvar_16 * tmpvar_6.y));
            ndotl_13 = (ndotl_13 + (tmpvar_17 * tmpvar_6.z));
            highp vec4 tmpvar_19;
            tmpvar_19 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_13 * inversesqrt(tmpvar_18)));
            ndotl_13 = tmpvar_19;
            highp vec4 tmpvar_20;
            tmpvar_20 = (tmpvar_19 * (1.0/((1.0 + 
              (tmpvar_18 * lightAttenSq_11)
            ))));
            col_12 = (lightColor0_7 * tmpvar_20.x);
            col_12 = (col_12 + (lightColor1_8 * tmpvar_20.y));
            col_12 = (col_12 + (lightColor2_9 * tmpvar_20.z));
            col_12 = (col_12 + (lightColor3_10 * tmpvar_20.w));
            tmpvar_2 = col_12;
            mediump vec3 normal_21;
            normal_21 = tmpvar_6;
            mediump vec3 ambient_22;
            mediump vec4 tmpvar_23;
            tmpvar_23.w = 1.0;
            tmpvar_23.xyz = normal_21;
            mediump vec3 res_24;
            mediump vec3 x_25;
            x_25.x = dot (unity_SHAr, tmpvar_23);
            x_25.y = dot (unity_SHAg, tmpvar_23);
            x_25.z = dot (unity_SHAb, tmpvar_23);
            mediump vec3 x1_26;
            mediump vec4 tmpvar_27;
            tmpvar_27 = (normal_21.xyzz * normal_21.yzzx);
            x1_26.x = dot (unity_SHBr, tmpvar_27);
            x1_26.y = dot (unity_SHBg, tmpvar_27);
            x1_26.z = dot (unity_SHBb, tmpvar_27);
            res_24 = (x_25 + (x1_26 + (unity_SHC.xyz * 
              ((normal_21.x * normal_21.x) - (normal_21.y * normal_21.y))
            )));
            mediump vec3 tmpvar_28;
            tmpvar_28 = max (((1.055 * 
              pow (max (res_24, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
            ) - 0.055), vec3(0.0, 0.0, 0.0));
            res_24 = tmpvar_28;
            ambient_22 = (tmpvar_2 + max (vec3(0.0, 0.0, 0.0), tmpvar_28));
            tmpvar_2 = ambient_22;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_6;
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD3 = ambient_22;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            lowp vec4 c_7;
            lowp vec4 c_8;
            lowp float diff_9;
            mediump float tmpvar_10;
            tmpvar_10 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_9 = tmpvar_10;
            c_8.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_9);
            c_8.w = tmpvar_6.w;
            c_7.w = c_8.w;
            c_7.xyz = (c_8.xyz + (tmpvar_6.xyz * xlv_TEXCOORD3));
            gl_FragData[0] = c_7;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 unity_4LightPosX0;
          uniform 	vec4 unity_4LightPosY0;
          uniform 	vec4 unity_4LightPosZ0;
          uniform 	mediump vec4 unity_4LightAtten0;
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	mediump vec4 unity_SHAr;
          uniform 	mediump vec4 unity_SHAg;
          uniform 	mediump vec4 unity_SHAb;
          uniform 	mediump vec4 unity_SHBr;
          uniform 	mediump vec4 unity_SHBg;
          uniform 	mediump vec4 unity_SHBb;
          uniform 	mediump vec4 unity_SHC;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec4 u_xlat16_2;
          vec4 u_xlat3;
          vec4 u_xlat4;
          mediump vec3 u_xlat16_5;
          mediump vec3 u_xlat16_6;
          float u_xlat21;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat21 = inversesqrt(u_xlat21);
              u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
              vs_TEXCOORD1.xyz = u_xlat1.xyz;
              vs_TEXCOORD2.xyz = u_xlat0.xyz;
              u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
              u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
              u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
              u_xlat4 = u_xlat1.yyyy * u_xlat3;
              u_xlat3 = u_xlat3 * u_xlat3;
              u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
              u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
              u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
              u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
              u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
              u_xlat3 = inversesqrt(u_xlat0);
              u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
              u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
              u_xlat2 = u_xlat2 * u_xlat3;
              u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
              u_xlat0 = u_xlat0 * u_xlat2;
              u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
              u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
              u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
              u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
              u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
              u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
              u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
              u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
              u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
              u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
              u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
              u_xlat1.w = 1.0;
              u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
              u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
              u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
              u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
              u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
              u_xlat1.xyz = log2(u_xlat16_5.xyz);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
              u_xlat1.xyz = exp2(u_xlat1.xyz);
              u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
              u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
              vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_3.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_0) + u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 unity_4LightPosX0;
          uniform 	vec4 unity_4LightPosY0;
          uniform 	vec4 unity_4LightPosZ0;
          uniform 	mediump vec4 unity_4LightAtten0;
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	mediump vec4 unity_SHAr;
          uniform 	mediump vec4 unity_SHAg;
          uniform 	mediump vec4 unity_SHAb;
          uniform 	mediump vec4 unity_SHBr;
          uniform 	mediump vec4 unity_SHBg;
          uniform 	mediump vec4 unity_SHBb;
          uniform 	mediump vec4 unity_SHC;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec4 u_xlat16_2;
          vec4 u_xlat3;
          vec4 u_xlat4;
          mediump vec3 u_xlat16_5;
          mediump vec3 u_xlat16_6;
          float u_xlat21;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat21 = inversesqrt(u_xlat21);
              u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
              vs_TEXCOORD1.xyz = u_xlat1.xyz;
              vs_TEXCOORD2.xyz = u_xlat0.xyz;
              u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
              u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
              u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
              u_xlat4 = u_xlat1.yyyy * u_xlat3;
              u_xlat3 = u_xlat3 * u_xlat3;
              u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
              u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
              u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
              u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
              u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
              u_xlat3 = inversesqrt(u_xlat0);
              u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
              u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
              u_xlat2 = u_xlat2 * u_xlat3;
              u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
              u_xlat0 = u_xlat0 * u_xlat2;
              u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
              u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
              u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
              u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
              u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
              u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
              u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
              u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
              u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
              u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
              u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
              u_xlat1.w = 1.0;
              u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
              u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
              u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
              u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
              u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
              u_xlat1.xyz = log2(u_xlat16_5.xyz);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
              u_xlat1.xyz = exp2(u_xlat1.xyz);
              u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
              u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
              vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_3.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_0) + u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 unity_4LightPosX0;
          uniform 	vec4 unity_4LightPosY0;
          uniform 	vec4 unity_4LightPosZ0;
          uniform 	mediump vec4 unity_4LightAtten0;
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	mediump vec4 unity_SHAr;
          uniform 	mediump vec4 unity_SHAg;
          uniform 	mediump vec4 unity_SHAb;
          uniform 	mediump vec4 unity_SHBr;
          uniform 	mediump vec4 unity_SHBg;
          uniform 	mediump vec4 unity_SHBb;
          uniform 	mediump vec4 unity_SHC;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec4 u_xlat16_2;
          vec4 u_xlat3;
          vec4 u_xlat4;
          mediump vec3 u_xlat16_5;
          mediump vec3 u_xlat16_6;
          float u_xlat21;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat21 = inversesqrt(u_xlat21);
              u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
              vs_TEXCOORD1.xyz = u_xlat1.xyz;
              vs_TEXCOORD2.xyz = u_xlat0.xyz;
              u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
              u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
              u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
              u_xlat4 = u_xlat1.yyyy * u_xlat3;
              u_xlat3 = u_xlat3 * u_xlat3;
              u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
              u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
              u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
              u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
              u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
              u_xlat3 = inversesqrt(u_xlat0);
              u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
              u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
              u_xlat2 = u_xlat2 * u_xlat3;
              u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
              u_xlat0 = u_xlat0 * u_xlat2;
              u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
              u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
              u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
              u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
              u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
              u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
              u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
              u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
              u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
              u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
              u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
              u_xlat1.w = 1.0;
              u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
              u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
              u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
              u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
              u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
              u_xlat1.xyz = log2(u_xlat16_5.xyz);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
              u_xlat1.xyz = exp2(u_xlat1.xyz);
              u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
              u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
              vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_3.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_1.xyz * vs_TEXCOORD3.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_0) + u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform sampler2D unity_DynamicLightmap;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            mediump vec3 tmpvar_7;
            lowp vec4 tmpvar_8;
            tmpvar_8 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            tmpvar_7 = pow (((unity_DynamicLightmap_HDR.x * tmpvar_8.w) * tmpvar_8.xyz), unity_DynamicLightmap_HDR.yyy);
            lowp vec4 c_9;
            lowp vec4 c_10;
            lowp float diff_11;
            mediump float tmpvar_12;
            tmpvar_12 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_11 = tmpvar_12;
            c_10.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_11);
            c_10.w = tmpvar_6.w;
            c_9.w = c_10.w;
            c_9.xyz = (c_10.xyz + (tmpvar_6.xyz * tmpvar_7));
            gl_FragData[0] = c_9;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform sampler2D unity_DynamicLightmap;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            mediump vec3 tmpvar_7;
            lowp vec4 tmpvar_8;
            tmpvar_8 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            tmpvar_7 = pow (((unity_DynamicLightmap_HDR.x * tmpvar_8.w) * tmpvar_8.xyz), unity_DynamicLightmap_HDR.yyy);
            lowp vec4 c_9;
            lowp vec4 c_10;
            lowp float diff_11;
            mediump float tmpvar_12;
            tmpvar_12 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_11 = tmpvar_12;
            c_10.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_11);
            c_10.w = tmpvar_6.w;
            c_9.w = c_10.w;
            c_9.xyz = (c_10.xyz + (tmpvar_6.xyz * tmpvar_7));
            gl_FragData[0] = c_9;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform sampler2D unity_DynamicLightmap;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            mediump vec3 tmpvar_7;
            lowp vec4 tmpvar_8;
            tmpvar_8 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            tmpvar_7 = pow (((unity_DynamicLightmap_HDR.x * tmpvar_8.w) * tmpvar_8.xyz), unity_DynamicLightmap_HDR.yyy);
            lowp vec4 c_9;
            lowp vec4 c_10;
            lowp float diff_11;
            mediump float tmpvar_12;
            tmpvar_12 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_11 = tmpvar_12;
            c_10.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_11);
            c_10.w = tmpvar_6.w;
            c_9.w = c_10.w;
            c_9.xyz = (c_10.xyz + (tmpvar_6.xyz * tmpvar_7));
            gl_FragData[0] = c_9;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump float u_xlat16_10;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
              u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_10 = max(u_xlat16_10, 0.0);
              u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump float u_xlat16_10;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
              u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_10 = max(u_xlat16_10, 0.0);
              u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump float u_xlat16_10;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
              u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_10 = max(u_xlat16_10, 0.0);
              u_xlat16_2.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              SV_Target0.xyz = u_xlat16_2.xyz * vec3(u_xlat16_10) + u_xlat16_1.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform sampler2D unity_DynamicLightmap;
          uniform sampler2D unity_DynamicDirectionality;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            mediump vec3 normalWorld_7;
            normalWorld_7 = tmpvar_3;
            mediump vec4 realtimeDirTex_8;
            mediump vec3 tmpvar_9;
            lowp vec4 tmpvar_10;
            tmpvar_10 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            lowp vec4 tmpvar_11;
            tmpvar_11 = texture2D (unity_DynamicDirectionality, xlv_TEXCOORD5.zw);
            realtimeDirTex_8 = tmpvar_11;
            lowp vec4 dirTex_12;
            dirTex_12 = realtimeDirTex_8;
            lowp vec3 y_13;
            y_13 = (dirTex_12.xyz - 0.5);
            lowp float tmpvar_14;
            tmpvar_14 = max (0.0001, dirTex_12.w);
            tmpvar_9 = ((pow (
              ((unity_DynamicLightmap_HDR.x * tmpvar_10.w) * tmpvar_10.xyz)
            , unity_DynamicLightmap_HDR.yyy) * (
              dot (normalWorld_7, y_13)
             + 0.5)) / tmpvar_14);
            lowp vec4 c_15;
            lowp vec4 c_16;
            lowp float diff_17;
            mediump float tmpvar_18;
            tmpvar_18 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_17 = tmpvar_18;
            c_16.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_17);
            c_16.w = tmpvar_6.w;
            c_15.w = c_16.w;
            c_15.xyz = (c_16.xyz + (tmpvar_6.xyz * tmpvar_9));
            gl_FragData[0] = c_15;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform sampler2D unity_DynamicLightmap;
          uniform sampler2D unity_DynamicDirectionality;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            mediump vec3 normalWorld_7;
            normalWorld_7 = tmpvar_3;
            mediump vec4 realtimeDirTex_8;
            mediump vec3 tmpvar_9;
            lowp vec4 tmpvar_10;
            tmpvar_10 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            lowp vec4 tmpvar_11;
            tmpvar_11 = texture2D (unity_DynamicDirectionality, xlv_TEXCOORD5.zw);
            realtimeDirTex_8 = tmpvar_11;
            lowp vec4 dirTex_12;
            dirTex_12 = realtimeDirTex_8;
            lowp vec3 y_13;
            y_13 = (dirTex_12.xyz - 0.5);
            lowp float tmpvar_14;
            tmpvar_14 = max (0.0001, dirTex_12.w);
            tmpvar_9 = ((pow (
              ((unity_DynamicLightmap_HDR.x * tmpvar_10.w) * tmpvar_10.xyz)
            , unity_DynamicLightmap_HDR.yyy) * (
              dot (normalWorld_7, y_13)
             + 0.5)) / tmpvar_14);
            lowp vec4 c_15;
            lowp vec4 c_16;
            lowp float diff_17;
            mediump float tmpvar_18;
            tmpvar_18 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_17 = tmpvar_18;
            c_16.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_17);
            c_16.w = tmpvar_6.w;
            c_15.w = c_16.w;
            c_15.xyz = (c_16.xyz + (tmpvar_6.xyz * tmpvar_9));
            gl_FragData[0] = c_15;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform sampler2D unity_DynamicLightmap;
          uniform sampler2D unity_DynamicDirectionality;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            mediump vec3 normalWorld_7;
            normalWorld_7 = tmpvar_3;
            mediump vec4 realtimeDirTex_8;
            mediump vec3 tmpvar_9;
            lowp vec4 tmpvar_10;
            tmpvar_10 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            lowp vec4 tmpvar_11;
            tmpvar_11 = texture2D (unity_DynamicDirectionality, xlv_TEXCOORD5.zw);
            realtimeDirTex_8 = tmpvar_11;
            lowp vec4 dirTex_12;
            dirTex_12 = realtimeDirTex_8;
            lowp vec3 y_13;
            y_13 = (dirTex_12.xyz - 0.5);
            lowp float tmpvar_14;
            tmpvar_14 = max (0.0001, dirTex_12.w);
            tmpvar_9 = ((pow (
              ((unity_DynamicLightmap_HDR.x * tmpvar_10.w) * tmpvar_10.xyz)
            , unity_DynamicLightmap_HDR.yyy) * (
              dot (normalWorld_7, y_13)
             + 0.5)) / tmpvar_14);
            lowp vec4 c_15;
            lowp vec4 c_16;
            lowp float diff_17;
            mediump float tmpvar_18;
            tmpvar_18 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_17 = tmpvar_18;
            c_16.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_17);
            c_16.w = tmpvar_6.w;
            c_15.w = c_16.w;
            c_15.xyz = (c_16.xyz + (tmpvar_6.xyz * tmpvar_9));
            gl_FragData[0] = c_15;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          uniform lowp sampler2D unity_DynamicDirectionality;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_13;
          mediump float u_xlat16_14;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(unity_DynamicDirectionality, vs_TEXCOORD6.zw);
              u_xlat16_2.xyz = u_xlat10_0.xyz + vec3(-0.5, -0.5, -0.5);
              u_xlat16_0.x = max(u_xlat10_0.w, 9.99999975e-05);
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
              u_xlat16_13 = u_xlat16_13 + 0.5;
              u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
              u_xlat16_0.xyz = u_xlat16_1.xyz / u_xlat16_0.xxx;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
              u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_14 = max(u_xlat16_14, 0.0);
              u_xlat16_3.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          uniform lowp sampler2D unity_DynamicDirectionality;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_13;
          mediump float u_xlat16_14;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(unity_DynamicDirectionality, vs_TEXCOORD6.zw);
              u_xlat16_2.xyz = u_xlat10_0.xyz + vec3(-0.5, -0.5, -0.5);
              u_xlat16_0.x = max(u_xlat10_0.w, 9.99999975e-05);
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
              u_xlat16_13 = u_xlat16_13 + 0.5;
              u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
              u_xlat16_0.xyz = u_xlat16_1.xyz / u_xlat16_0.xxx;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
              u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_14 = max(u_xlat16_14, 0.0);
              u_xlat16_3.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          uniform lowp sampler2D unity_DynamicDirectionality;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_13;
          mediump float u_xlat16_14;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(unity_DynamicDirectionality, vs_TEXCOORD6.zw);
              u_xlat16_2.xyz = u_xlat10_0.xyz + vec3(-0.5, -0.5, -0.5);
              u_xlat16_0.x = max(u_xlat10_0.w, 9.99999975e-05);
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
              u_xlat16_13 = u_xlat16_13 + 0.5;
              u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
              u_xlat16_0.xyz = u_xlat16_1.xyz / u_xlat16_0.xxx;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat16_1.xyz;
              u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_14 = max(u_xlat16_14, 0.0);
              u_xlat16_3.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_1.w = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_2;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            lowp vec4 c_8;
            lowp vec4 c_9;
            lowp float diff_10;
            mediump float tmpvar_11;
            tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_10 = tmpvar_11;
            c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
            c_9.w = tmpvar_7.w;
            c_8.w = c_9.w;
            c_8.xyz = c_9.xyz;
            c_3.w = c_8.w;
            highp float tmpvar_12;
            tmpvar_12 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_9.xyz, vec3(tmpvar_12));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_1.w = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_2;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            lowp vec4 c_8;
            lowp vec4 c_9;
            lowp float diff_10;
            mediump float tmpvar_11;
            tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_10 = tmpvar_11;
            c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
            c_9.w = tmpvar_7.w;
            c_8.w = c_9.w;
            c_8.xyz = c_9.xyz;
            c_3.w = c_8.w;
            highp float tmpvar_12;
            tmpvar_12 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_9.xyz, vec3(tmpvar_12));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_1.w = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_2;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_4));
            xlv_TEXCOORD2 = tmpvar_1;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            lowp vec4 c_8;
            lowp vec4 c_9;
            lowp float diff_10;
            mediump float tmpvar_11;
            tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_10 = tmpvar_11;
            c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
            c_9.w = tmpvar_7.w;
            c_8.w = c_9.w;
            c_8.xyz = c_9.xyz;
            c_3.w = c_8.w;
            highp float tmpvar_12;
            tmpvar_12 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_9.xyz, vec3(tmpvar_12));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          vec4 u_xlat1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat11;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_3.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_0) + (-unity_FogColor.xyz);
              u_xlat11 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
          #else
              u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat11) * u_xlat16_2.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          vec4 u_xlat1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat11;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_3.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_0) + (-unity_FogColor.xyz);
              u_xlat11 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
          #else
              u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat11) * u_xlat16_2.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          vec4 u_xlat1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat11;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_3.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_0) + (-unity_FogColor.xyz);
              u_xlat11 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat11 = min(max(u_xlat11, 0.0), 1.0);
          #else
              u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat11) * u_xlat16_2.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform mediump vec4 unity_SHAr;
          uniform mediump vec4 unity_SHAg;
          uniform mediump vec4 unity_SHAb;
          uniform mediump vec4 unity_SHBr;
          uniform mediump vec4 unity_SHBg;
          uniform mediump vec4 unity_SHBb;
          uniform mediump vec4 unity_SHC;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            highp vec3 tmpvar_5;
            tmpvar_5 = normalize((_glesNormal * tmpvar_4));
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            mediump vec3 normal_6;
            normal_6 = tmpvar_5;
            mediump vec4 tmpvar_7;
            tmpvar_7.w = 1.0;
            tmpvar_7.xyz = normal_6;
            mediump vec3 res_8;
            mediump vec3 x_9;
            x_9.x = dot (unity_SHAr, tmpvar_7);
            x_9.y = dot (unity_SHAg, tmpvar_7);
            x_9.z = dot (unity_SHAb, tmpvar_7);
            mediump vec3 x1_10;
            mediump vec4 tmpvar_11;
            tmpvar_11 = (normal_6.xyzz * normal_6.yzzx);
            x1_10.x = dot (unity_SHBr, tmpvar_11);
            x1_10.y = dot (unity_SHBg, tmpvar_11);
            x1_10.z = dot (unity_SHBb, tmpvar_11);
            res_8 = (x_9 + (x1_10 + (unity_SHC.xyz * 
              ((normal_6.x * normal_6.x) - (normal_6.y * normal_6.y))
            )));
            mediump vec3 tmpvar_12;
            tmpvar_12 = max (((1.055 * 
              pow (max (res_8, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
            ) - 0.055), vec3(0.0, 0.0, 0.0));
            res_8 = tmpvar_12;
            tmpvar_1.w = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_2;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_5;
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_12);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            lowp vec4 c_8;
            lowp vec4 c_9;
            lowp float diff_10;
            mediump float tmpvar_11;
            tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_10 = tmpvar_11;
            c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
            c_9.w = tmpvar_7.w;
            c_8.w = c_9.w;
            c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
            c_3.w = c_8.w;
            highp float tmpvar_12;
            tmpvar_12 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform mediump vec4 unity_SHAr;
          uniform mediump vec4 unity_SHAg;
          uniform mediump vec4 unity_SHAb;
          uniform mediump vec4 unity_SHBr;
          uniform mediump vec4 unity_SHBg;
          uniform mediump vec4 unity_SHBb;
          uniform mediump vec4 unity_SHC;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            highp vec3 tmpvar_5;
            tmpvar_5 = normalize((_glesNormal * tmpvar_4));
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            mediump vec3 normal_6;
            normal_6 = tmpvar_5;
            mediump vec4 tmpvar_7;
            tmpvar_7.w = 1.0;
            tmpvar_7.xyz = normal_6;
            mediump vec3 res_8;
            mediump vec3 x_9;
            x_9.x = dot (unity_SHAr, tmpvar_7);
            x_9.y = dot (unity_SHAg, tmpvar_7);
            x_9.z = dot (unity_SHAb, tmpvar_7);
            mediump vec3 x1_10;
            mediump vec4 tmpvar_11;
            tmpvar_11 = (normal_6.xyzz * normal_6.yzzx);
            x1_10.x = dot (unity_SHBr, tmpvar_11);
            x1_10.y = dot (unity_SHBg, tmpvar_11);
            x1_10.z = dot (unity_SHBb, tmpvar_11);
            res_8 = (x_9 + (x1_10 + (unity_SHC.xyz * 
              ((normal_6.x * normal_6.x) - (normal_6.y * normal_6.y))
            )));
            mediump vec3 tmpvar_12;
            tmpvar_12 = max (((1.055 * 
              pow (max (res_8, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
            ) - 0.055), vec3(0.0, 0.0, 0.0));
            res_8 = tmpvar_12;
            tmpvar_1.w = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_2;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_5;
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_12);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            lowp vec4 c_8;
            lowp vec4 c_9;
            lowp float diff_10;
            mediump float tmpvar_11;
            tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_10 = tmpvar_11;
            c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
            c_9.w = tmpvar_7.w;
            c_8.w = c_9.w;
            c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
            c_3.w = c_8.w;
            highp float tmpvar_12;
            tmpvar_12 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform mediump vec4 unity_SHAr;
          uniform mediump vec4 unity_SHAg;
          uniform mediump vec4 unity_SHAb;
          uniform mediump vec4 unity_SHBr;
          uniform mediump vec4 unity_SHBg;
          uniform mediump vec4 unity_SHBb;
          uniform mediump vec4 unity_SHC;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = _glesVertex.xyz;
            tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            highp mat3 tmpvar_4;
            tmpvar_4[0] = unity_WorldToObject[0].xyz;
            tmpvar_4[1] = unity_WorldToObject[1].xyz;
            tmpvar_4[2] = unity_WorldToObject[2].xyz;
            highp vec3 tmpvar_5;
            tmpvar_5 = normalize((_glesNormal * tmpvar_4));
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            mediump vec3 normal_6;
            normal_6 = tmpvar_5;
            mediump vec4 tmpvar_7;
            tmpvar_7.w = 1.0;
            tmpvar_7.xyz = normal_6;
            mediump vec3 res_8;
            mediump vec3 x_9;
            x_9.x = dot (unity_SHAr, tmpvar_7);
            x_9.y = dot (unity_SHAg, tmpvar_7);
            x_9.z = dot (unity_SHAb, tmpvar_7);
            mediump vec3 x1_10;
            mediump vec4 tmpvar_11;
            tmpvar_11 = (normal_6.xyzz * normal_6.yzzx);
            x1_10.x = dot (unity_SHBr, tmpvar_11);
            x1_10.y = dot (unity_SHBg, tmpvar_11);
            x1_10.z = dot (unity_SHBb, tmpvar_11);
            res_8 = (x_9 + (x1_10 + (unity_SHC.xyz * 
              ((normal_6.x * normal_6.x) - (normal_6.y * normal_6.y))
            )));
            mediump vec3 tmpvar_12;
            tmpvar_12 = max (((1.055 * 
              pow (max (res_8, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
            ) - 0.055), vec3(0.0, 0.0, 0.0));
            res_8 = tmpvar_12;
            tmpvar_1.w = ((tmpvar_2.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_2;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_5;
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_12);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            lowp vec4 c_8;
            lowp vec4 c_9;
            lowp float diff_10;
            mediump float tmpvar_11;
            tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_10 = tmpvar_11;
            c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
            c_9.w = tmpvar_7.w;
            c_8.w = c_9.w;
            c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
            c_3.w = c_8.w;
            highp float tmpvar_12;
            tmpvar_12 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	mediump vec4 unity_SHAr;
          uniform 	mediump vec4 unity_SHAg;
          uniform 	mediump vec4 unity_SHAb;
          uniform 	mediump vec4 unity_SHBr;
          uniform 	mediump vec4 unity_SHBg;
          uniform 	mediump vec4 unity_SHBb;
          uniform 	mediump vec4 unity_SHC;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          mediump vec4 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat12;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat12 = inversesqrt(u_xlat12);
              u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
              vs_TEXCOORD1.xyz = u_xlat0.xyz;
              u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
              u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
              u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
              u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
              u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
              u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
              u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
              u_xlat0.w = 1.0;
              u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
              u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
              u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
              u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
              u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
              u_xlat0.xyz = log2(u_xlat16_2.xyz);
              u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
              u_xlat0.xyz = exp2(u_xlat0.xyz);
              u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
              u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
              vs_TEXCOORD3.xyz = u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          vec4 u_xlat1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump vec3 u_xlat16_4;
          float u_xlat15;
          void main()
          {
              u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_4.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
              u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
              u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
              u_xlat15 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
          #else
              u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat15) * u_xlat16_3.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	mediump vec4 unity_SHAr;
          uniform 	mediump vec4 unity_SHAg;
          uniform 	mediump vec4 unity_SHAb;
          uniform 	mediump vec4 unity_SHBr;
          uniform 	mediump vec4 unity_SHBg;
          uniform 	mediump vec4 unity_SHBb;
          uniform 	mediump vec4 unity_SHC;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          mediump vec4 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat12;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat12 = inversesqrt(u_xlat12);
              u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
              vs_TEXCOORD1.xyz = u_xlat0.xyz;
              u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
              u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
              u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
              u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
              u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
              u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
              u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
              u_xlat0.w = 1.0;
              u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
              u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
              u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
              u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
              u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
              u_xlat0.xyz = log2(u_xlat16_2.xyz);
              u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
              u_xlat0.xyz = exp2(u_xlat0.xyz);
              u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
              u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
              vs_TEXCOORD3.xyz = u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          vec4 u_xlat1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump vec3 u_xlat16_4;
          float u_xlat15;
          void main()
          {
              u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_4.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
              u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
              u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
              u_xlat15 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
          #else
              u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat15) * u_xlat16_3.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	mediump vec4 unity_SHAr;
          uniform 	mediump vec4 unity_SHAg;
          uniform 	mediump vec4 unity_SHAb;
          uniform 	mediump vec4 unity_SHBr;
          uniform 	mediump vec4 unity_SHBg;
          uniform 	mediump vec4 unity_SHBb;
          uniform 	mediump vec4 unity_SHC;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          mediump vec4 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat12;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat12 = inversesqrt(u_xlat12);
              u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
              vs_TEXCOORD1.xyz = u_xlat0.xyz;
              u_xlat16_2.x = u_xlat0.y * u_xlat0.y;
              u_xlat16_2.x = u_xlat0.x * u_xlat0.x + (-u_xlat16_2.x);
              u_xlat16_1 = u_xlat0.yzzx * u_xlat0.xyzz;
              u_xlat16_3.x = dot(unity_SHBr, u_xlat16_1);
              u_xlat16_3.y = dot(unity_SHBg, u_xlat16_1);
              u_xlat16_3.z = dot(unity_SHBb, u_xlat16_1);
              u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_3.xyz;
              u_xlat0.w = 1.0;
              u_xlat16_3.x = dot(unity_SHAr, u_xlat0);
              u_xlat16_3.y = dot(unity_SHAg, u_xlat0);
              u_xlat16_3.z = dot(unity_SHAb, u_xlat0);
              u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
              u_xlat16_2.xyz = max(u_xlat16_2.xyz, vec3(0.0, 0.0, 0.0));
              u_xlat0.xyz = log2(u_xlat16_2.xyz);
              u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
              u_xlat0.xyz = exp2(u_xlat0.xyz);
              u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
              u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
              vs_TEXCOORD3.xyz = u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          vec4 u_xlat1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump vec3 u_xlat16_4;
          float u_xlat15;
          void main()
          {
              u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_4.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
              u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
              u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
              u_xlat15 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
          #else
              u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat15) * u_xlat16_3.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D unity_DynamicLightmap;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            mediump vec3 tmpvar_8;
            lowp vec4 tmpvar_9;
            tmpvar_9 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            tmpvar_8 = pow (((unity_DynamicLightmap_HDR.x * tmpvar_9.w) * tmpvar_9.xyz), unity_DynamicLightmap_HDR.yyy);
            lowp vec4 c_10;
            lowp vec4 c_11;
            lowp float diff_12;
            mediump float tmpvar_13;
            tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_12 = tmpvar_13;
            c_11.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_12);
            c_11.w = tmpvar_7.w;
            c_10.w = c_11.w;
            c_10.xyz = (c_11.xyz + (tmpvar_7.xyz * tmpvar_8));
            c_3.w = c_10.w;
            highp float tmpvar_14;
            tmpvar_14 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_10.xyz, vec3(tmpvar_14));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D unity_DynamicLightmap;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            mediump vec3 tmpvar_8;
            lowp vec4 tmpvar_9;
            tmpvar_9 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            tmpvar_8 = pow (((unity_DynamicLightmap_HDR.x * tmpvar_9.w) * tmpvar_9.xyz), unity_DynamicLightmap_HDR.yyy);
            lowp vec4 c_10;
            lowp vec4 c_11;
            lowp float diff_12;
            mediump float tmpvar_13;
            tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_12 = tmpvar_13;
            c_11.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_12);
            c_11.w = tmpvar_7.w;
            c_10.w = c_11.w;
            c_10.xyz = (c_11.xyz + (tmpvar_7.xyz * tmpvar_8));
            c_3.w = c_10.w;
            highp float tmpvar_14;
            tmpvar_14 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_10.xyz, vec3(tmpvar_14));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D unity_DynamicLightmap;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            mediump vec3 tmpvar_8;
            lowp vec4 tmpvar_9;
            tmpvar_9 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            tmpvar_8 = pow (((unity_DynamicLightmap_HDR.x * tmpvar_9.w) * tmpvar_9.xyz), unity_DynamicLightmap_HDR.yyy);
            lowp vec4 c_10;
            lowp vec4 c_11;
            lowp float diff_12;
            mediump float tmpvar_13;
            tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_12 = tmpvar_13;
            c_11.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_12);
            c_11.w = tmpvar_7.w;
            c_10.w = c_11.w;
            c_10.xyz = (c_11.xyz + (tmpvar_7.xyz * tmpvar_8));
            c_3.w = c_10.w;
            highp float tmpvar_14;
            tmpvar_14 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_10.xyz, vec3(tmpvar_14));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_13;
          float u_xlat15;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_13 = max(u_xlat16_13, 0.0);
              u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
              u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_13) + u_xlat16_1.xyz;
              u_xlat16_3.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
              u_xlat15 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
          #else
              u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
          #endif
              u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_3.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_13;
          float u_xlat15;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_13 = max(u_xlat16_13, 0.0);
              u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
              u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_13) + u_xlat16_1.xyz;
              u_xlat16_3.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
              u_xlat15 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
          #else
              u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
          #endif
              u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_3.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_13;
          float u_xlat15;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_13 = max(u_xlat16_13, 0.0);
              u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
              u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_13) + u_xlat16_1.xyz;
              u_xlat16_3.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
              u_xlat15 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
          #else
              u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
          #endif
              u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_3.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D unity_DynamicLightmap;
          uniform sampler2D unity_DynamicDirectionality;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            mediump vec3 normalWorld_8;
            normalWorld_8 = tmpvar_4;
            mediump vec4 realtimeDirTex_9;
            mediump vec3 tmpvar_10;
            lowp vec4 tmpvar_11;
            tmpvar_11 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            lowp vec4 tmpvar_12;
            tmpvar_12 = texture2D (unity_DynamicDirectionality, xlv_TEXCOORD5.zw);
            realtimeDirTex_9 = tmpvar_12;
            lowp vec4 dirTex_13;
            dirTex_13 = realtimeDirTex_9;
            lowp vec3 y_14;
            y_14 = (dirTex_13.xyz - 0.5);
            lowp float tmpvar_15;
            tmpvar_15 = max (0.0001, dirTex_13.w);
            tmpvar_10 = ((pow (
              ((unity_DynamicLightmap_HDR.x * tmpvar_11.w) * tmpvar_11.xyz)
            , unity_DynamicLightmap_HDR.yyy) * (
              dot (normalWorld_8, y_14)
             + 0.5)) / tmpvar_15);
            lowp vec4 c_16;
            lowp vec4 c_17;
            lowp float diff_18;
            mediump float tmpvar_19;
            tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_18 = tmpvar_19;
            c_17.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_18);
            c_17.w = tmpvar_7.w;
            c_16.w = c_17.w;
            c_16.xyz = (c_17.xyz + (tmpvar_7.xyz * tmpvar_10));
            c_3.w = c_16.w;
            highp float tmpvar_20;
            tmpvar_20 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_16.xyz, vec3(tmpvar_20));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D unity_DynamicLightmap;
          uniform sampler2D unity_DynamicDirectionality;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            mediump vec3 normalWorld_8;
            normalWorld_8 = tmpvar_4;
            mediump vec4 realtimeDirTex_9;
            mediump vec3 tmpvar_10;
            lowp vec4 tmpvar_11;
            tmpvar_11 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            lowp vec4 tmpvar_12;
            tmpvar_12 = texture2D (unity_DynamicDirectionality, xlv_TEXCOORD5.zw);
            realtimeDirTex_9 = tmpvar_12;
            lowp vec4 dirTex_13;
            dirTex_13 = realtimeDirTex_9;
            lowp vec3 y_14;
            y_14 = (dirTex_13.xyz - 0.5);
            lowp float tmpvar_15;
            tmpvar_15 = max (0.0001, dirTex_13.w);
            tmpvar_10 = ((pow (
              ((unity_DynamicLightmap_HDR.x * tmpvar_11.w) * tmpvar_11.xyz)
            , unity_DynamicLightmap_HDR.yyy) * (
              dot (normalWorld_8, y_14)
             + 0.5)) / tmpvar_15);
            lowp vec4 c_16;
            lowp vec4 c_17;
            lowp float diff_18;
            mediump float tmpvar_19;
            tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_18 = tmpvar_19;
            c_17.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_18);
            c_17.w = tmpvar_7.w;
            c_16.w = c_17.w;
            c_16.xyz = (c_17.xyz + (tmpvar_7.xyz * tmpvar_10));
            c_3.w = c_16.w;
            highp float tmpvar_20;
            tmpvar_20 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_16.xyz, vec3(tmpvar_20));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D unity_DynamicLightmap;
          uniform sampler2D unity_DynamicDirectionality;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            mediump vec3 normalWorld_8;
            normalWorld_8 = tmpvar_4;
            mediump vec4 realtimeDirTex_9;
            mediump vec3 tmpvar_10;
            lowp vec4 tmpvar_11;
            tmpvar_11 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            lowp vec4 tmpvar_12;
            tmpvar_12 = texture2D (unity_DynamicDirectionality, xlv_TEXCOORD5.zw);
            realtimeDirTex_9 = tmpvar_12;
            lowp vec4 dirTex_13;
            dirTex_13 = realtimeDirTex_9;
            lowp vec3 y_14;
            y_14 = (dirTex_13.xyz - 0.5);
            lowp float tmpvar_15;
            tmpvar_15 = max (0.0001, dirTex_13.w);
            tmpvar_10 = ((pow (
              ((unity_DynamicLightmap_HDR.x * tmpvar_11.w) * tmpvar_11.xyz)
            , unity_DynamicLightmap_HDR.yyy) * (
              dot (normalWorld_8, y_14)
             + 0.5)) / tmpvar_15);
            lowp vec4 c_16;
            lowp vec4 c_17;
            lowp float diff_18;
            mediump float tmpvar_19;
            tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_18 = tmpvar_19;
            c_17.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_18);
            c_17.w = tmpvar_7.w;
            c_16.w = c_17.w;
            c_16.xyz = (c_17.xyz + (tmpvar_7.xyz * tmpvar_10));
            c_3.w = c_16.w;
            highp float tmpvar_20;
            tmpvar_20 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_16.xyz, vec3(tmpvar_20));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          uniform lowp sampler2D unity_DynamicDirectionality;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          vec4 u_xlat1;
          mediump vec3 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat12;
          mediump float u_xlat16_13;
          mediump float u_xlat16_14;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(unity_DynamicDirectionality, vs_TEXCOORD6.zw);
              u_xlat16_2.xyz = u_xlat10_0.xyz + vec3(-0.5, -0.5, -0.5);
              u_xlat16_0.x = max(u_xlat10_0.w, 9.99999975e-05);
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
              u_xlat16_13 = u_xlat16_13 + 0.5;
              u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
              u_xlat16_0.xyz = u_xlat16_1.xyz / u_xlat16_0.xxx;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
              u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_14 = max(u_xlat16_14, 0.0);
              u_xlat16_3.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
              u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
              u_xlat12 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
          #else
              u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          uniform lowp sampler2D unity_DynamicDirectionality;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          vec4 u_xlat1;
          mediump vec3 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat12;
          mediump float u_xlat16_13;
          mediump float u_xlat16_14;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(unity_DynamicDirectionality, vs_TEXCOORD6.zw);
              u_xlat16_2.xyz = u_xlat10_0.xyz + vec3(-0.5, -0.5, -0.5);
              u_xlat16_0.x = max(u_xlat10_0.w, 9.99999975e-05);
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
              u_xlat16_13 = u_xlat16_13 + 0.5;
              u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
              u_xlat16_0.xyz = u_xlat16_1.xyz / u_xlat16_0.xxx;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
              u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_14 = max(u_xlat16_14, 0.0);
              u_xlat16_3.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
              u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
              u_xlat12 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
          #else
              u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          uniform lowp sampler2D unity_DynamicDirectionality;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          vec4 u_xlat1;
          mediump vec3 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat12;
          mediump float u_xlat16_13;
          mediump float u_xlat16_14;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(unity_DynamicDirectionality, vs_TEXCOORD6.zw);
              u_xlat16_2.xyz = u_xlat10_0.xyz + vec3(-0.5, -0.5, -0.5);
              u_xlat16_0.x = max(u_xlat10_0.w, 9.99999975e-05);
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
              u_xlat16_13 = u_xlat16_13 + 0.5;
              u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
              u_xlat16_0.xyz = u_xlat16_1.xyz / u_xlat16_0.xxx;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
              u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_14 = max(u_xlat16_14, 0.0);
              u_xlat16_3.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
              u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
              u_xlat12 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
          #else
              u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp vec4 unity_4LightPosX0;
          uniform highp vec4 unity_4LightPosY0;
          uniform highp vec4 unity_4LightPosZ0;
          uniform mediump vec4 unity_4LightAtten0;
          uniform mediump vec4 unity_LightColor[8];
          uniform mediump vec4 unity_SHAr;
          uniform mediump vec4 unity_SHAg;
          uniform mediump vec4 unity_SHAb;
          uniform mediump vec4 unity_SHBr;
          uniform mediump vec4 unity_SHBg;
          uniform mediump vec4 unity_SHBb;
          uniform mediump vec4 unity_SHC;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            mediump vec3 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp vec3 tmpvar_5;
            tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
            highp mat3 tmpvar_6;
            tmpvar_6[0] = unity_WorldToObject[0].xyz;
            tmpvar_6[1] = unity_WorldToObject[1].xyz;
            tmpvar_6[2] = unity_WorldToObject[2].xyz;
            highp vec3 tmpvar_7;
            tmpvar_7 = normalize((_glesNormal * tmpvar_6));
            tmpvar_1.xyz = tmpvar_5;
            highp vec3 lightColor0_8;
            lightColor0_8 = unity_LightColor[0].xyz;
            highp vec3 lightColor1_9;
            lightColor1_9 = unity_LightColor[1].xyz;
            highp vec3 lightColor2_10;
            lightColor2_10 = unity_LightColor[2].xyz;
            highp vec3 lightColor3_11;
            lightColor3_11 = unity_LightColor[3].xyz;
            highp vec4 lightAttenSq_12;
            lightAttenSq_12 = unity_4LightAtten0;
            highp vec3 col_13;
            highp vec4 ndotl_14;
            highp vec4 lengthSq_15;
            highp vec4 tmpvar_16;
            tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
            highp vec4 tmpvar_17;
            tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
            highp vec4 tmpvar_18;
            tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
            lengthSq_15 = (tmpvar_16 * tmpvar_16);
            lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
            lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
            highp vec4 tmpvar_19;
            tmpvar_19 = max (lengthSq_15, vec4(1e-6, 1e-6, 1e-6, 1e-6));
            lengthSq_15 = tmpvar_19;
            ndotl_14 = (tmpvar_16 * tmpvar_7.x);
            ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
            ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
            highp vec4 tmpvar_20;
            tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
            ndotl_14 = tmpvar_20;
            highp vec4 tmpvar_21;
            tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
              (tmpvar_19 * lightAttenSq_12)
            ))));
            col_13 = (lightColor0_8 * tmpvar_21.x);
            col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
            col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
            col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
            tmpvar_2 = col_13;
            mediump vec3 normal_22;
            normal_22 = tmpvar_7;
            mediump vec3 ambient_23;
            mediump vec4 tmpvar_24;
            tmpvar_24.w = 1.0;
            tmpvar_24.xyz = normal_22;
            mediump vec3 res_25;
            mediump vec3 x_26;
            x_26.x = dot (unity_SHAr, tmpvar_24);
            x_26.y = dot (unity_SHAg, tmpvar_24);
            x_26.z = dot (unity_SHAb, tmpvar_24);
            mediump vec3 x1_27;
            mediump vec4 tmpvar_28;
            tmpvar_28 = (normal_22.xyzz * normal_22.yzzx);
            x1_27.x = dot (unity_SHBr, tmpvar_28);
            x1_27.y = dot (unity_SHBg, tmpvar_28);
            x1_27.z = dot (unity_SHBb, tmpvar_28);
            res_25 = (x_26 + (x1_27 + (unity_SHC.xyz * 
              ((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
            )));
            mediump vec3 tmpvar_29;
            tmpvar_29 = max (((1.055 * 
              pow (max (res_25, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
            ) - 0.055), vec3(0.0, 0.0, 0.0));
            res_25 = tmpvar_29;
            ambient_23 = (tmpvar_2 + max (vec3(0.0, 0.0, 0.0), tmpvar_29));
            tmpvar_2 = ambient_23;
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_7;
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD3 = ambient_23;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            lowp vec4 c_8;
            lowp vec4 c_9;
            lowp float diff_10;
            mediump float tmpvar_11;
            tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_10 = tmpvar_11;
            c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
            c_9.w = tmpvar_7.w;
            c_8.w = c_9.w;
            c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
            c_3.w = c_8.w;
            highp float tmpvar_12;
            tmpvar_12 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp vec4 unity_4LightPosX0;
          uniform highp vec4 unity_4LightPosY0;
          uniform highp vec4 unity_4LightPosZ0;
          uniform mediump vec4 unity_4LightAtten0;
          uniform mediump vec4 unity_LightColor[8];
          uniform mediump vec4 unity_SHAr;
          uniform mediump vec4 unity_SHAg;
          uniform mediump vec4 unity_SHAb;
          uniform mediump vec4 unity_SHBr;
          uniform mediump vec4 unity_SHBg;
          uniform mediump vec4 unity_SHBb;
          uniform mediump vec4 unity_SHC;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            mediump vec3 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp vec3 tmpvar_5;
            tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
            highp mat3 tmpvar_6;
            tmpvar_6[0] = unity_WorldToObject[0].xyz;
            tmpvar_6[1] = unity_WorldToObject[1].xyz;
            tmpvar_6[2] = unity_WorldToObject[2].xyz;
            highp vec3 tmpvar_7;
            tmpvar_7 = normalize((_glesNormal * tmpvar_6));
            tmpvar_1.xyz = tmpvar_5;
            highp vec3 lightColor0_8;
            lightColor0_8 = unity_LightColor[0].xyz;
            highp vec3 lightColor1_9;
            lightColor1_9 = unity_LightColor[1].xyz;
            highp vec3 lightColor2_10;
            lightColor2_10 = unity_LightColor[2].xyz;
            highp vec3 lightColor3_11;
            lightColor3_11 = unity_LightColor[3].xyz;
            highp vec4 lightAttenSq_12;
            lightAttenSq_12 = unity_4LightAtten0;
            highp vec3 col_13;
            highp vec4 ndotl_14;
            highp vec4 lengthSq_15;
            highp vec4 tmpvar_16;
            tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
            highp vec4 tmpvar_17;
            tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
            highp vec4 tmpvar_18;
            tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
            lengthSq_15 = (tmpvar_16 * tmpvar_16);
            lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
            lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
            highp vec4 tmpvar_19;
            tmpvar_19 = max (lengthSq_15, vec4(1e-6, 1e-6, 1e-6, 1e-6));
            lengthSq_15 = tmpvar_19;
            ndotl_14 = (tmpvar_16 * tmpvar_7.x);
            ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
            ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
            highp vec4 tmpvar_20;
            tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
            ndotl_14 = tmpvar_20;
            highp vec4 tmpvar_21;
            tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
              (tmpvar_19 * lightAttenSq_12)
            ))));
            col_13 = (lightColor0_8 * tmpvar_21.x);
            col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
            col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
            col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
            tmpvar_2 = col_13;
            mediump vec3 normal_22;
            normal_22 = tmpvar_7;
            mediump vec3 ambient_23;
            mediump vec4 tmpvar_24;
            tmpvar_24.w = 1.0;
            tmpvar_24.xyz = normal_22;
            mediump vec3 res_25;
            mediump vec3 x_26;
            x_26.x = dot (unity_SHAr, tmpvar_24);
            x_26.y = dot (unity_SHAg, tmpvar_24);
            x_26.z = dot (unity_SHAb, tmpvar_24);
            mediump vec3 x1_27;
            mediump vec4 tmpvar_28;
            tmpvar_28 = (normal_22.xyzz * normal_22.yzzx);
            x1_27.x = dot (unity_SHBr, tmpvar_28);
            x1_27.y = dot (unity_SHBg, tmpvar_28);
            x1_27.z = dot (unity_SHBb, tmpvar_28);
            res_25 = (x_26 + (x1_27 + (unity_SHC.xyz * 
              ((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
            )));
            mediump vec3 tmpvar_29;
            tmpvar_29 = max (((1.055 * 
              pow (max (res_25, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
            ) - 0.055), vec3(0.0, 0.0, 0.0));
            res_25 = tmpvar_29;
            ambient_23 = (tmpvar_2 + max (vec3(0.0, 0.0, 0.0), tmpvar_29));
            tmpvar_2 = ambient_23;
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_7;
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD3 = ambient_23;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            lowp vec4 c_8;
            lowp vec4 c_9;
            lowp float diff_10;
            mediump float tmpvar_11;
            tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_10 = tmpvar_11;
            c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
            c_9.w = tmpvar_7.w;
            c_8.w = c_9.w;
            c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
            c_3.w = c_8.w;
            highp float tmpvar_12;
            tmpvar_12 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp vec4 unity_4LightPosX0;
          uniform highp vec4 unity_4LightPosY0;
          uniform highp vec4 unity_4LightPosZ0;
          uniform mediump vec4 unity_4LightAtten0;
          uniform mediump vec4 unity_LightColor[8];
          uniform mediump vec4 unity_SHAr;
          uniform mediump vec4 unity_SHAg;
          uniform mediump vec4 unity_SHAb;
          uniform mediump vec4 unity_SHBr;
          uniform mediump vec4 unity_SHBg;
          uniform mediump vec4 unity_SHBb;
          uniform mediump vec4 unity_SHC;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            mediump vec3 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp vec3 tmpvar_5;
            tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
            highp mat3 tmpvar_6;
            tmpvar_6[0] = unity_WorldToObject[0].xyz;
            tmpvar_6[1] = unity_WorldToObject[1].xyz;
            tmpvar_6[2] = unity_WorldToObject[2].xyz;
            highp vec3 tmpvar_7;
            tmpvar_7 = normalize((_glesNormal * tmpvar_6));
            tmpvar_1.xyz = tmpvar_5;
            highp vec3 lightColor0_8;
            lightColor0_8 = unity_LightColor[0].xyz;
            highp vec3 lightColor1_9;
            lightColor1_9 = unity_LightColor[1].xyz;
            highp vec3 lightColor2_10;
            lightColor2_10 = unity_LightColor[2].xyz;
            highp vec3 lightColor3_11;
            lightColor3_11 = unity_LightColor[3].xyz;
            highp vec4 lightAttenSq_12;
            lightAttenSq_12 = unity_4LightAtten0;
            highp vec3 col_13;
            highp vec4 ndotl_14;
            highp vec4 lengthSq_15;
            highp vec4 tmpvar_16;
            tmpvar_16 = (unity_4LightPosX0 - tmpvar_5.x);
            highp vec4 tmpvar_17;
            tmpvar_17 = (unity_4LightPosY0 - tmpvar_5.y);
            highp vec4 tmpvar_18;
            tmpvar_18 = (unity_4LightPosZ0 - tmpvar_5.z);
            lengthSq_15 = (tmpvar_16 * tmpvar_16);
            lengthSq_15 = (lengthSq_15 + (tmpvar_17 * tmpvar_17));
            lengthSq_15 = (lengthSq_15 + (tmpvar_18 * tmpvar_18));
            highp vec4 tmpvar_19;
            tmpvar_19 = max (lengthSq_15, vec4(1e-6, 1e-6, 1e-6, 1e-6));
            lengthSq_15 = tmpvar_19;
            ndotl_14 = (tmpvar_16 * tmpvar_7.x);
            ndotl_14 = (ndotl_14 + (tmpvar_17 * tmpvar_7.y));
            ndotl_14 = (ndotl_14 + (tmpvar_18 * tmpvar_7.z));
            highp vec4 tmpvar_20;
            tmpvar_20 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_14 * inversesqrt(tmpvar_19)));
            ndotl_14 = tmpvar_20;
            highp vec4 tmpvar_21;
            tmpvar_21 = (tmpvar_20 * (1.0/((1.0 + 
              (tmpvar_19 * lightAttenSq_12)
            ))));
            col_13 = (lightColor0_8 * tmpvar_21.x);
            col_13 = (col_13 + (lightColor1_9 * tmpvar_21.y));
            col_13 = (col_13 + (lightColor2_10 * tmpvar_21.z));
            col_13 = (col_13 + (lightColor3_11 * tmpvar_21.w));
            tmpvar_2 = col_13;
            mediump vec3 normal_22;
            normal_22 = tmpvar_7;
            mediump vec3 ambient_23;
            mediump vec4 tmpvar_24;
            tmpvar_24.w = 1.0;
            tmpvar_24.xyz = normal_22;
            mediump vec3 res_25;
            mediump vec3 x_26;
            x_26.x = dot (unity_SHAr, tmpvar_24);
            x_26.y = dot (unity_SHAg, tmpvar_24);
            x_26.z = dot (unity_SHAb, tmpvar_24);
            mediump vec3 x1_27;
            mediump vec4 tmpvar_28;
            tmpvar_28 = (normal_22.xyzz * normal_22.yzzx);
            x1_27.x = dot (unity_SHBr, tmpvar_28);
            x1_27.y = dot (unity_SHBg, tmpvar_28);
            x1_27.z = dot (unity_SHBb, tmpvar_28);
            res_25 = (x_26 + (x1_27 + (unity_SHC.xyz * 
              ((normal_22.x * normal_22.x) - (normal_22.y * normal_22.y))
            )));
            mediump vec3 tmpvar_29;
            tmpvar_29 = max (((1.055 * 
              pow (max (res_25, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
            ) - 0.055), vec3(0.0, 0.0, 0.0));
            res_25 = tmpvar_29;
            ambient_23 = (tmpvar_2 + max (vec3(0.0, 0.0, 0.0), tmpvar_29));
            tmpvar_2 = ambient_23;
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_7;
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD3 = ambient_23;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            lowp vec4 c_8;
            lowp vec4 c_9;
            lowp float diff_10;
            mediump float tmpvar_11;
            tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_10 = tmpvar_11;
            c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
            c_9.w = tmpvar_7.w;
            c_8.w = c_9.w;
            c_8.xyz = (c_9.xyz + (tmpvar_7.xyz * xlv_TEXCOORD3));
            c_3.w = c_8.w;
            highp float tmpvar_12;
            tmpvar_12 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_8.xyz, vec3(tmpvar_12));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 unity_4LightPosX0;
          uniform 	vec4 unity_4LightPosY0;
          uniform 	vec4 unity_4LightPosZ0;
          uniform 	mediump vec4 unity_4LightAtten0;
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	mediump vec4 unity_SHAr;
          uniform 	mediump vec4 unity_SHAg;
          uniform 	mediump vec4 unity_SHAb;
          uniform 	mediump vec4 unity_SHBr;
          uniform 	mediump vec4 unity_SHBg;
          uniform 	mediump vec4 unity_SHBb;
          uniform 	mediump vec4 unity_SHC;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec4 u_xlat16_2;
          vec4 u_xlat3;
          vec4 u_xlat4;
          mediump vec3 u_xlat16_5;
          mediump vec3 u_xlat16_6;
          float u_xlat21;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat21 = inversesqrt(u_xlat21);
              u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
              vs_TEXCOORD1.xyz = u_xlat1.xyz;
              vs_TEXCOORD2.xyz = u_xlat0.xyz;
              u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
              u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
              u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
              u_xlat4 = u_xlat1.yyyy * u_xlat3;
              u_xlat3 = u_xlat3 * u_xlat3;
              u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
              u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
              u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
              u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
              u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
              u_xlat3 = inversesqrt(u_xlat0);
              u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
              u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
              u_xlat2 = u_xlat2 * u_xlat3;
              u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
              u_xlat0 = u_xlat0 * u_xlat2;
              u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
              u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
              u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
              u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
              u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
              u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
              u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
              u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
              u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
              u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
              u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
              u_xlat1.w = 1.0;
              u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
              u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
              u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
              u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
              u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
              u_xlat1.xyz = log2(u_xlat16_5.xyz);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
              u_xlat1.xyz = exp2(u_xlat1.xyz);
              u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
              u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
              vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          vec4 u_xlat1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump vec3 u_xlat16_4;
          float u_xlat15;
          void main()
          {
              u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_4.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
              u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
              u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
              u_xlat15 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
          #else
              u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat15) * u_xlat16_3.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 unity_4LightPosX0;
          uniform 	vec4 unity_4LightPosY0;
          uniform 	vec4 unity_4LightPosZ0;
          uniform 	mediump vec4 unity_4LightAtten0;
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	mediump vec4 unity_SHAr;
          uniform 	mediump vec4 unity_SHAg;
          uniform 	mediump vec4 unity_SHAb;
          uniform 	mediump vec4 unity_SHBr;
          uniform 	mediump vec4 unity_SHBg;
          uniform 	mediump vec4 unity_SHBb;
          uniform 	mediump vec4 unity_SHC;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec4 u_xlat16_2;
          vec4 u_xlat3;
          vec4 u_xlat4;
          mediump vec3 u_xlat16_5;
          mediump vec3 u_xlat16_6;
          float u_xlat21;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat21 = inversesqrt(u_xlat21);
              u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
              vs_TEXCOORD1.xyz = u_xlat1.xyz;
              vs_TEXCOORD2.xyz = u_xlat0.xyz;
              u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
              u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
              u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
              u_xlat4 = u_xlat1.yyyy * u_xlat3;
              u_xlat3 = u_xlat3 * u_xlat3;
              u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
              u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
              u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
              u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
              u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
              u_xlat3 = inversesqrt(u_xlat0);
              u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
              u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
              u_xlat2 = u_xlat2 * u_xlat3;
              u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
              u_xlat0 = u_xlat0 * u_xlat2;
              u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
              u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
              u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
              u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
              u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
              u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
              u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
              u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
              u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
              u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
              u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
              u_xlat1.w = 1.0;
              u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
              u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
              u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
              u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
              u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
              u_xlat1.xyz = log2(u_xlat16_5.xyz);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
              u_xlat1.xyz = exp2(u_xlat1.xyz);
              u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
              u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
              vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          vec4 u_xlat1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump vec3 u_xlat16_4;
          float u_xlat15;
          void main()
          {
              u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_4.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
              u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
              u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
              u_xlat15 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
          #else
              u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat15) * u_xlat16_3.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 unity_4LightPosX0;
          uniform 	vec4 unity_4LightPosY0;
          uniform 	vec4 unity_4LightPosZ0;
          uniform 	mediump vec4 unity_4LightAtten0;
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	mediump vec4 unity_SHAr;
          uniform 	mediump vec4 unity_SHAg;
          uniform 	mediump vec4 unity_SHAb;
          uniform 	mediump vec4 unity_SHBr;
          uniform 	mediump vec4 unity_SHBg;
          uniform 	mediump vec4 unity_SHBb;
          uniform 	mediump vec4 unity_SHC;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec4 u_xlat16_2;
          vec4 u_xlat3;
          vec4 u_xlat4;
          mediump vec3 u_xlat16_5;
          mediump vec3 u_xlat16_6;
          float u_xlat21;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat21 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat21 = inversesqrt(u_xlat21);
              u_xlat1.xyz = vec3(u_xlat21) * u_xlat1.xyz;
              vs_TEXCOORD1.xyz = u_xlat1.xyz;
              vs_TEXCOORD2.xyz = u_xlat0.xyz;
              u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
              u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
              u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
              u_xlat4 = u_xlat1.yyyy * u_xlat3;
              u_xlat3 = u_xlat3 * u_xlat3;
              u_xlat3 = u_xlat2 * u_xlat2 + u_xlat3;
              u_xlat2 = u_xlat2 * u_xlat1.xxxx + u_xlat4;
              u_xlat2 = u_xlat0 * u_xlat1.zzzz + u_xlat2;
              u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
              u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
              u_xlat3 = inversesqrt(u_xlat0);
              u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
              u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
              u_xlat2 = u_xlat2 * u_xlat3;
              u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
              u_xlat0 = u_xlat0 * u_xlat2;
              u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
              u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
              u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
              u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
              u_xlat16_5.x = u_xlat1.y * u_xlat1.y;
              u_xlat16_5.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_5.x);
              u_xlat16_2 = u_xlat1.yzzx * u_xlat1.xyzz;
              u_xlat16_6.x = dot(unity_SHBr, u_xlat16_2);
              u_xlat16_6.y = dot(unity_SHBg, u_xlat16_2);
              u_xlat16_6.z = dot(unity_SHBb, u_xlat16_2);
              u_xlat16_5.xyz = unity_SHC.xyz * u_xlat16_5.xxx + u_xlat16_6.xyz;
              u_xlat1.w = 1.0;
              u_xlat16_6.x = dot(unity_SHAr, u_xlat1);
              u_xlat16_6.y = dot(unity_SHAg, u_xlat1);
              u_xlat16_6.z = dot(unity_SHAb, u_xlat1);
              u_xlat16_5.xyz = u_xlat16_5.xyz + u_xlat16_6.xyz;
              u_xlat16_5.xyz = max(u_xlat16_5.xyz, vec3(0.0, 0.0, 0.0));
              u_xlat1.xyz = log2(u_xlat16_5.xyz);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
              u_xlat1.xyz = exp2(u_xlat1.xyz);
              u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
              u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
              vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          vec4 u_xlat1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump vec3 u_xlat16_4;
          float u_xlat15;
          void main()
          {
              u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_4.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat1.xyz * vs_TEXCOORD3.xyz;
              u_xlat16_0.xyz = u_xlat16_4.xyz * u_xlat16_0.xxx + u_xlat16_2.xyz;
              u_xlat16_3.xyz = u_xlat16_0.xyz + (-unity_FogColor.xyz);
              u_xlat15 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
          #else
              u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat15) * u_xlat16_3.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D unity_DynamicLightmap;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            mediump vec3 tmpvar_8;
            lowp vec4 tmpvar_9;
            tmpvar_9 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            tmpvar_8 = pow (((unity_DynamicLightmap_HDR.x * tmpvar_9.w) * tmpvar_9.xyz), unity_DynamicLightmap_HDR.yyy);
            lowp vec4 c_10;
            lowp vec4 c_11;
            lowp float diff_12;
            mediump float tmpvar_13;
            tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_12 = tmpvar_13;
            c_11.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_12);
            c_11.w = tmpvar_7.w;
            c_10.w = c_11.w;
            c_10.xyz = (c_11.xyz + (tmpvar_7.xyz * tmpvar_8));
            c_3.w = c_10.w;
            highp float tmpvar_14;
            tmpvar_14 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_10.xyz, vec3(tmpvar_14));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D unity_DynamicLightmap;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            mediump vec3 tmpvar_8;
            lowp vec4 tmpvar_9;
            tmpvar_9 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            tmpvar_8 = pow (((unity_DynamicLightmap_HDR.x * tmpvar_9.w) * tmpvar_9.xyz), unity_DynamicLightmap_HDR.yyy);
            lowp vec4 c_10;
            lowp vec4 c_11;
            lowp float diff_12;
            mediump float tmpvar_13;
            tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_12 = tmpvar_13;
            c_11.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_12);
            c_11.w = tmpvar_7.w;
            c_10.w = c_11.w;
            c_10.xyz = (c_11.xyz + (tmpvar_7.xyz * tmpvar_8));
            c_3.w = c_10.w;
            highp float tmpvar_14;
            tmpvar_14 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_10.xyz, vec3(tmpvar_14));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D unity_DynamicLightmap;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            mediump vec3 tmpvar_8;
            lowp vec4 tmpvar_9;
            tmpvar_9 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            tmpvar_8 = pow (((unity_DynamicLightmap_HDR.x * tmpvar_9.w) * tmpvar_9.xyz), unity_DynamicLightmap_HDR.yyy);
            lowp vec4 c_10;
            lowp vec4 c_11;
            lowp float diff_12;
            mediump float tmpvar_13;
            tmpvar_13 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_12 = tmpvar_13;
            c_11.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_12);
            c_11.w = tmpvar_7.w;
            c_10.w = c_11.w;
            c_10.xyz = (c_11.xyz + (tmpvar_7.xyz * tmpvar_8));
            c_3.w = c_10.w;
            highp float tmpvar_14;
            tmpvar_14 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_10.xyz, vec3(tmpvar_14));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_13;
          float u_xlat15;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_13 = max(u_xlat16_13, 0.0);
              u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
              u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_13) + u_xlat16_1.xyz;
              u_xlat16_3.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
              u_xlat15 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
          #else
              u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
          #endif
              u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_3.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_13;
          float u_xlat15;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_13 = max(u_xlat16_13, 0.0);
              u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
              u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_13) + u_xlat16_1.xyz;
              u_xlat16_3.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
              u_xlat15 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
          #else
              u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
          #endif
              u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_3.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_13;
          float u_xlat15;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_13 = max(u_xlat16_13, 0.0);
              u_xlat16_2.xyz = u_xlat0.xyz * _LightColor0.xyz;
              u_xlat16_1.xyz = u_xlat16_2.xyz * vec3(u_xlat16_13) + u_xlat16_1.xyz;
              u_xlat16_3.xyz = u_xlat16_1.xyz + (-unity_FogColor.xyz);
              u_xlat15 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat15 = min(max(u_xlat15, 0.0), 1.0);
          #else
              u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
          #endif
              u_xlat0.xyz = vec3(u_xlat15) * u_xlat16_3.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D unity_DynamicLightmap;
          uniform sampler2D unity_DynamicDirectionality;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            mediump vec3 normalWorld_8;
            normalWorld_8 = tmpvar_4;
            mediump vec4 realtimeDirTex_9;
            mediump vec3 tmpvar_10;
            lowp vec4 tmpvar_11;
            tmpvar_11 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            lowp vec4 tmpvar_12;
            tmpvar_12 = texture2D (unity_DynamicDirectionality, xlv_TEXCOORD5.zw);
            realtimeDirTex_9 = tmpvar_12;
            lowp vec4 dirTex_13;
            dirTex_13 = realtimeDirTex_9;
            lowp vec3 y_14;
            y_14 = (dirTex_13.xyz - 0.5);
            lowp float tmpvar_15;
            tmpvar_15 = max (0.0001, dirTex_13.w);
            tmpvar_10 = ((pow (
              ((unity_DynamicLightmap_HDR.x * tmpvar_11.w) * tmpvar_11.xyz)
            , unity_DynamicLightmap_HDR.yyy) * (
              dot (normalWorld_8, y_14)
             + 0.5)) / tmpvar_15);
            lowp vec4 c_16;
            lowp vec4 c_17;
            lowp float diff_18;
            mediump float tmpvar_19;
            tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_18 = tmpvar_19;
            c_17.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_18);
            c_17.w = tmpvar_7.w;
            c_16.w = c_17.w;
            c_16.xyz = (c_17.xyz + (tmpvar_7.xyz * tmpvar_10));
            c_3.w = c_16.w;
            highp float tmpvar_20;
            tmpvar_20 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_16.xyz, vec3(tmpvar_20));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D unity_DynamicLightmap;
          uniform sampler2D unity_DynamicDirectionality;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            mediump vec3 normalWorld_8;
            normalWorld_8 = tmpvar_4;
            mediump vec4 realtimeDirTex_9;
            mediump vec3 tmpvar_10;
            lowp vec4 tmpvar_11;
            tmpvar_11 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            lowp vec4 tmpvar_12;
            tmpvar_12 = texture2D (unity_DynamicDirectionality, xlv_TEXCOORD5.zw);
            realtimeDirTex_9 = tmpvar_12;
            lowp vec4 dirTex_13;
            dirTex_13 = realtimeDirTex_9;
            lowp vec3 y_14;
            y_14 = (dirTex_13.xyz - 0.5);
            lowp float tmpvar_15;
            tmpvar_15 = max (0.0001, dirTex_13.w);
            tmpvar_10 = ((pow (
              ((unity_DynamicLightmap_HDR.x * tmpvar_11.w) * tmpvar_11.xyz)
            , unity_DynamicLightmap_HDR.yyy) * (
              dot (normalWorld_8, y_14)
             + 0.5)) / tmpvar_15);
            lowp vec4 c_16;
            lowp vec4 c_17;
            lowp float diff_18;
            mediump float tmpvar_19;
            tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_18 = tmpvar_19;
            c_17.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_18);
            c_17.w = tmpvar_7.w;
            c_16.w = c_17.w;
            c_16.xyz = (c_17.xyz + (tmpvar_7.xyz * tmpvar_10));
            c_3.w = c_16.w;
            highp float tmpvar_20;
            tmpvar_20 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_16.xyz, vec3(tmpvar_20));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = _glesVertex.xyz;
            tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
            highp mat3 tmpvar_5;
            tmpvar_5[0] = unity_WorldToObject[0].xyz;
            tmpvar_5[1] = unity_WorldToObject[1].xyz;
            tmpvar_5[2] = unity_WorldToObject[2].xyz;
            tmpvar_1.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
            tmpvar_2.zw = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
            tmpvar_1.w = ((tmpvar_3.z * unity_FogParams.z) + unity_FogParams.w);
            gl_Position = tmpvar_3;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_5));
            xlv_TEXCOORD2 = tmpvar_1;
            xlv_TEXCOORD5 = tmpvar_2;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D unity_DynamicLightmap;
          uniform sampler2D unity_DynamicDirectionality;
          uniform mediump vec4 unity_DynamicLightmap_HDR;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec4 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD5;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            mediump vec3 normalWorld_8;
            normalWorld_8 = tmpvar_4;
            mediump vec4 realtimeDirTex_9;
            mediump vec3 tmpvar_10;
            lowp vec4 tmpvar_11;
            tmpvar_11 = texture2D (unity_DynamicLightmap, xlv_TEXCOORD5.zw);
            lowp vec4 tmpvar_12;
            tmpvar_12 = texture2D (unity_DynamicDirectionality, xlv_TEXCOORD5.zw);
            realtimeDirTex_9 = tmpvar_12;
            lowp vec4 dirTex_13;
            dirTex_13 = realtimeDirTex_9;
            lowp vec3 y_14;
            y_14 = (dirTex_13.xyz - 0.5);
            lowp float tmpvar_15;
            tmpvar_15 = max (0.0001, dirTex_13.w);
            tmpvar_10 = ((pow (
              ((unity_DynamicLightmap_HDR.x * tmpvar_11.w) * tmpvar_11.xyz)
            , unity_DynamicLightmap_HDR.yyy) * (
              dot (normalWorld_8, y_14)
             + 0.5)) / tmpvar_15);
            lowp vec4 c_16;
            lowp vec4 c_17;
            lowp float diff_18;
            mediump float tmpvar_19;
            tmpvar_19 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_18 = tmpvar_19;
            c_17.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_18);
            c_17.w = tmpvar_7.w;
            c_16.w = c_17.w;
            c_16.xyz = (c_17.xyz + (tmpvar_7.xyz * tmpvar_10));
            c_3.w = c_16.w;
            highp float tmpvar_20;
            tmpvar_20 = clamp (xlv_TEXCOORD2.w, 0.0, 1.0);
            c_3.xyz = mix (unity_FogColor.xyz, c_16.xyz, vec3(tmpvar_20));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          uniform lowp sampler2D unity_DynamicDirectionality;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          vec4 u_xlat1;
          mediump vec3 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat12;
          mediump float u_xlat16_13;
          mediump float u_xlat16_14;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(unity_DynamicDirectionality, vs_TEXCOORD6.zw);
              u_xlat16_2.xyz = u_xlat10_0.xyz + vec3(-0.5, -0.5, -0.5);
              u_xlat16_0.x = max(u_xlat10_0.w, 9.99999975e-05);
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
              u_xlat16_13 = u_xlat16_13 + 0.5;
              u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
              u_xlat16_0.xyz = u_xlat16_1.xyz / u_xlat16_0.xxx;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
              u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_14 = max(u_xlat16_14, 0.0);
              u_xlat16_3.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
              u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
              u_xlat12 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
          #else
              u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          uniform lowp sampler2D unity_DynamicDirectionality;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          vec4 u_xlat1;
          mediump vec3 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat12;
          mediump float u_xlat16_13;
          mediump float u_xlat16_14;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(unity_DynamicDirectionality, vs_TEXCOORD6.zw);
              u_xlat16_2.xyz = u_xlat10_0.xyz + vec3(-0.5, -0.5, -0.5);
              u_xlat16_0.x = max(u_xlat10_0.w, 9.99999975e-05);
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
              u_xlat16_13 = u_xlat16_13 + 0.5;
              u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
              u_xlat16_0.xyz = u_xlat16_1.xyz / u_xlat16_0.xxx;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
              u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_14 = max(u_xlat16_14, 0.0);
              u_xlat16_3.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
              u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
              u_xlat12 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
          #else
              u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" "VERTEXLIGHT_ON" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD6;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              vs_TEXCOORD6.zw = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              vs_TEXCOORD6.xy = vec2(0.0, 0.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_DynamicLightmap_HDR;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform lowp sampler2D unity_DynamicLightmap;
          uniform lowp sampler2D unity_DynamicDirectionality;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec4 vs_TEXCOORD6;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          vec4 u_xlat1;
          mediump vec3 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          float u_xlat12;
          mediump float u_xlat16_13;
          mediump float u_xlat16_14;
          void main()
          {
              u_xlat10_0 = texture(unity_DynamicLightmap, vs_TEXCOORD6.zw);
              u_xlat16_1.x = u_xlat10_0.w * unity_DynamicLightmap_HDR.x;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xxx;
              u_xlat16_1.xyz = log2(u_xlat16_1.xyz);
              u_xlat16_1.xyz = u_xlat16_1.xyz * unity_DynamicLightmap_HDR.yyy;
              u_xlat16_1.xyz = exp2(u_xlat16_1.xyz);
              u_xlat10_0 = texture(unity_DynamicDirectionality, vs_TEXCOORD6.zw);
              u_xlat16_2.xyz = u_xlat10_0.xyz + vec3(-0.5, -0.5, -0.5);
              u_xlat16_0.x = max(u_xlat10_0.w, 9.99999975e-05);
              u_xlat16_13 = dot(vs_TEXCOORD1.xyz, u_xlat16_2.xyz);
              u_xlat16_13 = u_xlat16_13 + 0.5;
              u_xlat16_1.xyz = vec3(u_xlat16_13) * u_xlat16_1.xyz;
              u_xlat16_0.xyz = u_xlat16_1.xyz / u_xlat16_0.xxx;
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_0.xyz * u_xlat1.xyz;
              u_xlat16_14 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_14 = max(u_xlat16_14, 0.0);
              u_xlat16_3.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_2.xyz = u_xlat16_3.xyz * vec3(u_xlat16_14) + u_xlat16_2.xyz;
              u_xlat16_0.xyz = u_xlat16_2.xyz + (-unity_FogColor.xyz);
              u_xlat12 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat12 = min(max(u_xlat12, 0.0), 1.0);
          #else
              u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
          #endif
              u_xlat1.xyz = vec3(u_xlat12) * u_xlat16_0.xyz + unity_FogColor.xyz;
              SV_Target0 = u_xlat1;
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
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "DIRLIGHTMAP_COMBINED" "DYNAMICLIGHTMAP_ON" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
      }
      
    } // end phase
    Pass // ind: 2, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "FORWARDADD"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 200
      ZWrite Off
      Blend SrcAlpha One
      ColorMask  -1
      GpuProgramID 96156
      // m_ProgramMask = 6
      !!! *******************************************************************************************
      !!! Allow restore shader as UnityLab format - only available for DevX GameRecovery license type
      !!! *******************************************************************************************
      Program "vp"
      {
        SubProgram "gles hw_tier00"
        {
           Keywords { "POINT" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_3.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_3).xyz;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform highp mat4 unity_WorldToLight;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp float atten_3;
            highp vec3 lightCoord_4;
            lowp vec3 tmpvar_5;
            lowp vec3 lightDir_6;
            highp vec3 tmpvar_7;
            tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_6 = tmpvar_7;
            tmpvar_5 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_8;
            tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp vec4 tmpvar_9;
            tmpvar_9.w = 1.0;
            tmpvar_9.xyz = xlv_TEXCOORD2;
            lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
            highp float tmpvar_10;
            tmpvar_10 = texture2D (_LightTexture0, vec2(dot (lightCoord_4, lightCoord_4))).x;
            atten_3 = tmpvar_10;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_6;
            tmpvar_1 = (tmpvar_1 * atten_3);
            lowp vec4 c_11;
            lowp vec4 c_12;
            lowp float diff_13;
            mediump float tmpvar_14;
            tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
            diff_13 = tmpvar_14;
            c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
            c_12.w = tmpvar_8.w;
            c_11.w = c_12.w;
            c_11.xyz = c_12.xyz;
            gl_FragData[0] = c_11;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "POINT" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_3.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_3).xyz;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform highp mat4 unity_WorldToLight;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp float atten_3;
            highp vec3 lightCoord_4;
            lowp vec3 tmpvar_5;
            lowp vec3 lightDir_6;
            highp vec3 tmpvar_7;
            tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_6 = tmpvar_7;
            tmpvar_5 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_8;
            tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp vec4 tmpvar_9;
            tmpvar_9.w = 1.0;
            tmpvar_9.xyz = xlv_TEXCOORD2;
            lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
            highp float tmpvar_10;
            tmpvar_10 = texture2D (_LightTexture0, vec2(dot (lightCoord_4, lightCoord_4))).x;
            atten_3 = tmpvar_10;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_6;
            tmpvar_1 = (tmpvar_1 * atten_3);
            lowp vec4 c_11;
            lowp vec4 c_12;
            lowp float diff_13;
            mediump float tmpvar_14;
            tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
            diff_13 = tmpvar_14;
            c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
            c_12.w = tmpvar_8.w;
            c_11.w = c_12.w;
            c_11.xyz = c_12.xyz;
            gl_FragData[0] = c_11;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "POINT" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_3.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_3).xyz;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform highp mat4 unity_WorldToLight;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp float atten_3;
            highp vec3 lightCoord_4;
            lowp vec3 tmpvar_5;
            lowp vec3 lightDir_6;
            highp vec3 tmpvar_7;
            tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_6 = tmpvar_7;
            tmpvar_5 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_8;
            tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp vec4 tmpvar_9;
            tmpvar_9.w = 1.0;
            tmpvar_9.xyz = xlv_TEXCOORD2;
            lightCoord_4 = (unity_WorldToLight * tmpvar_9).xyz;
            highp float tmpvar_10;
            tmpvar_10 = texture2D (_LightTexture0, vec2(dot (lightCoord_4, lightCoord_4))).x;
            atten_3 = tmpvar_10;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_6;
            tmpvar_1 = (tmpvar_1 * atten_3);
            lowp vec4 c_11;
            lowp vec4 c_12;
            lowp float diff_13;
            mediump float tmpvar_14;
            tmpvar_14 = max (0.0, dot (tmpvar_5, tmpvar_2));
            diff_13 = tmpvar_14;
            c_12.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_13);
            c_12.w = tmpvar_8.w;
            c_11.w = c_12.w;
            c_11.xyz = c_12.xyz;
            gl_FragData[0] = c_11;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "POINT" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec3 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump float u_xlat16_1;
          mediump vec3 u_xlat16_3;
          float u_xlat6;
          void main()
          {
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              u_xlat16_1 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_1 = max(u_xlat16_1, 0.0);
              u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).x;
              u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "POINT" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec3 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump float u_xlat16_1;
          mediump vec3 u_xlat16_3;
          float u_xlat6;
          void main()
          {
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              u_xlat16_1 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_1 = max(u_xlat16_1, 0.0);
              u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).x;
              u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "POINT" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec3 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump float u_xlat16_1;
          mediump vec3 u_xlat16_3;
          float u_xlat6;
          void main()
          {
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              u_xlat16_1 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_1 = max(u_xlat16_1, 0.0);
              u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).x;
              u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            lowp vec4 c_7;
            lowp vec4 c_8;
            lowp float diff_9;
            mediump float tmpvar_10;
            tmpvar_10 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_9 = tmpvar_10;
            c_8.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_9);
            c_8.w = tmpvar_6.w;
            c_7.w = c_8.w;
            c_7.xyz = c_8.xyz;
            gl_FragData[0] = c_7;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            lowp vec4 c_7;
            lowp vec4 c_8;
            lowp float diff_9;
            mediump float tmpvar_10;
            tmpvar_10 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_9 = tmpvar_10;
            c_8.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_9);
            c_8.w = tmpvar_6.w;
            c_7.w = c_8.w;
            c_7.xyz = c_8.xyz;
            gl_FragData[0] = c_7;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            lowp vec3 lightDir_4;
            mediump vec3 tmpvar_5;
            tmpvar_5 = _WorldSpaceLightPos0.xyz;
            lightDir_4 = tmpvar_5;
            tmpvar_3 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_6;
            tmpvar_6 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_4;
            lowp vec4 c_7;
            lowp vec4 c_8;
            lowp float diff_9;
            mediump float tmpvar_10;
            tmpvar_10 = max (0.0, dot (tmpvar_3, tmpvar_2));
            diff_9 = tmpvar_10;
            c_8.xyz = ((tmpvar_6.xyz * tmpvar_1) * diff_9);
            c_8.w = tmpvar_6.w;
            c_7.w = c_8.w;
            c_7.xyz = c_8.xyz;
            gl_FragData[0] = c_7;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec4 u_xlat16_1;
          lowp vec4 u_xlat10_1;
          mediump vec3 u_xlat16_2;
          void main()
          {
              u_xlat16_0 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0 = max(u_xlat16_0, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_1 = u_xlat10_1 * _Color;
              u_xlat16_2.xyz = u_xlat16_1.xyz * _LightColor0.xyz;
              SV_Target0.w = u_xlat16_1.w;
              SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "SPOT" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_3.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_3);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp float atten_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            highp vec3 tmpvar_6;
            tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            lowp float tmpvar_8;
            highp vec4 tmpvar_9;
            tmpvar_9 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
            tmpvar_8 = tmpvar_9.w;
            lowp float tmpvar_10;
            highp vec4 tmpvar_11;
            tmpvar_11 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz)));
            tmpvar_10 = tmpvar_11.x;
            highp float tmpvar_12;
            tmpvar_12 = ((float(
              (xlv_TEXCOORD3.z > 0.0)
            ) * tmpvar_8) * tmpvar_10);
            atten_3 = tmpvar_12;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            tmpvar_1 = (tmpvar_1 * atten_3);
            lowp vec4 c_13;
            lowp vec4 c_14;
            lowp float diff_15;
            mediump float tmpvar_16;
            tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_15 = tmpvar_16;
            c_14.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_15);
            c_14.w = tmpvar_7.w;
            c_13.w = c_14.w;
            c_13.xyz = c_14.xyz;
            gl_FragData[0] = c_13;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "SPOT" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_3.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_3);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp float atten_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            highp vec3 tmpvar_6;
            tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            lowp float tmpvar_8;
            highp vec4 tmpvar_9;
            tmpvar_9 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
            tmpvar_8 = tmpvar_9.w;
            lowp float tmpvar_10;
            highp vec4 tmpvar_11;
            tmpvar_11 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz)));
            tmpvar_10 = tmpvar_11.x;
            highp float tmpvar_12;
            tmpvar_12 = ((float(
              (xlv_TEXCOORD3.z > 0.0)
            ) * tmpvar_8) * tmpvar_10);
            atten_3 = tmpvar_12;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            tmpvar_1 = (tmpvar_1 * atten_3);
            lowp vec4 c_13;
            lowp vec4 c_14;
            lowp float diff_15;
            mediump float tmpvar_16;
            tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_15 = tmpvar_16;
            c_14.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_15);
            c_14.w = tmpvar_7.w;
            c_13.w = c_14.w;
            c_13.xyz = c_14.xyz;
            gl_FragData[0] = c_13;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "SPOT" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_3.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_3);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp float atten_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            highp vec3 tmpvar_6;
            tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            lowp float tmpvar_8;
            highp vec4 tmpvar_9;
            tmpvar_9 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
            tmpvar_8 = tmpvar_9.w;
            lowp float tmpvar_10;
            highp vec4 tmpvar_11;
            tmpvar_11 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz)));
            tmpvar_10 = tmpvar_11.x;
            highp float tmpvar_12;
            tmpvar_12 = ((float(
              (xlv_TEXCOORD3.z > 0.0)
            ) * tmpvar_8) * tmpvar_10);
            atten_3 = tmpvar_12;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            tmpvar_1 = (tmpvar_1 * atten_3);
            lowp vec4 c_13;
            lowp vec4 c_14;
            lowp float diff_15;
            mediump float tmpvar_16;
            tmpvar_16 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_15 = tmpvar_16;
            c_14.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_15);
            c_14.w = tmpvar_7.w;
            c_13.w = c_14.w;
            c_13.xyz = c_14.xyz;
            gl_FragData[0] = c_13;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "SPOT" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
              u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
              vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          vec2 u_xlat1;
          bool u_xlatb1;
          mediump vec3 u_xlat16_2;
          float u_xlat9;
          mediump float u_xlat16_11;
          void main()
          {
              u_xlat0 = vs_TEXCOORD2.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
              u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
              u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
              u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
              u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(0.0<u_xlat0.z);
          #else
              u_xlatb1 = 0.0<u_xlat0.z;
          #endif
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).x;
              u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
              u_xlat16_2.x = u_xlat9 * u_xlat16_2.x;
              u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
              u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat16_11 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_11 = max(u_xlat16_11, 0.0);
              SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "SPOT" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
              u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
              vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          vec2 u_xlat1;
          bool u_xlatb1;
          mediump vec3 u_xlat16_2;
          float u_xlat9;
          mediump float u_xlat16_11;
          void main()
          {
              u_xlat0 = vs_TEXCOORD2.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
              u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
              u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
              u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
              u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(0.0<u_xlat0.z);
          #else
              u_xlatb1 = 0.0<u_xlat0.z;
          #endif
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).x;
              u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
              u_xlat16_2.x = u_xlat9 * u_xlat16_2.x;
              u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
              u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat16_11 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_11 = max(u_xlat16_11, 0.0);
              SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "SPOT" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
              u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
              vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          vec2 u_xlat1;
          bool u_xlatb1;
          mediump vec3 u_xlat16_2;
          float u_xlat9;
          mediump float u_xlat16_11;
          void main()
          {
              u_xlat0 = vs_TEXCOORD2.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
              u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
              u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
              u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
              u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(0.0<u_xlat0.z);
          #else
              u_xlatb1 = 0.0<u_xlat0.z;
          #endif
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).x;
              u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
              u_xlat16_2.x = u_xlat9 * u_xlat16_2.x;
              u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
              u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat16_11 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_11 = max(u_xlat16_11, 0.0);
              SV_Target0.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "POINT_COOKIE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_3.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_3).xyz;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp samplerCube _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp float atten_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            highp vec3 tmpvar_6;
            tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp float tmpvar_8;
            tmpvar_8 = (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))).x * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
            atten_3 = tmpvar_8;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            tmpvar_1 = (tmpvar_1 * atten_3);
            lowp vec4 c_9;
            lowp vec4 c_10;
            lowp float diff_11;
            mediump float tmpvar_12;
            tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_11 = tmpvar_12;
            c_10.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_11);
            c_10.w = tmpvar_7.w;
            c_9.w = c_10.w;
            c_9.xyz = c_10.xyz;
            gl_FragData[0] = c_9;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "POINT_COOKIE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_3.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_3).xyz;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp samplerCube _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp float atten_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            highp vec3 tmpvar_6;
            tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp float tmpvar_8;
            tmpvar_8 = (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))).x * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
            atten_3 = tmpvar_8;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            tmpvar_1 = (tmpvar_1 * atten_3);
            lowp vec4 c_9;
            lowp vec4 c_10;
            lowp float diff_11;
            mediump float tmpvar_12;
            tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_11 = tmpvar_12;
            c_10.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_11);
            c_10.w = tmpvar_7.w;
            c_9.w = c_10.w;
            c_9.xyz = c_10.xyz;
            gl_FragData[0] = c_9;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "POINT_COOKIE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_3.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_3).xyz;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp samplerCube _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp float atten_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            highp vec3 tmpvar_6;
            tmpvar_6 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp float tmpvar_8;
            tmpvar_8 = (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))).x * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
            atten_3 = tmpvar_8;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            tmpvar_1 = (tmpvar_1 * atten_3);
            lowp vec4 c_9;
            lowp vec4 c_10;
            lowp float diff_11;
            mediump float tmpvar_12;
            tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_11 = tmpvar_12;
            c_10.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_11);
            c_10.w = tmpvar_7.w;
            c_9.w = c_10.w;
            c_9.xyz = c_10.xyz;
            gl_FragData[0] = c_9;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "POINT_COOKIE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTextureB0;
          uniform highp samplerCube _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec3 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump float u_xlat16_1;
          float u_xlat2;
          mediump vec3 u_xlat16_3;
          float u_xlat6;
          void main()
          {
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              u_xlat16_1 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_1 = max(u_xlat16_1, 0.0);
              u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
              u_xlat2 = texture(_LightTextureB0, vec2(u_xlat6)).x;
              u_xlat0.x = u_xlat0.x * u_xlat2;
              u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "POINT_COOKIE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTextureB0;
          uniform highp samplerCube _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec3 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump float u_xlat16_1;
          float u_xlat2;
          mediump vec3 u_xlat16_3;
          float u_xlat6;
          void main()
          {
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              u_xlat16_1 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_1 = max(u_xlat16_1, 0.0);
              u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
              u_xlat2 = texture(_LightTextureB0, vec2(u_xlat6)).x;
              u_xlat0.x = u_xlat0.x * u_xlat2;
              u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "POINT_COOKIE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTextureB0;
          uniform highp samplerCube _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec3 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump float u_xlat16_1;
          float u_xlat2;
          mediump vec3 u_xlat16_3;
          float u_xlat6;
          void main()
          {
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              u_xlat16_1 = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_1 = max(u_xlat16_1, 0.0);
              u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
              u_xlat2 = texture(_LightTextureB0, vec2(u_xlat6)).x;
              u_xlat0.x = u_xlat0.x * u_xlat2;
              u_xlat16_3.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              SV_Target0.xyz = vec3(u_xlat16_1) * u_xlat16_3.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL_COOKIE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec2 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_3.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_3).xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec2 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp float atten_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp float tmpvar_8;
            tmpvar_8 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
            atten_3 = tmpvar_8;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            tmpvar_1 = (tmpvar_1 * atten_3);
            lowp vec4 c_9;
            lowp vec4 c_10;
            lowp float diff_11;
            mediump float tmpvar_12;
            tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_11 = tmpvar_12;
            c_10.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_11);
            c_10.w = tmpvar_7.w;
            c_9.w = c_10.w;
            c_9.xyz = c_10.xyz;
            gl_FragData[0] = c_9;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL_COOKIE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec2 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_3.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_3).xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec2 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp float atten_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp float tmpvar_8;
            tmpvar_8 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
            atten_3 = tmpvar_8;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            tmpvar_1 = (tmpvar_1 * atten_3);
            lowp vec4 c_9;
            lowp vec4 c_10;
            lowp float diff_11;
            mediump float tmpvar_12;
            tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_11 = tmpvar_12;
            c_10.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_11);
            c_10.w = tmpvar_7.w;
            c_9.w = c_10.w;
            c_9.xyz = c_10.xyz;
            gl_FragData[0] = c_9;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL_COOKIE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec2 xlv_TEXCOORD3;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            highp mat3 tmpvar_2;
            tmpvar_2[0] = unity_WorldToObject[0].xyz;
            tmpvar_2[1] = unity_WorldToObject[1].xyz;
            tmpvar_2[2] = unity_WorldToObject[2].xyz;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_3.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_3).xy;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec2 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp float atten_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp float tmpvar_8;
            tmpvar_8 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
            atten_3 = tmpvar_8;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            tmpvar_1 = (tmpvar_1 * atten_3);
            lowp vec4 c_9;
            lowp vec4 c_10;
            lowp float diff_11;
            mediump float tmpvar_12;
            tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_11 = tmpvar_12;
            c_10.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_11);
            c_10.w = tmpvar_7.w;
            c_9.w = c_10.w;
            c_9.xyz = c_10.xyz;
            gl_FragData[0] = c_9;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL_COOKIE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec2 vs_TEXCOORD3;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat9;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0.xy = u_xlat1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
              vs_TEXCOORD3.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec2 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump float u_xlat16_7;
          void main()
          {
              u_xlat0.xy = vs_TEXCOORD2.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat0.xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat0.xy;
              u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
              u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_7 = max(u_xlat16_7, 0.0);
              SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL_COOKIE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec2 vs_TEXCOORD3;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat9;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0.xy = u_xlat1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
              vs_TEXCOORD3.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec2 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump float u_xlat16_7;
          void main()
          {
              u_xlat0.xy = vs_TEXCOORD2.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat0.xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat0.xy;
              u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
              u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_7 = max(u_xlat16_7, 0.0);
              SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL_COOKIE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec2 vs_TEXCOORD3;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat9;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0.xy = u_xlat1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
              vs_TEXCOORD3.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec2 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          mediump float u_xlat16_7;
          void main()
          {
              u_xlat0.xy = vs_TEXCOORD2.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat0.xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat0.xy;
              u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
              u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat16_0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat16_0.xyz;
              SV_Target0.w = u_xlat16_0.w;
              u_xlat16_7 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_7 = max(u_xlat16_7, 0.0);
              SV_Target0.xyz = vec3(u_xlat16_7) * u_xlat16_1.xyz;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "POINT" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            highp vec4 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_4.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_4).xyz;
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform highp mat4 unity_WorldToLight;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp float atten_4;
            highp vec3 lightCoord_5;
            lowp vec3 tmpvar_6;
            lowp vec3 lightDir_7;
            highp vec3 tmpvar_8;
            tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_7 = tmpvar_8;
            tmpvar_6 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_9;
            tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp vec4 tmpvar_10;
            tmpvar_10.w = 1.0;
            tmpvar_10.xyz = xlv_TEXCOORD2;
            lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
            highp float tmpvar_11;
            tmpvar_11 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).x;
            atten_4 = tmpvar_11;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_7;
            tmpvar_1 = (tmpvar_1 * atten_4);
            lowp vec4 c_12;
            lowp vec4 c_13;
            lowp float diff_14;
            mediump float tmpvar_15;
            tmpvar_15 = max (0.0, dot (tmpvar_6, tmpvar_2));
            diff_14 = tmpvar_15;
            c_13.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_14);
            c_13.w = tmpvar_9.w;
            c_12.w = c_13.w;
            c_12.xyz = c_13.xyz;
            c_3.w = c_12.w;
            highp float tmpvar_16;
            tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_13.xyz * vec3(tmpvar_16));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "POINT" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            highp vec4 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_4.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_4).xyz;
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform highp mat4 unity_WorldToLight;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp float atten_4;
            highp vec3 lightCoord_5;
            lowp vec3 tmpvar_6;
            lowp vec3 lightDir_7;
            highp vec3 tmpvar_8;
            tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_7 = tmpvar_8;
            tmpvar_6 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_9;
            tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp vec4 tmpvar_10;
            tmpvar_10.w = 1.0;
            tmpvar_10.xyz = xlv_TEXCOORD2;
            lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
            highp float tmpvar_11;
            tmpvar_11 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).x;
            atten_4 = tmpvar_11;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_7;
            tmpvar_1 = (tmpvar_1 * atten_4);
            lowp vec4 c_12;
            lowp vec4 c_13;
            lowp float diff_14;
            mediump float tmpvar_15;
            tmpvar_15 = max (0.0, dot (tmpvar_6, tmpvar_2));
            diff_14 = tmpvar_15;
            c_13.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_14);
            c_13.w = tmpvar_9.w;
            c_12.w = c_13.w;
            c_12.xyz = c_13.xyz;
            c_3.w = c_12.w;
            highp float tmpvar_16;
            tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_13.xyz * vec3(tmpvar_16));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "POINT" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            highp vec4 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_4.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_4).xyz;
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform highp mat4 unity_WorldToLight;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp float atten_4;
            highp vec3 lightCoord_5;
            lowp vec3 tmpvar_6;
            lowp vec3 lightDir_7;
            highp vec3 tmpvar_8;
            tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_7 = tmpvar_8;
            tmpvar_6 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_9;
            tmpvar_9 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp vec4 tmpvar_10;
            tmpvar_10.w = 1.0;
            tmpvar_10.xyz = xlv_TEXCOORD2;
            lightCoord_5 = (unity_WorldToLight * tmpvar_10).xyz;
            highp float tmpvar_11;
            tmpvar_11 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).x;
            atten_4 = tmpvar_11;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_7;
            tmpvar_1 = (tmpvar_1 * atten_4);
            lowp vec4 c_12;
            lowp vec4 c_13;
            lowp float diff_14;
            mediump float tmpvar_15;
            tmpvar_15 = max (0.0, dot (tmpvar_6, tmpvar_2));
            diff_14 = tmpvar_15;
            c_13.xyz = ((tmpvar_9.xyz * tmpvar_1) * diff_14);
            c_13.w = tmpvar_9.w;
            c_12.w = c_13.w;
            c_12.xyz = c_13.xyz;
            c_3.w = c_12.w;
            highp float tmpvar_16;
            tmpvar_16 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_13.xyz * vec3(tmpvar_16));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "POINT" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          float u_xlat2;
          mediump vec3 u_xlat16_4;
          float u_xlat9;
          void main()
          {
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
              u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).x;
              u_xlat16_4.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
              u_xlat2 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
          #else
              u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat2);
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "POINT" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          float u_xlat2;
          mediump vec3 u_xlat16_4;
          float u_xlat9;
          void main()
          {
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
              u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).x;
              u_xlat16_4.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
              u_xlat2 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
          #else
              u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat2);
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "POINT" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          float u_xlat2;
          mediump vec3 u_xlat16_4;
          float u_xlat9;
          void main()
          {
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
              u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xx).x;
              u_xlat16_4.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
              u_xlat2 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
          #else
              u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat2);
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            lowp vec4 c_8;
            lowp vec4 c_9;
            lowp float diff_10;
            mediump float tmpvar_11;
            tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_10 = tmpvar_11;
            c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
            c_9.w = tmpvar_7.w;
            c_8.w = c_9.w;
            c_8.xyz = c_9.xyz;
            c_3.w = c_8.w;
            highp float tmpvar_12;
            tmpvar_12 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_9.xyz * vec3(tmpvar_12));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            lowp vec4 c_8;
            lowp vec4 c_9;
            lowp float diff_10;
            mediump float tmpvar_11;
            tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_10 = tmpvar_11;
            c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
            c_9.w = tmpvar_7.w;
            c_8.w = c_9.w;
            c_8.xyz = c_9.xyz;
            c_3.w = c_8.w;
            highp float tmpvar_12;
            tmpvar_12 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_9.xyz * vec3(tmpvar_12));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp vec3 tmpvar_4;
            lowp vec3 lightDir_5;
            mediump vec3 tmpvar_6;
            tmpvar_6 = _WorldSpaceLightPos0.xyz;
            lightDir_5 = tmpvar_6;
            tmpvar_4 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_7;
            tmpvar_7 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_5;
            lowp vec4 c_8;
            lowp vec4 c_9;
            lowp float diff_10;
            mediump float tmpvar_11;
            tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
            diff_10 = tmpvar_11;
            c_9.xyz = ((tmpvar_7.xyz * tmpvar_1) * diff_10);
            c_9.w = tmpvar_7.w;
            c_8.w = c_9.w;
            c_8.xyz = c_9.xyz;
            c_3.w = c_8.w;
            highp float tmpvar_12;
            tmpvar_12 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_9.xyz * vec3(tmpvar_12));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          vec4 u_xlat1;
          lowp vec4 u_xlat10_1;
          float u_xlat2;
          mediump vec3 u_xlat16_3;
          void main()
          {
              u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_3.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
              u_xlat2 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
          #else
              u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
          #endif
              u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat2);
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          vec4 u_xlat1;
          lowp vec4 u_xlat10_1;
          float u_xlat2;
          mediump vec3 u_xlat16_3;
          void main()
          {
              u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_3.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
              u_xlat2 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
          #else
              u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
          #endif
              u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat2);
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          float u_xlat6;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              gl_Position = u_xlat0;
              vs_TEXCOORD4 = u_xlat0.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat6 = inversesqrt(u_xlat6);
              vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          vec4 u_xlat1;
          lowp vec4 u_xlat10_1;
          float u_xlat2;
          mediump vec3 u_xlat16_3;
          void main()
          {
              u_xlat16_0.x = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_0.x = max(u_xlat16_0.x, 0.0);
              u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat1 = u_xlat10_1 * _Color;
              u_xlat16_3.xyz = u_xlat1.xyz * _LightColor0.xyz;
              u_xlat16_0.xyz = u_xlat16_0.xxx * u_xlat16_3.xyz;
              u_xlat2 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
          #else
              u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
          #endif
              u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat2);
              SV_Target0 = u_xlat1;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "SPOT" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            highp vec4 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_4.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_4);
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp float atten_4;
            lowp vec3 tmpvar_5;
            lowp vec3 lightDir_6;
            highp vec3 tmpvar_7;
            tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_6 = tmpvar_7;
            tmpvar_5 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_8;
            tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            lowp float tmpvar_9;
            highp vec4 tmpvar_10;
            tmpvar_10 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
            tmpvar_9 = tmpvar_10.w;
            lowp float tmpvar_11;
            highp vec4 tmpvar_12;
            tmpvar_12 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz)));
            tmpvar_11 = tmpvar_12.x;
            highp float tmpvar_13;
            tmpvar_13 = ((float(
              (xlv_TEXCOORD3.z > 0.0)
            ) * tmpvar_9) * tmpvar_11);
            atten_4 = tmpvar_13;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_6;
            tmpvar_1 = (tmpvar_1 * atten_4);
            lowp vec4 c_14;
            lowp vec4 c_15;
            lowp float diff_16;
            mediump float tmpvar_17;
            tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_2));
            diff_16 = tmpvar_17;
            c_15.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_16);
            c_15.w = tmpvar_8.w;
            c_14.w = c_15.w;
            c_14.xyz = c_15.xyz;
            c_3.w = c_14.w;
            highp float tmpvar_18;
            tmpvar_18 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_15.xyz * vec3(tmpvar_18));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "SPOT" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            highp vec4 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_4.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_4);
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp float atten_4;
            lowp vec3 tmpvar_5;
            lowp vec3 lightDir_6;
            highp vec3 tmpvar_7;
            tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_6 = tmpvar_7;
            tmpvar_5 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_8;
            tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            lowp float tmpvar_9;
            highp vec4 tmpvar_10;
            tmpvar_10 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
            tmpvar_9 = tmpvar_10.w;
            lowp float tmpvar_11;
            highp vec4 tmpvar_12;
            tmpvar_12 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz)));
            tmpvar_11 = tmpvar_12.x;
            highp float tmpvar_13;
            tmpvar_13 = ((float(
              (xlv_TEXCOORD3.z > 0.0)
            ) * tmpvar_9) * tmpvar_11);
            atten_4 = tmpvar_13;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_6;
            tmpvar_1 = (tmpvar_1 * atten_4);
            lowp vec4 c_14;
            lowp vec4 c_15;
            lowp float diff_16;
            mediump float tmpvar_17;
            tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_2));
            diff_16 = tmpvar_17;
            c_15.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_16);
            c_15.w = tmpvar_8.w;
            c_14.w = c_15.w;
            c_14.xyz = c_15.xyz;
            c_3.w = c_14.w;
            highp float tmpvar_18;
            tmpvar_18 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_15.xyz * vec3(tmpvar_18));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "SPOT" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            highp vec4 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_4.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_4);
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec4 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp float atten_4;
            lowp vec3 tmpvar_5;
            lowp vec3 lightDir_6;
            highp vec3 tmpvar_7;
            tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_6 = tmpvar_7;
            tmpvar_5 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_8;
            tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            lowp float tmpvar_9;
            highp vec4 tmpvar_10;
            tmpvar_10 = texture2D (_LightTexture0, ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5));
            tmpvar_9 = tmpvar_10.w;
            lowp float tmpvar_11;
            highp vec4 tmpvar_12;
            tmpvar_12 = texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz)));
            tmpvar_11 = tmpvar_12.x;
            highp float tmpvar_13;
            tmpvar_13 = ((float(
              (xlv_TEXCOORD3.z > 0.0)
            ) * tmpvar_9) * tmpvar_11);
            atten_4 = tmpvar_13;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_6;
            tmpvar_1 = (tmpvar_1 * atten_4);
            lowp vec4 c_14;
            lowp vec4 c_15;
            lowp float diff_16;
            mediump float tmpvar_17;
            tmpvar_17 = max (0.0, dot (tmpvar_5, tmpvar_2));
            diff_16 = tmpvar_17;
            c_15.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_16);
            c_15.w = tmpvar_8.w;
            c_14.w = c_15.w;
            c_14.xyz = c_15.xyz;
            c_3.w = c_14.w;
            highp float tmpvar_18;
            tmpvar_18 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_15.xyz * vec3(tmpvar_18));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "SPOT" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
              u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
              vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          vec3 u_xlat1;
          bool u_xlatb1;
          mediump vec3 u_xlat16_2;
          float u_xlat9;
          float u_xlat10;
          mediump float u_xlat16_11;
          void main()
          {
              u_xlat0 = vs_TEXCOORD2.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
              u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
              u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
              u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
              u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(0.0<u_xlat0.z);
          #else
              u_xlatb1 = 0.0<u_xlat0.z;
          #endif
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).x;
              u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
              u_xlat16_2.x = u_xlat9 * u_xlat16_2.x;
              u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
              u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat0.xyz;
              u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              u_xlat16_11 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
              u_xlat16_11 = max(u_xlat16_11, 0.0);
              u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
              u_xlat1.x = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
          #else
              u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "SPOT" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
              u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
              vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          vec3 u_xlat1;
          bool u_xlatb1;
          mediump vec3 u_xlat16_2;
          float u_xlat9;
          float u_xlat10;
          mediump float u_xlat16_11;
          void main()
          {
              u_xlat0 = vs_TEXCOORD2.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
              u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
              u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
              u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
              u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(0.0<u_xlat0.z);
          #else
              u_xlatb1 = 0.0<u_xlat0.z;
          #endif
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).x;
              u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
              u_xlat16_2.x = u_xlat9 * u_xlat16_2.x;
              u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
              u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat0.xyz;
              u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              u_xlat16_11 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
              u_xlat16_11 = max(u_xlat16_11, 0.0);
              u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
              u_xlat1.x = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
          #else
              u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "SPOT" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec4 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
              u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
              vs_TEXCOORD3 = hlslcc_mtx4x4unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          vec3 u_xlat1;
          bool u_xlatb1;
          mediump vec3 u_xlat16_2;
          float u_xlat9;
          float u_xlat10;
          mediump float u_xlat16_11;
          void main()
          {
              u_xlat0 = vs_TEXCOORD2.yyyy * hlslcc_mtx4x4unity_WorldToLight[1];
              u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_WorldToLight[3];
              u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
              u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
              u_xlat9 = texture(_LightTexture0, u_xlat1.xy).w;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(0.0<u_xlat0.z);
          #else
              u_xlatb1 = 0.0<u_xlat0.z;
          #endif
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTextureB0, u_xlat0.xx).x;
              u_xlat16_2.x = (u_xlatb1) ? 1.0 : 0.0;
              u_xlat16_2.x = u_xlat9 * u_xlat16_2.x;
              u_xlat16_2.x = u_xlat0.x * u_xlat16_2.x;
              u_xlat16_2.xyz = u_xlat16_2.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat0.xyz;
              u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              u_xlat16_11 = dot(vs_TEXCOORD1.xyz, u_xlat1.xyz);
              u_xlat16_11 = max(u_xlat16_11, 0.0);
              u_xlat16_2.xyz = vec3(u_xlat16_11) * u_xlat16_2.xyz;
              u_xlat1.x = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
          #else
              u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx;
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "POINT_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            highp vec4 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_4.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_4).xyz;
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp samplerCube _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp float atten_4;
            lowp vec3 tmpvar_5;
            lowp vec3 lightDir_6;
            highp vec3 tmpvar_7;
            tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_6 = tmpvar_7;
            tmpvar_5 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_8;
            tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp float tmpvar_9;
            tmpvar_9 = (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))).x * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
            atten_4 = tmpvar_9;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_6;
            tmpvar_1 = (tmpvar_1 * atten_4);
            lowp vec4 c_10;
            lowp vec4 c_11;
            lowp float diff_12;
            mediump float tmpvar_13;
            tmpvar_13 = max (0.0, dot (tmpvar_5, tmpvar_2));
            diff_12 = tmpvar_13;
            c_11.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_12);
            c_11.w = tmpvar_8.w;
            c_10.w = c_11.w;
            c_10.xyz = c_11.xyz;
            c_3.w = c_10.w;
            highp float tmpvar_14;
            tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "POINT_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            highp vec4 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_4.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_4).xyz;
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp samplerCube _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp float atten_4;
            lowp vec3 tmpvar_5;
            lowp vec3 lightDir_6;
            highp vec3 tmpvar_7;
            tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_6 = tmpvar_7;
            tmpvar_5 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_8;
            tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp float tmpvar_9;
            tmpvar_9 = (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))).x * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
            atten_4 = tmpvar_9;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_6;
            tmpvar_1 = (tmpvar_1 * atten_4);
            lowp vec4 c_10;
            lowp vec4 c_11;
            lowp float diff_12;
            mediump float tmpvar_13;
            tmpvar_13 = max (0.0, dot (tmpvar_5, tmpvar_2));
            diff_12 = tmpvar_13;
            c_11.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_12);
            c_11.w = tmpvar_8.w;
            c_10.w = c_11.w;
            c_10.xyz = c_11.xyz;
            c_3.w = c_10.w;
            highp float tmpvar_14;
            tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "POINT_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            highp vec4 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_4.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_4).xyz;
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp samplerCube _LightTexture0;
          uniform highp sampler2D _LightTextureB0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec3 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp float atten_4;
            lowp vec3 tmpvar_5;
            lowp vec3 lightDir_6;
            highp vec3 tmpvar_7;
            tmpvar_7 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD2));
            lightDir_6 = tmpvar_7;
            tmpvar_5 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_8;
            tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp float tmpvar_9;
            tmpvar_9 = (texture2D (_LightTextureB0, vec2(dot (xlv_TEXCOORD3, xlv_TEXCOORD3))).x * textureCube (_LightTexture0, xlv_TEXCOORD3).w);
            atten_4 = tmpvar_9;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_6;
            tmpvar_1 = (tmpvar_1 * atten_4);
            lowp vec4 c_10;
            lowp vec4 c_11;
            lowp float diff_12;
            mediump float tmpvar_13;
            tmpvar_13 = max (0.0, dot (tmpvar_5, tmpvar_2));
            diff_12 = tmpvar_13;
            c_11.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_12);
            c_11.w = tmpvar_8.w;
            c_10.w = c_11.w;
            c_10.xyz = c_11.xyz;
            c_3.w = c_10.w;
            highp float tmpvar_14;
            tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "POINT_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTextureB0;
          uniform highp samplerCube _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          float u_xlat2;
          float u_xlat3;
          mediump vec3 u_xlat16_4;
          float u_xlat9;
          void main()
          {
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
              u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
              u_xlat3 = texture(_LightTextureB0, vec2(u_xlat9)).x;
              u_xlat0.x = u_xlat0.x * u_xlat3;
              u_xlat16_4.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
              u_xlat2 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
          #else
              u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat2);
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "POINT_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTextureB0;
          uniform highp samplerCube _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          float u_xlat2;
          float u_xlat3;
          mediump vec3 u_xlat16_4;
          float u_xlat9;
          void main()
          {
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
              u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
              u_xlat3 = texture(_LightTextureB0, vec2(u_xlat9)).x;
              u_xlat0.x = u_xlat0.x * u_xlat3;
              u_xlat16_4.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
              u_xlat2 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
          #else
              u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat2);
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "POINT_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD1;
          out highp vec3 vs_TEXCOORD2;
          out highp vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat10;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat1.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat1.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat1.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              vs_TEXCOORD3.xyz = hlslcc_mtx4x4unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTextureB0;
          uniform highp samplerCube _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD1;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          float u_xlat2;
          float u_xlat3;
          mediump vec3 u_xlat16_4;
          float u_xlat9;
          void main()
          {
              u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat16_1.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
              u_xlat16_1.x = max(u_xlat16_1.x, 0.0);
              u_xlat0.xyz = vs_TEXCOORD2.yyy * hlslcc_mtx4x4unity_WorldToLight[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_WorldToLight[3].xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xyz).w;
              u_xlat3 = texture(_LightTextureB0, vec2(u_xlat9)).x;
              u_xlat0.x = u_xlat0.x * u_xlat3;
              u_xlat16_4.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_4.xyz = u_xlat16_4.xyz * u_xlat0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xxx * u_xlat16_4.xyz;
              u_xlat2 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
          #else
              u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat2);
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec2 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            highp vec4 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_4.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_4).xy;
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec2 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp float atten_4;
            lowp vec3 tmpvar_5;
            lowp vec3 lightDir_6;
            mediump vec3 tmpvar_7;
            tmpvar_7 = _WorldSpaceLightPos0.xyz;
            lightDir_6 = tmpvar_7;
            tmpvar_5 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_8;
            tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp float tmpvar_9;
            tmpvar_9 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
            atten_4 = tmpvar_9;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_6;
            tmpvar_1 = (tmpvar_1 * atten_4);
            lowp vec4 c_10;
            lowp vec4 c_11;
            lowp float diff_12;
            mediump float tmpvar_13;
            tmpvar_13 = max (0.0, dot (tmpvar_5, tmpvar_2));
            diff_12 = tmpvar_13;
            c_11.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_12);
            c_11.w = tmpvar_8.w;
            c_10.w = c_11.w;
            c_10.xyz = c_11.xyz;
            c_3.w = c_10.w;
            highp float tmpvar_14;
            tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec2 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            highp vec4 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_4.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_4).xy;
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec2 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp float atten_4;
            lowp vec3 tmpvar_5;
            lowp vec3 lightDir_6;
            mediump vec3 tmpvar_7;
            tmpvar_7 = _WorldSpaceLightPos0.xyz;
            lightDir_6 = tmpvar_7;
            tmpvar_5 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_8;
            tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp float tmpvar_9;
            tmpvar_9 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
            atten_4 = tmpvar_9;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_6;
            tmpvar_1 = (tmpvar_1 * atten_4);
            lowp vec4 c_10;
            lowp vec4 c_11;
            lowp float diff_12;
            mediump float tmpvar_13;
            tmpvar_13 = max (0.0, dot (tmpvar_5, tmpvar_2));
            diff_12 = tmpvar_13;
            c_11.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_12);
            c_11.w = tmpvar_8.w;
            c_10.w = c_11.w;
            c_10.xyz = c_11.xyz;
            c_3.w = c_10.w;
            highp float tmpvar_14;
            tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp mat4 unity_WorldToLight;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec3 xlv_TEXCOORD2;
          varying highp vec2 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 tmpvar_2;
            tmpvar_2.w = 1.0;
            tmpvar_2.xyz = _glesVertex.xyz;
            tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_WorldToObject[0].xyz;
            tmpvar_3[1] = unity_WorldToObject[1].xyz;
            tmpvar_3[2] = unity_WorldToObject[2].xyz;
            gl_Position = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
            highp vec4 tmpvar_4;
            tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
            xlv_TEXCOORD2 = tmpvar_4.xyz;
            xlv_TEXCOORD3 = (unity_WorldToLight * tmpvar_4).xy;
            xlv_TEXCOORD4 = ((tmpvar_1.z * unity_FogParams.z) + unity_FogParams.w);
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump vec4 _WorldSpaceLightPos0;
          uniform lowp vec4 _LightColor0;
          uniform highp sampler2D _LightTexture0;
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          varying highp vec2 xlv_TEXCOORD3;
          varying highp float xlv_TEXCOORD4;
          void main ()
          {
            mediump vec3 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec4 c_3;
            lowp float atten_4;
            lowp vec3 tmpvar_5;
            lowp vec3 lightDir_6;
            mediump vec3 tmpvar_7;
            tmpvar_7 = _WorldSpaceLightPos0.xyz;
            lightDir_6 = tmpvar_7;
            tmpvar_5 = xlv_TEXCOORD1;
            lowp vec4 tmpvar_8;
            tmpvar_8 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color);
            highp float tmpvar_9;
            tmpvar_9 = texture2D (_LightTexture0, xlv_TEXCOORD3).w;
            atten_4 = tmpvar_9;
            tmpvar_1 = _LightColor0.xyz;
            tmpvar_2 = lightDir_6;
            tmpvar_1 = (tmpvar_1 * atten_4);
            lowp vec4 c_10;
            lowp vec4 c_11;
            lowp float diff_12;
            mediump float tmpvar_13;
            tmpvar_13 = max (0.0, dot (tmpvar_5, tmpvar_2));
            diff_12 = tmpvar_13;
            c_11.xyz = ((tmpvar_8.xyz * tmpvar_1) * diff_12);
            c_11.w = tmpvar_8.w;
            c_10.w = c_11.w;
            c_10.xyz = c_11.xyz;
            c_3.w = c_10.w;
            highp float tmpvar_14;
            tmpvar_14 = clamp (xlv_TEXCOORD4, 0.0, 1.0);
            c_3.xyz = (c_11.xyz * vec3(tmpvar_14));
            gl_FragData[0] = c_3;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec2 vs_TEXCOORD3;
          out highp vec3 vs_TEXCOORD1;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat9;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0.xy = u_xlat1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
              vs_TEXCOORD3.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          float u_xlat2;
          mediump float u_xlat16_10;
          void main()
          {
              u_xlat0.xy = vs_TEXCOORD2.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat0.xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat0.xy;
              u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
              u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
              u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_10 = max(u_xlat16_10, 0.0);
              u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
              u_xlat2 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
          #else
              u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat2);
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec2 vs_TEXCOORD3;
          out highp vec3 vs_TEXCOORD1;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat9;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0.xy = u_xlat1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
              vs_TEXCOORD3.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          float u_xlat2;
          mediump float u_xlat16_10;
          void main()
          {
              u_xlat0.xy = vs_TEXCOORD2.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat0.xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat0.xy;
              u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
              u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
              u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_10 = max(u_xlat16_10, 0.0);
              u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
              u_xlat2 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
          #else
              u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat2);
              SV_Target0 = u_xlat0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec4 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec2 vs_TEXCOORD3;
          out highp vec3 vs_TEXCOORD1;
          out highp float vs_TEXCOORD4;
          out highp vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat9;
          void main()
          {
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat1 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              gl_Position = u_xlat1;
              vs_TEXCOORD4 = u_xlat1.z * unity_FogParams.z + unity_FogParams.w;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
              vs_TEXCOORD2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              u_xlat0.xy = u_xlat1.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
              vs_TEXCOORD3.xy = hlslcc_mtx4x4unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _WorldSpaceLightPos0;
          uniform 	mediump vec4 _LightColor0;
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToLight[4];
          uniform 	mediump vec4 _Color;
          uniform lowp sampler2D _MainTex;
          uniform highp sampler2D _LightTexture0;
          in highp vec2 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          in highp float vs_TEXCOORD4;
          in highp vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          lowp vec4 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          float u_xlat2;
          mediump float u_xlat16_10;
          void main()
          {
              u_xlat0.xy = vs_TEXCOORD2.yy * hlslcc_mtx4x4unity_WorldToLight[1].xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat0.xy;
              u_xlat0.xy = hlslcc_mtx4x4unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat0.xy;
              u_xlat0.xy = u_xlat0.xy + hlslcc_mtx4x4unity_WorldToLight[3].xy;
              u_xlat0.x = texture(_LightTexture0, u_xlat0.xy).w;
              u_xlat16_1.xyz = u_xlat0.xxx * _LightColor0.xyz;
              u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
              u_xlat0 = u_xlat10_0 * _Color;
              u_xlat16_1.xyz = u_xlat16_1.xyz * u_xlat0.xyz;
              u_xlat16_10 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
              u_xlat16_10 = max(u_xlat16_10, 0.0);
              u_xlat16_1.xyz = vec3(u_xlat16_10) * u_xlat16_1.xyz;
              u_xlat2 = vs_TEXCOORD4;
          #ifdef UNITY_ADRENO_ES3
              u_xlat2 = min(max(u_xlat2, 0.0), 1.0);
          #else
              u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_1.xyz * vec3(u_xlat2);
              SV_Target0 = u_xlat0;
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
           Keywords { "POINT" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "POINT" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "POINT" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "POINT" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "POINT" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "POINT" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "SPOT" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "SPOT" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "SPOT" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "SPOT" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "SPOT" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "SPOT" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "POINT_COOKIE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "POINT_COOKIE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "POINT_COOKIE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "POINT_COOKIE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "POINT_COOKIE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "POINT_COOKIE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL_COOKIE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL_COOKIE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL_COOKIE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL_COOKIE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL_COOKIE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL_COOKIE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "POINT" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "POINT" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "POINT" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "POINT" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "POINT" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "POINT" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "SPOT" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "SPOT" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "SPOT" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "SPOT" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "SPOT" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "SPOT" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "POINT_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "POINT_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "POINT_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "POINT_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "POINT_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "POINT_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
          
          "!!!!GLES3
          
          
          "
        }
      }
      
    } // end phase
    Pass // ind: 3, name: Meta
    {
      Name "Meta"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "META"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 200
      ZWrite Off
      Cull Off
      ColorMask  -1
      GpuProgramID 144637
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
          attribute vec4 _glesMultiTexCoord1;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_LightmapST;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform bvec4 unity_MetaVertexControl;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            highp vec4 vertex_1;
            vertex_1 = _glesVertex;
            if (unity_MetaVertexControl.x) {
              vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
              highp float tmpvar_2;
              if ((_glesVertex.z > 0.0)) {
                tmpvar_2 = 0.0001;
              } else {
                tmpvar_2 = 0.0;
              };
              vertex_1.z = tmpvar_2;
            };
            if (unity_MetaVertexControl.y) {
              vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
              highp float tmpvar_3;
              if ((vertex_1.z > 0.0)) {
                tmpvar_3 = 0.0001;
              } else {
                tmpvar_3 = 0.0;
              };
              vertex_1.z = tmpvar_3;
            };
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = vertex_1.xyz;
            gl_Position = (unity_MatrixVP * tmpvar_4);
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          uniform bvec4 unity_MetaFragmentControl;
          uniform highp float unity_OneOverOutputBoost;
          uniform highp float unity_MaxOutputValue;
          uniform highp float unity_UseLinearSpace;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
            tmpvar_2 = tmpvar_3;
            mediump vec4 res_4;
            res_4 = vec4(0.0, 0.0, 0.0, 0.0);
            if (unity_MetaFragmentControl.x) {
              mediump vec4 tmpvar_5;
              tmpvar_5.w = 1.0;
              tmpvar_5.xyz = tmpvar_2;
              res_4.w = tmpvar_5.w;
              highp vec3 tmpvar_6;
              tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
              res_4.xyz = tmpvar_6;
            };
            if (unity_MetaFragmentControl.y) {
              mediump vec3 emission_7;
              if (bool(unity_UseLinearSpace)) {
                emission_7 = vec3(0.0, 0.0, 0.0);
              } else {
                emission_7 = vec3(0.0, 0.0, 0.0);
              };
              mediump vec4 tmpvar_8;
              tmpvar_8.w = 1.0;
              tmpvar_8.xyz = emission_7;
              res_4 = tmpvar_8;
            };
            tmpvar_1 = res_4;
            gl_FragData[0] = tmpvar_1;
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
          attribute vec4 _glesMultiTexCoord1;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_LightmapST;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform bvec4 unity_MetaVertexControl;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            highp vec4 vertex_1;
            vertex_1 = _glesVertex;
            if (unity_MetaVertexControl.x) {
              vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
              highp float tmpvar_2;
              if ((_glesVertex.z > 0.0)) {
                tmpvar_2 = 0.0001;
              } else {
                tmpvar_2 = 0.0;
              };
              vertex_1.z = tmpvar_2;
            };
            if (unity_MetaVertexControl.y) {
              vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
              highp float tmpvar_3;
              if ((vertex_1.z > 0.0)) {
                tmpvar_3 = 0.0001;
              } else {
                tmpvar_3 = 0.0;
              };
              vertex_1.z = tmpvar_3;
            };
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = vertex_1.xyz;
            gl_Position = (unity_MatrixVP * tmpvar_4);
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          uniform bvec4 unity_MetaFragmentControl;
          uniform highp float unity_OneOverOutputBoost;
          uniform highp float unity_MaxOutputValue;
          uniform highp float unity_UseLinearSpace;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
            tmpvar_2 = tmpvar_3;
            mediump vec4 res_4;
            res_4 = vec4(0.0, 0.0, 0.0, 0.0);
            if (unity_MetaFragmentControl.x) {
              mediump vec4 tmpvar_5;
              tmpvar_5.w = 1.0;
              tmpvar_5.xyz = tmpvar_2;
              res_4.w = tmpvar_5.w;
              highp vec3 tmpvar_6;
              tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
              res_4.xyz = tmpvar_6;
            };
            if (unity_MetaFragmentControl.y) {
              mediump vec3 emission_7;
              if (bool(unity_UseLinearSpace)) {
                emission_7 = vec3(0.0, 0.0, 0.0);
              } else {
                emission_7 = vec3(0.0, 0.0, 0.0);
              };
              mediump vec4 tmpvar_8;
              tmpvar_8.w = 1.0;
              tmpvar_8.xyz = emission_7;
              res_4 = tmpvar_8;
            };
            tmpvar_1 = res_4;
            gl_FragData[0] = tmpvar_1;
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
          attribute vec4 _glesMultiTexCoord1;
          attribute vec4 _glesMultiTexCoord2;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_LightmapST;
          uniform highp vec4 unity_DynamicLightmapST;
          uniform bvec4 unity_MetaVertexControl;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            highp vec4 vertex_1;
            vertex_1 = _glesVertex;
            if (unity_MetaVertexControl.x) {
              vertex_1.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
              highp float tmpvar_2;
              if ((_glesVertex.z > 0.0)) {
                tmpvar_2 = 0.0001;
              } else {
                tmpvar_2 = 0.0;
              };
              vertex_1.z = tmpvar_2;
            };
            if (unity_MetaVertexControl.y) {
              vertex_1.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
              highp float tmpvar_3;
              if ((vertex_1.z > 0.0)) {
                tmpvar_3 = 0.0001;
              } else {
                tmpvar_3 = 0.0;
              };
              vertex_1.z = tmpvar_3;
            };
            highp vec4 tmpvar_4;
            tmpvar_4.w = 1.0;
            tmpvar_4.xyz = vertex_1.xyz;
            gl_Position = (unity_MatrixVP * tmpvar_4);
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          uniform lowp vec4 _Color;
          uniform bvec4 unity_MetaFragmentControl;
          uniform highp float unity_OneOverOutputBoost;
          uniform highp float unity_MaxOutputValue;
          uniform highp float unity_UseLinearSpace;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 tmpvar_1;
            mediump vec3 tmpvar_2;
            lowp vec3 tmpvar_3;
            tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Color).xyz;
            tmpvar_2 = tmpvar_3;
            mediump vec4 res_4;
            res_4 = vec4(0.0, 0.0, 0.0, 0.0);
            if (unity_MetaFragmentControl.x) {
              mediump vec4 tmpvar_5;
              tmpvar_5.w = 1.0;
              tmpvar_5.xyz = tmpvar_2;
              res_4.w = tmpvar_5.w;
              highp vec3 tmpvar_6;
              tmpvar_6 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
              res_4.xyz = tmpvar_6;
            };
            if (unity_MetaFragmentControl.y) {
              mediump vec3 emission_7;
              if (bool(unity_UseLinearSpace)) {
                emission_7 = vec3(0.0, 0.0, 0.0);
              } else {
                emission_7 = vec3(0.0, 0.0, 0.0);
              };
              mediump vec4 tmpvar_8;
              tmpvar_8.w = 1.0;
              tmpvar_8.xyz = emission_7;
              res_4 = tmpvar_8;
            };
            tmpvar_1 = res_4;
            gl_FragData[0] = tmpvar_1;
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
          uniform 	vec4 unity_LightmapST;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	bvec4 unity_MetaVertexControl;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD1;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          vec4 u_xlat0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb6;
          void main()
          {
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(0.0<in_POSITION0.z);
          #else
              u_xlatb0 = 0.0<in_POSITION0.z;
          #endif
              u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
              u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
              u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb6 = !!(0.0<u_xlat0.z);
          #else
              u_xlatb6 = 0.0<u_xlat0.z;
          #endif
              u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
              u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
              vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Color;
          uniform 	bvec4 unity_MetaFragmentControl;
          uniform 	float unity_OneOverOutputBoost;
          uniform 	float unity_MaxOutputValue;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec3 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec3 u_xlat10_0;
          float u_xlat3;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
              u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
              u_xlat3 = unity_OneOverOutputBoost;
          #ifdef UNITY_ADRENO_ES3
              u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
          #else
              u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_0.xyz * vec3(u_xlat3);
              u_xlat0.xyz = exp2(u_xlat0.xyz);
              u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
              u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat0.xyz : vec3(0.0, 0.0, 0.0);
              u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
              SV_Target0 = (unity_MetaFragmentControl.y) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat16_0;
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
          uniform 	vec4 unity_LightmapST;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	bvec4 unity_MetaVertexControl;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD1;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          vec4 u_xlat0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb6;
          void main()
          {
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(0.0<in_POSITION0.z);
          #else
              u_xlatb0 = 0.0<in_POSITION0.z;
          #endif
              u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
              u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
              u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb6 = !!(0.0<u_xlat0.z);
          #else
              u_xlatb6 = 0.0<u_xlat0.z;
          #endif
              u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
              u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
              vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Color;
          uniform 	bvec4 unity_MetaFragmentControl;
          uniform 	float unity_OneOverOutputBoost;
          uniform 	float unity_MaxOutputValue;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec3 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec3 u_xlat10_0;
          float u_xlat3;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
              u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
              u_xlat3 = unity_OneOverOutputBoost;
          #ifdef UNITY_ADRENO_ES3
              u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
          #else
              u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_0.xyz * vec3(u_xlat3);
              u_xlat0.xyz = exp2(u_xlat0.xyz);
              u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
              u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat0.xyz : vec3(0.0, 0.0, 0.0);
              u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
              SV_Target0 = (unity_MetaFragmentControl.y) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat16_0;
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
          uniform 	vec4 unity_LightmapST;
          uniform 	vec4 unity_DynamicLightmapST;
          uniform 	bvec4 unity_MetaVertexControl;
          uniform 	vec4 _MainTex_ST;
          in highp vec4 in_POSITION0;
          in highp vec4 in_TEXCOORD0;
          in highp vec4 in_TEXCOORD1;
          in highp vec4 in_TEXCOORD2;
          out highp vec2 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          vec4 u_xlat0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb6;
          void main()
          {
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(0.0<in_POSITION0.z);
          #else
              u_xlatb0 = 0.0<in_POSITION0.z;
          #endif
              u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
              u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
              u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb6 = !!(0.0<u_xlat0.z);
          #else
              u_xlatb6 = 0.0<u_xlat0.z;
          #endif
              u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
              u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
              u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = u_xlat0 + hlslcc_mtx4x4unity_MatrixVP[3];
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
              vs_TEXCOORD1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 _Color;
          uniform 	bvec4 unity_MetaFragmentControl;
          uniform 	float unity_OneOverOutputBoost;
          uniform 	float unity_MaxOutputValue;
          uniform lowp sampler2D _MainTex;
          in highp vec2 vs_TEXCOORD0;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec3 u_xlat0;
          mediump vec4 u_xlat16_0;
          lowp vec3 u_xlat10_0;
          float u_xlat3;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_0.xyz = u_xlat10_0.xyz * _Color.xyz;
              u_xlat16_0.xyz = log2(u_xlat16_0.xyz);
              u_xlat3 = unity_OneOverOutputBoost;
          #ifdef UNITY_ADRENO_ES3
              u_xlat3 = min(max(u_xlat3, 0.0), 1.0);
          #else
              u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
          #endif
              u_xlat0.xyz = u_xlat16_0.xyz * vec3(u_xlat3);
              u_xlat0.xyz = exp2(u_xlat0.xyz);
              u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
              u_xlat16_0.xyz = (unity_MetaFragmentControl.x) ? u_xlat0.xyz : vec3(0.0, 0.0, 0.0);
              u_xlat16_0.w = (unity_MetaFragmentControl.x) ? 1.0 : 0.0;
              SV_Target0 = (unity_MetaFragmentControl.y) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat16_0;
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
  FallBack "Legacy Shaders/Transparent/VertexLit"
}
