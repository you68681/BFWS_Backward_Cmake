(define (problem BLOCKS-19-1)
(:domain BLOCKS)
(:objects B R I N J G M P F S C L H K D E O Q A - block)
(:INIT (CLEAR A) (CLEAR Q) (CLEAR O) (ONTABLE E) (ONTABLE D) (ONTABLE K)
 (ON A H) (ON H L) (ON L C) (ON C S) (ON S F) (ON F P) (ON P M) (ON M G)
 (ON G J) (ON J N) (ON N I) (ON I R) (ON R E) (ON Q D) (ON O B) (ON B K)
 (HANDEMPTY))
(:goal (AND (ON L C) (ON C S) (ON S I) (ON I J) (ON J K) (ON K E) (ON E B)
            (ON B H) (ON H A) (ON A D) (ON D P) (ON P N) (ON N O) (ON O R)
            (ON R Q) (ON Q F) (ON F G) (ON G M) (ONTABLE M)))
)