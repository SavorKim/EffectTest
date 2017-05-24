using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(NcController))]

public class NcControllerEditor : FXMakerEditor {
    // Attribute ------------------------------------------------------------------------
    protected NcController m_Sel;

    // Property -------------------------------------------------------------------------
    // Event Function -------------------------------------------------------------------
    void OnEnable() {
        m_Sel = target as NcController;
    }

    void OnDisable() {
    }

    void OnValidate() {
        m_Sel.SetAutoDestructInChildren();
    }


    public override void OnInspectorGUI() {
        AddScriptNameField(m_Sel);

        EditorGUI.BeginChangeCheck();
        {
            serializedObject.Update ();

            m_Sel.AnimFrameCount = EditorGUILayout.IntField(GetCommonContent("animFrameCount"), m_Sel.AnimFrameCountBase);
            EditorGUILayout.PropertyField (serializedObject.FindProperty ("callBackFrames"), true);
            m_Sel.EffectTimeScale = EditorGUILayout.FloatField(GetCommonContent("EffectTimeScale"), m_Sel.EffectTimeScale);
            m_Sel.isLoop = EditorGUILayout.Toggle ("isLoop", m_Sel.isLoop);

            if (GUILayout.Button("アニメーションカウントを取得してみる"))
            {
                m_Sel.SetAnimFrameCountForEditor();
            }
            serializedObject.ApplyModifiedProperties ();

        } 
        if (EditorGUI.EndChangeCheck()) {
            OnEditComponent();
            OnValidate();
        }
    }
}
