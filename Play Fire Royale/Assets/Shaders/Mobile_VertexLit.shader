Shader "Mobile/VertexLit"
{
  Properties
  {
    _MainTex ("Base (RGB)", 2D) = "white" {}
  }
  SubShader
  {
    Tags
    { 
      "RenderType" = "Opaque"
    }
    LOD 80
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "LIGHTMODE" = "Vertex"
        "RenderType" = "Opaque"
      }
      LOD 80
      Fog
      { 
        Mode  Off
      } 
      GpuProgramID 159137
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
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            mediump vec3 lcolor_5;
            mediump vec3 eyeNormal_6;
            mediump vec4 color_7;
            highp mat3 tmpvar_8;
            tmpvar_8[0] = tmpvar_2.xyz;
            tmpvar_8[1] = tmpvar_3.xyz;
            tmpvar_8[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_9;
            tmpvar_9 = normalize((tmpvar_8 * _glesNormal));
            eyeNormal_6 = tmpvar_9;
            lowp vec3 tmpvar_10;
            tmpvar_10 = glstate_lightmodel_ambient.xyz;
            lcolor_5 = tmpvar_10;
            highp vec3 tmpvar_11;
            tmpvar_11 = unity_LightPosition[0].xyz;
            mediump vec3 dirToLight_12;
            dirToLight_12 = tmpvar_11;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_12), 0.0)) * unity_LightColor[0].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_13;
            tmpvar_13 = unity_LightPosition[1].xyz;
            mediump vec3 dirToLight_14;
            dirToLight_14 = tmpvar_13;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_14), 0.0)) * unity_LightColor[1].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_15;
            tmpvar_15 = unity_LightPosition[2].xyz;
            mediump vec3 dirToLight_16;
            dirToLight_16 = tmpvar_15;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_16), 0.0)) * unity_LightColor[2].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_17;
            tmpvar_17 = unity_LightPosition[3].xyz;
            mediump vec3 dirToLight_18;
            dirToLight_18 = tmpvar_17;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_18), 0.0)) * unity_LightColor[3].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_19;
            tmpvar_19 = unity_LightPosition[4].xyz;
            mediump vec3 dirToLight_20;
            dirToLight_20 = tmpvar_19;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_20), 0.0)) * unity_LightColor[4].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_21;
            tmpvar_21 = unity_LightPosition[5].xyz;
            mediump vec3 dirToLight_22;
            dirToLight_22 = tmpvar_21;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_22), 0.0)) * unity_LightColor[5].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_23;
            tmpvar_23 = unity_LightPosition[6].xyz;
            mediump vec3 dirToLight_24;
            dirToLight_24 = tmpvar_23;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_24), 0.0)) * unity_LightColor[6].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_25;
            tmpvar_25 = unity_LightPosition[7].xyz;
            mediump vec3 dirToLight_26;
            dirToLight_26 = tmpvar_25;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_26), 0.0)) * unity_LightColor[7].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            color_7.xyz = lcolor_5;
            color_7.w = 1.0;
            lowp vec4 tmpvar_27;
            mediump vec4 tmpvar_28;
            tmpvar_28 = clamp (color_7, 0.0, 1.0);
            tmpvar_27 = tmpvar_28;
            highp vec4 tmpvar_29;
            tmpvar_29.w = 1.0;
            tmpvar_29.xyz = _glesVertex.xyz;
            xlv_COLOR0 = tmpvar_27;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
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
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            mediump vec3 lcolor_5;
            mediump vec3 eyeNormal_6;
            mediump vec4 color_7;
            highp mat3 tmpvar_8;
            tmpvar_8[0] = tmpvar_2.xyz;
            tmpvar_8[1] = tmpvar_3.xyz;
            tmpvar_8[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_9;
            tmpvar_9 = normalize((tmpvar_8 * _glesNormal));
            eyeNormal_6 = tmpvar_9;
            lowp vec3 tmpvar_10;
            tmpvar_10 = glstate_lightmodel_ambient.xyz;
            lcolor_5 = tmpvar_10;
            highp vec3 tmpvar_11;
            tmpvar_11 = unity_LightPosition[0].xyz;
            mediump vec3 dirToLight_12;
            dirToLight_12 = tmpvar_11;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_12), 0.0)) * unity_LightColor[0].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_13;
            tmpvar_13 = unity_LightPosition[1].xyz;
            mediump vec3 dirToLight_14;
            dirToLight_14 = tmpvar_13;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_14), 0.0)) * unity_LightColor[1].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_15;
            tmpvar_15 = unity_LightPosition[2].xyz;
            mediump vec3 dirToLight_16;
            dirToLight_16 = tmpvar_15;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_16), 0.0)) * unity_LightColor[2].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_17;
            tmpvar_17 = unity_LightPosition[3].xyz;
            mediump vec3 dirToLight_18;
            dirToLight_18 = tmpvar_17;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_18), 0.0)) * unity_LightColor[3].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_19;
            tmpvar_19 = unity_LightPosition[4].xyz;
            mediump vec3 dirToLight_20;
            dirToLight_20 = tmpvar_19;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_20), 0.0)) * unity_LightColor[4].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_21;
            tmpvar_21 = unity_LightPosition[5].xyz;
            mediump vec3 dirToLight_22;
            dirToLight_22 = tmpvar_21;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_22), 0.0)) * unity_LightColor[5].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_23;
            tmpvar_23 = unity_LightPosition[6].xyz;
            mediump vec3 dirToLight_24;
            dirToLight_24 = tmpvar_23;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_24), 0.0)) * unity_LightColor[6].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_25;
            tmpvar_25 = unity_LightPosition[7].xyz;
            mediump vec3 dirToLight_26;
            dirToLight_26 = tmpvar_25;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_26), 0.0)) * unity_LightColor[7].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            color_7.xyz = lcolor_5;
            color_7.w = 1.0;
            lowp vec4 tmpvar_27;
            mediump vec4 tmpvar_28;
            tmpvar_28 = clamp (color_7, 0.0, 1.0);
            tmpvar_27 = tmpvar_28;
            highp vec4 tmpvar_29;
            tmpvar_29.w = 1.0;
            tmpvar_29.xyz = _glesVertex.xyz;
            xlv_COLOR0 = tmpvar_27;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
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
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            mediump vec3 lcolor_5;
            mediump vec3 eyeNormal_6;
            mediump vec4 color_7;
            highp mat3 tmpvar_8;
            tmpvar_8[0] = tmpvar_2.xyz;
            tmpvar_8[1] = tmpvar_3.xyz;
            tmpvar_8[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_9;
            tmpvar_9 = normalize((tmpvar_8 * _glesNormal));
            eyeNormal_6 = tmpvar_9;
            lowp vec3 tmpvar_10;
            tmpvar_10 = glstate_lightmodel_ambient.xyz;
            lcolor_5 = tmpvar_10;
            highp vec3 tmpvar_11;
            tmpvar_11 = unity_LightPosition[0].xyz;
            mediump vec3 dirToLight_12;
            dirToLight_12 = tmpvar_11;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_12), 0.0)) * unity_LightColor[0].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_13;
            tmpvar_13 = unity_LightPosition[1].xyz;
            mediump vec3 dirToLight_14;
            dirToLight_14 = tmpvar_13;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_14), 0.0)) * unity_LightColor[1].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_15;
            tmpvar_15 = unity_LightPosition[2].xyz;
            mediump vec3 dirToLight_16;
            dirToLight_16 = tmpvar_15;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_16), 0.0)) * unity_LightColor[2].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_17;
            tmpvar_17 = unity_LightPosition[3].xyz;
            mediump vec3 dirToLight_18;
            dirToLight_18 = tmpvar_17;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_18), 0.0)) * unity_LightColor[3].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_19;
            tmpvar_19 = unity_LightPosition[4].xyz;
            mediump vec3 dirToLight_20;
            dirToLight_20 = tmpvar_19;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_20), 0.0)) * unity_LightColor[4].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_21;
            tmpvar_21 = unity_LightPosition[5].xyz;
            mediump vec3 dirToLight_22;
            dirToLight_22 = tmpvar_21;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_22), 0.0)) * unity_LightColor[5].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_23;
            tmpvar_23 = unity_LightPosition[6].xyz;
            mediump vec3 dirToLight_24;
            dirToLight_24 = tmpvar_23;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_24), 0.0)) * unity_LightColor[6].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_25;
            tmpvar_25 = unity_LightPosition[7].xyz;
            mediump vec3 dirToLight_26;
            dirToLight_26 = tmpvar_25;
            lcolor_5 = (lcolor_5 + min ((
              (vec3(max (dot (eyeNormal_6, dirToLight_26), 0.0)) * unity_LightColor[7].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            color_7.xyz = lcolor_5;
            color_7.w = 1.0;
            lowp vec4 tmpvar_27;
            mediump vec4 tmpvar_28;
            tmpvar_28 = clamp (color_7, 0.0, 1.0);
            tmpvar_27 = tmpvar_28;
            highp vec4 tmpvar_29;
            tmpvar_29.w = 1.0;
            tmpvar_29.xyz = _glesVertex.xyz;
            xlv_COLOR0 = tmpvar_27;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_29));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          mediump vec3 u_xlat16_3;
          mediump vec3 u_xlat16_4;
          float u_xlat15;
          int u_xlati15;
          mediump float u_xlat16_18;
          void main()
          {
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat2.xyz;
              u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
              u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
              u_xlat0.z = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat15 = inversesqrt(u_xlat15);
              u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
              u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz;
              for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
              {
                  u_xlat16_18 = dot(u_xlat0.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
                  u_xlat16_18 = max(u_xlat16_18, 0.0);
                  u_xlat16_4.xyz = vec3(u_xlat16_18) * unity_LightColor[u_xlati_loop_1].xyz;
                  u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5);
                  u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(1.0, 1.0, 1.0));
                  u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
              }
              vs_COLOR0.xyz = u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_COLOR0.w = 1.0;
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
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          mediump vec3 u_xlat16_3;
          mediump vec3 u_xlat16_4;
          float u_xlat15;
          int u_xlati15;
          mediump float u_xlat16_18;
          void main()
          {
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat2.xyz;
              u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
              u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
              u_xlat0.z = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat15 = inversesqrt(u_xlat15);
              u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
              u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz;
              for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
              {
                  u_xlat16_18 = dot(u_xlat0.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
                  u_xlat16_18 = max(u_xlat16_18, 0.0);
                  u_xlat16_4.xyz = vec3(u_xlat16_18) * unity_LightColor[u_xlati_loop_1].xyz;
                  u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5);
                  u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(1.0, 1.0, 1.0));
                  u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
              }
              vs_COLOR0.xyz = u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_COLOR0.w = 1.0;
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
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          mediump vec3 u_xlat16_3;
          mediump vec3 u_xlat16_4;
          float u_xlat15;
          int u_xlati15;
          mediump float u_xlat16_18;
          void main()
          {
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat1.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat2.xyz;
              u_xlat0.x = dot(u_xlat0.xyz, in_NORMAL0.xyz);
              u_xlat0.y = dot(u_xlat1.xyz, in_NORMAL0.xyz);
              u_xlat0.z = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat15 = inversesqrt(u_xlat15);
              u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
              u_xlat16_3.xyz = glstate_lightmodel_ambient.xyz;
              for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
              {
                  u_xlat16_18 = dot(u_xlat0.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
                  u_xlat16_18 = max(u_xlat16_18, 0.0);
                  u_xlat16_4.xyz = vec3(u_xlat16_18) * unity_LightColor[u_xlati_loop_1].xyz;
                  u_xlat16_4.xyz = u_xlat16_4.xyz * vec3(0.5, 0.5, 0.5);
                  u_xlat16_4.xyz = min(u_xlat16_4.xyz, vec3(1.0, 1.0, 1.0));
                  u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_4.xyz;
              }
              vs_COLOR0.xyz = u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              vs_COLOR0.w = 1.0;
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
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "POINT" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform mediump vec4 unity_LightAtten[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_7;
            mediump vec3 eyeNormal_8;
            highp vec3 eyePos_9;
            mediump vec4 color_10;
            color_10 = vec4(0.0, 0.0, 0.0, 1.1);
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = tmpvar_5;
            eyePos_9 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_11).xyz;
            highp mat3 tmpvar_12;
            tmpvar_12[0] = tmpvar_2.xyz;
            tmpvar_12[1] = tmpvar_3.xyz;
            tmpvar_12[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_13;
            tmpvar_13 = normalize((tmpvar_12 * _glesNormal));
            eyeNormal_8 = tmpvar_13;
            lowp vec3 tmpvar_14;
            tmpvar_14 = glstate_lightmodel_ambient.xyz;
            lcolor_7 = tmpvar_14;
            for (highp int il_6 = 0; il_6 < 8; il_6++) {
              mediump float att_15;
              highp vec3 dirToLight_16;
              dirToLight_16 = (unity_LightPosition[il_6].xyz - (eyePos_9 * unity_LightPosition[il_6].w));
              highp float tmpvar_17;
              tmpvar_17 = dot (dirToLight_16, dirToLight_16);
              att_15 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_17))));
              if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_17 > unity_LightAtten[il_6].w))) {
                att_15 = 0.0;
              };
              dirToLight_16 = (dirToLight_16 * inversesqrt(max (tmpvar_17, 1e-6)));
              att_15 = (att_15 * 0.5);
              mediump vec3 dirToLight_18;
              dirToLight_18 = dirToLight_16;
              lcolor_7 = (lcolor_7 + min ((
                (vec3(max (dot (eyeNormal_8, dirToLight_18), 0.0)) * unity_LightColor[il_6].xyz)
               * att_15), vec3(1.0, 1.0, 1.0)));
            };
            color_10.xyz = lcolor_7;
            color_10.w = 1.0;
            lowp vec4 tmpvar_19;
            mediump vec4 tmpvar_20;
            tmpvar_20 = clamp (color_10, 0.0, 1.0);
            tmpvar_19 = tmpvar_20;
            highp vec4 tmpvar_21;
            tmpvar_21.w = 1.0;
            tmpvar_21.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_19;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            gl_FragData[0] = col_1;
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
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform mediump vec4 unity_LightAtten[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_7;
            mediump vec3 eyeNormal_8;
            highp vec3 eyePos_9;
            mediump vec4 color_10;
            color_10 = vec4(0.0, 0.0, 0.0, 1.1);
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = tmpvar_5;
            eyePos_9 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_11).xyz;
            highp mat3 tmpvar_12;
            tmpvar_12[0] = tmpvar_2.xyz;
            tmpvar_12[1] = tmpvar_3.xyz;
            tmpvar_12[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_13;
            tmpvar_13 = normalize((tmpvar_12 * _glesNormal));
            eyeNormal_8 = tmpvar_13;
            lowp vec3 tmpvar_14;
            tmpvar_14 = glstate_lightmodel_ambient.xyz;
            lcolor_7 = tmpvar_14;
            for (highp int il_6 = 0; il_6 < 8; il_6++) {
              mediump float att_15;
              highp vec3 dirToLight_16;
              dirToLight_16 = (unity_LightPosition[il_6].xyz - (eyePos_9 * unity_LightPosition[il_6].w));
              highp float tmpvar_17;
              tmpvar_17 = dot (dirToLight_16, dirToLight_16);
              att_15 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_17))));
              if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_17 > unity_LightAtten[il_6].w))) {
                att_15 = 0.0;
              };
              dirToLight_16 = (dirToLight_16 * inversesqrt(max (tmpvar_17, 1e-6)));
              att_15 = (att_15 * 0.5);
              mediump vec3 dirToLight_18;
              dirToLight_18 = dirToLight_16;
              lcolor_7 = (lcolor_7 + min ((
                (vec3(max (dot (eyeNormal_8, dirToLight_18), 0.0)) * unity_LightColor[il_6].xyz)
               * att_15), vec3(1.0, 1.0, 1.0)));
            };
            color_10.xyz = lcolor_7;
            color_10.w = 1.0;
            lowp vec4 tmpvar_19;
            mediump vec4 tmpvar_20;
            tmpvar_20 = clamp (color_10, 0.0, 1.0);
            tmpvar_19 = tmpvar_20;
            highp vec4 tmpvar_21;
            tmpvar_21.w = 1.0;
            tmpvar_21.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_19;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            gl_FragData[0] = col_1;
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
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform mediump vec4 unity_LightAtten[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_7;
            mediump vec3 eyeNormal_8;
            highp vec3 eyePos_9;
            mediump vec4 color_10;
            color_10 = vec4(0.0, 0.0, 0.0, 1.1);
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = tmpvar_5;
            eyePos_9 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_11).xyz;
            highp mat3 tmpvar_12;
            tmpvar_12[0] = tmpvar_2.xyz;
            tmpvar_12[1] = tmpvar_3.xyz;
            tmpvar_12[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_13;
            tmpvar_13 = normalize((tmpvar_12 * _glesNormal));
            eyeNormal_8 = tmpvar_13;
            lowp vec3 tmpvar_14;
            tmpvar_14 = glstate_lightmodel_ambient.xyz;
            lcolor_7 = tmpvar_14;
            for (highp int il_6 = 0; il_6 < 8; il_6++) {
              mediump float att_15;
              highp vec3 dirToLight_16;
              dirToLight_16 = (unity_LightPosition[il_6].xyz - (eyePos_9 * unity_LightPosition[il_6].w));
              highp float tmpvar_17;
              tmpvar_17 = dot (dirToLight_16, dirToLight_16);
              att_15 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_17))));
              if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_17 > unity_LightAtten[il_6].w))) {
                att_15 = 0.0;
              };
              dirToLight_16 = (dirToLight_16 * inversesqrt(max (tmpvar_17, 1e-6)));
              att_15 = (att_15 * 0.5);
              mediump vec3 dirToLight_18;
              dirToLight_18 = dirToLight_16;
              lcolor_7 = (lcolor_7 + min ((
                (vec3(max (dot (eyeNormal_8, dirToLight_18), 0.0)) * unity_LightColor[il_6].xyz)
               * att_15), vec3(1.0, 1.0, 1.0)));
            };
            color_10.xyz = lcolor_7;
            color_10.w = 1.0;
            lowp vec4 tmpvar_19;
            mediump vec4 tmpvar_20;
            tmpvar_20 = clamp (color_10, 0.0, 1.0);
            tmpvar_19 = tmpvar_20;
            highp vec4 tmpvar_21;
            tmpvar_21.w = 1.0;
            tmpvar_21.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_19;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            gl_FragData[0] = col_1;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	mediump vec4 unity_LightAtten[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          int u_xlati0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          bool u_xlatb4;
          mediump vec3 u_xlat16_5;
          float u_xlat6;
          vec3 u_xlat7;
          bool u_xlatb7;
          mediump vec3 u_xlat16_9;
          float u_xlat10;
          bool u_xlatb10;
          bool u_xlatb12;
          float u_xlat13;
          float u_xlat18;
          int u_xlati18;
          bool u_xlatb18;
          bool u_xlatb19;
          float u_xlat20;
          bool u_xlatb20;
          mediump float u_xlat16_21;
          void main()
          {
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
              u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
              u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[1].w<u_xlat18);
          #else
              u_xlatb19 = unity_LightAtten[1].w<u_xlat18;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(unity_LightPosition[1].w!=0.0);
          #else
              u_xlatb2 = unity_LightPosition[1].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb2;
              u_xlat2.x = unity_LightAtten[1].z * u_xlat18 + 1.0;
              u_xlat18 = max(u_xlat18, 9.99999997e-07);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
              u_xlat18 = float(1.0) / u_xlat2.x;
              u_xlat18 = u_xlat18 * 0.5;
              u_xlat16_3.x = (u_xlatb19) ? 0.0 : u_xlat18;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
              u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
              u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
              u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
              u_xlat16_9.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
              u_xlat16_9.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz;
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
              u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
              u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[0].w<u_xlat18);
          #else
              u_xlatb19 = unity_LightAtten[0].w<u_xlat18;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb20 = !!(unity_LightPosition[0].w!=0.0);
          #else
              u_xlatb20 = unity_LightPosition[0].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb20;
              u_xlat20 = unity_LightAtten[0].z * u_xlat18 + 1.0;
              u_xlat18 = max(u_xlat18, 9.99999997e-07);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[0].xyz;
              u_xlat18 = float(1.0) / u_xlat20;
              u_xlat18 = u_xlat18 * 0.5;
              u_xlat16_21 = (u_xlatb19) ? 0.0 : u_xlat18;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_5.xyz + glstate_lightmodel_ambient.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb18 = !!(0<unity_VertexLightParams.x);
          #else
              u_xlatb18 = 0<unity_VertexLightParams.x;
          #endif
              u_xlat16_5.xyz = (bool(u_xlatb18)) ? u_xlat16_5.xyz : glstate_lightmodel_ambient.xyz;
              u_xlati18 = u_xlatb18 ? 1 : int(0);
              u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb1 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlati18 = (u_xlatb1) ? 2 : u_xlati18;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[2].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[2].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[2].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[2].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[2].xyz;
              u_xlat7.x = float(1.0) / u_xlat10;
              u_xlat7.x = u_xlat7.x * 0.5;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat7.x;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[3].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[3].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[3].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[3].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[3].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[3].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 3 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[4].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[4].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[4].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[4].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[4].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[4].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 4 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[5].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[5].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[5].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[5].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[5].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[5].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 5 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
              u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[6].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[6].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[6].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[6].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[6].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[6].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 6 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat13 = max(u_xlat7.x, 9.99999997e-07);
              u_xlat13 = inversesqrt(u_xlat13);
              u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat0.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[7].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(unity_LightAtten[7].w<u_xlat7.x);
          #else
              u_xlatb0 = unity_LightAtten[7].w<u_xlat7.x;
          #endif
              u_xlat6 = unity_LightAtten[7].z * u_xlat7.x + 1.0;
              u_xlat6 = float(1.0) / u_xlat6;
              u_xlat6 = u_xlat6 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb12 = !!(unity_LightPosition[7].w!=0.0);
          #else
              u_xlatb12 = unity_LightPosition[7].w!=0.0;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb12;
              u_xlat16_21 = (u_xlatb0) ? 0.0 : u_xlat6;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 7 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb1;
              vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	mediump vec4 unity_LightAtten[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          int u_xlati0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          bool u_xlatb4;
          mediump vec3 u_xlat16_5;
          float u_xlat6;
          vec3 u_xlat7;
          bool u_xlatb7;
          mediump vec3 u_xlat16_9;
          float u_xlat10;
          bool u_xlatb10;
          bool u_xlatb12;
          float u_xlat13;
          float u_xlat18;
          int u_xlati18;
          bool u_xlatb18;
          bool u_xlatb19;
          float u_xlat20;
          bool u_xlatb20;
          mediump float u_xlat16_21;
          void main()
          {
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
              u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
              u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[1].w<u_xlat18);
          #else
              u_xlatb19 = unity_LightAtten[1].w<u_xlat18;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(unity_LightPosition[1].w!=0.0);
          #else
              u_xlatb2 = unity_LightPosition[1].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb2;
              u_xlat2.x = unity_LightAtten[1].z * u_xlat18 + 1.0;
              u_xlat18 = max(u_xlat18, 9.99999997e-07);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
              u_xlat18 = float(1.0) / u_xlat2.x;
              u_xlat18 = u_xlat18 * 0.5;
              u_xlat16_3.x = (u_xlatb19) ? 0.0 : u_xlat18;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
              u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
              u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
              u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
              u_xlat16_9.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
              u_xlat16_9.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz;
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
              u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
              u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[0].w<u_xlat18);
          #else
              u_xlatb19 = unity_LightAtten[0].w<u_xlat18;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb20 = !!(unity_LightPosition[0].w!=0.0);
          #else
              u_xlatb20 = unity_LightPosition[0].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb20;
              u_xlat20 = unity_LightAtten[0].z * u_xlat18 + 1.0;
              u_xlat18 = max(u_xlat18, 9.99999997e-07);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[0].xyz;
              u_xlat18 = float(1.0) / u_xlat20;
              u_xlat18 = u_xlat18 * 0.5;
              u_xlat16_21 = (u_xlatb19) ? 0.0 : u_xlat18;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_5.xyz + glstate_lightmodel_ambient.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb18 = !!(0<unity_VertexLightParams.x);
          #else
              u_xlatb18 = 0<unity_VertexLightParams.x;
          #endif
              u_xlat16_5.xyz = (bool(u_xlatb18)) ? u_xlat16_5.xyz : glstate_lightmodel_ambient.xyz;
              u_xlati18 = u_xlatb18 ? 1 : int(0);
              u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb1 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlati18 = (u_xlatb1) ? 2 : u_xlati18;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[2].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[2].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[2].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[2].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[2].xyz;
              u_xlat7.x = float(1.0) / u_xlat10;
              u_xlat7.x = u_xlat7.x * 0.5;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat7.x;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[3].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[3].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[3].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[3].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[3].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[3].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 3 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[4].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[4].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[4].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[4].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[4].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[4].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 4 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[5].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[5].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[5].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[5].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[5].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[5].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 5 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
              u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[6].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[6].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[6].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[6].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[6].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[6].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 6 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat13 = max(u_xlat7.x, 9.99999997e-07);
              u_xlat13 = inversesqrt(u_xlat13);
              u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat0.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[7].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(unity_LightAtten[7].w<u_xlat7.x);
          #else
              u_xlatb0 = unity_LightAtten[7].w<u_xlat7.x;
          #endif
              u_xlat6 = unity_LightAtten[7].z * u_xlat7.x + 1.0;
              u_xlat6 = float(1.0) / u_xlat6;
              u_xlat6 = u_xlat6 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb12 = !!(unity_LightPosition[7].w!=0.0);
          #else
              u_xlatb12 = unity_LightPosition[7].w!=0.0;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb12;
              u_xlat16_21 = (u_xlatb0) ? 0.0 : u_xlat6;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 7 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb1;
              vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	mediump vec4 unity_LightAtten[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          int u_xlati0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          bool u_xlatb4;
          mediump vec3 u_xlat16_5;
          float u_xlat6;
          vec3 u_xlat7;
          bool u_xlatb7;
          mediump vec3 u_xlat16_9;
          float u_xlat10;
          bool u_xlatb10;
          bool u_xlatb12;
          float u_xlat13;
          float u_xlat18;
          int u_xlati18;
          bool u_xlatb18;
          bool u_xlatb19;
          float u_xlat20;
          bool u_xlatb20;
          mediump float u_xlat16_21;
          void main()
          {
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
              u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
              u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[1].w<u_xlat18);
          #else
              u_xlatb19 = unity_LightAtten[1].w<u_xlat18;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(unity_LightPosition[1].w!=0.0);
          #else
              u_xlatb2 = unity_LightPosition[1].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb2;
              u_xlat2.x = unity_LightAtten[1].z * u_xlat18 + 1.0;
              u_xlat18 = max(u_xlat18, 9.99999997e-07);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
              u_xlat18 = float(1.0) / u_xlat2.x;
              u_xlat18 = u_xlat18 * 0.5;
              u_xlat16_3.x = (u_xlatb19) ? 0.0 : u_xlat18;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
              u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
              u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
              u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
              u_xlat16_9.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
              u_xlat16_9.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz;
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
              u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
              u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[0].w<u_xlat18);
          #else
              u_xlatb19 = unity_LightAtten[0].w<u_xlat18;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb20 = !!(unity_LightPosition[0].w!=0.0);
          #else
              u_xlatb20 = unity_LightPosition[0].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb20;
              u_xlat20 = unity_LightAtten[0].z * u_xlat18 + 1.0;
              u_xlat18 = max(u_xlat18, 9.99999997e-07);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[0].xyz;
              u_xlat18 = float(1.0) / u_xlat20;
              u_xlat18 = u_xlat18 * 0.5;
              u_xlat16_21 = (u_xlatb19) ? 0.0 : u_xlat18;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_5.xyz + glstate_lightmodel_ambient.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb18 = !!(0<unity_VertexLightParams.x);
          #else
              u_xlatb18 = 0<unity_VertexLightParams.x;
          #endif
              u_xlat16_5.xyz = (bool(u_xlatb18)) ? u_xlat16_5.xyz : glstate_lightmodel_ambient.xyz;
              u_xlati18 = u_xlatb18 ? 1 : int(0);
              u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb1 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlati18 = (u_xlatb1) ? 2 : u_xlati18;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[2].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[2].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[2].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[2].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[2].xyz;
              u_xlat7.x = float(1.0) / u_xlat10;
              u_xlat7.x = u_xlat7.x * 0.5;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat7.x;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[3].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[3].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[3].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[3].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[3].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[3].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 3 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[4].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[4].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[4].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[4].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[4].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[4].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 4 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[5].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[5].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[5].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[5].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[5].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[5].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 5 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
              u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[6].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[6].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[6].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[6].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[6].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[6].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 6 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat13 = max(u_xlat7.x, 9.99999997e-07);
              u_xlat13 = inversesqrt(u_xlat13);
              u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat0.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[7].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(unity_LightAtten[7].w<u_xlat7.x);
          #else
              u_xlatb0 = unity_LightAtten[7].w<u_xlat7.x;
          #endif
              u_xlat6 = unity_LightAtten[7].z * u_xlat7.x + 1.0;
              u_xlat6 = float(1.0) / u_xlat6;
              u_xlat6 = u_xlat6 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb12 = !!(unity_LightPosition[7].w!=0.0);
          #else
              u_xlatb12 = unity_LightPosition[7].w!=0.0;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb12;
              u_xlat16_21 = (u_xlatb0) ? 0.0 : u_xlat6;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 7 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb1;
              vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
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
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform mediump vec4 unity_LightAtten[8];
          uniform highp vec4 unity_SpotDirection[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_7;
            mediump vec3 eyeNormal_8;
            highp vec3 eyePos_9;
            mediump vec4 color_10;
            color_10 = vec4(0.0, 0.0, 0.0, 1.1);
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = tmpvar_5;
            eyePos_9 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_11).xyz;
            highp mat3 tmpvar_12;
            tmpvar_12[0] = tmpvar_2.xyz;
            tmpvar_12[1] = tmpvar_3.xyz;
            tmpvar_12[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_13;
            tmpvar_13 = normalize((tmpvar_12 * _glesNormal));
            eyeNormal_8 = tmpvar_13;
            lowp vec3 tmpvar_14;
            tmpvar_14 = glstate_lightmodel_ambient.xyz;
            lcolor_7 = tmpvar_14;
            for (highp int il_6 = 0; il_6 < 8; il_6++) {
              mediump float rho_15;
              mediump float att_16;
              highp vec3 dirToLight_17;
              dirToLight_17 = (unity_LightPosition[il_6].xyz - (eyePos_9 * unity_LightPosition[il_6].w));
              highp float tmpvar_18;
              tmpvar_18 = dot (dirToLight_17, dirToLight_17);
              att_16 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_18))));
              if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_18 > unity_LightAtten[il_6].w))) {
                att_16 = 0.0;
              };
              dirToLight_17 = (dirToLight_17 * inversesqrt(max (tmpvar_18, 1e-6)));
              highp float tmpvar_19;
              tmpvar_19 = max (dot (dirToLight_17, unity_SpotDirection[il_6].xyz), 0.0);
              rho_15 = tmpvar_19;
              att_16 = (att_16 * clamp ((
                (rho_15 - unity_LightAtten[il_6].x)
               * unity_LightAtten[il_6].y), 0.0, 1.0));
              att_16 = (att_16 * 0.5);
              mediump vec3 dirToLight_20;
              dirToLight_20 = dirToLight_17;
              lcolor_7 = (lcolor_7 + min ((
                (vec3(max (dot (eyeNormal_8, dirToLight_20), 0.0)) * unity_LightColor[il_6].xyz)
               * att_16), vec3(1.0, 1.0, 1.0)));
            };
            color_10.xyz = lcolor_7;
            color_10.w = 1.0;
            lowp vec4 tmpvar_21;
            mediump vec4 tmpvar_22;
            tmpvar_22 = clamp (color_10, 0.0, 1.0);
            tmpvar_21 = tmpvar_22;
            highp vec4 tmpvar_23;
            tmpvar_23.w = 1.0;
            tmpvar_23.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_21;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            gl_FragData[0] = col_1;
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
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform mediump vec4 unity_LightAtten[8];
          uniform highp vec4 unity_SpotDirection[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_7;
            mediump vec3 eyeNormal_8;
            highp vec3 eyePos_9;
            mediump vec4 color_10;
            color_10 = vec4(0.0, 0.0, 0.0, 1.1);
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = tmpvar_5;
            eyePos_9 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_11).xyz;
            highp mat3 tmpvar_12;
            tmpvar_12[0] = tmpvar_2.xyz;
            tmpvar_12[1] = tmpvar_3.xyz;
            tmpvar_12[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_13;
            tmpvar_13 = normalize((tmpvar_12 * _glesNormal));
            eyeNormal_8 = tmpvar_13;
            lowp vec3 tmpvar_14;
            tmpvar_14 = glstate_lightmodel_ambient.xyz;
            lcolor_7 = tmpvar_14;
            for (highp int il_6 = 0; il_6 < 8; il_6++) {
              mediump float rho_15;
              mediump float att_16;
              highp vec3 dirToLight_17;
              dirToLight_17 = (unity_LightPosition[il_6].xyz - (eyePos_9 * unity_LightPosition[il_6].w));
              highp float tmpvar_18;
              tmpvar_18 = dot (dirToLight_17, dirToLight_17);
              att_16 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_18))));
              if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_18 > unity_LightAtten[il_6].w))) {
                att_16 = 0.0;
              };
              dirToLight_17 = (dirToLight_17 * inversesqrt(max (tmpvar_18, 1e-6)));
              highp float tmpvar_19;
              tmpvar_19 = max (dot (dirToLight_17, unity_SpotDirection[il_6].xyz), 0.0);
              rho_15 = tmpvar_19;
              att_16 = (att_16 * clamp ((
                (rho_15 - unity_LightAtten[il_6].x)
               * unity_LightAtten[il_6].y), 0.0, 1.0));
              att_16 = (att_16 * 0.5);
              mediump vec3 dirToLight_20;
              dirToLight_20 = dirToLight_17;
              lcolor_7 = (lcolor_7 + min ((
                (vec3(max (dot (eyeNormal_8, dirToLight_20), 0.0)) * unity_LightColor[il_6].xyz)
               * att_16), vec3(1.0, 1.0, 1.0)));
            };
            color_10.xyz = lcolor_7;
            color_10.w = 1.0;
            lowp vec4 tmpvar_21;
            mediump vec4 tmpvar_22;
            tmpvar_22 = clamp (color_10, 0.0, 1.0);
            tmpvar_21 = tmpvar_22;
            highp vec4 tmpvar_23;
            tmpvar_23.w = 1.0;
            tmpvar_23.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_21;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            gl_FragData[0] = col_1;
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
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform mediump vec4 unity_LightAtten[8];
          uniform highp vec4 unity_SpotDirection[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_7;
            mediump vec3 eyeNormal_8;
            highp vec3 eyePos_9;
            mediump vec4 color_10;
            color_10 = vec4(0.0, 0.0, 0.0, 1.1);
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = tmpvar_5;
            eyePos_9 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_11).xyz;
            highp mat3 tmpvar_12;
            tmpvar_12[0] = tmpvar_2.xyz;
            tmpvar_12[1] = tmpvar_3.xyz;
            tmpvar_12[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_13;
            tmpvar_13 = normalize((tmpvar_12 * _glesNormal));
            eyeNormal_8 = tmpvar_13;
            lowp vec3 tmpvar_14;
            tmpvar_14 = glstate_lightmodel_ambient.xyz;
            lcolor_7 = tmpvar_14;
            for (highp int il_6 = 0; il_6 < 8; il_6++) {
              mediump float rho_15;
              mediump float att_16;
              highp vec3 dirToLight_17;
              dirToLight_17 = (unity_LightPosition[il_6].xyz - (eyePos_9 * unity_LightPosition[il_6].w));
              highp float tmpvar_18;
              tmpvar_18 = dot (dirToLight_17, dirToLight_17);
              att_16 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_18))));
              if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_18 > unity_LightAtten[il_6].w))) {
                att_16 = 0.0;
              };
              dirToLight_17 = (dirToLight_17 * inversesqrt(max (tmpvar_18, 1e-6)));
              highp float tmpvar_19;
              tmpvar_19 = max (dot (dirToLight_17, unity_SpotDirection[il_6].xyz), 0.0);
              rho_15 = tmpvar_19;
              att_16 = (att_16 * clamp ((
                (rho_15 - unity_LightAtten[il_6].x)
               * unity_LightAtten[il_6].y), 0.0, 1.0));
              att_16 = (att_16 * 0.5);
              mediump vec3 dirToLight_20;
              dirToLight_20 = dirToLight_17;
              lcolor_7 = (lcolor_7 + min ((
                (vec3(max (dot (eyeNormal_8, dirToLight_20), 0.0)) * unity_LightColor[il_6].xyz)
               * att_16), vec3(1.0, 1.0, 1.0)));
            };
            color_10.xyz = lcolor_7;
            color_10.w = 1.0;
            lowp vec4 tmpvar_21;
            mediump vec4 tmpvar_22;
            tmpvar_22 = clamp (color_10, 0.0, 1.0);
            tmpvar_21 = tmpvar_22;
            highp vec4 tmpvar_23;
            tmpvar_23.w = 1.0;
            tmpvar_23.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_21;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_23));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            gl_FragData[0] = col_1;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	mediump vec4 unity_LightAtten[8];
          uniform 	vec4 unity_SpotDirection[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          int u_xlati0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          bool u_xlatb4;
          mediump vec3 u_xlat16_5;
          float u_xlat6;
          vec3 u_xlat7;
          bool u_xlatb7;
          mediump vec3 u_xlat16_9;
          float u_xlat10;
          bool u_xlatb10;
          bool u_xlatb12;
          float u_xlat13;
          float u_xlat18;
          int u_xlati18;
          bool u_xlatb18;
          bool u_xlatb19;
          float u_xlat20;
          bool u_xlatb20;
          mediump float u_xlat16_21;
          mediump float u_xlat16_23;
          void main()
          {
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
              u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
              u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[1].w<u_xlat18);
          #else
              u_xlatb19 = unity_LightAtten[1].w<u_xlat18;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(unity_LightPosition[1].w!=0.0);
          #else
              u_xlatb2 = unity_LightPosition[1].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb2;
              u_xlat2.x = unity_LightAtten[1].z * u_xlat18 + 1.0;
              u_xlat18 = max(u_xlat18, 9.99999997e-07);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
              u_xlat18 = float(1.0) / u_xlat2.x;
              u_xlat16_3.x = (u_xlatb19) ? 0.0 : u_xlat18;
              u_xlat18 = dot(u_xlat1.xyz, unity_SpotDirection[1].xyz);
              u_xlat18 = max(u_xlat18, 0.0);
              u_xlat16_9.x = u_xlat18 + (-unity_LightAtten[1].x);
              u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[1].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
          #else
              u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
          #endif
              u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x;
              u_xlat16_3.x = u_xlat16_3.x * 0.5;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
              u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
              u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
              u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
              u_xlat16_9.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
              u_xlat16_9.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz;
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
              u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
              u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[0].w<u_xlat18);
          #else
              u_xlatb19 = unity_LightAtten[0].w<u_xlat18;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb20 = !!(unity_LightPosition[0].w!=0.0);
          #else
              u_xlatb20 = unity_LightPosition[0].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb20;
              u_xlat20 = unity_LightAtten[0].z * u_xlat18 + 1.0;
              u_xlat18 = max(u_xlat18, 9.99999997e-07);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
              u_xlat18 = float(1.0) / u_xlat20;
              u_xlat16_21 = (u_xlatb19) ? 0.0 : u_xlat18;
              u_xlat18 = dot(u_xlat1.xyz, unity_SpotDirection[0].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[0].xyz;
              u_xlat18 = max(u_xlat18, 0.0);
              u_xlat16_23 = u_xlat18 + (-unity_LightAtten[0].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[0].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_5.xyz + glstate_lightmodel_ambient.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb18 = !!(0<unity_VertexLightParams.x);
          #else
              u_xlatb18 = 0<unity_VertexLightParams.x;
          #endif
              u_xlat16_5.xyz = (bool(u_xlatb18)) ? u_xlat16_5.xyz : glstate_lightmodel_ambient.xyz;
              u_xlati18 = u_xlatb18 ? 1 : int(0);
              u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb1 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlati18 = (u_xlatb1) ? 2 : u_xlati18;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[2].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[2].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[2].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[2].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[2].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[2].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[2].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[2].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[3].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[3].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[3].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[3].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[3].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[3].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[3].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[3].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[3].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 3 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[4].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[4].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[4].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[4].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[4].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[4].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[4].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[4].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[4].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 4 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[5].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[5].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[5].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[5].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[5].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[5].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[5].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[5].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[5].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 5 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
              u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[6].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[6].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[6].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[6].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[6].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[6].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[6].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[6].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[6].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 6 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat13 = max(u_xlat7.x, 9.99999997e-07);
              u_xlat13 = inversesqrt(u_xlat13);
              u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
              u_xlat13 = dot(u_xlat0.xyz, unity_SpotDirection[7].xyz);
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat0.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[7].xyz;
              u_xlat0.x = max(u_xlat13, 0.0);
              u_xlat16_21 = u_xlat0.x + (-unity_LightAtten[7].x);
              u_xlat16_21 = u_xlat16_21 * unity_LightAtten[7].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
          #else
              u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(unity_LightAtten[7].w<u_xlat7.x);
          #else
              u_xlatb0 = unity_LightAtten[7].w<u_xlat7.x;
          #endif
              u_xlat6 = unity_LightAtten[7].z * u_xlat7.x + 1.0;
              u_xlat6 = float(1.0) / u_xlat6;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb12 = !!(unity_LightPosition[7].w!=0.0);
          #else
              u_xlatb12 = unity_LightPosition[7].w!=0.0;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb12;
              u_xlat16_23 = (u_xlatb0) ? 0.0 : u_xlat6;
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 7 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb1;
              vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	mediump vec4 unity_LightAtten[8];
          uniform 	vec4 unity_SpotDirection[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          int u_xlati0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          bool u_xlatb4;
          mediump vec3 u_xlat16_5;
          float u_xlat6;
          vec3 u_xlat7;
          bool u_xlatb7;
          mediump vec3 u_xlat16_9;
          float u_xlat10;
          bool u_xlatb10;
          bool u_xlatb12;
          float u_xlat13;
          float u_xlat18;
          int u_xlati18;
          bool u_xlatb18;
          bool u_xlatb19;
          float u_xlat20;
          bool u_xlatb20;
          mediump float u_xlat16_21;
          mediump float u_xlat16_23;
          void main()
          {
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
              u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
              u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[1].w<u_xlat18);
          #else
              u_xlatb19 = unity_LightAtten[1].w<u_xlat18;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(unity_LightPosition[1].w!=0.0);
          #else
              u_xlatb2 = unity_LightPosition[1].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb2;
              u_xlat2.x = unity_LightAtten[1].z * u_xlat18 + 1.0;
              u_xlat18 = max(u_xlat18, 9.99999997e-07);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
              u_xlat18 = float(1.0) / u_xlat2.x;
              u_xlat16_3.x = (u_xlatb19) ? 0.0 : u_xlat18;
              u_xlat18 = dot(u_xlat1.xyz, unity_SpotDirection[1].xyz);
              u_xlat18 = max(u_xlat18, 0.0);
              u_xlat16_9.x = u_xlat18 + (-unity_LightAtten[1].x);
              u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[1].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
          #else
              u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
          #endif
              u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x;
              u_xlat16_3.x = u_xlat16_3.x * 0.5;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
              u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
              u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
              u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
              u_xlat16_9.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
              u_xlat16_9.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz;
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
              u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
              u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[0].w<u_xlat18);
          #else
              u_xlatb19 = unity_LightAtten[0].w<u_xlat18;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb20 = !!(unity_LightPosition[0].w!=0.0);
          #else
              u_xlatb20 = unity_LightPosition[0].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb20;
              u_xlat20 = unity_LightAtten[0].z * u_xlat18 + 1.0;
              u_xlat18 = max(u_xlat18, 9.99999997e-07);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
              u_xlat18 = float(1.0) / u_xlat20;
              u_xlat16_21 = (u_xlatb19) ? 0.0 : u_xlat18;
              u_xlat18 = dot(u_xlat1.xyz, unity_SpotDirection[0].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[0].xyz;
              u_xlat18 = max(u_xlat18, 0.0);
              u_xlat16_23 = u_xlat18 + (-unity_LightAtten[0].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[0].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_5.xyz + glstate_lightmodel_ambient.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb18 = !!(0<unity_VertexLightParams.x);
          #else
              u_xlatb18 = 0<unity_VertexLightParams.x;
          #endif
              u_xlat16_5.xyz = (bool(u_xlatb18)) ? u_xlat16_5.xyz : glstate_lightmodel_ambient.xyz;
              u_xlati18 = u_xlatb18 ? 1 : int(0);
              u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb1 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlati18 = (u_xlatb1) ? 2 : u_xlati18;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[2].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[2].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[2].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[2].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[2].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[2].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[2].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[2].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[3].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[3].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[3].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[3].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[3].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[3].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[3].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[3].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[3].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 3 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[4].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[4].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[4].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[4].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[4].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[4].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[4].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[4].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[4].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 4 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[5].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[5].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[5].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[5].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[5].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[5].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[5].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[5].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[5].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 5 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
              u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[6].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[6].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[6].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[6].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[6].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[6].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[6].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[6].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[6].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 6 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat13 = max(u_xlat7.x, 9.99999997e-07);
              u_xlat13 = inversesqrt(u_xlat13);
              u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
              u_xlat13 = dot(u_xlat0.xyz, unity_SpotDirection[7].xyz);
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat0.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[7].xyz;
              u_xlat0.x = max(u_xlat13, 0.0);
              u_xlat16_21 = u_xlat0.x + (-unity_LightAtten[7].x);
              u_xlat16_21 = u_xlat16_21 * unity_LightAtten[7].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
          #else
              u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(unity_LightAtten[7].w<u_xlat7.x);
          #else
              u_xlatb0 = unity_LightAtten[7].w<u_xlat7.x;
          #endif
              u_xlat6 = unity_LightAtten[7].z * u_xlat7.x + 1.0;
              u_xlat6 = float(1.0) / u_xlat6;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb12 = !!(unity_LightPosition[7].w!=0.0);
          #else
              u_xlatb12 = unity_LightPosition[7].w!=0.0;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb12;
              u_xlat16_23 = (u_xlatb0) ? 0.0 : u_xlat6;
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 7 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb1;
              vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	mediump vec4 unity_LightAtten[8];
          uniform 	vec4 unity_SpotDirection[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          vec4 u_xlat0;
          int u_xlati0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          bool u_xlatb4;
          mediump vec3 u_xlat16_5;
          float u_xlat6;
          vec3 u_xlat7;
          bool u_xlatb7;
          mediump vec3 u_xlat16_9;
          float u_xlat10;
          bool u_xlatb10;
          bool u_xlatb12;
          float u_xlat13;
          float u_xlat18;
          int u_xlati18;
          bool u_xlatb18;
          bool u_xlatb19;
          float u_xlat20;
          bool u_xlatb20;
          mediump float u_xlat16_21;
          mediump float u_xlat16_23;
          void main()
          {
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
              u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
              u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[1].w<u_xlat18);
          #else
              u_xlatb19 = unity_LightAtten[1].w<u_xlat18;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(unity_LightPosition[1].w!=0.0);
          #else
              u_xlatb2 = unity_LightPosition[1].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb2;
              u_xlat2.x = unity_LightAtten[1].z * u_xlat18 + 1.0;
              u_xlat18 = max(u_xlat18, 9.99999997e-07);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
              u_xlat18 = float(1.0) / u_xlat2.x;
              u_xlat16_3.x = (u_xlatb19) ? 0.0 : u_xlat18;
              u_xlat18 = dot(u_xlat1.xyz, unity_SpotDirection[1].xyz);
              u_xlat18 = max(u_xlat18, 0.0);
              u_xlat16_9.x = u_xlat18 + (-unity_LightAtten[1].x);
              u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[1].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
          #else
              u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
          #endif
              u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x;
              u_xlat16_3.x = u_xlat16_3.x * 0.5;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
              u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
              u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
              u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
              u_xlat16_9.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
              u_xlat16_9.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz;
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
              u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat1.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
              u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[0].w<u_xlat18);
          #else
              u_xlatb19 = unity_LightAtten[0].w<u_xlat18;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb20 = !!(unity_LightPosition[0].w!=0.0);
          #else
              u_xlatb20 = unity_LightPosition[0].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb20;
              u_xlat20 = unity_LightAtten[0].z * u_xlat18 + 1.0;
              u_xlat18 = max(u_xlat18, 9.99999997e-07);
              u_xlat18 = inversesqrt(u_xlat18);
              u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
              u_xlat18 = float(1.0) / u_xlat20;
              u_xlat16_21 = (u_xlatb19) ? 0.0 : u_xlat18;
              u_xlat18 = dot(u_xlat1.xyz, unity_SpotDirection[0].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[0].xyz;
              u_xlat18 = max(u_xlat18, 0.0);
              u_xlat16_23 = u_xlat18 + (-unity_LightAtten[0].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[0].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_5.xyz + glstate_lightmodel_ambient.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb18 = !!(0<unity_VertexLightParams.x);
          #else
              u_xlatb18 = 0<unity_VertexLightParams.x;
          #endif
              u_xlat16_5.xyz = (bool(u_xlatb18)) ? u_xlat16_5.xyz : glstate_lightmodel_ambient.xyz;
              u_xlati18 = u_xlatb18 ? 1 : int(0);
              u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb1 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlati18 = (u_xlatb1) ? 2 : u_xlati18;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[2].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[2].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[2].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[2].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[2].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[2].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[2].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[2].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[3].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[3].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[3].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[3].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[3].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[3].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[3].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[3].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[3].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 3 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[4].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[4].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[4].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[4].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[4].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[4].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[4].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[4].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[4].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 4 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[5].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[5].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[5].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[5].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[5].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[5].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[5].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[5].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[5].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 5 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
              u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[6].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[6].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[6].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[6].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[6].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[6].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[6].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[6].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[6].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati18 = (u_xlatb1) ? 6 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati18<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati18<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat13 = max(u_xlat7.x, 9.99999997e-07);
              u_xlat13 = inversesqrt(u_xlat13);
              u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat13);
              u_xlat13 = dot(u_xlat0.xyz, unity_SpotDirection[7].xyz);
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat0.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[7].xyz;
              u_xlat0.x = max(u_xlat13, 0.0);
              u_xlat16_21 = u_xlat0.x + (-unity_LightAtten[7].x);
              u_xlat16_21 = u_xlat16_21 * unity_LightAtten[7].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_21 = min(max(u_xlat16_21, 0.0), 1.0);
          #else
              u_xlat16_21 = clamp(u_xlat16_21, 0.0, 1.0);
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(unity_LightAtten[7].w<u_xlat7.x);
          #else
              u_xlatb0 = unity_LightAtten[7].w<u_xlat7.x;
          #endif
              u_xlat6 = unity_LightAtten[7].z * u_xlat7.x + 1.0;
              u_xlat6 = float(1.0) / u_xlat6;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb12 = !!(unity_LightPosition[7].w!=0.0);
          #else
              u_xlatb12 = unity_LightPosition[7].w!=0.0;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb12;
              u_xlat16_23 = (u_xlatb0) ? 0.0 : u_xlat6;
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 7 : u_xlati18;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb1;
              vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              SV_Target0.xyz = u_xlat16_1.xyz + u_xlat16_1.xyz;
              SV_Target0.w = 1.0;
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
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_6;
            mediump vec3 eyeNormal_7;
            mediump vec4 color_8;
            highp vec4 tmpvar_9;
            tmpvar_9.w = 1.0;
            tmpvar_9.xyz = tmpvar_5;
            highp vec3 tmpvar_10;
            tmpvar_10 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_9).xyz;
            highp mat3 tmpvar_11;
            tmpvar_11[0] = tmpvar_2.xyz;
            tmpvar_11[1] = tmpvar_3.xyz;
            tmpvar_11[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_12;
            tmpvar_12 = normalize((tmpvar_11 * _glesNormal));
            eyeNormal_7 = tmpvar_12;
            lowp vec3 tmpvar_13;
            tmpvar_13 = glstate_lightmodel_ambient.xyz;
            lcolor_6 = tmpvar_13;
            highp vec3 tmpvar_14;
            tmpvar_14 = unity_LightPosition[0].xyz;
            mediump vec3 dirToLight_15;
            dirToLight_15 = tmpvar_14;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_15), 0.0)) * unity_LightColor[0].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_16;
            tmpvar_16 = unity_LightPosition[1].xyz;
            mediump vec3 dirToLight_17;
            dirToLight_17 = tmpvar_16;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_17), 0.0)) * unity_LightColor[1].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_18;
            tmpvar_18 = unity_LightPosition[2].xyz;
            mediump vec3 dirToLight_19;
            dirToLight_19 = tmpvar_18;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_19), 0.0)) * unity_LightColor[2].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_20;
            tmpvar_20 = unity_LightPosition[3].xyz;
            mediump vec3 dirToLight_21;
            dirToLight_21 = tmpvar_20;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_21), 0.0)) * unity_LightColor[3].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_22;
            tmpvar_22 = unity_LightPosition[4].xyz;
            mediump vec3 dirToLight_23;
            dirToLight_23 = tmpvar_22;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_23), 0.0)) * unity_LightColor[4].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_24;
            tmpvar_24 = unity_LightPosition[5].xyz;
            mediump vec3 dirToLight_25;
            dirToLight_25 = tmpvar_24;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_25), 0.0)) * unity_LightColor[5].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_26;
            tmpvar_26 = unity_LightPosition[6].xyz;
            mediump vec3 dirToLight_27;
            dirToLight_27 = tmpvar_26;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_27), 0.0)) * unity_LightColor[6].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_28;
            tmpvar_28 = unity_LightPosition[7].xyz;
            mediump vec3 dirToLight_29;
            dirToLight_29 = tmpvar_28;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_29), 0.0)) * unity_LightColor[7].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            color_8.xyz = lcolor_6;
            color_8.w = 1.0;
            lowp vec4 tmpvar_30;
            mediump vec4 tmpvar_31;
            tmpvar_31 = clamp (color_8, 0.0, 1.0);
            tmpvar_30 = tmpvar_31;
            lowp float tmpvar_32;
            highp float tmpvar_33;
            tmpvar_33 = clamp (((
              sqrt(dot (tmpvar_10, tmpvar_10))
             * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
            tmpvar_32 = tmpvar_33;
            highp vec4 tmpvar_34;
            tmpvar_34.w = 1.0;
            tmpvar_34.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_30;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_32;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
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
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_6;
            mediump vec3 eyeNormal_7;
            mediump vec4 color_8;
            highp vec4 tmpvar_9;
            tmpvar_9.w = 1.0;
            tmpvar_9.xyz = tmpvar_5;
            highp vec3 tmpvar_10;
            tmpvar_10 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_9).xyz;
            highp mat3 tmpvar_11;
            tmpvar_11[0] = tmpvar_2.xyz;
            tmpvar_11[1] = tmpvar_3.xyz;
            tmpvar_11[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_12;
            tmpvar_12 = normalize((tmpvar_11 * _glesNormal));
            eyeNormal_7 = tmpvar_12;
            lowp vec3 tmpvar_13;
            tmpvar_13 = glstate_lightmodel_ambient.xyz;
            lcolor_6 = tmpvar_13;
            highp vec3 tmpvar_14;
            tmpvar_14 = unity_LightPosition[0].xyz;
            mediump vec3 dirToLight_15;
            dirToLight_15 = tmpvar_14;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_15), 0.0)) * unity_LightColor[0].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_16;
            tmpvar_16 = unity_LightPosition[1].xyz;
            mediump vec3 dirToLight_17;
            dirToLight_17 = tmpvar_16;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_17), 0.0)) * unity_LightColor[1].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_18;
            tmpvar_18 = unity_LightPosition[2].xyz;
            mediump vec3 dirToLight_19;
            dirToLight_19 = tmpvar_18;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_19), 0.0)) * unity_LightColor[2].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_20;
            tmpvar_20 = unity_LightPosition[3].xyz;
            mediump vec3 dirToLight_21;
            dirToLight_21 = tmpvar_20;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_21), 0.0)) * unity_LightColor[3].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_22;
            tmpvar_22 = unity_LightPosition[4].xyz;
            mediump vec3 dirToLight_23;
            dirToLight_23 = tmpvar_22;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_23), 0.0)) * unity_LightColor[4].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_24;
            tmpvar_24 = unity_LightPosition[5].xyz;
            mediump vec3 dirToLight_25;
            dirToLight_25 = tmpvar_24;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_25), 0.0)) * unity_LightColor[5].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_26;
            tmpvar_26 = unity_LightPosition[6].xyz;
            mediump vec3 dirToLight_27;
            dirToLight_27 = tmpvar_26;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_27), 0.0)) * unity_LightColor[6].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_28;
            tmpvar_28 = unity_LightPosition[7].xyz;
            mediump vec3 dirToLight_29;
            dirToLight_29 = tmpvar_28;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_29), 0.0)) * unity_LightColor[7].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            color_8.xyz = lcolor_6;
            color_8.w = 1.0;
            lowp vec4 tmpvar_30;
            mediump vec4 tmpvar_31;
            tmpvar_31 = clamp (color_8, 0.0, 1.0);
            tmpvar_30 = tmpvar_31;
            lowp float tmpvar_32;
            highp float tmpvar_33;
            tmpvar_33 = clamp (((
              sqrt(dot (tmpvar_10, tmpvar_10))
             * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
            tmpvar_32 = tmpvar_33;
            highp vec4 tmpvar_34;
            tmpvar_34.w = 1.0;
            tmpvar_34.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_30;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_32;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
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
          attribute vec3 _glesNormal;
          attribute vec4 _glesMultiTexCoord0;
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_6;
            mediump vec3 eyeNormal_7;
            mediump vec4 color_8;
            highp vec4 tmpvar_9;
            tmpvar_9.w = 1.0;
            tmpvar_9.xyz = tmpvar_5;
            highp vec3 tmpvar_10;
            tmpvar_10 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_9).xyz;
            highp mat3 tmpvar_11;
            tmpvar_11[0] = tmpvar_2.xyz;
            tmpvar_11[1] = tmpvar_3.xyz;
            tmpvar_11[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_12;
            tmpvar_12 = normalize((tmpvar_11 * _glesNormal));
            eyeNormal_7 = tmpvar_12;
            lowp vec3 tmpvar_13;
            tmpvar_13 = glstate_lightmodel_ambient.xyz;
            lcolor_6 = tmpvar_13;
            highp vec3 tmpvar_14;
            tmpvar_14 = unity_LightPosition[0].xyz;
            mediump vec3 dirToLight_15;
            dirToLight_15 = tmpvar_14;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_15), 0.0)) * unity_LightColor[0].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_16;
            tmpvar_16 = unity_LightPosition[1].xyz;
            mediump vec3 dirToLight_17;
            dirToLight_17 = tmpvar_16;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_17), 0.0)) * unity_LightColor[1].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_18;
            tmpvar_18 = unity_LightPosition[2].xyz;
            mediump vec3 dirToLight_19;
            dirToLight_19 = tmpvar_18;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_19), 0.0)) * unity_LightColor[2].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_20;
            tmpvar_20 = unity_LightPosition[3].xyz;
            mediump vec3 dirToLight_21;
            dirToLight_21 = tmpvar_20;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_21), 0.0)) * unity_LightColor[3].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_22;
            tmpvar_22 = unity_LightPosition[4].xyz;
            mediump vec3 dirToLight_23;
            dirToLight_23 = tmpvar_22;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_23), 0.0)) * unity_LightColor[4].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_24;
            tmpvar_24 = unity_LightPosition[5].xyz;
            mediump vec3 dirToLight_25;
            dirToLight_25 = tmpvar_24;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_25), 0.0)) * unity_LightColor[5].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_26;
            tmpvar_26 = unity_LightPosition[6].xyz;
            mediump vec3 dirToLight_27;
            dirToLight_27 = tmpvar_26;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_27), 0.0)) * unity_LightColor[6].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            highp vec3 tmpvar_28;
            tmpvar_28 = unity_LightPosition[7].xyz;
            mediump vec3 dirToLight_29;
            dirToLight_29 = tmpvar_28;
            lcolor_6 = (lcolor_6 + min ((
              (vec3(max (dot (eyeNormal_7, dirToLight_29), 0.0)) * unity_LightColor[7].xyz)
             * 0.5), vec3(1.0, 1.0, 1.0)));
            color_8.xyz = lcolor_6;
            color_8.w = 1.0;
            lowp vec4 tmpvar_30;
            mediump vec4 tmpvar_31;
            tmpvar_31 = clamp (color_8, 0.0, 1.0);
            tmpvar_30 = tmpvar_31;
            lowp float tmpvar_32;
            highp float tmpvar_33;
            tmpvar_33 = clamp (((
              sqrt(dot (tmpvar_10, tmpvar_10))
             * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
            tmpvar_32 = tmpvar_33;
            highp vec4 tmpvar_34;
            tmpvar_34.w = 1.0;
            tmpvar_34.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_30;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_32;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_34));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out mediump float vs_TEXCOORD1;
          vec3 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          vec3 u_xlat3;
          vec3 u_xlat4;
          vec3 u_xlat5;
          vec3 u_xlat6;
          mediump vec3 u_xlat16_7;
          mediump vec3 u_xlat16_8;
          float u_xlat27;
          int u_xlati27;
          bool u_xlatb28;
          mediump float u_xlat16_34;
          void main()
          {
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
              u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
              u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
              u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
              u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
              u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
              u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
              u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
              u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
              u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
              u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
              u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat27 = inversesqrt(u_xlat27);
              u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
              u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz;
              for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
              {
                  u_xlat16_34 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
                  u_xlat16_34 = max(u_xlat16_34, 0.0);
                  u_xlat16_8.xyz = vec3(u_xlat16_34) * unity_LightColor[u_xlati_loop_1].xyz;
                  u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5);
                  u_xlat16_8.xyz = min(u_xlat16_8.xyz, vec3(1.0, 1.0, 1.0));
                  u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
              }
              vs_COLOR0.xyz = u_xlat16_7.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = sqrt(u_xlat0.x);
              u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
              u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD1 = u_xlat0.x;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_FogColor;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in mediump float vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
              SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
              SV_Target0.w = 1.0;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out mediump float vs_TEXCOORD1;
          vec3 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          vec3 u_xlat3;
          vec3 u_xlat4;
          vec3 u_xlat5;
          vec3 u_xlat6;
          mediump vec3 u_xlat16_7;
          mediump vec3 u_xlat16_8;
          float u_xlat27;
          int u_xlati27;
          bool u_xlatb28;
          mediump float u_xlat16_34;
          void main()
          {
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
              u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
              u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
              u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
              u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
              u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
              u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
              u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
              u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
              u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
              u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
              u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat27 = inversesqrt(u_xlat27);
              u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
              u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz;
              for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
              {
                  u_xlat16_34 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
                  u_xlat16_34 = max(u_xlat16_34, 0.0);
                  u_xlat16_8.xyz = vec3(u_xlat16_34) * unity_LightColor[u_xlati_loop_1].xyz;
                  u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5);
                  u_xlat16_8.xyz = min(u_xlat16_8.xyz, vec3(1.0, 1.0, 1.0));
                  u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
              }
              vs_COLOR0.xyz = u_xlat16_7.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = sqrt(u_xlat0.x);
              u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
              u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD1 = u_xlat0.x;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_FogColor;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in mediump float vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
              SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
              SV_Target0.w = 1.0;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out mediump float vs_TEXCOORD1;
          vec3 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          vec3 u_xlat3;
          vec3 u_xlat4;
          vec3 u_xlat5;
          vec3 u_xlat6;
          mediump vec3 u_xlat16_7;
          mediump vec3 u_xlat16_8;
          float u_xlat27;
          int u_xlati27;
          bool u_xlatb28;
          mediump float u_xlat16_34;
          void main()
          {
              u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
              u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
              u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
              u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
              u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
              u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
              u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
              u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
              u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
              u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
              u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
              u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
              u_xlat27 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat27 = inversesqrt(u_xlat27);
              u_xlat1.xyz = vec3(u_xlat27) * u_xlat1.xyz;
              u_xlat16_7.xyz = glstate_lightmodel_ambient.xyz;
              for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
              {
                  u_xlat16_34 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
                  u_xlat16_34 = max(u_xlat16_34, 0.0);
                  u_xlat16_8.xyz = vec3(u_xlat16_34) * unity_LightColor[u_xlati_loop_1].xyz;
                  u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(0.5, 0.5, 0.5);
                  u_xlat16_8.xyz = min(u_xlat16_8.xyz, vec3(1.0, 1.0, 1.0));
                  u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_8.xyz;
              }
              vs_COLOR0.xyz = u_xlat16_7.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = sqrt(u_xlat0.x);
              u_xlat0.x = u_xlat0.x * unity_FogParams.z + unity_FogParams.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
          #else
              u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
          #endif
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
              u_xlat1 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD1 = u_xlat0.x;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_FogColor;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in mediump float vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
              SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
              SV_Target0.w = 1.0;
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
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform mediump vec4 unity_LightAtten[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_7;
            mediump vec3 eyeNormal_8;
            highp vec3 eyePos_9;
            mediump vec4 color_10;
            color_10 = vec4(0.0, 0.0, 0.0, 1.1);
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = tmpvar_5;
            highp vec3 tmpvar_12;
            tmpvar_12 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_11).xyz;
            eyePos_9 = tmpvar_12;
            highp mat3 tmpvar_13;
            tmpvar_13[0] = tmpvar_2.xyz;
            tmpvar_13[1] = tmpvar_3.xyz;
            tmpvar_13[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_14;
            tmpvar_14 = normalize((tmpvar_13 * _glesNormal));
            eyeNormal_8 = tmpvar_14;
            lowp vec3 tmpvar_15;
            tmpvar_15 = glstate_lightmodel_ambient.xyz;
            lcolor_7 = tmpvar_15;
            for (highp int il_6 = 0; il_6 < 8; il_6++) {
              mediump float att_16;
              highp vec3 dirToLight_17;
              dirToLight_17 = (unity_LightPosition[il_6].xyz - (eyePos_9 * unity_LightPosition[il_6].w));
              highp float tmpvar_18;
              tmpvar_18 = dot (dirToLight_17, dirToLight_17);
              att_16 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_18))));
              if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_18 > unity_LightAtten[il_6].w))) {
                att_16 = 0.0;
              };
              dirToLight_17 = (dirToLight_17 * inversesqrt(max (tmpvar_18, 1e-6)));
              att_16 = (att_16 * 0.5);
              mediump vec3 dirToLight_19;
              dirToLight_19 = dirToLight_17;
              lcolor_7 = (lcolor_7 + min ((
                (vec3(max (dot (eyeNormal_8, dirToLight_19), 0.0)) * unity_LightColor[il_6].xyz)
               * att_16), vec3(1.0, 1.0, 1.0)));
            };
            color_10.xyz = lcolor_7;
            color_10.w = 1.0;
            lowp vec4 tmpvar_20;
            mediump vec4 tmpvar_21;
            tmpvar_21 = clamp (color_10, 0.0, 1.0);
            tmpvar_20 = tmpvar_21;
            lowp float tmpvar_22;
            highp float tmpvar_23;
            tmpvar_23 = clamp (((
              sqrt(dot (tmpvar_12, tmpvar_12))
             * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
            tmpvar_22 = tmpvar_23;
            highp vec4 tmpvar_24;
            tmpvar_24.w = 1.0;
            tmpvar_24.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_20;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_22;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_24));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
            gl_FragData[0] = col_1;
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
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform mediump vec4 unity_LightAtten[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_7;
            mediump vec3 eyeNormal_8;
            highp vec3 eyePos_9;
            mediump vec4 color_10;
            color_10 = vec4(0.0, 0.0, 0.0, 1.1);
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = tmpvar_5;
            highp vec3 tmpvar_12;
            tmpvar_12 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_11).xyz;
            eyePos_9 = tmpvar_12;
            highp mat3 tmpvar_13;
            tmpvar_13[0] = tmpvar_2.xyz;
            tmpvar_13[1] = tmpvar_3.xyz;
            tmpvar_13[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_14;
            tmpvar_14 = normalize((tmpvar_13 * _glesNormal));
            eyeNormal_8 = tmpvar_14;
            lowp vec3 tmpvar_15;
            tmpvar_15 = glstate_lightmodel_ambient.xyz;
            lcolor_7 = tmpvar_15;
            for (highp int il_6 = 0; il_6 < 8; il_6++) {
              mediump float att_16;
              highp vec3 dirToLight_17;
              dirToLight_17 = (unity_LightPosition[il_6].xyz - (eyePos_9 * unity_LightPosition[il_6].w));
              highp float tmpvar_18;
              tmpvar_18 = dot (dirToLight_17, dirToLight_17);
              att_16 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_18))));
              if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_18 > unity_LightAtten[il_6].w))) {
                att_16 = 0.0;
              };
              dirToLight_17 = (dirToLight_17 * inversesqrt(max (tmpvar_18, 1e-6)));
              att_16 = (att_16 * 0.5);
              mediump vec3 dirToLight_19;
              dirToLight_19 = dirToLight_17;
              lcolor_7 = (lcolor_7 + min ((
                (vec3(max (dot (eyeNormal_8, dirToLight_19), 0.0)) * unity_LightColor[il_6].xyz)
               * att_16), vec3(1.0, 1.0, 1.0)));
            };
            color_10.xyz = lcolor_7;
            color_10.w = 1.0;
            lowp vec4 tmpvar_20;
            mediump vec4 tmpvar_21;
            tmpvar_21 = clamp (color_10, 0.0, 1.0);
            tmpvar_20 = tmpvar_21;
            lowp float tmpvar_22;
            highp float tmpvar_23;
            tmpvar_23 = clamp (((
              sqrt(dot (tmpvar_12, tmpvar_12))
             * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
            tmpvar_22 = tmpvar_23;
            highp vec4 tmpvar_24;
            tmpvar_24.w = 1.0;
            tmpvar_24.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_20;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_22;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_24));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
            gl_FragData[0] = col_1;
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
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform mediump vec4 unity_LightAtten[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_7;
            mediump vec3 eyeNormal_8;
            highp vec3 eyePos_9;
            mediump vec4 color_10;
            color_10 = vec4(0.0, 0.0, 0.0, 1.1);
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = tmpvar_5;
            highp vec3 tmpvar_12;
            tmpvar_12 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_11).xyz;
            eyePos_9 = tmpvar_12;
            highp mat3 tmpvar_13;
            tmpvar_13[0] = tmpvar_2.xyz;
            tmpvar_13[1] = tmpvar_3.xyz;
            tmpvar_13[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_14;
            tmpvar_14 = normalize((tmpvar_13 * _glesNormal));
            eyeNormal_8 = tmpvar_14;
            lowp vec3 tmpvar_15;
            tmpvar_15 = glstate_lightmodel_ambient.xyz;
            lcolor_7 = tmpvar_15;
            for (highp int il_6 = 0; il_6 < 8; il_6++) {
              mediump float att_16;
              highp vec3 dirToLight_17;
              dirToLight_17 = (unity_LightPosition[il_6].xyz - (eyePos_9 * unity_LightPosition[il_6].w));
              highp float tmpvar_18;
              tmpvar_18 = dot (dirToLight_17, dirToLight_17);
              att_16 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_18))));
              if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_18 > unity_LightAtten[il_6].w))) {
                att_16 = 0.0;
              };
              dirToLight_17 = (dirToLight_17 * inversesqrt(max (tmpvar_18, 1e-6)));
              att_16 = (att_16 * 0.5);
              mediump vec3 dirToLight_19;
              dirToLight_19 = dirToLight_17;
              lcolor_7 = (lcolor_7 + min ((
                (vec3(max (dot (eyeNormal_8, dirToLight_19), 0.0)) * unity_LightColor[il_6].xyz)
               * att_16), vec3(1.0, 1.0, 1.0)));
            };
            color_10.xyz = lcolor_7;
            color_10.w = 1.0;
            lowp vec4 tmpvar_20;
            mediump vec4 tmpvar_21;
            tmpvar_21 = clamp (color_10, 0.0, 1.0);
            tmpvar_20 = tmpvar_21;
            lowp float tmpvar_22;
            highp float tmpvar_23;
            tmpvar_23 = clamp (((
              sqrt(dot (tmpvar_12, tmpvar_12))
             * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
            tmpvar_22 = tmpvar_23;
            highp vec4 tmpvar_24;
            tmpvar_24.w = 1.0;
            tmpvar_24.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_20;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_22;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_24));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
            gl_FragData[0] = col_1;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	mediump vec4 unity_LightAtten[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out mediump float vs_TEXCOORD1;
          vec4 u_xlat0;
          int u_xlati0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          mediump vec3 u_xlat16_5;
          vec3 u_xlat6;
          vec3 u_xlat7;
          bool u_xlatb7;
          mediump vec3 u_xlat16_9;
          float u_xlat12;
          bool u_xlatb12;
          float u_xlat13;
          bool u_xlatb18;
          float u_xlat19;
          bool u_xlatb19;
          float u_xlat20;
          mediump float u_xlat16_21;
          void main()
          {
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
          #else
              u_xlatb0 = unity_LightPosition[1].w!=0.0;
          #endif
              u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat6.xyz;
              u_xlat6.xyz = u_xlat6.xyz * in_POSITION0.yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat6.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat6.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat6.xyz + u_xlat1.xyz;
              u_xlat1.xyz = (-u_xlat6.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
              u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat19);
          #else
              u_xlatb2 = unity_LightAtten[1].w<u_xlat19;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb2;
              u_xlat2.x = unity_LightAtten[1].z * u_xlat19 + 1.0;
              u_xlat19 = max(u_xlat19, 9.99999997e-07);
              u_xlat19 = inversesqrt(u_xlat19);
              u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
              u_xlat19 = float(1.0) / u_xlat2.x;
              u_xlat19 = u_xlat19 * 0.5;
              u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat19;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
              u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
              u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
              u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat0.x = inversesqrt(u_xlat0.x);
              u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
              u_xlat16_9.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
              u_xlat16_9.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz;
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
              u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat1.xyz = (-u_xlat6.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
              u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat19 = max(u_xlat0.x, 9.99999997e-07);
              u_xlat19 = inversesqrt(u_xlat19);
              u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[0].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(unity_LightAtten[0].w<u_xlat0.x);
          #else
              u_xlatb1 = unity_LightAtten[0].w<u_xlat0.x;
          #endif
              u_xlat0.x = unity_LightAtten[0].z * u_xlat0.x + 1.0;
              u_xlat0.x = float(1.0) / u_xlat0.x;
              u_xlat0.x = u_xlat0.x * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightPosition[0].w!=0.0);
          #else
              u_xlatb7 = unity_LightPosition[0].w!=0.0;
          #endif
              u_xlatb1 = u_xlatb1 && u_xlatb7;
              u_xlat16_21 = (u_xlatb1) ? 0.0 : u_xlat0.x;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_5.xyz + glstate_lightmodel_ambient.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = 0<unity_VertexLightParams.x;
          #endif
              u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : glstate_lightmodel_ambient.xyz;
              u_xlati0 = u_xlatb0 ? 1 : int(0);
              u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb1 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlati0 = (u_xlatb1) ? 2 : u_xlati0;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[2].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[2].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[2].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[2].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[2].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[2].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[3].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[3].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[3].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[3].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[3].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[3].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 3 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[4].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[4].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[4].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[4].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[4].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[4].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 4 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[5].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[5].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[5].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[5].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[5].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[5].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 5 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[6].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[6].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[6].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[6].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[6].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[6].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 6 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
              u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
              u_xlat6.x = sqrt(u_xlat6.x);
              u_xlat6.x = u_xlat6.x * unity_FogParams.z + unity_FogParams.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
          #else
              u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
          #endif
              vs_TEXCOORD1 = u_xlat6.x;
              u_xlat6.x = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat12 = max(u_xlat6.x, 9.99999997e-07);
              u_xlat12 = inversesqrt(u_xlat12);
              u_xlat7.xyz = vec3(u_xlat12) * u_xlat7.xyz;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[7].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb12 = !!(unity_LightAtten[7].w<u_xlat6.x);
          #else
              u_xlatb12 = unity_LightAtten[7].w<u_xlat6.x;
          #endif
              u_xlat6.x = unity_LightAtten[7].z * u_xlat6.x + 1.0;
              u_xlat6.x = float(1.0) / u_xlat6.x;
              u_xlat6.x = u_xlat6.x * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb18 = !!(unity_LightPosition[7].w!=0.0);
          #else
              u_xlatb18 = unity_LightPosition[7].w!=0.0;
          #endif
              u_xlatb12 = u_xlatb12 && u_xlatb18;
              u_xlat16_21 = (u_xlatb12) ? 0.0 : u_xlat6.x;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 7 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb1;
              vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_FogColor;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in mediump float vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
              SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
              SV_Target0.w = 1.0;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	mediump vec4 unity_LightAtten[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out mediump float vs_TEXCOORD1;
          vec4 u_xlat0;
          int u_xlati0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          mediump vec3 u_xlat16_5;
          vec3 u_xlat6;
          vec3 u_xlat7;
          bool u_xlatb7;
          mediump vec3 u_xlat16_9;
          float u_xlat12;
          bool u_xlatb12;
          float u_xlat13;
          bool u_xlatb18;
          float u_xlat19;
          bool u_xlatb19;
          float u_xlat20;
          mediump float u_xlat16_21;
          void main()
          {
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
          #else
              u_xlatb0 = unity_LightPosition[1].w!=0.0;
          #endif
              u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat6.xyz;
              u_xlat6.xyz = u_xlat6.xyz * in_POSITION0.yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat6.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat6.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat6.xyz + u_xlat1.xyz;
              u_xlat1.xyz = (-u_xlat6.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
              u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat19);
          #else
              u_xlatb2 = unity_LightAtten[1].w<u_xlat19;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb2;
              u_xlat2.x = unity_LightAtten[1].z * u_xlat19 + 1.0;
              u_xlat19 = max(u_xlat19, 9.99999997e-07);
              u_xlat19 = inversesqrt(u_xlat19);
              u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
              u_xlat19 = float(1.0) / u_xlat2.x;
              u_xlat19 = u_xlat19 * 0.5;
              u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat19;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
              u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
              u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
              u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat0.x = inversesqrt(u_xlat0.x);
              u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
              u_xlat16_9.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
              u_xlat16_9.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz;
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
              u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat1.xyz = (-u_xlat6.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
              u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat19 = max(u_xlat0.x, 9.99999997e-07);
              u_xlat19 = inversesqrt(u_xlat19);
              u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[0].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(unity_LightAtten[0].w<u_xlat0.x);
          #else
              u_xlatb1 = unity_LightAtten[0].w<u_xlat0.x;
          #endif
              u_xlat0.x = unity_LightAtten[0].z * u_xlat0.x + 1.0;
              u_xlat0.x = float(1.0) / u_xlat0.x;
              u_xlat0.x = u_xlat0.x * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightPosition[0].w!=0.0);
          #else
              u_xlatb7 = unity_LightPosition[0].w!=0.0;
          #endif
              u_xlatb1 = u_xlatb1 && u_xlatb7;
              u_xlat16_21 = (u_xlatb1) ? 0.0 : u_xlat0.x;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_5.xyz + glstate_lightmodel_ambient.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = 0<unity_VertexLightParams.x;
          #endif
              u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : glstate_lightmodel_ambient.xyz;
              u_xlati0 = u_xlatb0 ? 1 : int(0);
              u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb1 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlati0 = (u_xlatb1) ? 2 : u_xlati0;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[2].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[2].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[2].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[2].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[2].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[2].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[3].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[3].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[3].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[3].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[3].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[3].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 3 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[4].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[4].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[4].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[4].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[4].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[4].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 4 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[5].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[5].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[5].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[5].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[5].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[5].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 5 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[6].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[6].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[6].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[6].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[6].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[6].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 6 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
              u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
              u_xlat6.x = sqrt(u_xlat6.x);
              u_xlat6.x = u_xlat6.x * unity_FogParams.z + unity_FogParams.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
          #else
              u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
          #endif
              vs_TEXCOORD1 = u_xlat6.x;
              u_xlat6.x = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat12 = max(u_xlat6.x, 9.99999997e-07);
              u_xlat12 = inversesqrt(u_xlat12);
              u_xlat7.xyz = vec3(u_xlat12) * u_xlat7.xyz;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[7].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb12 = !!(unity_LightAtten[7].w<u_xlat6.x);
          #else
              u_xlatb12 = unity_LightAtten[7].w<u_xlat6.x;
          #endif
              u_xlat6.x = unity_LightAtten[7].z * u_xlat6.x + 1.0;
              u_xlat6.x = float(1.0) / u_xlat6.x;
              u_xlat6.x = u_xlat6.x * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb18 = !!(unity_LightPosition[7].w!=0.0);
          #else
              u_xlatb18 = unity_LightPosition[7].w!=0.0;
          #endif
              u_xlatb12 = u_xlatb12 && u_xlatb18;
              u_xlat16_21 = (u_xlatb12) ? 0.0 : u_xlat6.x;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 7 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb1;
              vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_FogColor;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in mediump float vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
              SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
              SV_Target0.w = 1.0;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	mediump vec4 unity_LightAtten[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out mediump float vs_TEXCOORD1;
          vec4 u_xlat0;
          int u_xlati0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          mediump vec3 u_xlat16_5;
          vec3 u_xlat6;
          vec3 u_xlat7;
          bool u_xlatb7;
          mediump vec3 u_xlat16_9;
          float u_xlat12;
          bool u_xlatb12;
          float u_xlat13;
          bool u_xlatb18;
          float u_xlat19;
          bool u_xlatb19;
          float u_xlat20;
          mediump float u_xlat16_21;
          void main()
          {
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
          #else
              u_xlatb0 = unity_LightPosition[1].w!=0.0;
          #endif
              u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat6.xyz;
              u_xlat6.xyz = u_xlat6.xyz * in_POSITION0.yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat6.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat6.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat6.xyz + u_xlat1.xyz;
              u_xlat1.xyz = (-u_xlat6.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
              u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat19);
          #else
              u_xlatb2 = unity_LightAtten[1].w<u_xlat19;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb2;
              u_xlat2.x = unity_LightAtten[1].z * u_xlat19 + 1.0;
              u_xlat19 = max(u_xlat19, 9.99999997e-07);
              u_xlat19 = inversesqrt(u_xlat19);
              u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
              u_xlat19 = float(1.0) / u_xlat2.x;
              u_xlat19 = u_xlat19 * 0.5;
              u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat19;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
              u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
              u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
              u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat0.x = inversesqrt(u_xlat0.x);
              u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
              u_xlat16_9.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
              u_xlat16_9.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz;
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
              u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat1.xyz = (-u_xlat6.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
              u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat19 = max(u_xlat0.x, 9.99999997e-07);
              u_xlat19 = inversesqrt(u_xlat19);
              u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[0].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(unity_LightAtten[0].w<u_xlat0.x);
          #else
              u_xlatb1 = unity_LightAtten[0].w<u_xlat0.x;
          #endif
              u_xlat0.x = unity_LightAtten[0].z * u_xlat0.x + 1.0;
              u_xlat0.x = float(1.0) / u_xlat0.x;
              u_xlat0.x = u_xlat0.x * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightPosition[0].w!=0.0);
          #else
              u_xlatb7 = unity_LightPosition[0].w!=0.0;
          #endif
              u_xlatb1 = u_xlatb1 && u_xlatb7;
              u_xlat16_21 = (u_xlatb1) ? 0.0 : u_xlat0.x;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_5.xyz + glstate_lightmodel_ambient.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = 0<unity_VertexLightParams.x;
          #endif
              u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : glstate_lightmodel_ambient.xyz;
              u_xlati0 = u_xlatb0 ? 1 : int(0);
              u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb1 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlati0 = (u_xlatb1) ? 2 : u_xlati0;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[2].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[2].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[2].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[2].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[2].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[2].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[3].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[3].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[3].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[3].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[3].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[3].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 3 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[4].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[4].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[4].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[4].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[4].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[4].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 4 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[5].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[5].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[5].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[5].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[5].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[5].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 5 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat4.x = max(u_xlat20, 9.99999997e-07);
              u_xlat4.x = inversesqrt(u_xlat4.x);
              u_xlat7.xyz = u_xlat7.xyz * u_xlat4.xxx;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[6].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(unity_LightAtten[6].w<u_xlat20);
          #else
              u_xlatb7 = unity_LightAtten[6].w<u_xlat20;
          #endif
              u_xlat13 = unity_LightAtten[6].z * u_xlat20 + 1.0;
              u_xlat13 = float(1.0) / u_xlat13;
              u_xlat13 = u_xlat13 * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightPosition[6].w!=0.0);
          #else
              u_xlatb19 = unity_LightPosition[6].w!=0.0;
          #endif
              u_xlatb7 = u_xlatb7 && u_xlatb19;
              u_xlat16_21 = (u_xlatb7) ? 0.0 : u_xlat13;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 6 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
              u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
              u_xlat6.x = sqrt(u_xlat6.x);
              u_xlat6.x = u_xlat6.x * unity_FogParams.z + unity_FogParams.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
          #else
              u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
          #endif
              vs_TEXCOORD1 = u_xlat6.x;
              u_xlat6.x = dot(u_xlat7.xyz, u_xlat7.xyz);
              u_xlat12 = max(u_xlat6.x, 9.99999997e-07);
              u_xlat12 = inversesqrt(u_xlat12);
              u_xlat7.xyz = vec3(u_xlat12) * u_xlat7.xyz;
              u_xlat16_21 = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_21 = max(u_xlat16_21, 0.0);
              u_xlat16_5.xyz = vec3(u_xlat16_21) * unity_LightColor[7].xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb12 = !!(unity_LightAtten[7].w<u_xlat6.x);
          #else
              u_xlatb12 = unity_LightAtten[7].w<u_xlat6.x;
          #endif
              u_xlat6.x = unity_LightAtten[7].z * u_xlat6.x + 1.0;
              u_xlat6.x = float(1.0) / u_xlat6.x;
              u_xlat6.x = u_xlat6.x * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb18 = !!(unity_LightPosition[7].w!=0.0);
          #else
              u_xlatb18 = unity_LightPosition[7].w!=0.0;
          #endif
              u_xlatb12 = u_xlatb12 && u_xlatb18;
              u_xlat16_21 = (u_xlatb12) ? 0.0 : u_xlat6.x;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 7 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb1;
              vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_FogColor;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in mediump float vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
              SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
              SV_Target0.w = 1.0;
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
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform mediump vec4 unity_LightAtten[8];
          uniform highp vec4 unity_SpotDirection[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_7;
            mediump vec3 eyeNormal_8;
            highp vec3 eyePos_9;
            mediump vec4 color_10;
            color_10 = vec4(0.0, 0.0, 0.0, 1.1);
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = tmpvar_5;
            highp vec3 tmpvar_12;
            tmpvar_12 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_11).xyz;
            eyePos_9 = tmpvar_12;
            highp mat3 tmpvar_13;
            tmpvar_13[0] = tmpvar_2.xyz;
            tmpvar_13[1] = tmpvar_3.xyz;
            tmpvar_13[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_14;
            tmpvar_14 = normalize((tmpvar_13 * _glesNormal));
            eyeNormal_8 = tmpvar_14;
            lowp vec3 tmpvar_15;
            tmpvar_15 = glstate_lightmodel_ambient.xyz;
            lcolor_7 = tmpvar_15;
            for (highp int il_6 = 0; il_6 < 8; il_6++) {
              mediump float rho_16;
              mediump float att_17;
              highp vec3 dirToLight_18;
              dirToLight_18 = (unity_LightPosition[il_6].xyz - (eyePos_9 * unity_LightPosition[il_6].w));
              highp float tmpvar_19;
              tmpvar_19 = dot (dirToLight_18, dirToLight_18);
              att_17 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_19))));
              if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_19 > unity_LightAtten[il_6].w))) {
                att_17 = 0.0;
              };
              dirToLight_18 = (dirToLight_18 * inversesqrt(max (tmpvar_19, 1e-6)));
              highp float tmpvar_20;
              tmpvar_20 = max (dot (dirToLight_18, unity_SpotDirection[il_6].xyz), 0.0);
              rho_16 = tmpvar_20;
              att_17 = (att_17 * clamp ((
                (rho_16 - unity_LightAtten[il_6].x)
               * unity_LightAtten[il_6].y), 0.0, 1.0));
              att_17 = (att_17 * 0.5);
              mediump vec3 dirToLight_21;
              dirToLight_21 = dirToLight_18;
              lcolor_7 = (lcolor_7 + min ((
                (vec3(max (dot (eyeNormal_8, dirToLight_21), 0.0)) * unity_LightColor[il_6].xyz)
               * att_17), vec3(1.0, 1.0, 1.0)));
            };
            color_10.xyz = lcolor_7;
            color_10.w = 1.0;
            lowp vec4 tmpvar_22;
            mediump vec4 tmpvar_23;
            tmpvar_23 = clamp (color_10, 0.0, 1.0);
            tmpvar_22 = tmpvar_23;
            lowp float tmpvar_24;
            highp float tmpvar_25;
            tmpvar_25 = clamp (((
              sqrt(dot (tmpvar_12, tmpvar_12))
             * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
            tmpvar_24 = tmpvar_25;
            highp vec4 tmpvar_26;
            tmpvar_26.w = 1.0;
            tmpvar_26.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_22;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_24;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_26));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
            gl_FragData[0] = col_1;
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
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform mediump vec4 unity_LightAtten[8];
          uniform highp vec4 unity_SpotDirection[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_7;
            mediump vec3 eyeNormal_8;
            highp vec3 eyePos_9;
            mediump vec4 color_10;
            color_10 = vec4(0.0, 0.0, 0.0, 1.1);
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = tmpvar_5;
            highp vec3 tmpvar_12;
            tmpvar_12 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_11).xyz;
            eyePos_9 = tmpvar_12;
            highp mat3 tmpvar_13;
            tmpvar_13[0] = tmpvar_2.xyz;
            tmpvar_13[1] = tmpvar_3.xyz;
            tmpvar_13[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_14;
            tmpvar_14 = normalize((tmpvar_13 * _glesNormal));
            eyeNormal_8 = tmpvar_14;
            lowp vec3 tmpvar_15;
            tmpvar_15 = glstate_lightmodel_ambient.xyz;
            lcolor_7 = tmpvar_15;
            for (highp int il_6 = 0; il_6 < 8; il_6++) {
              mediump float rho_16;
              mediump float att_17;
              highp vec3 dirToLight_18;
              dirToLight_18 = (unity_LightPosition[il_6].xyz - (eyePos_9 * unity_LightPosition[il_6].w));
              highp float tmpvar_19;
              tmpvar_19 = dot (dirToLight_18, dirToLight_18);
              att_17 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_19))));
              if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_19 > unity_LightAtten[il_6].w))) {
                att_17 = 0.0;
              };
              dirToLight_18 = (dirToLight_18 * inversesqrt(max (tmpvar_19, 1e-6)));
              highp float tmpvar_20;
              tmpvar_20 = max (dot (dirToLight_18, unity_SpotDirection[il_6].xyz), 0.0);
              rho_16 = tmpvar_20;
              att_17 = (att_17 * clamp ((
                (rho_16 - unity_LightAtten[il_6].x)
               * unity_LightAtten[il_6].y), 0.0, 1.0));
              att_17 = (att_17 * 0.5);
              mediump vec3 dirToLight_21;
              dirToLight_21 = dirToLight_18;
              lcolor_7 = (lcolor_7 + min ((
                (vec3(max (dot (eyeNormal_8, dirToLight_21), 0.0)) * unity_LightColor[il_6].xyz)
               * att_17), vec3(1.0, 1.0, 1.0)));
            };
            color_10.xyz = lcolor_7;
            color_10.w = 1.0;
            lowp vec4 tmpvar_22;
            mediump vec4 tmpvar_23;
            tmpvar_23 = clamp (color_10, 0.0, 1.0);
            tmpvar_22 = tmpvar_23;
            lowp float tmpvar_24;
            highp float tmpvar_25;
            tmpvar_25 = clamp (((
              sqrt(dot (tmpvar_12, tmpvar_12))
             * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
            tmpvar_24 = tmpvar_25;
            highp vec4 tmpvar_26;
            tmpvar_26.w = 1.0;
            tmpvar_26.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_22;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_24;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_26));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
            gl_FragData[0] = col_1;
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
          uniform mediump vec4 unity_LightColor[8];
          uniform highp vec4 unity_LightPosition[8];
          uniform mediump vec4 unity_LightAtten[8];
          uniform highp vec4 unity_SpotDirection[8];
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform lowp vec4 glstate_lightmodel_ambient;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixInvV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 _MainTex_ST;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            highp mat4 m_1;
            m_1 = (unity_WorldToObject * unity_MatrixInvV);
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            highp vec4 tmpvar_4;
            tmpvar_2.x = m_1[0].x;
            tmpvar_2.y = m_1[1].x;
            tmpvar_2.z = m_1[2].x;
            tmpvar_2.w = m_1[3].x;
            tmpvar_3.x = m_1[0].y;
            tmpvar_3.y = m_1[1].y;
            tmpvar_3.z = m_1[2].y;
            tmpvar_3.w = m_1[3].y;
            tmpvar_4.x = m_1[0].z;
            tmpvar_4.y = m_1[1].z;
            tmpvar_4.z = m_1[2].z;
            tmpvar_4.w = m_1[3].z;
            highp vec3 tmpvar_5;
            tmpvar_5 = _glesVertex.xyz;
            mediump vec3 lcolor_7;
            mediump vec3 eyeNormal_8;
            highp vec3 eyePos_9;
            mediump vec4 color_10;
            color_10 = vec4(0.0, 0.0, 0.0, 1.1);
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = tmpvar_5;
            highp vec3 tmpvar_12;
            tmpvar_12 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_11).xyz;
            eyePos_9 = tmpvar_12;
            highp mat3 tmpvar_13;
            tmpvar_13[0] = tmpvar_2.xyz;
            tmpvar_13[1] = tmpvar_3.xyz;
            tmpvar_13[2] = tmpvar_4.xyz;
            highp vec3 tmpvar_14;
            tmpvar_14 = normalize((tmpvar_13 * _glesNormal));
            eyeNormal_8 = tmpvar_14;
            lowp vec3 tmpvar_15;
            tmpvar_15 = glstate_lightmodel_ambient.xyz;
            lcolor_7 = tmpvar_15;
            for (highp int il_6 = 0; il_6 < 8; il_6++) {
              mediump float rho_16;
              mediump float att_17;
              highp vec3 dirToLight_18;
              dirToLight_18 = (unity_LightPosition[il_6].xyz - (eyePos_9 * unity_LightPosition[il_6].w));
              highp float tmpvar_19;
              tmpvar_19 = dot (dirToLight_18, dirToLight_18);
              att_17 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_19))));
              if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_19 > unity_LightAtten[il_6].w))) {
                att_17 = 0.0;
              };
              dirToLight_18 = (dirToLight_18 * inversesqrt(max (tmpvar_19, 1e-6)));
              highp float tmpvar_20;
              tmpvar_20 = max (dot (dirToLight_18, unity_SpotDirection[il_6].xyz), 0.0);
              rho_16 = tmpvar_20;
              att_17 = (att_17 * clamp ((
                (rho_16 - unity_LightAtten[il_6].x)
               * unity_LightAtten[il_6].y), 0.0, 1.0));
              att_17 = (att_17 * 0.5);
              mediump vec3 dirToLight_21;
              dirToLight_21 = dirToLight_18;
              lcolor_7 = (lcolor_7 + min ((
                (vec3(max (dot (eyeNormal_8, dirToLight_21), 0.0)) * unity_LightColor[il_6].xyz)
               * att_17), vec3(1.0, 1.0, 1.0)));
            };
            color_10.xyz = lcolor_7;
            color_10.w = 1.0;
            lowp vec4 tmpvar_22;
            mediump vec4 tmpvar_23;
            tmpvar_23 = clamp (color_10, 0.0, 1.0);
            tmpvar_22 = tmpvar_23;
            lowp float tmpvar_24;
            highp float tmpvar_25;
            tmpvar_25 = clamp (((
              sqrt(dot (tmpvar_12, tmpvar_12))
             * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
            tmpvar_24 = tmpvar_25;
            highp vec4 tmpvar_26;
            tmpvar_26.w = 1.0;
            tmpvar_26.xyz = tmpvar_5;
            xlv_COLOR0 = tmpvar_22;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD1 = tmpvar_24;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_26));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform lowp vec4 unity_FogColor;
          uniform sampler2D _MainTex;
          varying lowp vec4 xlv_COLOR0;
          varying highp vec2 xlv_TEXCOORD0;
          varying lowp float xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 col_1;
            col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
            col_1.xyz = (col_1 * 2.0).xyz;
            col_1.w = 1.0;
            col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
            gl_FragData[0] = col_1;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	mediump vec4 unity_LightAtten[8];
          uniform 	vec4 unity_SpotDirection[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out mediump float vs_TEXCOORD1;
          vec4 u_xlat0;
          int u_xlati0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          bool u_xlatb4;
          mediump vec3 u_xlat16_5;
          vec3 u_xlat6;
          vec3 u_xlat7;
          bool u_xlatb7;
          mediump vec3 u_xlat16_9;
          float u_xlat10;
          bool u_xlatb10;
          bool u_xlatb12;
          float u_xlat18;
          bool u_xlatb18;
          float u_xlat19;
          bool u_xlatb19;
          float u_xlat20;
          bool u_xlatb20;
          mediump float u_xlat16_21;
          mediump float u_xlat16_23;
          void main()
          {
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
          #else
              u_xlatb0 = unity_LightPosition[1].w!=0.0;
          #endif
              u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat6.xyz;
              u_xlat6.xyz = u_xlat6.xyz * in_POSITION0.yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat6.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat6.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat6.xyz + u_xlat1.xyz;
              u_xlat1.xyz = (-u_xlat6.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
              u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat19);
          #else
              u_xlatb2 = unity_LightAtten[1].w<u_xlat19;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb2;
              u_xlat2.x = unity_LightAtten[1].z * u_xlat19 + 1.0;
              u_xlat19 = max(u_xlat19, 9.99999997e-07);
              u_xlat19 = inversesqrt(u_xlat19);
              u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
              u_xlat19 = float(1.0) / u_xlat2.x;
              u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat19;
              u_xlat0.x = dot(u_xlat1.xyz, unity_SpotDirection[1].xyz);
              u_xlat0.x = max(u_xlat0.x, 0.0);
              u_xlat16_9.x = u_xlat0.x + (-unity_LightAtten[1].x);
              u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[1].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
          #else
              u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
          #endif
              u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x;
              u_xlat16_3.x = u_xlat16_3.x * 0.5;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
              u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
              u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
              u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat0.x = inversesqrt(u_xlat0.x);
              u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
              u_xlat16_9.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
              u_xlat16_9.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz;
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
              u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat1.xyz = (-u_xlat6.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
              u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[0].w<u_xlat0.x);
          #else
              u_xlatb19 = unity_LightAtten[0].w<u_xlat0.x;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb20 = !!(unity_LightPosition[0].w!=0.0);
          #else
              u_xlatb20 = unity_LightPosition[0].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb20;
              u_xlat20 = unity_LightAtten[0].z * u_xlat0.x + 1.0;
              u_xlat0.x = max(u_xlat0.x, 9.99999997e-07);
              u_xlat0.x = inversesqrt(u_xlat0.x);
              u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
              u_xlat0.x = float(1.0) / u_xlat20;
              u_xlat16_21 = (u_xlatb19) ? 0.0 : u_xlat0.x;
              u_xlat0.x = dot(u_xlat1.xyz, unity_SpotDirection[0].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[0].xyz;
              u_xlat0.x = max(u_xlat0.x, 0.0);
              u_xlat16_23 = u_xlat0.x + (-unity_LightAtten[0].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[0].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_5.xyz + glstate_lightmodel_ambient.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = 0<unity_VertexLightParams.x;
          #endif
              u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : glstate_lightmodel_ambient.xyz;
              u_xlati0 = u_xlatb0 ? 1 : int(0);
              u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb1 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlati0 = (u_xlatb1) ? 2 : u_xlati0;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[2].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[2].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[2].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[2].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[2].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[2].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[2].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[2].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[3].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[3].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[3].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[3].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[3].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[3].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[3].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[3].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[3].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 3 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[4].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[4].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[4].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[4].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[4].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[4].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[4].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[4].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[4].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 4 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[5].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[5].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[5].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[5].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[5].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[5].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[5].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[5].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[5].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 5 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[6].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[6].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[6].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[6].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[6].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[6].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[6].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[6].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[6].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 6 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
              u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
              u_xlat6.x = sqrt(u_xlat6.x);
              u_xlat6.x = u_xlat6.x * unity_FogParams.z + unity_FogParams.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
          #else
              u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
          #endif
              vs_TEXCOORD1 = u_xlat6.x;
              u_xlat6.x = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb12 = !!(unity_LightAtten[7].w<u_xlat6.x);
          #else
              u_xlatb12 = unity_LightAtten[7].w<u_xlat6.x;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb18 = !!(unity_LightPosition[7].w!=0.0);
          #else
              u_xlatb18 = unity_LightPosition[7].w!=0.0;
          #endif
              u_xlatb12 = u_xlatb12 && u_xlatb18;
              u_xlat18 = unity_LightAtten[7].z * u_xlat6.x + 1.0;
              u_xlat6.x = max(u_xlat6.x, 9.99999997e-07);
              u_xlat6.x = inversesqrt(u_xlat6.x);
              u_xlat7.xyz = u_xlat6.xxx * u_xlat7.xyz;
              u_xlat6.x = float(1.0) / u_xlat18;
              u_xlat16_21 = (u_xlatb12) ? 0.0 : u_xlat6.x;
              u_xlat6.x = dot(u_xlat7.xyz, unity_SpotDirection[7].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[7].xyz;
              u_xlat6.x = max(u_xlat6.x, 0.0);
              u_xlat16_23 = u_xlat6.x + (-unity_LightAtten[7].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[7].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 7 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb1;
              vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_FogColor;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in mediump float vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
              SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
              SV_Target0.w = 1.0;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	mediump vec4 unity_LightAtten[8];
          uniform 	vec4 unity_SpotDirection[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out mediump float vs_TEXCOORD1;
          vec4 u_xlat0;
          int u_xlati0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          bool u_xlatb4;
          mediump vec3 u_xlat16_5;
          vec3 u_xlat6;
          vec3 u_xlat7;
          bool u_xlatb7;
          mediump vec3 u_xlat16_9;
          float u_xlat10;
          bool u_xlatb10;
          bool u_xlatb12;
          float u_xlat18;
          bool u_xlatb18;
          float u_xlat19;
          bool u_xlatb19;
          float u_xlat20;
          bool u_xlatb20;
          mediump float u_xlat16_21;
          mediump float u_xlat16_23;
          void main()
          {
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
          #else
              u_xlatb0 = unity_LightPosition[1].w!=0.0;
          #endif
              u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat6.xyz;
              u_xlat6.xyz = u_xlat6.xyz * in_POSITION0.yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat6.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat6.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat6.xyz + u_xlat1.xyz;
              u_xlat1.xyz = (-u_xlat6.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
              u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat19);
          #else
              u_xlatb2 = unity_LightAtten[1].w<u_xlat19;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb2;
              u_xlat2.x = unity_LightAtten[1].z * u_xlat19 + 1.0;
              u_xlat19 = max(u_xlat19, 9.99999997e-07);
              u_xlat19 = inversesqrt(u_xlat19);
              u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
              u_xlat19 = float(1.0) / u_xlat2.x;
              u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat19;
              u_xlat0.x = dot(u_xlat1.xyz, unity_SpotDirection[1].xyz);
              u_xlat0.x = max(u_xlat0.x, 0.0);
              u_xlat16_9.x = u_xlat0.x + (-unity_LightAtten[1].x);
              u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[1].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
          #else
              u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
          #endif
              u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x;
              u_xlat16_3.x = u_xlat16_3.x * 0.5;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
              u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
              u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
              u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat0.x = inversesqrt(u_xlat0.x);
              u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
              u_xlat16_9.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
              u_xlat16_9.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz;
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
              u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat1.xyz = (-u_xlat6.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
              u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[0].w<u_xlat0.x);
          #else
              u_xlatb19 = unity_LightAtten[0].w<u_xlat0.x;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb20 = !!(unity_LightPosition[0].w!=0.0);
          #else
              u_xlatb20 = unity_LightPosition[0].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb20;
              u_xlat20 = unity_LightAtten[0].z * u_xlat0.x + 1.0;
              u_xlat0.x = max(u_xlat0.x, 9.99999997e-07);
              u_xlat0.x = inversesqrt(u_xlat0.x);
              u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
              u_xlat0.x = float(1.0) / u_xlat20;
              u_xlat16_21 = (u_xlatb19) ? 0.0 : u_xlat0.x;
              u_xlat0.x = dot(u_xlat1.xyz, unity_SpotDirection[0].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[0].xyz;
              u_xlat0.x = max(u_xlat0.x, 0.0);
              u_xlat16_23 = u_xlat0.x + (-unity_LightAtten[0].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[0].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_5.xyz + glstate_lightmodel_ambient.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = 0<unity_VertexLightParams.x;
          #endif
              u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : glstate_lightmodel_ambient.xyz;
              u_xlati0 = u_xlatb0 ? 1 : int(0);
              u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb1 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlati0 = (u_xlatb1) ? 2 : u_xlati0;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[2].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[2].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[2].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[2].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[2].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[2].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[2].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[2].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[3].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[3].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[3].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[3].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[3].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[3].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[3].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[3].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[3].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 3 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[4].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[4].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[4].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[4].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[4].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[4].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[4].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[4].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[4].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 4 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[5].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[5].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[5].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[5].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[5].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[5].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[5].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[5].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[5].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 5 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[6].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[6].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[6].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[6].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[6].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[6].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[6].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[6].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[6].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 6 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
              u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
              u_xlat6.x = sqrt(u_xlat6.x);
              u_xlat6.x = u_xlat6.x * unity_FogParams.z + unity_FogParams.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
          #else
              u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
          #endif
              vs_TEXCOORD1 = u_xlat6.x;
              u_xlat6.x = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb12 = !!(unity_LightAtten[7].w<u_xlat6.x);
          #else
              u_xlatb12 = unity_LightAtten[7].w<u_xlat6.x;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb18 = !!(unity_LightPosition[7].w!=0.0);
          #else
              u_xlatb18 = unity_LightPosition[7].w!=0.0;
          #endif
              u_xlatb12 = u_xlatb12 && u_xlatb18;
              u_xlat18 = unity_LightAtten[7].z * u_xlat6.x + 1.0;
              u_xlat6.x = max(u_xlat6.x, 9.99999997e-07);
              u_xlat6.x = inversesqrt(u_xlat6.x);
              u_xlat7.xyz = u_xlat6.xxx * u_xlat7.xyz;
              u_xlat6.x = float(1.0) / u_xlat18;
              u_xlat16_21 = (u_xlatb12) ? 0.0 : u_xlat6.x;
              u_xlat6.x = dot(u_xlat7.xyz, unity_SpotDirection[7].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[7].xyz;
              u_xlat6.x = max(u_xlat6.x, 0.0);
              u_xlat16_23 = u_xlat6.x + (-unity_LightAtten[7].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[7].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 7 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb1;
              vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_FogColor;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in mediump float vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
              SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
              SV_Target0.w = 1.0;
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
          
          uniform 	mediump vec4 unity_LightColor[8];
          uniform 	vec4 unity_LightPosition[8];
          uniform 	mediump vec4 unity_LightAtten[8];
          uniform 	vec4 unity_SpotDirection[8];
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	mediump vec4 glstate_lightmodel_ambient;
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	ivec4 unity_VertexLightParams;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_NORMAL0;
          in highp vec3 in_TEXCOORD0;
          out mediump vec4 vs_COLOR0;
          out highp vec2 vs_TEXCOORD0;
          out mediump float vs_TEXCOORD1;
          vec4 u_xlat0;
          int u_xlati0;
          bool u_xlatb0;
          vec4 u_xlat1;
          bool u_xlatb1;
          vec3 u_xlat2;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          bool u_xlatb4;
          mediump vec3 u_xlat16_5;
          vec3 u_xlat6;
          vec3 u_xlat7;
          bool u_xlatb7;
          mediump vec3 u_xlat16_9;
          float u_xlat10;
          bool u_xlatb10;
          bool u_xlatb12;
          float u_xlat18;
          bool u_xlatb18;
          float u_xlat19;
          bool u_xlatb19;
          float u_xlat20;
          bool u_xlatb20;
          mediump float u_xlat16_21;
          mediump float u_xlat16_23;
          void main()
          {
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
          #else
              u_xlatb0 = unity_LightPosition[1].w!=0.0;
          #endif
              u_xlat6.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat6.xyz;
              u_xlat6.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat6.xyz;
              u_xlat6.xyz = u_xlat6.xyz * in_POSITION0.yyy;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat6.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat6.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
              u_xlat6.xyz = u_xlat6.xyz + u_xlat1.xyz;
              u_xlat1.xyz = (-u_xlat6.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
              u_xlat19 = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat19);
          #else
              u_xlatb2 = unity_LightAtten[1].w<u_xlat19;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb2;
              u_xlat2.x = unity_LightAtten[1].z * u_xlat19 + 1.0;
              u_xlat19 = max(u_xlat19, 9.99999997e-07);
              u_xlat19 = inversesqrt(u_xlat19);
              u_xlat1.xyz = vec3(u_xlat19) * u_xlat1.xyz;
              u_xlat19 = float(1.0) / u_xlat2.x;
              u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat19;
              u_xlat0.x = dot(u_xlat1.xyz, unity_SpotDirection[1].xyz);
              u_xlat0.x = max(u_xlat0.x, 0.0);
              u_xlat16_9.x = u_xlat0.x + (-unity_LightAtten[1].x);
              u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[1].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
          #else
              u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
          #endif
              u_xlat16_3.x = u_xlat16_9.x * u_xlat16_3.x;
              u_xlat16_3.x = u_xlat16_3.x * 0.5;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat2.xyz;
              u_xlat2.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat2.xyz;
              u_xlat2.x = dot(u_xlat2.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat4.xyz;
              u_xlat2.y = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat4.xyz;
              u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat4.xyz;
              u_xlat2.z = dot(u_xlat4.xyz, in_NORMAL0.xyz);
              u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat0.x = inversesqrt(u_xlat0.x);
              u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
              u_xlat16_9.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
              u_xlat16_9.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz;
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_9.xyz;
              u_xlat16_3.xyz = min(u_xlat16_3.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat1.xyz = (-u_xlat6.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
              u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb19 = !!(unity_LightAtten[0].w<u_xlat0.x);
          #else
              u_xlatb19 = unity_LightAtten[0].w<u_xlat0.x;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb20 = !!(unity_LightPosition[0].w!=0.0);
          #else
              u_xlatb20 = unity_LightPosition[0].w!=0.0;
          #endif
              u_xlatb19 = u_xlatb19 && u_xlatb20;
              u_xlat20 = unity_LightAtten[0].z * u_xlat0.x + 1.0;
              u_xlat0.x = max(u_xlat0.x, 9.99999997e-07);
              u_xlat0.x = inversesqrt(u_xlat0.x);
              u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
              u_xlat0.x = float(1.0) / u_xlat20;
              u_xlat16_21 = (u_xlatb19) ? 0.0 : u_xlat0.x;
              u_xlat0.x = dot(u_xlat1.xyz, unity_SpotDirection[0].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat1.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[0].xyz;
              u_xlat0.x = max(u_xlat0.x, 0.0);
              u_xlat16_23 = u_xlat0.x + (-unity_LightAtten[0].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[0].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_5.xyz + glstate_lightmodel_ambient.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = 0<unity_VertexLightParams.x;
          #endif
              u_xlat16_5.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : glstate_lightmodel_ambient.xyz;
              u_xlati0 = u_xlatb0 ? 1 : int(0);
              u_xlat16_3.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb1 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlati0 = (u_xlatb1) ? 2 : u_xlati0;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_3.xyz : u_xlat16_5.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[2].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[2].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[2].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[2].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[2].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[2].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[2].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[2].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[2].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[3].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[3].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[3].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[3].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[3].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[3].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[3].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[3].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[3].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 3 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[4].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[4].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[4].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[4].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[4].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[4].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[4].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[4].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[4].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 4 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[5].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[5].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[5].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[5].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[5].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[5].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[5].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[5].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[5].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 5 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
              u_xlat20 = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb4 = !!(unity_LightAtten[6].w<u_xlat20);
          #else
              u_xlatb4 = unity_LightAtten[6].w<u_xlat20;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb10 = !!(unity_LightPosition[6].w!=0.0);
          #else
              u_xlatb10 = unity_LightPosition[6].w!=0.0;
          #endif
              u_xlatb4 = u_xlatb4 && u_xlatb10;
              u_xlat10 = unity_LightAtten[6].z * u_xlat20 + 1.0;
              u_xlat20 = max(u_xlat20, 9.99999997e-07);
              u_xlat20 = inversesqrt(u_xlat20);
              u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat20);
              u_xlat20 = float(1.0) / u_xlat10;
              u_xlat16_21 = (u_xlatb4) ? 0.0 : u_xlat20;
              u_xlat20 = dot(u_xlat7.xyz, unity_SpotDirection[6].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[6].xyz;
              u_xlat7.x = max(u_xlat20, 0.0);
              u_xlat16_23 = u_xlat7.x + (-unity_LightAtten[6].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[6].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 6 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb7 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb7 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb1 = u_xlatb7 && u_xlatb1;
              u_xlat16_3.xyz = (bool(u_xlatb1)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
              u_xlat7.xyz = (-u_xlat6.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
              u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
              u_xlat6.x = sqrt(u_xlat6.x);
              u_xlat6.x = u_xlat6.x * unity_FogParams.z + unity_FogParams.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat6.x = min(max(u_xlat6.x, 0.0), 1.0);
          #else
              u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
          #endif
              vs_TEXCOORD1 = u_xlat6.x;
              u_xlat6.x = dot(u_xlat7.xyz, u_xlat7.xyz);
          #ifdef UNITY_ADRENO_ES3
              u_xlatb12 = !!(unity_LightAtten[7].w<u_xlat6.x);
          #else
              u_xlatb12 = unity_LightAtten[7].w<u_xlat6.x;
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb18 = !!(unity_LightPosition[7].w!=0.0);
          #else
              u_xlatb18 = unity_LightPosition[7].w!=0.0;
          #endif
              u_xlatb12 = u_xlatb12 && u_xlatb18;
              u_xlat18 = unity_LightAtten[7].z * u_xlat6.x + 1.0;
              u_xlat6.x = max(u_xlat6.x, 9.99999997e-07);
              u_xlat6.x = inversesqrt(u_xlat6.x);
              u_xlat7.xyz = u_xlat6.xxx * u_xlat7.xyz;
              u_xlat6.x = float(1.0) / u_xlat18;
              u_xlat16_21 = (u_xlatb12) ? 0.0 : u_xlat6.x;
              u_xlat6.x = dot(u_xlat7.xyz, unity_SpotDirection[7].xyz);
              u_xlat16_5.x = dot(u_xlat2.xyz, u_xlat7.xyz);
              u_xlat16_5.x = max(u_xlat16_5.x, 0.0);
              u_xlat16_5.xyz = u_xlat16_5.xxx * unity_LightColor[7].xyz;
              u_xlat6.x = max(u_xlat6.x, 0.0);
              u_xlat16_23 = u_xlat6.x + (-unity_LightAtten[7].x);
              u_xlat16_23 = u_xlat16_23 * unity_LightAtten[7].y;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_23 = min(max(u_xlat16_23, 0.0), 1.0);
          #else
              u_xlat16_23 = clamp(u_xlat16_23, 0.0, 1.0);
          #endif
              u_xlat16_21 = u_xlat16_21 * u_xlat16_23;
              u_xlat16_21 = u_xlat16_21 * 0.5;
              u_xlat16_5.xyz = vec3(u_xlat16_21) * u_xlat16_5.xyz;
              u_xlat16_5.xyz = min(u_xlat16_5.xyz, vec3(1.0, 1.0, 1.0));
              u_xlat16_5.xyz = u_xlat16_3.xyz + u_xlat16_5.xyz;
              u_xlati0 = (u_xlatb1) ? 7 : u_xlati0;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlati0<unity_VertexLightParams.x);
          #else
              u_xlatb0 = u_xlati0<unity_VertexLightParams.x;
          #endif
              u_xlatb0 = u_xlatb0 && u_xlatb1;
              vs_COLOR0.xyz = (bool(u_xlatb0)) ? u_xlat16_5.xyz : u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
          #else
              vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
          #endif
              vs_COLOR0.w = 1.0;
              vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_FogColor;
          uniform lowp sampler2D _MainTex;
          in mediump vec4 vs_COLOR0;
          in highp vec2 vs_TEXCOORD0;
          in mediump float vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
              u_xlat16_1.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + (-unity_FogColor.xyz);
              SV_Target0.xyz = vec3(vs_TEXCOORD1) * u_xlat16_1.xyz + unity_FogColor.xyz;
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
      }
      
    } // end phase
    Pass // ind: 2, name: 
    {
      Tags
      { 
        "LIGHTMODE" = "VertexLM"
        "RenderType" = "Opaque"
      }
      LOD 80
      GpuProgramID 1307
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
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_LightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec2 xlv_TEXCOORD1;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
            xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump sampler2D unity_Lightmap;
          uniform mediump vec4 unity_Lightmap_HDR;
          uniform sampler2D _MainTex;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec2 xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 tex_1;
            lowp vec4 col_2;
            mediump vec4 tmpvar_3;
            tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
            tex_1 = tmpvar_3;
            mediump vec3 tmpvar_4;
            tmpvar_4 = (unity_Lightmap_HDR.x * tex_1.xyz);
            lowp vec4 tmpvar_5;
            tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1);
            tex_1 = tmpvar_5;
            col_2.xyz = (tmpvar_5.xyz * tmpvar_4);
            col_2.w = 1.0;
            gl_FragData[0] = col_2;
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
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_LightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec2 xlv_TEXCOORD1;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
            xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump sampler2D unity_Lightmap;
          uniform mediump vec4 unity_Lightmap_HDR;
          uniform sampler2D _MainTex;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec2 xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 tex_1;
            lowp vec4 col_2;
            mediump vec4 tmpvar_3;
            tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
            tex_1 = tmpvar_3;
            mediump vec3 tmpvar_4;
            tmpvar_4 = (unity_Lightmap_HDR.x * tex_1.xyz);
            lowp vec4 tmpvar_5;
            tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1);
            tex_1 = tmpvar_5;
            col_2.xyz = (tmpvar_5.xyz * tmpvar_4);
            col_2.w = 1.0;
            gl_FragData[0] = col_2;
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
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_LightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec2 xlv_TEXCOORD1;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
            xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform mediump sampler2D unity_Lightmap;
          uniform mediump vec4 unity_Lightmap_HDR;
          uniform sampler2D _MainTex;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec2 xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 tex_1;
            lowp vec4 col_2;
            mediump vec4 tmpvar_3;
            tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
            tex_1 = tmpvar_3;
            mediump vec3 tmpvar_4;
            tmpvar_4 = (unity_Lightmap_HDR.x * tex_1.xyz);
            lowp vec4 tmpvar_5;
            tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1);
            tex_1 = tmpvar_5;
            col_2.xyz = (tmpvar_5.xyz * tmpvar_4);
            col_2.w = 1.0;
            gl_FragData[0] = col_2;
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
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_TEXCOORD1;
          in highp vec3 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec2 vs_TEXCOORD1;
          vec4 u_xlat0;
          vec4 u_xlat1;
          void main()
          {
              vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
              vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_Lightmap_HDR;
          uniform lowp sampler2D _MainTex;
          uniform mediump sampler2D unity_Lightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp vec2 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
              SV_Target0.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
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
          uniform 	vec4 unity_LightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_TEXCOORD1;
          in highp vec3 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec2 vs_TEXCOORD1;
          vec4 u_xlat0;
          vec4 u_xlat1;
          void main()
          {
              vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
              vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_Lightmap_HDR;
          uniform lowp sampler2D _MainTex;
          uniform mediump sampler2D unity_Lightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp vec2 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
              SV_Target0.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
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
          uniform 	vec4 unity_LightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_TEXCOORD1;
          in highp vec3 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec2 vs_TEXCOORD1;
          vec4 u_xlat0;
          vec4 u_xlat1;
          void main()
          {
              vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
              vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_Lightmap_HDR;
          uniform lowp sampler2D _MainTex;
          uniform mediump sampler2D unity_Lightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp vec2 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
              SV_Target0.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
              SV_Target0.w = 1.0;
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
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord1;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_LightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec2 xlv_TEXCOORD1;
          varying lowp float xlv_TEXCOORD2;
          void main ()
          {
            highp vec3 tmpvar_1;
            tmpvar_1 = _glesVertex.xyz;
            highp vec3 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = tmpvar_1;
            tmpvar_2 = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_3)).xyz;
            lowp float tmpvar_4;
            highp float tmpvar_5;
            tmpvar_5 = clamp (((
              sqrt(dot (tmpvar_2, tmpvar_2))
             * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
            tmpvar_4 = tmpvar_5;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
            xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD2 = tmpvar_4;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform lowp vec4 unity_FogColor;
          uniform mediump sampler2D unity_Lightmap;
          uniform mediump vec4 unity_Lightmap_HDR;
          uniform sampler2D _MainTex;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec2 xlv_TEXCOORD1;
          varying lowp float xlv_TEXCOORD2;
          void main ()
          {
            lowp vec4 tex_1;
            lowp vec4 col_2;
            mediump vec4 tmpvar_3;
            tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
            tex_1 = tmpvar_3;
            mediump vec3 tmpvar_4;
            tmpvar_4 = (unity_Lightmap_HDR.x * tex_1.xyz);
            lowp vec4 tmpvar_5;
            tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1);
            tex_1 = tmpvar_5;
            col_2.xyz = (tmpvar_5.xyz * tmpvar_4);
            col_2.w = 1.0;
            col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD2));
            gl_FragData[0] = col_2;
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
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord1;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_LightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec2 xlv_TEXCOORD1;
          varying lowp float xlv_TEXCOORD2;
          void main ()
          {
            highp vec3 tmpvar_1;
            tmpvar_1 = _glesVertex.xyz;
            highp vec3 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = tmpvar_1;
            tmpvar_2 = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_3)).xyz;
            lowp float tmpvar_4;
            highp float tmpvar_5;
            tmpvar_5 = clamp (((
              sqrt(dot (tmpvar_2, tmpvar_2))
             * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
            tmpvar_4 = tmpvar_5;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
            xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD2 = tmpvar_4;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform lowp vec4 unity_FogColor;
          uniform mediump sampler2D unity_Lightmap;
          uniform mediump vec4 unity_Lightmap_HDR;
          uniform sampler2D _MainTex;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec2 xlv_TEXCOORD1;
          varying lowp float xlv_TEXCOORD2;
          void main ()
          {
            lowp vec4 tex_1;
            lowp vec4 col_2;
            mediump vec4 tmpvar_3;
            tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
            tex_1 = tmpvar_3;
            mediump vec3 tmpvar_4;
            tmpvar_4 = (unity_Lightmap_HDR.x * tex_1.xyz);
            lowp vec4 tmpvar_5;
            tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1);
            tex_1 = tmpvar_5;
            col_2.xyz = (tmpvar_5.xyz * tmpvar_4);
            col_2.w = 1.0;
            col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD2));
            gl_FragData[0] = col_2;
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
          attribute vec4 _glesMultiTexCoord0;
          attribute vec4 _glesMultiTexCoord1;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixVP;
          uniform highp vec4 unity_FogParams;
          uniform highp vec4 unity_LightmapST;
          uniform highp vec4 _MainTex_ST;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec2 xlv_TEXCOORD1;
          varying lowp float xlv_TEXCOORD2;
          void main ()
          {
            highp vec3 tmpvar_1;
            tmpvar_1 = _glesVertex.xyz;
            highp vec3 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = tmpvar_1;
            tmpvar_2 = (unity_MatrixV * (unity_ObjectToWorld * tmpvar_3)).xyz;
            lowp float tmpvar_4;
            highp float tmpvar_5;
            tmpvar_5 = clamp (((
              sqrt(dot (tmpvar_2, tmpvar_2))
             * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
            tmpvar_4 = tmpvar_5;
            highp vec4 tmpvar_6;
            tmpvar_6.w = 1.0;
            tmpvar_6.xyz = tmpvar_1;
            xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
            xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
            xlv_TEXCOORD2 = tmpvar_4;
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform lowp vec4 unity_FogColor;
          uniform mediump sampler2D unity_Lightmap;
          uniform mediump vec4 unity_Lightmap_HDR;
          uniform sampler2D _MainTex;
          varying highp vec2 xlv_TEXCOORD0;
          varying highp vec2 xlv_TEXCOORD1;
          varying lowp float xlv_TEXCOORD2;
          void main ()
          {
            lowp vec4 tex_1;
            lowp vec4 col_2;
            mediump vec4 tmpvar_3;
            tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
            tex_1 = tmpvar_3;
            mediump vec3 tmpvar_4;
            tmpvar_4 = (unity_Lightmap_HDR.x * tex_1.xyz);
            lowp vec4 tmpvar_5;
            tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1);
            tex_1 = tmpvar_5;
            col_2.xyz = (tmpvar_5.xyz * tmpvar_4);
            col_2.w = 1.0;
            col_2.xyz = mix (unity_FogColor.xyz, col_2.xyz, vec3(xlv_TEXCOORD2));
            gl_FragData[0] = col_2;
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
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_LightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_TEXCOORD1;
          in highp vec3 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec2 vs_TEXCOORD1;
          out mediump float vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          void main()
          {
              vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
              vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
              u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat1.x = sqrt(u_xlat1.x);
              u_xlat1.x = u_xlat1.x * unity_FogParams.z + unity_FogParams.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
          #else
              u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
          #endif
              vs_TEXCOORD2 = u_xlat1.x;
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_Lightmap_HDR;
          uniform lowp sampler2D _MainTex;
          uniform mediump sampler2D unity_Lightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp vec2 vs_TEXCOORD1;
          in mediump float vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
              SV_Target0.xyz = vec3(vs_TEXCOORD2) * u_xlat16_1.xyz + unity_FogColor.xyz;
              SV_Target0.w = 1.0;
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
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_LightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_TEXCOORD1;
          in highp vec3 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec2 vs_TEXCOORD1;
          out mediump float vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          void main()
          {
              vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
              vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
              u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat1.x = sqrt(u_xlat1.x);
              u_xlat1.x = u_xlat1.x * unity_FogParams.z + unity_FogParams.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
          #else
              u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
          #endif
              vs_TEXCOORD2 = u_xlat1.x;
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_Lightmap_HDR;
          uniform lowp sampler2D _MainTex;
          uniform mediump sampler2D unity_Lightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp vec2 vs_TEXCOORD1;
          in mediump float vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
              SV_Target0.xyz = vec3(vs_TEXCOORD2) * u_xlat16_1.xyz + unity_FogColor.xyz;
              SV_Target0.w = 1.0;
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
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	vec4 unity_FogParams;
          uniform 	vec4 unity_LightmapST;
          uniform 	vec4 _MainTex_ST;
          in highp vec3 in_POSITION0;
          in highp vec3 in_TEXCOORD1;
          in highp vec3 in_TEXCOORD0;
          out highp vec2 vs_TEXCOORD0;
          out highp vec2 vs_TEXCOORD1;
          out mediump float vs_TEXCOORD2;
          vec4 u_xlat0;
          vec4 u_xlat1;
          void main()
          {
              vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
              vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
              u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
              u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
              u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat1.xyz;
              u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat1.x = sqrt(u_xlat1.x);
              u_xlat1.x = u_xlat1.x * unity_FogParams.z + unity_FogParams.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
          #else
              u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
          #endif
              vs_TEXCOORD2 = u_xlat1.x;
              u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
              gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	mediump vec4 unity_FogColor;
          uniform 	mediump vec4 unity_Lightmap_HDR;
          uniform lowp sampler2D _MainTex;
          uniform mediump sampler2D unity_Lightmap;
          in highp vec2 vs_TEXCOORD0;
          in highp vec2 vs_TEXCOORD1;
          in mediump float vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          lowp vec3 u_xlat10_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
              u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
              u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD1.xy).xyz;
              u_xlat16_1.xyz = u_xlat10_0.xyz * u_xlat16_1.xyz + (-unity_FogColor.xyz);
              SV_Target0.xyz = vec3(vs_TEXCOORD2) * u_xlat16_1.xyz + unity_FogColor.xyz;
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
      }
      
    } // end phase
    Pass // ind: 3, name: ShadowCaster
    {
      Name "ShadowCaster"
      Tags
      { 
        "LIGHTMODE" = "SHADOWCASTER"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      LOD 80
      Cull Off
      GpuProgramID 77718
      // m_ProgramMask = 6
      !!! *******************************************************************************************
      !!! Allow restore shader as UnityLab format - only available for DevX GameRecovery license type
      !!! *******************************************************************************************
      Program "vp"
      {
        SubProgram "gles hw_tier00"
        {
           Keywords { "SHADOWS_DEPTH" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp vec4 unity_LightShadowBias;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 wPos_2;
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            wPos_2 = tmpvar_3;
            if ((unity_LightShadowBias.z != 0.0)) {
              highp mat3 tmpvar_4;
              tmpvar_4[0] = unity_WorldToObject[0].xyz;
              tmpvar_4[1] = unity_WorldToObject[1].xyz;
              tmpvar_4[2] = unity_WorldToObject[2].xyz;
              highp vec3 tmpvar_5;
              tmpvar_5 = normalize((_glesNormal * tmpvar_4));
              highp float tmpvar_6;
              tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
                (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
              )));
              wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
                sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
              )));
            };
            tmpvar_1 = (unity_MatrixVP * wPos_2);
            highp vec4 clipPos_7;
            clipPos_7.xyw = tmpvar_1.xyw;
            clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
            clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
            gl_Position = clipPos_7;
          }
          
          
          #endif
          #ifdef FRAGMENT
          void main ()
          {
            gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "SHADOWS_DEPTH" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp vec4 unity_LightShadowBias;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 wPos_2;
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            wPos_2 = tmpvar_3;
            if ((unity_LightShadowBias.z != 0.0)) {
              highp mat3 tmpvar_4;
              tmpvar_4[0] = unity_WorldToObject[0].xyz;
              tmpvar_4[1] = unity_WorldToObject[1].xyz;
              tmpvar_4[2] = unity_WorldToObject[2].xyz;
              highp vec3 tmpvar_5;
              tmpvar_5 = normalize((_glesNormal * tmpvar_4));
              highp float tmpvar_6;
              tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
                (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
              )));
              wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
                sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
              )));
            };
            tmpvar_1 = (unity_MatrixVP * wPos_2);
            highp vec4 clipPos_7;
            clipPos_7.xyw = tmpvar_1.xyw;
            clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
            clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
            gl_Position = clipPos_7;
          }
          
          
          #endif
          #ifdef FRAGMENT
          void main ()
          {
            gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "SHADOWS_DEPTH" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          attribute vec3 _glesNormal;
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp vec4 unity_LightShadowBias;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_WorldToObject;
          uniform highp mat4 unity_MatrixVP;
          void main ()
          {
            highp vec4 tmpvar_1;
            highp vec4 wPos_2;
            highp vec4 tmpvar_3;
            tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
            wPos_2 = tmpvar_3;
            if ((unity_LightShadowBias.z != 0.0)) {
              highp mat3 tmpvar_4;
              tmpvar_4[0] = unity_WorldToObject[0].xyz;
              tmpvar_4[1] = unity_WorldToObject[1].xyz;
              tmpvar_4[2] = unity_WorldToObject[2].xyz;
              highp vec3 tmpvar_5;
              tmpvar_5 = normalize((_glesNormal * tmpvar_4));
              highp float tmpvar_6;
              tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
                (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
              )));
              wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
                sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
              )));
            };
            tmpvar_1 = (unity_MatrixVP * wPos_2);
            highp vec4 clipPos_7;
            clipPos_7.xyw = tmpvar_1.xyw;
            clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
            clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
            gl_Position = clipPos_7;
          }
          
          
          #endif
          #ifdef FRAGMENT
          void main ()
          {
            gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "SHADOWS_DEPTH" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 unity_LightShadowBias;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat6;
          float u_xlat9;
          bool u_xlatb9;
          void main()
          {
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
              u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
              u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
              u_xlat9 = sqrt(u_xlat9);
              u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
              u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
          #else
              u_xlatb9 = unity_LightShadowBias.z!=0.0;
          #endif
              u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
              u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
          #else
              u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
          #endif
              u_xlat6 = u_xlat0.z + u_xlat1.x;
              u_xlat1.x = max((-u_xlat0.w), u_xlat6);
              gl_Position.xyw = u_xlat0.xyw;
              u_xlat0.x = (-u_xlat6) + u_xlat1.x;
              gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          layout(location = 0) out highp vec4 SV_Target0;
          void main()
          {
              SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "SHADOWS_DEPTH" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 unity_LightShadowBias;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat6;
          float u_xlat9;
          bool u_xlatb9;
          void main()
          {
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
              u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
              u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
              u_xlat9 = sqrt(u_xlat9);
              u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
              u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
          #else
              u_xlatb9 = unity_LightShadowBias.z!=0.0;
          #endif
              u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
              u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
          #else
              u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
          #endif
              u_xlat6 = u_xlat0.z + u_xlat1.x;
              u_xlat1.x = max((-u_xlat0.w), u_xlat6);
              gl_Position.xyw = u_xlat0.xyw;
              u_xlat0.x = (-u_xlat6) + u_xlat1.x;
              gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          layout(location = 0) out highp vec4 SV_Target0;
          void main()
          {
              SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "SHADOWS_DEPTH" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 unity_LightShadowBias;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat6;
          float u_xlat9;
          bool u_xlatb9;
          void main()
          {
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
              u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
              u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
              u_xlat9 = sqrt(u_xlat9);
              u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
              u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
          #else
              u_xlatb9 = unity_LightShadowBias.z!=0.0;
          #endif
              u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
              u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
          #ifdef UNITY_ADRENO_ES3
              u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
          #else
              u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
          #endif
              u_xlat6 = u_xlat0.z + u_xlat1.x;
              u_xlat1.x = max((-u_xlat0.w), u_xlat6);
              gl_Position.xyw = u_xlat0.xyw;
              u_xlat0.x = (-u_xlat6) + u_xlat1.x;
              gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          layout(location = 0) out highp vec4 SV_Target0;
          void main()
          {
              SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "SHADOWS_CUBE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          uniform highp vec4 _LightPositionRange;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          varying highp vec3 xlv_TEXCOORD0;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _LightPositionRange;
          uniform highp vec4 unity_LightShadowBias;
          varying highp vec3 xlv_TEXCOORD0;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+7) * min (
              ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
            , 0.999)));
            highp vec4 tmpvar_2;
            tmpvar_2 = (tmpvar_1 - (tmpvar_1.yzww * 0.003921569));
            gl_FragData[0] = tmpvar_2;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "SHADOWS_CUBE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          uniform highp vec4 _LightPositionRange;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          varying highp vec3 xlv_TEXCOORD0;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _LightPositionRange;
          uniform highp vec4 unity_LightShadowBias;
          varying highp vec3 xlv_TEXCOORD0;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+7) * min (
              ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
            , 0.999)));
            highp vec4 tmpvar_2;
            tmpvar_2 = (tmpvar_1 - (tmpvar_1.yzww * 0.003921569));
            gl_FragData[0] = tmpvar_2;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "SHADOWS_CUBE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          uniform highp vec4 _LightPositionRange;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          varying highp vec3 xlv_TEXCOORD0;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = _glesVertex.xyz;
            xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
            gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _LightPositionRange;
          uniform highp vec4 unity_LightShadowBias;
          varying highp vec3 xlv_TEXCOORD0;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+7) * min (
              ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
            , 0.999)));
            highp vec4 tmpvar_2;
            tmpvar_2 = (tmpvar_1 - (tmpvar_1.yzww * 0.003921569));
            gl_FragData[0] = tmpvar_2;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "SHADOWS_CUBE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 unity_LightShadowBias;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat9;
          bool u_xlatb9;
          void main()
          {
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
              u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
              u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
              u_xlat9 = sqrt(u_xlat9);
              u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
              u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
          #else
              u_xlatb9 = unity_LightShadowBias.z!=0.0;
          #endif
              u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
              u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
              u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
              gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
              gl_Position.xyw = u_xlat0.xyw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          layout(location = 0) out highp vec4 SV_Target0;
          void main()
          {
              SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "SHADOWS_CUBE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 unity_LightShadowBias;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat9;
          bool u_xlatb9;
          void main()
          {
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
              u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
              u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
              u_xlat9 = sqrt(u_xlat9);
              u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
              u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
          #else
              u_xlatb9 = unity_LightShadowBias.z!=0.0;
          #endif
              u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
              u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
              u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
              gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
              gl_Position.xyw = u_xlat0.xyw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          layout(location = 0) out highp vec4 SV_Target0;
          void main()
          {
              SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "SHADOWS_CUBE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 unity_LightShadowBias;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          in highp vec4 in_POSITION0;
          in highp vec3 in_NORMAL0;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          float u_xlat9;
          bool u_xlatb9;
          void main()
          {
              u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
              u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
              u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
              u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
              u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
              u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
              u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
              u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
              u_xlat9 = inversesqrt(u_xlat9);
              u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
              u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
              u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
              u_xlat9 = sqrt(u_xlat9);
              u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
              u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
          #else
              u_xlatb9 = unity_LightShadowBias.z!=0.0;
          #endif
              u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
              u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
              u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
              u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
              u_xlat1.x = max((-u_xlat0.w), u_xlat0.z);
              u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
              gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
              gl_Position.xyw = u_xlat0.xyw;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          layout(location = 0) out highp vec4 SV_Target0;
          void main()
          {
              SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
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
           Keywords { "SHADOWS_DEPTH" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "SHADOWS_DEPTH" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "SHADOWS_DEPTH" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "SHADOWS_DEPTH" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "SHADOWS_DEPTH" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "SHADOWS_DEPTH" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "SHADOWS_CUBE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "SHADOWS_CUBE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "SHADOWS_CUBE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "SHADOWS_CUBE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "SHADOWS_CUBE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "SHADOWS_CUBE" }
          
          "!!!!GLES3
          
          
          "
        }
      }
      
    } // end phase
  }
  FallBack ""
}
