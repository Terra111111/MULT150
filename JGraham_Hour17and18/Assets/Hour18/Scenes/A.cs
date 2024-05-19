using UnityEngine;

public class A : MonoBehaviour
{
    Animator animator;

    void Start()
    {
        animator = GetComponent<Animator>();
    }

    void Update()
    {
        // Play walk animation when 'W' key is pressed
        if (Input.GetKeyDown(KeyCode.A))
        {
            Debug.Log("a");
            animator.SetTrigger("Thisishover");
        }
        // Add more keypresses and animations as needed
    }
}
