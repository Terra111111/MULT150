using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GUIScript : MonoBehaviour
{


    
int buttonInt = 0;
string[] list = {"Easy", "Medium", "Hard"};

void OnGUI()

{
    buttonInt = GUI.Toolbar(new Rect(5, 5, 200, 30), buttonInt, list);
    
}
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
