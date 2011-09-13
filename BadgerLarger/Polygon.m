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
    
    gpc_vertex *vertexList;
    gpc_vertex *vertexListStepper;

    vertexList = (gpc_vertex *)malloc(sizeof(gpc_vertex) * vertexCount);
    vertexListStepper = vertexList;
    
    for (int i = 0; i < vertexCount; i++) 
    {
        Vertex *vertex = [vertices objectAtIndex:i];
        
        gpc_vertex *gpcVertex;
        gpcVertex = (gpc_vertex *)malloc(sizeof(gpc_vertex));
        gpcVertex -> x = vertex.x;
        gpcVertex -> y = vertex.y;
        
        *vertexListStepper = *gpcVertex;
        vertexListStepper++;
    }
    
    gpc_vertex_list *currentPolyVertexList;
    currentPolyVertexList = (gpc_vertex_list *)malloc(sizeof(gpc_vertex_list));
    currentPolyVertexList -> num_vertices = vertexCount;
    currentPolyVertexList -> vertex = vertexList;
    
    gpc_vertex_list *vertexListArray;
    vertexListArray = (gpc_vertex_list *)malloc(sizeof(gpc_vertex_list));
    vertexListArray = currentPolyVertexList;
    
    gpc_polygon *polygon;
    polygon = (gpc_polygon *)malloc(sizeof(gpc_polygon));
    
    polygon -> hole = NULL;
    polygon -> num_contours = 1;
    polygon -> contour = vertexListArray;
    
    return polygon;
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
    
    gpc_polygon currentPolygon = *[Polygon generateGpcPoly:self.vertices];
    gpc_polygon otherPolygon = *[Polygon generateGpcPoly:polygon.vertices];
    
    gpc_polygon intersectPolygon;
    gpc_polygon_clip(GPC_INT, &currentPolygon, &otherPolygon, &intersectPolygon);
    
    if (intersectPolygon.num_contours == 0) 
    {
        returnValue = FALSE;   
    }
    else
    {
        returnValue = TRUE;
    }
    
    gpc_free_polygon(&currentPolygon);
    gpc_free_polygon(&otherPolygon);
    gpc_free_polygon(&intersectPolygon);
    
    return returnValue;
}

- (void)dealloc
{
    [_vertices release];
    [super dealloc];
}

@end
