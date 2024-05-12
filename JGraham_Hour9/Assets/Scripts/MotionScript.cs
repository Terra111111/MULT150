using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MotionScript : MonoBehaviour
{

    // Update is called once per frame
    void Update ()
	{
		float xMovement = Input.GetAxis ("Horizontal") * Time.deltaTime;
		float yMovement = Input.GetAxis ("Vertical") * Time.deltaTime;

		transform.Translate (xMovement, yMovement , 0);
	}
}
