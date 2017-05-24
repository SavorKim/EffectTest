using UnityEngine;
using System.Collections;

public class testController : MonoBehaviour {

    public GameObject target;

	// Use this for initialization
	void Start () {
        NcController con= target.GetComponent<NcController>();
        con.StartWithCallback(callback:terminated);
	}

    void terminated(){
        Debug.Log("terminated.");

    }
	
	// Update is called once per frame
	void Update () {
	
	}
}
