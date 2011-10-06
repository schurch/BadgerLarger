//
//  Polygon.m
//  BadgerLarger
//
//  Created by Stefan Church on 13/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import "Polygon.h"
#import "Vertex.h"


@implementation Polygon

+ (gpc_polygon *)generateGpcPoly:(NSArray *)vertices
{    
    int vertexCount = (int)[vertices count];

    gpc_vertex *vertexList = malloc(sizeof(gpc_vertex) * vertexCount);
    
    for (int i = 0; i < vertexCount; i++) 
    {
        Vertex *vertex = [vertices objectAtIndex:i];
        
        gpc_vertex gpcVertex;
        gpcVertex.x = vertex.x;
        gpcVertex.y = vertex.y;
        
        vertexList[i] = gpcVertex;
    }
    
    gpc_vertex_list *currentPolyVertexList = malloc(sizeof(gpc_vertex_list));
    currentPolyVertexList -> num_vertices = vertexCount;
    currentPolyVertexList -> vertex = vertexList;

    
    gpc_polygon *gpcPolygon = malloc(sizeof(gpc_polygon));
    
    gpcPolygon -> hole = NULL;
    gpcPolygon -> num_contours = 1;
    gpcPolygon -> contour = currentPolyVertexList;
    
    return gpcPolygon;
}

@synthesize vertices = _vertices;

- (id)initWithRect:(CGRect)zoomArea
{
    self = [super init];
    if(self)
    {
        Vertex *vertex1 = [[Vertex alloc] initWithX:zoomArea.origin.x y:zoomArea.origin.y];
        Vertex *vertex2 = [[Vertex alloc] initWithX:(zoomArea.origin.x + zoomArea.size.width) y:zoomArea.origin.y];
        Vertex *vertex3 = [[Vertex alloc] initWithX:(zoomArea.origin.x + zoomArea.size.width) y:(zoomArea.origin.y + zoomArea.size.height)];
        Vertex *vertex4 = [[Vertex alloc] initWithX:zoomArea.origin.x y:(zoomArea.origin.y + zoomArea.size.height)];
                
        NSArray *vertices = [[NSArray alloc] initWithObjects:vertex1, vertex2, vertex3, vertex4, nil];
        
        [vertex1 release];
        [vertex2 release];
        [vertex3 release];
        [vertex4 release];
        
        _vertices = vertices;
    }
    
    return self;
}

- (id)initWithVertices:(NSArray *)vertices
{
    self = [super init];
    if(self)
    {
        [vertices retain];
        _vertices = vertices;
    }
    
    return self;
}

- (BOOL)doesIntersect:(Polygon *)polygon
{
    bool returnValue;

    gpc_polygon *currentPolygon = [Polygon generateGpcPoly:self.vertices];
    gpc_polygon *otherPolygon = [Polygon generateGpcPoly:polygon.vertices];
    
    gpc_polygon *intersectPolygon = malloc(sizeof(gpc_polygon));
    gpc_polygon_clip(GPC_INT, currentPolygon, otherPolygon, intersectPolygon);
    
    if (intersectPolygon -> num_contours == 0) 
    {
        returnValue = FALSE;   
    }
    else
    {
        returnValue = TRUE;
    }
    
    gpc_free_polygon(currentPolygon);
    gpc_free_polygon(otherPolygon);
    gpc_free_polygon(intersectPolygon);
    
    free(currentPolygon);
    free(otherPolygon);
    free(intersectPolygon);
    
    return returnValue;
}

- (void)dealloc
{
    [_vertices release];
    [super dealloc];
}

@end
