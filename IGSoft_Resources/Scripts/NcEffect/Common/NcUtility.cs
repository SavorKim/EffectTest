//-----------------------------------------------------------------
/*
    @file   NcUtility.cs

    @brief  FXMakerユーティリティ.

    @author Drecom Co.,Ltd. Genki.Nagasaka

    Copyright(C) Drecom Co., Ltd. All rights reserved.
*/
//-----------------------------------------------------------------
#define __DRECOM_

using UnityEngine;

#if __DRECOM_
/// <summary>
/// FXMakerユーティリティ.
/// </summary>
public static class NcUtility
{
#region 定数.
    private const string DEFAULT_USE_CAMERA_TAG_NAME = "MainCamera"; //!< デフォルトで使用するカメラタグ名.
#endregion

#region 変数.
    private static string _useCameraTagName = DEFAULT_USE_CAMERA_TAG_NAME; //!< FX Makerで使用するカメラタグ名.

    /// <summary>
    /// FX Makerで使用するカメラ.
    /// </summary>
    public static Camera Camera
    {
        get
        {
            if (_cameraInstance == null)
            {
                // 設定されたタグからカメラの参照を引っ張る.
                _cameraInstance = GameObject
                    .FindGameObjectWithTag(_useCameraTagName)
                    .GetComponent<Camera>();
                
                if (_cameraInstance == null)
                {
                    _cameraInstance = Camera.main;
                    Debug.LogWarning("[FX Maker warning] : camera is not found. please check NcController.UseCameraTagName. set MainCamera.");
                }
            }
            return _cameraInstance;
        }
    }
    public static Camera _cameraInstance = null;
#endregion

#region コンストラクタ.
    /// <summary>
    /// コンストラクタ.
    /// </summary>
    static NcUtility ()
    {
    }
#endregion

#region 外部公開メソッド.
    /// <summary>
    /// 使用するカメラのタグ名を設定.
    /// </summary>
    /// <param name="cameraObjectTag">使用するカメラのタグ名.</param>
    public static void SetUseCameraTagName (string cameraObjectTag)
    {
        _useCameraTagName = cameraObjectTag;
        _cameraInstance   = null;
    }
#endregion
}
#endif // __DRECOM_.
