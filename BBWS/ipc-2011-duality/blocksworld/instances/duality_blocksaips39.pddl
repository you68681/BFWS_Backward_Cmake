(define (problem blocks-19-0)
(:domain blocks)
(:objects f e o h d c q m p i r a g k j b s l n - block)
(:init (on f e) (on f o) (on f h) (on f d) (on f c) (on f q) (on f m) (on f p) (on f i) (on f r) (on f a) (on f g) (on f k) (on f j) (on f b) (on f l) (on f n) (on e f) (on e o) (on e h) (on e d) (on e q) (on e m) (on e p) (on e i) (on e r) (on e a) (on e g) (on e k) (on e j) (on e b) (on e s) (on e l) (on e n) (on o f) (on o h) (on o d) (on o c) (on o q) (on o m) (on o p) (on o i) (on o r) (on o a) (on o g) (on o k) (on o j) (on o b) (on o s) (on o l) (on o n) (on h f) (on h e) (on h o) (on h d) (on h c) (on h m) (on h p) (on h i) (on h r) (on h a) (on h g) (on h k) (on h j) (on h b) (on h s) (on h l) (on h n) (on d f) (on d e) (on d o) (on d h) (on d c) (on d q) (on d m) (on d p) (on d i) (on d r) (on d a) (on d g) (on d k) (on d b) (on d s) (on d l) (on d n) (on c f) (on c e) (on c o) (on c h) (on c d) (on c q) (on c m) (on c p) (on c i) (on c r) (on c a) (on c g) (on c j) (on c b) (on c s) (on c l) (on c n) (on q f) (on q e) (on q o) (on q h) (on q d) (on q c) (on q m) (on q i) (on q r) (on q a) (on q g) (on q k) (on q j) (on q b) (on q s) (on q l) (on q n) (on m f) (on m e) (on m h) (on m d) (on m c) (on m q) (on m p) (on m i) (on m r) (on m a) (on m g) (on m k) (on m j) (on m b) (on m s) (on m l) (on m n) (on p f) (on p e) (on p o) (on p h) (on p d) (on p c) (on p q) (on p m) (on p i) (on p r) (on p g) (on p k) (on p j) (on p b) (on p s) (on p l) (on p n) (on i f) (on i e) (on i o) (on i h) (on i c) (on i q) (on i m) (on i p) (on i r) (on i a) (on i g) (on i k) (on i j) (on i b) (on i s) (on i l) (on i n) (on r f) (on r e) (on r o) (on r h) (on r d) (on r c) (on r q) (on r m) (on r p) (on r a) (on r g) (on r k) (on r j) (on r b) (on r s) (on r l) (on r n) (on a f) (on a e) (on a o) (on a h) (on a d) (on a c) (on a q) (on a m) (on a p) (on a i) (on a r) (on a g) (on a k) (on a j) (on a b) (on a s) (on a n) (on g f) (on g e) (on g o) (on g h) (on g d) (on g c) (on g q) (on g m) (on g p) (on g i) (on g r) (on g a) (on g k) (on g j) (on g b) (on g s) (on g l) (on g n) (on k f) (on k e) (on k o) (on k h) (on k d) (on k c) (on k q) (on k m) (on k p) (on k i) (on k r) (on k a) (on k j) (on k b) (on k s) (on k l) (on k n) (on j f) (on j e) (on j o) (on j h) (on j d) (on j c) (on j q) (on j m) (on j p) (on j i) (on j r) (on j a) (on j g) (on j k) (on j s) (on j l) (on j n) (on b f) (on b e) (on b o) (on b h) (on b d) (on b c) (on b q) (on b m) (on b p) (on b i) (on b r) (on b a) (on b g) (on b k) (on b j) (on b s) (on b l) (on s f) (on s e) (on s o) (on s h) (on s d) (on s c) (on s q) (on s p) (on s i) (on s r) (on s a) (on s g) (on s k) (on s j) (on s b) (on s l) (on s n) (on l f) (on l e) (on l o) (on l h) (on l d) (on l c) (on l q) (on l m) (on l p) (on l i) (on l a) (on l g) (on l k) (on l j) (on l b) (on l s) (on l n) (on n e) (on n o) (on n h) (on n d) (on n c) (on n q) (on n m) (on n p) (on n i) (on n r) (on n a) (on n g) (on n k) (on n j) (on n b) (on n s) (on n l) (ontable f) (ontable e) (ontable o) (ontable h) (ontable d) (ontable c) (ontable q) (ontable m) (ontable p) (ontable i) (ontable r) (ontable a) (ontable g) (ontable k) (ontable j) (ontable b) (ontable s) (ontable l) (ontable n) (clear f) (clear e) (clear o) (clear h) (clear d) (clear c) (clear q) (clear m) (clear p) (clear i) (clear r) (clear a) (clear g) (clear k) (clear j) (clear b) (clear s) (clear l) (clear n) (handempty) (holding f) (holding e) (holding o) (holding h) (holding d) (holding c) (holding q) (holding m) (holding p) (holding i) (holding r) (holding a) (holding g) (holding k) (holding j) (holding b) (holding s) (holding l) (holding n))
(:goal (and (on f e) (on f o) (on f h) (on f d) (on f c) (on f q) (on f m) (on f p) (on f i) (on f r) (on f a) (on f g) (on f k) (on f j) (on f s) (on f l) (on f n) (on e o) (on e h) (on e d) (on e c) (on e q) (on e m) (on e p) (on e i) (on e r) (on e a) (on e g) (on e k) (on e j) (on e b) (on e s) (on e l) (on e n) (on o f) (on o h) (on o d) (on o c) (on o q) (on o m) (on o p) (on o i) (on o r) (on o a) (on o g) (on o k) (on o j) (on o b) (on o s) (on o l) (on o n) (on h f) (on h e) (on h d) (on h c) (on h q) (on h m) (on h p) (on h i) (on h r) (on h a) (on h g) (on h k) (on h j) (on h b) (on h s) (on h l) (on h n) (on d f) (on d e) (on d o) (on d c) (on d q) (on d m) (on d p) (on d i) (on d r) (on d a) (on d g) (on d k) (on d j) (on d b) (on d s) (on d l) (on d n) (on c f) (on c e) (on c o) (on c h) (on c q) (on c m) (on c p) (on c i) (on c r) (on c a) (on c g) (on c k) (on c j) (on c b) (on c s) (on c l) (on c n) (on q f) (on q e) (on q o) (on q h) (on q d) (on q m) (on q p) (on q i) (on q r) (on q a) (on q g) (on q k) (on q j) (on q b) (on q s) (on q l) (on q n) (on m f) (on m e) (on m o) (on m h) (on m d) (on m c) (on m p) (on m i) (on m r) (on m a) (on m g) (on m k) (on m j) (on m b) (on m s) (on m l) (on m n) (on p f) (on p e) (on p o) (on p h) (on p d) (on p c) (on p q) (on p i) (on p r) (on p a) (on p g) (on p k) (on p j) (on p b) (on p s) (on p l) (on p n) (on i f) (on i e) (on i o) (on i h) (on i d) (on i c) (on i q) (on i m) (on i r) (on i a) (on i g) (on i k) (on i j) (on i b) (on i s) (on i l) (on i n) (on r f) (on r e) (on r o) (on r h) (on r d) (on r c) (on r q) (on r m) (on r p) (on r a) (on r g) (on r k) (on r j) (on r b) (on r s) (on r l) (on r n) (on a f) (on a e) (on a o) (on a h) (on a d) (on a c) (on a q) (on a m) (on a p) (on a i) (on a g) (on a k) (on a j) (on a b) (on a s) (on a l) (on a n) (on g f) (on g e) (on g o) (on g h) (on g d) (on g c) (on g q) (on g m) (on g p) (on g i) (on g r) (on g k) (on g j) (on g b) (on g s) (on g l) (on g n) (on k f) (on k e) (on k o) (on k h) (on k d) (on k c) (on k q) (on k m) (on k p) (on k i) (on k r) (on k a) (on k j) (on k b) (on k s) (on k l) (on k n) (on j f) (on j e) (on j o) (on j h) (on j d) (on j c) (on j q) (on j m) (on j p) (on j i) (on j r) (on j a) (on j g) (on j b) (on j s) (on j l) (on j n) (on b f) (on b e) (on b o) (on b h) (on b d) (on b c) (on b q) (on b m) (on b p) (on b i) (on b r) (on b a) (on b g) (on b k) (on b j) (on b s) (on b l) (on b n) (on s f) (on s e) (on s o) (on s h) (on s d) (on s c) (on s q) (on s m) (on s p) (on s i) (on s r) (on s a) (on s g) (on s k) (on s j) (on s b) (on s l) (on s n) (on l f) (on l e) (on l o) (on l h) (on l d) (on l c) (on l q) (on l m) (on l p) (on l i) (on l r) (on l a) (on l g) (on l k) (on l j) (on l b) (on l s) (on l n) (on n f) (on n e) (on n o) (on n h) (on n d) (on n c) (on n q) (on n m) (on n p) (on n i) (on n r) (on n a) (on n g) (on n k) (on n b) (on n s) (on n l) (ontable f) (ontable e) (ontable o) (ontable h) (ontable d) (ontable c) (ontable q) (ontable m) (ontable p) (ontable i) (ontable r) (ontable a) (ontable g) (ontable k) (ontable j) (ontable n) (clear f) (clear e) (clear o) (clear h) (clear d) (clear c) (clear q) (clear m) (clear p) (clear i) (clear r) (clear a) (clear g) (clear k) (clear j) (clear b) (holding f) (holding e) (holding o) (holding h) (holding d) (holding c) (holding q) (holding m) (holding p) (holding i) (holding r) (holding a) (holding g) (holding k) (holding j) (holding b) (holding s) (holding l) (holding n))))