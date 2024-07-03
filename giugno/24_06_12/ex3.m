clear all
clc

% Given camera specifications
W = 720; % Number of horizontal pixels
H = 524; % Number of vertical pixels
pixel_size = 7e-3; % Pixel size in mm
f = 8; % Focal length in mm
L = 2000; % Distance to the plane in mm

% Calculate the size of the sensor in mm
sensor_width = W * pixel_size;
sensor_height = H * pixel_size;

% Calculate the spatial resolutions
horizontal_spatial_resolution = (sensor_width / f) * L;
vertical_spatial_resolution = (sensor_height / f) * L;

% Calculate the angular field of view (in degrees)
fov_horizontal = 2 * atan((sensor_width / 2) / f) * (180 / pi);

% Display the results
fprintf('Horizontal Spatial Resolution: %.2f mm\n', horizontal_spatial_resolution);
fprintf('Vertical Spatial Resolution: %.2f mm\n', vertical_spatial_resolution);
fprintf('Horizontal Field of View: %.2f degrees\n', fov_horizontal);
