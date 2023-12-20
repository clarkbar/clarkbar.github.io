#import "typst-cd.typ": *
#import "template.typ": *
#show: ams-article.with(
  title: "Geometrization of chromatic homotopy theory -- a work in what I'd like to think of as progress", 
  authors: (
    (
      name: "Clark Barwick",
      department: [School of Mathematics],
      organization: [University of Edinburgh],
      email: "clark.barwick@ed.ac.uk",
      url: "https://clarkbar.github.io/"
    ),
  ),
  abstract: [These are notes from a talk I gave at the Newton Institute in June 2023 about an unusual, largely speculative, approach to chromatic homotopy theory.
    The idea is to realize the chromatic filtration on the stable homotopy category as filtration on a category of sheaves on a moduli stack of vector bundles on the Fargues--Fontaine curve.
    The category of sheaves arises from a quantum field theory on the curve, and
    the filtration is induced by the Harder--Narasimhan filtration.],
  paper-size: "a4",
  bibliography-file: "refs.bib",
)

== Acknowledgements
I learned about some of this perspective from lecture notes of an MSRI talk by Laurent Fargues in 2018.
Lars Hesselholt shared these notes with me, and subsequent discussions with him have been enlightening, as always.

My point of view on stratifications was heavily informed by conversations with my PhD students Saul Glasman and Peter Haine,
as well as the work of David Ayala, John Francis, Aaron Mazel-Gee, and Nick Rozenblyum.

Early in my attempts to get this story straight, I had a number of inspirational conversations with Agnes Beaudry, Jeremy Hahn, Mike Hopkins, Tyler Lawson, Tomer Schlank, and Vesna Stojanoska.

The title joke is stolen from Bill Dwyer, Phil Hirschhorn, and Dan Kan.

Obviously none of these brilliant and generous people can be held responsible for the inevitable errors in these notes.

= Chromatic homotopy theory, as viewed from a safe distance

The job of the chromatic homotopy theorist is to break the $infinity$-category $bold("Sp")$ of spectra up into its smallest constituent pieces, along with a set of clear instructions for their reassembly.

== Recollements
The simplest way to break up a stable category $bold(X)$ (such as $bold("Sp")$) is a _recollement_.
This breaks $bold(X)$ into two pieces:
- a fully faithful functor $i_! = i_ast colon bold(Z) arrow.hook bold(X)$ that admits both a left adjoint $i^ast$ and a right adjoint $i^!$, and
- a quotient functor $j^ast = j^! colon bold(X) arrow bold(U)$ that admits both a fully faithful right adjoint $j_ast$, and a fully faithful left adjoint $j_!$.
These two pieces are required to be complementary in the sense that $i_ast$ is the kernel of $j^ast$.

This furnishes us with three exact sequences of categories -- left:
#align(center)[#commutative_diagram(
  node((0,0), [$bold(Z)$]),
  node((0,1), [$bold(X)$]),
  node((0,2), [$bold(U)$,]),
  arr((0,2),(0,1), [$j_!$]),
  arr((0,1),(0,0), [$i^ast$])
)]
middle:
#align(center)[#commutative_diagram(
  node((0,0), [$bold(Z)$]),
  node((0,1), [$bold(X)$]),
  node((0,2), [$bold(U)$,]),
  arr((0,0),(0,1), [$i_ast$], label_pos: -1em),
  arr((0,1),(0,2), [$j^ast$], label_pos: -1em)
)]
and right:
#align(center)[#commutative_diagram(
  node((0,0), [$bold(Z)$]),
  node((0,1), [$bold(X)$]),
  node((0,2), [$bold(U)$;]),
  arr((0,2),(0,1), [$j_ast$]),
  arr((0,1),(0,0), [$i^!$])
)]

For each object $F in bold(X)$, the units and counits of the four adjunctions assemble into a diagram 
#align(center)[#commutative_diagram(
  node((0,0), [$0$]),
  node((0,1), [$j_! j^ast F$]),
  node((0,2), [$j_! j^ast F$]),
  node((1,0), [$i_ast i^! F$]),
  node((1,1), [$F$]),
  node((1,2), [$j_ast j^ast F$]),
  node((2,0), [$i_ast i^! F$]),
  node((2,1), [$i_ast i^ast F$]),
  node((2,2), [$i_ast i^ast j_ast j^ast F$]),
  arr((0,0),(0,1), []),
  arr((0,1),(0,2), [$=$], label_pos: -1em),
  arr((0,0),(1,0), []),
  arr((0,1),(1,1), []),
  arr((0,2),(1,2), []),
  arr((1,0),(1,1), []),
  arr((1,1),(1,2), []),
  arr((1,0),(2,0), [$=$]),
  arr((1,1),(2,1), []),
  arr((1,2),(2,2), []),
  arr((2,0),(2,1), []),
  arr((2,1),(2,2), [])
)]
#h(-1.2em) in which the rows and columns are fiber sequences,
and the lower right hand square is cartesian.

This entire picture can be reconstructed from the following pieces:
- the category $bold(Z)$,
- the category $bold(U)$, and
- the functor $phi = i^ast j_ast colon bold(U) arrow bold(Z)$ (sometimes called the _gluing functor_).
The category $bold(X)$ becomes identified with the "comma category" $bold(Z) arrow.b_(bold(Z)) bold(U)$ consisting of triples $(F_Z, F_U, f)$, where
- $F_Z in bold(Z)$,
- $F_U in bold(U)$, and
- $[f colon F_Z arrow i^ast j_ast F_U] in bold(Z)$.
The functor $bold(X) arrow bold(Z) arrow.b_(bold(Z)) bold(U)$ carries $F$ to $(i^ast F, j^ast F, f)$, where $f colon i^ast F arrow i^ast j_ast j^ast F$ comes from applying $i^ast$ to the unit for the adjunction $(j^ast, j_ast)$.
The functor in the other direction carries $(F_Z, F_U, f)$ to the pullback
$ i_ast F_Z times_(i_ast i^ast j_ast F_U) j_ast F_U. $
This game is sometimes called _Artin gluing_.

There is a visible asymmetry here, and our notation reflects an attitude toward the geometric meaning of this asymmetry.
We want to think of
- $bold(X)$ as a category of sheaves on a geometric object $X$, 
- $bold(Z)$ as the corresponding category of sheaves on a _closed_ subobject $Z subset X$,
- $bold(U)$ as the category of sheaves on an _open_ subobject $U subset X$.
For example, this is exactly how the category of constructible sheaves on your favorite scheme or stratified topological space breaks up.

However, rather confusingly, there is a dual geometric interpretation of recollements, which arises from the following example.
Let $X$ be a scheme, and let $Z$ be a closed subset with open complement $U$.
On the category $bold(X) = bold("QCoh")(X)$ of quasicoherent sheaves on $X$, we then get a recollement the opposite way around:
- $bold(Z) = bold("QCoh")(U)$;
- $j_! (bold(U)) subset bold("QCoh")(X)$ consists of those quasicoherent sheaves that are set-theoretically supported on $Z$, and
- $j_ast (bold(U)) subset bold("QCoh")(X)$ consists of those quasicoherent sheaves that are complete along $Z$.
The roles of 'open' and 'closed' seem to be switched.
This is the geometric interpretation suggested, for example, in the work of Ayala, Mazel-Gee, and Rozenblyum on stratified noncommutative stacks.

It is significant here that $bold(U)$ is not simply $bold("QCoh")(Z)$;
to define that category, we would have had to choose a scheme structure on $Z$, which we didn't do.
And even if we did, the category $bold("QCoh")(Z)$ is not a full subcategory of $bold("QCoh")(X)$
(think of Bockstein).
So the choice of $bold(U)$ in this story does not depend on a scheme structure on $Z$, but it does depend on the closed embedding $Z arrow.hook X$.
In effect, $bold(U)$ "knows about" the formal completion $hat(X)_Z$.

In our interpretation, the geometric meaning of this example is _not_ that the roles of 'open' and 'closed' ought to be reversed.
Instead, the example indicates that a closed _subset_ $Z subset X$ of a scheme shouldn't be considered analogous to a closed submanifold of a manifold in the first place.
The point is that $Z$ includes all nilpotent thickening data, so it more closely resembles an open tubular neighborhood of closed submanifold.
The open set $U$, at least as seen through the lens of $bold("QCoh")(U)$, is more like the closed complement of this tubular neighborhood.

Our attitude thus remains that the category $bold(U)$ is the _open_ part of the recollement, and the category $bold(Z)$ is the _closed_ part of the recollement.
This project is really an effort to apply this geometric interpretation to the structures we encounter in chromatic homotopy theory.

== Geometric backgrounds
The idea that purely category-theoretic information suffices to "do some geometry" goes back at least to Grothendieck.
The Grothendieck--Serre approach to geometry was to consider topological spaces $X$ together with a sheaf of local rings $cal(O)_X$ on $X$.
Such a _locally ringed space_ is then required to be locally isomorphic to one of a family of _local models_.
E.g.:
- A smooth manifold is a paracompact Hausdorff topological space $X$ equipped with a sheaf of local $bold(R)$-algebras $cal(O)_X$ such that locally, $(X, cal(O)_X)$ is isomorphic to $(bold(R)^n,cal(C)^infinity)$.
- A scheme is a spectral topological space $X$ equipped with a sheaf of local rings $cal(O)_X$ such that locally, $(X, cal(O)_X)$ is isomorphic to $"Spec"(A)$ for a ring $A$.

#h(1.2em) What one means by "local" and "ring" now can be adjusted and elaborated by introducing algebraic structures, derived structures, condensed structures, categorified structures, etc., as needed for one's applications.
This opens the door for a bunch of different "geometries,"
which can be formalized in various ways.
Lurie provides a sophisticated approach, but we will be content with a much less refined notion:
a _pregeometric background_ is a pair $(bold(X),cal(A)_bold(X))$ consisting of a topos $bold(X)$ and a sheaf of symmetric monoidal categories $cal(A)_bold(X) colon bold(X)^"op" arrow bold("CAlg")(bold("Cat"))$.

The notion of a pregeometric background is just about the crudest possible categorification of the notion of _ringed space_.
The topos $bold(X)$ will usually be generated by some geometric objects of interest.
The geometry of one of these objects $X in bold(X)$ is then controlled by the symmetric monoidal category $cal(A)_bold(X)(X)$
(or, perhaps, the sheaf of symmetric monoidal categories $U arrow.bar cal(A)_bold(X)(U)$ for $U in bold(X)_(slash X))$.
We are to imagine that the symmetric monoidal category $cal(A)_bold(X)(X)$ functions roughly like $bold("QCoh")(cal(O)_X)$, even when it is not in any sense generated by its tensor unit.
E.g.:
- $bold(X)$ is the topos of sheaves on the site of smooth manifolds (or equivalently on Euclidean spaces);
  $cal(A)_bold(X)$ is the sheaf that carries a manifold $M$ to the symmetric monoidal category of differentiable $cal(C)_M^infinity$-modules.
- $bold(X)$ is the topos of sheaves on the flat site of schemes of finite type over some $k$;
  $cal(A)_bold(X)$ is the sheaf that carries a finite type scheme $X$ to $bold("QCoh")(X)$.
- $bold(X)$ is the topos of sheaves on the flat site of schemes of finite type over some $k$;
  $cal(A)_bold(X)$ is the sheaf that carries a finite type scheme $X$ to $bold("Cnstr")(X;bold(Q)_ell)$, where $ell$ is invertible in $k$.
- $bold(X)$ is the topos of sheaves on the flat site of schemes of finite type over $bold(C)$;
  $cal(A)_bold(X)$ is the sheaf that carries a finite type $bold(C)$-scheme $X$ to $bold("Mod")(cal(D)_X) = bold("QCoh")(X_"dR")$.
- $bold(X)$ is the topos of sheaves on the site of smooth manifolds;
  $cal(A)_bold(X)$ is the sheaf that carries a manifold $M$ to the symmetric monoidal category of local systems (of animae, say).
- $bold(X)$ is the topos of animae;
  $cal(A)_bold(X)$ is the sheaf that carries an anima $S$ to $"Fun"(S,bold("An"))$.

#h(1.2em) A _geometric background_ $(bold(X), bold(E), cal(A)_bold(X))$ consists of a topos $bold(X)$, a wide subcategory $bold(E) subset bold(X)$ that is stable under pullbacks, and a _six-functor formalism_ -- i.e., a lax symmetric monoidal functor
$ cal(A)_bold(X) colon bold("Span")(bold(X),bold(E),bold(X)) arrow bold("Pr")^L $
(the category of presentable categories and left adjoints) that restricts to a sheaf
$bold(X)^"op" = bold("Span")(bold(X),"eq"(bold(X)),bold(X)) arrow bold("Cat")$.
(This description of a six-functor formalism is really due to Liu and Zheng originally.
It was simplified in much more recent work of Mann.
Our discussion here is inspired by Scholze's notes.)

Let's unpack.
The six functors are:
$ times.circle, "Hom", f^ast, f_ast, f_!, f^!. $
First, we obtain a presentably symmetric monoidal category $cal(A)_bold(X) (X)$ for each object $X in bold(X)$, which accounts for the first pair of functors.
If $[f colon X arrow Y] in bold(X)$, then we have an adjunction $(f^ast, f_ast)$ between $cal(A)_bold(X) (Y)$ and $cal(A)_bold(X) (X)$ in which the left adjoint $f^ast$ is symmetric monoidal, and the right adjoint $f_ast$ is lax symmetric monoidal.
If $f in bold(E)$, then we also have an adjunction $(f_!,f^!)$ between $cal(A)_bold(X) (X)$ and $cal(A)_bold(X) (Y)$ in which the left adjoint $f_!$ is a map of $cal(A)_bold(X)(Y)$-modules, so we get a _projection formula_ $f_!(F times.circle f^ast G) = f_! F times.circle G$.
If we have a pullback square
#align(center)[#commutative_diagram(
  node((0, 0), [$X'$]),
  node((0, 1), [$X$]),
  node((1, 0), [$Y'$]),
  node((1, 1), [$Y$]),
  arr((0, 0), (0, 1), [$g$], label_pos: -1em),
  arr((0, 0), (1, 0), [$f$]),
  arr((0, 1), (1, 1), [$f$], label_pos: -1em),
  arr((1, 0), (1, 1), [$g$])
)]
#h(-1.2em) in which $f in bold(E)$, then we obtain the _base change formulas_ $g^ast f_! = f_! g^ast$ and $g^! f_ast = f_ast g^!$.

E.g.:
- $bold(X)$ is the topos of sheaves on the flat site of varieties over the complex numbers; $bold(E)$ consists of separated morphisms locally of finite presentation; $cal(A)_bold(X)$ carries a variety to its category of $cal(D)$-modules.
- $bold(X)$ is the topos of sheaves on the flat site of varieties over $overline(bold(F))_p$; $bold(E)$ consists of separated morphisms locally of finite presentation; $cal(A)_bold(X)$ carries a variety to its category of constructible $ell$-adic sheaves.

#h(1.2em) Let $(bold(X),cal(A)_bold(X))$ be a pregeometric background in which $cal(A)_bold(X)$ is valued in $bold("Pr")^L$.
Let $bold(E) subset bold(X)$ be a wide subcategory that is stable under pullbacks.
In general, to upgrade these data to a geometric background will require more structure.
In certain situations, this can be done in a familiar way:
let $bold(E)',bold(E)'' subset bold(E)$ be two further wide subcategories such that:
- $bold(E)'$ and $bold(E)''$ are each stable under pullbacks;
- every morphism of $bold(E)' sect bold(E)''$ is truncated;
- every morphism $f in bold(E)$ can be factored as $f = h g$ with $g in bold(E)'$ and $h in bold(E)''$;
- if $g in bold(E)'$, then $g^ast$ admits a left adjoint $g_!$ that satisfies base change and the projection formula;
- if $h in bold(E)''$, then the right adjoint $h_ast$ satisfies base change and the projection formula; and
- if $h in bold(E)''$, then $h_ast$ admits a right adjoint $h^!$. 
Then for every $f in bold(E)$, we can define the adjunction $(f_!, f^!)$ as follows:
we factor $f = h g$, where $g in bold(E)'$ and $h in bold(E)''$,
and then we define $f_! = h_ast g_!$, and we define $f^! = h^! g^ast$.
It is a theorem of Mann that this is well-defined.
On categories of schemes, one often uses this to define six-functor formalisms where $bold(E)'$ consists of open immersions, and $bold(E)''$ consists of proper maps.

At various points, we may also wish to assume that $cal(A)_bold(X)$ enjoys a _Kunneth formula_:
$ cal(A)_bold(X) (U times_X V) = cal(A)_bold(X) (U) times.circle_(cal(A)_bold(X) (X)) cal(A)_bold(X) (V), $
for morphisms $U arrow X$ and $V arrow X$ in $bold(E)$.

== Stratifications

== Balmer spectra

== Adelic stratification

The first step, already taken by Serre, is to break up $bold("Sp")$ as a constructible sheaf of categories over $"Spec"(bold(Z))$.
For every prime number $p$, we have the category $bold("Sp")$

== Chromatic stratification

== Etale refinements

= The Fargues--Fontaine curve

== Big picture: Arithmetic topology

== Tilting

== Diamonds

== The curve

== Vector bundles on the curve

== Barsotti--Tate groups and the curve

== Geometrization of local Langlands

== The conjecture

= Quantum field theories on the curve

== Factorization algebras

== Fusion
