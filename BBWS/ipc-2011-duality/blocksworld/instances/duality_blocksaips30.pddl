(define (problem blocks-14-1)
(:domain blocks)
(:objects k a f l d b m e j n h i c g - block)
(:init (on k a) (on k l) (on k d) (on k b) (on k m) (on k e) (on k j) (on k n) (on k h) (on k i) (on k c) (on k g) (on a k) (on a f) (on a l) (on a d) (on a b) (on a m) (on a e) (on a j) (on a n) (on a h) (on a c) (on a g) (on f k) (on f a) (on f l) (on f d) (on f b) (on f m) (on f e) (on f j) (on f n) (on f h) (on f i) (on f c) (on l k) (on l a) (on l f) (on l d) (on l b) (on l m) (on l e) (on l j) (on l h) (on l i) (on l c) (on l g) (on d k) (on d a) (on d f) (on d l) (on d m) (on d e) (on d j) (on d n) (on d h) (on d i) (on d c) (on d g) (on b k) (on b a) (on b f) (on b l) (on b d) (on b m) (on b e) (on b j) (on b n) (on b i) (on b c) (on b g) (on m a) (on m f) (on m l) (on m d) (on m b) (on m e) (on m j) (on m n) (on m h) (on m i) (on m c) (on m g) (on e k) (on e a) (on e f) (on e d) (on e b) (on e m) (on e j) (on e n) (on e h) (on e i) (on e c) (on e g) (on j k) (on j a) (on j f) (on j l) (on j b) (on j m) (on j e) (on j n) (on j h) (on j i) (on j c) (on j g) (on n k) (on n a) (on n f) (on n l) (on n d) (on n b) (on n m) (on n e) (on n j) (on n h) (on n i) (on n g) (on h k) (on h a) (on h f) (on h l) (on h d) (on h b) (on h e) (on h j) (on h n) (on h i) (on h c) (on h g) (on i k) (on i a) (on i f) (on i l) (on i d) (on i b) (on i m) (on i j) (on i n) (on i h) (on i c) (on i g) (on c k) (on c a) (on c f) (on c l) (on c d) (on c b) (on c m) (on c e) (on c j) (on c n) (on c h) (on c i) (on c g) (on g k) (on g f) (on g l) (on g d) (on g b) (on g m) (on g e) (on g j) (on g n) (on g h) (on g i) (on g c) (ontable k) (ontable a) (ontable f) (ontable l) (ontable d) (ontable b) (ontable m) (ontable e) (ontable j) (ontable n) (ontable h) (ontable i) (ontable c) (ontable g) (clear k) (clear a) (clear f) (clear l) (clear d) (clear b) (clear m) (clear e) (clear j) (clear n) (clear h) (clear i) (clear c) (clear g) (handempty) (holding k) (holding a) (holding f) (holding l) (holding d) (holding b) (holding m) (holding e) (holding j) (holding n) (holding h) (holding i) (holding c) (holding g))
(:goal (and (on k a) (on k f) (on k l) (on k d) (on k m) (on k e) (on k j) (on k n) (on k h) (on k i) (on k c) (on k g) (on a f) (on a l) (on a d) (on a b) (on a m) (on a e) (on a j) (on a n) (on a h) (on a i) (on a c) (on a g) (on f k) (on f l) (on f d) (on f b) (on f m) (on f e) (on f j) (on f n) (on f h) (on f i) (on f c) (on f g) (on l k) (on l a) (on l f) (on l d) (on l b) (on l e) (on l j) (on l n) (on l h) (on l i) (on l c) (on l g) (on d k) (on d a) (on d f) (on d b) (on d m) (on d e) (on d j) (on d n) (on d h) (on d i) (on d c) (on d g) (on b k) (on b a) (on b f) (on b l) (on b d) (on b m) (on b e) (on b j) (on b n) (on b h) (on b i) (on b c) (on b g) (on m k) (on m a) (on m f) (on m l) (on m d) (on m b) (on m e) (on m j) (on m n) (on m h) (on m i) (on m c) (on m g) (on e k) (on e a) (on e f) (on e l) (on e d) (on e b) (on e m) (on e j) (on e n) (on e h) (on e i) (on e c) (on e g) (on j k) (on j a) (on j f) (on j l) (on j d) (on j b) (on j m) (on j e) (on j n) (on j h) (on j i) (on j c) (on j g) (on n k) (on n a) (on n f) (on n l) (on n d) (on n b) (on n m) (on n e) (on n j) (on n h) (on n i) (on n c) (on n g) (on h k) (on h a) (on h l) (on h d) (on h b) (on h m) (on h e) (on h j) (on h n) (on h i) (on h c) (on h g) (on i k) (on i a) (on i f) (on i l) (on i b) (on i m) (on i e) (on i j) (on i n) (on i h) (on i c) (on i g) (on c k) (on c a) (on c f) (on c l) (on c d) (on c b) (on c m) (on c j) (on c n) (on c h) (on c i) (on c g) (on g k) (on g a) (on g f) (on g l) (on g d) (on g b) (on g m) (on g e) (on g n) (on g h) (on g i) (on g c) (ontable k) (ontable a) (ontable f) (ontable l) (ontable d) (ontable h) (ontable i) (ontable c) (ontable g) (clear k) (clear a) (clear f) (clear l) (clear d) (clear b) (clear m) (clear e) (clear j) (holding k) (holding a) (holding f) (holding l) (holding d) (holding b) (holding m) (holding e) (holding j) (holding n) (holding h) (holding i) (holding c) (holding g))))