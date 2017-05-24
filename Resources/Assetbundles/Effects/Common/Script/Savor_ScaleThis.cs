// Savor Util -  2017- Kim SangWon
//
// Script handling sprite alpha with FadeIn FadeOut, and repeating... 

// Made by SavorK(Shabel@netsgo.com)


using UnityEngine;
using System.Collections;

public class Savor_ScaleThis : MonoBehaviour {

    public AnimationCurve FadeInCurve;
    public AnimationCurve MainCurve;
    public AnimationCurve FadeOutCurve;
    public float fadeTime = 2.0f;
    public float playTime = 2.0f;
    //public float delayTime = 0.0f;
    public int repeat = 1;
    public bool loop = false;
    public bool NoFI = false;

    
    
    private float _pTime;
    
    private int _rep;
    private int _State;
    private AnimationCurve _NowCurve;


    private Transform _trans = null;
    private float delayTimer = 0.0f;
    private float playTimer = 0.0f;

    Vector3 StartScale;
    Vector3 _Scale;


    // Use this for initialization
    void Start()
    {

        
        StartScale = _trans.localScale;
        

    }

    void OnEnable()
    {

        _trans = GetComponent<Transform>();
        _rep = repeat;
        if (NoFI == true)
            _State = 1;
        else _State = 0;
        playTimer = 0.0f;
    }


    // Update is called once per frame
    void Update () {

        if (null == _trans)
            return; // Skip



        playTimer += Time.deltaTime;



        if (_State == 1)
            _pTime = playTime;
        else
            _pTime = fadeTime;


        if (playTimer > _pTime)
        {
            if (loop == true)
            { _State = 1; }

            else if (_rep > 1)
            {
                _State = 1;
                _rep--;
            }

            else
            { _State++; }



            playTimer = 0.0f;
        }


        switch (_State)
        {
            case 0:
                _NowCurve = FadeInCurve;

                ChangeScale(playTimer);

                break;

            case 1:
                _NowCurve = MainCurve;

                ChangeScale(playTimer);

                break;

            case 2:
                _NowCurve = FadeOutCurve;

                ChangeScale(playTimer);

                break;

            default:

                break;

        }



    }


    void ChangeScale(float f)
    {



        _trans.localScale = StartScale * Mathf.Abs(_NowCurve.Evaluate(f / _pTime));

        // Debug.Log(playTimer);

        

    }
}
