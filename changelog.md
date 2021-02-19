-*-change-log-*-

v0.12.2.2

 * Update dependencies.

v0.12.0.0

 * Improve filter-element support.

v0.11.0.0

 * Drop support for GHC 7.
 * Remove toPoint, isPathArc, isPathWithArc

v0.10.3.0 September 2020

 * Generic and Hashable instances.

v0.9.0.0 April 2019

 * Performance optimizations.
 * Memo module and render cache.

v0.8.2.0 March 2019

 * Export parser and serializer.

v0.8.1.0 March 2019

 * Filter attributes.

v0.8.0.0 March 2019

 * Remove WithDrawAttributes type class.
 * Remove css and top-level definitions from Document.
 * Basic support for SVG filters.

v0.7.0.0 March 2019

 * fork from svg-tree due to 'reanimate' requiring breaking changes
 * Fix: change x,y rect defaults from '0' to 'auto'.
 * Expose list of named svg colors.
 * Adding: Allow definitions to appear anywhere in an svg document.
 * Change module namespace from Graphics.Svg to Graphics.SvgTree

v0.6.2.3 October 2018

 * GHC 8.6 fixes
 * Adding: Allow definitions to appear anywhere in an svg document.

v0.6.2.2 December 2017

 * Adding `Semigroup` instances for defined `Monoid`, for GHC 8.4

v0.6.2.1 December 2017
 * Workaround/Fix: removed reliance on Template Haskell to derive lenses,
   by writing them directly in the file, using the ddump-splices. For some
   reason Haddock associated with GHC 8.2.2 was entering infinite loop on
   the Types file. Ugly workaround, but at least it works.

v0.6.2 August 2017
 * Fix: gather named elements even outside of <defs> tags.
 * Fix: URL ID now can contain more characters.

v0.6.1: January 2017
 * Fix: some gradient mesh parsing, stop can have style (like with Inkscape 0.92)
 * Fix: norm say "<mesh>" is the global tag
 * Fix: Adding `xlink:href` attribute on patterns
 * Fix: Adding `patternTransform` attribute on patterns

v0.6: September 2016
 * Add SVG 2.0 gradient mesh

v0.5.1.2: September 2016
 * Fix path parsing with white space prefix

v0.5.1.1: May 2016
 * Fix: GHC 8.0 compatibility

v0.5.1: March 2016
 * Fix: serialization of multi criteria css selector.

v0.5: March 2016:
 * Adding: preserveAspectRatio attribute
 * Fix: Application of CSS rules with indirect parent/child relation.

v0.4.2: March 2016
 * Enhancement: avoiding serializatinon of empty class attribute
 * Fix: incorrect deserialization of complex CSS
 * Fix: Really fixing duplicate ID with serialization

v0.4.1: February 2016
 * Fix: fixing duplicate ID with serialization

v0.4: February 2016
 * Breaking change: viewbox types are no longer Int
   but double, sneakingly passed in v0.3.2.2. This
   version acknoweledge this change

V0.3.2.2 February 2016 (Deprecated)
 * Fix: Bad serialization of some None constructors.

v0.3.2.1 October 2015
 * Fix: Don't add '#' for <img> serialization

v0.3.2 August 2015
 * Fix: allow compilation with GHC 7.4

v0.3.1 May 2015
 * Fix: Bumping lens dependency and removing upper bound.

v0.3 April 2015
 * Breaking change: Switching all the numeric types associated to geometry
   to Double precision (thx to Kasbah)

v0.2 April 2015
 * Fix: Differentiating opacity & fill-opacity, as they are
   semantically deferent (BREAKING CHANGE!)

v0.1.1 April 2015
 * Fix: Bumping lens bounds

v0.1.0.2 March 2015
 * Fix: Bumping lens bounds

v0.1.0.1
 * Fix: Lowering some lower bounds

v0.1
 * Initial release
