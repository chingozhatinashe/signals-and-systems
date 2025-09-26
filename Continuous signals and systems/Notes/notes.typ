#import "@preview/ilm:1.4.1": *
#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.3.2"
#import "@preview/cetz-plot:0.1.1"


#set text(lang: "en")

#show: ilm.with(
  title: [Signals and systems IIA],
  author: "Tinashe Chingozha, PhD",
  date: datetime.today(),
  // abstract: [#lorem(30)],
  figure-index: (enabled: true),
  table-index: (enabled: true),
  listing-index: (enabled: true),
)

= Course Syllabus

+ Introduction to Signals and systems
  - Basic properties of signals and systems.
+ Continuous-Time Fourier Series
  - Definition of exponential Fourier Series.
  - Fourier Series analysis of Linear Time Invariant Continuous-Time Systems
+ Continuous-Time Fourier Transform
  - Definition of the Fourier Integral Transform
  - Fourier Transform analysis of Linear Time Invariant Continuous-Time Systems
+ Butterworth Filter Design
  - Low-Pass Filter design
  - High-Pass Filter design
  - Band-Pass Filter design
  - Band-Stop Filter design
+ Nyquist Sampling Theorem
  - Nuyquist Sampling Theorem for band-limited signals
+ State-Space Analysis
  - Deriving State-Space equations for _RLC_
  - Solution of State-Space equations
  - Transfer Function #sym.arrow.l.r.long State-Space representation
  - Linear transformation of state vector
  - Controllability and Observability

= Introduction to Signals and systems

== Signal properties

=== Periodicity
A signal $x(t)$ is periodic with period $T$ if and only if \
$ x(t) = x(t + n T), "for" n in NN $.

=== Even/Odd signals
The signal $x(t)$ is said to be even if $x(t) = x(-t)$ and odd if $-x(t) = x(-t)$. Any  signal $x(t)$ can be decomposed into an even and odd part $x_e (t)$ and $x_o (t)$
$            x(t) & = &        x_e (t) + x_o (t) \
"where" x_e (t) & = & frac(1, 2)(x(t) + x(-t)) \
        x_o (t) & = & frac(1, 2)(x(t) - x(-t)) $.

It can easily be shown that odd(even) signals have the following properties.
+ The graph of an even signals is symmetric about the vertical axis.
+ The graph of an odd signal has $180^0$ rotational symmetry.
+ The product of two even signals is an even signal.
+ The product of two odd signals is an even signals.
+ The product of an odd signal and even signal is an odd signal.

Decomposing an signal into it's odd and even parts is often useful in simplifying integrals because of the following properties.
$
  integral_(-a)^(a) x_o (t) dif t & = &                          0 \
    integral_(-a)^a x_e (t) dif t & = & 2integral_0^a x_e(t) dif t
$

=== Signal energy
The energy of a signal $x(t)$  denoted $E_x$ is defined as
$ E_x = integral_(-infinity)^(infinity)|x(t)|^2 dif t. $

$E_x$ can be understood as a measure of the size of $x(t)$. The signal $x(t)$ is an _energy_ signal if it has finite energy, a necessary condition for the energy to be finitie is that the signal amplitude $arrow.r.long$ 0 as $|t| arrow.r.long infinity$.

=== Signal power
The power of a signal $x(t)$ denoted $P_x$ is defined as
$ P_x = lim_(T arrow.r infinity) frac(1, T) integral_(-frac(T, 2))^(frac(T, 2)) |x(t)|^2 dif t. $
$P_x$ is the time average of the signal amplitude squared i.e $sqrt(P_x)$ is the root-mean-square(*rms*) value of $x(t)$. The signal $x(t)$ is a _power_ signal if it has finite power.

#showybox(
  frame: (
    border-color: red.darken(50%),
    title-color: red.darken(50%),
    body-color: red.lighten(90%),
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: left,
  ),
  title: "Note",
  [Signal power involves averaging energy over an infinite duration which means a signal with finite energy has zero power, and a signal with finite power has infinite energy. Therefore a signal cannot be both and energy signal and a power signal. There exists signals that are neither energy signals nor power signals for example ramp signals.],
)

== System properties

=== Linearity

Consider a system $bold(H)$ such that $bold(H)(x(t)) = y(t)$ where $x(t)$ is the input and $y(t)$ is the output. The system $bold(H)$ is said to be linear if had the following properties:

- *homogeneity/scaling property* : For $bold(k)$ a complex number $bold(H)(bold(k) x(t)) = bold(k) bold(H)(x(t)) = bold(k) y(t)$.
- *superposition property*: Let the response of system $bold(H)$ to inputs $x_1 (t)$ and $x_2 (t)$ be $y_1 (t) = bold(H)(x_1 (t))$ and $y_2 (t) = bold(H)(x_2(t))$ then $bold(H)(x_1(t) + x_2(t)) = y_1(t) + y_2(t)$.

=== Time invariance
Consider a system $bold(H)$ such that $bold(H)(x(t)) = y(t)$ where $x(t)$ is the input and $y(t)$ is the output. $bold(H)$ is said to be time invariant if $bold(H)(x(t - t_0)) = y(t - t_0), t_0 in RR$. Time shifting the input by $t_0$ shifts the output by $t_0$.

=== Memory
A system $bold(H)$ is said to have memory if the output at time $t_0$ i.e. $y(t_0)$ is a function of/depends on input values other that $x(t_0)$.

=== Invertibility
A system $bold(H)$ is invertible if distinct input results in distinct outputs. For an invertible system $bold(H)$ the exists a system $bold(H)^(-1)$ it's inverse such that $bold(H)^(-1)(bold(H)(x(t))) = x(t)$.

=== Causality
The system $bold(H)$ is causal if the system output at anytime $t_0$ dependence only on input values for $t lt.eq t_0$

=== Bounded Input Bounded Output(BIBO) stability

A system $bold(H)$ is said to be BIBO stable if the output $y(t)$ remains bounded for any bounded input. More precisely for $x(t)$ such that $|x(t)| lt.eq M$ where $M gt 0$, there exists $R > 0$ such that $|bold(H)(x(t))| lt.eq R "for all" t$.

== Signal Models

=== Unit step function

$
  u(t) = cases(
    1 "if" t > 0,
    0 "if" t < 0
  )
$

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (15, 5),
    x-tick-step: 1,
    y-tick-step: 1,
    y-min: -0.1,
    y-max: 1.5,
    x-min: -1,
    x-max: 5,
    x-grid: true,
    y-grid: true,
    {
      plot.add(((-1, 0), (0, 1), (1, 1), (2, 1), (3, 1), (4, 1), (5, 1)), line: "hv")
    },
  )
})

=== Unit Impulse function
The unit impulse denoted $delta(t)$ is the function defined by the following equations
$
                                        delta(t - t_0) & = & 0, t eq.not t_0 \
  integral_(-infinity)^(infinity) delta(t - t_0) dif t & = &               1
$

The impulse function has a useful property, the sifting property that is
$ integral_(-infinity)^(infinity) f(t) delta(t - t_0) dif t = f(t_0) $
$ f(t)delta(t - t_0) = f(t_0)delta(t - t_0) $

== Complex exponential signal
The complex exponential signal $x(t)$ is defined as
$ x(t) = e^(s t), s = sigma + j omega $
which encompases a large variety of signals.

1. Case when $s = 0$
$x(t) = 1$ i.e. models constant signals.

2. Case when $s$ is pure real i.e. $omega = 0$.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (5, 5),
    x-tick-step: 1,
    y-tick-step: 1,
    y-min: 0,
    y-max: 2,
    x-min: -1,
    x-max: 1,
    {
      plot.add(domain: (-1, 1), t => (t, calc.exp(t)))
    },
  )
})

= Continuous-Time Fourier Series

= Continuous-Time Fourier Transform

= Butterworth Filter Design

= Nyquist's Sampling Theorem

= State-Space Analysis

