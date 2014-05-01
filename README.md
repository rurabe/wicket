# Wicket

[![Build Status](https://travis-ci.org/rurabe/wicket.svg?branch=master)](https://travis-ci.org/rurabe/wicket)[![Code Climate](https://codeclimate.com/github/rurabe/wicket.png)](https://codeclimate.com/github/rurabe/wicket)

Wicket is a pure Ruby library for the conversion of [SVG](http://en.wikipedia.org/wiki/Scalable_Vector_Graphics) path data into [Well Known Text (WKT)](http://en.wikipedia.org/wiki/Well-known_text). This is useful for cases when you have SVG input data, but want to store it in a spatial database that accepts WKT such as PostGIS.

Notable features include:
- Translating line paths into WKT Polygons or Multipolygons
- Accepting absolute or relative path commands
- Inversing Y axis measurements (SVG y coordinates decrease as you go up)
- Decimal math for increased accuracy

Future possible features could include:
- Translating curved paths
- Translating non closed paths into Linestrings and Multilines
- Specifying paths for polygons which are exlcusions from the area (donut holes)
- Translating WKT to SVG (although PostGIS already does this)

If you want to see these or any other features, feel free to make an issue or pull request.

Wicket is similar in concept to [SVG-to-WKT.js](https://github.com/davidmcclure/svg-to-wkt), although that project operates within the browser and focuses much more on the DOM elements. It also owes credit to [Savage](https://github.com/awebneck/savage) as a reference for the SVG parser. If you need to edit SVG paths, I would recommend checking it out.

## Installation

Add this line to your application's Gemfile:

    gem 'wicket'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wicket

## Usage

```ruby
path = Wicket::SVGPath.new("M10 10H20l10 10H10z")
path.to_polygon 
  # => "POLYGON((10.0 -10.0,20.0 -10.0,30.0 -20.0,10.0 -20.0,10.0 -10.0))"
path.to_multipolygon 
  # => "MULTIPOLYGON(((10.0 -10.0,30.0 -10.0,40.0 -10.0,50.0 -20.0,40.0 -20.0,10.0 -10.0)))"
```

## Gotchas

- Wicket assumes that a move command (M or m) is part of the polygon edge. It just so happened that a lot of the data I was working with when creating this project was formatted that way. Eventually I believe this should not be the case and should be able to be toggled on as an option.
- Polygons are assumed to have no holes, thus everything inside the path is part of the polygon.
- Each polygon is represented by a subpath. A subpath continues until it is closed by a Z command. Multiple subpaths are represented as individual elements in `#to_multipolygon`, whereas only the first subpath is represented in `#to_polygon`. Make sure your data does not include multiple subpaths if using the `#to_polygon` method.

## Contributing

1. Fork it ( http://github.com/rurabe/wicket/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
