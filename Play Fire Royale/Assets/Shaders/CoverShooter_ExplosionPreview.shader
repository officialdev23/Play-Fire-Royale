Shader "CoverShooter/ExplosionPreview"
{
  Properties
  {
    _Color ("Color", Color) = (1,0,0,1)
    _Opacity ("Opacity", float) = 1
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    LOD 100
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 100
      ZTest Always
      ZWrite Off
      Cull Front
      Blend One OneMinusSrcAlpha
      GpuProgramID 16953
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
          uniform highp vec4 _ProjectionParams;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixVP;
          varying highp vec4 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1 = _glesVertex;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = tmpvar_1.xyz;
            tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            highp vec4 o_4;
            highp vec4 tmpvar_5;
            tmpvar_5 = (tmpvar_2 * 0.5);
            highp vec2 tmpvar_6;
            tmpvar_6.x = tmpvar_5.x;
            tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
            o_4.xy = (tmpvar_6 + tmpvar_5.w);
            o_4.zw = tmpvar_2.zw;
            highp vec4 tmpvar_7;
            tmpvar_7.w = 1.0;
            tmpvar_7.xyz = tmpvar_1.xyz;
            gl_Position = tmpvar_2;
            xlv_TEXCOORD0 = o_4;
            xlv_TEXCOORD1 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_7)).xyz * vec3(-1.0, -1.0, 1.0));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _ProjectionParams;
          uniform highp vec4 _ZBufferParams;
          uniform highp mat4 unity_CameraToWorld;
          uniform highp vec4 _Color;
          uniform highp float _Opacity;
          uniform highp vec3 _Center;
          uniform highp float _Radius;
          uniform sampler2D _CameraDepthTexture;
          varying highp vec4 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 tmpvar_1;
            highp vec4 color_2;
            highp float depth_3;
            highp vec2 tmpvar_4;
            tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
            lowp float tmpvar_5;
            tmpvar_5 = texture2D (_CameraDepthTexture, tmpvar_4).x;
            depth_3 = tmpvar_5;
            highp float tmpvar_6;
            tmpvar_6 = (1.0/(((_ZBufferParams.x * depth_3) + _ZBufferParams.y)));
            depth_3 = tmpvar_6;
            highp vec4 tmpvar_7;
            tmpvar_7.w = 1.0;
            tmpvar_7.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_6);
            highp float tmpvar_8;
            highp vec3 tmpvar_9;
            tmpvar_9 = ((unity_CameraToWorld * tmpvar_7).xyz - _Center);
            tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
            if ((tmpvar_8 > (_Radius * 0.5))) {
              discard;
            };
            color_2.xyz = (_Color.xyz * _Color.w);
            color_2.w = (_Color.w * _Opacity);
            tmpvar_1 = color_2;
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
          uniform highp vec4 _ProjectionParams;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixVP;
          varying highp vec4 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1 = _glesVertex;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = tmpvar_1.xyz;
            tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            highp vec4 o_4;
            highp vec4 tmpvar_5;
            tmpvar_5 = (tmpvar_2 * 0.5);
            highp vec2 tmpvar_6;
            tmpvar_6.x = tmpvar_5.x;
            tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
            o_4.xy = (tmpvar_6 + tmpvar_5.w);
            o_4.zw = tmpvar_2.zw;
            highp vec4 tmpvar_7;
            tmpvar_7.w = 1.0;
            tmpvar_7.xyz = tmpvar_1.xyz;
            gl_Position = tmpvar_2;
            xlv_TEXCOORD0 = o_4;
            xlv_TEXCOORD1 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_7)).xyz * vec3(-1.0, -1.0, 1.0));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _ProjectionParams;
          uniform highp vec4 _ZBufferParams;
          uniform highp mat4 unity_CameraToWorld;
          uniform highp vec4 _Color;
          uniform highp float _Opacity;
          uniform highp vec3 _Center;
          uniform highp float _Radius;
          uniform sampler2D _CameraDepthTexture;
          varying highp vec4 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 tmpvar_1;
            highp vec4 color_2;
            highp float depth_3;
            highp vec2 tmpvar_4;
            tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
            lowp float tmpvar_5;
            tmpvar_5 = texture2D (_CameraDepthTexture, tmpvar_4).x;
            depth_3 = tmpvar_5;
            highp float tmpvar_6;
            tmpvar_6 = (1.0/(((_ZBufferParams.x * depth_3) + _ZBufferParams.y)));
            depth_3 = tmpvar_6;
            highp vec4 tmpvar_7;
            tmpvar_7.w = 1.0;
            tmpvar_7.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_6);
            highp float tmpvar_8;
            highp vec3 tmpvar_9;
            tmpvar_9 = ((unity_CameraToWorld * tmpvar_7).xyz - _Center);
            tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
            if ((tmpvar_8 > (_Radius * 0.5))) {
              discard;
            };
            color_2.xyz = (_Color.xyz * _Color.w);
            color_2.w = (_Color.w * _Opacity);
            tmpvar_1 = color_2;
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
          uniform highp vec4 _ProjectionParams;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixV;
          uniform highp mat4 unity_MatrixVP;
          varying highp vec4 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            highp vec4 tmpvar_1;
            tmpvar_1 = _glesVertex;
            highp vec4 tmpvar_2;
            highp vec4 tmpvar_3;
            tmpvar_3.w = 1.0;
            tmpvar_3.xyz = tmpvar_1.xyz;
            tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
            highp vec4 o_4;
            highp vec4 tmpvar_5;
            tmpvar_5 = (tmpvar_2 * 0.5);
            highp vec2 tmpvar_6;
            tmpvar_6.x = tmpvar_5.x;
            tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
            o_4.xy = (tmpvar_6 + tmpvar_5.w);
            o_4.zw = tmpvar_2.zw;
            highp vec4 tmpvar_7;
            tmpvar_7.w = 1.0;
            tmpvar_7.xyz = tmpvar_1.xyz;
            gl_Position = tmpvar_2;
            xlv_TEXCOORD0 = o_4;
            xlv_TEXCOORD1 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_7)).xyz * vec3(-1.0, -1.0, 1.0));
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _ProjectionParams;
          uniform highp vec4 _ZBufferParams;
          uniform highp mat4 unity_CameraToWorld;
          uniform highp vec4 _Color;
          uniform highp float _Opacity;
          uniform highp vec3 _Center;
          uniform highp float _Radius;
          uniform sampler2D _CameraDepthTexture;
          varying highp vec4 xlv_TEXCOORD0;
          varying highp vec3 xlv_TEXCOORD1;
          void main ()
          {
            lowp vec4 tmpvar_1;
            highp vec4 color_2;
            highp float depth_3;
            highp vec2 tmpvar_4;
            tmpvar_4 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
            lowp float tmpvar_5;
            tmpvar_5 = texture2D (_CameraDepthTexture, tmpvar_4).x;
            depth_3 = tmpvar_5;
            highp float tmpvar_6;
            tmpvar_6 = (1.0/(((_ZBufferParams.x * depth_3) + _ZBufferParams.y)));
            depth_3 = tmpvar_6;
            highp vec4 tmpvar_7;
            tmpvar_7.w = 1.0;
            tmpvar_7.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_6);
            highp float tmpvar_8;
            highp vec3 tmpvar_9;
            tmpvar_9 = ((unity_CameraToWorld * tmpvar_7).xyz - _Center);
            tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
            if ((tmpvar_8 > (_Radius * 0.5))) {
              discard;
            };
            color_2.xyz = (_Color.xyz * _Color.w);
            color_2.w = (_Color.w * _Opacity);
            tmpvar_1 = color_2;
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
          
          uniform 	vec4 _ProjectionParams;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          in highp vec4 in_POSITION0;
          out highp vec4 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
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
              u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
              u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
              vs_TEXCOORD0.zw = u_xlat1.zw;
              vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
              vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _ProjectionParams;
          uniform 	vec4 _ZBufferParams;
          uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
          uniform 	vec4 _Color;
          uniform 	float _Opacity;
          uniform 	vec3 _Center;
          uniform 	float _Radius;
          uniform highp sampler2D _CameraDepthTexture;
          in highp vec4 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          bool u_xlatb0;
          vec3 u_xlat1;
          float u_xlat2;
          float u_xlat6;
          void main()
          {
              u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD1.z;
              u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
              u_xlat1.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
              u_xlat6 = texture(_CameraDepthTexture, u_xlat1.xy).x;
              u_xlat6 = _ZBufferParams.x * u_xlat6 + _ZBufferParams.y;
              u_xlat6 = float(1.0) / u_xlat6;
              u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
              u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
              u_xlat0.xyz = vec3(u_xlat0.x + (-_Center.xxyz.y), u_xlat0.y + (-_Center.xxyz.z), u_xlat0.z + (-float(_Center.z)));
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = sqrt(u_xlat0.x);
              u_xlat2 = _Radius * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlat2<u_xlat0.x);
          #else
              u_xlatb0 = u_xlat2<u_xlat0.x;
          #endif
              if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
              u_xlat0.xyz = _Color.www * _Color.xyz;
              u_xlat0.w = _Color.w * _Opacity;
              SV_Target0 = u_xlat0;
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
          
          uniform 	vec4 _ProjectionParams;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          in highp vec4 in_POSITION0;
          out highp vec4 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
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
              u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
              u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
              vs_TEXCOORD0.zw = u_xlat1.zw;
              vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
              vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _ProjectionParams;
          uniform 	vec4 _ZBufferParams;
          uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
          uniform 	vec4 _Color;
          uniform 	float _Opacity;
          uniform 	vec3 _Center;
          uniform 	float _Radius;
          uniform highp sampler2D _CameraDepthTexture;
          in highp vec4 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          bool u_xlatb0;
          vec3 u_xlat1;
          float u_xlat2;
          float u_xlat6;
          void main()
          {
              u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD1.z;
              u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
              u_xlat1.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
              u_xlat6 = texture(_CameraDepthTexture, u_xlat1.xy).x;
              u_xlat6 = _ZBufferParams.x * u_xlat6 + _ZBufferParams.y;
              u_xlat6 = float(1.0) / u_xlat6;
              u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
              u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
              u_xlat0.xyz = vec3(u_xlat0.x + (-_Center.xxyz.y), u_xlat0.y + (-_Center.xxyz.z), u_xlat0.z + (-float(_Center.z)));
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = sqrt(u_xlat0.x);
              u_xlat2 = _Radius * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlat2<u_xlat0.x);
          #else
              u_xlatb0 = u_xlat2<u_xlat0.x;
          #endif
              if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
              u_xlat0.xyz = _Color.www * _Color.xyz;
              u_xlat0.w = _Color.w * _Opacity;
              SV_Target0 = u_xlat0;
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
          
          uniform 	vec4 _ProjectionParams;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          in highp vec4 in_POSITION0;
          out highp vec4 vs_TEXCOORD0;
          out highp vec3 vs_TEXCOORD1;
          vec4 u_xlat0;
          vec4 u_xlat1;
          vec4 u_xlat2;
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
              u_xlat1.y = u_xlat1.y * _ProjectionParams.x;
              u_xlat2.xzw = u_xlat1.xwy * vec3(0.5, 0.5, 0.5);
              vs_TEXCOORD0.zw = u_xlat1.zw;
              vs_TEXCOORD0.xy = u_xlat2.zz + u_xlat2.xw;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * u_xlat0.www + u_xlat0.xyz;
              vs_TEXCOORD1.xyz = u_xlat0.xyz * vec3(-1.0, -1.0, 1.0);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _ProjectionParams;
          uniform 	vec4 _ZBufferParams;
          uniform 	vec4 hlslcc_mtx4x4unity_CameraToWorld[4];
          uniform 	vec4 _Color;
          uniform 	float _Opacity;
          uniform 	vec3 _Center;
          uniform 	float _Radius;
          uniform highp sampler2D _CameraDepthTexture;
          in highp vec4 vs_TEXCOORD0;
          in highp vec3 vs_TEXCOORD1;
          layout(location = 0) out mediump vec4 SV_Target0;
          vec4 u_xlat0;
          bool u_xlatb0;
          vec3 u_xlat1;
          float u_xlat2;
          float u_xlat6;
          void main()
          {
              u_xlat0.x = _ProjectionParams.z / vs_TEXCOORD1.z;
              u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
              u_xlat1.xy = vs_TEXCOORD0.xy / vs_TEXCOORD0.ww;
              u_xlat6 = texture(_CameraDepthTexture, u_xlat1.xy).x;
              u_xlat6 = _ZBufferParams.x * u_xlat6 + _ZBufferParams.y;
              u_xlat6 = float(1.0) / u_xlat6;
              u_xlat0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
              u_xlat1.xyz = u_xlat0.yyy * hlslcc_mtx4x4unity_CameraToWorld[1].xyz;
              u_xlat0.xyw = hlslcc_mtx4x4unity_CameraToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
              u_xlat0.xyz = hlslcc_mtx4x4unity_CameraToWorld[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
              u_xlat0.xyz = u_xlat0.xyz + hlslcc_mtx4x4unity_CameraToWorld[3].xyz;
              u_xlat0.xyz = vec3(u_xlat0.x + (-_Center.xxyz.y), u_xlat0.y + (-_Center.xxyz.z), u_xlat0.z + (-float(_Center.z)));
              u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat0.x = sqrt(u_xlat0.x);
              u_xlat2 = _Radius * 0.5;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlat2<u_xlat0.x);
          #else
              u_xlatb0 = u_xlat2<u_xlat0.x;
          #endif
              if((int(u_xlatb0) * int(0xffffffffu))!=0){discard;}
              u_xlat0.xyz = _Color.www * _Color.xyz;
              u_xlat0.w = _Color.w * _Opacity;
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
