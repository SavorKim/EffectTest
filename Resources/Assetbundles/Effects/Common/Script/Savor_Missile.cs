using UnityEngine;
using System.Collections;

public class Savor_Missile : MonoBehaviour {

    public int life = 3;
    public GameObject HitEffect;
    

    void OnTriggerEnter(Collider collision)
    {
        
        -- life ;
        Instantiate(HitEffect, collision.transform.position, HitEffect.transform.rotation);
        Debug.Log("Hit");

        if (life < 1)
        {
            GameObject.Destroy(this.gameObject);
        }
    }
}
