(define (problem blocks-17-0)
(:domain blocks)
(:objects c d e f b i j a n o k m p h g l q - block)
(:init (on c d) (on c f) (on c b) (on c i) (on c j) (on c a) (on c n) (on c o) (on c k) (on c m) (on c p) (on c h) (on c g) (on c l) (on c q) (on d c) (on d e) (on d f) (on d b) (on d i) (on d j) (on d a) (on d n) (on d o) (on d k) (on d m) (on d p) (on d h) (on d g) (on d l) (on d q) (on e c) (on e d) (on e f) (on e b) (on e i) (on e j) (on e a) (on e n) (on e o) (on e k) (on e p) (on e h) (on e g) (on e l) (on e q) (on f c) (on f e) (on f b) (on f i) (on f j) (on f a) (on f n) (on f o) (on f k) (on f m) (on f p) (on f h) (on f g) (on f l) (on f q) (on b c) (on b d) (on b e) (on b f) (on b j) (on b a) (on b n) (on b o) (on b k) (on b m) (on b p) (on b h) (on b g) (on b l) (on b q) (on i c) (on i d) (on i e) (on i f) (on i b) (on i j) (on i a) (on i n) (on i o) (on i m) (on i p) (on i h) (on i g) (on i l) (on i q) (on j c) (on j d) (on j e) (on j f) (on j b) (on j i) (on j a) (on j n) (on j o) (on j k) (on j m) (on j p) (on j g) (on j l) (on j q) (on a c) (on a d) (on a e) (on a f) (on a b) (on a i) (on a j) (on a n) (on a o) (on a k) (on a m) (on a p) (on a h) (on a l) (on a q) (on n c) (on n d) (on n e) (on n f) (on n b) (on n i) (on n j) (on n a) (on n o) (on n k) (on n m) (on n p) (on n h) (on n g) (on n q) (on o c) (on o d) (on o e) (on o f) (on o b) (on o i) (on o a) (on o n) (on o k) (on o m) (on o p) (on o h) (on o g) (on o l) (on o q) (on k c) (on k d) (on k e) (on k b) (on k i) (on k j) (on k a) (on k n) (on k o) (on k m) (on k p) (on k h) (on k g) (on k l) (on k q) (on m c) (on m d) (on m e) (on m f) (on m b) (on m i) (on m j) (on m a) (on m n) (on m o) (on m k) (on m h) (on m g) (on m l) (on m q) (on p c) (on p d) (on p e) (on p f) (on p b) (on p i) (on p j) (on p n) (on p o) (on p k) (on p m) (on p h) (on p g) (on p l) (on p q) (on h d) (on h e) (on h f) (on h b) (on h i) (on h j) (on h a) (on h n) (on h o) (on h k) (on h m) (on h p) (on h g) (on h l) (on h q) (on g c) (on g d) (on g e) (on g f) (on g i) (on g j) (on g a) (on g n) (on g o) (on g k) (on g m) (on g p) (on g h) (on g l) (on g q) (on l c) (on l d) (on l e) (on l f) (on l b) (on l i) (on l j) (on l a) (on l n) (on l k) (on l m) (on l p) (on l h) (on l g) (on l q) (on q c) (on q d) (on q e) (on q f) (on q b) (on q i) (on q j) (on q a) (on q o) (on q k) (on q m) (on q p) (on q h) (on q g) (on q l) (ontable c) (ontable d) (ontable e) (ontable f) (ontable b) (ontable i) (ontable j) (ontable a) (ontable n) (ontable o) (ontable k) (ontable m) (ontable p) (ontable h) (ontable g) (ontable l) (ontable q) (clear c) (clear d) (clear e) (clear f) (clear b) (clear i) (clear j) (clear a) (clear n) (clear o) (clear k) (clear m) (clear p) (clear h) (clear g) (clear l) (clear q) (handempty) (holding c) (holding d) (holding e) (holding f) (holding b) (holding i) (holding j) (holding a) (holding n) (holding o) (holding k) (holding m) (holding p) (holding h) (holding g) (holding l) (holding q))
(:goal (and (on c d) (on c e) (on c f) (on c b) (on c i) (on c j) (on c a) (on c n) (on c k) (on c m) (on c p) (on c h) (on c g) (on c l) (on c q) (on d e) (on d f) (on d b) (on d i) (on d j) (on d a) (on d n) (on d o) (on d k) (on d m) (on d p) (on d h) (on d g) (on d l) (on d q) (on e c) (on e d) (on e f) (on e b) (on e i) (on e j) (on e a) (on e n) (on e o) (on e m) (on e p) (on e h) (on e g) (on e l) (on e q) (on f c) (on f d) (on f b) (on f i) (on f j) (on f a) (on f n) (on f o) (on f k) (on f m) (on f p) (on f h) (on f g) (on f l) (on f q) (on b c) (on b d) (on b e) (on b f) (on b i) (on b j) (on b a) (on b n) (on b o) (on b k) (on b p) (on b h) (on b g) (on b l) (on b q) (on i c) (on i d) (on i e) (on i f) (on i j) (on i a) (on i n) (on i o) (on i k) (on i m) (on i p) (on i h) (on i g) (on i l) (on i q) (on j c) (on j d) (on j e) (on j f) (on j b) (on j a) (on j n) (on j o) (on j k) (on j m) (on j p) (on j h) (on j g) (on j l) (on j q) (on a c) (on a d) (on a e) (on a f) (on a b) (on a i) (on a n) (on a o) (on a k) (on a m) (on a p) (on a h) (on a g) (on a l) (on a q) (on n c) (on n d) (on n e) (on n f) (on n b) (on n i) (on n j) (on n a) (on n o) (on n k) (on n m) (on n p) (on n h) (on n g) (on n l) (on n q) (on o c) (on o d) (on o e) (on o f) (on o b) (on o i) (on o j) (on o a) (on o n) (on o k) (on o m) (on o p) (on o h) (on o g) (on o l) (on o q) (on k c) (on k d) (on k e) (on k f) (on k b) (on k i) (on k j) (on k a) (on k n) (on k o) (on k m) (on k p) (on k h) (on k g) (on k l) (on k q) (on m c) (on m d) (on m e) (on m f) (on m b) (on m i) (on m j) (on m a) (on m n) (on m o) (on m k) (on m p) (on m h) (on m g) (on m l) (on m q) (on p c) (on p d) (on p e) (on p f) (on p b) (on p i) (on p j) (on p a) (on p n) (on p o) (on p k) (on p m) (on p h) (on p g) (on p l) (on p q) (on h c) (on h d) (on h e) (on h f) (on h b) (on h i) (on h j) (on h a) (on h o) (on h k) (on h m) (on h p) (on h g) (on h l) (on h q) (on g c) (on g e) (on g f) (on g b) (on g i) (on g j) (on g a) (on g n) (on g o) (on g k) (on g m) (on g p) (on g h) (on g l) (on g q) (on l c) (on l d) (on l e) (on l b) (on l i) (on l j) (on l a) (on l n) (on l o) (on l k) (on l m) (on l p) (on l h) (on l g) (on l q) (on q c) (on q d) (on q e) (on q f) (on q b) (on q i) (on q j) (on q n) (on q o) (on q k) (on q m) (on q p) (on q h) (on q g) (on q l) (ontable c) (ontable d) (ontable e) (ontable f) (ontable b) (ontable i) (ontable j) (ontable a) (ontable h) (ontable g) (ontable l) (ontable q) (clear c) (clear d) (clear e) (clear f) (clear b) (clear i) (clear j) (clear a) (clear n) (clear o) (clear k) (clear m) (holding c) (holding d) (holding e) (holding f) (holding b) (holding i) (holding j) (holding a) (holding n) (holding o) (holding k) (holding m) (holding p) (holding h) (holding g) (holding l) (holding q))))