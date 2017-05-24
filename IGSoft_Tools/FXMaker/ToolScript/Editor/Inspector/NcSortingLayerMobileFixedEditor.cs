using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(NcSortingLayerMobileFixed))]

public class NcSortingLayerMobileFixedEditor : FXMakerEditor {
    // Attribute ------------------------------------------------------------------------
    // Property -------------------------------------------------------------------------
    // Event Function -------------------------------------------------------------------
    void OnEnable() {
    }

    void OnDisable() {
    }

    void OnValidate() {
        NcSortingLayerMobileFixed sortingLayer = target as NcSortingLayerMobileFixed;
        sortingLayer.SetLayerName(sortingLayer.LayerName);
        sortingLayer.SetOrderInLayer(sortingLayer.OrderInLayer);
    }

    public override void OnInspectorGUI()
    {
        NcSortingLayerMobileFixed sortingLayer = target as NcSortingLayerMobileFixed;

        EditorGUI.BeginChangeCheck();
        {
            sortingLayer.LayerName = EditorGUILayout.TextField(GetCommonContent("LayerName"), sortingLayer.LayerName);
            sortingLayer.OrderInLayer = EditorGUILayout.IntField(GetCommonContent("OrderInLayer"), sortingLayer.OrderInLayer);
        }

        if (EditorGUI.EndChangeCheck()) {
            OnEditComponent();
            OnValidate();
        }
    }
}
