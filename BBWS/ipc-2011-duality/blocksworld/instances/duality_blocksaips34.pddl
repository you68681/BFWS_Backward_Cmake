(define (problem blocks-16-2)
(:domain blocks)
(:objects k i g n p a d m c b h f o j l e - block)
(:init (on k i) (on k g) (on k n) (on k p) (on k a) (on k d) (on k m) (on k c) (on k b) (on k h) (on k f) (on k o) (on k l) (on k e) (on i k) (on i g) (on i n) (on i p) (on i a) (on i m) (on i c) (on i b) (on i h) (on i f) (on i o) (on i j) (on i l) (on i e) (on g k) (on g i) (on g n) (on g p) (on g a) (on g d) (on g m) (on g c) (on g b) (on g h) (on g f) (on g o) (on g j) (on g l) (on n k) (on n i) (on n g) (on n p) (on n d) (on n m) (on n c) (on n b) (on n h) (on n f) (on n o) (on n j) (on n l) (on n e) (on p k) (on p i) (on p g) (on p n) (on p a) (on p d) (on p m) (on p c) (on p b) (on p h) (on p f) (on p j) (on p l) (on p e) (on a k) (on a i) (on a g) (on a n) (on a d) (on a m) (on a c) (on a b) (on a h) (on a f) (on a o) (on a j) (on a l) (on a e) (on d k) (on d i) (on d g) (on d n) (on d p) (on d a) (on d m) (on d c) (on d b) (on d f) (on d o) (on d j) (on d l) (on d e) (on m k) (on m i) (on m g) (on m p) (on m a) (on m d) (on m c) (on m b) (on m h) (on m f) (on m o) (on m j) (on m l) (on m e) (on c k) (on c i) (on c g) (on c n) (on c p) (on c a) (on c d) (on c m) (on c b) (on c h) (on c f) (on c o) (on c j) (on c e) (on b i) (on b g) (on b n) (on b p) (on b a) (on b d) (on b m) (on b c) (on b h) (on b f) (on b o) (on b j) (on b l) (on b e) (on h k) (on h i) (on h g) (on h n) (on h p) (on h a) (on h d) (on h m) (on h c) (on h b) (on h o) (on h j) (on h l) (on h e) (on f k) (on f i) (on f g) (on f n) (on f p) (on f a) (on f d) (on f m) (on f c) (on f h) (on f o) (on f j) (on f l) (on f e) (on o k) (on o i) (on o g) (on o n) (on o p) (on o a) (on o d) (on o m) (on o c) (on o b) (on o h) (on o f) (on o j) (on o l) (on o e) (on j k) (on j i) (on j n) (on j p) (on j a) (on j d) (on j m) (on j c) (on j b) (on j h) (on j f) (on j o) (on j l) (on j e) (on l k) (on l i) (on l g) (on l n) (on l p) (on l a) (on l d) (on l c) (on l b) (on l h) (on l f) (on l o) (on l j) (on l e) (on e k) (on e i) (on e g) (on e n) (on e p) (on e a) (on e d) (on e m) (on e b) (on e h) (on e f) (on e o) (on e j) (on e l) (ontable k) (ontable i) (ontable g) (ontable n) (ontable p) (ontable a) (ontable d) (ontable m) (ontable c) (ontable b) (ontable h) (ontable f) (ontable o) (ontable j) (ontable l) (ontable e) (clear k) (clear i) (clear g) (clear n) (clear p) (clear a) (clear d) (clear m) (clear c) (clear b) (clear h) (clear f) (clear o) (clear j) (clear l) (clear e) (handempty) (holding k) (holding i) (holding g) (holding n) (holding p) (holding a) (holding d) (holding m) (holding c) (holding b) (holding h) (holding f) (holding o) (holding j) (holding l) (holding e))
(:goal (and (on k i) (on k g) (on k n) (on k p) (on k a) (on k d) (on k m) (on k c) (on k b) (on k h) (on k f) (on k o) (on k l) (on k e) (on i g) (on i n) (on i p) (on i a) (on i d) (on i m) (on i c) (on i b) (on i h) (on i f) (on i o) (on i j) (on i l) (on i e) (on g k) (on g n) (on g p) (on g a) (on g d) (on g m) (on g c) (on g b) (on g h) (on g f) (on g o) (on g j) (on g l) (on g e) (on n k) (on n i) (on n p) (on n a) (on n d) (on n m) (on n c) (on n b) (on n h) (on n f) (on n o) (on n j) (on n l) (on n e) (on p k) (on p i) (on p g) (on p a) (on p d) (on p m) (on p c) (on p b) (on p h) (on p f) (on p o) (on p j) (on p l) (on p e) (on a k) (on a i) (on a g) (on a n) (on a d) (on a m) (on a c) (on a b) (on a h) (on a f) (on a o) (on a j) (on a l) (on a e) (on d k) (on d i) (on d g) (on d n) (on d p) (on d m) (on d c) (on d b) (on d h) (on d f) (on d o) (on d j) (on d l) (on d e) (on m k) (on m i) (on m g) (on m n) (on m p) (on m a) (on m c) (on m b) (on m h) (on m f) (on m o) (on m j) (on m l) (on m e) (on c k) (on c i) (on c g) (on c n) (on c p) (on c a) (on c d) (on c b) (on c h) (on c f) (on c o) (on c j) (on c l) (on c e) (on b k) (on b i) (on b g) (on b n) (on b p) (on b a) (on b d) (on b m) (on b h) (on b f) (on b o) (on b j) (on b l) (on b e) (on h k) (on h i) (on h g) (on h n) (on h p) (on h a) (on h d) (on h m) (on h c) (on h f) (on h o) (on h j) (on h l) (on h e) (on f k) (on f i) (on f g) (on f n) (on f p) (on f a) (on f d) (on f m) (on f c) (on f b) (on f o) (on f j) (on f l) (on f e) (on o k) (on o i) (on o g) (on o n) (on o p) (on o a) (on o d) (on o m) (on o c) (on o b) (on o h) (on o f) (on o j) (on o l) (on o e) (on j k) (on j i) (on j g) (on j n) (on j p) (on j a) (on j d) (on j m) (on j c) (on j b) (on j h) (on j f) (on j o) (on j l) (on j e) (on l k) (on l i) (on l g) (on l n) (on l p) (on l a) (on l d) (on l m) (on l c) (on l b) (on l h) (on l f) (on l j) (on l e) (on e k) (on e i) (on e g) (on e n) (on e p) (on e a) (on e d) (on e m) (on e c) (on e b) (on e h) (on e o) (on e j) (on e l) (ontable k) (ontable i) (ontable g) (ontable n) (ontable p) (ontable a) (ontable d) (ontable m) (ontable c) (ontable b) (ontable h) (ontable f) (ontable l) (ontable e) (clear k) (clear i) (clear g) (clear n) (clear p) (clear a) (clear d) (clear m) (clear c) (clear b) (clear h) (clear f) (clear o) (clear j) (holding k) (holding i) (holding g) (holding n) (holding p) (holding a) (holding d) (holding m) (holding c) (holding b) (holding h) (holding f) (holding o) (holding j) (holding l) (holding e))))