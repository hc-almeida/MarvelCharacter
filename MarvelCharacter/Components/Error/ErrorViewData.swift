//
//  ErrorViewData.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 07/05/24.
//

import Foundation
import UIKit

protocol ErrorViewData {
    var title: String { get }
    var subtitle: String { get }
    var image: UIImage { get }
}

struct ErrorBuild {
    
    struct ViewData: ErrorViewData {
        var title: String
        var subtitle: String
        var image: UIImage
    }
    
    enum ErrorType {
        case generic
        case noItems
        case noConnection
        
        var viewData: ViewData {
            let title: String
            let subtile: String
            let image: UIImage
            
            switch self {
            case .generic:
                title = "O carregamento falhou"
                subtile = "Você pode tentar novamente mais tarde"
                image = .errorGeneric
            case .noItems:
                title = "Não foi encontrado resultados"
                subtile = "Tente uma nova pesquisa"
                image = .notFound
            case .noConnection:
                title = "Sem conexão com a internet"
                subtile = "Verifique se está tudo certo com a sua conexão antes de tentar de novo"
                image = .noConnection
            }
            
            return .init(title: title, subtitle: subtile, image: image)
        }
        
    }
    
    static func setup(type: ErrorType, closeAction: (() -> Void)? = nil) -> ErrorViewController {
        let controller = ErrorViewController(viewData: type.viewData)
        
        controller.didTapCloseAction = {
            controller.dismiss(animated: true) {
                guard closeAction != nil else { return }
                closeAction?()
            }
        }
        
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
    
}
