using UnityEngine;

namespace Runningtap
{
    [ExecuteInEditMode]
    public class UVProjection : MonoBehaviour
    {
        public GameObject Locator;
        public GameObject Terrain;

        private Material material;
        private const string BoxPosition = "_BoxPosition";
        private const string BoxScale = "_BoxScale";
        private const string BoxRotation = "_BoxRotation";
        private const string TerrainRotation = "_TerrainRotation";

        private void Awake()
        {
            material = Terrain.GetComponent<Renderer>().material;
        }

        void Update()
        {
            material.SetVector(BoxPosition, Locator.transform.position);
            material.SetVector(BoxScale, Locator.transform.localScale);
            material.SetVector(BoxRotation, Locator.transform.rotation.eulerAngles);
            material.SetVector(TerrainRotation, Terrain.transform.rotation.eulerAngles);
        }
    }
}