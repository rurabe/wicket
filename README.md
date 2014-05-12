# Wicket

[![Build Status](https://travis-ci.org/rurabe/wicket.svg?branch=master)](https://travis-ci.org/rurabe/wicket)[![Code Climate](https://codeclimate.com/github/rurabe/wicket.png)](https://codeclimate.com/github/rurabe/wicket)

Wicket is a pure Ruby library for the conversion of [SVG](http://en.wikipedia.org/wiki/Scalable_Vector_Graphics) path data into [Well Known Text (WKT)](http://en.wikipedia.org/wiki/Well-known_text). This is useful for cases when you have SVG input data, but want to store it in a spatial database that accepts WKT such as PostGIS.

Notable features include:
- Translating line paths into WKT Polygons or Multipolygons
- Accepting absolute or relative path commands
- Inversing Y axis measurements (SVG y coordinates decrease as you go up)
- Translates quadratic and cubic curve commands into straight line segments
- Curve definition translation controls
- Decimal math for increased accuracy

Future possible features could include:
- Specifying a maximum level of precision to express decimals in
- Translating non closed paths into Linestrings and Multilines
- Specifying paths for polygons which are exlcusions from the area (donut holes)
- Translating WKT to SVG (although PostGIS already does this)

If you want to see these or any other features, feel free to make an issue or pull request.

Wicket is similar in concept to [SVG-to-WKT.js](https://github.com/davidmcclure/svg-to-wkt), although that project operates within the browser. It also owes credit to [Savage](https://github.com/awebneck/savage) as a reference for the SVG parser. If you need to edit SVG paths, I would recommend checking it out.

## Installation

Add this line to your application's Gemfile:

    gem 'wicket'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wicket

## Configuration

You can pass configuration parameters to Wicket at three times:

- At load time, using an initializer

```ruby
Wicket.configure do |w|
  w.min_angle = 165
  w.min_angle_unit = :degrees
end
```

- At instantiation time (overrides the initializer)

```ruby
Wicket::SVGPath.new("M10 10H20l10 10H10z",
  min_angle: 165,
  min_angle_unit: :degrees
)
```

- At conversion time (overrides the initializer and instantiation)

```ruby
  path = Wicket::SVGPath.new("M10 10H20l10 10H10z")
  path.to_polygon(min_angle: 165, min_angle_unit: :degrees)
```

### Configuration Options

There are currently two configuration options:

1. `min_angle`

  This is the minimum angle allowed when translating a curve into a series of straight lines. A higher minimum will require more line segments, more vertices, and more text, but it will get you a more accurate line.

  There are 4 ways to describe an angle to Wicket, and luckily Wicket is pretty smart about figuring out which one you want, although, as noted below, you can explicitly state which one you want.

  1. `decimal_percentage`

    If the `min_angle` is greater than 0 and less than 1, Wicket assumes you are expressing a decimal percentage of the maximum total angle (180 degrees, or Pi radians). For example, 0.9 would indicate that you only want to allow angles of 0.9 * Pi radians or 0.9 * 180 degrees.

  2. `radians`

    If the `min_angle` is greater than or equal to 1 and less than Pi, it will assume you are talking in radians.

  3. `percentage`

    If the `min_angle` is greater than or equal to Pi, and less than 100 it will assume you are talking in percentage terms. This is the same as #1 except multiplied by 100.

  4. `degrees`

    If the `min_angle` is greater than or equal to 100, but less than 180, it will assume you are talking in degrees.

  Obviously, this must be a numeric value greater than 0 and less than 180.

2. `min_angle_unit`
  
  As noted above, this should rarely be necessary, but sometimes it can be included for explcitness in the code, or in rare cases, used to override Wicket's guess as to what unit you are using. For example, if you for some reason wanted the `min_angle` to be 0.5 radians, you could explicitly state so and Wicket would comply. This would, however, result in a pretty poorly fit curve, since the above guesses cover all obtuse angles in all four formats.

  This option accepts the same four arguments as above: `decimal_percentage`,`radians`, `percentage`, and `degrees`

## Usage

### Linear paths
```ruby
# one subpath
path = Wicket::SVGPath.new("M10 10H20l10 10H10z")
path.to_polygon 
  # => "POLYGON((10.0 -10.0,20.0 -10.0,30.0 -20.0,10.0 -20.0,10.0 -10.0))"
path.to_multipolygon 
  # => "MULTIPOLYGON(((10.0 -10.0,30.0 -10.0,40.0 -10.0,50.0 -20.0,40.0 -20.0,10.0 -10.0)))"

# two subpaths
path = Wicket::SVGPath.new("M10 10H20l10 10H10z M100 100h10v10h-10z")
path.to_polygon # ONLY THE FIRST SUBPATH!
  # => "POLYGON((10.0 -10.0,20.0 -10.0,30.0 -20.0,10.0 -20.0,10.0 -10.0))"
path.to_multipolygon # both subpaths
  # => "MULTIPOLYGON(((10.0 -10.0,30.0 -10.0,40.0 -10.0,50.0 -20.0,40.0 -20.0,10.0 -10.0)),((100 -100,110 -100,110 -110,100 -110,100 -100)))

```

### Curved paths
```ruby
# one subpath
path = Wicket::SVGPath.new("M10 10H20l10 10H10z")
path.to_polygon 
  # => "POLYGON((10.0 -10.0,20.0 -10.0,30.0 -20.0,10.0 -20.0,10.0 -10.0))"
path.to_multipolygon 
  # => "MULTIPOLYGON(((10.0 -10.0,30.0 -10.0,40.0 -10.0,50.0 -20.0,40.0 -20.0,10.0 -10.0)))"

# two subpaths
path = Wicket::SVGPath.new("M10 10H20l10 10H10z M100 100h10v10h-10z")
path.to_polygon # ONLY THE FIRST SUBPATH!
  # => "POLYGON((10.0 -10.0,20.0 -10.0,30.0 -20.0,10.0 -20.0,10.0 -10.0))"
path.to_multipolygon # both subpaths
  # => "MULTIPOLYGON(((10.0 -10.0,30.0 -10.0,40.0 -10.0,50.0 -20.0,40.0 -20.0,10.0 -10.0)),((100 -100,110 -100,110 -110,100 -110,100 -100)))

```

## Gotchas

- Wicket assumes that a move command (M or m) is part of the polygon edge. It just so happened that a lot of the data I was working with when creating this project was formatted that way. If your cursor moves around a lot and does not intend to define these as edges, be aware.
- Polygons are assumed to have no holes, thus everything inside the path is part of the polygon.
- Each polygon is represented by a subpath. A subpath continues until it is closed by a Z command. Multiple subpaths are represented as individual elements in `#to_multipolygon`, whereas only the first subpath is represented in `#to_polygon`. Make sure your data does not include multiple subpaths if using the `#to_polygon` method.
- "-0.0" is a possible value, [as negative zero is a concept in BigDecimal](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/bigdecimal/rdoc/BigDecimal.html#class-BigDecimal-label-Positive+and+negative+zero).

## Contributing

If you have a path that you think is being mistranslated, please submit a pull request with your path added to `spec/test_cases.yml`, and if possible, the fix.

Otherwise, submit a pull request for any other feature.
