Shader "Skybox/Procedural"
{
  Properties
  {
    [KeywordEnum(None, Simple, High Quality)] _SunDisk ("Sun", float) = 2
    _SunSize ("Sun Size", Range(0, 1)) = 0.04
    _SunSizeConvergence ("Sun Size Convergence", Range(1, 10)) = 5
    _AtmosphereThickness ("Atmosphere Thickness", Range(0, 5)) = 1
    _SkyTint ("Sky Tint", Color) = (0.5,0.5,0.5,1)
    _GroundColor ("Ground", Color) = (0.369,0.349,0.341,1)
    _Exposure ("Exposure", Range(0, 8)) = 1.3
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
      GpuProgramID 1560
      // m_ProgramMask = 6
      !!! *******************************************************************************************
      !!! Allow restore shader as UnityLab format - only available for DevX GameRecovery license type
      !!! *******************************************************************************************
      Program "vp"
      {
        SubProgram "gles hw_tier00"
        {
           Keywords { "_SUNDISK_NONE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform mediump float _Exposure;
          uniform mediump vec3 _GroundColor;
          uniform mediump vec3 _SkyTint;
          uniform mediump float _AtmosphereThickness;
          varying mediump float xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          void main ()
          {
            mediump vec3 cOut_1;
            mediump vec3 cIn_2;
            highp float far_3;
            highp float kKr4PI_4;
            highp float kKrESun_5;
            highp vec3 kSkyTintInGammaSpace_6;
            mediump float tmpvar_7;
            mediump vec3 tmpvar_8;
            mediump vec3 tmpvar_9;
            highp vec4 tmpvar_10;
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = _glesVertex.xyz;
            tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
            kSkyTintInGammaSpace_6 = _SkyTint;
            highp vec3 tmpvar_12;
            tmpvar_12 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
              (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
            ), vec3(4.0, 4.0, 4.0))));
            mediump float tmpvar_13;
            mediump float tmpvar_14;
            tmpvar_14 = pow (_AtmosphereThickness, 2.5);
            tmpvar_13 = (0.05 * tmpvar_14);
            kKrESun_5 = tmpvar_13;
            mediump float tmpvar_15;
            tmpvar_15 = (0.03141593 * tmpvar_14);
            kKr4PI_4 = tmpvar_15;
            highp mat3 tmpvar_16;
            tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
            tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
            tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
            highp vec3 tmpvar_17;
            tmpvar_17 = normalize((tmpvar_16 * _glesVertex.xyz));
            far_3 = 0.0;
            if ((tmpvar_17.y >= 0.0)) {
              highp vec3 frontColor_18;
              highp vec3 samplePoint_19;
              far_3 = (sqrt((
                (1.050625 + (tmpvar_17.y * tmpvar_17.y))
               - 1.0)) - tmpvar_17.y);
              highp float tmpvar_20;
              tmpvar_20 = (1.0 - (dot (tmpvar_17, vec3(0.0, 1.0001, 0.0)) / 1.0001));
              highp float tmpvar_21;
              tmpvar_21 = (exp((-0.00287 + 
                (tmpvar_20 * (0.459 + (tmpvar_20 * (3.83 + 
                  (tmpvar_20 * (-6.8 + (tmpvar_20 * 5.25)))
                ))))
              )) * 0.2460318);
              highp float tmpvar_22;
              tmpvar_22 = (far_3 / 2.0);
              highp float tmpvar_23;
              tmpvar_23 = (tmpvar_22 * 40.00004);
              highp vec3 tmpvar_24;
              tmpvar_24 = (tmpvar_17 * tmpvar_22);
              highp vec3 tmpvar_25;
              tmpvar_25 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_24 * 0.5));
              highp float tmpvar_26;
              tmpvar_26 = sqrt(dot (tmpvar_25, tmpvar_25));
              highp float tmpvar_27;
              tmpvar_27 = exp((160.0002 * (1.0 - tmpvar_26)));
              highp float tmpvar_28;
              tmpvar_28 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_25) / tmpvar_26));
              highp float tmpvar_29;
              tmpvar_29 = (1.0 - (dot (tmpvar_17, tmpvar_25) / tmpvar_26));
              frontColor_18 = (exp((
                -(clamp ((tmpvar_21 + (tmpvar_27 * 
                  ((0.25 * exp((-0.00287 + 
                    (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
                      (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
                    ))))
                  ))) - (0.25 * exp((-0.00287 + 
                    (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
                      (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
                    ))))
                  ))))
                )), 0.0, 50.0))
               * 
                ((tmpvar_12 * kKr4PI_4) + 0.01256637)
              )) * (tmpvar_27 * tmpvar_23));
              samplePoint_19 = (tmpvar_25 + tmpvar_24);
              highp float tmpvar_30;
              tmpvar_30 = sqrt(dot (samplePoint_19, samplePoint_19));
              highp float tmpvar_31;
              tmpvar_31 = exp((160.0002 * (1.0 - tmpvar_30)));
              highp float tmpvar_32;
              tmpvar_32 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_19) / tmpvar_30));
              highp float tmpvar_33;
              tmpvar_33 = (1.0 - (dot (tmpvar_17, samplePoint_19) / tmpvar_30));
              frontColor_18 = (frontColor_18 + (exp(
                (-(clamp ((tmpvar_21 + 
                  (tmpvar_31 * ((0.25 * exp(
                    (-0.00287 + (tmpvar_32 * (0.459 + (tmpvar_32 * 
                      (3.83 + (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25))))
                    ))))
                  )) - (0.25 * exp(
                    (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
                      (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
                    ))))
                  ))))
                ), 0.0, 50.0)) * ((tmpvar_12 * kKr4PI_4) + 0.01256637))
              ) * (tmpvar_31 * tmpvar_23)));
              samplePoint_19 = (samplePoint_19 + tmpvar_24);
              cIn_2 = (frontColor_18 * (tmpvar_12 * kKrESun_5));
              cOut_1 = (frontColor_18 * 0.02);
            } else {
              highp vec3 frontColor_1_34;
              far_3 = (-0.0001 / min (-0.001, tmpvar_17.y));
              highp vec3 tmpvar_35;
              tmpvar_35 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_17));
              highp float tmpvar_36;
              highp float tmpvar_37;
              tmpvar_37 = (1.0 - dot (-(tmpvar_17), tmpvar_35));
              tmpvar_36 = (0.25 * exp((-0.00287 + 
                (tmpvar_37 * (0.459 + (tmpvar_37 * (3.83 + 
                  (tmpvar_37 * (-6.8 + (tmpvar_37 * 5.25)))
                ))))
              )));
              highp float tmpvar_38;
              tmpvar_38 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_35));
              highp float tmpvar_39;
              tmpvar_39 = (far_3 / 2.0);
              highp vec3 tmpvar_40;
              tmpvar_40 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_17 * tmpvar_39) * 0.5));
              highp float tmpvar_41;
              tmpvar_41 = exp((160.0002 * (1.0 - 
                sqrt(dot (tmpvar_40, tmpvar_40))
              )));
              highp vec3 tmpvar_42;
              tmpvar_42 = exp((-(
                clamp (((tmpvar_41 * (
                  (0.25 * exp((-0.00287 + (tmpvar_38 * 
                    (0.459 + (tmpvar_38 * (3.83 + (tmpvar_38 * 
                      (-6.8 + (tmpvar_38 * 5.25))
                    ))))
                  ))))
                 + tmpvar_36)) - (0.9996001 * tmpvar_36)), 0.0, 50.0)
              ) * (
                (tmpvar_12 * kKr4PI_4)
               + 0.01256637)));
              frontColor_1_34 = (tmpvar_42 * (tmpvar_41 * (tmpvar_39 * 40.00004)));
              cIn_2 = (frontColor_1_34 * ((tmpvar_12 * kKrESun_5) + 0.02));
              highp vec3 tmpvar_43;
              tmpvar_43 = clamp (tmpvar_42, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
              cOut_1 = tmpvar_43;
            };
            tmpvar_7 = (-(tmpvar_17.y) / 0.02);
            tmpvar_8 = (_Exposure * (cIn_2 + (
              (_GroundColor * _GroundColor)
             * cOut_1)));
            mediump vec3 light_44;
            light_44 = _WorldSpaceLightPos0.xyz;
            mediump vec3 ray_45;
            ray_45 = -(tmpvar_17);
            mediump float tmpvar_46;
            tmpvar_46 = dot (light_44, ray_45);
            tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
              (0.75 * (tmpvar_46 * tmpvar_46))
            )));
            mediump vec3 tmpvar_47;
            tmpvar_47 = sqrt(tmpvar_8);
            tmpvar_8 = tmpvar_47;
            mediump vec3 tmpvar_48;
            tmpvar_48 = sqrt(tmpvar_9);
            tmpvar_9 = tmpvar_48;
            gl_Position = tmpvar_10;
            xlv_TEXCOORD0 = tmpvar_7;
            xlv_TEXCOORD1 = tmpvar_47;
            xlv_TEXCOORD2 = tmpvar_48;
          }
          
          
          #endif
          #ifdef FRAGMENT
          varying mediump float xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          void main ()
          {
            mediump vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (xlv_TEXCOORD0, 0.0, 1.0)));
            gl_FragData[0] = tmpvar_1;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "_SUNDISK_NONE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform mediump float _Exposure;
          uniform mediump vec3 _GroundColor;
          uniform mediump vec3 _SkyTint;
          uniform mediump float _AtmosphereThickness;
          varying mediump float xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          void main ()
          {
            mediump vec3 cOut_1;
            mediump vec3 cIn_2;
            highp float far_3;
            highp float kKr4PI_4;
            highp float kKrESun_5;
            highp vec3 kSkyTintInGammaSpace_6;
            mediump float tmpvar_7;
            mediump vec3 tmpvar_8;
            mediump vec3 tmpvar_9;
            highp vec4 tmpvar_10;
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = _glesVertex.xyz;
            tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
            kSkyTintInGammaSpace_6 = _SkyTint;
            highp vec3 tmpvar_12;
            tmpvar_12 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
              (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
            ), vec3(4.0, 4.0, 4.0))));
            mediump float tmpvar_13;
            mediump float tmpvar_14;
            tmpvar_14 = pow (_AtmosphereThickness, 2.5);
            tmpvar_13 = (0.05 * tmpvar_14);
            kKrESun_5 = tmpvar_13;
            mediump float tmpvar_15;
            tmpvar_15 = (0.03141593 * tmpvar_14);
            kKr4PI_4 = tmpvar_15;
            highp mat3 tmpvar_16;
            tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
            tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
            tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
            highp vec3 tmpvar_17;
            tmpvar_17 = normalize((tmpvar_16 * _glesVertex.xyz));
            far_3 = 0.0;
            if ((tmpvar_17.y >= 0.0)) {
              highp vec3 frontColor_18;
              highp vec3 samplePoint_19;
              far_3 = (sqrt((
                (1.050625 + (tmpvar_17.y * tmpvar_17.y))
               - 1.0)) - tmpvar_17.y);
              highp float tmpvar_20;
              tmpvar_20 = (1.0 - (dot (tmpvar_17, vec3(0.0, 1.0001, 0.0)) / 1.0001));
              highp float tmpvar_21;
              tmpvar_21 = (exp((-0.00287 + 
                (tmpvar_20 * (0.459 + (tmpvar_20 * (3.83 + 
                  (tmpvar_20 * (-6.8 + (tmpvar_20 * 5.25)))
                ))))
              )) * 0.2460318);
              highp float tmpvar_22;
              tmpvar_22 = (far_3 / 2.0);
              highp float tmpvar_23;
              tmpvar_23 = (tmpvar_22 * 40.00004);
              highp vec3 tmpvar_24;
              tmpvar_24 = (tmpvar_17 * tmpvar_22);
              highp vec3 tmpvar_25;
              tmpvar_25 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_24 * 0.5));
              highp float tmpvar_26;
              tmpvar_26 = sqrt(dot (tmpvar_25, tmpvar_25));
              highp float tmpvar_27;
              tmpvar_27 = exp((160.0002 * (1.0 - tmpvar_26)));
              highp float tmpvar_28;
              tmpvar_28 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_25) / tmpvar_26));
              highp float tmpvar_29;
              tmpvar_29 = (1.0 - (dot (tmpvar_17, tmpvar_25) / tmpvar_26));
              frontColor_18 = (exp((
                -(clamp ((tmpvar_21 + (tmpvar_27 * 
                  ((0.25 * exp((-0.00287 + 
                    (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
                      (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
                    ))))
                  ))) - (0.25 * exp((-0.00287 + 
                    (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
                      (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
                    ))))
                  ))))
                )), 0.0, 50.0))
               * 
                ((tmpvar_12 * kKr4PI_4) + 0.01256637)
              )) * (tmpvar_27 * tmpvar_23));
              samplePoint_19 = (tmpvar_25 + tmpvar_24);
              highp float tmpvar_30;
              tmpvar_30 = sqrt(dot (samplePoint_19, samplePoint_19));
              highp float tmpvar_31;
              tmpvar_31 = exp((160.0002 * (1.0 - tmpvar_30)));
              highp float tmpvar_32;
              tmpvar_32 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_19) / tmpvar_30));
              highp float tmpvar_33;
              tmpvar_33 = (1.0 - (dot (tmpvar_17, samplePoint_19) / tmpvar_30));
              frontColor_18 = (frontColor_18 + (exp(
                (-(clamp ((tmpvar_21 + 
                  (tmpvar_31 * ((0.25 * exp(
                    (-0.00287 + (tmpvar_32 * (0.459 + (tmpvar_32 * 
                      (3.83 + (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25))))
                    ))))
                  )) - (0.25 * exp(
                    (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
                      (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
                    ))))
                  ))))
                ), 0.0, 50.0)) * ((tmpvar_12 * kKr4PI_4) + 0.01256637))
              ) * (tmpvar_31 * tmpvar_23)));
              samplePoint_19 = (samplePoint_19 + tmpvar_24);
              cIn_2 = (frontColor_18 * (tmpvar_12 * kKrESun_5));
              cOut_1 = (frontColor_18 * 0.02);
            } else {
              highp vec3 frontColor_1_34;
              far_3 = (-0.0001 / min (-0.001, tmpvar_17.y));
              highp vec3 tmpvar_35;
              tmpvar_35 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_17));
              highp float tmpvar_36;
              highp float tmpvar_37;
              tmpvar_37 = (1.0 - dot (-(tmpvar_17), tmpvar_35));
              tmpvar_36 = (0.25 * exp((-0.00287 + 
                (tmpvar_37 * (0.459 + (tmpvar_37 * (3.83 + 
                  (tmpvar_37 * (-6.8 + (tmpvar_37 * 5.25)))
                ))))
              )));
              highp float tmpvar_38;
              tmpvar_38 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_35));
              highp float tmpvar_39;
              tmpvar_39 = (far_3 / 2.0);
              highp vec3 tmpvar_40;
              tmpvar_40 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_17 * tmpvar_39) * 0.5));
              highp float tmpvar_41;
              tmpvar_41 = exp((160.0002 * (1.0 - 
                sqrt(dot (tmpvar_40, tmpvar_40))
              )));
              highp vec3 tmpvar_42;
              tmpvar_42 = exp((-(
                clamp (((tmpvar_41 * (
                  (0.25 * exp((-0.00287 + (tmpvar_38 * 
                    (0.459 + (tmpvar_38 * (3.83 + (tmpvar_38 * 
                      (-6.8 + (tmpvar_38 * 5.25))
                    ))))
                  ))))
                 + tmpvar_36)) - (0.9996001 * tmpvar_36)), 0.0, 50.0)
              ) * (
                (tmpvar_12 * kKr4PI_4)
               + 0.01256637)));
              frontColor_1_34 = (tmpvar_42 * (tmpvar_41 * (tmpvar_39 * 40.00004)));
              cIn_2 = (frontColor_1_34 * ((tmpvar_12 * kKrESun_5) + 0.02));
              highp vec3 tmpvar_43;
              tmpvar_43 = clamp (tmpvar_42, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
              cOut_1 = tmpvar_43;
            };
            tmpvar_7 = (-(tmpvar_17.y) / 0.02);
            tmpvar_8 = (_Exposure * (cIn_2 + (
              (_GroundColor * _GroundColor)
             * cOut_1)));
            mediump vec3 light_44;
            light_44 = _WorldSpaceLightPos0.xyz;
            mediump vec3 ray_45;
            ray_45 = -(tmpvar_17);
            mediump float tmpvar_46;
            tmpvar_46 = dot (light_44, ray_45);
            tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
              (0.75 * (tmpvar_46 * tmpvar_46))
            )));
            mediump vec3 tmpvar_47;
            tmpvar_47 = sqrt(tmpvar_8);
            tmpvar_8 = tmpvar_47;
            mediump vec3 tmpvar_48;
            tmpvar_48 = sqrt(tmpvar_9);
            tmpvar_9 = tmpvar_48;
            gl_Position = tmpvar_10;
            xlv_TEXCOORD0 = tmpvar_7;
            xlv_TEXCOORD1 = tmpvar_47;
            xlv_TEXCOORD2 = tmpvar_48;
          }
          
          
          #endif
          #ifdef FRAGMENT
          varying mediump float xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          void main ()
          {
            mediump vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (xlv_TEXCOORD0, 0.0, 1.0)));
            gl_FragData[0] = tmpvar_1;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "_SUNDISK_NONE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform mediump float _Exposure;
          uniform mediump vec3 _GroundColor;
          uniform mediump vec3 _SkyTint;
          uniform mediump float _AtmosphereThickness;
          varying mediump float xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          void main ()
          {
            mediump vec3 cOut_1;
            mediump vec3 cIn_2;
            highp float far_3;
            highp float kKr4PI_4;
            highp float kKrESun_5;
            highp vec3 kSkyTintInGammaSpace_6;
            mediump float tmpvar_7;
            mediump vec3 tmpvar_8;
            mediump vec3 tmpvar_9;
            highp vec4 tmpvar_10;
            highp vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = _glesVertex.xyz;
            tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
            kSkyTintInGammaSpace_6 = _SkyTint;
            highp vec3 tmpvar_12;
            tmpvar_12 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
              (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_6)
            ), vec3(4.0, 4.0, 4.0))));
            mediump float tmpvar_13;
            mediump float tmpvar_14;
            tmpvar_14 = pow (_AtmosphereThickness, 2.5);
            tmpvar_13 = (0.05 * tmpvar_14);
            kKrESun_5 = tmpvar_13;
            mediump float tmpvar_15;
            tmpvar_15 = (0.03141593 * tmpvar_14);
            kKr4PI_4 = tmpvar_15;
            highp mat3 tmpvar_16;
            tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
            tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
            tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
            highp vec3 tmpvar_17;
            tmpvar_17 = normalize((tmpvar_16 * _glesVertex.xyz));
            far_3 = 0.0;
            if ((tmpvar_17.y >= 0.0)) {
              highp vec3 frontColor_18;
              highp vec3 samplePoint_19;
              far_3 = (sqrt((
                (1.050625 + (tmpvar_17.y * tmpvar_17.y))
               - 1.0)) - tmpvar_17.y);
              highp float tmpvar_20;
              tmpvar_20 = (1.0 - (dot (tmpvar_17, vec3(0.0, 1.0001, 0.0)) / 1.0001));
              highp float tmpvar_21;
              tmpvar_21 = (exp((-0.00287 + 
                (tmpvar_20 * (0.459 + (tmpvar_20 * (3.83 + 
                  (tmpvar_20 * (-6.8 + (tmpvar_20 * 5.25)))
                ))))
              )) * 0.2460318);
              highp float tmpvar_22;
              tmpvar_22 = (far_3 / 2.0);
              highp float tmpvar_23;
              tmpvar_23 = (tmpvar_22 * 40.00004);
              highp vec3 tmpvar_24;
              tmpvar_24 = (tmpvar_17 * tmpvar_22);
              highp vec3 tmpvar_25;
              tmpvar_25 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_24 * 0.5));
              highp float tmpvar_26;
              tmpvar_26 = sqrt(dot (tmpvar_25, tmpvar_25));
              highp float tmpvar_27;
              tmpvar_27 = exp((160.0002 * (1.0 - tmpvar_26)));
              highp float tmpvar_28;
              tmpvar_28 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_25) / tmpvar_26));
              highp float tmpvar_29;
              tmpvar_29 = (1.0 - (dot (tmpvar_17, tmpvar_25) / tmpvar_26));
              frontColor_18 = (exp((
                -(clamp ((tmpvar_21 + (tmpvar_27 * 
                  ((0.25 * exp((-0.00287 + 
                    (tmpvar_28 * (0.459 + (tmpvar_28 * (3.83 + 
                      (tmpvar_28 * (-6.8 + (tmpvar_28 * 5.25)))
                    ))))
                  ))) - (0.25 * exp((-0.00287 + 
                    (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
                      (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
                    ))))
                  ))))
                )), 0.0, 50.0))
               * 
                ((tmpvar_12 * kKr4PI_4) + 0.01256637)
              )) * (tmpvar_27 * tmpvar_23));
              samplePoint_19 = (tmpvar_25 + tmpvar_24);
              highp float tmpvar_30;
              tmpvar_30 = sqrt(dot (samplePoint_19, samplePoint_19));
              highp float tmpvar_31;
              tmpvar_31 = exp((160.0002 * (1.0 - tmpvar_30)));
              highp float tmpvar_32;
              tmpvar_32 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_19) / tmpvar_30));
              highp float tmpvar_33;
              tmpvar_33 = (1.0 - (dot (tmpvar_17, samplePoint_19) / tmpvar_30));
              frontColor_18 = (frontColor_18 + (exp(
                (-(clamp ((tmpvar_21 + 
                  (tmpvar_31 * ((0.25 * exp(
                    (-0.00287 + (tmpvar_32 * (0.459 + (tmpvar_32 * 
                      (3.83 + (tmpvar_32 * (-6.8 + (tmpvar_32 * 5.25))))
                    ))))
                  )) - (0.25 * exp(
                    (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
                      (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
                    ))))
                  ))))
                ), 0.0, 50.0)) * ((tmpvar_12 * kKr4PI_4) + 0.01256637))
              ) * (tmpvar_31 * tmpvar_23)));
              samplePoint_19 = (samplePoint_19 + tmpvar_24);
              cIn_2 = (frontColor_18 * (tmpvar_12 * kKrESun_5));
              cOut_1 = (frontColor_18 * 0.02);
            } else {
              highp vec3 frontColor_1_34;
              far_3 = (-0.0001 / min (-0.001, tmpvar_17.y));
              highp vec3 tmpvar_35;
              tmpvar_35 = (vec3(0.0, 1.0001, 0.0) + (far_3 * tmpvar_17));
              highp float tmpvar_36;
              highp float tmpvar_37;
              tmpvar_37 = (1.0 - dot (-(tmpvar_17), tmpvar_35));
              tmpvar_36 = (0.25 * exp((-0.00287 + 
                (tmpvar_37 * (0.459 + (tmpvar_37 * (3.83 + 
                  (tmpvar_37 * (-6.8 + (tmpvar_37 * 5.25)))
                ))))
              )));
              highp float tmpvar_38;
              tmpvar_38 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_35));
              highp float tmpvar_39;
              tmpvar_39 = (far_3 / 2.0);
              highp vec3 tmpvar_40;
              tmpvar_40 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_17 * tmpvar_39) * 0.5));
              highp float tmpvar_41;
              tmpvar_41 = exp((160.0002 * (1.0 - 
                sqrt(dot (tmpvar_40, tmpvar_40))
              )));
              highp vec3 tmpvar_42;
              tmpvar_42 = exp((-(
                clamp (((tmpvar_41 * (
                  (0.25 * exp((-0.00287 + (tmpvar_38 * 
                    (0.459 + (tmpvar_38 * (3.83 + (tmpvar_38 * 
                      (-6.8 + (tmpvar_38 * 5.25))
                    ))))
                  ))))
                 + tmpvar_36)) - (0.9996001 * tmpvar_36)), 0.0, 50.0)
              ) * (
                (tmpvar_12 * kKr4PI_4)
               + 0.01256637)));
              frontColor_1_34 = (tmpvar_42 * (tmpvar_41 * (tmpvar_39 * 40.00004)));
              cIn_2 = (frontColor_1_34 * ((tmpvar_12 * kKrESun_5) + 0.02));
              highp vec3 tmpvar_43;
              tmpvar_43 = clamp (tmpvar_42, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
              cOut_1 = tmpvar_43;
            };
            tmpvar_7 = (-(tmpvar_17.y) / 0.02);
            tmpvar_8 = (_Exposure * (cIn_2 + (
              (_GroundColor * _GroundColor)
             * cOut_1)));
            mediump vec3 light_44;
            light_44 = _WorldSpaceLightPos0.xyz;
            mediump vec3 ray_45;
            ray_45 = -(tmpvar_17);
            mediump float tmpvar_46;
            tmpvar_46 = dot (light_44, ray_45);
            tmpvar_9 = (_Exposure * (cIn_2 * (0.75 + 
              (0.75 * (tmpvar_46 * tmpvar_46))
            )));
            mediump vec3 tmpvar_47;
            tmpvar_47 = sqrt(tmpvar_8);
            tmpvar_8 = tmpvar_47;
            mediump vec3 tmpvar_48;
            tmpvar_48 = sqrt(tmpvar_9);
            tmpvar_9 = tmpvar_48;
            gl_Position = tmpvar_10;
            xlv_TEXCOORD0 = tmpvar_7;
            xlv_TEXCOORD1 = tmpvar_47;
            xlv_TEXCOORD2 = tmpvar_48;
          }
          
          
          #endif
          #ifdef FRAGMENT
          varying mediump float xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          void main ()
          {
            mediump vec4 tmpvar_1;
            tmpvar_1.w = 1.0;
            tmpvar_1.xyz = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (xlv_TEXCOORD0, 0.0, 1.0)));
            gl_FragData[0] = tmpvar_1;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "_SUNDISK_NONE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	mediump float _Exposure;
          uniform 	mediump vec3 _GroundColor;
          uniform 	mediump vec3 _SkyTint;
          uniform 	mediump float _AtmosphereThickness;
          in highp vec4 in_POSITION0;
          out mediump float vs_TEXCOORD0;
          out mediump vec3 vs_TEXCOORD1;
          out mediump vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          mediump vec3 u_xlat16_0;
          bool u_xlatb0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          mediump vec3 u_xlat16_4;
          vec4 u_xlat5;
          vec3 u_xlat6;
          mediump vec3 u_xlat16_7;
          float u_xlat8;
          vec3 u_xlat13;
          float u_xlat16;
          float u_xlat21;
          float u_xlat24;
          float u_xlat25;
          float u_xlat26;
          mediump float u_xlat16_27;
          float u_xlat28;
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
              u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
              u_xlat16_3.x = log2(_AtmosphereThickness);
              u_xlat16_3.x = u_xlat16_3.x * 2.5;
              u_xlat16_3.x = exp2(u_xlat16_3.x);
              u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
              u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat24 = inversesqrt(u_xlat24);
              u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlat2.y>=0.0);
          #else
              u_xlatb0 = u_xlat2.y>=0.0;
          #endif
              if(u_xlatb0){
                  u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat0.x = (-u_xlat0.y) * u_xlat24 + u_xlat0.x;
                  u_xlat8 = (-u_xlat0.y) * u_xlat24 + 1.0;
                  u_xlat16 = u_xlat8 * 5.25 + -6.80000019;
                  u_xlat16 = u_xlat8 * u_xlat16 + 3.82999992;
                  u_xlat16 = u_xlat8 * u_xlat16 + 0.458999991;
                  u_xlat8 = u_xlat8 * u_xlat16 + -0.00286999997;
                  u_xlat8 = u_xlat8 * 1.44269502;
                  u_xlat0.y = exp2(u_xlat8);
                  u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
                  u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
                  u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat24 = sqrt(u_xlat24);
                  u_xlat25 = (-u_xlat24) + 1.0;
                  u_xlat25 = u_xlat25 * 230.831207;
                  u_xlat25 = exp2(u_xlat25);
                  u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat26 = u_xlat26 / u_xlat24;
                  u_xlat28 = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat24 = u_xlat28 / u_xlat24;
                  u_xlat26 = (-u_xlat26) + 1.0;
                  u_xlat28 = u_xlat26 * 5.25 + -6.80000019;
                  u_xlat28 = u_xlat26 * u_xlat28 + 3.82999992;
                  u_xlat28 = u_xlat26 * u_xlat28 + 0.458999991;
                  u_xlat26 = u_xlat26 * u_xlat28 + -0.00286999997;
                  u_xlat26 = u_xlat26 * 1.44269502;
                  u_xlat26 = exp2(u_xlat26);
                  u_xlat24 = (-u_xlat24) + 1.0;
                  u_xlat28 = u_xlat24 * 5.25 + -6.80000019;
                  u_xlat28 = u_xlat24 * u_xlat28 + 3.82999992;
                  u_xlat28 = u_xlat24 * u_xlat28 + 0.458999991;
                  u_xlat24 = u_xlat24 * u_xlat28 + -0.00286999997;
                  u_xlat24 = u_xlat24 * 1.44269502;
                  u_xlat24 = exp2(u_xlat24);
                  u_xlat24 = u_xlat24 * 0.25;
                  u_xlat24 = u_xlat26 * 0.25 + (-u_xlat24);
                  u_xlat24 = u_xlat25 * u_xlat24 + u_xlat0.y;
                  u_xlat24 = max(u_xlat24, 0.0);
                  u_xlat24 = min(u_xlat24, 50.0);
                  u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat6.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat6.xyz = exp2(u_xlat6.xyz);
                  u_xlat24 = u_xlat0.z * u_xlat25;
                  u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
                  u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat25 = (-u_xlat0.x) + 1.0;
                  u_xlat25 = u_xlat25 * 230.831207;
                  u_xlat25 = exp2(u_xlat25);
                  u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat26 = u_xlat26 / u_xlat0.x;
                  u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat0.x = u_xlat4.x / u_xlat0.x;
                  u_xlat26 = (-u_xlat26) + 1.0;
                  u_xlat4.x = u_xlat26 * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat26 * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat26 * u_xlat4.x + 0.458999991;
                  u_xlat26 = u_xlat26 * u_xlat4.x + -0.00286999997;
                  u_xlat26 = u_xlat26 * 1.44269502;
                  u_xlat26 = exp2(u_xlat26);
                  u_xlat0.x = (-u_xlat0.x) + 1.0;
                  u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
                  u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
                  u_xlat0.x = u_xlat0.x * 1.44269502;
                  u_xlat0.x = exp2(u_xlat0.x);
                  u_xlat0.x = u_xlat0.x * 0.25;
                  u_xlat0.x = u_xlat26 * 0.25 + (-u_xlat0.x);
                  u_xlat0.x = u_xlat25 * u_xlat0.x + u_xlat0.y;
                  u_xlat0.x = max(u_xlat0.x, 0.0);
                  u_xlat0.x = min(u_xlat0.x, 50.0);
                  u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
                  u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat4.xyz = exp2(u_xlat4.xyz);
                  u_xlat0.x = u_xlat0.z * u_xlat25;
                  u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat24) + u_xlat0.xyz;
                  u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
                  u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              } else {
                  u_xlat26 = min(u_xlat2.y, -0.00100000005);
                  u_xlat26 = -9.99999975e-05 / u_xlat26;
                  u_xlat5.xyz = vec3(u_xlat26) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
                  u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
                  u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
                  u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
                  u_xlat21 = u_xlat5.y * 5.25 + -6.80000019;
                  u_xlat21 = u_xlat5.y * u_xlat21 + 3.82999992;
                  u_xlat21 = u_xlat5.y * u_xlat21 + 0.458999991;
                  u_xlat13.x = u_xlat5.y * u_xlat21 + -0.00286999997;
                  u_xlat13.x = u_xlat13.x * 1.44269502;
                  u_xlat5.y = exp2(u_xlat13.x);
                  u_xlat21 = u_xlat5.x * 5.25 + -6.80000019;
                  u_xlat21 = u_xlat5.x * u_xlat21 + 3.82999992;
                  u_xlat21 = u_xlat5.x * u_xlat21 + 0.458999991;
                  u_xlat5.x = u_xlat5.x * u_xlat21 + -0.00286999997;
                  u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
                  u_xlat5.x = exp2(u_xlat5.x);
                  u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
                  u_xlat13.xz = vec2(u_xlat26) * vec2(0.5, 20.0);
                  u_xlat6.xyz = u_xlat2.xyz * u_xlat13.xxx;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat26 = dot(u_xlat6.xyz, u_xlat6.xyz);
                  u_xlat26 = sqrt(u_xlat26);
                  u_xlat26 = (-u_xlat26) + 1.0;
                  u_xlat26 = u_xlat26 * 230.831207;
                  u_xlat26 = exp2(u_xlat26);
                  u_xlat5.x = u_xlat26 * u_xlat5.x + (-u_xlat5.z);
                  u_xlat5.x = max(u_xlat5.x, 0.0);
                  u_xlat5.x = min(u_xlat5.x, 50.0);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
                  u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat0.xyz = exp2(u_xlat5.xyz);
                  u_xlat26 = u_xlat13.z * u_xlat26;
                  u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat26);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              //ENDIF
              }
              u_xlat26 = u_xlat2.y * -50.0;
              u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
              u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
              u_xlat16_27 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
              u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
              u_xlat16_27 = u_xlat16_27 * 0.75 + 0.75;
              u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz;
              u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
              vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
              vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
              vs_TEXCOORD0 = u_xlat26;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          in mediump float vs_TEXCOORD0;
          in mediump vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat16_0 = vs_TEXCOORD0;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
          #else
              u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
          #endif
              u_xlat16_1.xyz = vec3(vs_TEXCOORD1.x + (-vs_TEXCOORD2.x), vs_TEXCOORD1.y + (-vs_TEXCOORD2.y), vs_TEXCOORD1.z + (-vs_TEXCOORD2.z));
              SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "_SUNDISK_NONE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	mediump float _Exposure;
          uniform 	mediump vec3 _GroundColor;
          uniform 	mediump vec3 _SkyTint;
          uniform 	mediump float _AtmosphereThickness;
          in highp vec4 in_POSITION0;
          out mediump float vs_TEXCOORD0;
          out mediump vec3 vs_TEXCOORD1;
          out mediump vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          mediump vec3 u_xlat16_0;
          bool u_xlatb0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          mediump vec3 u_xlat16_4;
          vec4 u_xlat5;
          vec3 u_xlat6;
          mediump vec3 u_xlat16_7;
          float u_xlat8;
          vec3 u_xlat13;
          float u_xlat16;
          float u_xlat21;
          float u_xlat24;
          float u_xlat25;
          float u_xlat26;
          mediump float u_xlat16_27;
          float u_xlat28;
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
              u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
              u_xlat16_3.x = log2(_AtmosphereThickness);
              u_xlat16_3.x = u_xlat16_3.x * 2.5;
              u_xlat16_3.x = exp2(u_xlat16_3.x);
              u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
              u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat24 = inversesqrt(u_xlat24);
              u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlat2.y>=0.0);
          #else
              u_xlatb0 = u_xlat2.y>=0.0;
          #endif
              if(u_xlatb0){
                  u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat0.x = (-u_xlat0.y) * u_xlat24 + u_xlat0.x;
                  u_xlat8 = (-u_xlat0.y) * u_xlat24 + 1.0;
                  u_xlat16 = u_xlat8 * 5.25 + -6.80000019;
                  u_xlat16 = u_xlat8 * u_xlat16 + 3.82999992;
                  u_xlat16 = u_xlat8 * u_xlat16 + 0.458999991;
                  u_xlat8 = u_xlat8 * u_xlat16 + -0.00286999997;
                  u_xlat8 = u_xlat8 * 1.44269502;
                  u_xlat0.y = exp2(u_xlat8);
                  u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
                  u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
                  u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat24 = sqrt(u_xlat24);
                  u_xlat25 = (-u_xlat24) + 1.0;
                  u_xlat25 = u_xlat25 * 230.831207;
                  u_xlat25 = exp2(u_xlat25);
                  u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat26 = u_xlat26 / u_xlat24;
                  u_xlat28 = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat24 = u_xlat28 / u_xlat24;
                  u_xlat26 = (-u_xlat26) + 1.0;
                  u_xlat28 = u_xlat26 * 5.25 + -6.80000019;
                  u_xlat28 = u_xlat26 * u_xlat28 + 3.82999992;
                  u_xlat28 = u_xlat26 * u_xlat28 + 0.458999991;
                  u_xlat26 = u_xlat26 * u_xlat28 + -0.00286999997;
                  u_xlat26 = u_xlat26 * 1.44269502;
                  u_xlat26 = exp2(u_xlat26);
                  u_xlat24 = (-u_xlat24) + 1.0;
                  u_xlat28 = u_xlat24 * 5.25 + -6.80000019;
                  u_xlat28 = u_xlat24 * u_xlat28 + 3.82999992;
                  u_xlat28 = u_xlat24 * u_xlat28 + 0.458999991;
                  u_xlat24 = u_xlat24 * u_xlat28 + -0.00286999997;
                  u_xlat24 = u_xlat24 * 1.44269502;
                  u_xlat24 = exp2(u_xlat24);
                  u_xlat24 = u_xlat24 * 0.25;
                  u_xlat24 = u_xlat26 * 0.25 + (-u_xlat24);
                  u_xlat24 = u_xlat25 * u_xlat24 + u_xlat0.y;
                  u_xlat24 = max(u_xlat24, 0.0);
                  u_xlat24 = min(u_xlat24, 50.0);
                  u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat6.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat6.xyz = exp2(u_xlat6.xyz);
                  u_xlat24 = u_xlat0.z * u_xlat25;
                  u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
                  u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat25 = (-u_xlat0.x) + 1.0;
                  u_xlat25 = u_xlat25 * 230.831207;
                  u_xlat25 = exp2(u_xlat25);
                  u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat26 = u_xlat26 / u_xlat0.x;
                  u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat0.x = u_xlat4.x / u_xlat0.x;
                  u_xlat26 = (-u_xlat26) + 1.0;
                  u_xlat4.x = u_xlat26 * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat26 * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat26 * u_xlat4.x + 0.458999991;
                  u_xlat26 = u_xlat26 * u_xlat4.x + -0.00286999997;
                  u_xlat26 = u_xlat26 * 1.44269502;
                  u_xlat26 = exp2(u_xlat26);
                  u_xlat0.x = (-u_xlat0.x) + 1.0;
                  u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
                  u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
                  u_xlat0.x = u_xlat0.x * 1.44269502;
                  u_xlat0.x = exp2(u_xlat0.x);
                  u_xlat0.x = u_xlat0.x * 0.25;
                  u_xlat0.x = u_xlat26 * 0.25 + (-u_xlat0.x);
                  u_xlat0.x = u_xlat25 * u_xlat0.x + u_xlat0.y;
                  u_xlat0.x = max(u_xlat0.x, 0.0);
                  u_xlat0.x = min(u_xlat0.x, 50.0);
                  u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
                  u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat4.xyz = exp2(u_xlat4.xyz);
                  u_xlat0.x = u_xlat0.z * u_xlat25;
                  u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat24) + u_xlat0.xyz;
                  u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
                  u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              } else {
                  u_xlat26 = min(u_xlat2.y, -0.00100000005);
                  u_xlat26 = -9.99999975e-05 / u_xlat26;
                  u_xlat5.xyz = vec3(u_xlat26) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
                  u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
                  u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
                  u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
                  u_xlat21 = u_xlat5.y * 5.25 + -6.80000019;
                  u_xlat21 = u_xlat5.y * u_xlat21 + 3.82999992;
                  u_xlat21 = u_xlat5.y * u_xlat21 + 0.458999991;
                  u_xlat13.x = u_xlat5.y * u_xlat21 + -0.00286999997;
                  u_xlat13.x = u_xlat13.x * 1.44269502;
                  u_xlat5.y = exp2(u_xlat13.x);
                  u_xlat21 = u_xlat5.x * 5.25 + -6.80000019;
                  u_xlat21 = u_xlat5.x * u_xlat21 + 3.82999992;
                  u_xlat21 = u_xlat5.x * u_xlat21 + 0.458999991;
                  u_xlat5.x = u_xlat5.x * u_xlat21 + -0.00286999997;
                  u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
                  u_xlat5.x = exp2(u_xlat5.x);
                  u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
                  u_xlat13.xz = vec2(u_xlat26) * vec2(0.5, 20.0);
                  u_xlat6.xyz = u_xlat2.xyz * u_xlat13.xxx;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat26 = dot(u_xlat6.xyz, u_xlat6.xyz);
                  u_xlat26 = sqrt(u_xlat26);
                  u_xlat26 = (-u_xlat26) + 1.0;
                  u_xlat26 = u_xlat26 * 230.831207;
                  u_xlat26 = exp2(u_xlat26);
                  u_xlat5.x = u_xlat26 * u_xlat5.x + (-u_xlat5.z);
                  u_xlat5.x = max(u_xlat5.x, 0.0);
                  u_xlat5.x = min(u_xlat5.x, 50.0);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
                  u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat0.xyz = exp2(u_xlat5.xyz);
                  u_xlat26 = u_xlat13.z * u_xlat26;
                  u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat26);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              //ENDIF
              }
              u_xlat26 = u_xlat2.y * -50.0;
              u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
              u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
              u_xlat16_27 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
              u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
              u_xlat16_27 = u_xlat16_27 * 0.75 + 0.75;
              u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz;
              u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
              vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
              vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
              vs_TEXCOORD0 = u_xlat26;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          in mediump float vs_TEXCOORD0;
          in mediump vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat16_0 = vs_TEXCOORD0;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
          #else
              u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
          #endif
              u_xlat16_1.xyz = vec3(vs_TEXCOORD1.x + (-vs_TEXCOORD2.x), vs_TEXCOORD1.y + (-vs_TEXCOORD2.y), vs_TEXCOORD1.z + (-vs_TEXCOORD2.z));
              SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "_SUNDISK_NONE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	mediump float _Exposure;
          uniform 	mediump vec3 _GroundColor;
          uniform 	mediump vec3 _SkyTint;
          uniform 	mediump float _AtmosphereThickness;
          in highp vec4 in_POSITION0;
          out mediump float vs_TEXCOORD0;
          out mediump vec3 vs_TEXCOORD1;
          out mediump vec3 vs_TEXCOORD2;
          vec4 u_xlat0;
          mediump vec3 u_xlat16_0;
          bool u_xlatb0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          mediump vec3 u_xlat16_4;
          vec4 u_xlat5;
          vec3 u_xlat6;
          mediump vec3 u_xlat16_7;
          float u_xlat8;
          vec3 u_xlat13;
          float u_xlat16;
          float u_xlat21;
          float u_xlat24;
          float u_xlat25;
          float u_xlat26;
          mediump float u_xlat16_27;
          float u_xlat28;
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
              u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
              u_xlat16_3.x = log2(_AtmosphereThickness);
              u_xlat16_3.x = u_xlat16_3.x * 2.5;
              u_xlat16_3.x = exp2(u_xlat16_3.x);
              u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
              u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat24 = inversesqrt(u_xlat24);
              u_xlat2.xyz = vec3(u_xlat24) * u_xlat0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlat2.y>=0.0);
          #else
              u_xlatb0 = u_xlat2.y>=0.0;
          #endif
              if(u_xlatb0){
                  u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat0.x = (-u_xlat0.y) * u_xlat24 + u_xlat0.x;
                  u_xlat8 = (-u_xlat0.y) * u_xlat24 + 1.0;
                  u_xlat16 = u_xlat8 * 5.25 + -6.80000019;
                  u_xlat16 = u_xlat8 * u_xlat16 + 3.82999992;
                  u_xlat16 = u_xlat8 * u_xlat16 + 0.458999991;
                  u_xlat8 = u_xlat8 * u_xlat16 + -0.00286999997;
                  u_xlat8 = u_xlat8 * 1.44269502;
                  u_xlat0.y = exp2(u_xlat8);
                  u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
                  u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
                  u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat24 = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat24 = sqrt(u_xlat24);
                  u_xlat25 = (-u_xlat24) + 1.0;
                  u_xlat25 = u_xlat25 * 230.831207;
                  u_xlat25 = exp2(u_xlat25);
                  u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat26 = u_xlat26 / u_xlat24;
                  u_xlat28 = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat24 = u_xlat28 / u_xlat24;
                  u_xlat26 = (-u_xlat26) + 1.0;
                  u_xlat28 = u_xlat26 * 5.25 + -6.80000019;
                  u_xlat28 = u_xlat26 * u_xlat28 + 3.82999992;
                  u_xlat28 = u_xlat26 * u_xlat28 + 0.458999991;
                  u_xlat26 = u_xlat26 * u_xlat28 + -0.00286999997;
                  u_xlat26 = u_xlat26 * 1.44269502;
                  u_xlat26 = exp2(u_xlat26);
                  u_xlat24 = (-u_xlat24) + 1.0;
                  u_xlat28 = u_xlat24 * 5.25 + -6.80000019;
                  u_xlat28 = u_xlat24 * u_xlat28 + 3.82999992;
                  u_xlat28 = u_xlat24 * u_xlat28 + 0.458999991;
                  u_xlat24 = u_xlat24 * u_xlat28 + -0.00286999997;
                  u_xlat24 = u_xlat24 * 1.44269502;
                  u_xlat24 = exp2(u_xlat24);
                  u_xlat24 = u_xlat24 * 0.25;
                  u_xlat24 = u_xlat26 * 0.25 + (-u_xlat24);
                  u_xlat24 = u_xlat25 * u_xlat24 + u_xlat0.y;
                  u_xlat24 = max(u_xlat24, 0.0);
                  u_xlat24 = min(u_xlat24, 50.0);
                  u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat6.xyz = (-vec3(u_xlat24)) * u_xlat5.xyz;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat6.xyz = exp2(u_xlat6.xyz);
                  u_xlat24 = u_xlat0.z * u_xlat25;
                  u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
                  u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat25 = (-u_xlat0.x) + 1.0;
                  u_xlat25 = u_xlat25 * 230.831207;
                  u_xlat25 = exp2(u_xlat25);
                  u_xlat26 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat26 = u_xlat26 / u_xlat0.x;
                  u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat0.x = u_xlat4.x / u_xlat0.x;
                  u_xlat26 = (-u_xlat26) + 1.0;
                  u_xlat4.x = u_xlat26 * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat26 * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat26 * u_xlat4.x + 0.458999991;
                  u_xlat26 = u_xlat26 * u_xlat4.x + -0.00286999997;
                  u_xlat26 = u_xlat26 * 1.44269502;
                  u_xlat26 = exp2(u_xlat26);
                  u_xlat0.x = (-u_xlat0.x) + 1.0;
                  u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
                  u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
                  u_xlat0.x = u_xlat0.x * 1.44269502;
                  u_xlat0.x = exp2(u_xlat0.x);
                  u_xlat0.x = u_xlat0.x * 0.25;
                  u_xlat0.x = u_xlat26 * 0.25 + (-u_xlat0.x);
                  u_xlat0.x = u_xlat25 * u_xlat0.x + u_xlat0.y;
                  u_xlat0.x = max(u_xlat0.x, 0.0);
                  u_xlat0.x = min(u_xlat0.x, 50.0);
                  u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
                  u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat4.xyz = exp2(u_xlat4.xyz);
                  u_xlat0.x = u_xlat0.z * u_xlat25;
                  u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat24) + u_xlat0.xyz;
                  u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
                  u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              } else {
                  u_xlat26 = min(u_xlat2.y, -0.00100000005);
                  u_xlat26 = -9.99999975e-05 / u_xlat26;
                  u_xlat5.xyz = vec3(u_xlat26) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
                  u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
                  u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
                  u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
                  u_xlat21 = u_xlat5.y * 5.25 + -6.80000019;
                  u_xlat21 = u_xlat5.y * u_xlat21 + 3.82999992;
                  u_xlat21 = u_xlat5.y * u_xlat21 + 0.458999991;
                  u_xlat13.x = u_xlat5.y * u_xlat21 + -0.00286999997;
                  u_xlat13.x = u_xlat13.x * 1.44269502;
                  u_xlat5.y = exp2(u_xlat13.x);
                  u_xlat21 = u_xlat5.x * 5.25 + -6.80000019;
                  u_xlat21 = u_xlat5.x * u_xlat21 + 3.82999992;
                  u_xlat21 = u_xlat5.x * u_xlat21 + 0.458999991;
                  u_xlat5.x = u_xlat5.x * u_xlat21 + -0.00286999997;
                  u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
                  u_xlat5.x = exp2(u_xlat5.x);
                  u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
                  u_xlat13.xz = vec2(u_xlat26) * vec2(0.5, 20.0);
                  u_xlat6.xyz = u_xlat2.xyz * u_xlat13.xxx;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat26 = dot(u_xlat6.xyz, u_xlat6.xyz);
                  u_xlat26 = sqrt(u_xlat26);
                  u_xlat26 = (-u_xlat26) + 1.0;
                  u_xlat26 = u_xlat26 * 230.831207;
                  u_xlat26 = exp2(u_xlat26);
                  u_xlat5.x = u_xlat26 * u_xlat5.x + (-u_xlat5.z);
                  u_xlat5.x = max(u_xlat5.x, 0.0);
                  u_xlat5.x = min(u_xlat5.x, 50.0);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
                  u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat0.xyz = exp2(u_xlat5.xyz);
                  u_xlat26 = u_xlat13.z * u_xlat26;
                  u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat26);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              //ENDIF
              }
              u_xlat26 = u_xlat2.y * -50.0;
              u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
              u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
              u_xlat16_27 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
              u_xlat16_27 = u_xlat16_27 * u_xlat16_27;
              u_xlat16_27 = u_xlat16_27 * 0.75 + 0.75;
              u_xlat16_7.xyz = vec3(u_xlat16_27) * u_xlat16_4.xyz;
              u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
              vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
              vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
              vs_TEXCOORD0 = u_xlat26;
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          in mediump float vs_TEXCOORD0;
          in mediump vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD2;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump float u_xlat16_0;
          mediump vec3 u_xlat16_1;
          void main()
          {
              u_xlat16_0 = vs_TEXCOORD0;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_0 = min(max(u_xlat16_0, 0.0), 1.0);
          #else
              u_xlat16_0 = clamp(u_xlat16_0, 0.0, 1.0);
          #endif
              u_xlat16_1.xyz = vec3(vs_TEXCOORD1.x + (-vs_TEXCOORD2.x), vs_TEXCOORD1.y + (-vs_TEXCOORD2.y), vs_TEXCOORD1.z + (-vs_TEXCOORD2.z));
              SV_Target0.xyz = vec3(u_xlat16_0) * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "_SUNDISK_SIMPLE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform lowp vec4 _LightColor0;
          uniform mediump float _Exposure;
          uniform mediump vec3 _GroundColor;
          uniform mediump vec3 _SkyTint;
          uniform mediump float _AtmosphereThickness;
          varying mediump vec3 xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump float lightColorIntensity_1;
            mediump vec3 cOut_2;
            mediump vec3 cIn_3;
            highp float far_4;
            highp float kKr4PI_5;
            highp float kKrESun_6;
            highp vec3 kSkyTintInGammaSpace_7;
            mediump vec3 tmpvar_8;
            mediump vec3 tmpvar_9;
            mediump vec3 tmpvar_10;
            mediump vec3 tmpvar_11;
            highp vec4 tmpvar_12;
            highp vec4 tmpvar_13;
            tmpvar_13.w = 1.0;
            tmpvar_13.xyz = _glesVertex.xyz;
            tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
            kSkyTintInGammaSpace_7 = _SkyTint;
            highp vec3 tmpvar_14;
            tmpvar_14 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
              (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_7)
            ), vec3(4.0, 4.0, 4.0))));
            mediump float tmpvar_15;
            mediump float tmpvar_16;
            tmpvar_16 = pow (_AtmosphereThickness, 2.5);
            tmpvar_15 = (0.05 * tmpvar_16);
            kKrESun_6 = tmpvar_15;
            mediump float tmpvar_17;
            tmpvar_17 = (0.03141593 * tmpvar_16);
            kKr4PI_5 = tmpvar_17;
            highp mat3 tmpvar_18;
            tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
            tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
            tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
            highp vec3 tmpvar_19;
            tmpvar_19 = normalize((tmpvar_18 * _glesVertex.xyz));
            far_4 = 0.0;
            if ((tmpvar_19.y >= 0.0)) {
              highp vec3 frontColor_20;
              highp vec3 samplePoint_21;
              far_4 = (sqrt((
                (1.050625 + (tmpvar_19.y * tmpvar_19.y))
               - 1.0)) - tmpvar_19.y);
              highp float tmpvar_22;
              tmpvar_22 = (1.0 - (dot (tmpvar_19, vec3(0.0, 1.0001, 0.0)) / 1.0001));
              highp float tmpvar_23;
              tmpvar_23 = (exp((-0.00287 + 
                (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
                  (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
                ))))
              )) * 0.2460318);
              highp float tmpvar_24;
              tmpvar_24 = (far_4 / 2.0);
              highp float tmpvar_25;
              tmpvar_25 = (tmpvar_24 * 40.00004);
              highp vec3 tmpvar_26;
              tmpvar_26 = (tmpvar_19 * tmpvar_24);
              highp vec3 tmpvar_27;
              tmpvar_27 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_26 * 0.5));
              highp float tmpvar_28;
              tmpvar_28 = sqrt(dot (tmpvar_27, tmpvar_27));
              highp float tmpvar_29;
              tmpvar_29 = exp((160.0002 * (1.0 - tmpvar_28)));
              highp float tmpvar_30;
              tmpvar_30 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_27) / tmpvar_28));
              highp float tmpvar_31;
              tmpvar_31 = (1.0 - (dot (tmpvar_19, tmpvar_27) / tmpvar_28));
              frontColor_20 = (exp((
                -(clamp ((tmpvar_23 + (tmpvar_29 * 
                  ((0.25 * exp((-0.00287 + 
                    (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
                      (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
                    ))))
                  ))) - (0.25 * exp((-0.00287 + 
                    (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
                      (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
                    ))))
                  ))))
                )), 0.0, 50.0))
               * 
                ((tmpvar_14 * kKr4PI_5) + 0.01256637)
              )) * (tmpvar_29 * tmpvar_25));
              samplePoint_21 = (tmpvar_27 + tmpvar_26);
              highp float tmpvar_32;
              tmpvar_32 = sqrt(dot (samplePoint_21, samplePoint_21));
              highp float tmpvar_33;
              tmpvar_33 = exp((160.0002 * (1.0 - tmpvar_32)));
              highp float tmpvar_34;
              tmpvar_34 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_21) / tmpvar_32));
              highp float tmpvar_35;
              tmpvar_35 = (1.0 - (dot (tmpvar_19, samplePoint_21) / tmpvar_32));
              frontColor_20 = (frontColor_20 + (exp(
                (-(clamp ((tmpvar_23 + 
                  (tmpvar_33 * ((0.25 * exp(
                    (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
                      (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
                    ))))
                  )) - (0.25 * exp(
                    (-0.00287 + (tmpvar_35 * (0.459 + (tmpvar_35 * 
                      (3.83 + (tmpvar_35 * (-6.8 + (tmpvar_35 * 5.25))))
                    ))))
                  ))))
                ), 0.0, 50.0)) * ((tmpvar_14 * kKr4PI_5) + 0.01256637))
              ) * (tmpvar_33 * tmpvar_25)));
              samplePoint_21 = (samplePoint_21 + tmpvar_26);
              cIn_3 = (frontColor_20 * (tmpvar_14 * kKrESun_6));
              cOut_2 = (frontColor_20 * 0.02);
            } else {
              highp vec3 frontColor_1_36;
              far_4 = (-0.0001 / min (-0.001, tmpvar_19.y));
              highp vec3 tmpvar_37;
              tmpvar_37 = (vec3(0.0, 1.0001, 0.0) + (far_4 * tmpvar_19));
              highp float tmpvar_38;
              highp float tmpvar_39;
              tmpvar_39 = (1.0 - dot (-(tmpvar_19), tmpvar_37));
              tmpvar_38 = (0.25 * exp((-0.00287 + 
                (tmpvar_39 * (0.459 + (tmpvar_39 * (3.83 + 
                  (tmpvar_39 * (-6.8 + (tmpvar_39 * 5.25)))
                ))))
              )));
              highp float tmpvar_40;
              tmpvar_40 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_37));
              highp float tmpvar_41;
              tmpvar_41 = (far_4 / 2.0);
              highp vec3 tmpvar_42;
              tmpvar_42 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_19 * tmpvar_41) * 0.5));
              highp float tmpvar_43;
              tmpvar_43 = exp((160.0002 * (1.0 - 
                sqrt(dot (tmpvar_42, tmpvar_42))
              )));
              highp vec3 tmpvar_44;
              tmpvar_44 = exp((-(
                clamp (((tmpvar_43 * (
                  (0.25 * exp((-0.00287 + (tmpvar_40 * 
                    (0.459 + (tmpvar_40 * (3.83 + (tmpvar_40 * 
                      (-6.8 + (tmpvar_40 * 5.25))
                    ))))
                  ))))
                 + tmpvar_38)) - (0.9996001 * tmpvar_38)), 0.0, 50.0)
              ) * (
                (tmpvar_14 * kKr4PI_5)
               + 0.01256637)));
              frontColor_1_36 = (tmpvar_44 * (tmpvar_43 * (tmpvar_41 * 40.00004)));
              cIn_3 = (frontColor_1_36 * ((tmpvar_14 * kKrESun_6) + 0.02));
              highp vec3 tmpvar_45;
              tmpvar_45 = clamp (tmpvar_44, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
              cOut_2 = tmpvar_45;
            };
            tmpvar_8 = -(tmpvar_19);
            tmpvar_9 = (_Exposure * (cIn_3 + (
              (_GroundColor * _GroundColor)
             * cOut_2)));
            mediump vec3 light_46;
            light_46 = _WorldSpaceLightPos0.xyz;
            mediump vec3 ray_47;
            ray_47 = -(tmpvar_19);
            mediump float tmpvar_48;
            tmpvar_48 = dot (light_46, ray_47);
            tmpvar_10 = (_Exposure * (cIn_3 * (0.75 + 
              (0.75 * (tmpvar_48 * tmpvar_48))
            )));
            lowp float tmpvar_49;
            tmpvar_49 = clamp (sqrt(dot (_LightColor0.xyz, _LightColor0.xyz)), 0.25, 1.0);
            lightColorIntensity_1 = tmpvar_49;
            tmpvar_11 = (((27.0 * 
              clamp ((cOut_2 * 8000.0), 0.0, 1.0)
            ) * _LightColor0.xyz) / lightColorIntensity_1);
            mediump vec3 tmpvar_50;
            tmpvar_50 = sqrt(tmpvar_9);
            tmpvar_9 = tmpvar_50;
            mediump vec3 tmpvar_51;
            tmpvar_51 = sqrt(tmpvar_10);
            tmpvar_10 = tmpvar_51;
            mediump vec3 tmpvar_52;
            tmpvar_52 = sqrt(tmpvar_11);
            tmpvar_11 = tmpvar_52;
            gl_Position = tmpvar_12;
            xlv_TEXCOORD0 = tmpvar_8;
            xlv_TEXCOORD1 = tmpvar_50;
            xlv_TEXCOORD2 = tmpvar_51;
            xlv_TEXCOORD3 = tmpvar_52;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform mediump float _SunSize;
          varying mediump vec3 xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 col_1;
            mediump float tmpvar_2;
            tmpvar_2 = (xlv_TEXCOORD0.y / 0.02);
            mediump vec3 tmpvar_3;
            tmpvar_3 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_2, 0.0, 1.0)));
            col_1 = tmpvar_3;
            if ((tmpvar_2 < 0.0)) {
              mediump vec3 lightPos_4;
              lightPos_4 = _WorldSpaceLightPos0.xyz;
              mediump vec3 tmpvar_5;
              tmpvar_5 = (lightPos_4 - -(xlv_TEXCOORD0));
              mediump float tmpvar_6;
              tmpvar_6 = clamp ((sqrt(
                dot (tmpvar_5, tmpvar_5)
              ) / _SunSize), 0.0, 1.0);
              mediump float tmpvar_7;
              tmpvar_7 = (1.0 - (tmpvar_6 * (tmpvar_6 * 
                (3.0 - (2.0 * tmpvar_6))
              )));
              col_1 = (tmpvar_3 + (xlv_TEXCOORD3 * (tmpvar_7 * tmpvar_7)));
            };
            mediump vec4 tmpvar_8;
            tmpvar_8.w = 1.0;
            tmpvar_8.xyz = col_1;
            gl_FragData[0] = tmpvar_8;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "_SUNDISK_SIMPLE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform lowp vec4 _LightColor0;
          uniform mediump float _Exposure;
          uniform mediump vec3 _GroundColor;
          uniform mediump vec3 _SkyTint;
          uniform mediump float _AtmosphereThickness;
          varying mediump vec3 xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump float lightColorIntensity_1;
            mediump vec3 cOut_2;
            mediump vec3 cIn_3;
            highp float far_4;
            highp float kKr4PI_5;
            highp float kKrESun_6;
            highp vec3 kSkyTintInGammaSpace_7;
            mediump vec3 tmpvar_8;
            mediump vec3 tmpvar_9;
            mediump vec3 tmpvar_10;
            mediump vec3 tmpvar_11;
            highp vec4 tmpvar_12;
            highp vec4 tmpvar_13;
            tmpvar_13.w = 1.0;
            tmpvar_13.xyz = _glesVertex.xyz;
            tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
            kSkyTintInGammaSpace_7 = _SkyTint;
            highp vec3 tmpvar_14;
            tmpvar_14 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
              (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_7)
            ), vec3(4.0, 4.0, 4.0))));
            mediump float tmpvar_15;
            mediump float tmpvar_16;
            tmpvar_16 = pow (_AtmosphereThickness, 2.5);
            tmpvar_15 = (0.05 * tmpvar_16);
            kKrESun_6 = tmpvar_15;
            mediump float tmpvar_17;
            tmpvar_17 = (0.03141593 * tmpvar_16);
            kKr4PI_5 = tmpvar_17;
            highp mat3 tmpvar_18;
            tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
            tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
            tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
            highp vec3 tmpvar_19;
            tmpvar_19 = normalize((tmpvar_18 * _glesVertex.xyz));
            far_4 = 0.0;
            if ((tmpvar_19.y >= 0.0)) {
              highp vec3 frontColor_20;
              highp vec3 samplePoint_21;
              far_4 = (sqrt((
                (1.050625 + (tmpvar_19.y * tmpvar_19.y))
               - 1.0)) - tmpvar_19.y);
              highp float tmpvar_22;
              tmpvar_22 = (1.0 - (dot (tmpvar_19, vec3(0.0, 1.0001, 0.0)) / 1.0001));
              highp float tmpvar_23;
              tmpvar_23 = (exp((-0.00287 + 
                (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
                  (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
                ))))
              )) * 0.2460318);
              highp float tmpvar_24;
              tmpvar_24 = (far_4 / 2.0);
              highp float tmpvar_25;
              tmpvar_25 = (tmpvar_24 * 40.00004);
              highp vec3 tmpvar_26;
              tmpvar_26 = (tmpvar_19 * tmpvar_24);
              highp vec3 tmpvar_27;
              tmpvar_27 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_26 * 0.5));
              highp float tmpvar_28;
              tmpvar_28 = sqrt(dot (tmpvar_27, tmpvar_27));
              highp float tmpvar_29;
              tmpvar_29 = exp((160.0002 * (1.0 - tmpvar_28)));
              highp float tmpvar_30;
              tmpvar_30 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_27) / tmpvar_28));
              highp float tmpvar_31;
              tmpvar_31 = (1.0 - (dot (tmpvar_19, tmpvar_27) / tmpvar_28));
              frontColor_20 = (exp((
                -(clamp ((tmpvar_23 + (tmpvar_29 * 
                  ((0.25 * exp((-0.00287 + 
                    (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
                      (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
                    ))))
                  ))) - (0.25 * exp((-0.00287 + 
                    (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
                      (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
                    ))))
                  ))))
                )), 0.0, 50.0))
               * 
                ((tmpvar_14 * kKr4PI_5) + 0.01256637)
              )) * (tmpvar_29 * tmpvar_25));
              samplePoint_21 = (tmpvar_27 + tmpvar_26);
              highp float tmpvar_32;
              tmpvar_32 = sqrt(dot (samplePoint_21, samplePoint_21));
              highp float tmpvar_33;
              tmpvar_33 = exp((160.0002 * (1.0 - tmpvar_32)));
              highp float tmpvar_34;
              tmpvar_34 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_21) / tmpvar_32));
              highp float tmpvar_35;
              tmpvar_35 = (1.0 - (dot (tmpvar_19, samplePoint_21) / tmpvar_32));
              frontColor_20 = (frontColor_20 + (exp(
                (-(clamp ((tmpvar_23 + 
                  (tmpvar_33 * ((0.25 * exp(
                    (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
                      (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
                    ))))
                  )) - (0.25 * exp(
                    (-0.00287 + (tmpvar_35 * (0.459 + (tmpvar_35 * 
                      (3.83 + (tmpvar_35 * (-6.8 + (tmpvar_35 * 5.25))))
                    ))))
                  ))))
                ), 0.0, 50.0)) * ((tmpvar_14 * kKr4PI_5) + 0.01256637))
              ) * (tmpvar_33 * tmpvar_25)));
              samplePoint_21 = (samplePoint_21 + tmpvar_26);
              cIn_3 = (frontColor_20 * (tmpvar_14 * kKrESun_6));
              cOut_2 = (frontColor_20 * 0.02);
            } else {
              highp vec3 frontColor_1_36;
              far_4 = (-0.0001 / min (-0.001, tmpvar_19.y));
              highp vec3 tmpvar_37;
              tmpvar_37 = (vec3(0.0, 1.0001, 0.0) + (far_4 * tmpvar_19));
              highp float tmpvar_38;
              highp float tmpvar_39;
              tmpvar_39 = (1.0 - dot (-(tmpvar_19), tmpvar_37));
              tmpvar_38 = (0.25 * exp((-0.00287 + 
                (tmpvar_39 * (0.459 + (tmpvar_39 * (3.83 + 
                  (tmpvar_39 * (-6.8 + (tmpvar_39 * 5.25)))
                ))))
              )));
              highp float tmpvar_40;
              tmpvar_40 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_37));
              highp float tmpvar_41;
              tmpvar_41 = (far_4 / 2.0);
              highp vec3 tmpvar_42;
              tmpvar_42 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_19 * tmpvar_41) * 0.5));
              highp float tmpvar_43;
              tmpvar_43 = exp((160.0002 * (1.0 - 
                sqrt(dot (tmpvar_42, tmpvar_42))
              )));
              highp vec3 tmpvar_44;
              tmpvar_44 = exp((-(
                clamp (((tmpvar_43 * (
                  (0.25 * exp((-0.00287 + (tmpvar_40 * 
                    (0.459 + (tmpvar_40 * (3.83 + (tmpvar_40 * 
                      (-6.8 + (tmpvar_40 * 5.25))
                    ))))
                  ))))
                 + tmpvar_38)) - (0.9996001 * tmpvar_38)), 0.0, 50.0)
              ) * (
                (tmpvar_14 * kKr4PI_5)
               + 0.01256637)));
              frontColor_1_36 = (tmpvar_44 * (tmpvar_43 * (tmpvar_41 * 40.00004)));
              cIn_3 = (frontColor_1_36 * ((tmpvar_14 * kKrESun_6) + 0.02));
              highp vec3 tmpvar_45;
              tmpvar_45 = clamp (tmpvar_44, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
              cOut_2 = tmpvar_45;
            };
            tmpvar_8 = -(tmpvar_19);
            tmpvar_9 = (_Exposure * (cIn_3 + (
              (_GroundColor * _GroundColor)
             * cOut_2)));
            mediump vec3 light_46;
            light_46 = _WorldSpaceLightPos0.xyz;
            mediump vec3 ray_47;
            ray_47 = -(tmpvar_19);
            mediump float tmpvar_48;
            tmpvar_48 = dot (light_46, ray_47);
            tmpvar_10 = (_Exposure * (cIn_3 * (0.75 + 
              (0.75 * (tmpvar_48 * tmpvar_48))
            )));
            lowp float tmpvar_49;
            tmpvar_49 = clamp (sqrt(dot (_LightColor0.xyz, _LightColor0.xyz)), 0.25, 1.0);
            lightColorIntensity_1 = tmpvar_49;
            tmpvar_11 = (((27.0 * 
              clamp ((cOut_2 * 8000.0), 0.0, 1.0)
            ) * _LightColor0.xyz) / lightColorIntensity_1);
            mediump vec3 tmpvar_50;
            tmpvar_50 = sqrt(tmpvar_9);
            tmpvar_9 = tmpvar_50;
            mediump vec3 tmpvar_51;
            tmpvar_51 = sqrt(tmpvar_10);
            tmpvar_10 = tmpvar_51;
            mediump vec3 tmpvar_52;
            tmpvar_52 = sqrt(tmpvar_11);
            tmpvar_11 = tmpvar_52;
            gl_Position = tmpvar_12;
            xlv_TEXCOORD0 = tmpvar_8;
            xlv_TEXCOORD1 = tmpvar_50;
            xlv_TEXCOORD2 = tmpvar_51;
            xlv_TEXCOORD3 = tmpvar_52;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform mediump float _SunSize;
          varying mediump vec3 xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 col_1;
            mediump float tmpvar_2;
            tmpvar_2 = (xlv_TEXCOORD0.y / 0.02);
            mediump vec3 tmpvar_3;
            tmpvar_3 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_2, 0.0, 1.0)));
            col_1 = tmpvar_3;
            if ((tmpvar_2 < 0.0)) {
              mediump vec3 lightPos_4;
              lightPos_4 = _WorldSpaceLightPos0.xyz;
              mediump vec3 tmpvar_5;
              tmpvar_5 = (lightPos_4 - -(xlv_TEXCOORD0));
              mediump float tmpvar_6;
              tmpvar_6 = clamp ((sqrt(
                dot (tmpvar_5, tmpvar_5)
              ) / _SunSize), 0.0, 1.0);
              mediump float tmpvar_7;
              tmpvar_7 = (1.0 - (tmpvar_6 * (tmpvar_6 * 
                (3.0 - (2.0 * tmpvar_6))
              )));
              col_1 = (tmpvar_3 + (xlv_TEXCOORD3 * (tmpvar_7 * tmpvar_7)));
            };
            mediump vec4 tmpvar_8;
            tmpvar_8.w = 1.0;
            tmpvar_8.xyz = col_1;
            gl_FragData[0] = tmpvar_8;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "_SUNDISK_SIMPLE" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform lowp vec4 _LightColor0;
          uniform mediump float _Exposure;
          uniform mediump vec3 _GroundColor;
          uniform mediump vec3 _SkyTint;
          uniform mediump float _AtmosphereThickness;
          varying mediump vec3 xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump float lightColorIntensity_1;
            mediump vec3 cOut_2;
            mediump vec3 cIn_3;
            highp float far_4;
            highp float kKr4PI_5;
            highp float kKrESun_6;
            highp vec3 kSkyTintInGammaSpace_7;
            mediump vec3 tmpvar_8;
            mediump vec3 tmpvar_9;
            mediump vec3 tmpvar_10;
            mediump vec3 tmpvar_11;
            highp vec4 tmpvar_12;
            highp vec4 tmpvar_13;
            tmpvar_13.w = 1.0;
            tmpvar_13.xyz = _glesVertex.xyz;
            tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
            kSkyTintInGammaSpace_7 = _SkyTint;
            highp vec3 tmpvar_14;
            tmpvar_14 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
              (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_7)
            ), vec3(4.0, 4.0, 4.0))));
            mediump float tmpvar_15;
            mediump float tmpvar_16;
            tmpvar_16 = pow (_AtmosphereThickness, 2.5);
            tmpvar_15 = (0.05 * tmpvar_16);
            kKrESun_6 = tmpvar_15;
            mediump float tmpvar_17;
            tmpvar_17 = (0.03141593 * tmpvar_16);
            kKr4PI_5 = tmpvar_17;
            highp mat3 tmpvar_18;
            tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
            tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
            tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
            highp vec3 tmpvar_19;
            tmpvar_19 = normalize((tmpvar_18 * _glesVertex.xyz));
            far_4 = 0.0;
            if ((tmpvar_19.y >= 0.0)) {
              highp vec3 frontColor_20;
              highp vec3 samplePoint_21;
              far_4 = (sqrt((
                (1.050625 + (tmpvar_19.y * tmpvar_19.y))
               - 1.0)) - tmpvar_19.y);
              highp float tmpvar_22;
              tmpvar_22 = (1.0 - (dot (tmpvar_19, vec3(0.0, 1.0001, 0.0)) / 1.0001));
              highp float tmpvar_23;
              tmpvar_23 = (exp((-0.00287 + 
                (tmpvar_22 * (0.459 + (tmpvar_22 * (3.83 + 
                  (tmpvar_22 * (-6.8 + (tmpvar_22 * 5.25)))
                ))))
              )) * 0.2460318);
              highp float tmpvar_24;
              tmpvar_24 = (far_4 / 2.0);
              highp float tmpvar_25;
              tmpvar_25 = (tmpvar_24 * 40.00004);
              highp vec3 tmpvar_26;
              tmpvar_26 = (tmpvar_19 * tmpvar_24);
              highp vec3 tmpvar_27;
              tmpvar_27 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_26 * 0.5));
              highp float tmpvar_28;
              tmpvar_28 = sqrt(dot (tmpvar_27, tmpvar_27));
              highp float tmpvar_29;
              tmpvar_29 = exp((160.0002 * (1.0 - tmpvar_28)));
              highp float tmpvar_30;
              tmpvar_30 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_27) / tmpvar_28));
              highp float tmpvar_31;
              tmpvar_31 = (1.0 - (dot (tmpvar_19, tmpvar_27) / tmpvar_28));
              frontColor_20 = (exp((
                -(clamp ((tmpvar_23 + (tmpvar_29 * 
                  ((0.25 * exp((-0.00287 + 
                    (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
                      (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
                    ))))
                  ))) - (0.25 * exp((-0.00287 + 
                    (tmpvar_31 * (0.459 + (tmpvar_31 * (3.83 + 
                      (tmpvar_31 * (-6.8 + (tmpvar_31 * 5.25)))
                    ))))
                  ))))
                )), 0.0, 50.0))
               * 
                ((tmpvar_14 * kKr4PI_5) + 0.01256637)
              )) * (tmpvar_29 * tmpvar_25));
              samplePoint_21 = (tmpvar_27 + tmpvar_26);
              highp float tmpvar_32;
              tmpvar_32 = sqrt(dot (samplePoint_21, samplePoint_21));
              highp float tmpvar_33;
              tmpvar_33 = exp((160.0002 * (1.0 - tmpvar_32)));
              highp float tmpvar_34;
              tmpvar_34 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_21) / tmpvar_32));
              highp float tmpvar_35;
              tmpvar_35 = (1.0 - (dot (tmpvar_19, samplePoint_21) / tmpvar_32));
              frontColor_20 = (frontColor_20 + (exp(
                (-(clamp ((tmpvar_23 + 
                  (tmpvar_33 * ((0.25 * exp(
                    (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
                      (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
                    ))))
                  )) - (0.25 * exp(
                    (-0.00287 + (tmpvar_35 * (0.459 + (tmpvar_35 * 
                      (3.83 + (tmpvar_35 * (-6.8 + (tmpvar_35 * 5.25))))
                    ))))
                  ))))
                ), 0.0, 50.0)) * ((tmpvar_14 * kKr4PI_5) + 0.01256637))
              ) * (tmpvar_33 * tmpvar_25)));
              samplePoint_21 = (samplePoint_21 + tmpvar_26);
              cIn_3 = (frontColor_20 * (tmpvar_14 * kKrESun_6));
              cOut_2 = (frontColor_20 * 0.02);
            } else {
              highp vec3 frontColor_1_36;
              far_4 = (-0.0001 / min (-0.001, tmpvar_19.y));
              highp vec3 tmpvar_37;
              tmpvar_37 = (vec3(0.0, 1.0001, 0.0) + (far_4 * tmpvar_19));
              highp float tmpvar_38;
              highp float tmpvar_39;
              tmpvar_39 = (1.0 - dot (-(tmpvar_19), tmpvar_37));
              tmpvar_38 = (0.25 * exp((-0.00287 + 
                (tmpvar_39 * (0.459 + (tmpvar_39 * (3.83 + 
                  (tmpvar_39 * (-6.8 + (tmpvar_39 * 5.25)))
                ))))
              )));
              highp float tmpvar_40;
              tmpvar_40 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_37));
              highp float tmpvar_41;
              tmpvar_41 = (far_4 / 2.0);
              highp vec3 tmpvar_42;
              tmpvar_42 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_19 * tmpvar_41) * 0.5));
              highp float tmpvar_43;
              tmpvar_43 = exp((160.0002 * (1.0 - 
                sqrt(dot (tmpvar_42, tmpvar_42))
              )));
              highp vec3 tmpvar_44;
              tmpvar_44 = exp((-(
                clamp (((tmpvar_43 * (
                  (0.25 * exp((-0.00287 + (tmpvar_40 * 
                    (0.459 + (tmpvar_40 * (3.83 + (tmpvar_40 * 
                      (-6.8 + (tmpvar_40 * 5.25))
                    ))))
                  ))))
                 + tmpvar_38)) - (0.9996001 * tmpvar_38)), 0.0, 50.0)
              ) * (
                (tmpvar_14 * kKr4PI_5)
               + 0.01256637)));
              frontColor_1_36 = (tmpvar_44 * (tmpvar_43 * (tmpvar_41 * 40.00004)));
              cIn_3 = (frontColor_1_36 * ((tmpvar_14 * kKrESun_6) + 0.02));
              highp vec3 tmpvar_45;
              tmpvar_45 = clamp (tmpvar_44, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
              cOut_2 = tmpvar_45;
            };
            tmpvar_8 = -(tmpvar_19);
            tmpvar_9 = (_Exposure * (cIn_3 + (
              (_GroundColor * _GroundColor)
             * cOut_2)));
            mediump vec3 light_46;
            light_46 = _WorldSpaceLightPos0.xyz;
            mediump vec3 ray_47;
            ray_47 = -(tmpvar_19);
            mediump float tmpvar_48;
            tmpvar_48 = dot (light_46, ray_47);
            tmpvar_10 = (_Exposure * (cIn_3 * (0.75 + 
              (0.75 * (tmpvar_48 * tmpvar_48))
            )));
            lowp float tmpvar_49;
            tmpvar_49 = clamp (sqrt(dot (_LightColor0.xyz, _LightColor0.xyz)), 0.25, 1.0);
            lightColorIntensity_1 = tmpvar_49;
            tmpvar_11 = (((27.0 * 
              clamp ((cOut_2 * 8000.0), 0.0, 1.0)
            ) * _LightColor0.xyz) / lightColorIntensity_1);
            mediump vec3 tmpvar_50;
            tmpvar_50 = sqrt(tmpvar_9);
            tmpvar_9 = tmpvar_50;
            mediump vec3 tmpvar_51;
            tmpvar_51 = sqrt(tmpvar_10);
            tmpvar_10 = tmpvar_51;
            mediump vec3 tmpvar_52;
            tmpvar_52 = sqrt(tmpvar_11);
            tmpvar_11 = tmpvar_52;
            gl_Position = tmpvar_12;
            xlv_TEXCOORD0 = tmpvar_8;
            xlv_TEXCOORD1 = tmpvar_50;
            xlv_TEXCOORD2 = tmpvar_51;
            xlv_TEXCOORD3 = tmpvar_52;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform mediump float _SunSize;
          varying mediump vec3 xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 col_1;
            mediump float tmpvar_2;
            tmpvar_2 = (xlv_TEXCOORD0.y / 0.02);
            mediump vec3 tmpvar_3;
            tmpvar_3 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_2, 0.0, 1.0)));
            col_1 = tmpvar_3;
            if ((tmpvar_2 < 0.0)) {
              mediump vec3 lightPos_4;
              lightPos_4 = _WorldSpaceLightPos0.xyz;
              mediump vec3 tmpvar_5;
              tmpvar_5 = (lightPos_4 - -(xlv_TEXCOORD0));
              mediump float tmpvar_6;
              tmpvar_6 = clamp ((sqrt(
                dot (tmpvar_5, tmpvar_5)
              ) / _SunSize), 0.0, 1.0);
              mediump float tmpvar_7;
              tmpvar_7 = (1.0 - (tmpvar_6 * (tmpvar_6 * 
                (3.0 - (2.0 * tmpvar_6))
              )));
              col_1 = (tmpvar_3 + (xlv_TEXCOORD3 * (tmpvar_7 * tmpvar_7)));
            };
            mediump vec4 tmpvar_8;
            tmpvar_8.w = 1.0;
            tmpvar_8.xyz = col_1;
            gl_FragData[0] = tmpvar_8;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "_SUNDISK_SIMPLE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec3 _GroundColor;
          uniform 	mediump vec3 _SkyTint;
          uniform 	mediump float _AtmosphereThickness;
          in highp vec4 in_POSITION0;
          out mediump vec3 vs_TEXCOORD0;
          out mediump vec3 vs_TEXCOORD1;
          out mediump vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          mediump vec3 u_xlat16_0;
          bool u_xlatb0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          mediump vec3 u_xlat16_4;
          vec4 u_xlat5;
          vec3 u_xlat6;
          mediump vec3 u_xlat16_7;
          mediump vec3 u_xlat16_8;
          float u_xlat9;
          vec3 u_xlat14;
          float u_xlat18;
          float u_xlat23;
          float u_xlat27;
          float u_xlat28;
          float u_xlat29;
          mediump float u_xlat16_30;
          float u_xlat31;
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
              u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
              u_xlat16_3.x = log2(_AtmosphereThickness);
              u_xlat16_3.x = u_xlat16_3.x * 2.5;
              u_xlat16_3.x = exp2(u_xlat16_3.x);
              u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
              u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat27 = inversesqrt(u_xlat27);
              u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlat2.y>=0.0);
          #else
              u_xlatb0 = u_xlat2.y>=0.0;
          #endif
              if(u_xlatb0){
                  u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat0.x = (-u_xlat0.y) * u_xlat27 + u_xlat0.x;
                  u_xlat9 = (-u_xlat0.y) * u_xlat27 + 1.0;
                  u_xlat18 = u_xlat9 * 5.25 + -6.80000019;
                  u_xlat18 = u_xlat9 * u_xlat18 + 3.82999992;
                  u_xlat18 = u_xlat9 * u_xlat18 + 0.458999991;
                  u_xlat9 = u_xlat9 * u_xlat18 + -0.00286999997;
                  u_xlat9 = u_xlat9 * 1.44269502;
                  u_xlat0.y = exp2(u_xlat9);
                  u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
                  u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
                  u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat27 = sqrt(u_xlat27);
                  u_xlat28 = (-u_xlat27) + 1.0;
                  u_xlat28 = u_xlat28 * 230.831207;
                  u_xlat28 = exp2(u_xlat28);
                  u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat29 = u_xlat29 / u_xlat27;
                  u_xlat31 = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat27 = u_xlat31 / u_xlat27;
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat31 = u_xlat29 * 5.25 + -6.80000019;
                  u_xlat31 = u_xlat29 * u_xlat31 + 3.82999992;
                  u_xlat31 = u_xlat29 * u_xlat31 + 0.458999991;
                  u_xlat29 = u_xlat29 * u_xlat31 + -0.00286999997;
                  u_xlat29 = u_xlat29 * 1.44269502;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat27 = (-u_xlat27) + 1.0;
                  u_xlat31 = u_xlat27 * 5.25 + -6.80000019;
                  u_xlat31 = u_xlat27 * u_xlat31 + 3.82999992;
                  u_xlat31 = u_xlat27 * u_xlat31 + 0.458999991;
                  u_xlat27 = u_xlat27 * u_xlat31 + -0.00286999997;
                  u_xlat27 = u_xlat27 * 1.44269502;
                  u_xlat27 = exp2(u_xlat27);
                  u_xlat27 = u_xlat27 * 0.25;
                  u_xlat27 = u_xlat29 * 0.25 + (-u_xlat27);
                  u_xlat27 = u_xlat28 * u_xlat27 + u_xlat0.y;
                  u_xlat27 = max(u_xlat27, 0.0);
                  u_xlat27 = min(u_xlat27, 50.0);
                  u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat6.xyz = (-vec3(u_xlat27)) * u_xlat5.xyz;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat6.xyz = exp2(u_xlat6.xyz);
                  u_xlat27 = u_xlat0.z * u_xlat28;
                  u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
                  u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat28 = (-u_xlat0.x) + 1.0;
                  u_xlat28 = u_xlat28 * 230.831207;
                  u_xlat28 = exp2(u_xlat28);
                  u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat29 = u_xlat29 / u_xlat0.x;
                  u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat0.x = u_xlat4.x / u_xlat0.x;
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat4.x = u_xlat29 * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat29 * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat29 * u_xlat4.x + 0.458999991;
                  u_xlat29 = u_xlat29 * u_xlat4.x + -0.00286999997;
                  u_xlat29 = u_xlat29 * 1.44269502;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat0.x = (-u_xlat0.x) + 1.0;
                  u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
                  u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
                  u_xlat0.x = u_xlat0.x * 1.44269502;
                  u_xlat0.x = exp2(u_xlat0.x);
                  u_xlat0.x = u_xlat0.x * 0.25;
                  u_xlat0.x = u_xlat29 * 0.25 + (-u_xlat0.x);
                  u_xlat0.x = u_xlat28 * u_xlat0.x + u_xlat0.y;
                  u_xlat0.x = max(u_xlat0.x, 0.0);
                  u_xlat0.x = min(u_xlat0.x, 50.0);
                  u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
                  u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat4.xyz = exp2(u_xlat4.xyz);
                  u_xlat0.x = u_xlat0.z * u_xlat28;
                  u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat27) + u_xlat0.xyz;
                  u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
                  u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              } else {
                  u_xlat29 = min(u_xlat2.y, -0.00100000005);
                  u_xlat29 = -9.99999975e-05 / u_xlat29;
                  u_xlat5.xyz = vec3(u_xlat29) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
                  u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
                  u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
                  u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
                  u_xlat23 = u_xlat5.y * 5.25 + -6.80000019;
                  u_xlat23 = u_xlat5.y * u_xlat23 + 3.82999992;
                  u_xlat23 = u_xlat5.y * u_xlat23 + 0.458999991;
                  u_xlat14.x = u_xlat5.y * u_xlat23 + -0.00286999997;
                  u_xlat14.x = u_xlat14.x * 1.44269502;
                  u_xlat5.y = exp2(u_xlat14.x);
                  u_xlat23 = u_xlat5.x * 5.25 + -6.80000019;
                  u_xlat23 = u_xlat5.x * u_xlat23 + 3.82999992;
                  u_xlat23 = u_xlat5.x * u_xlat23 + 0.458999991;
                  u_xlat5.x = u_xlat5.x * u_xlat23 + -0.00286999997;
                  u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
                  u_xlat5.x = exp2(u_xlat5.x);
                  u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
                  u_xlat14.xz = vec2(u_xlat29) * vec2(0.5, 20.0);
                  u_xlat6.xyz = u_xlat2.xyz * u_xlat14.xxx;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
                  u_xlat29 = sqrt(u_xlat29);
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat29 = u_xlat29 * 230.831207;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat5.x = u_xlat29 * u_xlat5.x + (-u_xlat5.z);
                  u_xlat5.x = max(u_xlat5.x, 0.0);
                  u_xlat5.x = min(u_xlat5.x, 50.0);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
                  u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat0.xyz = exp2(u_xlat5.xyz);
                  u_xlat29 = u_xlat14.z * u_xlat29;
                  u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat29);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              //ENDIF
              }
              u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
              u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
              u_xlat16_30 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
              u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
              u_xlat16_30 = u_xlat16_30 * 0.75 + 0.75;
              u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
              u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
              u_xlat16_30 = dot(_LightColor0.xyz, _LightColor0.xyz);
              u_xlat16_30 = sqrt(u_xlat16_30);
              u_xlat16_30 = max(u_xlat16_30, 0.25);
              u_xlat16_30 = min(u_xlat16_30, 1.0);
              u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(8000.0, 8000.0, 8000.0);
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_8.xyz = min(max(u_xlat16_8.xyz, 0.0), 1.0);
          #else
              u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
          #endif
              u_xlat16_8.xyz = u_xlat16_8.xyz * _LightColor0.xyz;
              u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(27.0, 27.0, 27.0);
              u_xlat16_8.xyz = u_xlat16_8.xyz / vec3(u_xlat16_30);
              vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
              vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
              vs_TEXCOORD3.xyz = sqrt(u_xlat16_8.xyz);
              vs_TEXCOORD0.xyz = (-u_xlat2.xyz);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump float _SunSize;
          in mediump vec3 vs_TEXCOORD0;
          in mediump vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD2;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          mediump vec3 u_xlat16_1;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          void main()
          {
              u_xlat16_0.xyz = vs_TEXCOORD0.xyz + _WorldSpaceLightPos0.xyz;
              u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
              u_xlat16_0.x = sqrt(u_xlat16_0.x);
              u_xlat16_3.x = float(1.0) / _SunSize;
              u_xlat16_0.x = u_xlat16_3.x * u_xlat16_0.x;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
          #else
              u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
          #endif
              u_xlat16_3.x = u_xlat16_0.x * -2.0 + 3.0;
              u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
              u_xlat16_0.x = (-u_xlat16_3.x) * u_xlat16_0.x + 1.0;
              u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
              u_xlat16_3.x = vs_TEXCOORD0.y * 50.0;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
          #else
              u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
          #endif
              u_xlat16_1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
              u_xlat16_1.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(vs_TEXCOORD0.y<0.0);
          #else
              u_xlatb2 = vs_TEXCOORD0.y<0.0;
          #endif
              SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_1.xyz : u_xlat16_3.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "_SUNDISK_SIMPLE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec3 _GroundColor;
          uniform 	mediump vec3 _SkyTint;
          uniform 	mediump float _AtmosphereThickness;
          in highp vec4 in_POSITION0;
          out mediump vec3 vs_TEXCOORD0;
          out mediump vec3 vs_TEXCOORD1;
          out mediump vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          mediump vec3 u_xlat16_0;
          bool u_xlatb0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          mediump vec3 u_xlat16_4;
          vec4 u_xlat5;
          vec3 u_xlat6;
          mediump vec3 u_xlat16_7;
          mediump vec3 u_xlat16_8;
          float u_xlat9;
          vec3 u_xlat14;
          float u_xlat18;
          float u_xlat23;
          float u_xlat27;
          float u_xlat28;
          float u_xlat29;
          mediump float u_xlat16_30;
          float u_xlat31;
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
              u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
              u_xlat16_3.x = log2(_AtmosphereThickness);
              u_xlat16_3.x = u_xlat16_3.x * 2.5;
              u_xlat16_3.x = exp2(u_xlat16_3.x);
              u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
              u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat27 = inversesqrt(u_xlat27);
              u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlat2.y>=0.0);
          #else
              u_xlatb0 = u_xlat2.y>=0.0;
          #endif
              if(u_xlatb0){
                  u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat0.x = (-u_xlat0.y) * u_xlat27 + u_xlat0.x;
                  u_xlat9 = (-u_xlat0.y) * u_xlat27 + 1.0;
                  u_xlat18 = u_xlat9 * 5.25 + -6.80000019;
                  u_xlat18 = u_xlat9 * u_xlat18 + 3.82999992;
                  u_xlat18 = u_xlat9 * u_xlat18 + 0.458999991;
                  u_xlat9 = u_xlat9 * u_xlat18 + -0.00286999997;
                  u_xlat9 = u_xlat9 * 1.44269502;
                  u_xlat0.y = exp2(u_xlat9);
                  u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
                  u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
                  u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat27 = sqrt(u_xlat27);
                  u_xlat28 = (-u_xlat27) + 1.0;
                  u_xlat28 = u_xlat28 * 230.831207;
                  u_xlat28 = exp2(u_xlat28);
                  u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat29 = u_xlat29 / u_xlat27;
                  u_xlat31 = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat27 = u_xlat31 / u_xlat27;
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat31 = u_xlat29 * 5.25 + -6.80000019;
                  u_xlat31 = u_xlat29 * u_xlat31 + 3.82999992;
                  u_xlat31 = u_xlat29 * u_xlat31 + 0.458999991;
                  u_xlat29 = u_xlat29 * u_xlat31 + -0.00286999997;
                  u_xlat29 = u_xlat29 * 1.44269502;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat27 = (-u_xlat27) + 1.0;
                  u_xlat31 = u_xlat27 * 5.25 + -6.80000019;
                  u_xlat31 = u_xlat27 * u_xlat31 + 3.82999992;
                  u_xlat31 = u_xlat27 * u_xlat31 + 0.458999991;
                  u_xlat27 = u_xlat27 * u_xlat31 + -0.00286999997;
                  u_xlat27 = u_xlat27 * 1.44269502;
                  u_xlat27 = exp2(u_xlat27);
                  u_xlat27 = u_xlat27 * 0.25;
                  u_xlat27 = u_xlat29 * 0.25 + (-u_xlat27);
                  u_xlat27 = u_xlat28 * u_xlat27 + u_xlat0.y;
                  u_xlat27 = max(u_xlat27, 0.0);
                  u_xlat27 = min(u_xlat27, 50.0);
                  u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat6.xyz = (-vec3(u_xlat27)) * u_xlat5.xyz;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat6.xyz = exp2(u_xlat6.xyz);
                  u_xlat27 = u_xlat0.z * u_xlat28;
                  u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
                  u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat28 = (-u_xlat0.x) + 1.0;
                  u_xlat28 = u_xlat28 * 230.831207;
                  u_xlat28 = exp2(u_xlat28);
                  u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat29 = u_xlat29 / u_xlat0.x;
                  u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat0.x = u_xlat4.x / u_xlat0.x;
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat4.x = u_xlat29 * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat29 * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat29 * u_xlat4.x + 0.458999991;
                  u_xlat29 = u_xlat29 * u_xlat4.x + -0.00286999997;
                  u_xlat29 = u_xlat29 * 1.44269502;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat0.x = (-u_xlat0.x) + 1.0;
                  u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
                  u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
                  u_xlat0.x = u_xlat0.x * 1.44269502;
                  u_xlat0.x = exp2(u_xlat0.x);
                  u_xlat0.x = u_xlat0.x * 0.25;
                  u_xlat0.x = u_xlat29 * 0.25 + (-u_xlat0.x);
                  u_xlat0.x = u_xlat28 * u_xlat0.x + u_xlat0.y;
                  u_xlat0.x = max(u_xlat0.x, 0.0);
                  u_xlat0.x = min(u_xlat0.x, 50.0);
                  u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
                  u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat4.xyz = exp2(u_xlat4.xyz);
                  u_xlat0.x = u_xlat0.z * u_xlat28;
                  u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat27) + u_xlat0.xyz;
                  u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
                  u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              } else {
                  u_xlat29 = min(u_xlat2.y, -0.00100000005);
                  u_xlat29 = -9.99999975e-05 / u_xlat29;
                  u_xlat5.xyz = vec3(u_xlat29) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
                  u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
                  u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
                  u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
                  u_xlat23 = u_xlat5.y * 5.25 + -6.80000019;
                  u_xlat23 = u_xlat5.y * u_xlat23 + 3.82999992;
                  u_xlat23 = u_xlat5.y * u_xlat23 + 0.458999991;
                  u_xlat14.x = u_xlat5.y * u_xlat23 + -0.00286999997;
                  u_xlat14.x = u_xlat14.x * 1.44269502;
                  u_xlat5.y = exp2(u_xlat14.x);
                  u_xlat23 = u_xlat5.x * 5.25 + -6.80000019;
                  u_xlat23 = u_xlat5.x * u_xlat23 + 3.82999992;
                  u_xlat23 = u_xlat5.x * u_xlat23 + 0.458999991;
                  u_xlat5.x = u_xlat5.x * u_xlat23 + -0.00286999997;
                  u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
                  u_xlat5.x = exp2(u_xlat5.x);
                  u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
                  u_xlat14.xz = vec2(u_xlat29) * vec2(0.5, 20.0);
                  u_xlat6.xyz = u_xlat2.xyz * u_xlat14.xxx;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
                  u_xlat29 = sqrt(u_xlat29);
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat29 = u_xlat29 * 230.831207;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat5.x = u_xlat29 * u_xlat5.x + (-u_xlat5.z);
                  u_xlat5.x = max(u_xlat5.x, 0.0);
                  u_xlat5.x = min(u_xlat5.x, 50.0);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
                  u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat0.xyz = exp2(u_xlat5.xyz);
                  u_xlat29 = u_xlat14.z * u_xlat29;
                  u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat29);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              //ENDIF
              }
              u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
              u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
              u_xlat16_30 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
              u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
              u_xlat16_30 = u_xlat16_30 * 0.75 + 0.75;
              u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
              u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
              u_xlat16_30 = dot(_LightColor0.xyz, _LightColor0.xyz);
              u_xlat16_30 = sqrt(u_xlat16_30);
              u_xlat16_30 = max(u_xlat16_30, 0.25);
              u_xlat16_30 = min(u_xlat16_30, 1.0);
              u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(8000.0, 8000.0, 8000.0);
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_8.xyz = min(max(u_xlat16_8.xyz, 0.0), 1.0);
          #else
              u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
          #endif
              u_xlat16_8.xyz = u_xlat16_8.xyz * _LightColor0.xyz;
              u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(27.0, 27.0, 27.0);
              u_xlat16_8.xyz = u_xlat16_8.xyz / vec3(u_xlat16_30);
              vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
              vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
              vs_TEXCOORD3.xyz = sqrt(u_xlat16_8.xyz);
              vs_TEXCOORD0.xyz = (-u_xlat2.xyz);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump float _SunSize;
          in mediump vec3 vs_TEXCOORD0;
          in mediump vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD2;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          mediump vec3 u_xlat16_1;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          void main()
          {
              u_xlat16_0.xyz = vs_TEXCOORD0.xyz + _WorldSpaceLightPos0.xyz;
              u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
              u_xlat16_0.x = sqrt(u_xlat16_0.x);
              u_xlat16_3.x = float(1.0) / _SunSize;
              u_xlat16_0.x = u_xlat16_3.x * u_xlat16_0.x;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
          #else
              u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
          #endif
              u_xlat16_3.x = u_xlat16_0.x * -2.0 + 3.0;
              u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
              u_xlat16_0.x = (-u_xlat16_3.x) * u_xlat16_0.x + 1.0;
              u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
              u_xlat16_3.x = vs_TEXCOORD0.y * 50.0;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
          #else
              u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
          #endif
              u_xlat16_1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
              u_xlat16_1.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(vs_TEXCOORD0.y<0.0);
          #else
              u_xlatb2 = vs_TEXCOORD0.y<0.0;
          #endif
              SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_1.xyz : u_xlat16_3.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "_SUNDISK_SIMPLE" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec3 _GroundColor;
          uniform 	mediump vec3 _SkyTint;
          uniform 	mediump float _AtmosphereThickness;
          in highp vec4 in_POSITION0;
          out mediump vec3 vs_TEXCOORD0;
          out mediump vec3 vs_TEXCOORD1;
          out mediump vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          mediump vec3 u_xlat16_0;
          bool u_xlatb0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          mediump vec3 u_xlat16_4;
          vec4 u_xlat5;
          vec3 u_xlat6;
          mediump vec3 u_xlat16_7;
          mediump vec3 u_xlat16_8;
          float u_xlat9;
          vec3 u_xlat14;
          float u_xlat18;
          float u_xlat23;
          float u_xlat27;
          float u_xlat28;
          float u_xlat29;
          mediump float u_xlat16_30;
          float u_xlat31;
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
              u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
              u_xlat16_3.x = log2(_AtmosphereThickness);
              u_xlat16_3.x = u_xlat16_3.x * 2.5;
              u_xlat16_3.x = exp2(u_xlat16_3.x);
              u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
              u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat27 = inversesqrt(u_xlat27);
              u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlat2.y>=0.0);
          #else
              u_xlatb0 = u_xlat2.y>=0.0;
          #endif
              if(u_xlatb0){
                  u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat0.x = (-u_xlat0.y) * u_xlat27 + u_xlat0.x;
                  u_xlat9 = (-u_xlat0.y) * u_xlat27 + 1.0;
                  u_xlat18 = u_xlat9 * 5.25 + -6.80000019;
                  u_xlat18 = u_xlat9 * u_xlat18 + 3.82999992;
                  u_xlat18 = u_xlat9 * u_xlat18 + 0.458999991;
                  u_xlat9 = u_xlat9 * u_xlat18 + -0.00286999997;
                  u_xlat9 = u_xlat9 * 1.44269502;
                  u_xlat0.y = exp2(u_xlat9);
                  u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
                  u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
                  u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat27 = sqrt(u_xlat27);
                  u_xlat28 = (-u_xlat27) + 1.0;
                  u_xlat28 = u_xlat28 * 230.831207;
                  u_xlat28 = exp2(u_xlat28);
                  u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat29 = u_xlat29 / u_xlat27;
                  u_xlat31 = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat27 = u_xlat31 / u_xlat27;
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat31 = u_xlat29 * 5.25 + -6.80000019;
                  u_xlat31 = u_xlat29 * u_xlat31 + 3.82999992;
                  u_xlat31 = u_xlat29 * u_xlat31 + 0.458999991;
                  u_xlat29 = u_xlat29 * u_xlat31 + -0.00286999997;
                  u_xlat29 = u_xlat29 * 1.44269502;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat27 = (-u_xlat27) + 1.0;
                  u_xlat31 = u_xlat27 * 5.25 + -6.80000019;
                  u_xlat31 = u_xlat27 * u_xlat31 + 3.82999992;
                  u_xlat31 = u_xlat27 * u_xlat31 + 0.458999991;
                  u_xlat27 = u_xlat27 * u_xlat31 + -0.00286999997;
                  u_xlat27 = u_xlat27 * 1.44269502;
                  u_xlat27 = exp2(u_xlat27);
                  u_xlat27 = u_xlat27 * 0.25;
                  u_xlat27 = u_xlat29 * 0.25 + (-u_xlat27);
                  u_xlat27 = u_xlat28 * u_xlat27 + u_xlat0.y;
                  u_xlat27 = max(u_xlat27, 0.0);
                  u_xlat27 = min(u_xlat27, 50.0);
                  u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat6.xyz = (-vec3(u_xlat27)) * u_xlat5.xyz;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat6.xyz = exp2(u_xlat6.xyz);
                  u_xlat27 = u_xlat0.z * u_xlat28;
                  u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
                  u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat28 = (-u_xlat0.x) + 1.0;
                  u_xlat28 = u_xlat28 * 230.831207;
                  u_xlat28 = exp2(u_xlat28);
                  u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat29 = u_xlat29 / u_xlat0.x;
                  u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat0.x = u_xlat4.x / u_xlat0.x;
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat4.x = u_xlat29 * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat29 * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat29 * u_xlat4.x + 0.458999991;
                  u_xlat29 = u_xlat29 * u_xlat4.x + -0.00286999997;
                  u_xlat29 = u_xlat29 * 1.44269502;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat0.x = (-u_xlat0.x) + 1.0;
                  u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
                  u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
                  u_xlat0.x = u_xlat0.x * 1.44269502;
                  u_xlat0.x = exp2(u_xlat0.x);
                  u_xlat0.x = u_xlat0.x * 0.25;
                  u_xlat0.x = u_xlat29 * 0.25 + (-u_xlat0.x);
                  u_xlat0.x = u_xlat28 * u_xlat0.x + u_xlat0.y;
                  u_xlat0.x = max(u_xlat0.x, 0.0);
                  u_xlat0.x = min(u_xlat0.x, 50.0);
                  u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
                  u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat4.xyz = exp2(u_xlat4.xyz);
                  u_xlat0.x = u_xlat0.z * u_xlat28;
                  u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat27) + u_xlat0.xyz;
                  u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
                  u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              } else {
                  u_xlat29 = min(u_xlat2.y, -0.00100000005);
                  u_xlat29 = -9.99999975e-05 / u_xlat29;
                  u_xlat5.xyz = vec3(u_xlat29) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
                  u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
                  u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
                  u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
                  u_xlat23 = u_xlat5.y * 5.25 + -6.80000019;
                  u_xlat23 = u_xlat5.y * u_xlat23 + 3.82999992;
                  u_xlat23 = u_xlat5.y * u_xlat23 + 0.458999991;
                  u_xlat14.x = u_xlat5.y * u_xlat23 + -0.00286999997;
                  u_xlat14.x = u_xlat14.x * 1.44269502;
                  u_xlat5.y = exp2(u_xlat14.x);
                  u_xlat23 = u_xlat5.x * 5.25 + -6.80000019;
                  u_xlat23 = u_xlat5.x * u_xlat23 + 3.82999992;
                  u_xlat23 = u_xlat5.x * u_xlat23 + 0.458999991;
                  u_xlat5.x = u_xlat5.x * u_xlat23 + -0.00286999997;
                  u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
                  u_xlat5.x = exp2(u_xlat5.x);
                  u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
                  u_xlat14.xz = vec2(u_xlat29) * vec2(0.5, 20.0);
                  u_xlat6.xyz = u_xlat2.xyz * u_xlat14.xxx;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
                  u_xlat29 = sqrt(u_xlat29);
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat29 = u_xlat29 * 230.831207;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat5.x = u_xlat29 * u_xlat5.x + (-u_xlat5.z);
                  u_xlat5.x = max(u_xlat5.x, 0.0);
                  u_xlat5.x = min(u_xlat5.x, 50.0);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
                  u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat0.xyz = exp2(u_xlat5.xyz);
                  u_xlat29 = u_xlat14.z * u_xlat29;
                  u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat29);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              //ENDIF
              }
              u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
              u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
              u_xlat16_30 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
              u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
              u_xlat16_30 = u_xlat16_30 * 0.75 + 0.75;
              u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
              u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
              u_xlat16_30 = dot(_LightColor0.xyz, _LightColor0.xyz);
              u_xlat16_30 = sqrt(u_xlat16_30);
              u_xlat16_30 = max(u_xlat16_30, 0.25);
              u_xlat16_30 = min(u_xlat16_30, 1.0);
              u_xlat16_8.xyz = u_xlat16_0.xyz * vec3(8000.0, 8000.0, 8000.0);
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_8.xyz = min(max(u_xlat16_8.xyz, 0.0), 1.0);
          #else
              u_xlat16_8.xyz = clamp(u_xlat16_8.xyz, 0.0, 1.0);
          #endif
              u_xlat16_8.xyz = u_xlat16_8.xyz * _LightColor0.xyz;
              u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(27.0, 27.0, 27.0);
              u_xlat16_8.xyz = u_xlat16_8.xyz / vec3(u_xlat16_30);
              vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
              vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
              vs_TEXCOORD3.xyz = sqrt(u_xlat16_8.xyz);
              vs_TEXCOORD0.xyz = (-u_xlat2.xyz);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	mediump float _SunSize;
          in mediump vec3 vs_TEXCOORD0;
          in mediump vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD2;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec3 u_xlat16_0;
          mediump vec3 u_xlat16_1;
          bool u_xlatb2;
          mediump vec3 u_xlat16_3;
          void main()
          {
              u_xlat16_0.xyz = vs_TEXCOORD0.xyz + _WorldSpaceLightPos0.xyz;
              u_xlat16_0.x = dot(u_xlat16_0.xyz, u_xlat16_0.xyz);
              u_xlat16_0.x = sqrt(u_xlat16_0.x);
              u_xlat16_3.x = float(1.0) / _SunSize;
              u_xlat16_0.x = u_xlat16_3.x * u_xlat16_0.x;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_0.x = min(max(u_xlat16_0.x, 0.0), 1.0);
          #else
              u_xlat16_0.x = clamp(u_xlat16_0.x, 0.0, 1.0);
          #endif
              u_xlat16_3.x = u_xlat16_0.x * -2.0 + 3.0;
              u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
              u_xlat16_0.x = (-u_xlat16_3.x) * u_xlat16_0.x + 1.0;
              u_xlat16_0.x = u_xlat16_0.x * u_xlat16_0.x;
              u_xlat16_3.x = vs_TEXCOORD0.y * 50.0;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
          #else
              u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
          #endif
              u_xlat16_1.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_1.xyz + vs_TEXCOORD2.xyz;
              u_xlat16_1.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb2 = !!(vs_TEXCOORD0.y<0.0);
          #else
              u_xlatb2 = vs_TEXCOORD0.y<0.0;
          #endif
              SV_Target0.xyz = (bool(u_xlatb2)) ? u_xlat16_1.xyz : u_xlat16_3.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "_SUNDISK_HIGH_QUALITY" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform lowp vec4 _LightColor0;
          uniform mediump float _Exposure;
          uniform mediump vec3 _GroundColor;
          uniform mediump vec3 _SkyTint;
          uniform mediump float _AtmosphereThickness;
          varying highp vec3 xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump float lightColorIntensity_1;
            mediump vec3 cOut_2;
            mediump vec3 cIn_3;
            highp float far_4;
            highp float kKr4PI_5;
            highp float kKrESun_6;
            highp vec3 kSkyTintInGammaSpace_7;
            mediump vec3 tmpvar_8;
            mediump vec3 tmpvar_9;
            mediump vec3 tmpvar_10;
            highp vec4 tmpvar_11;
            highp vec4 tmpvar_12;
            tmpvar_12.w = 1.0;
            tmpvar_12.xyz = _glesVertex.xyz;
            tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
            kSkyTintInGammaSpace_7 = _SkyTint;
            highp vec3 tmpvar_13;
            tmpvar_13 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
              (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_7)
            ), vec3(4.0, 4.0, 4.0))));
            mediump float tmpvar_14;
            mediump float tmpvar_15;
            tmpvar_15 = pow (_AtmosphereThickness, 2.5);
            tmpvar_14 = (0.05 * tmpvar_15);
            kKrESun_6 = tmpvar_14;
            mediump float tmpvar_16;
            tmpvar_16 = (0.03141593 * tmpvar_15);
            kKr4PI_5 = tmpvar_16;
            highp mat3 tmpvar_17;
            tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
            tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
            tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
            highp vec3 tmpvar_18;
            tmpvar_18 = normalize((tmpvar_17 * _glesVertex.xyz));
            far_4 = 0.0;
            if ((tmpvar_18.y >= 0.0)) {
              highp vec3 frontColor_19;
              highp vec3 samplePoint_20;
              far_4 = (sqrt((
                (1.050625 + (tmpvar_18.y * tmpvar_18.y))
               - 1.0)) - tmpvar_18.y);
              highp float tmpvar_21;
              tmpvar_21 = (1.0 - (dot (tmpvar_18, vec3(0.0, 1.0001, 0.0)) / 1.0001));
              highp float tmpvar_22;
              tmpvar_22 = (exp((-0.00287 + 
                (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
                  (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
                ))))
              )) * 0.2460318);
              highp float tmpvar_23;
              tmpvar_23 = (far_4 / 2.0);
              highp float tmpvar_24;
              tmpvar_24 = (tmpvar_23 * 40.00004);
              highp vec3 tmpvar_25;
              tmpvar_25 = (tmpvar_18 * tmpvar_23);
              highp vec3 tmpvar_26;
              tmpvar_26 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_25 * 0.5));
              highp float tmpvar_27;
              tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
              highp float tmpvar_28;
              tmpvar_28 = exp((160.0002 * (1.0 - tmpvar_27)));
              highp float tmpvar_29;
              tmpvar_29 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_26) / tmpvar_27));
              highp float tmpvar_30;
              tmpvar_30 = (1.0 - (dot (tmpvar_18, tmpvar_26) / tmpvar_27));
              frontColor_19 = (exp((
                -(clamp ((tmpvar_22 + (tmpvar_28 * 
                  ((0.25 * exp((-0.00287 + 
                    (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
                      (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
                    ))))
                  ))) - (0.25 * exp((-0.00287 + 
                    (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
                      (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
                    ))))
                  ))))
                )), 0.0, 50.0))
               * 
                ((tmpvar_13 * kKr4PI_5) + 0.01256637)
              )) * (tmpvar_28 * tmpvar_24));
              samplePoint_20 = (tmpvar_26 + tmpvar_25);
              highp float tmpvar_31;
              tmpvar_31 = sqrt(dot (samplePoint_20, samplePoint_20));
              highp float tmpvar_32;
              tmpvar_32 = exp((160.0002 * (1.0 - tmpvar_31)));
              highp float tmpvar_33;
              tmpvar_33 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_20) / tmpvar_31));
              highp float tmpvar_34;
              tmpvar_34 = (1.0 - (dot (tmpvar_18, samplePoint_20) / tmpvar_31));
              frontColor_19 = (frontColor_19 + (exp(
                (-(clamp ((tmpvar_22 + 
                  (tmpvar_32 * ((0.25 * exp(
                    (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
                      (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
                    ))))
                  )) - (0.25 * exp(
                    (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
                      (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
                    ))))
                  ))))
                ), 0.0, 50.0)) * ((tmpvar_13 * kKr4PI_5) + 0.01256637))
              ) * (tmpvar_32 * tmpvar_24)));
              samplePoint_20 = (samplePoint_20 + tmpvar_25);
              cIn_3 = (frontColor_19 * (tmpvar_13 * kKrESun_6));
              cOut_2 = (frontColor_19 * 0.02);
            } else {
              highp vec3 frontColor_1_35;
              far_4 = (-0.0001 / min (-0.001, tmpvar_18.y));
              highp vec3 tmpvar_36;
              tmpvar_36 = (vec3(0.0, 1.0001, 0.0) + (far_4 * tmpvar_18));
              highp float tmpvar_37;
              highp float tmpvar_38;
              tmpvar_38 = (1.0 - dot (-(tmpvar_18), tmpvar_36));
              tmpvar_37 = (0.25 * exp((-0.00287 + 
                (tmpvar_38 * (0.459 + (tmpvar_38 * (3.83 + 
                  (tmpvar_38 * (-6.8 + (tmpvar_38 * 5.25)))
                ))))
              )));
              highp float tmpvar_39;
              tmpvar_39 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_36));
              highp float tmpvar_40;
              tmpvar_40 = (far_4 / 2.0);
              highp vec3 tmpvar_41;
              tmpvar_41 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_18 * tmpvar_40) * 0.5));
              highp float tmpvar_42;
              tmpvar_42 = exp((160.0002 * (1.0 - 
                sqrt(dot (tmpvar_41, tmpvar_41))
              )));
              highp vec3 tmpvar_43;
              tmpvar_43 = exp((-(
                clamp (((tmpvar_42 * (
                  (0.25 * exp((-0.00287 + (tmpvar_39 * 
                    (0.459 + (tmpvar_39 * (3.83 + (tmpvar_39 * 
                      (-6.8 + (tmpvar_39 * 5.25))
                    ))))
                  ))))
                 + tmpvar_37)) - (0.9996001 * tmpvar_37)), 0.0, 50.0)
              ) * (
                (tmpvar_13 * kKr4PI_5)
               + 0.01256637)));
              frontColor_1_35 = (tmpvar_43 * (tmpvar_42 * (tmpvar_40 * 40.00004)));
              cIn_3 = (frontColor_1_35 * ((tmpvar_13 * kKrESun_6) + 0.02));
              highp vec3 tmpvar_44;
              tmpvar_44 = clamp (tmpvar_43, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
              cOut_2 = tmpvar_44;
            };
            tmpvar_8 = (_Exposure * (cIn_3 + (
              (_GroundColor * _GroundColor)
             * cOut_2)));
            mediump vec3 light_45;
            light_45 = _WorldSpaceLightPos0.xyz;
            mediump vec3 ray_46;
            ray_46 = -(tmpvar_18);
            mediump float tmpvar_47;
            tmpvar_47 = dot (light_45, ray_46);
            tmpvar_9 = (_Exposure * (cIn_3 * (0.75 + 
              (0.75 * (tmpvar_47 * tmpvar_47))
            )));
            lowp float tmpvar_48;
            tmpvar_48 = clamp (sqrt(dot (_LightColor0.xyz, _LightColor0.xyz)), 0.25, 1.0);
            lightColorIntensity_1 = tmpvar_48;
            tmpvar_10 = (((15.0 * 
              clamp (cOut_2, 0.0, 1.0)
            ) * _LightColor0.xyz) / lightColorIntensity_1);
            mediump vec3 tmpvar_49;
            tmpvar_49 = sqrt(tmpvar_8);
            tmpvar_8 = tmpvar_49;
            mediump vec3 tmpvar_50;
            tmpvar_50 = sqrt(tmpvar_9);
            tmpvar_9 = tmpvar_50;
            mediump vec3 tmpvar_51;
            tmpvar_51 = sqrt(tmpvar_10);
            tmpvar_10 = tmpvar_51;
            gl_Position = tmpvar_11;
            xlv_TEXCOORD0 = -(_glesVertex).xyz;
            xlv_TEXCOORD1 = tmpvar_49;
            xlv_TEXCOORD2 = tmpvar_50;
            xlv_TEXCOORD3 = tmpvar_51;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform mediump float _SunSize;
          uniform mediump float _SunSizeConvergence;
          varying highp vec3 xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 ray_1;
            mediump vec3 col_2;
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
            tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
            tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
            highp vec3 tmpvar_4;
            tmpvar_4 = normalize((tmpvar_3 * xlv_TEXCOORD0));
            ray_1 = tmpvar_4;
            mediump float tmpvar_5;
            tmpvar_5 = (ray_1.y / 0.02);
            mediump vec3 tmpvar_6;
            tmpvar_6 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_5, 0.0, 1.0)));
            col_2 = tmpvar_6;
            if ((tmpvar_5 < 0.0)) {
              mediump vec3 lightPos_7;
              lightPos_7 = _WorldSpaceLightPos0.xyz;
              mediump float tmpvar_8;
              tmpvar_8 = pow (clamp (dot (lightPos_7, 
                -(ray_1)
              ), 0.0, 1.0), _SunSizeConvergence);
              mediump float temp_9;
              temp_9 = ((0.01001645 * (1.0 + 
                (tmpvar_8 * tmpvar_8)
              )) / max (pow (
                (1.9801 - (-1.98 * -(tmpvar_8)))
              , 
                (pow (_SunSize, 0.65) * 10.0)
              ), 0.0001));
              mediump float tmpvar_10;
              tmpvar_10 = pow (temp_9, 0.454545);
              temp_9 = tmpvar_10;
              col_2 = (tmpvar_6 + (xlv_TEXCOORD3 * tmpvar_10));
            };
            mediump vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = col_2;
            gl_FragData[0] = tmpvar_11;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "_SUNDISK_HIGH_QUALITY" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform lowp vec4 _LightColor0;
          uniform mediump float _Exposure;
          uniform mediump vec3 _GroundColor;
          uniform mediump vec3 _SkyTint;
          uniform mediump float _AtmosphereThickness;
          varying highp vec3 xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump float lightColorIntensity_1;
            mediump vec3 cOut_2;
            mediump vec3 cIn_3;
            highp float far_4;
            highp float kKr4PI_5;
            highp float kKrESun_6;
            highp vec3 kSkyTintInGammaSpace_7;
            mediump vec3 tmpvar_8;
            mediump vec3 tmpvar_9;
            mediump vec3 tmpvar_10;
            highp vec4 tmpvar_11;
            highp vec4 tmpvar_12;
            tmpvar_12.w = 1.0;
            tmpvar_12.xyz = _glesVertex.xyz;
            tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
            kSkyTintInGammaSpace_7 = _SkyTint;
            highp vec3 tmpvar_13;
            tmpvar_13 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
              (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_7)
            ), vec3(4.0, 4.0, 4.0))));
            mediump float tmpvar_14;
            mediump float tmpvar_15;
            tmpvar_15 = pow (_AtmosphereThickness, 2.5);
            tmpvar_14 = (0.05 * tmpvar_15);
            kKrESun_6 = tmpvar_14;
            mediump float tmpvar_16;
            tmpvar_16 = (0.03141593 * tmpvar_15);
            kKr4PI_5 = tmpvar_16;
            highp mat3 tmpvar_17;
            tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
            tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
            tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
            highp vec3 tmpvar_18;
            tmpvar_18 = normalize((tmpvar_17 * _glesVertex.xyz));
            far_4 = 0.0;
            if ((tmpvar_18.y >= 0.0)) {
              highp vec3 frontColor_19;
              highp vec3 samplePoint_20;
              far_4 = (sqrt((
                (1.050625 + (tmpvar_18.y * tmpvar_18.y))
               - 1.0)) - tmpvar_18.y);
              highp float tmpvar_21;
              tmpvar_21 = (1.0 - (dot (tmpvar_18, vec3(0.0, 1.0001, 0.0)) / 1.0001));
              highp float tmpvar_22;
              tmpvar_22 = (exp((-0.00287 + 
                (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
                  (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
                ))))
              )) * 0.2460318);
              highp float tmpvar_23;
              tmpvar_23 = (far_4 / 2.0);
              highp float tmpvar_24;
              tmpvar_24 = (tmpvar_23 * 40.00004);
              highp vec3 tmpvar_25;
              tmpvar_25 = (tmpvar_18 * tmpvar_23);
              highp vec3 tmpvar_26;
              tmpvar_26 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_25 * 0.5));
              highp float tmpvar_27;
              tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
              highp float tmpvar_28;
              tmpvar_28 = exp((160.0002 * (1.0 - tmpvar_27)));
              highp float tmpvar_29;
              tmpvar_29 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_26) / tmpvar_27));
              highp float tmpvar_30;
              tmpvar_30 = (1.0 - (dot (tmpvar_18, tmpvar_26) / tmpvar_27));
              frontColor_19 = (exp((
                -(clamp ((tmpvar_22 + (tmpvar_28 * 
                  ((0.25 * exp((-0.00287 + 
                    (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
                      (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
                    ))))
                  ))) - (0.25 * exp((-0.00287 + 
                    (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
                      (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
                    ))))
                  ))))
                )), 0.0, 50.0))
               * 
                ((tmpvar_13 * kKr4PI_5) + 0.01256637)
              )) * (tmpvar_28 * tmpvar_24));
              samplePoint_20 = (tmpvar_26 + tmpvar_25);
              highp float tmpvar_31;
              tmpvar_31 = sqrt(dot (samplePoint_20, samplePoint_20));
              highp float tmpvar_32;
              tmpvar_32 = exp((160.0002 * (1.0 - tmpvar_31)));
              highp float tmpvar_33;
              tmpvar_33 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_20) / tmpvar_31));
              highp float tmpvar_34;
              tmpvar_34 = (1.0 - (dot (tmpvar_18, samplePoint_20) / tmpvar_31));
              frontColor_19 = (frontColor_19 + (exp(
                (-(clamp ((tmpvar_22 + 
                  (tmpvar_32 * ((0.25 * exp(
                    (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
                      (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
                    ))))
                  )) - (0.25 * exp(
                    (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
                      (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
                    ))))
                  ))))
                ), 0.0, 50.0)) * ((tmpvar_13 * kKr4PI_5) + 0.01256637))
              ) * (tmpvar_32 * tmpvar_24)));
              samplePoint_20 = (samplePoint_20 + tmpvar_25);
              cIn_3 = (frontColor_19 * (tmpvar_13 * kKrESun_6));
              cOut_2 = (frontColor_19 * 0.02);
            } else {
              highp vec3 frontColor_1_35;
              far_4 = (-0.0001 / min (-0.001, tmpvar_18.y));
              highp vec3 tmpvar_36;
              tmpvar_36 = (vec3(0.0, 1.0001, 0.0) + (far_4 * tmpvar_18));
              highp float tmpvar_37;
              highp float tmpvar_38;
              tmpvar_38 = (1.0 - dot (-(tmpvar_18), tmpvar_36));
              tmpvar_37 = (0.25 * exp((-0.00287 + 
                (tmpvar_38 * (0.459 + (tmpvar_38 * (3.83 + 
                  (tmpvar_38 * (-6.8 + (tmpvar_38 * 5.25)))
                ))))
              )));
              highp float tmpvar_39;
              tmpvar_39 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_36));
              highp float tmpvar_40;
              tmpvar_40 = (far_4 / 2.0);
              highp vec3 tmpvar_41;
              tmpvar_41 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_18 * tmpvar_40) * 0.5));
              highp float tmpvar_42;
              tmpvar_42 = exp((160.0002 * (1.0 - 
                sqrt(dot (tmpvar_41, tmpvar_41))
              )));
              highp vec3 tmpvar_43;
              tmpvar_43 = exp((-(
                clamp (((tmpvar_42 * (
                  (0.25 * exp((-0.00287 + (tmpvar_39 * 
                    (0.459 + (tmpvar_39 * (3.83 + (tmpvar_39 * 
                      (-6.8 + (tmpvar_39 * 5.25))
                    ))))
                  ))))
                 + tmpvar_37)) - (0.9996001 * tmpvar_37)), 0.0, 50.0)
              ) * (
                (tmpvar_13 * kKr4PI_5)
               + 0.01256637)));
              frontColor_1_35 = (tmpvar_43 * (tmpvar_42 * (tmpvar_40 * 40.00004)));
              cIn_3 = (frontColor_1_35 * ((tmpvar_13 * kKrESun_6) + 0.02));
              highp vec3 tmpvar_44;
              tmpvar_44 = clamp (tmpvar_43, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
              cOut_2 = tmpvar_44;
            };
            tmpvar_8 = (_Exposure * (cIn_3 + (
              (_GroundColor * _GroundColor)
             * cOut_2)));
            mediump vec3 light_45;
            light_45 = _WorldSpaceLightPos0.xyz;
            mediump vec3 ray_46;
            ray_46 = -(tmpvar_18);
            mediump float tmpvar_47;
            tmpvar_47 = dot (light_45, ray_46);
            tmpvar_9 = (_Exposure * (cIn_3 * (0.75 + 
              (0.75 * (tmpvar_47 * tmpvar_47))
            )));
            lowp float tmpvar_48;
            tmpvar_48 = clamp (sqrt(dot (_LightColor0.xyz, _LightColor0.xyz)), 0.25, 1.0);
            lightColorIntensity_1 = tmpvar_48;
            tmpvar_10 = (((15.0 * 
              clamp (cOut_2, 0.0, 1.0)
            ) * _LightColor0.xyz) / lightColorIntensity_1);
            mediump vec3 tmpvar_49;
            tmpvar_49 = sqrt(tmpvar_8);
            tmpvar_8 = tmpvar_49;
            mediump vec3 tmpvar_50;
            tmpvar_50 = sqrt(tmpvar_9);
            tmpvar_9 = tmpvar_50;
            mediump vec3 tmpvar_51;
            tmpvar_51 = sqrt(tmpvar_10);
            tmpvar_10 = tmpvar_51;
            gl_Position = tmpvar_11;
            xlv_TEXCOORD0 = -(_glesVertex).xyz;
            xlv_TEXCOORD1 = tmpvar_49;
            xlv_TEXCOORD2 = tmpvar_50;
            xlv_TEXCOORD3 = tmpvar_51;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform mediump float _SunSize;
          uniform mediump float _SunSizeConvergence;
          varying highp vec3 xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 ray_1;
            mediump vec3 col_2;
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
            tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
            tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
            highp vec3 tmpvar_4;
            tmpvar_4 = normalize((tmpvar_3 * xlv_TEXCOORD0));
            ray_1 = tmpvar_4;
            mediump float tmpvar_5;
            tmpvar_5 = (ray_1.y / 0.02);
            mediump vec3 tmpvar_6;
            tmpvar_6 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_5, 0.0, 1.0)));
            col_2 = tmpvar_6;
            if ((tmpvar_5 < 0.0)) {
              mediump vec3 lightPos_7;
              lightPos_7 = _WorldSpaceLightPos0.xyz;
              mediump float tmpvar_8;
              tmpvar_8 = pow (clamp (dot (lightPos_7, 
                -(ray_1)
              ), 0.0, 1.0), _SunSizeConvergence);
              mediump float temp_9;
              temp_9 = ((0.01001645 * (1.0 + 
                (tmpvar_8 * tmpvar_8)
              )) / max (pow (
                (1.9801 - (-1.98 * -(tmpvar_8)))
              , 
                (pow (_SunSize, 0.65) * 10.0)
              ), 0.0001));
              mediump float tmpvar_10;
              tmpvar_10 = pow (temp_9, 0.454545);
              temp_9 = tmpvar_10;
              col_2 = (tmpvar_6 + (xlv_TEXCOORD3 * tmpvar_10));
            };
            mediump vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = col_2;
            gl_FragData[0] = tmpvar_11;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "_SUNDISK_HIGH_QUALITY" }
          
          "!!!!GLES
          #version 100
          
          #ifdef VERTEX
          attribute vec4 _glesVertex;
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform highp mat4 unity_MatrixVP;
          uniform lowp vec4 _LightColor0;
          uniform mediump float _Exposure;
          uniform mediump vec3 _GroundColor;
          uniform mediump vec3 _SkyTint;
          uniform mediump float _AtmosphereThickness;
          varying highp vec3 xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump float lightColorIntensity_1;
            mediump vec3 cOut_2;
            mediump vec3 cIn_3;
            highp float far_4;
            highp float kKr4PI_5;
            highp float kKrESun_6;
            highp vec3 kSkyTintInGammaSpace_7;
            mediump vec3 tmpvar_8;
            mediump vec3 tmpvar_9;
            mediump vec3 tmpvar_10;
            highp vec4 tmpvar_11;
            highp vec4 tmpvar_12;
            tmpvar_12.w = 1.0;
            tmpvar_12.xyz = _glesVertex.xyz;
            tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
            kSkyTintInGammaSpace_7 = _SkyTint;
            highp vec3 tmpvar_13;
            tmpvar_13 = (1.0/(pow (mix (vec3(0.5, 0.42, 0.325), vec3(0.8, 0.72, 0.625), 
              (vec3(1.0, 1.0, 1.0) - kSkyTintInGammaSpace_7)
            ), vec3(4.0, 4.0, 4.0))));
            mediump float tmpvar_14;
            mediump float tmpvar_15;
            tmpvar_15 = pow (_AtmosphereThickness, 2.5);
            tmpvar_14 = (0.05 * tmpvar_15);
            kKrESun_6 = tmpvar_14;
            mediump float tmpvar_16;
            tmpvar_16 = (0.03141593 * tmpvar_15);
            kKr4PI_5 = tmpvar_16;
            highp mat3 tmpvar_17;
            tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
            tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
            tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
            highp vec3 tmpvar_18;
            tmpvar_18 = normalize((tmpvar_17 * _glesVertex.xyz));
            far_4 = 0.0;
            if ((tmpvar_18.y >= 0.0)) {
              highp vec3 frontColor_19;
              highp vec3 samplePoint_20;
              far_4 = (sqrt((
                (1.050625 + (tmpvar_18.y * tmpvar_18.y))
               - 1.0)) - tmpvar_18.y);
              highp float tmpvar_21;
              tmpvar_21 = (1.0 - (dot (tmpvar_18, vec3(0.0, 1.0001, 0.0)) / 1.0001));
              highp float tmpvar_22;
              tmpvar_22 = (exp((-0.00287 + 
                (tmpvar_21 * (0.459 + (tmpvar_21 * (3.83 + 
                  (tmpvar_21 * (-6.8 + (tmpvar_21 * 5.25)))
                ))))
              )) * 0.2460318);
              highp float tmpvar_23;
              tmpvar_23 = (far_4 / 2.0);
              highp float tmpvar_24;
              tmpvar_24 = (tmpvar_23 * 40.00004);
              highp vec3 tmpvar_25;
              tmpvar_25 = (tmpvar_18 * tmpvar_23);
              highp vec3 tmpvar_26;
              tmpvar_26 = (vec3(0.0, 1.0001, 0.0) + (tmpvar_25 * 0.5));
              highp float tmpvar_27;
              tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
              highp float tmpvar_28;
              tmpvar_28 = exp((160.0002 * (1.0 - tmpvar_27)));
              highp float tmpvar_29;
              tmpvar_29 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, tmpvar_26) / tmpvar_27));
              highp float tmpvar_30;
              tmpvar_30 = (1.0 - (dot (tmpvar_18, tmpvar_26) / tmpvar_27));
              frontColor_19 = (exp((
                -(clamp ((tmpvar_22 + (tmpvar_28 * 
                  ((0.25 * exp((-0.00287 + 
                    (tmpvar_29 * (0.459 + (tmpvar_29 * (3.83 + 
                      (tmpvar_29 * (-6.8 + (tmpvar_29 * 5.25)))
                    ))))
                  ))) - (0.25 * exp((-0.00287 + 
                    (tmpvar_30 * (0.459 + (tmpvar_30 * (3.83 + 
                      (tmpvar_30 * (-6.8 + (tmpvar_30 * 5.25)))
                    ))))
                  ))))
                )), 0.0, 50.0))
               * 
                ((tmpvar_13 * kKr4PI_5) + 0.01256637)
              )) * (tmpvar_28 * tmpvar_24));
              samplePoint_20 = (tmpvar_26 + tmpvar_25);
              highp float tmpvar_31;
              tmpvar_31 = sqrt(dot (samplePoint_20, samplePoint_20));
              highp float tmpvar_32;
              tmpvar_32 = exp((160.0002 * (1.0 - tmpvar_31)));
              highp float tmpvar_33;
              tmpvar_33 = (1.0 - (dot (_WorldSpaceLightPos0.xyz, samplePoint_20) / tmpvar_31));
              highp float tmpvar_34;
              tmpvar_34 = (1.0 - (dot (tmpvar_18, samplePoint_20) / tmpvar_31));
              frontColor_19 = (frontColor_19 + (exp(
                (-(clamp ((tmpvar_22 + 
                  (tmpvar_32 * ((0.25 * exp(
                    (-0.00287 + (tmpvar_33 * (0.459 + (tmpvar_33 * 
                      (3.83 + (tmpvar_33 * (-6.8 + (tmpvar_33 * 5.25))))
                    ))))
                  )) - (0.25 * exp(
                    (-0.00287 + (tmpvar_34 * (0.459 + (tmpvar_34 * 
                      (3.83 + (tmpvar_34 * (-6.8 + (tmpvar_34 * 5.25))))
                    ))))
                  ))))
                ), 0.0, 50.0)) * ((tmpvar_13 * kKr4PI_5) + 0.01256637))
              ) * (tmpvar_32 * tmpvar_24)));
              samplePoint_20 = (samplePoint_20 + tmpvar_25);
              cIn_3 = (frontColor_19 * (tmpvar_13 * kKrESun_6));
              cOut_2 = (frontColor_19 * 0.02);
            } else {
              highp vec3 frontColor_1_35;
              far_4 = (-0.0001 / min (-0.001, tmpvar_18.y));
              highp vec3 tmpvar_36;
              tmpvar_36 = (vec3(0.0, 1.0001, 0.0) + (far_4 * tmpvar_18));
              highp float tmpvar_37;
              highp float tmpvar_38;
              tmpvar_38 = (1.0 - dot (-(tmpvar_18), tmpvar_36));
              tmpvar_37 = (0.25 * exp((-0.00287 + 
                (tmpvar_38 * (0.459 + (tmpvar_38 * (3.83 + 
                  (tmpvar_38 * (-6.8 + (tmpvar_38 * 5.25)))
                ))))
              )));
              highp float tmpvar_39;
              tmpvar_39 = (1.0 - dot (_WorldSpaceLightPos0.xyz, tmpvar_36));
              highp float tmpvar_40;
              tmpvar_40 = (far_4 / 2.0);
              highp vec3 tmpvar_41;
              tmpvar_41 = (vec3(0.0, 1.0001, 0.0) + ((tmpvar_18 * tmpvar_40) * 0.5));
              highp float tmpvar_42;
              tmpvar_42 = exp((160.0002 * (1.0 - 
                sqrt(dot (tmpvar_41, tmpvar_41))
              )));
              highp vec3 tmpvar_43;
              tmpvar_43 = exp((-(
                clamp (((tmpvar_42 * (
                  (0.25 * exp((-0.00287 + (tmpvar_39 * 
                    (0.459 + (tmpvar_39 * (3.83 + (tmpvar_39 * 
                      (-6.8 + (tmpvar_39 * 5.25))
                    ))))
                  ))))
                 + tmpvar_37)) - (0.9996001 * tmpvar_37)), 0.0, 50.0)
              ) * (
                (tmpvar_13 * kKr4PI_5)
               + 0.01256637)));
              frontColor_1_35 = (tmpvar_43 * (tmpvar_42 * (tmpvar_40 * 40.00004)));
              cIn_3 = (frontColor_1_35 * ((tmpvar_13 * kKrESun_6) + 0.02));
              highp vec3 tmpvar_44;
              tmpvar_44 = clamp (tmpvar_43, vec3(0.0, 0.0, 0.0), vec3(1.0, 1.0, 1.0));
              cOut_2 = tmpvar_44;
            };
            tmpvar_8 = (_Exposure * (cIn_3 + (
              (_GroundColor * _GroundColor)
             * cOut_2)));
            mediump vec3 light_45;
            light_45 = _WorldSpaceLightPos0.xyz;
            mediump vec3 ray_46;
            ray_46 = -(tmpvar_18);
            mediump float tmpvar_47;
            tmpvar_47 = dot (light_45, ray_46);
            tmpvar_9 = (_Exposure * (cIn_3 * (0.75 + 
              (0.75 * (tmpvar_47 * tmpvar_47))
            )));
            lowp float tmpvar_48;
            tmpvar_48 = clamp (sqrt(dot (_LightColor0.xyz, _LightColor0.xyz)), 0.25, 1.0);
            lightColorIntensity_1 = tmpvar_48;
            tmpvar_10 = (((15.0 * 
              clamp (cOut_2, 0.0, 1.0)
            ) * _LightColor0.xyz) / lightColorIntensity_1);
            mediump vec3 tmpvar_49;
            tmpvar_49 = sqrt(tmpvar_8);
            tmpvar_8 = tmpvar_49;
            mediump vec3 tmpvar_50;
            tmpvar_50 = sqrt(tmpvar_9);
            tmpvar_9 = tmpvar_50;
            mediump vec3 tmpvar_51;
            tmpvar_51 = sqrt(tmpvar_10);
            tmpvar_10 = tmpvar_51;
            gl_Position = tmpvar_11;
            xlv_TEXCOORD0 = -(_glesVertex).xyz;
            xlv_TEXCOORD1 = tmpvar_49;
            xlv_TEXCOORD2 = tmpvar_50;
            xlv_TEXCOORD3 = tmpvar_51;
          }
          
          
          #endif
          #ifdef FRAGMENT
          uniform highp vec4 _WorldSpaceLightPos0;
          uniform highp mat4 unity_ObjectToWorld;
          uniform mediump float _SunSize;
          uniform mediump float _SunSizeConvergence;
          varying highp vec3 xlv_TEXCOORD0;
          varying mediump vec3 xlv_TEXCOORD1;
          varying mediump vec3 xlv_TEXCOORD2;
          varying mediump vec3 xlv_TEXCOORD3;
          void main ()
          {
            mediump vec3 ray_1;
            mediump vec3 col_2;
            highp mat3 tmpvar_3;
            tmpvar_3[0] = unity_ObjectToWorld[0].xyz;
            tmpvar_3[1] = unity_ObjectToWorld[1].xyz;
            tmpvar_3[2] = unity_ObjectToWorld[2].xyz;
            highp vec3 tmpvar_4;
            tmpvar_4 = normalize((tmpvar_3 * xlv_TEXCOORD0));
            ray_1 = tmpvar_4;
            mediump float tmpvar_5;
            tmpvar_5 = (ray_1.y / 0.02);
            mediump vec3 tmpvar_6;
            tmpvar_6 = mix (xlv_TEXCOORD2, xlv_TEXCOORD1, vec3(clamp (tmpvar_5, 0.0, 1.0)));
            col_2 = tmpvar_6;
            if ((tmpvar_5 < 0.0)) {
              mediump vec3 lightPos_7;
              lightPos_7 = _WorldSpaceLightPos0.xyz;
              mediump float tmpvar_8;
              tmpvar_8 = pow (clamp (dot (lightPos_7, 
                -(ray_1)
              ), 0.0, 1.0), _SunSizeConvergence);
              mediump float temp_9;
              temp_9 = ((0.01001645 * (1.0 + 
                (tmpvar_8 * tmpvar_8)
              )) / max (pow (
                (1.9801 - (-1.98 * -(tmpvar_8)))
              , 
                (pow (_SunSize, 0.65) * 10.0)
              ), 0.0001));
              mediump float tmpvar_10;
              tmpvar_10 = pow (temp_9, 0.454545);
              temp_9 = tmpvar_10;
              col_2 = (tmpvar_6 + (xlv_TEXCOORD3 * tmpvar_10));
            };
            mediump vec4 tmpvar_11;
            tmpvar_11.w = 1.0;
            tmpvar_11.xyz = col_2;
            gl_FragData[0] = tmpvar_11;
          }
          
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "_SUNDISK_HIGH_QUALITY" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec3 _GroundColor;
          uniform 	mediump vec3 _SkyTint;
          uniform 	mediump float _AtmosphereThickness;
          in highp vec4 in_POSITION0;
          out highp vec3 vs_TEXCOORD0;
          out mediump vec3 vs_TEXCOORD1;
          out mediump vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          mediump vec3 u_xlat16_0;
          bool u_xlatb0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          mediump vec3 u_xlat16_4;
          vec4 u_xlat5;
          vec3 u_xlat6;
          mediump vec3 u_xlat16_7;
          mediump vec3 u_xlat16_8;
          float u_xlat9;
          vec3 u_xlat14;
          float u_xlat18;
          float u_xlat23;
          float u_xlat27;
          float u_xlat28;
          float u_xlat29;
          mediump float u_xlat16_30;
          float u_xlat31;
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
              u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
              u_xlat16_3.x = log2(_AtmosphereThickness);
              u_xlat16_3.x = u_xlat16_3.x * 2.5;
              u_xlat16_3.x = exp2(u_xlat16_3.x);
              u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
              u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat27 = inversesqrt(u_xlat27);
              u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlat2.y>=0.0);
          #else
              u_xlatb0 = u_xlat2.y>=0.0;
          #endif
              if(u_xlatb0){
                  u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat0.x = (-u_xlat0.y) * u_xlat27 + u_xlat0.x;
                  u_xlat9 = (-u_xlat0.y) * u_xlat27 + 1.0;
                  u_xlat18 = u_xlat9 * 5.25 + -6.80000019;
                  u_xlat18 = u_xlat9 * u_xlat18 + 3.82999992;
                  u_xlat18 = u_xlat9 * u_xlat18 + 0.458999991;
                  u_xlat9 = u_xlat9 * u_xlat18 + -0.00286999997;
                  u_xlat9 = u_xlat9 * 1.44269502;
                  u_xlat0.y = exp2(u_xlat9);
                  u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
                  u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
                  u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat27 = sqrt(u_xlat27);
                  u_xlat28 = (-u_xlat27) + 1.0;
                  u_xlat28 = u_xlat28 * 230.831207;
                  u_xlat28 = exp2(u_xlat28);
                  u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat29 = u_xlat29 / u_xlat27;
                  u_xlat31 = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat27 = u_xlat31 / u_xlat27;
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat31 = u_xlat29 * 5.25 + -6.80000019;
                  u_xlat31 = u_xlat29 * u_xlat31 + 3.82999992;
                  u_xlat31 = u_xlat29 * u_xlat31 + 0.458999991;
                  u_xlat29 = u_xlat29 * u_xlat31 + -0.00286999997;
                  u_xlat29 = u_xlat29 * 1.44269502;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat27 = (-u_xlat27) + 1.0;
                  u_xlat31 = u_xlat27 * 5.25 + -6.80000019;
                  u_xlat31 = u_xlat27 * u_xlat31 + 3.82999992;
                  u_xlat31 = u_xlat27 * u_xlat31 + 0.458999991;
                  u_xlat27 = u_xlat27 * u_xlat31 + -0.00286999997;
                  u_xlat27 = u_xlat27 * 1.44269502;
                  u_xlat27 = exp2(u_xlat27);
                  u_xlat27 = u_xlat27 * 0.25;
                  u_xlat27 = u_xlat29 * 0.25 + (-u_xlat27);
                  u_xlat27 = u_xlat28 * u_xlat27 + u_xlat0.y;
                  u_xlat27 = max(u_xlat27, 0.0);
                  u_xlat27 = min(u_xlat27, 50.0);
                  u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat6.xyz = (-vec3(u_xlat27)) * u_xlat5.xyz;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat6.xyz = exp2(u_xlat6.xyz);
                  u_xlat27 = u_xlat0.z * u_xlat28;
                  u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
                  u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat28 = (-u_xlat0.x) + 1.0;
                  u_xlat28 = u_xlat28 * 230.831207;
                  u_xlat28 = exp2(u_xlat28);
                  u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat29 = u_xlat29 / u_xlat0.x;
                  u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat0.x = u_xlat4.x / u_xlat0.x;
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat4.x = u_xlat29 * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat29 * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat29 * u_xlat4.x + 0.458999991;
                  u_xlat29 = u_xlat29 * u_xlat4.x + -0.00286999997;
                  u_xlat29 = u_xlat29 * 1.44269502;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat0.x = (-u_xlat0.x) + 1.0;
                  u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
                  u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
                  u_xlat0.x = u_xlat0.x * 1.44269502;
                  u_xlat0.x = exp2(u_xlat0.x);
                  u_xlat0.x = u_xlat0.x * 0.25;
                  u_xlat0.x = u_xlat29 * 0.25 + (-u_xlat0.x);
                  u_xlat0.x = u_xlat28 * u_xlat0.x + u_xlat0.y;
                  u_xlat0.x = max(u_xlat0.x, 0.0);
                  u_xlat0.x = min(u_xlat0.x, 50.0);
                  u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
                  u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat4.xyz = exp2(u_xlat4.xyz);
                  u_xlat0.x = u_xlat0.z * u_xlat28;
                  u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat27) + u_xlat0.xyz;
                  u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
                  u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              } else {
                  u_xlat29 = min(u_xlat2.y, -0.00100000005);
                  u_xlat29 = -9.99999975e-05 / u_xlat29;
                  u_xlat5.xyz = vec3(u_xlat29) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
                  u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
                  u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
                  u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
                  u_xlat23 = u_xlat5.y * 5.25 + -6.80000019;
                  u_xlat23 = u_xlat5.y * u_xlat23 + 3.82999992;
                  u_xlat23 = u_xlat5.y * u_xlat23 + 0.458999991;
                  u_xlat14.x = u_xlat5.y * u_xlat23 + -0.00286999997;
                  u_xlat14.x = u_xlat14.x * 1.44269502;
                  u_xlat5.y = exp2(u_xlat14.x);
                  u_xlat23 = u_xlat5.x * 5.25 + -6.80000019;
                  u_xlat23 = u_xlat5.x * u_xlat23 + 3.82999992;
                  u_xlat23 = u_xlat5.x * u_xlat23 + 0.458999991;
                  u_xlat5.x = u_xlat5.x * u_xlat23 + -0.00286999997;
                  u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
                  u_xlat5.x = exp2(u_xlat5.x);
                  u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
                  u_xlat14.xz = vec2(u_xlat29) * vec2(0.5, 20.0);
                  u_xlat6.xyz = u_xlat2.xyz * u_xlat14.xxx;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
                  u_xlat29 = sqrt(u_xlat29);
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat29 = u_xlat29 * 230.831207;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat5.x = u_xlat29 * u_xlat5.x + (-u_xlat5.z);
                  u_xlat5.x = max(u_xlat5.x, 0.0);
                  u_xlat5.x = min(u_xlat5.x, 50.0);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
                  u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat0.xyz = exp2(u_xlat5.xyz);
                  u_xlat29 = u_xlat14.z * u_xlat29;
                  u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat29);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              //ENDIF
              }
              vs_TEXCOORD0.xyz = (-in_POSITION0.xyz);
              u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
              u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
              u_xlat16_30 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
              u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
              u_xlat16_30 = u_xlat16_30 * 0.75 + 0.75;
              u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
              u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
              u_xlat16_30 = dot(_LightColor0.xyz, _LightColor0.xyz);
              u_xlat16_30 = sqrt(u_xlat16_30);
              u_xlat16_30 = max(u_xlat16_30, 0.25);
              u_xlat16_30 = min(u_xlat16_30, 1.0);
              u_xlat16_0.xyz = u_xlat16_0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
          #else
              u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
          #endif
              u_xlat16_8.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
              u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(15.0, 15.0, 15.0);
              u_xlat16_8.xyz = u_xlat16_8.xyz / vec3(u_xlat16_30);
              vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
              vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
              vs_TEXCOORD3.xyz = sqrt(u_xlat16_8.xyz);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	mediump float _SunSize;
          uniform 	mediump float _SunSizeConvergence;
          in highp vec3 vs_TEXCOORD0;
          in mediump vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD2;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec2 u_xlat16_0;
          vec3 u_xlat1;
          bool u_xlatb1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_6;
          float u_xlat10;
          void main()
          {
              u_xlat16_0.x = log2(_SunSize);
              u_xlat16_0.x = u_xlat16_0.x * 0.649999976;
              u_xlat16_0.x = exp2(u_xlat16_0.x);
              u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat1.xyz));
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
          #else
              u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
          #endif
              u_xlat16_3.x = log2(u_xlat16_3.x);
              u_xlat16_3.x = u_xlat16_3.x * _SunSizeConvergence;
              u_xlat16_3.x = exp2(u_xlat16_3.x);
              u_xlat16_6 = (-u_xlat16_3.x) * 1.98000002 + 1.98010004;
              u_xlat16_0.y = u_xlat16_3.x * u_xlat16_3.x + 1.0;
              u_xlat16_0.xy = u_xlat16_0.xy * vec2(10.0, 0.0100164423);
              u_xlat16_6 = log2(u_xlat16_6);
              u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
              u_xlat16_0.x = exp2(u_xlat16_0.x);
              u_xlat16_0.x = max(u_xlat16_0.x, 9.99999975e-05);
              u_xlat16_0.x = u_xlat16_0.y / u_xlat16_0.x;
              u_xlat16_0.x = log2(u_xlat16_0.x);
              u_xlat16_0.x = u_xlat16_0.x * 0.454544991;
              u_xlat16_0.x = exp2(u_xlat16_0.x);
              u_xlat16_3.x = u_xlat1.y * 50.0;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
          #else
              u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlat1.y<0.0);
          #else
              u_xlatb1 = u_xlat1.y<0.0;
          #endif
              u_xlat16_2.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vs_TEXCOORD2.xyz;
              u_xlat16_2.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
              SV_Target0.xyz = (bool(u_xlatb1)) ? u_xlat16_2.xyz : u_xlat16_3.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "_SUNDISK_HIGH_QUALITY" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec3 _GroundColor;
          uniform 	mediump vec3 _SkyTint;
          uniform 	mediump float _AtmosphereThickness;
          in highp vec4 in_POSITION0;
          out highp vec3 vs_TEXCOORD0;
          out mediump vec3 vs_TEXCOORD1;
          out mediump vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          mediump vec3 u_xlat16_0;
          bool u_xlatb0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          mediump vec3 u_xlat16_4;
          vec4 u_xlat5;
          vec3 u_xlat6;
          mediump vec3 u_xlat16_7;
          mediump vec3 u_xlat16_8;
          float u_xlat9;
          vec3 u_xlat14;
          float u_xlat18;
          float u_xlat23;
          float u_xlat27;
          float u_xlat28;
          float u_xlat29;
          mediump float u_xlat16_30;
          float u_xlat31;
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
              u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
              u_xlat16_3.x = log2(_AtmosphereThickness);
              u_xlat16_3.x = u_xlat16_3.x * 2.5;
              u_xlat16_3.x = exp2(u_xlat16_3.x);
              u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
              u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat27 = inversesqrt(u_xlat27);
              u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlat2.y>=0.0);
          #else
              u_xlatb0 = u_xlat2.y>=0.0;
          #endif
              if(u_xlatb0){
                  u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat0.x = (-u_xlat0.y) * u_xlat27 + u_xlat0.x;
                  u_xlat9 = (-u_xlat0.y) * u_xlat27 + 1.0;
                  u_xlat18 = u_xlat9 * 5.25 + -6.80000019;
                  u_xlat18 = u_xlat9 * u_xlat18 + 3.82999992;
                  u_xlat18 = u_xlat9 * u_xlat18 + 0.458999991;
                  u_xlat9 = u_xlat9 * u_xlat18 + -0.00286999997;
                  u_xlat9 = u_xlat9 * 1.44269502;
                  u_xlat0.y = exp2(u_xlat9);
                  u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
                  u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
                  u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat27 = sqrt(u_xlat27);
                  u_xlat28 = (-u_xlat27) + 1.0;
                  u_xlat28 = u_xlat28 * 230.831207;
                  u_xlat28 = exp2(u_xlat28);
                  u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat29 = u_xlat29 / u_xlat27;
                  u_xlat31 = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat27 = u_xlat31 / u_xlat27;
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat31 = u_xlat29 * 5.25 + -6.80000019;
                  u_xlat31 = u_xlat29 * u_xlat31 + 3.82999992;
                  u_xlat31 = u_xlat29 * u_xlat31 + 0.458999991;
                  u_xlat29 = u_xlat29 * u_xlat31 + -0.00286999997;
                  u_xlat29 = u_xlat29 * 1.44269502;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat27 = (-u_xlat27) + 1.0;
                  u_xlat31 = u_xlat27 * 5.25 + -6.80000019;
                  u_xlat31 = u_xlat27 * u_xlat31 + 3.82999992;
                  u_xlat31 = u_xlat27 * u_xlat31 + 0.458999991;
                  u_xlat27 = u_xlat27 * u_xlat31 + -0.00286999997;
                  u_xlat27 = u_xlat27 * 1.44269502;
                  u_xlat27 = exp2(u_xlat27);
                  u_xlat27 = u_xlat27 * 0.25;
                  u_xlat27 = u_xlat29 * 0.25 + (-u_xlat27);
                  u_xlat27 = u_xlat28 * u_xlat27 + u_xlat0.y;
                  u_xlat27 = max(u_xlat27, 0.0);
                  u_xlat27 = min(u_xlat27, 50.0);
                  u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat6.xyz = (-vec3(u_xlat27)) * u_xlat5.xyz;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat6.xyz = exp2(u_xlat6.xyz);
                  u_xlat27 = u_xlat0.z * u_xlat28;
                  u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
                  u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat28 = (-u_xlat0.x) + 1.0;
                  u_xlat28 = u_xlat28 * 230.831207;
                  u_xlat28 = exp2(u_xlat28);
                  u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat29 = u_xlat29 / u_xlat0.x;
                  u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat0.x = u_xlat4.x / u_xlat0.x;
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat4.x = u_xlat29 * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat29 * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat29 * u_xlat4.x + 0.458999991;
                  u_xlat29 = u_xlat29 * u_xlat4.x + -0.00286999997;
                  u_xlat29 = u_xlat29 * 1.44269502;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat0.x = (-u_xlat0.x) + 1.0;
                  u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
                  u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
                  u_xlat0.x = u_xlat0.x * 1.44269502;
                  u_xlat0.x = exp2(u_xlat0.x);
                  u_xlat0.x = u_xlat0.x * 0.25;
                  u_xlat0.x = u_xlat29 * 0.25 + (-u_xlat0.x);
                  u_xlat0.x = u_xlat28 * u_xlat0.x + u_xlat0.y;
                  u_xlat0.x = max(u_xlat0.x, 0.0);
                  u_xlat0.x = min(u_xlat0.x, 50.0);
                  u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
                  u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat4.xyz = exp2(u_xlat4.xyz);
                  u_xlat0.x = u_xlat0.z * u_xlat28;
                  u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat27) + u_xlat0.xyz;
                  u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
                  u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              } else {
                  u_xlat29 = min(u_xlat2.y, -0.00100000005);
                  u_xlat29 = -9.99999975e-05 / u_xlat29;
                  u_xlat5.xyz = vec3(u_xlat29) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
                  u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
                  u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
                  u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
                  u_xlat23 = u_xlat5.y * 5.25 + -6.80000019;
                  u_xlat23 = u_xlat5.y * u_xlat23 + 3.82999992;
                  u_xlat23 = u_xlat5.y * u_xlat23 + 0.458999991;
                  u_xlat14.x = u_xlat5.y * u_xlat23 + -0.00286999997;
                  u_xlat14.x = u_xlat14.x * 1.44269502;
                  u_xlat5.y = exp2(u_xlat14.x);
                  u_xlat23 = u_xlat5.x * 5.25 + -6.80000019;
                  u_xlat23 = u_xlat5.x * u_xlat23 + 3.82999992;
                  u_xlat23 = u_xlat5.x * u_xlat23 + 0.458999991;
                  u_xlat5.x = u_xlat5.x * u_xlat23 + -0.00286999997;
                  u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
                  u_xlat5.x = exp2(u_xlat5.x);
                  u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
                  u_xlat14.xz = vec2(u_xlat29) * vec2(0.5, 20.0);
                  u_xlat6.xyz = u_xlat2.xyz * u_xlat14.xxx;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
                  u_xlat29 = sqrt(u_xlat29);
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat29 = u_xlat29 * 230.831207;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat5.x = u_xlat29 * u_xlat5.x + (-u_xlat5.z);
                  u_xlat5.x = max(u_xlat5.x, 0.0);
                  u_xlat5.x = min(u_xlat5.x, 50.0);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
                  u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat0.xyz = exp2(u_xlat5.xyz);
                  u_xlat29 = u_xlat14.z * u_xlat29;
                  u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat29);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              //ENDIF
              }
              vs_TEXCOORD0.xyz = (-in_POSITION0.xyz);
              u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
              u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
              u_xlat16_30 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
              u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
              u_xlat16_30 = u_xlat16_30 * 0.75 + 0.75;
              u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
              u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
              u_xlat16_30 = dot(_LightColor0.xyz, _LightColor0.xyz);
              u_xlat16_30 = sqrt(u_xlat16_30);
              u_xlat16_30 = max(u_xlat16_30, 0.25);
              u_xlat16_30 = min(u_xlat16_30, 1.0);
              u_xlat16_0.xyz = u_xlat16_0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
          #else
              u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
          #endif
              u_xlat16_8.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
              u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(15.0, 15.0, 15.0);
              u_xlat16_8.xyz = u_xlat16_8.xyz / vec3(u_xlat16_30);
              vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
              vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
              vs_TEXCOORD3.xyz = sqrt(u_xlat16_8.xyz);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	mediump float _SunSize;
          uniform 	mediump float _SunSizeConvergence;
          in highp vec3 vs_TEXCOORD0;
          in mediump vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD2;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec2 u_xlat16_0;
          vec3 u_xlat1;
          bool u_xlatb1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_6;
          float u_xlat10;
          void main()
          {
              u_xlat16_0.x = log2(_SunSize);
              u_xlat16_0.x = u_xlat16_0.x * 0.649999976;
              u_xlat16_0.x = exp2(u_xlat16_0.x);
              u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat1.xyz));
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
          #else
              u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
          #endif
              u_xlat16_3.x = log2(u_xlat16_3.x);
              u_xlat16_3.x = u_xlat16_3.x * _SunSizeConvergence;
              u_xlat16_3.x = exp2(u_xlat16_3.x);
              u_xlat16_6 = (-u_xlat16_3.x) * 1.98000002 + 1.98010004;
              u_xlat16_0.y = u_xlat16_3.x * u_xlat16_3.x + 1.0;
              u_xlat16_0.xy = u_xlat16_0.xy * vec2(10.0, 0.0100164423);
              u_xlat16_6 = log2(u_xlat16_6);
              u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
              u_xlat16_0.x = exp2(u_xlat16_0.x);
              u_xlat16_0.x = max(u_xlat16_0.x, 9.99999975e-05);
              u_xlat16_0.x = u_xlat16_0.y / u_xlat16_0.x;
              u_xlat16_0.x = log2(u_xlat16_0.x);
              u_xlat16_0.x = u_xlat16_0.x * 0.454544991;
              u_xlat16_0.x = exp2(u_xlat16_0.x);
              u_xlat16_3.x = u_xlat1.y * 50.0;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
          #else
              u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlat1.y<0.0);
          #else
              u_xlatb1 = u_xlat1.y<0.0;
          #endif
              u_xlat16_2.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vs_TEXCOORD2.xyz;
              u_xlat16_2.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
              SV_Target0.xyz = (bool(u_xlatb1)) ? u_xlat16_2.xyz : u_xlat16_3.xyz;
              SV_Target0.w = 1.0;
              return;
          }
          
          #endif
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "_SUNDISK_HIGH_QUALITY" }
          
          "!!!!GLES3
          #ifdef VERTEX
          #version 300 es
          
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
          uniform 	mediump vec4 _LightColor0;
          uniform 	mediump float _Exposure;
          uniform 	mediump vec3 _GroundColor;
          uniform 	mediump vec3 _SkyTint;
          uniform 	mediump float _AtmosphereThickness;
          in highp vec4 in_POSITION0;
          out highp vec3 vs_TEXCOORD0;
          out mediump vec3 vs_TEXCOORD1;
          out mediump vec3 vs_TEXCOORD2;
          out mediump vec3 vs_TEXCOORD3;
          vec4 u_xlat0;
          mediump vec3 u_xlat16_0;
          bool u_xlatb0;
          vec4 u_xlat1;
          vec4 u_xlat2;
          mediump vec3 u_xlat16_3;
          vec3 u_xlat4;
          mediump vec3 u_xlat16_4;
          vec4 u_xlat5;
          vec3 u_xlat6;
          mediump vec3 u_xlat16_7;
          mediump vec3 u_xlat16_8;
          float u_xlat9;
          vec3 u_xlat14;
          float u_xlat18;
          float u_xlat23;
          float u_xlat27;
          float u_xlat28;
          float u_xlat29;
          mediump float u_xlat16_30;
          float u_xlat31;
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
              u_xlat1.xyz = (-_SkyTint.xyz) + vec3(1.0, 1.0, 1.0);
              u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000042, 0.300000012) + vec3(0.5, 0.419999987, 0.324999988);
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = u_xlat1.xyz * u_xlat1.xyz;
              u_xlat1.xyz = vec3(1.0, 1.0, 1.0) / u_xlat1.xyz;
              u_xlat16_3.x = log2(_AtmosphereThickness);
              u_xlat16_3.x = u_xlat16_3.x * 2.5;
              u_xlat16_3.x = exp2(u_xlat16_3.x);
              u_xlat16_3.xy = u_xlat16_3.xx * vec2(0.049999997, 0.0314159282);
              u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
              u_xlat27 = inversesqrt(u_xlat27);
              u_xlat2.xyz = vec3(u_xlat27) * u_xlat0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlatb0 = !!(u_xlat2.y>=0.0);
          #else
              u_xlatb0 = u_xlat2.y>=0.0;
          #endif
              if(u_xlatb0){
                  u_xlat0.x = u_xlat2.y * u_xlat2.y + 0.0506249666;
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat0.x = (-u_xlat0.y) * u_xlat27 + u_xlat0.x;
                  u_xlat9 = (-u_xlat0.y) * u_xlat27 + 1.0;
                  u_xlat18 = u_xlat9 * 5.25 + -6.80000019;
                  u_xlat18 = u_xlat9 * u_xlat18 + 3.82999992;
                  u_xlat18 = u_xlat9 * u_xlat18 + 0.458999991;
                  u_xlat9 = u_xlat9 * u_xlat18 + -0.00286999997;
                  u_xlat9 = u_xlat9 * 1.44269502;
                  u_xlat0.y = exp2(u_xlat9);
                  u_xlat0.xyz = u_xlat0.xyx * vec3(0.5, 0.246031836, 20.0);
                  u_xlat4.xyz = u_xlat0.xxx * u_xlat2.xyz;
                  u_xlat4.xyz = u_xlat4.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat27 = sqrt(u_xlat27);
                  u_xlat28 = (-u_xlat27) + 1.0;
                  u_xlat28 = u_xlat28 * 230.831207;
                  u_xlat28 = exp2(u_xlat28);
                  u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat29 = u_xlat29 / u_xlat27;
                  u_xlat31 = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat27 = u_xlat31 / u_xlat27;
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat31 = u_xlat29 * 5.25 + -6.80000019;
                  u_xlat31 = u_xlat29 * u_xlat31 + 3.82999992;
                  u_xlat31 = u_xlat29 * u_xlat31 + 0.458999991;
                  u_xlat29 = u_xlat29 * u_xlat31 + -0.00286999997;
                  u_xlat29 = u_xlat29 * 1.44269502;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat27 = (-u_xlat27) + 1.0;
                  u_xlat31 = u_xlat27 * 5.25 + -6.80000019;
                  u_xlat31 = u_xlat27 * u_xlat31 + 3.82999992;
                  u_xlat31 = u_xlat27 * u_xlat31 + 0.458999991;
                  u_xlat27 = u_xlat27 * u_xlat31 + -0.00286999997;
                  u_xlat27 = u_xlat27 * 1.44269502;
                  u_xlat27 = exp2(u_xlat27);
                  u_xlat27 = u_xlat27 * 0.25;
                  u_xlat27 = u_xlat29 * 0.25 + (-u_xlat27);
                  u_xlat27 = u_xlat28 * u_xlat27 + u_xlat0.y;
                  u_xlat27 = max(u_xlat27, 0.0);
                  u_xlat27 = min(u_xlat27, 50.0);
                  u_xlat5.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat6.xyz = (-vec3(u_xlat27)) * u_xlat5.xyz;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat6.xyz = exp2(u_xlat6.xyz);
                  u_xlat27 = u_xlat0.z * u_xlat28;
                  u_xlat4.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat4.xyz;
                  u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
                  u_xlat0.x = sqrt(u_xlat0.x);
                  u_xlat28 = (-u_xlat0.x) + 1.0;
                  u_xlat28 = u_xlat28 * 230.831207;
                  u_xlat28 = exp2(u_xlat28);
                  u_xlat29 = dot(_WorldSpaceLightPos0.xyz, u_xlat4.xyz);
                  u_xlat29 = u_xlat29 / u_xlat0.x;
                  u_xlat4.x = dot(u_xlat2.xyz, u_xlat4.xyz);
                  u_xlat0.x = u_xlat4.x / u_xlat0.x;
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat4.x = u_xlat29 * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat29 * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat29 * u_xlat4.x + 0.458999991;
                  u_xlat29 = u_xlat29 * u_xlat4.x + -0.00286999997;
                  u_xlat29 = u_xlat29 * 1.44269502;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat0.x = (-u_xlat0.x) + 1.0;
                  u_xlat4.x = u_xlat0.x * 5.25 + -6.80000019;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 3.82999992;
                  u_xlat4.x = u_xlat0.x * u_xlat4.x + 0.458999991;
                  u_xlat0.x = u_xlat0.x * u_xlat4.x + -0.00286999997;
                  u_xlat0.x = u_xlat0.x * 1.44269502;
                  u_xlat0.x = exp2(u_xlat0.x);
                  u_xlat0.x = u_xlat0.x * 0.25;
                  u_xlat0.x = u_xlat29 * 0.25 + (-u_xlat0.x);
                  u_xlat0.x = u_xlat28 * u_xlat0.x + u_xlat0.y;
                  u_xlat0.x = max(u_xlat0.x, 0.0);
                  u_xlat0.x = min(u_xlat0.x, 50.0);
                  u_xlat4.xyz = u_xlat5.xyz * (-u_xlat0.xxx);
                  u_xlat4.xyz = u_xlat4.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat4.xyz = exp2(u_xlat4.xyz);
                  u_xlat0.x = u_xlat0.z * u_xlat28;
                  u_xlat0.xyz = u_xlat0.xxx * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat6.xyz * vec3(u_xlat27) + u_xlat0.xyz;
                  u_xlat4.xyz = u_xlat1.xyz * u_xlat16_3.xxx;
                  u_xlat4.xyz = u_xlat0.xyz * u_xlat4.xyz;
                  u_xlat0.xyz = u_xlat0.xyz * vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              } else {
                  u_xlat29 = min(u_xlat2.y, -0.00100000005);
                  u_xlat29 = -9.99999975e-05 / u_xlat29;
                  u_xlat5.xyz = vec3(u_xlat29) * u_xlat2.xyz + vec3(0.0, 1.00010002, 0.0);
                  u_xlat5.w = dot((-u_xlat2.xyz), u_xlat5.xyz);
                  u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
                  u_xlat5.xy = (-u_xlat5.xw) + vec2(1.0, 1.0);
                  u_xlat23 = u_xlat5.y * 5.25 + -6.80000019;
                  u_xlat23 = u_xlat5.y * u_xlat23 + 3.82999992;
                  u_xlat23 = u_xlat5.y * u_xlat23 + 0.458999991;
                  u_xlat14.x = u_xlat5.y * u_xlat23 + -0.00286999997;
                  u_xlat14.x = u_xlat14.x * 1.44269502;
                  u_xlat5.y = exp2(u_xlat14.x);
                  u_xlat23 = u_xlat5.x * 5.25 + -6.80000019;
                  u_xlat23 = u_xlat5.x * u_xlat23 + 3.82999992;
                  u_xlat23 = u_xlat5.x * u_xlat23 + 0.458999991;
                  u_xlat5.x = u_xlat5.x * u_xlat23 + -0.00286999997;
                  u_xlat5.xyz = u_xlat5.xyy * vec3(1.44269502, 0.25, 0.249900013);
                  u_xlat5.x = exp2(u_xlat5.x);
                  u_xlat5.x = u_xlat5.x * 0.25 + u_xlat5.y;
                  u_xlat14.xz = vec2(u_xlat29) * vec2(0.5, 20.0);
                  u_xlat6.xyz = u_xlat2.xyz * u_xlat14.xxx;
                  u_xlat6.xyz = u_xlat6.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.0, 1.00010002, 0.0);
                  u_xlat29 = dot(u_xlat6.xyz, u_xlat6.xyz);
                  u_xlat29 = sqrt(u_xlat29);
                  u_xlat29 = (-u_xlat29) + 1.0;
                  u_xlat29 = u_xlat29 * 230.831207;
                  u_xlat29 = exp2(u_xlat29);
                  u_xlat5.x = u_xlat29 * u_xlat5.x + (-u_xlat5.z);
                  u_xlat5.x = max(u_xlat5.x, 0.0);
                  u_xlat5.x = min(u_xlat5.x, 50.0);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.yyy + vec3(0.0125663709, 0.0125663709, 0.0125663709);
                  u_xlat5.xyz = (-u_xlat5.xxx) * u_xlat6.xyz;
                  u_xlat5.xyz = u_xlat5.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
                  u_xlat0.xyz = exp2(u_xlat5.xyz);
                  u_xlat29 = u_xlat14.z * u_xlat29;
                  u_xlat5.xyz = u_xlat0.xyz * vec3(u_xlat29);
                  u_xlat6.xyz = u_xlat1.xyz * u_xlat16_3.xxx + vec3(0.0199999996, 0.0199999996, 0.0199999996);
                  u_xlat4.xyz = u_xlat5.xyz * u_xlat6.xyz;
                  u_xlat16_4.xyz = u_xlat4.xyz;
                  u_xlat16_0.xyz = u_xlat0.xyz;
              //ENDIF
              }
              vs_TEXCOORD0.xyz = (-in_POSITION0.xyz);
              u_xlat16_3.xyz = vec3(_GroundColor.xxyz.y * _GroundColor.xxyz.y, _GroundColor.xxyz.z * _GroundColor.xxyz.z, float(_GroundColor.z) * float(_GroundColor.z));
              u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_0.xyz + u_xlat16_4.xyz;
              u_xlat16_3.xyz = u_xlat16_3.xyz * vec3(_Exposure);
              u_xlat16_30 = dot(_WorldSpaceLightPos0.xyz, (-u_xlat2.xyz));
              u_xlat16_30 = u_xlat16_30 * u_xlat16_30;
              u_xlat16_30 = u_xlat16_30 * 0.75 + 0.75;
              u_xlat16_7.xyz = vec3(u_xlat16_30) * u_xlat16_4.xyz;
              u_xlat16_7.xyz = u_xlat16_7.xyz * vec3(_Exposure);
              u_xlat16_30 = dot(_LightColor0.xyz, _LightColor0.xyz);
              u_xlat16_30 = sqrt(u_xlat16_30);
              u_xlat16_30 = max(u_xlat16_30, 0.25);
              u_xlat16_30 = min(u_xlat16_30, 1.0);
              u_xlat16_0.xyz = u_xlat16_0.xyz;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_0.xyz = min(max(u_xlat16_0.xyz, 0.0), 1.0);
          #else
              u_xlat16_0.xyz = clamp(u_xlat16_0.xyz, 0.0, 1.0);
          #endif
              u_xlat16_8.xyz = u_xlat16_0.xyz * _LightColor0.xyz;
              u_xlat16_8.xyz = u_xlat16_8.xyz * vec3(15.0, 15.0, 15.0);
              u_xlat16_8.xyz = u_xlat16_8.xyz / vec3(u_xlat16_30);
              vs_TEXCOORD1.xyz = sqrt(u_xlat16_3.xyz);
              vs_TEXCOORD2.xyz = sqrt(u_xlat16_7.xyz);
              vs_TEXCOORD3.xyz = sqrt(u_xlat16_8.xyz);
              return;
          }
          
          #endif
          #ifdef FRAGMENT
          #version 300 es
          
          precision highp int;
          uniform 	vec4 _WorldSpaceLightPos0;
          uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
          uniform 	mediump float _SunSize;
          uniform 	mediump float _SunSizeConvergence;
          in highp vec3 vs_TEXCOORD0;
          in mediump vec3 vs_TEXCOORD1;
          in mediump vec3 vs_TEXCOORD2;
          in mediump vec3 vs_TEXCOORD3;
          layout(location = 0) out mediump vec4 SV_Target0;
          mediump vec2 u_xlat16_0;
          vec3 u_xlat1;
          bool u_xlatb1;
          mediump vec3 u_xlat16_2;
          mediump vec3 u_xlat16_3;
          mediump float u_xlat16_6;
          float u_xlat10;
          void main()
          {
              u_xlat16_0.x = log2(_SunSize);
              u_xlat16_0.x = u_xlat16_0.x * 0.649999976;
              u_xlat16_0.x = exp2(u_xlat16_0.x);
              u_xlat1.xyz = vs_TEXCOORD0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * vs_TEXCOORD0.xxx + u_xlat1.xyz;
              u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * vs_TEXCOORD0.zzz + u_xlat1.xyz;
              u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
              u_xlat10 = inversesqrt(u_xlat10);
              u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
              u_xlat16_3.x = dot(_WorldSpaceLightPos0.xyz, (-u_xlat1.xyz));
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
          #else
              u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
          #endif
              u_xlat16_3.x = log2(u_xlat16_3.x);
              u_xlat16_3.x = u_xlat16_3.x * _SunSizeConvergence;
              u_xlat16_3.x = exp2(u_xlat16_3.x);
              u_xlat16_6 = (-u_xlat16_3.x) * 1.98000002 + 1.98010004;
              u_xlat16_0.y = u_xlat16_3.x * u_xlat16_3.x + 1.0;
              u_xlat16_0.xy = u_xlat16_0.xy * vec2(10.0, 0.0100164423);
              u_xlat16_6 = log2(u_xlat16_6);
              u_xlat16_0.x = u_xlat16_6 * u_xlat16_0.x;
              u_xlat16_0.x = exp2(u_xlat16_0.x);
              u_xlat16_0.x = max(u_xlat16_0.x, 9.99999975e-05);
              u_xlat16_0.x = u_xlat16_0.y / u_xlat16_0.x;
              u_xlat16_0.x = log2(u_xlat16_0.x);
              u_xlat16_0.x = u_xlat16_0.x * 0.454544991;
              u_xlat16_0.x = exp2(u_xlat16_0.x);
              u_xlat16_3.x = u_xlat1.y * 50.0;
          #ifdef UNITY_ADRENO_ES3
              u_xlat16_3.x = min(max(u_xlat16_3.x, 0.0), 1.0);
          #else
              u_xlat16_3.x = clamp(u_xlat16_3.x, 0.0, 1.0);
          #endif
          #ifdef UNITY_ADRENO_ES3
              u_xlatb1 = !!(u_xlat1.y<0.0);
          #else
              u_xlatb1 = u_xlat1.y<0.0;
          #endif
              u_xlat16_2.xyz = vs_TEXCOORD1.xyz + (-vs_TEXCOORD2.xyz);
              u_xlat16_3.xyz = u_xlat16_3.xxx * u_xlat16_2.xyz + vs_TEXCOORD2.xyz;
              u_xlat16_2.xyz = vs_TEXCOORD3.xyz * u_xlat16_0.xxx + u_xlat16_3.xyz;
              SV_Target0.xyz = (bool(u_xlatb1)) ? u_xlat16_2.xyz : u_xlat16_3.xyz;
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
           Keywords { "_SUNDISK_NONE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "_SUNDISK_NONE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "_SUNDISK_NONE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "_SUNDISK_NONE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "_SUNDISK_NONE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "_SUNDISK_NONE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "_SUNDISK_SIMPLE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "_SUNDISK_SIMPLE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "_SUNDISK_SIMPLE" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "_SUNDISK_SIMPLE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "_SUNDISK_SIMPLE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "_SUNDISK_SIMPLE" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles hw_tier00"
        {
           Keywords { "_SUNDISK_HIGH_QUALITY" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier01"
        {
           Keywords { "_SUNDISK_HIGH_QUALITY" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles hw_tier02"
        {
           Keywords { "_SUNDISK_HIGH_QUALITY" }
          
          "!!!!GLES
          
          
          "
        }
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "_SUNDISK_HIGH_QUALITY" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "_SUNDISK_HIGH_QUALITY" }
          
          "!!!!GLES3
          
          
          "
        }
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "_SUNDISK_HIGH_QUALITY" }
          
          "!!!!GLES3
          
          
          "
        }
      }
      
    } // end phase
  }
  FallBack ""
}
