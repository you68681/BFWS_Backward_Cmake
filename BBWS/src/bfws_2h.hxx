/*
Lightweight Automated Planning Toolkit
Copyright (C) 2013
Miquel Ramirez <miquel.ramirez@rmit.edu.au>
Nir Lipovetzky <nirlipo@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http:www.gnu.org/licenses/>.
*/

#ifndef __SINGLE_QUEUE_DOUBLE_HEURISTIC_GREEDY_BEST_FIRST_SEARCH_FAST_EXP__
#define __SINGLE_QUEUE_DOUBLE_HEURISTIC_GREEDY_BEST_FIRST_SEARCH_FAST_EXP__

#include <aptk/search_prob.hxx>
#include <aptk/resources_control.hxx>
#include <aptk/closed_list.hxx>
#include <landmark_graph_manager.hxx>
#include <vector>
#include <algorithm>
#include <iostream>
#include <aptk/hash_table.hxx>

namespace aptk {

namespace search {

namespace bfws_2h{


template <typename Search_Model, typename State>
class Node {
public:
	typedef aptk::agnostic::Landmarks_Graph_Manager<Search_Model>   Landmarks_Graph_Manager;


	typedef State                            State_Type;
	typedef Node<Search_Model,State>*        Node_Ptr;
	typedef typename std::vector< Node<Search_Model,State>* >                      Node_Vec_Ptr;
	typedef typename std::vector< Node<Search_Model,State>* >::reverse_iterator    Node_Vec_Ptr_Rit;
	typedef typename std::vector< Node<Search_Model,State>* >::iterator            Node_Vec_Ptr_It;

	Node( State* s, float cost, Action_Idx action, Node<Search_Model,State>* parent, int num_actions ) 
		: m_state( s ), m_parent( parent ), m_action(action), m_g( 0 ), m_g_unit(0), m_h1(0), m_h2(0), m_r(0), m_partition(0), m_M(0), m_land_consumed(NULL), m_land_unconsumed(NULL), m_rp_fl_vec(NULL), m_rp_fl_set(NULL), m_relaxed_deadend(false) {
		m_g = ( parent ? parent->m_g + cost : 0.0f);
		m_g_unit = ( parent ? parent->m_g_unit + 1 : 0);
	}
	
	virtual ~Node() {
		if ( m_state != NULL ) delete m_state;
		if ( m_rp_fl_vec != NULL ) delete m_rp_fl_vec;
		if ( m_rp_fl_set != NULL ) delete m_rp_fl_set;
		
	}

	unsigned&		h1n()				{ return m_h1; }
	unsigned		h1n() const 			{ return m_h1; }
	unsigned&		h2n()				{ return m_h2; }
	unsigned		h2n() const 			{ return m_h2; }
	unsigned&		r()				{ return m_r; }
	unsigned		r() const 			{ return m_r; }
	unsigned&		M()				{ return m_M; }
	unsigned		M() const 			{ return m_M; }	
	unsigned&      		partition()    	  { return m_partition; }			
	unsigned       		partition() const { return m_partition; }
          
	float&			gn()				{ return m_g; }			
	float			gn() const 			{ return m_g; }
	unsigned&      		gn_unit()			{ return m_g_unit; }			
	unsigned       		gn_unit() const 		{ return m_g_unit; }

	Node_Ptr		parent()   			{ return m_parent; }
	const Node_Ptr		parent() const 			{ return m_parent; }
	Action_Idx		action() const 			{ return m_action; }
	State*			state()				{ return m_state; }
        void			set_state( State* s )  		{ m_state = s; }
	bool			has_state() const		{ return m_state != NULL; }
	const State&		state() const 			{ return *m_state; }
	Bool_Vec_Ptr*&          land_consumed()                 { return m_land_consumed; }
	Bool_Vec_Ptr*&          land_unconsumed()               { return m_land_unconsumed; }
	Fluent_Vec*&            rp_vec()                        { return m_rp_fl_vec; }
	Fluent_Set*&            rp_set()                        { return m_rp_fl_set; }
	bool&                   relaxed_deadend()               { return m_relaxed_deadend;}
	
	//Used to update novelty table
        bool                  is_better( Node* n ) const{


		return false;
		
		//One could mark as novel a tuple that has a better reward, like ICAPS17
		//it is orthogonal, solves more problems in some domains, less in others.

		//return this->gn() < n->gn();
			      
		
	}

        void                    update_land_graph(Landmarks_Graph_Manager* lgm){
		Node_Vec_Ptr path( gn_unit()+1 );
		Node_Vec_Ptr_Rit rit = path.rbegin();
		Node_Ptr n = this;

		do{
			*rit = n;
			rit++;
			n = n->parent();
		}while( n );
		if(rit != path.rend())
			*rit = NULL;

		
		lgm->reset_graph();
		for( Node_Vec_Ptr_It it = path.begin(); it != path.end(); it++){

			if(*it == NULL) break;
			lgm->update_graph( (*it)->land_consumed(), (*it)->land_unconsumed() );

		}
	}
	
	void                    undo_land_graph( Landmarks_Graph_Manager* lgm ){
		lgm->undo_graph( land_consumed(), land_unconsumed() );				
	}
	
	void			print( std::ostream& os ) const {
		os << "{@ = " << this << ", s = " << m_state << ", parent = " << m_parent << ", g(n) = ";
		os << m_g << ", h1(n) = " << m_h1 << ", h2(n) = " << m_h2 << ", r(n) = " << m_r  << "}";
	}

	bool   	operator==( const Node<Search_Model,State>& o ) const {
		
		if( &(o.state()) != NULL && &(state()) != NULL)
			return (const State&)(o.state()) == (const State&)(state());
		/**
		 * Lazy
		 */
		if  ( m_parent == NULL ) {
			if ( o.m_parent == NULL ) return true;
			return false;
		}
	
		if ( o.m_parent == NULL ) return false;
		
		return (m_action == o.m_action) && ( *(m_parent->m_state) == *(o.m_parent->m_state) );
	}

	size_t      hash() const { return m_state ? m_state->hash() : m_hash; }

	void        update_hash() {
		Hash_Key hasher;
		hasher.add( m_action );
		if ( m_parent != NULL )
			hasher.add( m_parent->state()->fluent_vec() );
		m_hash = (size_t)hasher;
	}

public:

	State*		m_state;
	Node_Ptr	m_parent;
	Action_Idx	m_action;
	float		m_g;
	unsigned       	m_g_unit;
	unsigned	m_h1;
	unsigned	m_h2;
	unsigned	m_r;
        unsigned        m_partition;
	unsigned        m_M;
	
	size_t		m_hash;
	Bool_Vec_Ptr*   m_land_consumed;
	Bool_Vec_Ptr*   m_land_unconsumed;
	Fluent_Vec*     m_rp_fl_vec;
	Fluent_Set*     m_rp_fl_set;

	Fluent_Vec      m_goals_achieved;
	Fluent_Vec      m_goal_candidates;

	bool            m_relaxed_deadend;
};



template <typename Search_Model, typename First_Heuristic, typename Second_Heuristic, typename Relevant_Fluents_Heuristic, typename Open_List_Type >
class BFWS_2H {

public:
	typedef	        typename Search_Model::State_Type		        State;
	typedef  	typename Open_List_Type::Node_Type		        Search_Node;
	typedef 	Closed_List< Search_Node >			        Closed_List_Type;
	typedef         aptk::agnostic::Landmarks_Graph_Manager<Search_Model>   Landmarks_Graph_Manager;


	BFWS_2H( 	const Search_Model& search_problem ) 
	: m_problem( search_problem ), m_exp_count(0), m_gen_count(0), m_dead_end_count(0), m_open_repl_count(0),m_max_depth( infty ), m_max_novelty(1), m_time_budget(infty), m_lgm(NULL), m_max_h2n(no_such_index), m_max_r(no_such_index), m_verbose( true ),  m_use_novelty(true), m_use_novelty_pruning(false), m_use_rp(true), m_use_rp_from_init_only(false) {
		m_first_h = new First_Heuristic( search_problem );
		m_second_h = new Second_Heuristic( search_problem );
		m_relevant_fluents_h = new Relevant_Fluents_Heuristic( search_problem );
	}

	virtual ~BFWS_2H() {
		for ( typename Closed_List_Type::iterator i = m_closed.begin();
			i != m_closed.end(); i++ ) {
			delete i->second;
		}
		while	(!m_open.empty() ) 
		{	
			Search_Node* n = m_open.pop();
			delete n;
		}
		m_closed.clear();

		delete m_first_h;
		delete m_second_h;
		delete m_relevant_fluents_h;

	}

	/**
	 * Set the relevant fluents from node n
	 * computing a relaxed plan, and marking the fluents
	 * added by actions in relaxed plan as relevant
	 */


	void    set_relplan( Search_Node* n, State* s ){

		
      		std::vector<Action_Idx>	po;
      		std::vector<Action_Idx>	rel_plan;
		unsigned h = 0;

		m_relevant_fluents_h->ignore_rp_h_value(true);
		m_relevant_fluents_h->eval( *s, h, po, rel_plan  );

		if( h == std::numeric_limits<unsigned>::max() )
			n->relaxed_deadend() = true;
		

#ifdef DEBUG 		
		for ( unsigned p = 0; p < this->problem().task().num_fluents(); p++ ) {
			if (!m_rp_h->is_relaxed_plan_relevant(p)) continue;
			n->rp_vec()->push_back( p );
			n->rp_set()->set( p );
		}
		
		std::cout << "rel_plan size: "<< rel_plan.size() << " "<<std::flush;
#endif
		/**
		 * Reserve space
		 */
		if( !n->rp_vec() ){
			n->rp_vec() = new Fluent_Vec;
			n->rp_set() = new Fluent_Set( this->problem().task().num_fluents() );
		}
		else{
			n->rp_vec()->clear();
			n->rp_set()->reset();
		
		}
		
		for(std::vector<Action_Idx>::iterator it_a = rel_plan.begin(); 
		    it_a != rel_plan.end(); it_a++ ){
			const Action* a = this->problem().task().actions()[*it_a];

			//Add Conditional Effects
			if( !a->ceff_vec().empty() ){		
				for( unsigned i = 0; i < a->ceff_vec().size(); i++ ){
					Conditional_Effect* ce = a->ceff_vec()[i];
					for ( auto p : ce->add_vec() ) {
						if ( ! n->rp_set()->isset( p ) ){
							n->rp_vec()->push_back( p );
							n->rp_set()->set( p );
#ifdef DEBUG
							std::cout << this->problem().task().fluents()[add[i]]->signature() << std::endl;
#endif
						}
					}
				}
			}

            const Fluent_Vec& pre = a->prec_vec();

#ifdef DEBUG
            std::cout << this->problem().task().actions()[*it_a]->signature() << std::endl;
#endif
            for ( unsigned i = 0; i < pre.size(); i++ )
            {
                if ( ! n->rp_set()->isset( pre[i] ) )
                {
                    n->rp_vec()->push_back( pre[i] );
                    n->rp_set()->set( pre[i] );
#ifdef DEBUG
                    std::cout << this->problem().task().fluents()[add[i]]->signature() << std::endl;
#endif
                }
            }

/*
			const Fluent_Vec& add = a->add_vec();

#ifdef DEBUG
			std::cout << this->problem().task().actions()[*it_a]->signature() << std::endl;
#endif
			for ( unsigned i = 0; i < add.size(); i++ )
			{
				if ( ! n->rp_set()->isset( add[i] ) )
				{
					n->rp_vec()->push_back( add[i] );
					n->rp_set()->set( add[i] );
#ifdef DEBUG
					std::cout << this->problem().task().fluents()[add[i]]->signature() << std::endl;
#endif
				}
			}
*/
		}
	}
	/**
	 * chao edit
	 * @param n
	 * @param s
	 */
    void    set_relplan_edit( Search_Node* n, State* s,Fluent_Vec unachived_goal  ){


//            if (n->h2n()==0){
//        std::cout<<"relax plan find"<<std::endl;
//        s->print(std::cout);
//             }

        bool flag= true;
        std::vector<Action_Idx>	po;
        std::vector<Action_Idx>	rel_plan;
        unsigned h = 0;

        m_relevant_fluents_h->ignore_rp_h_value(true);
        m_relevant_fluents_h->eval( *s, h, po, rel_plan,flag , unachived_goal );

        if( h == std::numeric_limits<unsigned>::max() )
            n->relaxed_deadend() = true;


#ifdef DEBUG
        for ( unsigned p = 0; p < this->problem().task().num_fluents(); p++ ) {
			if (!m_rp_h->is_relaxed_plan_relevant(p)) continue;
			n->rp_vec()->push_back( p );
			n->rp_set()->set( p );
		}

		std::cout << "rel_plan size: "<< rel_plan.size() << " "<<std::flush;
#endif
        /**
         * Reserve space
         */
        if( !n->rp_vec() ){
            n->rp_vec() = new Fluent_Vec;
            n->rp_set() = new Fluent_Set( this->problem().task().num_fluents() );
        }
        else{
            n->rp_vec()->clear();
            n->rp_set()->reset();

        }
//    if (n->h2n()==5){
//        std::cout<<"relax plan find"<<std::endl;
//        s->print(std::cout);
//    }
        for(std::vector<Action_Idx>::iterator it_a = rel_plan.begin();
            it_a != rel_plan.end(); it_a++ ){
            const Action* a = this->problem().task().actions()[*it_a];
//            if (n->h2n()==1){
//                a->print(this->problem().task(),std::cout);
//            }
            //Add Conditional Effects
         if( !a->ceff_vec().empty() ){
                for( unsigned i = 0; i < a->ceff_vec().size(); i++ ){
                    Conditional_Effect* ce = a->ceff_vec()[i];
                    for ( auto p : ce->add_vec() ) {
                        if ( ! n->rp_set()->isset( p ) ){
                            n->rp_vec()->push_back( p );
                            n->rp_set()->set( p );
#ifdef DEBUG
                            std::cout << this->problem().task().fluents()[add[i]]->signature() << std::endl;
#endif
                        }
                    }
                }
            }

            const Fluent_Vec& pre = a->prec_vec();

#ifdef DEBUG
            std::cout << this->problem().task().actions()[*it_a]->signature() << std::endl;
#endif
            for ( unsigned i = 0; i < pre.size(); i++ )
            {
                if ( ! n->rp_set()->isset( pre[i] ) )
                {
                    n->rp_vec()->push_back( pre[i] );
                    n->rp_set()->set( pre[i] );
#ifdef DEBUG
                    std::cout << this->problem().task().fluents()[add[i]]->signature() << std::endl;
#endif
                }
            }

/*
			const Fluent_Vec& add = a->add_vec();

#ifdef DEBUG
			std::cout << this->problem().task().actions()[*it_a]->signature() << std::endl;
#endif
			for ( unsigned i = 0; i < add.size(); i++ )
			{
				if ( ! n->rp_set()->isset( add[i] ) )
				{
					n->rp_vec()->push_back( add[i] );
					n->rp_set()->set( add[i] );
#ifdef DEBUG
					std::cout << this->problem().task().fluents()[add[i]]->signature() << std::endl;
#endif
				}
			}
*/
        }
    }

	virtual void	start( float B = infty) {
		m_max_depth = B;
		m_root = new Search_Node( m_problem.init_state(), 0.0f, no_op, NULL, m_problem.num_actions() );
		//Init Novelty
		m_first_h->init();		

		if(m_use_rp)
		    /**
		     * original
		     */
		  //set_relplan( this->m_root, this->m_root->state() );
		    /** chao edi
		     */
            m_root_edit = new Search_Node(m_problem.goal_state(), 0.0f, no_op, NULL, m_problem.num_actions());
		     
            set_relplan( this->m_root, this->m_root_edit->state() );

		//if using the landmark manager to count goals or landmarks
		if(m_lgm){				
			m_lgm->apply_state( m_root->state()->fluent_vec(), m_root->land_consumed(), m_root->land_unconsumed() );

			eval(m_root);

			if(m_use_rp)
			  eval_relevant_fluents(m_root);	

			if(m_use_novelty)
			    eval_novel( m_root );				
				
			m_root->undo_land_graph( m_lgm );
		}
		else{		
			eval(m_root);

			if(m_use_rp)
			  eval_relevant_fluents(m_root);
			
			if(m_use_novelty)
			    eval_novel( m_root );				

		}

		if( m_root->relaxed_deadend() ){ //rel_plan infty
#ifdef DEBUG
			if ( m_verbose ) {
				std::cout << "h_add is infinite" << std::endl;
			}
#endif
			inc_dead_end();
			return;;
		}
		

		

		#ifdef DEBUG
		if ( m_verbose ) {
			std::cout << "Initial search node: ";
			m_root->print(std::cout);
			std::cout << std::endl;
			m_root->state()->print( std::cout );
			std::cout << std::endl;
		}
		#endif 
		m_open.insert( m_root );

		inc_gen();
	}


	
	virtual void      eval( Search_Node* candidate ) {
        Fluent_Vec unachived_goal;


        if(m_lgm){
			//Update land/goal counter up to parent node
			if(candidate->parent())
				candidate->parent()->update_land_graph( m_lgm );

			//Update counter with current operator
			if (candidate->action() != no_op){
				const bool has_cond_eff = !(m_problem.task().actions()[ candidate->action() ]->ceff_vec().empty());

				//If state hasn't been generated yet, update counter progressing the state of the parent
				if( !candidate->has_state() && has_cond_eff ){

					candidate->parent()->state()->progress_lazy_state(  m_problem.task().actions()[ candidate->action() ] );	

					m_lgm->apply_action( candidate->parent()->state(), candidate->action(), candidate->land_consumed(), candidate->land_unconsumed() );

					candidate->parent()->state()->regress_lazy_state( m_problem.task().actions()[ candidate->action() ] );
		
				}else{
					//update the counter with current state
					m_lgm->apply_action( candidate->state(), candidate->action(), candidate->land_consumed(), candidate->land_unconsumed() );
				}
			}
			else //If it's the root node, just initialize the counter
				m_lgm->apply_state( m_root->state()->fluent_vec(), m_root->land_consumed(), m_root->land_unconsumed() );
		}

		//Count land/goal unachieved
		/** chao edit
		 *
		 */

		if (candidate->state()==NULL){
            static Fluent_Vec added, deleted;
            added.clear(); deleted.clear();
            candidate->parent()->state()->progress_lazy_state(  m_problem.task().actions()[ candidate->action() ] );
            m_second_h->eval( *(candidate->state()), candidate->h2n(), (candidate->parent()->state()->fluent_vec()));
            candidate->parent()->state()->regress_lazy_state(  this->problem().task().actions()[ candidate->action() ], &added, &deleted );
        }
		if (candidate->state()!=NULL)
        m_second_h->eval( *(candidate->state()), candidate->h2n(),candidate->state()->fluent_vec());


//        m_second_h->eval( *(candidate->state()), candidate->h2n());






//		m_second_h->eval( *(candidate->state()), candidate->h2n());
//        if (candidate->h2n()==13 ){
//            std::cout<<"find"<<std::endl;
//        }



//        unachived_goal= m_second_h->eval_goal_count(*(candidate->state()), unachived_goal);

//        if (unachived_goal.empty()){
//            std::cout<<"find"<<std::endl;
//        }

		//If relevant fluents are in use
		if(m_use_rp && !m_use_rp_from_init_only){
			//if land/goal counter has decreased, then update relevant fluents
			if(candidate->parent() && candidate->h2n() < candidate->parent()->h2n() ){
				//If state hasn't been gereated, update the parent state with current op
				if( ! candidate->has_state() ){
					static Fluent_Vec added, deleted;
					added.clear(); deleted.clear();
					candidate->parent()->state()->progress_lazy_state(  this->problem().task().actions()[ candidate->action() ], &added, &deleted  );	
					/**original
					 *
					 */
					//set_relplan( candidate, candidate->parent()->state() );
					/**chao edit
					 *
					 */
					 set_relplan_edit(candidate, candidate->parent()->state(),unachived_goal);
					candidate->parent()->state()->regress_lazy_state(  this->problem().task().actions()[ candidate->action() ], &added, &deleted );					
				}
				else
					set_relplan( candidate, candidate->state() );
				
			}
		}
		
		if(candidate->h2n() < m_max_h2n ){
			m_max_h2n = candidate->h2n();
			m_max_r = 0;
			if ( m_verbose ) {
                static Fluent_Vec added, deleted;
                added.clear(); deleted.clear();
                if (candidate->action()!=-1){
                    problem().task().actions()[candidate->action()]->print(problem().task(),std::cout);
                }
			    if (candidate->parent()!=NULL){
                    candidate->parent()->state()->progress_lazy_state(  this->problem().task().actions()[ candidate->action() ], &added, &deleted  );
                    candidate->parent()->state()->print(std::cout);
                    candidate->parent()->state()->regress_lazy_state(  this->problem().task().actions()[ candidate->action() ], &added, &deleted );
			    }

			    //candidate->parent()->state()->print(std::cout);
//                if (m_max_h2n==0)
//                {
//                    std::cout<<'find'<<std::endl;
//                }
//                m_second_h->eval_edit( *(candidate->state()));
				std::cout << "--[" << m_max_h2n  <<" / " << m_max_r <<"]--" << std::endl;				
			}
		}

	}
	unsigned  rp_fl_achieved( Search_Node* n ){
	       unsigned count = 0;
	       static Fluent_Set counted( this->problem().task().num_fluents() );
	       Search_Node* n_start = n;
	       while( !n_start->rp_vec() ){
		       n_start = n_start->parent();
	       }
	       
	       while( n->action()!= no_op && n != n_start ){

		       const Action* a = this->problem().task().actions()[ n->action() ];

			//Add Conditional Effects
			if( !a->ceff_vec().empty() ){		
				for( unsigned i = 0; i < a->ceff_vec().size(); i++ ){
					Conditional_Effect* ce = a->ceff_vec()[i];
					for ( auto p : ce->add_vec() ) {
						if( n_start->rp_set()->isset( p ) && ! counted.isset(p) ){
							count++;
							counted.set( p );	
						}
					}
				}
			}


			  const  Fluent_Vec & pre=a->prec_vec();
			for (unsigned i=0; i<pre.size();i++){
			    const unsigned  p=pre[i];
			    if (n_start->rp_set()->isset(p) && !counted.isset(p))
                {
//			        if(n->h2n()==9){
//                        std::cout<<"====prec==="<<std::endl;
//			        }
			        count++;
			        counted.set(p);
//                    if(n->h2n()==9){
//                        std::cout<< count<<problem().task().fluents()[p]->signature()<<std::endl;
//                    }
                }
			}

/*
               const Fluent_Vec& add = a->add_vec();
		       
		       //std::cout << this->problem().task().actions()[*it_a]->signature() << std::endl;
		       for ( unsigned i = 0; i < add.size(); i++ ){
			       const unsigned p = add[i];
			       if( n_start->rp_set()->isset( p ) && ! counted.isset(p) ){
				       count++;
				       counted.set( p );
			       }
		       }
*/
		       n = n->parent();
	       }
	       counted.reset();
	       return count;	       
		       
       }

       /** chao test
        *
        * @param candidate
        */
       unsigned  rp_fl_achieved_eidt( Search_Node* n ){
           unsigned count = 0;
           static Fluent_Set counted( this->problem().task().num_fluents() );
           Search_Node* n_start = n;
           while( !n_start->rp_vec() ){
               n_start = n_start->parent();
           }

           while( n->action()!= no_op && n != n_start ){

               const Action* a = this->problem().task().actions()[ n->action() ];

               //Add Conditional Effects
               if( !a->ceff_vec().empty() ){
                   for( unsigned i = 0; i < a->ceff_vec().size(); i++ ){
                       Conditional_Effect* ce = a->ceff_vec()[i];
                       for ( auto p : ce->add_vec() ) {
                           if( n_start->rp_set()->isset( p ) && ! counted.isset(p) ){
                               count++;
                               counted.set( p );
                           }
                       }
                   }
               }


               const  Fluent_Vec & pre=a->prec_vec();
               for (unsigned i=0; i<pre.size();i++){
                   const unsigned  p=pre[i];
                   if (n_start->rp_set()->isset(p) && !counted.isset(p))
                   {
                       std::cout<<"====prec==="<<std::endl;
                       count++;
                       counted.set(p);
                       std::cout<< count<<problem().task().fluents()[p]->signature()<<std::endl;
                   }
               }

/*
               const Fluent_Vec& add = a->add_vec();

		       //std::cout << this->problem().task().actions()[*it_a]->signature() << std::endl;
		       for ( unsigned i = 0; i < add.size(); i++ ){
			       const unsigned p = add[i];
			       if( n_start->rp_set()->isset( p ) && ! counted.isset(p) ){
				       count++;
				       counted.set( p );
			       }
		       }
*/
               n = n->parent();
           }
           counted.reset();
           return count;

       }
	void			eval_relevant_fluents( Search_Node* candidate ) {
		candidate->r() = rp_fl_achieved( candidate );
		
		if(candidate->r() > m_max_r ){
		    //rp_fl_achieved_eidt(candidate);
//            static Fluent_Vec added, deleted;
//            added.clear(); deleted.clear();
//            if (candidate->parent()!=NULL){
//                candidate->parent()->state()->progress_lazy_state(  this->problem().task().actions()[ candidate->action() ], &added, &deleted  );
//                candidate->parent()->state()->print(std::cout);
//                candidate->parent()->state()->regress_lazy_state(  this->problem().task().actions()[ candidate->action() ], &added, &deleted );
//            }

			m_max_r = candidate->r();

			if ( m_verbose ) 
				std::cout << "--[" << m_max_h2n  <<" / " << m_max_r <<"]--" << std::endl;			
			
		}

	}

	
	void			eval_novel( Search_Node* candidate ) {
		candidate->partition() = (1000 * candidate->h2n() )+ candidate->r(); 
		m_first_h->eval( candidate, candidate->h1n()  );

	}

       
	bool 		is_closed( Search_Node* n ) 	{ 
		Search_Node* n2 = this->closed().retrieve(n);

		if ( n2 != NULL ) {
			if ( n2->gn() <= n->gn() ) {
				// The node we generated is a worse path than
				// the one we already found
				return true;
			}
			// Otherwise, we put it into Open and remove
			// n2 from closed
			this->closed().erase( this->closed().retrieve_iterator( n2 ) );
		}
		return false;
	}

	Search_Node* 		get_node() {
		Search_Node *next = NULL;
		if(! m_open.empty() ) {
			next = m_open.pop();
		}
		return next;
	}


	void	 	open_node( Search_Node *n ) {
		m_open.insert(n);
		inc_gen();
	}
	/** chao add
	 *
	 * @param node
	 */
	void                    set_negation(Search_Node *node){
	    m_in_negation.clear();
	    m_in_negation.resize(problem().task().num_fluents(), false);
        while (node->parent()){
            for (unsigned p: problem().task().negation()){
                if (node->state()->entails(p)){
                    m_in_negation[ p ] = TRUE;
                }

            }
            node=node->parent();

        }
    }
	
	virtual void 			process(  Search_Node *head ) {

		
#ifdef DEBUG
		if ( m_verbose ) {
			std::cout << "Expanding:" << std::endl;
			head->print(std::cout);
			std::cout << std::endl;
			head->state()->print( std::cout );
			std::cout << std::endl;
		}
#endif

		if(m_lgm)
			head->update_land_graph( m_lgm );
        //get negation from parent state.
//		set_negation(head);
         //get all negation
        //m_in_negation=this->problem().task().get_negation();
		std::vector< aptk::Action_Idx > app_set;
//		this->problem().applicable_set_v2( *(head->state()), app_set );
//        if (head->h2n()==3){
//            std::cout<<"find"<<std::endl;
//        }
//        if (head->h2n()==13){
//            std::cout<<"find"<<std::endl;
//        }
        for (unsigned i = 0; i < this->problem().num_actions(); ++i ) {
            /**original version
             *
             */
            if (this->problem().is_applicable( *(head->state()), i )){
              /** chao edit
               *
               */
             // ignore the negation impact
            //if (this->problem().is_applicable_edit( *(head->state()), i,m_in_negation )){
                app_set.push_back(i);
            }
        }

		for (unsigned i = 0; i < app_set.size(); ++i ) {
			int a = app_set[i];

			//Lazy state generation
			State *succ = nullptr;



            //std::cout<<result<<std::endl;
//            head->state()->print(std::cout);
            //	std::cout<<"VVVVVVVV"<<std::endl;
//            this->problem().task().actions()[ a ]->print(this->problem().task(),std::cout);
//            succ->print(std::cout);



           bool is_mutex = false;
           const Action* a_ptr=this->problem().task().actions()[a];
           for (auto p: head->state()->fluent_vec()){
               for (auto new_p: a_ptr->prec_vec()){
                   if (a_ptr->add_set().isset(p)) continue;
                   /** chao edit
                    *
                    */
                    //ignore the negation in mutex check
                   //if (m_in_negation[new_p] or m_in_negation[p]) continue;
                   if (this->problem().h2_fwd().is_mutex(p,new_p)){
                       is_mutex= true;
                       break;
                   }
               }
               if (is_mutex) break;

           }

           Search_Node* n= nullptr;
           if (is_mutex){
               continue;
           } else{
               n = new Search_Node( succ, m_problem.cost( *(head->state()), a ), a, head, m_problem.num_actions()  );
           }


			#ifdef DEBUG
			if ( m_verbose ) {
				std::cout << "Successor:" << std::endl;
				n->print(std::cout);
				std::cout << std::endl;
				if(n->has_state())
				n->state()->print( std::cout );
				std::cout << std::endl;
			}
			#endif

			eval( n );
			if( n->relaxed_deadend() ){ //rel_plan infty
#ifdef DEBUG
				if ( m_verbose ) {
					std::cout << "h_add is infinite" << std::endl;
				}
#endif
				inc_dead_end();					
				delete n;
				continue;
			}

			if(m_use_rp)
			  eval_relevant_fluents(n);
			
			if(m_use_novelty){
			    eval_novel(n);
			    if(m_use_novelty_pruning)
				    if( n->h1n() > m_max_novelty ){
#ifdef DEBUG
					    if ( m_verbose ) {
						    std::cout << "h_add is infinite" << std::endl;
					    }
#endif
					    inc_dead_end();					
					    delete n;
					    continue;
				    }
			    
			}
						       
#ifdef DEBUG
			if ( m_verbose )
				std::cout << "Inserted into OPEN" << std::endl;
#endif
			open_node(n);	
				

		} 
		inc_eval();
	}

	virtual Search_Node*	 	do_search() {
		Search_Node *head = get_node();

		while(head) {
			if ( head->gn() >= max_depth() )  {
				close(head);
				head = get_node();
				continue;
			}

			//Generate state
			if( ! head->has_state() )
			  head->set_state( m_problem.next(*(head->parent()->state()), head->action()) );

			if(m_problem.goal(*(head->state()))) {
				close(head);
				set_max_depth( head->gn() );	
				return head;
			}
			if ( (time_used() - m_t0 ) > m_time_budget )
				return NULL;			

			if ( is_closed( head ) ) {
				#ifdef DEBUG
				if ( m_verbose )
					std::cout << "Already in CLOSED" << std::endl;
				#endif
				delete head;
				head = get_node();
				continue;
			}
			process(head);
			close(head);
			head = get_node();
		}
		return NULL;
	}

        void	set_arity( float v, unsigned g ){ m_first_h->set_arity( v, g ); }
	void    set_max_novelty( unsigned v )   { m_max_novelty = v; }


	bool	find_solution( float& cost, std::vector<Action_Idx>& plan ) {
		m_t0 = time_used();
		Search_Node* end = do_search();
		if ( end == NULL ) return false;
		extract_plan( m_root, end, plan, cost );	
		
		return true;
	}

	float			max_depth() const			{ return m_max_depth; }
	void			set_max_depth( float v ) 		{ m_max_depth = v; }
      	void			set_use_rp( bool v )     	 { m_use_rp = v; }
      	void			set_use_rp_from_init_only( bool v ) { m_use_rp_from_init_only = v; }
    	void			set_use_novelty( bool v ) 	 { m_use_novelty = v; }
	void			set_use_novelty_pruning( bool v ){ m_use_novelty_pruning = v; }

	void			inc_gen()			{ m_gen_count++; }
	unsigned		generated() const		{ return m_gen_count; }
	void			inc_eval()			{ m_exp_count++; }
	unsigned		expanded() const		{ return m_exp_count; }
	void			inc_dead_end()			{ m_dead_end_count++; }
	unsigned		dead_ends() const		{ return m_dead_end_count; }
	void			inc_replaced_open()		{ m_open_repl_count++; }
	unsigned		open_repl() const		{ return m_open_repl_count; }

	void			set_budget( float v ) 		{ m_time_budget = v; }
	float			time_budget() const		{ return m_time_budget; }

	float			t0() const			{ return m_t0; }

	void 			close( Search_Node* n ) 	{  m_closed.put(n); }
	Closed_List_Type&	closed() 			{ return m_closed; }

	const	Search_Model&	problem() const			{ return m_problem; }

	First_Heuristic&	h1()				{ return *m_first_h; }
	Second_Heuristic&	h2()				{ return *m_second_h; }
    	Relevant_Fluents_Heuristic&	rel_fl_h()	        { return *m_relevant_fluents_h; }
	
	void			set_verbose( bool v ) 		{ m_verbose = v; }

	void                    use_land_graph_manager( Landmarks_Graph_Manager* lgm ) { 
		m_lgm = lgm; 
		m_second_h->set_graph( m_lgm->graph() );
	}

protected:

	virtual void	extract_plan( Search_Node* s, Search_Node* t, std::vector<Action_Idx>& plan, float& cost ) {
		Search_Node *tmp = t;
		cost = 0.0f;
		while( tmp != s) {
			cost += m_problem.cost( *(tmp->state()), tmp->action() );
			plan.push_back(tmp->action());
			tmp = tmp->parent();
		}
		
		std::reverse(plan.begin(), plan.end());		
	}

	void	extract_path( Search_Node* s, Search_Node* t, std::vector<Search_Node*>& plan ) {
		Search_Node* tmp = t;
		while( tmp != s) {
			plan.push_back(tmp);
			tmp = tmp->parent();
		}
		
		std::reverse(plan.begin(), plan.end());				
	}
	
protected:

	const Search_Model&			m_problem;
	First_Heuristic*			m_first_h;
	Second_Heuristic*			m_second_h;
    	Relevant_Fluents_Heuristic*    		m_relevant_fluents_h;
	
	Open_List_Type				m_open;
	Closed_List_Type			m_closed;
	
	unsigned				m_exp_count;
	unsigned				m_gen_count;
	unsigned				m_dead_end_count;
	unsigned				m_open_repl_count;
	
	float					m_max_depth;
	unsigned                                m_max_novelty;
	float					m_time_budget;
	float					m_t0;

	Search_Node*				m_root;
    Search_Node*				m_root_edit;
	std::vector<Action_Idx> 		m_app_set;
	Landmarks_Graph_Manager*                m_lgm;

	unsigned                                m_max_h2n;
	unsigned                                m_max_r;
	bool					m_verbose;

	bool                                    m_use_novelty;
	bool                                    m_use_novelty_pruning;
        bool                                    m_use_rp;
	bool                                    m_use_rp_from_init_only;
    std::vector<bool>	 						m_in_negation;

};

}

}

}

#endif // bfws_2h.hxx
