// Savor Util -  2017- Kim SangWon
//
// Script handling sprite alpha, UI Image, UI Text and Lens flares with FadeIn FadeOut, and repeating... 

// Made by SavorK(Shabel@netsgo.com)


using UnityEngine;
using UnityEngine.UI;
using TMPro;
using System.Collections;



public class Savor_SpriteAlpha : MonoBehaviour
{

    public AnimationCurve FadeInCurve;
    public AnimationCurve MainCurve;
    public AnimationCurve FadeOutCurve;
    public float fadeTime = 2.0f;
    public float playTime = 2.0f;
    //public float delayTime = 0.0f;
    public int repeat = 1;
    public bool loop = false;
    public bool NoFI = false;


    private Color _Spr;
    // private float _init_tAlpha;
    // private float _init_iAlpha;
    private float playTimer;
    private float _pTime;
    private SpriteRenderer t;
    private TextMeshPro tM;
    private Image image;
    private Text text;
    private LensFlare lF;
    private float _iniBrightness;
    private int _rep;
    private int _State;
    private AnimationCurve _NowCurve;

    private void Start()
    {
        lF = GetComponent<LensFlare>();
        if(lF)
        _iniBrightness = lF.brightness;
    }

    void OnEnable()
    {

        t = this.GetComponent<SpriteRenderer>();
        //_init_tAlpha = t.color.a;

        image = GetComponent<Image>();
        //_init_iAlpha = image.color.a;

        text = GetComponent<Text>();


        tM = GetComponent<TextMeshPro>();
        

        _rep = repeat;
        if (NoFI == true)
            _State = 1;
        else _State = 0;
        playTimer = 0.0f;
    }


    void Update()
    {
        if (null == t && null == image && null == text && null == lF && null == tM)
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

                if (t)
                    ChangeSpriteAlpha(playTimer);

                if (image)
                    ChangeImageAlpha(playTimer);

                if (text)
                    ChangeTextAlpha(playTimer);

                if (lF)
                    ChangeLensFlareAlpha(playTimer);

                if (tM)
                    ChangeTextMeshProAlpha(playTimer);

                break;

            case 1:
                _NowCurve = MainCurve;
                if (t)
                    ChangeSpriteAlpha(playTimer);

                if (image)
                    ChangeImageAlpha(playTimer);

                if (text)
                    ChangeTextAlpha(playTimer);

                if (lF)
                    ChangeLensFlareAlpha(playTimer);

                if (tM)
                    ChangeTextMeshProAlpha(playTimer);

                break;

            case 2:
                _NowCurve = FadeOutCurve;
                if (t)
                    ChangeSpriteAlpha(playTimer);

                if (image)
                    ChangeImageAlpha(playTimer);

                if (text)
                    ChangeTextAlpha(playTimer);

                if (lF)
                    ChangeLensFlareAlpha(playTimer);

                if (tM)
                    ChangeTextMeshProAlpha(playTimer);

                break;

            default:

                break;

        }



    }




    void ChangeSpriteAlpha(float f)
    {


        _Spr = t.color;
        _Spr.a = Mathf.Lerp(0.0f, 1.0f, _NowCurve.Evaluate(f / _pTime));

        // Debug.Log(playTimer);

        this.GetComponent<SpriteRenderer>().color = _Spr;

    }




    void ChangeImageAlpha(float f)
    {


        _Spr = image.color;
        _Spr.a = Mathf.Lerp(0.0f, 1.0f, _NowCurve.Evaluate(f / _pTime));

        // Debug.Log(playTimer);

        this.GetComponent<Image>().color = _Spr;

    }

    void ChangeTextAlpha(float f)
    {


        _Spr = text.color;
        _Spr.a = Mathf.Lerp(0.0f, 1.0f, _NowCurve.Evaluate(f / _pTime));

        // Debug.Log(playTimer);

        this.GetComponent<Text>().color = _Spr;

    }

    void ChangeLensFlareAlpha(float f)
    {


         //_Bri = lF.brightness;
        float _Bri = _NowCurve.Evaluate(f / _pTime);

        // Debug.Log(playTimer);

        lF.brightness = _Bri * _iniBrightness;

    }


    void ChangeTextMeshProAlpha(float f)
    {


        _Spr = tM.color;
        _Spr.a = Mathf.Lerp(0.0f, 1.0f, _NowCurve.Evaluate(f / _pTime));

        // Debug.Log(playTimer);

        this.GetComponent<TextMeshPro>().color = _Spr;

    }

    /*
        IEnumerator WaitTime(float dTime)
        {

            yield return new WaitForSeconds(dTime);

        }

        */

}