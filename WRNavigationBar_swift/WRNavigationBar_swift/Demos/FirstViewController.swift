//
//  FirstViewController.swift
//  WRNavigationBar_swift
//
//  Created by wangrui on 2017/4/19.
//  Copyright © 2017年 wangrui. All rights reserved.
//

import UIKit

private let IMAGE_HEIGHT:CGFloat = 260
private let NAVBAR_COLORCHANGE_POINT:CGFloat = IMAGE_HEIGHT - CGFloat(kNavBarBottom * 2)

class FirstViewController: UIViewController
{    
    lazy var tableView:UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: self.view.bounds.height), style: .plain)
        table.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        table.delegate = self
        table.dataSource = self
        return table
    }()
    lazy var imageView:UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "image4"))
        imgView.frame.size = CGSize(width: 100, height: 100)
        imgView.layer.cornerRadius = 50
        imgView.layer.masksToBounds = true
        return imgView
    }()
    lazy var topView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: IMAGE_HEIGHT))
        view.backgroundColor = UIColor.orange
        return view
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "个人中心"
        view.backgroundColor = UIColor.red
        view.addSubview(tableView)
        topView.addSubview(imageView)
        imageView.center = topView.center
        tableView.tableHeaderView = topView
        
        // 设置导航栏颜色
        navBarBarTintColor = MainNavBarColor
        
        // 设置初始导航栏透明度
        navBarEffectAlpha = 0
        
        // 设置导航栏按钮和标题颜色
        navBarTintColor = .white
    }
}


// MARK: - 滑动改变导航栏透明度
extension FirstViewController
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavBarBottom)
            navBarEffectAlpha = alpha
        }
        else
        {
            navBarEffectAlpha = 0
        }
    }
}


extension FirstViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        let str = String(format: "WRNavigationBar %zd", indexPath.row)
        cell.textLabel?.text = str
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc:UIViewController = UIViewController()
        vc.view.backgroundColor = .white
        vc.navBarBarTintColor = .gray
        let str = String(format: "WRNavigationBar %zd", indexPath.row)
        vc.title = str
        navigationController?.pushViewController(vc, animated: true)
    }
}
