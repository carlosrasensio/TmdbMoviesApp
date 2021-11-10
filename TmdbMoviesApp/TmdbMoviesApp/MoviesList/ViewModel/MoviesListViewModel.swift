//
//  MoviesListViewModel.swift
//  TmdbMoviesApp
//
//  Created by crodrigueza on 9/11/21.
//

import Foundation

class MoviesListViewModel {
    // MARK: - Variables/Constants
    private weak var view: MoviesListView?
    private var router: MoviesListRouter?

    // MARK: - Connecting view and router
    func bind(view: MoviesListView, router: MoviesListRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
}