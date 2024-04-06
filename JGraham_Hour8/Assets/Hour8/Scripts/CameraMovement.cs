using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMovement : MonoBehaviour
{
    // Start is called before the first frame update

    private float rotationSpeed = 500.0f;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
        {
            CamOrbit();
        }
    }

    private void CamOrbit()
    {
        if(Input.GetAxis("Mouse Y") != 0 || Input.GetAxis("Mouse X") != 0 )
        {
            float verticalInput = Input.GetAxis("Mouse Y") * rotationSpeed * Time.deltaTime;
            float horizontalInput = Input.GetAxis("Mouse X") * rotationSpeed * Time.deltaTime;
            transform.Rotate(Vector3.right, verticalInput);
            transform.Rotate(Vector3.up, horizontalInput, Space.World);
        }
    }

}
