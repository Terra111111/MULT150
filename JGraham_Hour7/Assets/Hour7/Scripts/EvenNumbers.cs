using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EvenNumbers : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        int count = 22;
        while (count < 102)
        {
            Debug.Log(count);
            count = count + 2;

        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
