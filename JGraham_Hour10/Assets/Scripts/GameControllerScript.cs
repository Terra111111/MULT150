using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameControllerScript : MonoBehaviour
{

    public GoalScript red;
    public GoalScript blue;
    public GoalScript orange;
    public GoalScript green;
    public GoalScript choas;

    private bool isGameOver = false;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    
    {
        if(red.IsSolved() && blue.IsSolved() && orange.IsSolved() && green && choas.IsSolved())
        {
            isGameOver = true;
        }
        
    }

    void OnGUI()
    {
        if(isGameOver)
        {
            GUI.Box(new Rect(Screen.width / 2 - 100,
                Screen.height / 2 - 50, 200, 75), "Game Over");
            GUI.Label(new Rect(Screen.width / 2 - 30,
                Screen.height / 2 - 25, 60, 50), "Game Over");
        }
    }
}
