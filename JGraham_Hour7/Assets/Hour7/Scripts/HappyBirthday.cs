using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HappyBirthday : MonoBehaviour
{

    // Start is called before the first frame update
    void Start()
    {
        Debug.ClearDeveloperConsole();


        int count = 0;
        while (count < 12)
        {
            count++;

            if (count == 3)
            {
                Debug.Log("3 - It's my birthday month!");
                int count2 = 0;


                while (count2 < 31)
                {
                    count2++;
                    if (count2 == 4)
                    {
                        Debug.Log("3 - 4 It's my birthday date!");
                    }
                    else
                    {
                    Debug.Log("3 - "+count2);
                       
                    }
                }

            } else
            {
               Debug.Log(count);
            }
        }
        Debug.Log("final sum: " + count);
    }
    // Update is called once per frame
    void Update()
    {
        
    }
}
