using UnityEngine;
using System;
using System.Collections.Generic;

#if UNITY_EDITOR
#endif

public class NcController : NcEffectBehaviour
{
    /// <summary>
    /// コールバック用のクラス
    /// </summary>
    [Serializable]
    public class CallBackFrameAndStringValue
    {
        // 指定フレーム
        public int frame;
        // 返す文字列
        public string value;
        // 呼び出されたかどうか
        [HideInInspector]
        public bool isCalled = false;
    }

    private Action _callbackAtPlayTerminated;
    private float _currentPlayFrame;
    private bool _manualEdited = false; //マニュアルでフレームが入力されていればanimFrameCount自動更新しない
    const float TIMESCALE_DEFAULT = 1.0f;
    public float EffectTimeScale = TIMESCALE_DEFAULT;
    // ループ設定用
    public bool isLoop = false;

    [SerializeField]
    private int _animFrameCountBase = 0;
    public float m_CurrentPauseLostTime = 0.0f;
    public float m_PauseLostTime = 0.0f;
    public float m_PauseTime = 0.0f;
    public bool isPause = false;
    private float startTime = 0.0f;

    public int AnimFrameCount
    {
        get
        {
            return (int)(_animFrameCountBase / EffectTimeScale);
        }

        set
        {
            _animFrameCountBase = value;
        }
    }

    public int AnimFrameCountBase
    {
        get
        {
            return _animFrameCountBase;
        }
    }

    public void CopyValue(NcController controller)
    {
        this.EffectTimeScale = controller.EffectTimeScale;
        this.m_CurrentPauseLostTime = controller.m_CurrentPauseLostTime;
        this.m_PauseLostTime = controller.m_PauseLostTime;
        this.m_PauseTime = controller.m_PauseTime;
        this.isPause = controller.isPause;
    }

    // Inspectorで指定したフレームに返す文字列を設定できる
    public CallBackFrameAndStringValue[] callBackFrames = new CallBackFrameAndStringValue [0];
    // フレームコールバック用
    private Action<string> _callBackAtFrame;

    void Awake()
    {
        startTime = Time.time;

        #if UNITY_EDITOR
        #else
//        NsEffectManager.SetActiveRecursively(gameObject, false);
        #endif
    }

    #if UNITY_EDITOR
    void OnValidate() {
        SetAutoDestructInChildren ();
    }

    public void SetAutoDestructInChildren()
    {
        // ループ設定に合わせて子の各コンポーネントのAutoDestructを統一する
        var nca = gameObject.GetComponentsInChildren<NcCurveAnimation> (true);
        for (int i = 0; i < nca.Length; ++i) {
            nca [i].m_bAutoDestruct = !isLoop;
        }
        var pa = gameObject.GetComponentsInChildren<ParticleAnimator> (true);
        for (int i = 0; i < pa.Length; ++i) {
            pa [i].autodestruct = !isLoop;
        }
        var sa = gameObject.GetComponentsInChildren<NcSpriteAnimation> (true);
        for (int i = 0; i < sa.Length; ++i) {
            sa [i].m_bAutoDestruct = !isLoop;
        }
        var ua = gameObject.GetComponentsInChildren<NcUvAnimation> (true);
        for (int i = 0; i < ua.Length; ++i) {
            ua [i].m_bAutoDestruct = !isLoop;
        }

        // TODO:今後の更新でNcControllerが1エフェクトにつき1つだけ付くようになったら以下の処理は消す
        var ncc = gameObject.GetComponentsInChildren<NcController> (true);
        for (int i = 0; i < ncc.Length; ++i) {
            ncc [i].isLoop = isLoop;
        }
    }
    #endif

    public float GetEngineTime()
    {
        if (isPause) return m_PauseTime;
        if (Time.time == 0)
            return 0.000001f;
        return (Time.time - m_PauseLostTime -  m_CurrentPauseLostTime) * EffectTimeScale;
    }

    public float GetEngineDeltaTime()
    {
        return Time.deltaTime * EffectTimeScale;
    }

    public void Pause ()
    {
        if (isPause) return;
        m_PauseTime = Time.time;
        isPause = true;
        var o = GetComponentsInChildren<ParticleSystem>(true);

        foreach (var e in o)
        {
            e.Pause(true);
        }
    }

    public void Resume()
    {
        if (!isPause) return;
        isPause = false;
        var particles = GetComponentsInChildren<ParticleSystem>(true);

        foreach (ParticleSystem particle in particles)
        {
//            Debug.Log("e.startDelay:" + particle.startDelay + " Time.time:" + Time.time + "startTime:" + startTime+ "m_CurrentPauseLostTime:" + m_CurrentPauseLostTime);
            particle.startDelay = Math.Max(particle.startDelay - (Time.time - m_PauseLostTime - m_CurrentPauseLostTime - startTime), 0);
            particle.Play(true);                
        }

        m_PauseLostTime += m_CurrentPauseLostTime;
        m_CurrentPauseLostTime = 0;
    }

    public void Update()
    {
        if (isPause)
        {
            m_CurrentPauseLostTime = Time.time - m_PauseTime;
            return;
        }

        // 30fps基準（NcFrameHelper.FixedSecondPerFrameで定義）のフレーム値で現在フレームを算出
        _currentPlayFrame = Mathf.Min(((Time.time - startTime) / NcFrameHelper.FixedSecondPerFrame) * EffectTimeScale, AnimFrameCount);

        //        Debug.Log("EngineTime:" + GetEngineTime()+" m_CurrentPauseLostTime:"+m_CurrentPauseLostTime);

    }

    void LateUpdate()
    {
        if (isPause) return;

        // フレーム単位のコールバックが設定されている場合、設定されているstring文字列を返して呼び出す
        if (callBackFrames != null) {
            for (int i = 0; i < callBackFrames.Length; i++) {
                var callback = callBackFrames [i];
                if (callback.isCalled) {
                    // 呼ばれていたら次へ
                    continue;
                }
                if (_currentPlayFrame >= callback.frame) {
                    if (_callBackAtFrame != null) {
                        _callBackAtFrame (callback.value);
                        callback.isCalled = true;
                    }
                }
            }
        }

        if(_currentPlayFrame >= AnimFrameCount)
        {
            if (_callbackAtPlayTerminated != null) {
                _callbackAtPlayTerminated();
            }

            if (!isLoop && gameObject.name != "_InstanceObject")
            {
                _callbackAtPlayTerminated = null;
                Destroy (this.gameObject);
            }
            else
            {
                startTime = Time.time;
                _currentPlayFrame = 0;
                foreach (var callback in callBackFrames)
                {
                    callback.isCalled = false;
                }
            }
        }
    }

    public void StartWithCallback(float timeScale = TIMESCALE_DEFAULT, Action callback = null)
    {
        //frameCount時にコールバックする
        _currentPlayFrame = 0;
        _callbackAtPlayTerminated = callback;


        //エフェクトのtimeScale
        EffectTimeScale = timeScale;

        //Restart相当
        gameObject.SetActive(true);
        //        NsEffectManager.RunReplayEffect(gameObject, true);
    }

    //もっとも長いFrameCountを設定する(Editor入力補助機能)
    public void SetAnimFrameCountForEditor()
    {
        #if UNITY_EDITOR
        if(_manualEdited)
        {
            return;
        }
        AnimFrameCount = 0;

        NcCurveAnimation[] curveAnimations = gameObject.GetComponentsInChildren<NcCurveAnimation>(true);
        foreach (NcCurveAnimation curveAnimation in curveAnimations)
        {
            int frameCount = curveAnimation.m_fDurationFrame + curveAnimation.m_fDelayFrame ;
            if(AnimFrameCount < frameCount)
            {
                AnimFrameCount = frameCount;
            }
        }
        NcSpriteAnimation[] spriteAnimations = gameObject.GetComponentsInChildren<NcSpriteAnimation>(true);
        foreach (NcSpriteAnimation spriteAnimation in spriteAnimations)
        {
            int frameCount = spriteAnimation.m_nFrameCount;
            if(AnimFrameCount < frameCount)
            {
                AnimFrameCount = frameCount;
            }
        }
        //Debug.LogFormat("aaa:done{0}", AnimFrameCount);
        #endif
    }

    public void SetTimeScale(float timeScale)
    {
        if (timeScale == 0.0f)
        {
            Pause();
            return;
        }
        EffectTimeScale = timeScale;
    }

    //最後のフレームに到達したか?
    public bool ReachedLastFrameForEditor(int currentFrame)
    {
        bool reached = false;
        #if UNITY_EDITOR
        if(currentFrame >= AnimFrameCount)
        {
            reached = true;
            _currentPlayFrame = 0;
        }
        #endif
        return reached;
    }

    //マニュアルで変更した
    public void SetManualSetForEditor(bool edited)
    {
        #if UNITY_EDITOR
        _manualEdited = edited;
        #endif
    }

    protected override void OnDestroy()
    {
        
    }

    // フレーム単位のコールバックを設定する
    public void SetCallBackAtFrame(Action<string> callback)
    {
        _callBackAtFrame = callback;
    }

    // 現在の再生フレームカウントを取得する
    public float GetCurrentFrameCount()
    {
        return _currentPlayFrame;
    }
}
