(define (problem blocks-4-1)
(:domain blocks)
(:objects a c d b - block)
(:init (on a c) (on a d) (on c d) (on c b) (on d a) (on d b) (on b a) (on b c) (on b d) (ontable a) (ontable c) (ontable d) (ontable b) (clear a) (clear c) (clear d) (clear b) (handempty) (holding a) (holding c) (holding d) (holding b))
(:goal (and (on a c) (on a b) (on c d) (on c b) (on d a) (on d c) (on d b) (on b a) (on b d) (ontable a) (ontable c) (ontable b) (clear a) (clear c) (clear d) (holding a) (holding c) (holding d) (holding b))))