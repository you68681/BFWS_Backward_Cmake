(define (problem BLOCKS-10-1)
(:domain BLOCKS)
(:objects D A J I E G H B F C - block)
(:INIT (CLEAR C) (CLEAR F) (ONTABLE B) (ONTABLE H) (ON C G) (ON G E) (ON E I)
 (ON I J) (ON J A) (ON A B) (ON F D) (ON D H) (HANDEMPTY))
(:goal (AND (ON C B) (ON B D) (ON D F) (ON F I) (ON I A) (ON A E) (ON E H)
            (ON H G) (ON G J) (ONTABLE J)))
)
