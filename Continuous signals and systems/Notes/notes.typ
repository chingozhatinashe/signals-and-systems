#import "@preview/ilm:1.4.1": *
#import "@preview/showybox:2.0.4": showybox
#import "@preview/cetz:0.3.2"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node


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

A *signal* is a function of one or more independent variables that carries information about a physical phenomenon. Common electrical engineering examples include the voltage across a component, current through a conductor, acoustic pressure recorded by a microphone, and the ECG trace of cardiac activity. Throughout this course the independent variable is time $t in RR$ and we study *continuous-time (CT)* signals — functions defined for every instant $t$, as opposed to *discrete-time (DT)* signals which are defined only at integer time steps.

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

=== Deterministic and random signals
A *deterministic* signal is completely specified by a mathematical expression — its values are known precisely for all time. A *random* (or stochastic) signal takes values that cannot be predicted in advance and must be characterised statistically. This course deals exclusively with deterministic signals.

== Signal operations

Three fundamental operations on the independent variable $t$ transform a signal in time. Understanding these is essential for working with convolution and Fourier analysis.

=== Time shifting

Given $x(t)$, the *time-shifted* signal is $x(t - t_0)$. It delays the signal by $t_0$ seconds when $t_0 > 0$ and advances it by $|t_0|$ seconds when $t_0 < 0$. Every feature of $x(t)$ moves by exactly $t_0$ along the time axis.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (12, 4),
    x-tick-step: 1,
    y-tick-step: 1,
    y-min: -0.2,
    y-max: 1.5,
    x-min: -1,
    x-max: 5,
    x-label: $t$,
    y-label: "",
    axis-style: "left",
    legend: "inner-north-west",
    {
      plot.add(((-1, 0), (0, 1), (1, 0), (5, 0)), line: "hv", label: $x(t)$)
      plot.add(((-1, 0), (2, 1), (3, 0), (5, 0)), line: "hv",
        style: (stroke: (dash: "dashed")), label: $x(t - 2)$)
    },
  )
})

=== Time reversal

The *time-reversed* signal is $x(-t)$, the reflection of $x(t)$ about the vertical axis $t = 0$. A feature that occurs at time $t_1$ in $x(t)$ appears at $-t_1$ in $x(-t)$.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (12, 4),
    x-tick-step: 1,
    y-tick-step: 1,
    y-min: -0.2,
    y-max: 1.5,
    x-min: -3,
    x-max: 3,
    x-label: $t$,
    y-label: "",
    axis-style: "left",
    legend: "inner-north-west",
    {
      plot.add(((-3, 0), (0, 1), (1, 0), (3, 0)), line: "hv", label: $x(t)$)
      plot.add(((-3, 0), (-1, 1), (0, 0), (3, 0)), line: "hv",
        style: (stroke: (dash: "dashed")), label: $x(-t)$)
    },
  )
})

=== Time scaling

The *time-scaled* signal is $x(a t)$ where $a > 0$. When $a > 1$ the signal is *compressed* in time; when $0 < a < 1$ it is *expanded*. A feature at time $t_1$ in $x(t)$ moves to $t_1 / a$ in $x(a t)$.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (12, 4),
    x-tick-step: 1,
    y-tick-step: 1,
    y-min: -0.2,
    y-max: 1.5,
    x-min: -0.5,
    x-max: 3,
    x-label: $t$,
    y-label: "",
    axis-style: "left",
    legend: "inner-north-east",
    {
      plot.add(((-0.5, 0), (0, 1), (1, 0), (3, 0)), line: "hv", label: $x(t)$)
      plot.add(((-0.5, 0), (0, 1), (0.5, 0), (3, 0)), line: "hv",
        style: (stroke: (dash: "dashed")), label: $x(2t)$)
      plot.add(((-0.5, 0), (0, 1), (2, 0), (3, 0)), line: "hv",
        style: (stroke: (paint: blue)), label: $x(t slash 2)$)
    },
  )
})

=== Combined transformations

When operations are combined the order matters. To evaluate $x(a t - t_0)$ from $x(t)$, factor the argument:
$
  x(a t - t_0) = x lr(( a lr((t - t_0 / a)) )).
$
The procedure is then: (1) time-shift $x(t)$ right by $t_0 / a$ to obtain $x(t - t_0/a)$, then (2) time-scale by $a$ to obtain $x(a(t - t_0/a)) = x(a t - t_0)$.

*Example:* Obtain $y(t) = x(2t + 3)$ from $x(t)$.
Rewrite as $x(2(t + 3/2))$. Shift $x(t)$ left by $3/2$ to get $x(t + 3/2)$, then compress by factor 2 to get $x(2(t + 3/2)) = x(2t + 3)$.

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

=== Worked example: system classification

Consider the system $bold(H)$ defined by $y(t) = t dot x(t)$. Classify it against all six properties.

*Linearity:* For inputs $x_1(t)$ and $x_2(t)$ with responses $y_1(t) = t x_1(t)$ and $y_2(t) = t x_2(t)$,
$
  bold(H)(k_1 x_1(t) + k_2 x_2(t)) = t(k_1 x_1(t) + k_2 x_2(t)) = k_1 y_1(t) + k_2 y_2(t).
$
The system is *linear*. $checkmark$

*Time invariance:* Shift the input to $x_1(t) = x(t - t_0)$, giving $y_1(t) = t x(t - t_0)$. But the delayed output is $y(t - t_0) = (t - t_0)x(t - t_0) eq.not y_1(t)$. The system is *time varying*. $times$

*Memory:* $y(t_0) = t_0 x(t_0)$ depends only on $x(t_0)$, so the system is *memoryless*. $checkmark$

*Causality:* Since $y(t_0)$ depends only on $x(t_0)$, the system is *causal*. $checkmark$

*Invertibility:* $x(t) = y(t) / t$ for $t eq.not 0$, but the inverse is undefined at $t = 0$. The system is *not invertible*. $times$

*BIBO stability:* Suppose $|x(t)| lt.eq M$ for all $t$. Then $|y(t)| = |t| |x(t)| lt.eq M|t|$, which is unbounded as $|t| arrow.r infinity$. The system is *not BIBO stable*. $times$

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

=== Unit ramp function

The unit ramp $r(t)$ is defined as
$
  r(t) = cases(
    t "if" t gt.eq 0,
    0 "if" t < 0
  )
$
and can be written compactly as $r(t) = t dot u(t)$. It is neither an energy signal nor a power signal.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (10, 5),
    x-tick-step: 1,
    y-tick-step: 1,
    y-min: -0.2,
    y-max: 3.5,
    x-min: -1,
    x-max: 4,
    x-grid: true,
    y-grid: true,
    x-label: $t$,
    y-label: $r(t)$,
    axis-style: "left",
    {
      plot.add(((-1, 0), (0, 0)))
      plot.add(domain: (0, 3.5), t => (t, t))
    },
  )
})

The unit ramp is the integral of the unit step:
$
  r(t) = integral_(-infinity)^t u(tau) dif tau, quad frac(dif r(t), dif t) = u(t).
$

=== Unit Impulse function
The unit impulse denoted $delta(t)$ is the function defined by the following equations
$
                                        delta(t - t_0) & = & 0, t eq.not t_0 \
  integral_(-infinity)^(infinity) delta(t - t_0) dif t & = &               1
$

The impulse function has a useful property, the sifting property that is
$ integral_(-infinity)^(infinity) f(t) delta(t - t_0) dif t = f(t_0) $
$ f(t)delta(t - t_0) = f(t_0)delta(t - t_0) $

The unit impulse and unit step are related by
$
  u(t) = integral_(-infinity)^t delta(tau) dif tau, quad delta(t) = frac(dif u(t), dif t).
$

The impulse also satisfies the *scaling property*
$
  delta(a t) = frac(1, |a|) delta(t), quad a eq.not 0,
$
which follows from requiring that $integral_(-infinity)^infinity delta(a t) dif t = 1$.

== Complex exponential signal
The complex exponential signal $x(t)$ is defined as
$ x(t) = e^(s t), s = sigma + j omega $
which encompases a large variety of signals.

1. Case when $s = 0$
$x(t) = 1$ i.e. models constant signals.

2. Case when $s$ is pure real i.e. $omega = 0, x(t) = e^(sigma t)$.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  cetz.draw.set-style(axes: (
    y: (label: (anchor: "south-east", offset: -0.2), mark: (end: "stealth", fill: black)),
    x: (label: (anchor: "north", offset: 0.1), mark: (end: "stealth", fill: black)),
  ))

  plot.plot(
    size: (5, 5),
    x-tick-step: 1,
    y-tick-step: 1,
    y-min: 0,
    y-max: 2,
    y-label: "x(t)",
    x-min: -1,
    x-max: 1,
    axis-style: "left",
    legend: "inner-north-west",
    x-label: "t",
    {
      plot.add(domain: (-1, 1), t => (t, calc.exp(t)), label: $sigma > 0$)
    },
  )

  cetz.draw.translate((8, 0))

  plot.plot(
    size: (5, 5),
    x-tick-step: 1,
    y-tick-step: 1,
    y-min: 0,
    y-max: 2,
    y-label: "x(t)",
    x-min: -1,
    x-max: 1,
    axis-style: "left",
    legend: "inner-north-west",
    x-label: "t",
    {
      plot.add(domain: (-1, 1), t => (t, calc.exp(-t)), label: $sigma < 0$)
    },
  )
})

3. Case when $s$ is pure imaginary i.e $sigma = 0, x(t) = e^(j omega t)$.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (5, 5),
    x-tick-step: 1,
    y-tick-step: 1,
    y-min: -1.5,
    y-max: 1.5,
    y-label: "x(t)",
    x-min: -1,
    x-max: 1,
    axis-style: "left",
    legend: "inner-north-west",
    x-label: "t",
    {
      plot.add(domain: (-1, 1), t => (t, calc.cos(2 * calc.pi * t)))
    },
  )
})

4. Case when $s$ is complex i.e $x(t) = e^((sigma + j omega)t) = e^(sigma t)e^(j omega t)$.
#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *


  plot.plot(
    size: (5, 5),
    x-tick-step: 1,
    y-tick-step: 1,
    y-min: -2,
    y-max: 2,
    y-label: "x(t)",
    x-min: -1,
    x-max: 1,
    axis-style: "left",
    legend: "inner-north-west",
    x-label: "t",
    {
      plot.add(domain: (-1, 1), t => (t, calc.exp(0.8 * t) * calc.cos(2 * calc.pi * t)), label: $sigma > 0$)

      plot.add(style: (stroke: (dash: "dashed")), domain: (-1, 1), t => (t, calc.exp(0.8 * t)))

      plot.add(style: (stroke: (dash: "dashed")), domain: (-1, 1), t => (t, -calc.exp(0.8 * t)))
    },
  )

  cetz.draw.translate((8, 0))

  plot.plot(
    size: (5, 5),
    x-tick-step: 1,
    y-tick-step: 1,
    y-min: -2,
    y-max: 2,
    y-label: "x(t)",
    x-min: -1,
    x-max: 1,
    axis-style: "left",
    legend: "inner-north-west",
    x-label: "t",
    {
      plot.add(domain: (-1, 1), t => (t, calc.exp(-0.8 * t) * calc.cos(2 * calc.pi * t)), label: $sigma < 0$)

      plot.add(style: (stroke: (dash: "dashed")), domain: (-1, 1), t => (t, calc.exp(-0.8 * t)))

      plot.add(style: (stroke: (dash: "dashed")), domain: (-1, 1), t => (t, -calc.exp(-0.8 * t)))
    },
  )
})

By Euler's formula
$
  e^(j omega t) = cos(omega t) + j sin(omega t),
$
the complex exponential with pure imaginary exponent $s = j omega$ decomposes into cosine (real part) and sine (imaginary part) components. This leads directly to the real sinusoidal signal.

=== Sinusoidal signal

The *sinusoidal signal* is defined as
$
  x(t) = A cos(omega t + phi)
$
where $A$ is the *amplitude*, $omega$ is the *angular frequency* (rad/s), and $phi$ is the *phase* (rad). The fundamental period is $T = 2pi / omega$ and the cyclic frequency is $f = 1/T = omega/(2pi)$ Hz. Any real sinusoid can be expressed as the real part of a complex exponential:
$
  A cos(omega t + phi) = A "Re" {e^(j(omega t + phi))}.
$

== Time domain system analysis(refresher)

=== Impulse response representation
The impulse response function of an LTI system denoted as $h(t)$ is defined as the system's response to the unit impulse function $delta (t)$.

#diagram(
  spacing: 10pt,
  node-stroke: 2pt,
  edge-stroke: 1pt,
  node((10, 1), [LTI \ System], width: 25mm, height: 15mm, name: <A>),
  edge((0, 1), <A>, "-|>", [$x(t) = delta(t)$]),
  edge(<A>, (18, 1), "-|>", [$y(t) = h(t)$], label-pos: 0.5),
)

The system response to any input $x(t)$ can be expressed as an integral involving the input and the system impulse response function $h(t)$,
$
  y(t) = integral_(-infinity)^infinity x(tau)h(t - tau)d tau = x(t)ast h(t).
$

This integral is called the convolution integral.

==== System properties
1. *Memoryless systems* : An LTI system is memoryless if and only if $h(t) = K delta(t)$, that is $y(t) = K x(t)$.
2. *Invertibility* : An LTI system with impulse response $h(t)$ is invertible only if the function $h_i (t)$ can be found such that $h(t) ast h_i (t) = delta (t)$.
3. *Causality* : An LTI system with impulse response $h(t)$ is causal if $h(t) = 0$ for all $t < 0$.
4. *Stability* : An LTI system with impulse response $h(t)$ is BIBO stable if
$
  integral_(-infinity)^infinity |h(t)| d t < infinity .
$
If $h(t)$ satisfies this condition it is said to be absolutely integrable.

=== Worked convolution example

Compute $y(t) = x(t) ast h(t)$ where
$
  x(t) = u(t) - u(t - 2), quad h(t) = e^(-t) u(t).
$
$x(t)$ is a rectangular pulse of unit amplitude and duration 2 s; $h(t)$ is a causal exponential decay with time constant 1 s.

Using the convolution integral with $x(tau) = 1$ only for $0 lt.eq tau lt.eq 2$:
$
  y(t) = integral_0^2 e^(-(t-tau)) u(t - tau) dif tau.
$

*Case 1, $t < 0$:* $u(t - tau) = 0$ for all $tau in [0, 2]$, so $y(t) = 0$.

*Case 2, $0 lt.eq t < 2$:* The step $u(t - tau)$ is nonzero only for $tau lt.eq t$, so
$
  y(t) = integral_0^t e^(-(t-tau)) dif tau = e^(-t) [e^tau]_0^t = 1 - e^(-t).
$

*Case 3, $t gt.eq 2$:* The step is nonzero for all $tau in [0, 2]$, so
$
  y(t) = integral_0^2 e^(-(t-tau)) dif tau = e^(-t) [e^tau]_0^2 = (e^2 - 1)e^(-t).
$

The complete output is therefore
$
  y(t) = cases(
    0 "if" t < 0,
    1 - e^(-t) "if" 0 lt.eq t < 2,
    (e^2 - 1) e^(-t) "if" t gt.eq 2.
  )
$

Note that $y(t)$ is continuous at $t = 2$: both expressions give $1 - e^(-2) approx 0.865$ there. The output rises from zero, reaches its peak at $t = 2$, and then decays exponentially — the hallmark of an RC-type response to a pulse input.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (12, 5),
    x-tick-step: 1,
    y-tick-step: 0.2,
    y-min: -0.05,
    y-max: 1.0,
    x-min: -0.5,
    x-max: 7,
    x-label: $t$,
    y-label: $y(t)$,
    axis-style: "left",
    {
      plot.add(domain: (-0.5, 0), t => (t, 0))
      plot.add(domain: (0, 2), t => (t, 1 - calc.exp(-t)))
      plot.add(domain: (2, 7), t => (t, (calc.exp(2) - 1) * calc.exp(-t)))
    },
  )
})

= Continuous-Time Fourier Series

== Motivation: Eigenfunctions of LTI Systems

Recall from Chapter 1 that the output of an LTI system with impulse response $h(t)$ is the convolution $y(t) = x(t) ast h(t)$. Suppose the input is the complex exponential $x(t) = e^(j omega t)$. Then
$
  y(t) &= integral_(-infinity)^infinity h(tau) e^(j omega (t - tau)) dif tau \
       &= e^(j omega t) integral_(-infinity)^infinity h(tau) e^(-j omega tau) dif tau \
       &= H(j omega) e^(j omega t),
$
where
$
  H(j omega) = integral_(-infinity)^infinity h(tau) e^(-j omega tau) dif tau
$
is a complex number depending only on $omega$. The output is simply the input $e^(j omega t)$ scaled by $H(j omega)$: the complex exponential passes through an LTI system *unchanged in shape*, multiplied only by the complex constant $H(j omega)$. Signals with this property are called *eigenfunctions* of the system, and $H(j omega)$ is the corresponding *eigenvalue*.

#showybox(
  frame: (
    border-color: blue.darken(30%),
    title-color: blue.darken(30%),
    body-color: blue.lighten(90%),
  ),
  title-style: (color: black, weight: "regular", align: left),
  title: "Key insight",
  [If a periodic signal $x(t)$ can be written as a sum of complex exponentials, then the LTI output $y(t)$ is the same sum with each exponential scaled by $H(j omega)$ at that frequency. This is the central motivation for the Fourier Series.],
)

== Harmonically Related Complex Exponentials

A signal $x(t)$ is periodic with period $T_0$ if $x(t) = x(t + T_0)$ for all $t$. The *fundamental angular frequency* is $omega_0 = 2pi / T_0$ rad/s. The set of complex exponentials
$
  {phi_k (t) = e^(j k omega_0 t), quad k in ZZ}
$
are called *harmonically related* because each has a frequency $k omega_0$ that is an integer multiple (harmonic) of $omega_0$. Each $phi_k(t)$ is itself periodic with period $T_0$.

=== Orthogonality

The harmonically related exponentials satisfy the orthogonality relation
$
  frac(1, T_0) integral_0^(T_0) e^(j k omega_0 t) e^(-j m omega_0 t) dif t = cases(
    1 "if" k = m,
    0 "if" k eq.not m.
  )
$

*Proof:* For $k eq.not m$, the integrand is $e^(j(k-m)omega_0 t)$. Since $k - m$ is a nonzero integer, integrating over exactly one period $T_0$ gives zero. For $k = m$ the integrand is 1 and the integral equals $T_0 / T_0 = 1$.

This orthogonality plays the same role as the dot product of orthogonal basis vectors: it allows each Fourier coefficient to be extracted independently.

== The Exponential Fourier Series

=== Synthesis equation

A periodic signal $x(t)$ with period $T_0$ can be represented as a linear combination of harmonically related complex exponentials:
$
  x(t) = sum_(n = -infinity)^(infinity) c_n e^(j n omega_0 t).
$
This is the *exponential Fourier Series*. The complex constants $c_n$ are the *Fourier coefficients*.

=== Analysis equation

Multiplying both sides of the synthesis equation by $e^(-j m omega_0 t)$ and integrating over one period:
$
  frac(1, T_0) integral_0^(T_0) x(t) e^(-j m omega_0 t) dif t
  &= frac(1, T_0) integral_0^(T_0) sum_n c_n e^(j n omega_0 t) e^(-j m omega_0 t) dif t \
  &= sum_n c_n underbrace(frac(1, T_0) integral_0^(T_0) e^(j(n-m) omega_0 t) dif t, = delta[n - m]) \
  &= c_m.
$
Therefore the Fourier coefficients are given by
$
  c_n = frac(1, T_0) integral_0^(T_0) x(t) e^(-j n omega_0 t) dif t.
$
The integration can be carried out over *any* interval of length $T_0$, not just $[0, T_0]$. The coefficient $c_0 = (1/T_0) integral_0^(T_0) x(t) dif t$ is the time-average (DC value) of $x(t)$.

== The Trigonometric Fourier Series

For a *real-valued* signal $x(t)$, the complex coefficients satisfy the *conjugate symmetry* property $c_(-n) = c_n^*$. Grouping positive and negative frequency terms:
$
  x(t) &= c_0 + sum_(n=1)^infinity (c_n e^(j n omega_0 t) + c_(-n) e^(-j n omega_0 t)) \
       &= a_0 + sum_(n=1)^infinity [a_n cos(n omega_0 t) + b_n sin(n omega_0 t)],
$
where
$
  a_0 = c_0, quad a_n = 2 "Re"{c_n}, quad b_n = -2 "Im"{c_n}.
$
Equivalently, combining cosine and sine into a single sinusoid:
$
  x(t) = a_0 + sum_(n=1)^infinity A_n cos(n omega_0 t + phi_n),
$
where $A_n = 2|c_n|$ and $phi_n = angle.l c_n$. This is the *compact trigonometric* (or amplitude-phase) form.

#showybox(
  frame: (
    border-color: red.darken(50%),
    title-color: red.darken(50%),
    body-color: red.lighten(90%),
  ),
  title-style: (color: black, weight: "regular", align: left),
  title: "Note",
  [For real even signals $b_n = 0$ (cosine series only). For real odd signals $a_n = 0$ (sine series only). Recognising signal symmetry before computing coefficients can halve the integration work.],
)

== Convergence of the Fourier Series

The Fourier Series does not converge for every periodic signal. A set of *sufficient* conditions (Dirichlet conditions) guarantees convergence:

+ $x(t)$ is absolutely integrable over one period: $integral_0^(T_0) |x(t)| dif t < infinity$.
+ $x(t)$ has a finite number of maxima and minima per period.
+ $x(t)$ has a finite number of discontinuities per period, each of finite size.

When these hold, the Fourier Series converges to $x(t)$ at every point of continuity, and to the average $frac{1}{2}[x(t^+) + x(t^-)]$ at each discontinuity.

=== Gibbs Phenomenon

At a jump discontinuity, the partial sum $x_N(t) = sum_(n=-N)^N c_n e^(j n omega_0 t)$ overshoots the signal value by approximately *9% of the jump magnitude*, regardless of how large $N$ is. This overshoot does not diminish as $N arrow.r infinity$; it only narrows. This is the *Gibbs phenomenon*.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  let sq(t) = if calc.rem-euclid(t, 2) < 1 { 1.0 } else { -1.0 }

  let fs(t, N) = {
    let s = 0.0
    for k in range(1, N + 1) {
      let n = 2 * k - 1
      s = s + (4 / (calc.pi * n)) * calc.sin(n * calc.pi * t)
    }
    s
  }

  plot.plot(
    size: (14, 5),
    x-tick-step: 0.5,
    y-tick-step: 1,
    y-min: -1.5,
    y-max: 1.5,
    x-min: -1,
    x-max: 2,
    x-label: $t \/ T_0$,
    y-label: "",
    axis-style: "left",
    legend: "inner-north-east",
    {
      plot.add(domain: (-1, 2), t => (t, fs(t, 1)), label: $N=1$)
      plot.add(domain: (-1, 2), t => (t, fs(t, 5)),
        style: (stroke: (dash: "dashed")), label: $N=5$)
      plot.add(domain: (-1, 2), t => (t, fs(t, 15)),
        style: (stroke: (paint: blue)), label: $N=15$)
    },
  )
})

== Worked Examples

=== Square Wave

Let $x(t)$ be the square wave with amplitude $A$ and period $T_0$:
$
  x(t) = cases(
    A  "if" 0 lt.eq t < T_0 / 2,
    -A "if" T_0 / 2 lt.eq t < T_0.
  )
$

Computing the Fourier coefficients using the analysis equation:
$
  c_n &= frac(1, T_0) [integral_0^(T_0\/2) A e^(-j n omega_0 t) dif t
               + integral_(T_0\/2)^(T_0) (-A) e^(-j n omega_0 t) dif t].
$

For $n eq.not 0$, integrating and simplifying using $omega_0 T_0 = 2pi$:
$
  c_n = frac(A, j n pi) (1 - e^(-j n pi)) = cases(
    frac(2A, j n pi) & n "odd",
    0                & n "even".
  )
$

For $n = 0$: $c_0 = 0$ (the square wave has zero mean). The Fourier Series contains only *odd harmonics*, and the coefficient magnitude decays as $1/n$:
$
  x(t) = frac(4A, pi) sum_(k=0)^infinity frac(1, 2k+1) sin((2k+1) omega_0 t).
$

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  let fs_sq(t, N, A) = {
    let s = 0.0
    for k in range(0, N + 1) {
      let n = 2 * k + 1
      s = s + (1.0 / n) * calc.sin(n * calc.pi * t)
    }
    (4 * A / calc.pi) * s
  }

  plot.plot(
    size: (14, 5),
    x-tick-step: 0.5,
    y-tick-step: 0.5,
    y-min: -1.4,
    y-max: 1.4,
    x-min: -1,
    x-max: 2,
    x-label: $t \/ T_0$,
    y-label: $x_N (t)$,
    axis-style: "left",
    legend: "inner-north-east",
    {
      plot.add(domain: (-1, 2), t => (t, fs_sq(t, 0, 1)), label: $N=1$)
      plot.add(domain: (-1, 2), t => (t, fs_sq(t, 3, 1)),
        style: (stroke: (dash: "dashed")), label: $N=7$)
      plot.add(domain: (-1, 2), t => (t, fs_sq(t, 15, 1)),
        style: (stroke: (paint: blue)), label: $N=31$)
    },
  )
})

=== Periodic Rectangular Pulse Train

Let $x(t)$ be a periodic train of rectangular pulses with amplitude $A$, pulse width $tau$, and period $T_0 > tau$:
$
  x(t) = A, quad |t| lt.eq tau / 2 "within each period."
$

The Fourier coefficients are
$
  c_n = frac(1, T_0) integral_(-tau\/2)^(tau\/2) A e^(-j n omega_0 t) dif t
      = frac(A tau, T_0) "sinc"(n omega_0 tau / 2),
$
where $"sinc"(u) = sin(u)/u$ (unnormalised). Written in terms of the duty cycle $D = tau / T_0$:
$
  c_n = A D , "sinc"(n pi D).
$

Key observations:
- $c_0 = A D$: the DC value equals amplitude times duty cycle.
- Spectral nulls occur at $n = 1/D, 2/D, dots$ (whenever $n pi D$ is a multiple of $pi$).
- Narrower pulses ($D arrow.r 0$) produce a *wider* spectral envelope and more visible harmonics — an instance of the *time–bandwidth trade-off*.

=== Full-Wave Rectified Sinusoid

Let $x(t) = A|cos(omega_0 t)|$. Because the rectification doubles the frequency, $x(t)$ has fundamental period $T_0 / 2$ and angular frequency $2 omega_0$. The Fourier coefficients evaluate to
$
  c_n = frac(2A, pi) frac((-1)^n, 1 - 4n^2).
$
Only *even* harmonics of the original $omega_0$ appear (n = 0, ±2, ±4, …), contrasting with the square wave which contains only odd harmonics. The coefficients decay as $1/n^2$ — faster than the square wave's $1/n$ — because the rectified sinusoid is continuous (no jump discontinuities).

== Properties of the Continuous-Time Fourier Series

Let $x(t) arrow.l.r.long^("FS") c_n$ and $y(t) arrow.l.r.long^("FS") d_n$, both with period $T_0$ and $omega_0 = 2pi/T_0$.

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: (left, left, left),
  table.header([*Property*], [*Time domain*], [*Fourier coefficients*]),
  [Linearity],        [$alpha x(t) + beta y(t)$],   [$alpha c_n + beta d_n$],
  [Time shifting],    [$x(t - t_0)$],               [$c_n e^(-j n omega_0 t_0)$],
  [Time reversal],    [$x(-t)$],                    [$c_(-n)$],
  [Conjugation],      [$x^*(t)$],                   [$c^*_(-n)$],
  [Conj. symmetry],   [$x(t)$ real],                [$c_(-n) = c^*_n$],
  [Multiplication],   [$x(t) dot y(t)$],            [$sum_k c_k d_(n-k)$],
  [Parseval's thm.],  [$(1\/T_0) integral_0^(T_0) |x(t)|^2 dif t$], [$sum_(n=-infinity)^infinity |c_n|^2$],
)

=== Proofs of selected properties

*Time shifting:* Replace $t$ with $t - t_0$ in the synthesis equation:
$
  x(t - t_0) = sum_n c_n e^(j n omega_0 (t - t_0)) = sum_n (c_n e^(-j n omega_0 t_0)) e^(j n omega_0 t).
$
The coefficient of $e^(j n omega_0 t)$ is $c_n e^(-j n omega_0 t_0)$. The *magnitude* $|c_n|$ is unchanged; only the *phase* shifts by $-n omega_0 t_0$.

*Parseval's theorem:* The average power of $x(t)$ equals the sum of powers in each harmonic:
$
  frac(1, T_0) integral_0^(T_0) |x(t)|^2 dif t = sum_(n=-infinity)^infinity |c_n|^2.
$
Proof: substitute the synthesis equation for one factor of $x(t)$ and use orthogonality.

== The Frequency Spectrum

The *amplitude spectrum* $|c_n|$ and *phase spectrum* $angle.l c_n$ plotted against the harmonic index $n$ (or frequency $n omega_0$) form the *line spectrum* of $x(t)$. Because $n$ takes only integer values, the spectrum is *discrete* — energy exists only at $omega = 0, plus.minus omega_0, plus.minus 2 omega_0, dots$

Key observations:
- For real $x(t)$: $|c_(-n)| = |c_n|$ (amplitude spectrum is even) and $angle.l c_(-n) = -angle.l c_n$ (phase spectrum is odd).
- The spectral *envelope* shape is determined by the signal's time-domain shape; for the rect pulse train it follows a $|"sinc"|$ curve.
- Decreasing the period $T_0$ (higher repetition rate) *increases* the harmonic spacing $omega_0 = 2pi/T_0$.
- Decreasing the pulse width $tau$ (for fixed $T_0$) *widens* the sinc envelope, spreading energy to higher harmonics.

== Fourier Series Analysis of LTI Systems

From §2.1, the response of an LTI system with frequency response $H(j omega)$ to $e^(j n omega_0 t)$ is $H(j n omega_0) e^(j n omega_0 t)$. By linearity, for a periodic input $x(t) = sum_n c_n e^(j n omega_0 t)$ the steady-state output is
$
  y(t) = sum_(n=-infinity)^infinity c_n H(j n omega_0) e^(j n omega_0 t).
$
The output Fourier coefficients are $d_n = c_n H(j n omega_0)$: each harmonic is scaled in amplitude by $|H(j n omega_0)|$ and shifted in phase by $angle.l H(j n omega_0)$.

=== Worked example: RC lowpass filter driven by a square wave

Consider a first-order RC lowpass filter with frequency response
$
  H(j omega) = frac(1, 1 + j omega R C).
$
The filter has $|H(j omega)| = 1 / sqrt(1 + (omega R C)^2)$ — it attenuates high-frequency harmonics. Let the input be the square wave from §2.6.1 with $A = 1$, $T_0 = 2pi$ (so $omega_0 = 1$ rad/s), and let $R C = 1$ s. The input Fourier coefficients are $c_n = 2/(j n pi)$ for odd $n$, 0 otherwise. The output coefficients are
$
  d_n = c_n H(j n) = frac(2, j n pi) dot frac(1, 1 + j n), quad n "odd."
$

The output is dominated by the fundamental ($n = plus.minus 1$) since higher harmonics are progressively attenuated. As $R C$ increases the filter becomes more selective and the output approaches a sinusoid.

= Continuous-Time Fourier Transform

== From Fourier Series to the Fourier Transform

In Chapter 2 we represented *periodic* signals as a discrete sum of complex exponentials. Most signals of engineering interest — a single pulse, a decaying transient, a finite-duration waveform — are *aperiodic*. To handle these we extend the Fourier Series by considering what happens when the period $T_0$ grows without bound.

=== The Limiting Argument

Consider a periodic signal $tilde(x)(t)$ with period $T_0$ whose single period $|t| < T_0/2$ matches a given aperiodic signal $x(t)$. As $T_0 arrow.r infinity$ the periodic replica moves infinitely far from the origin and $tilde(x)(t) arrow.r x(t)$ everywhere.

The Fourier coefficients of $tilde(x)(t)$ are
$
  c_n = frac(1, T_0) integral_(-T_0\/2)^(T_0\/2) tilde(x)(t) e^(-j n omega_0 t) dif t.
$
Define the *spectral envelope* $X(j omega)$ by
$
  X(j omega) = integral_(-infinity)^(infinity) x(t) e^(-j omega t) dif t,
$
so that $T_0 c_n = X(j n omega_0)$, i.e. $c_n = X(j n omega_0) / T_0$.

Substituting into the synthesis equation:
$
  tilde(x)(t) = sum_(n = -infinity)^(infinity) c_n e^(j n omega_0 t)
             = sum_(n = -infinity)^(infinity) frac(X(j n omega_0), T_0) e^(j n omega_0 t)
             = frac(1, 2 pi) sum_(n = -infinity)^(infinity) X(j n omega_0) e^(j n omega_0 t) Delta omega,
$
where $Delta omega = omega_0 = 2 pi / T_0$. As $T_0 arrow.r infinity$, the harmonic spacing $Delta omega arrow.r dif omega$ and the discrete sum passes to a Riemann integral:
$
  x(t) = frac(1, 2 pi) integral_(-infinity)^(infinity) X(j omega) e^(j omega t) dif omega.
$
This is the *inverse Fourier transform* (synthesis equation). The companion *forward transform* (analysis equation) is identified as
$
  X(j omega) = integral_(-infinity)^(infinity) x(t) e^(-j omega t) dif omega.
$

#showybox(
  frame: (
    border-color: blue.darken(30%),
    title-color: blue.darken(30%),
    body-color: blue.lighten(90%),
  ),
  title-style: (color: black, weight: "regular", align: left),
  title: "Key insight",
  [The passage from Fourier Series to Fourier Transform is the passage from a discrete spectrum (line spectrum at harmonics $n omega_0$) to a *continuous spectrum* $X(j omega)$. The Fourier coefficient $c_n$ is replaced by the spectral density $X(j omega) \/ 2pi$ — a density because energy is now spread continuously over frequency rather than concentrated at discrete lines.],
)

=== The Spectrum

$X(j omega)$ is in general complex. Writing it in polar form
$
  X(j omega) = |X(j omega)| e^(j angle.l X(j omega)),
$
we call $|X(j omega)|$ the *magnitude spectrum* and $angle.l X(j omega)$ the *phase spectrum* of $x(t)$. Together they carry all the frequency-domain information about the signal.

== Definition and Existence

=== The Fourier Transform Pair

The *Continuous-Time Fourier Transform (CTFT)* of a signal $x(t)$ and its inverse are defined by the pair

$
  X(j omega) = integral_(-infinity)^(infinity) x(t) e^(-j omega t) dif t
  quad quad "(analysis / forward transform)"
$
$
  x(t) = frac(1, 2 pi) integral_(-infinity)^(infinity) X(j omega) e^(j omega t) dif omega
  quad "(synthesis / inverse transform)"
$

We write this relationship compactly as $x(t) arrows.lr^(cal(F)) X(j omega)$, or equivalently $X(j omega) = cal(F){x(t)}$ and $x(t) = cal(F)^(-1){X(j omega)}$.

#showybox(
  frame: (
    border-color: red.darken(50%),
    title-color: red.darken(50%),
    body-color: red.lighten(90%),
  ),
  title-style: (color: black, weight: "regular", align: left),
  title: "Note",
  [Two sign conventions exist in the literature. This course follows the *engineering convention*: $e^(-j omega t)$ in the forward transform and $e^(+j omega t)$ in the inverse, with the $1\/(2pi)$ factor on the inverse. Oppenheim \& Willsky and Lathi both use this convention.],
)

=== Conditions for Existence (Dirichlet Conditions)

Not every signal has a Fourier transform in the classical sense. The following *Dirichlet conditions* are *sufficient* (not necessary) to guarantee that $X(j omega)$ exists and that the inverse transform reconstructs $x(t)$:

+ *Absolute integrability:* $integral_(-infinity)^(infinity) |x(t)| dif t < infinity$.
+ *Finite extrema:* $x(t)$ has a finite number of maxima and minima in every finite interval.
+ *Finite discontinuities:* $x(t)$ has a finite number of jump discontinuities in every finite interval, each of finite size.

When these conditions hold, $X(j omega)$ is well-defined and the inverse transform converges to $x(t)$ at every point of continuity, and to the average $frac{1}{2}[x(t^+) + x(t^-)]$ at each jump.

#showybox(
  frame: (
    border-color: red.darken(50%),
    title-color: red.darken(50%),
    body-color: red.lighten(90%),
  ),
  title-style: (color: black, weight: "regular", align: left),
  title: "Note",
  [Several signals that violate condition 1 — notably $u(t)$, $cos(omega_0 t)$, and the unit impulse $delta(t)$ — are so important in system analysis that their transforms are defined using *generalised functions* (distributions). These involve Dirac deltas in the frequency domain and are covered in §4.3 and §4.4.],
)

== Common Fourier Transform Pairs

This section derives the transforms of the signals most frequently encountered in system analysis. Each result is worth memorising; a summary table is given at the end.

=== Rectangular Pulse (Gate Function)

Define the rectangular pulse of width $tau$ and unit amplitude:
$
  x(t) = "rect"(t \/ tau) = cases(1 & |t| lt.eq tau\/2, 0 & |t| > tau\/2.)
$
Applying the forward transform:
$
  X(j omega) &= integral_(-tau\/2)^(tau\/2) e^(-j omega t) dif t
              = lr([frac(e^(-j omega t), -j omega)])_(-tau\/2)^(tau\/2)
              = frac(e^(-j omega tau\/2) - e^(j omega tau\/2), -j omega) \
             &= frac(2 sin(omega tau \/ 2), omega)
              = tau dot frac(sin(omega tau \/ 2), omega tau \/ 2)
              = tau , "sinc"(omega tau \/ 2),
$
where $"sinc"(u) = sin(u)\/u$ (unnormalised). Therefore
$
  "rect"(t \/ tau) arrows.lr^(cal(F)) tau , "sinc"(omega tau \/ 2).
$

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  let sinc(x) = if calc.abs(x) < 0.001 { 1.0 } else { calc.sin(x) / x }

  plot.plot(
    size: (6, 4),
    x-tick-step: 1,
    y-tick-step: 0.5,
    y-min: -0.3,
    y-max: 1.3,
    x-min: -3,
    x-max: 3,
    x-label: $t$,
    y-label: $x(t)$,
    axis-style: "left",
    {
      plot.add(((-3, 0), (-1, 0), (-1, 1), (1, 1), (1, 0), (3, 0)), line: "hv")
    },
  )

  cetz.draw.translate((9, 0))

  plot.plot(
    size: (6, 4),
    x-tick-step: calc.pi,
    y-tick-step: 0.5,
    y-min: -0.5,
    y-max: 2.3,
    x-min: -3 * calc.pi,
    x-max: 3 * calc.pi,
    x-label: $omega$,
    y-label: $X(j omega)$,
    axis-style: "left",
    {
      plot.add(
        domain: (-3 * calc.pi, 3 * calc.pi),
        t => (t, 2.0 * sinc(t)),
        samples: 300,
      )
    },
  )
})

=== Decaying Exponential

For $a > 0$, consider the causal decaying exponential $x(t) = e^(-a t) u(t)$:
$
  X(j omega) = integral_0^(infinity) e^(-a t) e^(-j omega t) dif t
             = integral_0^(infinity) e^(-(a + j omega) t) dif t
             = lr([frac(e^(-(a+j omega)t), -(a + j omega))])_0^(infinity)
             = frac(1, a + j omega).
$
The integral converges because $a > 0$ ensures $e^(-(a+j omega)t) arrow.r 0$ as $t arrow.r infinity$. Therefore
$
  e^(-a t) u(t) arrows.lr^(cal(F)) frac(1, a + j omega), quad a > 0.
$
The magnitude spectrum is a *Lorentzian*: $|X(j omega)| = 1\/sqrt(a^2 + omega^2)$, which decays as $1/omega$ for large $|omega|$. The 3 dB bandwidth (where $|X|$ falls to $1\/sqrt(2)$ of its DC value) is $omega_(3"dB") = a$ rad/s.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (6, 4),
    x-tick-step: 1,
    y-tick-step: 0.5,
    y-min: -0.1,
    y-max: 1.3,
    x-min: -1,
    x-max: 5,
    x-label: $t$,
    y-label: $e^(-a t)u(t)$,
    axis-style: "left",
    {
      plot.add(((-1, 0), (0, 0)))
      plot.add(domain: (0, 5), t => (t, calc.exp(-t)))
    },
  )

  cetz.draw.translate((9, 0))

  plot.plot(
    size: (6, 4),
    x-tick-step: 2,
    y-tick-step: 0.5,
    y-min: -0.1,
    y-max: 1.3,
    x-min: -6,
    x-max: 6,
    x-label: $omega$,
    y-label: $|X(j omega)|$,
    axis-style: "left",
    {
      plot.add(
        domain: (-6, 6),
        t => (t, 1.0 / calc.sqrt(1.0 + t * t)),
        samples: 200,
      )
    },
  )
})

=== Two-Sided Decaying Exponential

For $a > 0$, let $x(t) = e^(-a|t|)$. Split the integral at $t = 0$:
$
  X(j omega) &= integral_(-infinity)^0 e^(a t) e^(-j omega t) dif t
               + integral_0^(infinity) e^(-a t) e^(-j omega t) dif t \
             &= frac(1, a - j omega) + frac(1, a + j omega)
              = frac(2a, a^2 + omega^2).
$
This is a real, even, positive function of $omega$ — the phase spectrum is zero everywhere.

=== Unit Impulse

$
  cal(F){delta(t)} = integral_(-infinity)^(infinity) delta(t) e^(-j omega t) dif t = e^(-j omega dot 0) = 1.
$
The impulse has a *flat* (white) spectrum: all frequencies are present with equal magnitude. For a time-shifted impulse:
$
  cal(F){delta(t - t_0)} = e^(-j omega t_0).
$
The magnitude is still 1 for all $omega$; only the phase $-omega t_0$ changes.

=== Constant Signal and the DC Impulse

Taking the inverse transform of $2 pi delta(omega)$:
$
  frac(1, 2 pi) integral_(-infinity)^(infinity) 2 pi delta(omega) e^(j omega t) dif omega = 1.
$
Therefore $cal(F){1} = 2 pi delta(omega)$. This result makes physical sense: a constant signal is pure DC, so its entire energy is concentrated at $omega = 0$.

=== Signum Function

The signum function $"sgn"(t) = u(t) - u(-t)$ is an odd signal. It can be obtained as a limit of the two-sided exponential:
$
  "sgn"(t) = lim_(a arrow.r 0) cases(e^(-a t) & t > 0, -e^(a t) & t < 0.)
$
Taking the transform and letting $a arrow.r 0$:
$
  cal(F){"sgn"(t)} = lim_(a arrow.r 0) lr((frac(1, a + j omega) - frac(1, a - j omega))) = frac(2, j omega).
$

=== Unit Step

Since $u(t) = frac{1}{2} + frac{1}{2}"sgn"(t)$, linearity gives
$
  cal(F){u(t)} = pi delta(omega) + frac(1, j omega).
$
The $pi delta(omega)$ term captures the nonzero mean (DC component); the $1\/(j omega)$ term accounts for the step edge.

=== Summary Table of Transform Pairs

#table(
  columns: (auto, auto),
  inset: 8pt,
  align: (left, left),
  table.header([*Signal $x(t)$*], [*Transform $X(j omega)$*]),
  [$"rect"(t\/tau)$],           [$tau , "sinc"(omega tau \/ 2)$],
  [$"sinc"(W t \/ 2) \/ pi$],   [$"rect"(omega \/ (2W))$],
  [$e^(-a t)u(t),  a>0$],       [$1\/(a + j omega)$],
  [$t e^(-a t)u(t),  a>0$],     [$1\/(a + j omega)^2$],
  [$e^(-a|t|),  a>0$],          [$2a\/(a^2 + omega^2)$],
  [$e^(-a t^2)$],               [$sqrt(pi\/a) e^(-omega^2\/(4a))$],
  [$delta(t)$],                 [$1$],
  [$delta(t - t_0)$],           [$e^(-j omega t_0)$],
  [$1$],                        [$2 pi delta(omega)$],
  [$"sgn"(t)$],                 [$2\/(j omega)$],
  [$u(t)$],                     [$pi delta(omega) + 1\/(j omega)$],
  [$cos(omega_0 t)$],           [$pi[delta(omega - omega_0) + delta(omega + omega_0)]$],
  [$sin(omega_0 t)$],           [$j pi[delta(omega + omega_0) - delta(omega - omega_0)]$],
)

== Fourier Transform of Periodic Signals

A periodic signal $x(t)$ with period $T_0$ violates the absolute integrability condition, so its Fourier transform does not exist in the classical sense. However, we can use the Fourier Series representation together with the result $cal(F){1} = 2pi delta(omega)$ to assign a transform that is consistent with the inverse transform formula.

=== Derivation

Write the Fourier Series of $x(t)$:
$
  x(t) = sum_(n = -infinity)^(infinity) c_n e^(j n omega_0 t).
$
Taking the Fourier transform term-by-term and using $cal(F){e^(j n omega_0 t)} = 2pi delta(omega - n omega_0)$:
$
  X(j omega) = 2pi sum_(n = -infinity)^(infinity) c_n delta(omega - n omega_0).
$
The spectrum of a periodic signal is a *train of impulses* in frequency, located at the harmonics $omega = n omega_0$, each weighted by $2pi c_n$.

#showybox(
  frame: (
    border-color: blue.darken(30%),
    title-color: blue.darken(30%),
    body-color: blue.lighten(90%),
  ),
  title-style: (color: black, weight: "regular", align: left),
  title: "Key insight",
  [This result unifies periodic and aperiodic signals under one framework: both have a Fourier transform, but periodic signals have a *discrete* (impulsive) spectrum while aperiodic signals have a *continuous* spectrum. The Fourier Series is simply the special case of the Fourier Transform for periodic signals.],
)

=== Example: Sinusoid

For $x(t) = cos(omega_0 t) = frac{1}{2}(e^(j omega_0 t) + e^(-j omega_0 t))$, the Fourier Series has $c_1 = c_(-1) = 1/2$ and all other $c_n = 0$. Therefore
$
  cal(F){cos(omega_0 t)} = pi [delta(omega - omega_0) + delta(omega + omega_0)].
$
Two impulses of weight $pi$ sit symmetrically at $plus.minus omega_0$. Similarly
$
  cal(F){sin(omega_0 t)} = j pi [delta(omega + omega_0) - delta(omega - omega_0)].
$

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (6, 4),
    x-tick-step: calc.pi,
    y-tick-step: 0.5,
    y-min: -1.3,
    y-max: 1.3,
    x-min: -2 * calc.pi,
    x-max: 2 * calc.pi,
    x-label: $t$,
    y-label: $cos(omega_0 t)$,
    axis-style: "left",
    {
      plot.add(
        domain: (-2 * calc.pi, 2 * calc.pi),
        t => (t, calc.cos(t)),
        samples: 200,
      )
    },
  )

  cetz.draw.translate((9, 0))

  plot.plot(
    size: (6, 4),
    x-tick-step: 2,
    y-tick-step: 1,
    y-min: -0.3,
    y-max: 1.3,
    x-min: -5,
    x-max: 5,
    x-label: $omega$,
    y-label: $|X(j omega)| \/ pi$,
    axis-style: "left",
    {
      plot.add(((-5, 0), (-1, 0)), mark: none)
      plot.add(((-1, 0), (-1, 1)), mark: "o", mark-size: 0.15)
      plot.add(((-1, 0), (1, 0)), mark: none)
      plot.add(((1, 0), (1, 1)), mark: "o", mark-size: 0.15)
      plot.add(((1, 0), (5, 0)), mark: none)
    },
  )
})

=== Example: Periodic Impulse Train

The *periodic impulse train* (Shah function) is defined as
$
  p(t) = sum_(n = -infinity)^(infinity) delta(t - n T_0).
$
Its Fourier Series coefficients are $c_n = 1/T_0$ for all $n$ (since each impulse is identical). Therefore
$
  cal(F){p(t)} = frac(2pi, T_0) sum_(n=-infinity)^(infinity) delta(omega - n omega_0) = omega_0 sum_(n=-infinity)^(infinity) delta(omega - n omega_0).
$
*A periodic impulse train in time transforms to a periodic impulse train in frequency*, with spacing $omega_0 = 2pi\/T_0$. This result is fundamental to the derivation of the Nyquist Sampling Theorem (Chapter 6).

#showybox(
  frame: (
    border-color: red.darken(50%),
    title-color: red.darken(50%),
    body-color: red.lighten(90%),
  ),
  title-style: (color: black, weight: "regular", align: left),
  title: "Note",
  [The impulse train result shows the *inverse relationship* between time and frequency: a denser train in time ($T_0$ small, $omega_0$ large) produces a sparser train in frequency, and vice versa. This is a direct manifestation of the time–frequency uncertainty principle.],
)

== Properties of the Fourier Transform

The properties below allow transforms of complicated signals to be deduced from simpler known pairs, and are indispensable for solving system analysis problems. Throughout, assume $x(t) arrows.lr^(cal(F)) X(j omega)$ and $y(t) arrows.lr^(cal(F)) Y(j omega)$.

=== Linearity

For constants $a, b in CC$:
$
  a x(t) + b y(t) arrows.lr^(cal(F)) a X(j omega) + b Y(j omega).
$
*Proof:* The Fourier integral is a linear operation — constants factor out and integrals of sums split. $square$

=== Time Shifting

$
  x(t - t_0) arrows.lr^(cal(F)) e^(-j omega t_0) X(j omega).
$
*Proof:* Substitute $tau = t - t_0$ in the forward transform:
$
  integral_(-infinity)^(infinity) x(t - t_0) e^(-j omega t) dif t
  = integral_(-infinity)^(infinity) x(tau) e^(-j omega (tau + t_0)) dif tau
  = e^(-j omega t_0) X(j omega). quad square
$
Time shifting leaves the *magnitude spectrum unchanged* ($|e^(-j omega t_0) X(j omega)| = |X(j omega)|$) and adds a *linear phase* $-omega t_0$ to the phase spectrum. A delay in time corresponds to a linear phase ramp in frequency.

=== Frequency Shifting (Modulation)

$
  e^(j omega_0 t) x(t) arrows.lr^(cal(F)) X(j(omega - omega_0)).
$
*Proof:* Replace $omega$ with $omega - omega_0$ in the analysis integral:
$
  integral_(-infinity)^(infinity) e^(j omega_0 t) x(t) e^(-j omega t) dif t
  = integral_(-infinity)^(infinity) x(t) e^(-j(omega - omega_0)t) dif t
  = X(j(omega - omega_0)). quad square
$
Multiplication by a complex exponential *shifts the spectrum* by $omega_0$. This is the mathematical basis of *amplitude modulation* in communications.

*Example:* $x(t) cos(omega_0 t) = frac{1}{2}x(t)(e^(j omega_0 t) + e^(-j omega_0 t))$, so
$
  cal(F){x(t) cos(omega_0 t)} = frac{1}{2}[X(j(omega - omega_0)) + X(j(omega + omega_0))].
$
The spectrum of $x(t)$ is translated to be centred at $plus.minus omega_0$.

=== Time and Frequency Scaling

For real $a eq.not 0$:
$
  x(a t) arrows.lr^(cal(F)) frac{1}{|a|} X lr((frac(j omega, a))).
$
*Proof:* For $a > 0$, substitute $tau = a t$:
$
  integral_(-infinity)^(infinity) x(a t) e^(-j omega t) dif t
  = frac{1}{a} integral_(-infinity)^(infinity) x(tau) e^(-j (omega\/a) tau) dif tau
  = frac{1}{a} X lr((frac(j omega, a))).
$
For $a < 0$ the limits of integration reverse, introducing a factor $1\/|a|$. $square$

Compressing $x(t)$ in time ($|a| > 1$) expands its spectrum in frequency and reduces its amplitude, and vice versa. This is the *time–bandwidth trade-off*: you cannot simultaneously make a signal narrow in time and narrow in frequency.

=== Time Reversal

Setting $a = -1$ in the scaling property:
$
  x(-t) arrows.lr^(cal(F)) X(-j omega) = X^*(j omega), quad x(t) "real."
$
Reversing a real signal conjugates its spectrum, flipping the sign of the phase while leaving the magnitude unchanged.

=== Duality

If $x(t) arrows.lr^(cal(F)) X(j omega)$, then
$
  X(j t) arrows.lr^(cal(F)) 2pi x(-omega).
$
*Proof:* Starting from the inverse transform $x(t) = frac{1}{2pi} integral X(j omega) e^(j omega t) dif omega$, replace $t$ with $-t$ and then swap the roles of $t$ and $omega$. $square$

Duality means every transform pair generates a second pair for free.

*Example:* Since $"rect"(t\/tau) arrows.lr^(cal(F)) tau , "sinc"(omega tau\/2)$, duality gives
$
  tau , "sinc"(t tau \/ 2) arrows.lr^(cal(F)) 2pi , "rect"(-omega\/tau) = 2pi , "rect"(omega\/tau).
$
A sinc pulse in time has a rectangular (bandlimited) spectrum — it is the ideal low-pass filter impulse response.

=== Differentiation in Time

$
  frac(dif x(t), dif t) arrows.lr^(cal(F)) j omega X(j omega).
$
*Proof:* Differentiate the inverse transform formula under the integral sign:
$
  frac(dif, dif t) lr([frac{1}{2pi} integral X(j omega) e^(j omega t) dif omega])
  = frac{1}{2pi} integral j omega X(j omega) e^(j omega t) dif omega. quad square
$
By induction, differentiation $n$ times gives $(j omega)^n X(j omega)$. This property converts a differential equation in $t$ into an *algebraic equation* in $omega$ — the central tool of Fourier-domain system analysis.

=== Integration in Time

$
  integral_(-infinity)^t x(tau) dif tau arrows.lr^(cal(F)) frac{X(j omega)}{j omega} + pi X(0) delta(omega).
$
The $pi X(0) delta(omega)$ term accounts for any nonzero area (DC content) accumulated by the integral as $t arrow.r infinity$.

=== Convolution in Time

$
  x(t) ast y(t) arrows.lr^(cal(F)) X(j omega) Y(j omega).
$
*Proof:* Write the convolution and forward transform, then exchange the order of integration:
$
  cal(F){x ast y} &= integral_(-infinity)^(infinity) lr([integral_(-infinity)^(infinity) x(tau) y(t - tau) dif tau]) e^(-j omega t) dif t \
                  &= integral_(-infinity)^(infinity) x(tau) lr([integral_(-infinity)^(infinity) y(t - tau) e^(-j omega t) dif t]) dif tau \
                  &= integral_(-infinity)^(infinity) x(tau) e^(-j omega tau) Y(j omega) dif tau \
                  &= X(j omega) Y(j omega). quad square
$

#showybox(
  frame: (
    border-color: blue.darken(30%),
    title-color: blue.darken(30%),
    body-color: blue.lighten(90%),
  ),
  title-style: (color: black, weight: "regular", align: left),
  title: "Key insight",
  [The convolution theorem is the most important property in system analysis. Convolution in time — a laborious integral — becomes *pointwise multiplication* in frequency. To find a system's output: transform the input, multiply by $H(j omega)$, inverse transform.],
)

=== Multiplication in Time (Windowing)

$
  x(t) dot y(t) arrows.lr^(cal(F)) frac{1}{2pi} X(j omega) ast Y(j omega).
$
Multiplication in time corresponds to convolution in frequency (with a $1\/2pi$ normalisation). This property underlies *windowing* in spectral analysis: multiplying a signal by a window function $w(t)$ convolves its spectrum with $W(j omega)$, which must be chosen narrow in frequency to minimise spectral leakage.

=== Parseval's Theorem

$
  integral_(-infinity)^(infinity) |x(t)|^2 dif t = frac{1}{2pi} integral_(-infinity)^(infinity) |X(j omega)|^2 dif omega.
$
*Proof:* Apply the multiplication property with $y(t) = x^*(t)$, noting that $cal(F){x^*(t)} = X^*(-j omega)$, then evaluate at $omega = 0$. $square$

Parseval's theorem states that *total signal energy is preserved* by the Fourier transform. The quantity $|X(j omega)|^2\/(2pi)$ is the *energy spectral density* — it describes how the signal's energy is distributed across frequency.

=== Summary Table of Properties

#table(
  columns: (auto, auto, auto),
  inset: 8pt,
  align: (left, left, left),
  table.header([*Property*], [*Time domain*], [*Frequency domain*]),
  [Linearity],          [$a x(t) + b y(t)$],                          [$a X(j omega) + b Y(j omega)$],
  [Time shifting],      [$x(t - t_0)$],                               [$e^(-j omega t_0) X(j omega)$],
  [Freq. shifting],     [$e^(j omega_0 t) x(t)$],                     [$X(j(omega - omega_0))$],
  [Time scaling],       [$x(a t)$],                                   [$frac{1}{|a|} X(j omega \/ a)$],
  [Time reversal],      [$x(-t)$],                                    [$X(-j omega)$],
  [Duality],            [$X(j t)$],                                   [$2pi x(-omega)$],
  [Differentiation],    [$dif^n x \/ dif t^n$],                       [$(j omega)^n X(j omega)$],
  [Integration],        [$integral_(-infinity)^t x dif tau$],         [$X(j omega)\/(j omega) + pi X(0)delta(omega)$],
  [Convolution],        [$x(t) ast y(t)$],                            [$X(j omega) Y(j omega)$],
  [Multiplication],     [$x(t) y(t)$],                                [$frac{1}{2pi} X(j omega) ast Y(j omega)$],
  [Parseval's thm.],    [$integral |x|^2 dif t$],                     [$frac{1}{2pi} integral |X|^2 dif omega$],
  [Conj. symmetry],     [$x(t)$ real],                                [$X(-j omega) = X^*(j omega)$],
)

== Frequency Response of LTI Systems

=== The Frequency Response $H(j omega)$

From Chapter 1, the output of an LTI system with impulse response $h(t)$ is the convolution $y(t) = x(t) ast h(t)$. Applying the convolution theorem:
$
  Y(j omega) = H(j omega) X(j omega),
$
where
$
  H(j omega) = integral_(-infinity)^(infinity) h(t) e^(-j omega t) dif t = cal(F){h(t)}.
$
$H(j omega)$ is the *frequency response* of the system. It is complex-valued and decomposes as
$
  H(j omega) = |H(j omega)| e^(j angle.l H(j omega)),
$
where $|H(j omega)|$ is the *gain* (amplitude response) and $angle.l H(j omega)$ is the *phase response* at frequency $omega$. At each frequency $omega$, the system scales the input sinusoidal component by $|H(j omega)|$ and shifts its phase by $angle.l H(j omega)$.

#showybox(
  frame: (
    border-color: blue.darken(30%),
    title-color: blue.darken(30%),
    body-color: blue.lighten(90%),
  ),
  title-style: (color: black, weight: "regular", align: left),
  title: "Key insight",
  [The frequency response $H(j omega)$ is the eigenvalue of the LTI system at frequency $omega$ (recall §3.1). System analysis in the frequency domain reduces to: multiply spectra. The convolution integral, which is difficult to compute, is replaced by pointwise multiplication.],
)

=== Ideal Filters

An *ideal filter* passes certain frequencies without distortion and completely blocks all others. The four ideal filter types are characterised by their frequency responses:

#table(
  columns: (auto, auto),
  inset: 8pt,
  align: (left, left),
  table.header([*Filter type*], [*Frequency response $H(j omega)$*]),
  [Low-pass (LPF)],   [$"rect"(omega \/ (2 omega_c))$],
  [High-pass (HPF)],  [$1 - "rect"(omega \/ (2 omega_c))$],
  [Band-pass (BPF)],  [$"rect"((omega - omega_c)\/B) + "rect"((omega + omega_c)\/B)$],
  [Band-stop (BSF)],  [$1 - ["rect"((omega-omega_c)\/B) + "rect"((omega+omega_c)\/B)]$],
)

where $omega_c$ is the *cutoff frequency* and $B$ is the *bandwidth*.

The impulse response of the ideal LPF is found by taking the inverse Fourier transform of $H(j omega) = "rect"(omega \/ (2 omega_c))$:
$
  h(t) = frac{1}{2pi} integral_(-omega_c)^(omega_c) e^(j omega t) dif omega
        = frac{omega_c}{pi} "sinc"(omega_c t).
$

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  let sinc(x) = if calc.abs(x) < 0.001 { 1.0 } else { calc.sin(x) / x }

  plot.plot(
    size: (6, 4),
    x-tick-step: 2,
    y-tick-step: 0.5,
    y-min: -0.5,
    y-max: 1.3,
    x-min: -5,
    x-max: 5,
    x-label: $omega$,
    y-label: $H(j omega)$,
    axis-style: "left",
    {
      plot.add(((-5, 0), (-2, 0), (-2, 1), (2, 1), (2, 0), (5, 0)), line: "hv")
    },
  )

  cetz.draw.translate((9, 0))

  plot.plot(
    size: (6, 4),
    x-tick-step: calc.pi,
    y-tick-step: 0.5,
    y-min: -0.5,
    y-max: 1.3,
    x-min: -3 * calc.pi,
    x-max: 3 * calc.pi,
    x-label: $t$,
    y-label: $h(t)$,
    axis-style: "left",
    {
      plot.add(
        domain: (-3 * calc.pi, 3 * calc.pi),
        t => (t, sinc(2.0 * t) * 2.0 / calc.pi),
        samples: 300,
      )
    },
  )
})

#showybox(
  frame: (
    border-color: red.darken(50%),
    title-color: red.darken(50%),
    body-color: red.lighten(90%),
  ),
  title-style: (color: black, weight: "regular", align: left),
  title: "Note",
  [The ideal LPF impulse response $h(t) = (omega_c\/pi) "sinc"(omega_c t)$ is nonzero for $t < 0$ — it responds *before* the impulse is applied. This means the ideal LPF is *non-causal* and therefore physically unrealisable. Practical filter design (Chapter 5) constructs causal approximations with a smooth roll-off.],
)

=== LTI Systems Described by Differential Equations

A broad class of physical systems — electrical circuits, mechanical systems, control loops — is described by linear constant-coefficient ordinary differential equations (LCCODEs) of the form
$
  sum_(k=0)^N a_k frac(dif^k y, dif t^k) = sum_(k=0)^M b_k frac(dif^k x, dif t^k).
$
Taking the Fourier transform of both sides and applying the differentiation property $(dif^k \/ dif t^k) arrows.lr^(cal(F)) (j omega)^k$:
$
  lr((sum_(k=0)^N a_k (j omega)^k)) Y(j omega) = lr((sum_(k=0)^M b_k (j omega)^k)) X(j omega).
$
The frequency response is therefore a *rational function* of $j omega$:
$
  H(j omega) = frac(Y(j omega), X(j omega)) = frac(sum_(k=0)^M b_k (j omega)^k, sum_(k=0)^N a_k (j omega)^k) = frac(N(j omega), D(j omega)).
$

==== Worked Example: Series RC Circuit

Consider a series RC circuit with input voltage $x(t)$ applied across the series combination, and output $y(t)$ taken across the capacitor. Kirchhoff's voltage law gives
$
  R C frac(dif y(t), dif t) + y(t) = x(t).
$
Taking the Fourier transform:
$
  j omega R C Y(j omega) + Y(j omega) = X(j omega)
  quad arrow.r.double quad
  H(j omega) = frac(1, 1 + j omega R C).
$
Let $tau = R C$ (time constant). The magnitude and phase responses are
$
  |H(j omega)| = frac{1}{sqrt{1 + (omega tau)^2}}, quad angle.l H(j omega) = -arctan(omega tau).
$

The gain is 1 at DC, falls to $1\/sqrt{2}$ ($-3$ dB) at $omega_(3"dB") = 1\/tau$, and rolls off as $1\/omega$ for $omega >> 1\/tau$. The phase shifts from $0$ at DC to $-pi\/2$ at high frequency.

Now find the output when the input is $x(t) = e^(-a t) u(t)$ with $a eq.not 1\/tau$:
$
  Y(j omega) = H(j omega) X(j omega) = frac{1}{1 + j omega tau} dot frac{1}{a + j omega}.
$
Partial fractions (with $b = 1\/tau$):
$
  Y(j omega) = frac{1}{(a + j omega)(b + j omega)} = frac{1}{b - a} lr((frac{1}{a + j omega} - frac{1}{b + j omega})).
$
Inverse transforming using $1\/(alpha + j omega) arrows.lr^(cal(F)^(-1)) e^(-alpha t) u(t)$:
$
  y(t) = frac{1}{b - a} (e^(-a t) - e^(-b t)) u(t) = frac{tau}{1 - a tau} (e^(-a t) - e^(-t\/tau)) u(t).
$

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  let tau = 1.0
  let a   = 0.5
  let b   = 1.0 / tau
  let y(t) = (1.0 / (b - a)) * (calc.exp(-a * t) - calc.exp(-b * t))

  plot.plot(
    size: (12, 5),
    x-tick-step: 1,
    y-tick-step: 0.2,
    y-min: -0.05,
    y-max: 1.1,
    x-min: -0.5,
    x-max: 8,
    x-label: $t$,
    y-label: "",
    axis-style: "left",
    legend: "inner-north-east",
    {
      plot.add(
        domain: (0, 8),
        t => (t, calc.exp(-a * t)),
        label: $x(t) = e^(-0.5t)u(t)$,
      )
      plot.add(
        domain: (0, 8),
        t => (t, y(t)),
        style: (stroke: (dash: "dashed")),
        label: $y(t)$,
      )
      plot.add(((-0.5, 0), (0, 0)), mark: none)
    },
  )
})

== Signal Transmission and Distortion

When a signal passes through an LTI system the output is $Y(j omega) = H(j omega) X(j omega)$. In general, the system modifies both the amplitude and phase of each frequency component. *Distortion* is any unwanted modification — the goal of this section is to characterise the conditions under which a system transmits a signal faithfully.

=== Distortionless Transmission

A system transmits $x(t)$ *without distortion* if the output is a scaled, delayed replica:
$
  y(t) = K x(t - t_0), quad K > 0, quad t_0 in RR.
$
Taking the Fourier transform of both sides:
$
  Y(j omega) = K e^(-j omega t_0) X(j omega).
$
Comparing with $Y(j omega) = H(j omega) X(j omega)$, the condition for distortionless transmission is
$
  H(j omega) = K e^(-j omega t_0).
$
This requires:
- *Flat magnitude response:* $|H(j omega)| = K$ for all $omega$ — every frequency is amplified by the same gain.
- *Linear phase response:* $angle.l H(j omega) = -omega t_0$ — the phase shifts linearly with frequency.

Any deviation from these conditions introduces distortion. Two types are distinguished:

- *Amplitude distortion:* $|H(j omega)|$ is not constant — different frequencies are amplified by different amounts, changing the relative sizes of spectral components.
- *Phase distortion:* $angle.l H(j omega)$ is not linear — different frequencies are delayed by different amounts, disrupting the temporal alignment of spectral components.

#showybox(
  frame: (
    border-color: red.darken(50%),
    title-color: red.darken(50%),
    body-color: red.lighten(90%),
  ),
  title-style: (color: black, weight: "regular", align: left),
  title: "Note",
  [A system can have a flat magnitude response yet still distort if its phase is nonlinear. Phase distortion is often perceptually significant in audio and communications but invisible to power-spectrum measurements — this is why phase response must always be checked alongside magnitude response.],
)

=== Group Delay

For a system with phase response $angle.l H(j omega)$, the *group delay* is defined as
$
  tau_g (omega) = -frac(dif , dif omega) angle.l H(j omega).
$
Group delay measures the time delay experienced by the *envelope* of a narrowband signal centred at frequency $omega$. It generalises the concept of delay to systems whose phase is not exactly linear.

The distortionless condition $angle.l H(j omega) = -omega t_0$ is equivalent to *constant group delay* $tau_g(omega) = t_0$ for all $omega$: every narrowband component of the signal is delayed by the same amount, so the envelope shape is preserved.

==== Worked Example: RC Lowpass Filter

Returning to the first-order RC filter $H(j omega) = 1\/(1 + j omega tau)$, the phase is
$
  angle.l H(j omega) = -arctan(omega tau).
$
The group delay is
$
  tau_g(omega) = -frac(dif, dif omega)(-arctan(omega tau)) = frac(tau, 1 + (omega tau)^2).
$

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  plot.plot(
    size: (6, 4),
    x-tick-step: 1,
    y-tick-step: 0.5,
    y-min: -0.1,
    y-max: 1.3,
    x-min: 0,
    x-max: 5,
    x-label: $omega tau$,
    y-label: $|H(j omega)|$,
    axis-style: "left",
    {
      plot.add(
        domain: (0, 5),
        t => (t, 1.0 / calc.sqrt(1.0 + t * t)),
        samples: 200,
      )
    },
  )

  cetz.draw.translate((9, 0))

  plot.plot(
    size: (6, 4),
    x-tick-step: 1,
    y-tick-step: 0.2,
    y-min: -0.05,
    y-max: 1.1,
    x-min: 0,
    x-max: 5,
    x-label: $omega tau$,
    y-label: $tau_g \/ tau$,
    axis-style: "left",
    {
      plot.add(
        domain: (0, 5),
        t => (t, 1.0 / (1.0 + t * t)),
        samples: 200,
      )
    },
  )
})

The group delay equals $tau$ at DC and falls monotonically toward zero at high frequency. Because $tau_g(omega)$ is not constant, the RC filter is a *dispersive* system — it delays low-frequency components of the envelope more than high-frequency ones, spreading pulses in time. This is the mechanism behind pulse broadening in dispersive transmission media such as optical fibres.

#showybox(
  frame: (
    border-color: blue.darken(30%),
    title-color: blue.darken(30%),
    body-color: blue.lighten(90%),
  ),
  title-style: (color: black, weight: "regular", align: left),
  title: "Key insight",
  [Distortionless transmission requires *linear phase* (equivalently, *constant group delay*). A flat magnitude response alone is not sufficient. Systems with linear phase — such as symmetric FIR filters in the discrete-time setting — are therefore highly desirable whenever waveform shape must be preserved.],
)

== Energy Spectral Density

=== Definition

From Parseval's theorem the total energy of $x(t)$ is
$
  E_x = integral_(-infinity)^(infinity) |x(t)|^2 dif t = frac{1}{2pi} integral_(-infinity)^(infinity) |X(j omega)|^2 dif omega.
$
The integrand on the right, $|X(j omega)|^2 \/ (2pi)$, describes how the signal's energy is *distributed across frequency*. It is called the *energy spectral density (ESD)*:
$
  S_x (omega) = |X(j omega)|^2,
$
so that
$
  E_x = frac{1}{2pi} integral_(-infinity)^(infinity) S_x (omega) dif omega.
$
$S_x(omega)$ has units of energy per unit angular frequency (J·s/rad). For a real signal $x(t)$, conjugate symmetry gives $|X(-j omega)| = |X(j omega)|$, so $S_x(omega)$ is an even function of $omega$.

=== Energy in a Frequency Band

The energy contained in the band $omega_1 lt.eq |omega| lt.eq omega_2$ is
$
  E_(omega_1, omega_2) = frac{1}{2pi} lr([integral_(-omega_2)^(-omega_1) + integral_(omega_1)^(omega_2)]) S_x(omega) dif omega
                       = frac{1}{pi} integral_(omega_1)^(omega_2) S_x(omega) dif omega,
$
where the last equality uses the even symmetry of $S_x(omega)$.

=== Bandwidth Definitions

Several definitions of signal *bandwidth* are in common use, each suited to different contexts:

#table(
  columns: (auto, auto),
  inset: 8pt,
  align: (left, left),
  table.header([*Definition*], [*Condition*]),
  [3 dB bandwidth $B_(3"dB")$],       [$S_x(omega) = S_x(0)\/2$, i.e. $|X(j omega)| = |X(0)|\/ sqrt{2}$],
  [Null-to-null bandwidth $B_"null"$], [Distance from DC to first spectral null of $|X(j omega)|$],
  [RMS (Gabor) bandwidth $B_"rms"$],  [$B_"rms"^2 = frac{1}{E_x} frac{1}{2pi} integral omega^2 S_x(omega) dif omega$],
)

Each definition gives the same answer for a Gaussian signal (since Gaussians are their own Fourier transforms) but can differ significantly for other shapes.

=== Worked Example

Find the ESD, total energy, and 3 dB bandwidth of $x(t) = e^(-a t) u(t)$, $a > 0$.

*Step 1 — ESD:* From §4.3, $X(j omega) = 1\/(a + j omega)$, so
$
  S_x(omega) = |X(j omega)|^2 = frac{1}{a^2 + omega^2}.
$

*Step 2 — Total energy:*
$
  E_x = frac{1}{2pi} integral_(-infinity)^(infinity) frac{1}{a^2 + omega^2} dif omega.
$
Using the standard result $integral_(-infinity)^infinity dif omega\/(alpha^2 + omega^2) = pi\/alpha$:
$
  E_x = frac{1}{2pi} dot frac{pi}{a} = frac{1}{2a}.
$
This matches the direct time-domain calculation: $E_x = integral_0^infinity e^(-2a t) dif t = 1\/(2a)$. $checkmark$

*Step 3 — 3 dB bandwidth:* The ESD at DC is $S_x(0) = 1\/a^2$. Setting $S_x(omega_c) = S_x(0)\/2$:
$
  frac{1}{a^2 + omega_c^2} = frac{1}{2 a^2}
  quad arrow.r.double quad
  omega_c = a " rad/s."
$

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  let a = 1.0

  plot.plot(
    size: (12, 5),
    x-tick-step: 1,
    y-tick-step: 0.2,
    y-min: -0.05,
    y-max: 1.1,
    x-min: -5,
    x-max: 5,
    x-label: $omega \/ a$,
    y-label: $a^2 S_x(omega)$,
    axis-style: "left",
    legend: "inner-north-east",
    {
      plot.add(
        domain: (-5, 5),
        t => (t, 1.0 / (1.0 + t * t)),
        samples: 300,
        label: $S_x(omega)$,
      )
      plot.add(
        ((-5, 0.5), (5, 0.5)),
        style: (stroke: (dash: "dashed", paint: red)),
        label: [3 dB level],
      )
      plot.add(
        ((-1, 0), (-1, 0.5)),
        style: (stroke: (paint: red)),
      )
      plot.add(
        ((1, 0), (1, 0.5)),
        style: (stroke: (paint: red)),
      )
    },
  )
})

A larger $a$ (faster decay in time) gives a wider ESD ($omega_c = a$ increases) — again the time–bandwidth trade-off: a signal that is short-lived in time is necessarily broad in frequency.

=== ESD and the Autocorrelation Function

The ESD is also the Fourier transform of the *autocorrelation function* $R_x(tau)$:
$
  R_x (tau) = integral_(-infinity)^(infinity) x(t) x(t + tau) dif t arrows.lr^(cal(F)) S_x(omega) = |X(j omega)|^2.
$
This relationship (the *Wiener–Khinchin theorem* for energy signals) is useful when the ESD must be estimated from a signal without direct access to $X(j omega)$.

= Butterworth Filter Design

Chapter 3 established that the ideal low-pass filter has a rectangular frequency response — unity gain in the passband and zero gain in the stopband. Its impulse response is a sinc function that is nonzero for $t < 0$, making it non-causal and physically unrealisable. Practical filter design constructs a *causal*, stable, rational transfer function $H(s)$ whose magnitude response approximates the ideal as closely as possible. The Butterworth filter is the simplest such approximation: it achieves the flattest possible magnitude in the passband for a given filter order, at the cost of a gradual roll-off rather than a brick-wall transition.

== Filter Specifications

A low-pass filter design is governed by four parameters that bound its magnitude response $|H(j omega)|$:

- *Passband edge* $omega_p$: all frequencies $|omega| lt.eq omega_p$ must pass with magnitude no less than $10^(-R_p slash 20)$, where $R_p > 0$ is the maximum allowable passband ripple in dB.
- *Stopband edge* $omega_s > omega_p$: all frequencies $|omega| gt.eq omega_s$ must satisfy $|H(j omega)| lt.eq 10^(-A_s slash 20)$, where $A_s > 0$ is the minimum required stopband attenuation in dB.
- *Transition band* $omega_p < |omega| < omega_s$: no constraint is imposed here. A narrow transition band demands a higher filter order.

Introducing the shorthand $epsilon.alt^2 = 10^(R_p\/10) - 1$ and $delta_s = 10^(-A_s\/20)$, the constraints become
$
  |H(j omega_p)| gt.eq frac(1, sqrt(1 + epsilon.alt^2)), quad |H(j omega_s)| lt.eq delta_s.
$

The figure below illustrates the specification regions. The shaded areas are *forbidden* — the filter magnitude must stay out of them.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  let bw(x) = 1.0 / calc.sqrt(1.0 + calc.pow(x, 8))

  let rp_level = 1.0 / calc.sqrt(2.0)
  let as_level = 0.1

  plot.plot(
    size: (12, 5),
    x-tick-step: 1,
    y-tick-step: 0.2,
    y-min: -0.05,
    y-max: 1.25,
    x-min: 0,
    x-max: 3.5,
    x-label: $omega \/ omega_p$,
    y-label: $|H(j omega)|$,
    axis-style: "left",
    legend: "inner-north-east",
    {
      plot.add(
        domain: (0, 3.5),
        t => (t, bw(t)),
        samples: 300,
        label: [Practical LPF ($n = 4$)],
      )
      plot.add(
        ((0, rp_level), (1.0, rp_level)),
        style: (stroke: (dash: "dashed", paint: blue)),
        label: [$1\/sqrt(1+epsilon.alt^2)$ (passband edge)],
      )
      plot.add(
        ((1.0, 0), (1.0, rp_level)),
        style: (stroke: (dash: "dashed", paint: blue)),
        mark: none,
      )
      plot.add(
        ((0, as_level), (2.0, as_level)),
        style: (stroke: (dash: "dashed", paint: red)),
        label: [$delta_s$ (stopband limit)],
      )
      plot.add(
        ((2.0, 0), (2.0, as_level)),
        style: (stroke: (dash: "dashed", paint: red)),
        mark: none,
      )
    },
  )
})

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
  [A common special case is $R_p = 3$ dB, giving $epsilon.alt = 1$. This places the passband edge exactly at the half-power point and is the convention used in Butterworth design tables — the normalised cutoff $Omega = 1$ always corresponds to a $-3$ dB attenuation.],
)

== The Butterworth Approximation

=== Maximally Flat Magnitude Response

The Butterworth filter of order $n$ is defined by the magnitude-squared response
$
  |H_n (j Omega)|^2 = frac(1, 1 + Omega^(2n)),
$
where $Omega = omega \/ omega_c$ is the frequency normalised to the $-3$ dB cutoff $omega_c$. Three properties follow immediately:

+ $|H_n (j 0)| = 1$: unity DC gain for all orders.
+ $|H_n (j 1)| = 1\/sqrt(2)$: the $-3$ dB point is always at $Omega = 1$, regardless of $n$.
+ $|H_n (j Omega)|$ is monotonically decreasing in $Omega$ — there is no ripple anywhere.

The response is said to be *maximally flat* at $Omega = 0$ because all derivatives $dif^k |H_n|^2 \/ dif Omega^k$ vanish at $Omega = 0$ for $k = 1, 2, dots, 2n-1$. No other all-pole filter of the same order achieves a flatter passband near DC.

#showybox(
  frame: (
    border-color: blue.darken(30%),
    title-color: blue.darken(30%),
    body-color: blue.lighten(90%),
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: left,
  ),
  title: "Key insight",
  ["Maximally flat" means no passband ripple — the magnitude response hugs unity as long as possible before rolling off. The trade-off is that the transition from passband to stopband is smooth and gradual rather than sharp. Filters that allow passband ripple (Chebyshev, elliptic) achieve a steeper roll-off for the same order.],
)

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  let bw(x, n) = 1.0 / calc.sqrt(1.0 + calc.pow(x, 2 * n))

  plot.plot(
    size: (12, 5),
    x-tick-step: 0.5,
    y-tick-step: 0.2,
    y-min: -0.05,
    y-max: 1.15,
    x-min: 0,
    x-max: 3,
    x-label: $Omega = omega \/ omega_c$,
    y-label: $|H_n (j Omega)|$,
    axis-style: "left",
    legend: "inner-north-east",
    {
      plot.add(
        domain: (0, 3), t => (t, bw(t, 1)), samples: 200, label: $n = 1$,
      )
      plot.add(
        domain: (0, 3), t => (t, bw(t, 2)), samples: 200,
        style: (stroke: (dash: "dashed")), label: $n = 2$,
      )
      plot.add(
        domain: (0, 3), t => (t, bw(t, 3)), samples: 200,
        style: (stroke: (paint: blue)), label: $n = 3$,
      )
      plot.add(
        domain: (0, 3), t => (t, bw(t, 5)), samples: 200,
        style: (stroke: (paint: red)), label: $n = 5$,
      )
      plot.add(
        ((0, 1.0 / calc.sqrt(2.0)), (3, 1.0 / calc.sqrt(2.0))),
        style: (stroke: (dash: "dotted", paint: gray)),
        mark: none,
      )
    },
  )
})

=== Roll-off Rate

For $Omega >> 1$ the $Omega^(2n)$ term dominates the denominator and
$
  |H_n (j Omega)| approx Omega^(-n).
$
In dB this is $-20n log_10 Omega$, giving a high-frequency roll-off of *$-20n$ dB per decade* (equivalently $-6n$ dB per octave). Each additional pole therefore contributes an extra 20 dB/decade of attenuation.

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
  [The roll-off rate of $-20n$ dB/decade only applies well into the stopband ($Omega >> 1$). In the transition band the actual slope is shallower. When checking whether a design meets spec, always evaluate $|H_n (j Omega)|$ directly at $omega_s$ rather than relying on the asymptotic rate.],
)

== Butterworth Poles and Transfer Function

=== Pole Locations

To find a causal, stable transfer function $H_n (s)$ realising the Butterworth response, note that
$
  |H_n (j omega)|^2 = H_n (s) H_n (-s) bar_(s = j omega) = frac(1, 1 + (-1)^n s^(2n)) bar_(s = j omega).
$
The $2n$ poles of $H_n (s) H_n (-s)$ are the roots of $1 + (-1)^n s^(2n) = 0$, which gives $s^(2n) = (-1)^(n+1)$. These $2n$ roots lie *equally spaced on the unit circle* in the $s$-plane:
$
  s_k = exp lr([j frac(pi (2k + n - 1), 2n)]), quad k = 1, 2, dots, 2n.
$
For a stable, causal filter we assign the $n$ poles in the *left half-plane* (Re$\{s_k\} < 0$) to $H_n (s)$; the remaining $n$ mirror-image poles belong to $H_n (-s)$.

#showybox(
  frame: (
    border-color: blue.darken(30%),
    title-color: blue.darken(30%),
    body-color: blue.lighten(90%),
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: left,
  ),
  title: "Key insight",
  [For *odd* $n$ there is always a real pole at $s = -1$, so $H_n (s)$ contains a first-order factor $(s + 1)$. For *even* $n$ all poles are complex conjugate pairs. This determines the cascade structure: odd-order designs have one first-order section; even-order designs consist entirely of second-order sections.],
)

The pole locations for $n = 3$ and $n = 4$ are shown below. Open circles mark the right-half-plane poles assigned to $H_n (-s)$; filled circles are the stable poles of $H_n (s)$.

#cetz.canvas({
  import cetz.draw: *

  let poles(n, ox, oy) = {
    for k in range(1, 2 * n + 1) {
      let angle = calc.pi * (2 * k + n - 1) / (2 * n)
      let x = calc.cos(angle)
      let y = calc.sin(angle)
      let stable = x < -0.001
      if stable {
        circle((ox + x, oy + y), radius: 0.08, fill: black)
      } else {
        circle((ox + x, oy + y), radius: 0.08, fill: white, stroke: black)
      }
    }
  }

  // unit circles
  circle((3, 3), radius: 1, stroke: (dash: "dashed", paint: gray))
  circle((9, 3), radius: 1, stroke: (dash: "dashed", paint: gray))

  // axes n=3
  line((0.5, 3), (5.5, 3), mark: (end: "stealth", fill: black))
  line((3, 0.5), (3, 5.5), mark: (end: "stealth", fill: black))
  content((5.6, 3), [$sigma$], anchor: "west")
  content((3, 5.7), [$j omega$], anchor: "south")
  content((3, 0.2), [$n = 3$], anchor: "north")

  // axes n=4
  line((6.5, 3), (11.5, 3), mark: (end: "stealth", fill: black))
  line((9, 0.5), (9, 5.5), mark: (end: "stealth", fill: black))
  content((11.6, 3), [$sigma$], anchor: "west")
  content((9, 5.7), [$j omega$], anchor: "south")
  content((9, 0.2), [$n = 4$], anchor: "north")

  poles(3, 3, 3)
  poles(4, 9, 3)
})

=== Transfer Function

The normalised ($omega_c = 1$ rad/s) Butterworth transfer function is
$
  H_n (s) = frac(1, B_n (s)),
$
where $B_n (s) = product_(k=1)^n (s - s_k)$ is the *Butterworth polynomial* formed from the $n$ stable poles. The first five polynomials are:

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  align: (center, left),
  table.header([*Order $n$*], [*Butterworth polynomial $B_n (s)$*]),
  [$1$], [$s + 1$],
  [$2$], [$s^2 + sqrt(2) s + 1$],
  [$3$], [$(s + 1)(s^2 + s + 1)$],
  [$4$], [$(s^2 + 0.7654 s + 1)(s^2 + 1.8478 s + 1)$],
  [$5$], [$(s + 1)(s^2 + 0.6180 s + 1)(s^2 + 1.6180 s + 1)$],
)

Each quadratic factor $s^2 + 2 zeta omega_0 s + omega_0^2$ has $omega_0 = 1$ (all poles on the unit circle) and a damping ratio $zeta = -cos(theta_k)$ where $theta_k$ is the pole angle. The $n = 2$ factor has $zeta = 1\/sqrt(2) approx 0.707$, the standard Butterworth damping ratio.

== Filter Order Selection

=== Order Formula

Given the four design parameters $omega_p$, $R_p$, $omega_s$, $A_s$, the minimum Butterworth order that simultaneously satisfies both constraints is found by evaluating the magnitude-squared response at each specification edge:
$
  frac(1, 1 + (omega_p \/ omega_c)^(2n)) gt.eq 10^(-R_p\/10)
  quad "and" quad
  frac(1, 1 + (omega_s \/ omega_c)^(2n)) lt.eq 10^(-A_s\/10).
$
Solving each inequality for $n$ and taking the more demanding result gives
$
  n gt.eq frac(log lr((frac(10^(A_s\/10) - 1, 10^(R_p\/10) - 1))), 2 log (omega_s \/ omega_p)).
$
Round *up* to the nearest integer to guarantee both constraints are met.

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
  [Always round $n$ *up*. Rounding down produces a filter that meets neither the passband nor the stopband specification. Once $n$ is fixed, the cutoff $omega_c$ is chosen to place the excess margin in the stopband (passband-edge design) or split it between both bands depending on the application.],
)

=== Worked Example: Order Selection and Transfer Function

*Problem.* Design a Butterworth low-pass filter with no more than 3 dB ripple at $omega_p = 1000$ rad/s and at least 20 dB attenuation at $omega_s = 3000$ rad/s. Determine the minimum order and write the denormalised transfer function.

*Step 1 — Compute the order.*

With $R_p = 3$ dB ($10^(R_p\/10) - 1 = 1$) and $A_s = 20$ dB ($10^(A_s\/10) - 1 approx 99$):
$
  n gt.eq frac(log(99 \/ 1), 2 log(3000 \/ 1000)) = frac(log 99, 2 log 3) approx frac(1.996, 0.954) approx 2.09.
$
Round up: $n = 3$.

*Step 2 — Determine the cutoff frequency.*

Placing the passband edge exactly at spec (passband-edge design) with $R_p = 3$ dB gives $epsilon.alt = 1$ and
$
  omega_c = frac(omega_p, (10^(R_p\/10) - 1)^(1\/(2n))) = frac(1000, 1^(1\/6)) = 1000 " rad/s."
$

*Step 3 — Write the transfer function.*

From the $n = 3$ Butterworth polynomial $B_3 (s) = (s + 1)(s^2 + s + 1)$, denormalise by substituting $s arrow.r s \/ omega_c$:
$
  H(s) = frac(omega_c^3, (s + omega_c)(s^2 + omega_c s + omega_c^2))
        = frac(10^9, (s + 1000)(s^2 + 1000 s + 10^6)).
$

*Step 4 — Verify stopband attenuation.*

At $omega = omega_s = 3000$ rad/s, $Omega_s = omega_s \/ omega_c = 3$:
$
  |H_3 (j 3)| = frac(1, sqrt(1 + 3^6)) = frac(1, sqrt(730)) approx 0.037,
$
which in dB is $20 log_10 (0.037) approx -28.6$ dB $< -20$ dB. $checkmark$

The design meets spec with 8.6 dB of stopband margin to spare.

== Frequency Transformations

Once a normalised Butterworth LP prototype $H_n (s)$ is designed, algebraic substitutions map it to high-pass, band-pass, or band-stop responses without repeating the approximation step. All four standard filter types therefore share a single set of Butterworth tables.

#showybox(
  frame: (
    border-color: blue.darken(30%),
    title-color: blue.darken(30%),
    body-color: blue.lighten(90%),
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: left,
  ),
  title: "Key insight",
  [Every frequency transformation is a change of variable $s arrow.r f(s)$ that maps the LP passband edge $Omega = 1$ to the desired passband edge(s) of the target filter. The substitution is applied directly to $H_n (s)$; no new pole-location calculation is needed.],
)

=== Low-Pass to High-Pass

Replace $s arrow.r omega_c \/ s$ in the normalised prototype:
$
  H_"HP" (s) = H_n lr((frac(omega_c, s))).
$
This maps $Omega = omega / omega_c arrow.r omega_c \/ omega$, so the LP passband ($|Omega| lt.eq 1$) becomes the HP passband ($omega gt.eq omega_c$) and the LP stopband maps to the HP stopband. The filter order is unchanged; an $n$th-order LP yields an $n$th-order HP.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  let hp(x, n, wc) = 1.0 / calc.sqrt(1.0 + calc.pow(wc / x, 2 * n))

  plot.plot(
    size: (12, 4),
    x-tick-step: 500,
    y-tick-step: 0.2,
    y-min: -0.05,
    y-max: 1.15,
    x-min: 0,
    x-max: 3000,
    x-label: [$omega$ (rad/s)],
    y-label: $|H_"HP" (j omega)|$,
    axis-style: "left",
    legend: "inner-south-east",
    {
      plot.add(
        domain: (10, 3000), t => (t, hp(t, 2, 500)), samples: 300,
        label: $n = 2$,
      )
      plot.add(
        domain: (10, 3000), t => (t, hp(t, 3, 500)), samples: 300,
        style: (stroke: (dash: "dashed")), label: $n = 3$,
      )
      plot.add(
        ((500, 0), (500, 1.0 / calc.sqrt(2.0))),
        style: (stroke: (dash: "dotted", paint: gray)), mark: none,
      )
    },
  )
})

==== Worked Example: High-Pass Filter

*Problem.* Design a 2nd-order Butterworth HPF with $-3$ dB at $omega_c = 500$ rad/s. Verify that the attenuation at $omega = 100$ rad/s exceeds 20 dB.

*Step 1 — LP prototype.* For $n = 2$:
$
  H_2 (s) = frac(1, s^2 + sqrt(2) s + 1).
$

*Step 2 — Apply LP$arrow.r$HP transformation* with $s arrow.r 500 \/ s$:
$
  H_"HP" (s) = H_2 lr((frac(500, s)))
             = frac(1, lr((frac(500, s)))^2 + sqrt(2) frac(500, s) + 1)
             = frac(s^2, s^2 + 500 sqrt(2) s + 500^2).
$

*Step 3 — Verify attenuation at $omega = 100$ rad/s.*

The normalised frequency is $Omega = omega_c \/ omega = 500 \/ 100 = 5$ (LP domain):
$
  |H_"HP" (j 100)| = |H_2 (j 5)| = frac(1, sqrt(1 + 5^4)) = frac(1, sqrt(626)) approx 0.040,
$
giving $20 log_10 (0.040) approx -28.0$ dB $< -20$ dB. $checkmark$

=== Low-Pass to Band-Pass

Replace $s arrow.r Q lr((s \/ omega_0 + omega_0 \/ s))$ where $omega_0 = sqrt(omega_1 omega_2)$ is the geometric centre frequency, $B = omega_2 - omega_1$ is the $-3$ dB bandwidth, and $Q = omega_0 \/ B$ is the quality factor:
$
  H_"BP" (s) = H_n lr((Q lr((frac(s, omega_0) + frac(omega_0, s))))).
$
The LP passband $|Omega| lt.eq 1$ maps to the BP passband $omega_1 lt.eq omega lt.eq omega_2$. An $n$th-order LP prototype yields a *$2n$th-order* band-pass filter.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  let bp(w, n, w0, Q) = {
    let lp_arg = if w == 0.0 { 1e10 } else { Q * (w / w0 - w0 / w) }
    1.0 / calc.sqrt(1.0 + calc.pow(lp_arg, 2 * n))
  }

  plot.plot(
    size: (12, 4),
    x-tick-step: 500,
    y-tick-step: 0.2,
    y-min: -0.05,
    y-max: 1.15,
    x-min: 0,
    x-max: 3000,
    x-label: [$omega$ (rad/s)],
    y-label: $|H_"BP" (j omega)|$,
    axis-style: "left",
    legend: "inner-north-east",
    {
      plot.add(
        domain: (10, 3000), t => (t, bp(t, 1, 1000, 5)), samples: 400,
        label: $n = 1$,
      )
      plot.add(
        domain: (10, 3000), t => (t, bp(t, 2, 1000, 5)), samples: 400,
        style: (stroke: (dash: "dashed")), label: $n = 2$,
      )
      plot.add(
        ((1000, 0), (1000, 1.0)),
        style: (stroke: (dash: "dotted", paint: gray)), mark: none,
      )
    },
  )
})

==== Worked Example: Band-Pass Filter

*Problem.* Design a Butterworth BPF with centre frequency $omega_0 = 1000$ rad/s, $-3$ dB bandwidth $B = 200$ rad/s, and at least 20 dB attenuation at $omega = 500$ rad/s. Use the lowest order LP prototype that meets spec.

*Step 1 — Map the stopband edge to the LP domain.*

$Q = omega_0 \/ B = 1000 \/ 200 = 5$. The LP equivalent frequency at $omega = 500$ rad/s is
$
  Omega_s = Q lr((frac(omega_s, omega_0) - frac(omega_0, omega_s))) = 5 lr((frac(500, 1000) - frac(1000, 500))) = 5(-1.5) = -7.5.
$
By symmetry $|Omega_s| = 7.5$; use the LP order formula with $omega_p \/ omega_c = 1$ and $omega_s \/ omega_c = 7.5$, $A_s = 20$ dB:
$
  n gt.eq frac(log(99), 2 log(7.5)) approx frac(1.996, 1.749) approx 1.14 arrow.r n = 2.
$

*Step 2 — LP prototype* ($n = 2$):
$
  H_2 (s) = frac(1, s^2 + sqrt(2) s + 1).
$

*Step 3 — Apply LP$arrow.r$BP transformation* with $omega_0 = 1000$, $Q = 5$:
$
  H_"BP" (s) = H_2 lr((5 lr((frac(s, 1000) + frac(1000, s))))).
$
This yields a 4th-order band-pass filter. Expanding gives
$
  H_"BP" (s) = frac(4 times 10^6 s^2, s^4 + 2 sqrt(2) times 100 s^3 + (2 times 10^6 + 2 times 10^4) s^2 + 2 sqrt(2) times 10^8 s + 10^12).
$

*Step 4 — Verify.* At $omega = 500$ rad/s, $Omega = -7.5$ (LP domain):
$
  |H_2 (j 7.5)| = frac(1, sqrt(1 + 7.5^4)) approx frac(1, sqrt(3165)) approx 0.018,
$
giving $approx -35$ dB $< -20$ dB. $checkmark$

=== Low-Pass to Band-Stop

Replace $s arrow.r 1 \/ [Q (s \/ omega_0 + omega_0 \/ s)]$:
$
  H_"BS" (s) = H_n lr((frac(1, Q (s \/ omega_0 + omega_0 \/ s)))).
$
The LP passband maps to the BS stopband and the LP stopband maps to the two BS passbands on either side of $omega_0$. As with the BP case, an $n$th-order LP prototype produces a $2n$th-order band-stop filter.

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  let bs(w, n, w0, Q) = {
    let arg = if w == 0.0 { 1e10 } else { Q * (w / w0 - w0 / w) }
    let lp_arg = if arg == 0.0 { 1e10 } else { 1.0 / arg }
    1.0 / calc.sqrt(1.0 + calc.pow(lp_arg, 2 * n))
  }

  plot.plot(
    size: (12, 4),
    x-tick-step: 500,
    y-tick-step: 0.2,
    y-min: -0.05,
    y-max: 1.15,
    x-min: 0,
    x-max: 3000,
    x-label: [$omega$ (rad/s)],
    y-label: $|H_"BS" (j omega)|$,
    axis-style: "left",
    legend: "inner-north-east",
    {
      plot.add(
        domain: (10, 950), t => (t, bs(t, 2, 1000, 5)), samples: 300,
        label: $n = 2$,
      )
      plot.add(
        domain: (1050, 3000), t => (t, bs(t, 2, 1000, 5)), samples: 300,
        mark: none,
      )
    },
  )
})

==== Worked Example: Band-Stop (Notch) Filter

*Problem.* A biomedical acquisition system picks up 50 Hz mains interference. Design a Butterworth BSF to attenuate the tone at $omega_0 = 2 pi times 50 approx 314$ rad/s by at least 30 dB while keeping $|H| gt.eq -3$ dB for all $omega lt.eq 0.8 omega_0$ and $omega gt.eq 1.2 omega_0$.

*Step 1 — Identify parameters.*

The passband edges are $omega_1 = 0.8 omega_0 = 251$ rad/s and $omega_2 = 1.2 omega_0 = 377$ rad/s, giving $B = 126$ rad/s and $Q = omega_0 \/ B = 314 \/ 126 approx 2.49$.

*Step 2 — Map the passband edge to the LP prototype.*

The BS passband edge at $omega_1 = 0.8 omega_0$ maps to the LP domain as
$
  Omega_p = frac(1, Q (omega_1 \/ omega_0 - omega_0 \/ omega_1)) = frac(1, 2.49(0.8 - 1.25)) = frac(1, 2.49 times (-0.45)) approx 0.892.
$
By the LP$arrow.r$BS duality, $|Omega_p| = 0.892 < 1$, which confirms the passband requirement of $R_p = 3$ dB is met with margin. The effective LP stopband edge (corresponding to the BS notch at $omega_0$) maps to $Omega_s arrow.r infinity$, so *any* finite order meets the 30 dB notch depth requirement in principle. The roll-off near $omega_0$ determines the practical notch width.

For a 2nd-order LP prototype ($n = 2$), which gives a 4th-order BSF:

*Step 3 — Apply LP$arrow.r$BS transformation* with $omega_0 = 314$ rad/s, $Q = 2.49$:
$
  H_"BS" (s) = H_2 lr((frac(1, 2.49 (s\/314 + 314\/s)))).
$

*Step 4 — Verify notch depth.* At $omega = omega_0$ the LP argument $arrow.r infinity$, so $H_2 (j infinity) = 0$ — the notch is theoretically infinite. In practice component tolerances limit notch depth to 40–60 dB.

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
  [Mains notch filters are a common requirement in ECG and EEG systems. A higher $Q$ produces a narrower notch (less signal distortion on either side) but requires tighter component tolerances. A lower $Q$ is more robust to component variation but attenuates nearby signal frequencies.],
)

== Summary

The Butterworth filter design procedure can be summarised in five steps:

+ *Specify* the filter requirements: passband edge $omega_p$, passband ripple $R_p$ (dB), stopband edge $omega_s$, and stopband attenuation $A_s$ (dB).
+ *Compute the order* using
  $ n gt.eq frac(log lr((frac(10^(A_s\/10) - 1, 10^(R_p\/10) - 1))), 2 log (omega_s \/ omega_p)), $
  rounding up to the nearest integer.
+ *Select the LP prototype* $H_n (s) = 1\/B_n (s)$ from the Butterworth polynomial table.
+ *Denormalise* by substituting $s arrow.r s\/omega_c$ to place the cutoff at the desired frequency.
+ *Apply a frequency transformation* if a HP, BP, or BS response is required.

The key properties of the Butterworth approximation are:

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  align: (left, left),
  table.header([*Property*], [*Detail*]),
  [Passband behaviour],   [Maximally flat — no ripple; all derivatives of $|H|^2$ vanish at $omega = 0$],
  [Cutoff frequency],     [$-3$ dB for all orders at the normalised frequency $Omega = 1$],
  [Roll-off rate],        [$-20n$ dB/decade asymptotically in the stopband],
  [Pole locations],       [$n$ poles equally spaced on the left-half unit circle],
  [Filter types],         [LP, HP, BP, BS all derived from the same LP prototype],
)

#showybox(
  frame: (
    border-color: blue.darken(30%),
    title-color: blue.darken(30%),
    body-color: blue.lighten(90%),
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: left,
  ),
  title: "Key insight",
  [The Butterworth filter is the right choice when a monotone magnitude response and no passband ripple are essential — for example, in audio equalisation or precision measurement systems. When a sharper roll-off is needed at the cost of some passband ripple, Chebyshev or elliptic designs are preferred. Chapter 6 will show why the filter's passband edge $omega_p$ directly sets the minimum sampling rate needed to digitise a filtered analogue signal without aliasing.],
)

= Nyquist's Sampling Theorem

Chapters 1–5 have dealt exclusively with continuous-time signals and systems. In practice, signals are processed digitally: an analogue voltage is measured at discrete instants, converted to a binary number, processed by a computer, and converted back to an analogue output. The bridge between the continuous and discrete worlds is *sampling*. This chapter answers the fundamental question: how frequently must a continuous-time signal be sampled so that no information is lost, and how can the original signal be recovered from its samples?

== Ideal Sampling

=== The Impulse Train Sampler

The mathematical model of an ideal sampler multiplies the continuous-time signal $x(t)$ by a periodic impulse train
$
  p(t) = sum_(n = -infinity)^(infinity) delta(t - n T_s),
$
where $T_s$ is the *sampling period* and $f_s = 1\/T_s$ is the *sampling frequency* in Hz (equivalently $omega_s = 2 pi f_s$ rad/s). The sampled signal is
$
  x_s (t) = x(t) p(t) = sum_(n=-infinity)^(infinity) x(n T_s) delta(t - n T_s).
$
Each impulse carries the signal value $x(n T_s)$ at that instant as its weight. The sampled signal is therefore a sequence of weighted impulses, one at each sampling instant.

#diagram(
  spacing: 10pt,
  node-stroke: 2pt,
  edge-stroke: 1pt,
  node((0, 1), [$x(t)$], stroke: 0pt, name: <in>),
  node((6, 1), [Sampler $times p(t)$], width: 30mm, height: 12mm, name: <S>),
  node((14, 1), [$x_s (t)$], stroke: 0pt, name: <out>),
  edge(<in>, <S>, "-|>"),
  edge(<S>, <out>, "-|>"),
)

=== Spectrum of the Sampled Signal

From Chapter 3, the Fourier transform of the impulse train is itself an impulse train (§3.4):
$
  P(j omega) = frac(2 pi, T_s) sum_(k=-infinity)^(infinity) delta(omega - k omega_s).
$
Since $x_s (t) = x(t) p(t)$, the multiplication-in-time property gives convolution in frequency:
$
  X_s (j omega) = frac(1, 2 pi) X(j omega) ast P(j omega)
                = frac(1, T_s) sum_(k=-infinity)^(infinity) X(j(omega - k omega_s)).
$
The spectrum of the sampled signal is a *periodic replication* of $X(j omega)$, repeated every $omega_s$ rad/s and scaled by $1\/T_s$.

#showybox(
  frame: (
    border-color: blue.darken(30%),
    title-color: blue.darken(30%),
    body-color: blue.lighten(90%),
  ),
  title-style: (color: black, weight: "regular", align: left),
  title: "Key insight",
  [Sampling in time is equivalent to periodic replication in frequency. Every $omega_s$ rad/s, a copy of $X(j omega)$ appears in the spectrum of $x_s (t)$. Whether these copies overlap depends on the relationship between $omega_s$ and the signal bandwidth $omega_M$ — this is the essence of the sampling theorem.],
)

The figure below shows $X_s (j omega)$ for two cases: sufficient sampling rate (replicas separated) and insufficient rate (replicas overlap).

#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  let tri(x, wm) = if calc.abs(x) <= wm { 1.0 - calc.abs(x) / wm } else { 0.0 }

  plot.plot(
    size: (5.5, 3),
    x-tick-step: 3,
    y-tick-step: 0.5,
    y-min: -0.1,
    y-max: 1.3,
    x-min: -7,
    x-max: 7,
    x-label: $omega$,
    y-label: [$|X_s (j omega)| slash T_s^(-1)$],
    axis-style: "left",
    {
      for k in (-2, -1, 0, 1, 2) {
        let s = if k == 0 { (stroke: black) } else { (stroke: (paint: blue.lighten(40%))) }
        plot.add(
          domain: (-7, 7),
          t => (t, tri(t - k * 3, 1)),
          samples: 300,
          style: s,
          mark: none,
        )
      }
    },
  )

  cetz.draw.translate((8, 0))

  plot.plot(
    size: (5.5, 3),
    x-tick-step: 3,
    y-tick-step: 0.5,
    y-min: -0.1,
    y-max: 1.3,
    x-min: -7,
    x-max: 7,
    x-label: $omega$,
    y-label: [$|X_s (j omega)| slash T_s^(-1)$],
    axis-style: "left",
    {
      for k in (-2, -1, 0, 1, 2) {
        let s = if k == 0 { (stroke: black) } else { (stroke: (paint: red.lighten(40%))) }
        plot.add(
          domain: (-7, 7),
          t => (t, tri(t - k * 3, 1.8)),
          samples: 300,
          style: s,
          mark: none,
        )
      }
    },
  )
})

Left: $omega_s > 2 omega_M$ — replicas are separated and the original spectrum (black) can be recovered. Right: $omega_s < 2 omega_M$ — replicas overlap (aliasing) and the baseband is corrupted.

= State-Space Analysis

