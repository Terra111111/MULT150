using UnityEngine;

public class PlayerController : MonoBehaviour
{
    Animator animator;

    void Start()
    {
        animator = GetComponent<Animator>();
    }

    void Update()
    {
        // Play walk animation when 'W' key is pressed
        if (Input.GetKeyDown(KeyCode.W))
        {
            Debug.Log("a");
            animator.SetTrigger("Thisisthesame");
        }
        // Add more keypresses and animations as needed
    }
}
