using UnityEngine;

public class CubeControlScript : MonoBehaviour
{
	// A reference to the scene camera. 
	public GameObject mainCamera;

	//Variables that let us control the speed of movement and rotation.
	//Notice how setting a value here sets a default value in Unity
	public float moveSpeed = .5f;
	public float rotateSpeed = 3f;

	// We use these variables to keep track of our items scale
	Vector3 originalScale;
	Vector3 doubleScale;
	bool isEnlarged;

	void Start()
	{
		originalScale = transform.localScale;
		doubleScale = originalScale * 2;
		isEnlarged = false;
	}

	void Update ()
	{
		float xMovement = Input.GetAxis ("Horizontal") * moveSpeed;
		float zMovement = Input.GetAxis ("Vertical") * moveSpeed;
		transform.Translate(xMovement, 0f, zMovement);

		float camRotation = Input.GetAxis ("Mouse Y") * rotateSpeed;
		float cubeRotation = -Input.GetAxis ("Mouse X") * rotateSpeed;
		transform.Rotate(0f, cubeRotation, 0f);
		mainCamera.transform.Rotate(camRotation, 0f, 0f);

		if (Input.GetKeyDown (KeyCode.M))
		{
			if (isEnlarged)
			{
				isEnlarged = false;
				transform.localScale = originalScale;
			}
			else
			{
				isEnlarged = true;
				transform.localScale = doubleScale;
			}
		}
	}
}
