(define (problem blocks-19-1)
(:domain blocks)
(:objects b r i n j g m p f s c l h k d e o q a - block)
(:init (on b r) (on b i) (on b n) (on b j) (on b g) (on b m) (on b p) (on b f) (on b s) (on b c) (on b l) (on b k) (on b d) (on b e) (on b o) (on b q) (on b a) (on r b) (on r i) (on r n) (on r j) (on r g) (on r m) (on r p) (on r f) (on r s) (on r c) (on r l) (on r h) (on r k) (on r d) (on r e) (on r o) (on r a) (on i b) (on i r) (on i n) (on i g) (on i m) (on i p) (on i f) (on i s) (on i c) (on i l) (on i h) (on i k) (on i d) (on i e) (on i o) (on i q) (on i a) (on n b) (on n r) (on n i) (on n j) (on n g) (on n m) (on n p) (on n f) (on n s) (on n c) (on n l) (on n h) (on n k) (on n d) (on n e) (on n q) (on n a) (on j b) (on j r) (on j i) (on j n) (on j g) (on j m) (on j p) (on j f) (on j s) (on j c) (on j l) (on j h) (on j d) (on j e) (on j o) (on j q) (on j a) (on g b) (on g r) (on g i) (on g n) (on g j) (on g p) (on g f) (on g s) (on g c) (on g l) (on g h) (on g k) (on g d) (on g e) (on g o) (on g q) (on g a) (on m b) (on m r) (on m i) (on m n) (on m j) (on m g) (on m p) (on m f) (on m s) (on m c) (on m l) (on m h) (on m k) (on m d) (on m e) (on m o) (on m q) (on m a) (on p b) (on p r) (on p i) (on p j) (on p g) (on p m) (on p f) (on p s) (on p c) (on p l) (on p h) (on p k) (on p d) (on p e) (on p o) (on p q) (on p a) (on f b) (on f r) (on f i) (on f n) (on f j) (on f m) (on f p) (on f s) (on f c) (on f l) (on f h) (on f k) (on f d) (on f e) (on f o) (on f q) (on f a) (on s b) (on s r) (on s n) (on s j) (on s g) (on s m) (on s p) (on s f) (on s c) (on s l) (on s h) (on s k) (on s d) (on s e) (on s o) (on s q) (on s a) (on c b) (on c r) (on c i) (on c n) (on c j) (on c g) (on c m) (on c p) (on c f) (on c l) (on c h) (on c k) (on c d) (on c e) (on c o) (on c q) (on c a) (on l b) (on l r) (on l i) (on l n) (on l j) (on l g) (on l m) (on l p) (on l f) (on l s) (on l h) (on l k) (on l d) (on l e) (on l o) (on l q) (on l a) (on h b) (on h r) (on h i) (on h n) (on h j) (on h g) (on h m) (on h p) (on h f) (on h s) (on h c) (on h l) (on h k) (on h d) (on h e) (on h o) (on h q) (on k b) (on k r) (on k i) (on k n) (on k j) (on k g) (on k m) (on k p) (on k f) (on k s) (on k c) (on k l) (on k h) (on k d) (on k o) (on k q) (on k a) (on d b) (on d r) (on d i) (on d n) (on d j) (on d g) (on d m) (on d f) (on d s) (on d c) (on d l) (on d h) (on d k) (on d e) (on d o) (on d q) (on d a) (on e r) (on e i) (on e n) (on e j) (on e g) (on e m) (on e p) (on e f) (on e s) (on e c) (on e l) (on e h) (on e k) (on e d) (on e o) (on e q) (on e a) (on o b) (on o i) (on o n) (on o j) (on o g) (on o m) (on o p) (on o f) (on o s) (on o c) (on o l) (on o h) (on o k) (on o d) (on o e) (on o q) (on o a) (on q b) (on q r) (on q i) (on q n) (on q j) (on q g) (on q m) (on q p) (on q s) (on q c) (on q l) (on q h) (on q k) (on q d) (on q e) (on q o) (on q a) (on a b) (on a r) (on a i) (on a n) (on a j) (on a g) (on a m) (on a p) (on a f) (on a s) (on a c) (on a l) (on a h) (on a k) (on a e) (on a o) (on a q) (ontable b) (ontable r) (ontable i) (ontable n) (ontable j) (ontable g) (ontable m) (ontable p) (ontable f) (ontable s) (ontable c) (ontable l) (ontable h) (ontable k) (ontable d) (ontable e) (ontable o) (ontable q) (ontable a) (clear b) (clear r) (clear i) (clear n) (clear j) (clear g) (clear m) (clear p) (clear f) (clear s) (clear c) (clear l) (clear h) (clear k) (clear d) (clear e) (clear o) (clear q) (clear a) (handempty) (holding b) (holding r) (holding i) (holding n) (holding j) (holding g) (holding m) (holding p) (holding f) (holding s) (holding c) (holding l) (holding h) (holding k) (holding d) (holding e) (holding o) (holding q) (holding a))
(:goal (and (on b r) (on b i) (on b n) (on b j) (on b g) (on b m) (on b p) (on b f) (on b s) (on b c) (on b l) (on b h) (on b d) (on b e) (on b o) (on b q) (on b a) (on r b) (on r i) (on r n) (on r j) (on r g) (on r m) (on r p) (on r f) (on r s) (on r c) (on r l) (on r h) (on r k) (on r d) (on r o) (on r q) (on r a) (on i b) (on i n) (on i j) (on i g) (on i m) (on i p) (on i f) (on i s) (on i c) (on i l) (on i h) (on i k) (on i d) (on i e) (on i o) (on i q) (on i a) (on n b) (on n r) (on n j) (on n g) (on n m) (on n p) (on n f) (on n s) (on n c) (on n l) (on n h) (on n k) (on n d) (on n e) (on n o) (on n q) (on n a) (on j b) (on j r) (on j i) (on j g) (on j m) (on j p) (on j f) (on j s) (on j c) (on j l) (on j h) (on j k) (on j d) (on j e) (on j o) (on j q) (on j a) (on g b) (on g r) (on g i) (on g n) (on g m) (on g p) (on g f) (on g s) (on g c) (on g l) (on g h) (on g k) (on g d) (on g e) (on g o) (on g q) (on g a) (on m b) (on m r) (on m i) (on m n) (on m j) (on m p) (on m f) (on m s) (on m c) (on m l) (on m h) (on m k) (on m d) (on m e) (on m o) (on m q) (on m a) (on p b) (on p r) (on p i) (on p n) (on p j) (on p g) (on p f) (on p s) (on p c) (on p l) (on p h) (on p k) (on p d) (on p e) (on p o) (on p q) (on p a) (on f b) (on f r) (on f i) (on f n) (on f j) (on f g) (on f m) (on f s) (on f c) (on f l) (on f h) (on f k) (on f d) (on f e) (on f o) (on f q) (on f a) (on s b) (on s r) (on s i) (on s n) (on s j) (on s g) (on s m) (on s p) (on s c) (on s l) (on s h) (on s k) (on s d) (on s e) (on s o) (on s q) (on s a) (on c b) (on c r) (on c i) (on c n) (on c j) (on c g) (on c m) (on c p) (on c f) (on c l) (on c h) (on c k) (on c d) (on c e) (on c o) (on c q) (on c a) (on l b) (on l r) (on l i) (on l n) (on l j) (on l g) (on l m) (on l p) (on l f) (on l s) (on l h) (on l k) (on l d) (on l e) (on l o) (on l q) (on l a) (on h b) (on h r) (on h i) (on h n) (on h j) (on h g) (on h m) (on h p) (on h f) (on h s) (on h c) (on h k) (on h d) (on h e) (on h o) (on h q) (on h a) (on k b) (on k r) (on k i) (on k n) (on k j) (on k g) (on k m) (on k p) (on k f) (on k s) (on k c) (on k l) (on k h) (on k d) (on k e) (on k o) (on k q) (on k a) (on d b) (on d r) (on d i) (on d n) (on d j) (on d g) (on d m) (on d p) (on d f) (on d s) (on d c) (on d l) (on d h) (on d k) (on d e) (on d o) (on d q) (on d a) (on e b) (on e r) (on e i) (on e n) (on e j) (on e g) (on e m) (on e p) (on e f) (on e s) (on e c) (on e l) (on e h) (on e k) (on e d) (on e o) (on e q) (on e a) (on o r) (on o i) (on o n) (on o j) (on o g) (on o m) (on o p) (on o f) (on o s) (on o c) (on o l) (on o h) (on o k) (on o d) (on o e) (on o q) (on o a) (on q b) (on q r) (on q i) (on q n) (on q j) (on q g) (on q m) (on q p) (on q f) (on q s) (on q c) (on q l) (on q h) (on q k) (on q e) (on q o) (on q a) (on a b) (on a r) (on a i) (on a n) (on a j) (on a g) (on a m) (on a p) (on a f) (on a s) (on a c) (on a l) (on a k) (on a d) (on a e) (on a o) (on a q) (ontable b) (ontable r) (ontable i) (ontable n) (ontable j) (ontable g) (ontable m) (ontable p) (ontable f) (ontable s) (ontable c) (ontable l) (ontable h) (ontable o) (ontable q) (ontable a) (clear b) (clear r) (clear i) (clear n) (clear j) (clear g) (clear m) (clear p) (clear f) (clear s) (clear c) (clear l) (clear h) (clear k) (clear d) (clear e) (holding b) (holding r) (holding i) (holding n) (holding j) (holding g) (holding m) (holding p) (holding f) (holding s) (holding c) (holding l) (holding h) (holding k) (holding d) (holding e) (holding o) (holding q) (holding a))))