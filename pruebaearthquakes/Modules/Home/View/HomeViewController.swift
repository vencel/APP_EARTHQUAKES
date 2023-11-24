//
//  HomeViewController.swift
//  pruebaearthquakes
//
//  Created by Manuel Venegas Celis on 22-11-23.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    let itemsPerPage = 10
    var currentPage = 1
    
    private var viewModel = HomeViewModel()
    var dataFeature: [Feature] = []
    var items: [Feature] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideLoading()
        self.disableTextBack()
        
        // Configura la tabla
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = 200//UITableView.automaticDimension
        registerNib(identificador: "HomeViewCell")

        // Inicia la carga inicial de datos
//        loadMoreItems()
        
        // Inicia la carga inicial de datos y aplicar el filtro inicial
//        resetAndReloadData()

        
        loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.showLoading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hideLoading()
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        
        
        self.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hideLoading()
            let controller = LoginViewController().instantiateViewController() as! LoginViewController
            self.navigateToControllerInStoryboard(controller: controller,isFullScreen: true)
            
            AutenticacionManager.logout()
        }
    }
    
    func loadData() {
        self.checkNetwork()

        self.viewModel.getListEarthQuakes(view: self) { (response) in
            if let res = response as? HomeResponse {
                            
                self.dataFeature = res.features
               
                if !self.dataFeature.isEmpty {
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
                    
                    self.initLoadData()
                }else{
                    AlertWithTittle(msg: Messages.ErrorGenerico.rawValue, title: GenericTexts.TitleUps, controller: self)
                }
            }
        }
    }
    // Método para cargar más elementos
    func loadMoreItems() {

        let newItems = self.dataFeature
        
        // Filtra los elementos según las fechas seleccionadas
        let filteredItems = filterItemsByDate(newItems)
        
        items += filteredItems
        currentPage += 1

        // Recarga la tabla con los nuevos datos
        tableView.reloadData()
    }

    func loadItemsInit() {

        let newItems = self.dataFeature
        
        items += newItems
        currentPage += 1

        // Recarga la tabla con los nuevos datos
        tableView.reloadData()
    }
    
    func filterItemsByDate(_ items: [Feature]) -> [Feature] {
        let startDate = startDatePicker.date
        let endDate = endDatePicker.date

        // Filtra los elementos basados en las fechas seleccionadas
        let filteredItems = items.filter { item in
            
            let timestampInMillis: Int = item.properties.updated
                let timestampInSeconds = Double(timestampInMillis) / 1000.0

                let itemDate = Date(timeIntervalSince1970: timestampInSeconds)

                // Filtra el elemento si su fecha está en el rango especificado
                return itemDate >= startDate && itemDate <= endDate
//
//            let timestampInMillis: Int = item.properties.updated
//            let timestampInSeconds = Double(timestampInMillis) / 1000.0
//
//            let dateOK = Date(timeIntervalSince1970: timestampInSeconds)
//
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let formattedDate = dateFormatter.string(from: dateOK)
//
//            print("Fecha formateada: \(formattedDate)")
//            
//            guard let itemDate = formattedDate else {
//                // Si el elemento no tiene una fecha, no lo incluimos en los resultados
//                return false
//            }
//
//            // Filtra el elemento si su fecha está en el rango especificado
//            return itemDate >= startDate && itemDate <= endDate
        }

        return filteredItems
    }

    @IBAction func filterApply(_ sender: Any) {
        // Recargar la lista cuando cambian las fechas
        resetAndReloadData()
    }
//    @IBAction func dateValueChanged(_ sender: UIDatePicker) {
//        // Recargar la lista cuando cambian las fechas
//        resetAndReloadData()
//    }

    func resetAndReloadData() {
        // Restablece los datos y la paginación
        items.removeAll()
        currentPage = 1

        // Carga los datos filtrados
        loadMoreItems()
    }
    
    func initLoadData() {
        // Restablece los datos y la paginación
        items.removeAll()
        currentPage = 1

        // Carga los datos filtrados
        loadItemsInit()
    }

    func goToDetail(item: Feature) {

        self.checkNetwork()
        
        self.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.hideLoading()
            let controller = DetailHomeViewController().instantiateViewController() as! DetailHomeViewController
            controller.dataFeature = [item]
            self.navigateToControllerInStoryboard(controller: controller,isFullScreen: true)
            
        }
    }
    
    func registerNib(identificador: String) {
        let nibName = UINib(nibName: identificador, bundle: nil)
        self.tableView.register(nibName, forCellReuseIdentifier: identificador)
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell", for: indexPath) as! HomeViewCell
        
        cell.setList(item: items[indexPath.row] )
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Verifica si es el último elemento y carga más datos si es necesario
        if indexPath.row == items.count - 1 {
            loadMoreItems()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.goToDetail(item: items[indexPath.row])
    }
   
    

}
