using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightHide : MonoBehaviour
{
    [SerializeField] GameObject _bulb;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.L))
        {
            _bulb.SetActive(!_bulb.active);
        }
    }
}
