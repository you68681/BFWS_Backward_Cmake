(define (problem blocks-10-1)
(:domain blocks)
(:objects a b c - block)
(:init (on b a) (on b c) (on c b) (on a c) (ontable a) (ontable b) (ontable c) (clear a) (clear b) (clear c) (handempty) (holding a) (holding b) (holding c))
(:goal (and (on a b) (on b a) (on a c) (on c b) (on b c) (clear a) (ontable c) (holding c) (holding a) (holding b))))