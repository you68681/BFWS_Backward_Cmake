(define (problem blocks-8-2)
(:domain blocks)
(:objects f b g c h e a d - block)
(:init (on f b) (on f g) (on f c) (on f h) (on f e) (on f d) (on b f) (on b g) (on b c) (on b h) (on b a) (on b d) (on g b) (on g c) (on g h) (on g e) (on g a) (on g d) (on c f) (on c g) (on c h) (on c e) (on c a) (on c d) (on h f) (on h b) (on h g) (on h c) (on h e) (on h a) (on h d) (on e f) (on e b) (on e c) (on e h) (on e a) (on e d) (on a f) (on a b) (on a g) (on a c) (on a h) (on a e) (on d f) (on d b) (on d g) (on d c) (on d e) (on d a) (ontable f) (ontable b) (ontable g) (ontable c) (ontable h) (ontable e) (ontable a) (ontable d) (clear f) (clear b) (clear g) (clear c) (clear h) (clear e) (clear a) (clear d) (handempty) (holding f) (holding b) (holding g) (holding c) (holding h) (holding e) (holding a) (holding d))
(:goal (and (on f b) (on f c) (on f h) (on f e) (on f a) (on f d) (on b g) (on b c) (on b h) (on b e) (on b a) (on b d) (on g f) (on g b) (on g c) (on g h) (on g e) (on g a) (on g d) (on c f) (on c b) (on c g) (on c h) (on c e) (on c a) (on c d) (on h f) (on h b) (on h g) (on h c) (on h e) (on h a) (on h d) (on e f) (on e b) (on e g) (on e c) (on e h) (on e a) (on e d) (on a f) (on a b) (on a g) (on a c) (on a h) (on a e) (on a d) (on d f) (on d g) (on d c) (on d h) (on d e) (on d a) (ontable f) (ontable b) (ontable d) (clear f) (clear b) (clear g) (holding f) (holding b) (holding g) (holding c) (holding h) (holding e) (holding a) (holding d))))