(define (problem blocks-20-0)
(:domain blocks)
(:objects r d a f g o i e l j t b q m c k h p n s - block)
(:init (on r a) (on r f) (on r g) (on r o) (on r i) (on r e) (on r l) (on r j) (on r t) (on r b) (on r q) (on r m) (on r c) (on r k) (on r h) (on r p) (on r n) (on r s) (on d r) (on d a) (on d f) (on d o) (on d i) (on d e) (on d l) (on d j) (on d t) (on d b) (on d q) (on d m) (on d c) (on d k) (on d h) (on d p) (on d n) (on d s) (on a r) (on a d) (on a f) (on a g) (on a o) (on a i) (on a e) (on a j) (on a t) (on a b) (on a q) (on a m) (on a c) (on a k) (on a h) (on a p) (on a n) (on a s) (on f r) (on f d) (on f a) (on f g) (on f o) (on f i) (on f e) (on f l) (on f j) (on f t) (on f b) (on f q) (on f c) (on f k) (on f h) (on f p) (on f n) (on f s) (on g r) (on g d) (on g a) (on g f) (on g o) (on g i) (on g e) (on g l) (on g j) (on g t) (on g b) (on g q) (on g m) (on g c) (on g k) (on g p) (on g n) (on g s) (on o r) (on o d) (on o f) (on o g) (on o i) (on o e) (on o l) (on o j) (on o t) (on o b) (on o q) (on o m) (on o c) (on o k) (on o h) (on o p) (on o n) (on o s) (on i r) (on i d) (on i a) (on i f) (on i g) (on i o) (on i e) (on i l) (on i j) (on i t) (on i b) (on i m) (on i c) (on i k) (on i h) (on i p) (on i n) (on i s) (on e r) (on e d) (on e a) (on e f) (on e g) (on e o) (on e i) (on e l) (on e j) (on e t) (on e b) (on e q) (on e m) (on e c) (on e k) (on e h) (on e p) (on e s) (on l r) (on l d) (on l a) (on l f) (on l g) (on l o) (on l i) (on l e) (on l t) (on l b) (on l q) (on l m) (on l c) (on l k) (on l h) (on l p) (on l n) (on l s) (on j r) (on j d) (on j a) (on j g) (on j o) (on j i) (on j e) (on j l) (on j t) (on j b) (on j q) (on j m) (on j c) (on j k) (on j h) (on j p) (on j n) (on j s) (on t r) (on t d) (on t a) (on t f) (on t g) (on t o) (on t i) (on t e) (on t l) (on t j) (on t b) (on t q) (on t m) (on t c) (on t k) (on t h) (on t p) (on t n) (on b r) (on b d) (on b a) (on b f) (on b g) (on b o) (on b i) (on b e) (on b l) (on b j) (on b t) (on b q) (on b m) (on b c) (on b k) (on b h) (on b n) (on b s) (on q r) (on q d) (on q a) (on q f) (on q g) (on q o) (on q i) (on q e) (on q l) (on q j) (on q t) (on q m) (on q c) (on q k) (on q h) (on q p) (on q n) (on q s) (on m r) (on m d) (on m a) (on m f) (on m g) (on m o) (on m e) (on m l) (on m j) (on m t) (on m b) (on m q) (on m c) (on m k) (on m h) (on m p) (on m n) (on m s) (on c r) (on c d) (on c a) (on c f) (on c g) (on c o) (on c i) (on c e) (on c l) (on c j) (on c t) (on c b) (on c q) (on c m) (on c k) (on c h) (on c p) (on c n) (on c s) (on k r) (on k d) (on k a) (on k f) (on k g) (on k o) (on k i) (on k l) (on k j) (on k t) (on k b) (on k q) (on k m) (on k c) (on k h) (on k p) (on k n) (on k s) (on h r) (on h d) (on h a) (on h f) (on h g) (on h i) (on h e) (on h l) (on h j) (on h t) (on h b) (on h q) (on h m) (on h c) (on h k) (on h p) (on h n) (on h s) (on p r) (on p d) (on p a) (on p f) (on p g) (on p o) (on p i) (on p e) (on p l) (on p j) (on p b) (on p q) (on p m) (on p c) (on p k) (on p h) (on p n) (on p s) (on n d) (on n a) (on n f) (on n g) (on n o) (on n i) (on n e) (on n l) (on n j) (on n t) (on n b) (on n q) (on n m) (on n c) (on n k) (on n h) (on n p) (on n s) (on s r) (on s d) (on s a) (on s f) (on s g) (on s o) (on s i) (on s e) (on s l) (on s j) (on s t) (on s b) (on s q) (on s m) (on s k) (on s h) (on s p) (on s n) (ontable r) (ontable d) (ontable a) (ontable f) (ontable g) (ontable o) (ontable i) (ontable e) (ontable l) (ontable j) (ontable t) (ontable b) (ontable q) (ontable m) (ontable c) (ontable k) (ontable h) (ontable p) (ontable n) (ontable s) (clear r) (clear d) (clear a) (clear f) (clear g) (clear o) (clear i) (clear e) (clear l) (clear j) (clear t) (clear b) (clear q) (clear m) (clear c) (clear k) (clear h) (clear p) (clear n) (clear s) (handempty) (holding r) (holding d) (holding a) (holding f) (holding g) (holding o) (holding i) (holding e) (holding l) (holding j) (holding t) (holding b) (holding q) (holding m) (holding c) (holding k) (holding h) (holding p) (holding n) (holding s))
(:goal (and (on r d) (on r a) (on r f) (on r g) (on r o) (on r i) (on r e) (on r l) (on r j) (on r t) (on r b) (on r q) (on r m) (on r c) (on r h) (on r p) (on r n) (on r s) (on d r) (on d a) (on d f) (on d g) (on d o) (on d i) (on d e) (on d l) (on d j) (on d t) (on d b) (on d q) (on d m) (on d c) (on d k) (on d p) (on d n) (on d s) (on a r) (on a f) (on a g) (on a o) (on a i) (on a e) (on a l) (on a j) (on a t) (on a b) (on a q) (on a m) (on a c) (on a k) (on a h) (on a p) (on a n) (on a s) (on f r) (on f d) (on f g) (on f o) (on f i) (on f e) (on f l) (on f j) (on f t) (on f b) (on f q) (on f m) (on f c) (on f k) (on f h) (on f p) (on f n) (on f s) (on g r) (on g d) (on g a) (on g o) (on g i) (on g e) (on g l) (on g j) (on g t) (on g b) (on g q) (on g m) (on g c) (on g k) (on g h) (on g p) (on g n) (on g s) (on o r) (on o d) (on o a) (on o f) (on o i) (on o e) (on o l) (on o j) (on o t) (on o b) (on o q) (on o m) (on o c) (on o k) (on o h) (on o p) (on o n) (on o s) (on i r) (on i d) (on i a) (on i f) (on i g) (on i e) (on i l) (on i j) (on i t) (on i b) (on i q) (on i m) (on i c) (on i k) (on i h) (on i p) (on i n) (on i s) (on e r) (on e d) (on e a) (on e f) (on e g) (on e o) (on e l) (on e j) (on e t) (on e b) (on e q) (on e m) (on e c) (on e k) (on e h) (on e p) (on e n) (on e s) (on l r) (on l d) (on l a) (on l f) (on l g) (on l o) (on l i) (on l j) (on l t) (on l b) (on l q) (on l m) (on l c) (on l k) (on l h) (on l p) (on l n) (on l s) (on j r) (on j d) (on j a) (on j f) (on j g) (on j o) (on j i) (on j e) (on j t) (on j b) (on j q) (on j m) (on j c) (on j k) (on j h) (on j p) (on j n) (on j s) (on t r) (on t d) (on t a) (on t f) (on t g) (on t o) (on t i) (on t e) (on t l) (on t b) (on t q) (on t m) (on t c) (on t k) (on t h) (on t p) (on t n) (on t s) (on b r) (on b d) (on b a) (on b f) (on b g) (on b o) (on b i) (on b e) (on b l) (on b j) (on b q) (on b m) (on b c) (on b k) (on b h) (on b p) (on b n) (on b s) (on q r) (on q d) (on q a) (on q f) (on q g) (on q o) (on q i) (on q e) (on q l) (on q j) (on q t) (on q m) (on q c) (on q k) (on q h) (on q p) (on q n) (on q s) (on m r) (on m d) (on m a) (on m f) (on m g) (on m o) (on m i) (on m e) (on m l) (on m j) (on m t) (on m b) (on m c) (on m k) (on m h) (on m p) (on m n) (on m s) (on c r) (on c d) (on c a) (on c f) (on c g) (on c o) (on c i) (on c e) (on c l) (on c j) (on c t) (on c b) (on c q) (on c k) (on c h) (on c p) (on c n) (on c s) (on k r) (on k d) (on k a) (on k f) (on k g) (on k o) (on k i) (on k e) (on k l) (on k j) (on k t) (on k b) (on k q) (on k m) (on k c) (on k h) (on k p) (on k n) (on k s) (on h r) (on h d) (on h a) (on h f) (on h g) (on h o) (on h i) (on h e) (on h l) (on h j) (on h t) (on h b) (on h q) (on h m) (on h c) (on h k) (on h p) (on h n) (on h s) (on p d) (on p a) (on p f) (on p g) (on p o) (on p i) (on p e) (on p l) (on p j) (on p t) (on p b) (on p q) (on p m) (on p c) (on p k) (on p h) (on p n) (on p s) (on n r) (on n d) (on n a) (on n f) (on n g) (on n o) (on n i) (on n e) (on n l) (on n j) (on n t) (on n b) (on n q) (on n m) (on n c) (on n k) (on n h) (on n p) (on n s) (on s r) (on s d) (on s a) (on s f) (on s g) (on s o) (on s i) (on s e) (on s l) (on s j) (on s t) (on s b) (on s q) (on s m) (on s k) (on s h) (on s p) (on s n) (ontable r) (ontable d) (ontable a) (ontable f) (ontable g) (ontable o) (ontable i) (ontable e) (ontable l) (ontable j) (ontable t) (ontable b) (ontable q) (ontable m) (ontable c) (ontable p) (ontable s) (clear r) (clear d) (clear a) (clear f) (clear g) (clear o) (clear i) (clear e) (clear l) (clear j) (clear t) (clear b) (clear q) (clear m) (clear c) (clear k) (clear h) (holding r) (holding d) (holding a) (holding f) (holding g) (holding o) (holding i) (holding e) (holding l) (holding j) (holding t) (holding b) (holding q) (holding m) (holding c) (holding k) (holding h) (holding p) (holding n) (holding s))))