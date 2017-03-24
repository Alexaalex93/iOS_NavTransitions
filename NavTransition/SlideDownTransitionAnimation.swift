//
//  SlideDownTransitionAnimation.swift
//  NavTransition
//
//  Created by cice on 24/3/17.
//  Copyright © 2017 355 Berry Street. All rights reserved.
//

import UIKit

class SlideDownTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {

    //Estos metodos animan lo que le decimos. Le decimos cual es el principal(Deesde cual, presented, el que quieres animar presenting
    
    let duration = 2.0
    var isPresenting = false
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let container = transitionContext.containerView
        
        //Definimos la animacion
        let offScreenUp = CGAffineTransform(translationX: 0, y: -container.frame.height)
        
        let offScreenDown = CGAffineTransform(translationX: 0, y: container.frame.height)
        
        //Comprobar si se ha mostrado 
        
        if isPresenting {
            toView.transform = offScreenUp
        }
        
        //Sacamos la vista
        //toView.transform = offScreenUp
        
        //Añadimos ambas vistas al container
        container.addSubview(fromView)
        container.addSubview(toView)
        
        //Creamos la animacion 
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            
            fromView.alpha = 0.5
            toView.transform = CGAffineTransform.identity
            toView.alpha = 1.0
            
            
            if self.isPresenting {
            
                fromView.transform = offScreenDown

                
            } else {
                fromView.transform = offScreenUp
            }
            
        

            
            }) { (finished) in
                transitionContext.completeTransition(true)
        }
    }
    

    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
}
