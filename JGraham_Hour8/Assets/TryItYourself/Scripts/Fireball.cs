using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Fireball : MonoBehaviour
{
    private int TakeDamageFromFireball()
    {

        return 20;
    }
    private int TakeDamageFromFireball(int y)
    {

        return y;
    }
    private int TakeDamageFromFireball(int x, int y)
    {

        return x + y;
    }
    // Start is called before the first frame update
    void Start()
    {

        int x = TakeDamageFromFireball(); 
        print("Player health: " + x);


        int y = TakeDamageFromFireball(25); 
        print("Player health: " + y);


        int z = TakeDamageFromFireball(30, 50);
        print("Player health: " + z);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
