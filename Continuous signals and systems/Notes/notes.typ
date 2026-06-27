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

= Butterworth Filter Design

= Nyquist's Sampling Theorem

= State-Space Analysis

