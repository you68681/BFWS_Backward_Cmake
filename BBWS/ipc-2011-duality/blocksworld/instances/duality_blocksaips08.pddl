(define (problem blocks-6-1)
(:domain blocks)
(:objects f d c e b a - block)
(:init (on f d) (on f e) (on f b) (on f a) (on d f) (on d c) (on d e) (on d b) (on d a) (on c f) (on c d) (on c e) (on c a) (on e d) (on e c) (on e b) (on e a) (on b f) (on b d) (on b c) (on b e) (on a f) (on a c) (on a e) (on a b) (ontable f) (ontable d) (ontable c) (ontable e) (ontable b) (ontable a) (clear f) (clear d) (clear c) (clear e) (clear b) (clear a) (handempty) (holding f) (holding d) (holding c) (holding e) (holding b) (holding a))
(:goal (and (on f d) (on f c) (on f e) (on f b) (on f a) (on d f) (on d c) (on d e) (on d b) (on d a) (on c f) (on c d) (on c e) (on c b) (on c a) (on e f) (on e d) (on e c) (on e b) (on e a) (on b f) (on b d) (on b c) (on b e) (on b a) (on a d) (on a c) (on a e) (on a b) (ontable a) (clear f) (holding f) (holding d) (holding c) (holding e) (holding b) (holding a))))