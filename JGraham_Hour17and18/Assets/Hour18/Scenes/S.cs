using UnityEngine;

public class S : MonoBehaviour
{
    Animator animator;

    void Start()
    {
        animator = GetComponent<Animator>();
    }

    void Update()
    {
        // Play walk animation when 'W' key is pressed
        if (Input.GetKeyDown(KeyCode.S))
        {
            Debug.Log("a");
            animator.SetTrigger("Thisisspin");
        }
        // Add more keypresses and animations as needed
    }
}
