using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class colorchange : MonoBehaviour
{
    [SerializeField]
    private Animation animation;
void Update()
{
        if (Input.GetKeyDown("w"))
        {
            // Plays the walking animation - stops all other animations
            animation.Play("color", PlayMode.StopAll);
        }

    }
   
