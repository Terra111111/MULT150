using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewBehaviourScript : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {

        float hVal = Input.GetAxis("Horizontal");
        float vVal = Input.GetAxis("Vertical");

        if (hVal != 0)
            print("Horizontal movement selected: " + hVal);
        if (vVal != 0)
            print("Vertical movement selected: " + vVal);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
