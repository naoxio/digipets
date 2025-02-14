#version 330

// Input vertex attributes
in vec3 vertexPosition;
in vec2 vertexTexCoord;
in vec3 vertexNormal;
in vec4 vertexColor;

// Output vertex attributes (to fragment shader)
out vec3 fragPosition;
out vec2 fragTexCoord;
out vec4 fragColor;

// Uniform inputs
uniform mat4 matModel;
uniform mat4 matView;
uniform mat4 matProjection;

void main() {
    // Calculate fragment position in world space
    fragPosition = vec3(matModel * vec4(vertexPosition, 1.0));
    fragTexCoord = vertexTexCoord;
    fragColor = vertexColor;
    
    // Remove translation from view matrix to keep skybox centered on camera
    mat4 rotOnlyView = matView;
    rotOnlyView[3] = vec4(0.0, 0.0, 0.0, 1.0);
    
    gl_Position = matProjection * rotOnlyView * matModel * vec4(vertexPosition, 1.0);
}