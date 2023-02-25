//
//  Configuration.swift
//  JsonPlaceholder
//
//  Created by Timur on 7/1/23.
//

import Foundation

struct Configuration {
#if STAGING
    let host = "https://jsonplaceholder.typicode.com"
#else
    let host = "https://jsonplaceholder.typicode.com"
#endif
}
