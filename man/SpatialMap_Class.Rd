% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/slim_classes.R, R/slim_lang.R
\name{SM}
\alias{SM}
\alias{SpatialMap}
\title{SpatialMap}
\description{
Documentation for SpatialMap class from SLiM
}
\details{
This class represents a "spatial map": a grid of values overlaid across
a simulated spatial
landscape, representing some variable that varies across space. This variable
could be something
environmental (elevation, temperature), something that affects local dynamics
(local carryingcapacity
density, local mean dispersal distance), or anything else needed for the model
(years since
the last wildfire in that location, for example). A new spatial map is created
with the
defineSpatialMap() method of Subpopulation, because spatial maps are tightly
associated with
subpopulations; in particular, they must share the spatial bounds of any
subpopulation to which
they have been added, because the spatial map's grid of values is overlaid onto
those spatial
bounds.
There is a constructor for SpatialMap, but it is only used to copy an existing
spatial map:
(object<SpatialMap>$)SpatialMap(string$ name, object<SpatialMap>$ map)
Creates a new SpatialMap object that is a copy of map, named name.
That can be useful if you wish to derive a new spatial map from an existing map,
but it is not
very commonly used. Usually a new map is created with defineSpatialMap(), often
using spatial
data from a PNG image file that has been loaded using the Eidos class Image. If
you wish to add a
spatial map to additional subpopulations, beyond the subpopulation for which the
map was
originally defined, the Subpopulation method addSpatialMap() can be used to do
so, thereby
sharing the map across more than one subpopulation.
The SpatialMap class was added in SLiM 4.1; before that, spatial maps were a
sub-component
of Subpopulation. Splitting spatial maps out into their own class provides more
flexibility to
extend their capabilities in the future.
This class has the following methods (functions):
\itemize{
\item{\code{\link{add}}}
\item{\code{\link{blend}}}
\item{\code{\link{changeColors}}}
\item{\code{\link{changeValues}}}
\item{\code{\link{divide}}}
\item{\code{\link{exp}}}
\item{\code{\link{gridValues}}}
\item{\code{\link{interpolate}}}
\item{\code{\link{mapColor}}}
\item{\code{\link{mapImage}}}
\item{\code{\link{mapValue}}}
\item{\code{\link{multiply}}}
\item{\code{\link{power}}}
\item{\code{\link{range}}}
\item{\code{\link{rescale}}}
\item{\code{\link{sampleImprovedNearbyPoint}}}
\item{\code{\link{sampleNearbyPoint}}}
\item{\code{\link{smooth}}}
\item{\code{\link{subtract}}}
}
This class has the following properties:
\describe{
\item{gridDimensions}{A property of type integer or logical or string or float
or string or integer. This property is a constant, so it is not modifiable.
\strong{Property Description:} The dimensions of the spatial map's grid of
values, in the order of the components of the map's spatiality. For example, a
map with spatiality "xz" and a grid of values that is 500 in the "x" dimension
by 300 in the "z" dimension would return c(500, 300) for this property. }
\item{interpolate}{A property of type integer or logical or string or float
or string or integer. It is of length one (a singleton). This property is
a variable, so it is modifiable. \strong{Property Description:} Whether
interpolation between grid values is enabled (T) or disabled (F). The initial
value of this property is set by defineSpatialMap(), but it can be changed.
The interpolation performed is linear; for cubic interpolation, use the
interpolate() method. }
\item{name}{A property of type integer or logical or string or float or string
or integer. It is of length one (a singleton). This property is a constant, so
it is not modifiable. \strong{Property Description:} The name of the spatial
map, usually as provided to defineSpatialMap(). The names of spatial maps must
be unique within any given subpopulation, but the same name may be reused for
different spatial maps in different subpopulations. The name is used to identify
a map for methods such as spatialMapValue(), and is also used for display in
SLiMgui. }
\item{spatialBounds}{A property of type integer or logical or string or float
or string or integer. This property is a constant, so it is not modifiable.
\strong{Property Description:} The spatial bounds to which the spatial map is
aligned. These bounds come from the subpopulation that originally created the
map, with the defineSpatialMap() method, and cannot be subsequently changed.
All subpopulations that use a given spatial map must match that map's spatial
bounds, so that the map does not stretch or shrink relative to its initial
configuration. The components of the spatial bounds of a map correspond to the
components of the map's spatiality; for example, a map with spatiality "xz"
will have bounds (x0, z0, x1, z1); bounds for "y" are not included, since that
dimension is not used by the spatial map. }
\item{spatiality}{A property of type integer or logical or string or float
or string or integer. It is of length one (a singleton). This property is a
constant, so it is not modifiable. \strong{Property Description:} The spatiality
of the map: the subset of the model's dimensions that are used by the spatial
map. The spatiality of a map is configured by defineSpatialMap() and cannot
subsequently be changed. For example, a 3D model (with dimensionality "xyz")
might define a 2D spatial map with spatiality "xz", providing spatial values
that do not depend upon the "y" dimension. Often, however, the spatiality of a
map will match the dimensionality of the model. }
\item{tag}{A property of type integer or logical or string or float or string
or integer. It is of length one (a singleton). This property is a variable, so
it is modifiable. \strong{Property Description:} A user-defined integer value.
The value of tag is initially undefined, and it is an error to try to read
it; if you wish it to have a defined value, you must arrange that yourself by
explicitly setting its value prior to using it elsewhere in your code. The value
of tag is not used by SLiM; it is free for you to use. See also the getValue()
and setValue() methods (provided by the Dictionary class; see the Eidos manual),
for another way of attaching state to spatial maps.}

}
}
\seealso{
Other SpatialMap: 
\code{\link{add}()},
\code{\link{blend}()},
\code{\link{changeColors}()},
\code{\link{changeValues}()},
\code{\link{divide}()},
\code{\link{exp}()},
\code{\link{gridValues}()},
\code{\link{interpolate}()},
\code{\link{mapColor}()},
\code{\link{mapImage}()},
\code{\link{mapValue}()},
\code{\link{multiply}()},
\code{\link{power}()},
\code{\link{range}()},
\code{\link{rescale}()},
\code{\link{sampleImprovedNearbyPoint}()},
\code{\link{sampleNearbyPoint}()},
\code{\link{smooth}()},
\code{\link{subtract}()}
}
\concept{SpatialMap}
