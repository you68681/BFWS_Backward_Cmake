(define (problem BLOCKS-10-1)
(:domain BLOCKS)
(:objects A B C - block)
(:INIT (CLEAR A) (CLEAR B) (CLEAR C) (ONTABLE A) (ONTABLE B) (ONTABLE C) (HANDEMPTY))
(:goal (and (ON A B) (ON B C))))
