function Vector3(_x, _y, _z=0) constructor {

    x = _x;
    y = _y;
    z = _z;

    function Magnitude() {
        return sqrt(x * x + y * y + z * z);
    }

    function Normalize() {
        var magnitude = Magnitude();
        if (magnitude != 0) {
            x /= magnitude;
            y /= magnitude;
            z /= magnitude;
        }
    }

    function Dot(value) {
        return x * value.x + y * value.y + z * value.z;
    }

    function Cross(value) {
        var crossX = y * value.z - z * value.y;
        var crossY = z * value.x - x * value.z;
        var crossZ = x * value.y - y * value.x;
        return new Vector3(crossX, crossY, crossZ);
    }

    function Angle(value) {
        var dotProduct = Dot(value);
        var magnitudeProduct = Magnitude() * value.Magnitude();
        return arccos(dotProduct / magnitudeProduct);
    }

    function Add(value) {
        return new Vector3(x + value.x, y + value.y, z + value.z);
    }

    function Sub(value) {
        return new Vector3(x - value.x, y - value.y, z - value.z);
    }

    function MulScalar(value) {
        return new Vector3(x * value.x, y * value.y, z * value.z);
    }

    function DivideScalar(value) {
        return new Vector3(x / value.x, y / value.y, z / value.z);
    }
	
	function Distance(value) {
        var dx = x - value.x;
        var dy = y - value.y;
        var dz = z - value.z;
        return sqrt(dx * dx + dy * dy + dz * dz);
    }
}