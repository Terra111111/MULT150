using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TargetCubeScript2 : MonoBehaviour
{
    public GameObject target { get; private set; }

    // Start is called before the first frame update
    void Start()
    {
        target = GameObject.Find("Cube");
    }

    // Update is called once per frame
    void Update()
    {
        target.transform.Translate(.05f, 0f, 0f); 
        target.transform.Rotate(0f, 0f, 1f); 
        target.transform.localScale = new Vector3(1.5f, 1.5f, 1.5f);
    }
}
