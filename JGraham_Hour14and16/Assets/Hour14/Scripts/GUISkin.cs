using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GUITestSkin : MonoBehaviour
{
    
public GUISkin skin;void OnGUI()
{
    GUI.skin = skin;
    if(GUI.Button(new Rect(5, 5, 100, 30), "Hello World"))
    {}
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
