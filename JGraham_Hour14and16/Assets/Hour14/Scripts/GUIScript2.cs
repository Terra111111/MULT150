using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GUIScript2 : MonoBehaviour
{

    bool value = false;void OnGUI()
    {
        value = GUI.Toggle(new Rect(5, 5, 100, 100), value, "toggle", "button");
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
