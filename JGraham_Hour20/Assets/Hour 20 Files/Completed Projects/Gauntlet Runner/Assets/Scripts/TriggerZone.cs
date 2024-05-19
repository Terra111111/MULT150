using UnityEngine;

public class TriggerZone : MonoBehaviour
{
	void OnTriggerEnter(Collider other)
	{
		Destroy(other.gameObject);
	}

}
