(define (problem blocks-6-2)
(:domain blocks)
(:objects e f b d c a - block)
(:init (on e b) (on e d) (on e c) (on e a) (on f e) (on f b) (on f d) (on f c) (on b e) (on b f) (on b d) (on b a) (on d e) (on d f) (on d b) (on d c) (on d a) (on c e) (on c f) (on c b) (on c a) (on a e) (on a f) (on a d) (on a c) (ontable e) (ontable f) (ontable b) (ontable d) (ontable c) (ontable a) (clear e) (clear f) (clear b) (clear d) (clear c) (clear a) (handempty) (holding e) (holding f) (holding b) (holding d) (holding c) (holding a))
(:goal (and (on e f) (on e b) (on e d) (on e a) (on f b) (on f d) (on f c) (on f a) (on b e) (on b d) (on b c) (on b a) (on d e) (on d f) (on d c) (on d a) (on c e) (on c f) (on c b) (on c d) (on c a) (on a e) (on a f) (on a b) (on a c) (ontable e) (ontable f) (ontable b) (ontable d) (ontable a) (clear e) (clear f) (clear b) (clear d) (clear c) (holding e) (holding f) (holding b) (holding d) (holding c) (holding a))))