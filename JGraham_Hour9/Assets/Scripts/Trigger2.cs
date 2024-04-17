using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Trigger2 : MonoBehaviour
{
    void OnTriggerEnter(Collider other) 
    {
        print ("Entered: " + gameObject.name);
    }
	
	void OnTriggerExit(Collider other) 
    {
        print ("Exited: " + gameObject.name);
    }
	
	void OnTriggerStay(Collider other) 
    {
        print ("Inside: " + gameObject.name);
    }
}
