module Graphics.Svg.Types
    ( Coord
    , Origin( .. )
    , Point
    , SvgDocument( .. )
    , SvgDrawAttributes( .. )
    , SvgPath( .. )
    , SvgCap( .. )
    , SvgLineJoin( .. )
    , SvgTree( .. )
    , Transform( .. )
    ) where

import Data.Function( on )
import Data.Monoid( Monoid( .. ) )
import Codec.Picture( PixelRGBA8( .. ) )

type Coord = Float

type Point = (Coord, Coord)

data Origin
    = OriginAbsolute
    | OriginRelative
    deriving (Eq, Show)

data SvgPath
    = MoveTo Origin [Point]
    | LineTo Origin [Point]

    | HorizontalTo  Origin [Coord]
    | VerticalTo    Origin [Coord]

    -- | Cubic vezier
    | CurveTo  Origin [(Point, Point, Point)]
    -- | Cubic bezier
    | SmoothCurveTo  Origin [(Point, Point)]
    -- | Quadratic bezier
    | QuadraticBezier  Origin [(Point, Point)]
    -- | Quadratic bezier
    | SmoothQuadraticBezierCurveTo  Origin [Point]
    | ElipticalArc  Origin [(Coord, Coord, Coord, Coord, Coord, Point)]
    | EndPath
    deriving (Eq, Show)

-- | Represent an SVG transformation matrix
data Transform = Transform
    { _transformA :: {-# UNPACK #-} !Coord
    , _transformC :: {-# UNPACK #-} !Coord
    , _transformE :: {-# UNPACK #-} !Coord -- ^ X translation

    , _transformB :: {-# UNPACK #-} !Coord
    , _transformD :: {-# UNPACK #-} !Coord
    , _transformF :: {-# UNPACK #-} !Coord -- ^ Y translation
    }
    deriving (Eq, Show)

transformCombine :: Transform -> Transform -> Transform
transformCombine (Transform a c e
                            b d f)

                 (Transform a' c' e'
                            b' d' f') =
    Transform (a * a' + c * b' {- below b' is zero -})
              (a * c' + c * d' {- below d' is zero -})
              (a * e' + c * f' + e {- below f' is one -})

              (b * a' + d * b' {- below b' is zero -})
              (b * c' + d * d' {- below d' is zero -})
              (b * e' + d * f' + f {- below f' is one -})

instance Monoid Transform where
    mappend = transformCombine
    mempty = Transform 1 0 0
                       0 1 0

data SvgTree
    = SvgNone
    | Group SvgDrawAttributes [SvgTree]
    | Path SvgDrawAttributes [SvgPath]
    | Circle SvgDrawAttributes Point Float
    | Ellipse SvgDrawAttributes Point Float Float
    | Line SvgDrawAttributes Point Point
    deriving (Eq, Show)

data SvgDocument = SvgDocument
    { _svgViewBox  :: (Int, Int, Int, Int)
    , _svgElements :: [SvgTree]
    }
    deriving (Eq, Show)

data SvgCap
    = SvgCapRound
    | SvgCapButt
    | SvgCapSquare
    deriving (Eq, Show)

data SvgLineJoin
    = SvgJoinMiter
    | SvgJoinBevel
    | SvgJoinRound
    deriving (Eq, Show)

data SvgDrawAttributes = SvgDrawAttributes
    { _strokeWidth      :: Maybe Float
    , _strokeColor      :: Maybe PixelRGBA8
    , _strokeOpacity    :: Maybe Float
    , _strokeLineCap    :: Maybe SvgCap
    , _strokeLineJoin   :: Maybe SvgLineJoin
    , _strokeMiterLimit :: Maybe Float
    , _fillColor        :: Maybe PixelRGBA8
    , _fillOpacity      :: Maybe Float
    , _transform        :: Maybe Transform
    }
    deriving (Eq, Show)

mayRight :: Maybe a -> Maybe a -> Maybe a
mayRight _ b@(Just _) = b
mayRight a Nothing = a

mayMerge :: Monoid a => Maybe a -> Maybe a -> Maybe a
mayMerge (Just a) (Just b) = Just $ mappend a b
mayMerge _ b@(Just _) = b
mayMerge a Nothing = a

instance Monoid SvgDrawAttributes where
    mempty =
        SvgDrawAttributes Nothing Nothing Nothing Nothing
                          Nothing Nothing Nothing Nothing
                          Nothing
    mappend a b = SvgDrawAttributes
        { _strokeWidth = (mayRight `on` _strokeWidth) a b
        , _strokeColor =  (mayRight `on` _strokeColor) a b
        , _strokeLineCap = (mayRight `on` _strokeLineCap) a b
        , _strokeOpacity = (mayRight `on` _strokeOpacity) a b
        , _strokeLineJoin = (mayRight `on` _strokeLineJoin) a b
        , _strokeMiterLimit = (mayRight `on` _strokeMiterLimit) a b
        , _fillColor =  (mayRight `on` _fillColor) a b
        , _fillOpacity = (mayRight `on` _fillOpacity) a b
        , _transform =  (mayMerge `on` _transform) a b
        }

