= Requirements Elicitation & Validation
<Chapter::ElicitationValidation}}

\section{Elicitation}

The problem domain is very will known, so not a ton of outside information was necessary. The following methods were used to elicit requirements.

\begin{enumerate}
  \item Brainstorming
  \item Research
  \item User interviews to verify requirements, and project motivation
\end{enumerate}

\section{Validation Plan}

The success of this project can be measured by the following metrics.

\subsection{Quality Validation}

\begin{itemize}
  \item The frontend must work identically when connecting to the balancer as it does when connecting to a monolith.
  \item All E2E integration tests must pass with and without the balancer.
\end{itemize}

\subsection{Performance Validation}

\begin{itemize}
  \item The Balancer must be able to handle thousands of clients sending/receiving about 2-6 messages/sec, with about 5 clients per room.
  \item Requires a custom performance testing harness.
\end{itemize}

\subsection{Balancing Validation}

\begin{itemize}
  \item The Balancer should generally evenly distribute load across all Monoliths.
\end{itemize}