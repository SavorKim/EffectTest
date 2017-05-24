using UnityEngine;

public class NcSortingLayerMobileFixed : NcEffectBehaviour
{
    public string LayerName = "Default";

    public int OrderInLayer = 0;

    public void SetLayerName(string layerName)
    {
        LayerName = layerName;
        foreach( Renderer renderer in GetComponents<Renderer>() )
        {
            renderer.sortingLayerName = layerName;
        }
    }

    public void SetOrderInLayer(int orderInLayer)
    {
        OrderInLayer = orderInLayer;
        foreach( Renderer renderer in GetComponents<Renderer>() )
        {
            renderer.sortingOrder = orderInLayer;
        }
    }
}
