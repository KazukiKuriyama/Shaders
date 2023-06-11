using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PointController : MonoBehaviour
{
    void Start () {
        MeshFilter[] meshFilters= GetComponentsInChildren<MeshFilter>();
        foreach (var meshFilter in meshFilters)
        {
            meshFilter.mesh.SetIndices(meshFilter.mesh.GetIndices(0),MeshTopology.Points,0);
        }

        SkinnedMeshRenderer[] skinnedMeshRenderers = GetComponentsInChildren<SkinnedMeshRenderer>();
        foreach (var skinnedMeshRenderer in skinnedMeshRenderers)
        {
            // 注意: SkinnedMeshRendererはsharedMeshを直接変更すると、他の同じメッシュを使用しているすべてのオブジェクトに影響を与えます。
            // ユニークなインスタンスを作成するために、ここではメッシュのコピーを作成します。
            Mesh meshCopy = Instantiate(skinnedMeshRenderer.sharedMesh);
            meshCopy.SetIndices(meshCopy.GetIndices(0), MeshTopology.Points, 0);
            skinnedMeshRenderer.sharedMesh = meshCopy;
        }
    }
}