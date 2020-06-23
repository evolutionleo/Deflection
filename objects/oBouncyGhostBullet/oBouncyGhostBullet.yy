{
  "spriteId": {
    "name": "sBullet",
    "path": "sprites/sBullet/sBullet.yy",
  },
  "solid": false,
  "visible": true,
  "spriteMaskId": null,
  "persistent": false,
  "parentObjectId": {
    "name": "oBullet",
    "path": "objects/oBullet/oBullet.yy",
  },
  "physicsObject": false,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsGroup": 1,
  "physicsDensity": 0.5,
  "physicsRestitution": 0.1,
  "physicsLinearDamping": 0.1,
  "physicsAngularDamping": 0.1,
  "physicsFriction": 0.2,
  "physicsStartAwake": true,
  "physicsKinematic": false,
  "physicsShapePoints": [],
  "eventList": [
    {"isDnD":false,"eventNum":0,"eventType":0,"collisionObjectId":null,"parent":{"name":"oBouncyGhostBullet","path":"objects/oBouncyGhostBullet/oBouncyGhostBullet.yy",},"resourceVersion":"1.0","name":null,"tags":[],"resourceType":"GMEvent",},
    {"isDnD":false,"eventNum":0,"eventType":4,"collisionObjectId":{"name":"oBullet","path":"objects/oBullet/oBullet.yy",},"parent":{"name":"oBouncyGhostBullet","path":"objects/oBouncyGhostBullet/oBouncyGhostBullet.yy",},"resourceVersion":"1.0","name":null,"tags":[],"resourceType":"GMEvent",},
  ],
  "properties": [
    {"varType":1,"value":"1","rangeEnabled":false,"rangeMin":0.0,"rangeMax":10.0,"listItems":[],"multiselect":false,"filters":[],"resourceVersion":"1.0","name":"bounces","tags":[],"resourceType":"GMObjectProperty",},
  ],
  "overriddenProperties": [
    {"propertyId":{"name":"ygrv","path":"objects/oPhysics_object/oPhysics_object.yy",},"objectId":{"name":"oPhysics_object","path":"objects/oPhysics_object/oPhysics_object.yy",},"value":"0","resourceVersion":"1.0","name":null,"tags":[],"resourceType":"GMOverriddenProperty",},
  ],
  "parent": {
    "name": "Parents",
    "path": "folders/Objects/Parents.yy",
  },
  "resourceVersion": "1.0",
  "name": "oBouncyGhostBullet",
  "tags": [],
  "resourceType": "GMObject",
}