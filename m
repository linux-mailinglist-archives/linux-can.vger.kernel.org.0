Return-Path: <linux-can+bounces-1421-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E74B96D76A
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 13:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D55AFB20B7F
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 11:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D94199E95;
	Thu,  5 Sep 2024 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTQy6zR4"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BBD1922F9
	for <linux-can@vger.kernel.org>; Thu,  5 Sep 2024 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536557; cv=none; b=NfNol07DyGLh2WKKXs8tcUv++PrLGrwWkAKFC4ciePecLQG8NSjsTGEnG/34n8YNzv1pWB/nPl8+CrPjMxktJ0iShQjF8E+OqHS5jxGOgauDGg+KXokvqPoXYQ3FapVAEPmnEu4TKcM24mekESrnJJ5JvIfVHHqJmqSSh8YeyoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536557; c=relaxed/simple;
	bh=FAShGLUoYKGHHihCVvVPgVsBgqnU2zwUmFhwrlTJGEA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d8zue+7DFADXS1tLjX7o9rqt/qtnRgsPD33i+x3g8toZuyuiZNJoIF+Xkrei2pm/zCe7G/bm0eKpa10MvkRUE12Z1HErzLXurZ+Qh0DEI/g6muSQz7H5OjYxkUR0TcVu63i5/HXrsOpHJuWKeWWKRTXz6XJLjQlvsyk8hQJ+DVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTQy6zR4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725536555; x=1757072555;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FAShGLUoYKGHHihCVvVPgVsBgqnU2zwUmFhwrlTJGEA=;
  b=WTQy6zR4BfrrK6V6o2JBHa5eSfZ2OEaTddkdFKiBjmoM/K2nET075yq1
   2+ayRozB75U0R3zUnQbfHqCWTEWHu01wZVcCEZfyBMkxtVtSrOBYPjcPu
   IvDrF4Cllujj8rcpXbk267YCGfARNIclN56St4R16rfbNnqCHLvh0oUcl
   8To+ZmUS1PX3EgGjn3fBgIWGNnDlx9A5i2j2Y2xSXcPV4+9ced56JDzu0
   7pftgvxfeF9hlGKqWYjXS3MLOWk8esYZhS/wDsNhOeEJeJw2kvU2PXayM
   BUSpTx7jG9vuqe17HxyoDuo5h0ABnHn7hfSaX1HywPp4XkvI2XnqSfEoq
   A==;
X-CSE-ConnectionGUID: yIQTmYErQmeUcZO+GMrBjQ==
X-CSE-MsgGUID: JzsDlVj2RiyNvBEOA7qiAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24109756"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="24109756"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 04:42:35 -0700
X-CSE-ConnectionGUID: Am6kdXn9RhijdU6rz9/kuQ==
X-CSE-MsgGUID: BRwyOqmfSoq7tKuuBPSlKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="65839765"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Sep 2024 04:42:33 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smAsh-0009mR-1R;
	Thu, 05 Sep 2024 11:42:31 +0000
Date: Thu, 5 Sep 2024 19:42:05 +0800
From: kernel test robot <lkp@intel.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org
Subject: [mkl-can-next:rockchip-canfd-downstream 8/32]
 drivers/net/can/rockchip/rockchip_can.c:683:34: warning:
 'rockchip_can_of_match' defined but not used
Message-ID: <202409051911.L8wo8jx3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git rockchip-canfd-downstream
head:   57a1d7b3fcdc3ccf99336327347d54ad630a4485
commit: ffed8877bb0efe42f7a0c9022c414d32f97843b3 [8/32] can: rockchip_can: remove obsolete CAN LED support
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20240905/202409051911.L8wo8jx3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240905/202409051911.L8wo8jx3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409051911.L8wo8jx3-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |                              ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/can/rockchip/rockchip_can.c:737:17: note: in expansion of macro 'dev_err'
     737 |                 dev_err(&pdev->dev, "bus clock not found\n");
         |                 ^~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:741:26: error: invalid use of undefined type 'struct platform_device'
     741 |         rcan->dev = &pdev->dev;
         |                          ^~
   drivers/net/can/rockchip/rockchip_can.c:751:9: error: implicit declaration of function 'platform_set_drvdata' [-Wimplicit-function-declaration]
     751 |         platform_set_drvdata(pdev, ndev);
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:752:35: error: invalid use of undefined type 'struct platform_device'
     752 |         SET_NETDEV_DEV(ndev, &pdev->dev);
         |                                   ^~
   include/linux/netdevice.h:2609:63: note: in definition of macro 'SET_NETDEV_DEV'
    2609 | #define SET_NETDEV_DEV(net, pdev)       ((net)->dev.parent = (pdev))
         |                                                               ^~~~
   drivers/net/can/rockchip/rockchip_can.c:754:32: error: invalid use of undefined type 'struct platform_device'
     754 |         pm_runtime_enable(&pdev->dev);
         |                                ^~
   drivers/net/can/rockchip/rockchip_can.c:755:40: error: invalid use of undefined type 'struct platform_device'
     755 |         err = pm_runtime_get_sync(&pdev->dev);
         |                                        ^~
   drivers/net/can/rockchip/rockchip_can.c:757:30: error: invalid use of undefined type 'struct platform_device'
     757 |                 dev_err(&pdev->dev, "%s: pm_runtime_get failed(%d)\n",
         |                              ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/can/rockchip/rockchip_can.c:757:17: note: in expansion of macro 'dev_err'
     757 |                 dev_err(&pdev->dev, "%s: pm_runtime_get failed(%d)\n",
         |                 ^~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:764:30: error: invalid use of undefined type 'struct platform_device'
     764 |                 dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
         |                              ^~
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/net/can/rockchip/rockchip_can.c:764:17: note: in expansion of macro 'dev_err'
     764 |                 dev_err(&pdev->dev, "registering %s failed (err=%d)\n",
         |                 ^~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:769:29: error: invalid use of undefined type 'struct platform_device'
     769 |         pm_runtime_put(&pdev->dev);
         |                             ^~
   drivers/net/can/rockchip/rockchip_can.c:774:29: error: invalid use of undefined type 'struct platform_device'
     774 |         pm_runtime_put(&pdev->dev);
         |                             ^~
   drivers/net/can/rockchip/rockchip_can.c:776:33: error: invalid use of undefined type 'struct platform_device'
     776 |         pm_runtime_disable(&pdev->dev);
         |                                 ^~
   drivers/net/can/rockchip/rockchip_can.c: At top level:
   drivers/net/can/rockchip/rockchip_can.c:782:39: warning: 'struct platform_device' declared inside parameter list will not be visible outside of this definition or declaration
     782 | static int rockchip_can_remove(struct platform_device *pdev)
         |                                       ^~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c: In function 'rockchip_can_remove':
   drivers/net/can/rockchip/rockchip_can.c:784:35: error: implicit declaration of function 'platform_get_drvdata' [-Wimplicit-function-declaration]
     784 |         struct net_device *ndev = platform_get_drvdata(pdev);
         |                                   ^~~~~~~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:784:35: error: initialization of 'struct net_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/net/can/rockchip/rockchip_can.c:787:33: error: invalid use of undefined type 'struct platform_device'
     787 |         pm_runtime_disable(&pdev->dev);
         |                                 ^~
   drivers/net/can/rockchip/rockchip_can.c: At top level:
   drivers/net/can/rockchip/rockchip_can.c:793:15: error: variable 'rockchip_can_driver' has initializer but incomplete type
     793 | static struct platform_driver rockchip_can_driver = {
         |               ^~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:794:10: error: 'struct platform_driver' has no member named 'driver'
     794 |         .driver = {
         |          ^~~~~~
   drivers/net/can/rockchip/rockchip_can.c:794:19: error: extra brace group at end of initializer
     794 |         .driver = {
         |                   ^
   drivers/net/can/rockchip/rockchip_can.c:794:19: note: (near initialization for 'rockchip_can_driver')
   drivers/net/can/rockchip/rockchip_can.c:794:19: warning: excess elements in struct initializer
   drivers/net/can/rockchip/rockchip_can.c:794:19: note: (near initialization for 'rockchip_can_driver')
   drivers/net/can/rockchip/rockchip_can.c:799:10: error: 'struct platform_driver' has no member named 'probe'
     799 |         .probe = rockchip_can_probe,
         |          ^~~~~
   drivers/net/can/rockchip/rockchip_can.c:799:18: warning: excess elements in struct initializer
     799 |         .probe = rockchip_can_probe,
         |                  ^~~~~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:799:18: note: (near initialization for 'rockchip_can_driver')
   drivers/net/can/rockchip/rockchip_can.c:800:10: error: 'struct platform_driver' has no member named 'remove'
     800 |         .remove = rockchip_can_remove,
         |          ^~~~~~
   drivers/net/can/rockchip/rockchip_can.c:800:19: warning: excess elements in struct initializer
     800 |         .remove = rockchip_can_remove,
         |                   ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:800:19: note: (near initialization for 'rockchip_can_driver')
   drivers/net/can/rockchip/rockchip_can.c:802:1: warning: data definition has no type or storage class
     802 | module_platform_driver(rockchip_can_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:802:1: error: type defaults to 'int' in declaration of 'module_platform_driver' [-Wimplicit-int]
   drivers/net/can/rockchip/rockchip_can.c:802:1: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
   drivers/net/can/rockchip/rockchip_can.c:793:31: error: storage size of 'rockchip_can_driver' isn't known
     793 | static struct platform_driver rockchip_can_driver = {
         |                               ^~~~~~~~~~~~~~~~~~~
   drivers/net/can/rockchip/rockchip_can.c:793:31: warning: 'rockchip_can_driver' defined but not used [-Wunused-variable]
>> drivers/net/can/rockchip/rockchip_can.c:683:34: warning: 'rockchip_can_of_match' defined but not used [-Wunused-variable]
     683 | static const struct of_device_id rockchip_can_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~


vim +/rockchip_can_of_match +683 drivers/net/can/rockchip/rockchip_can.c

31119b56075179 Andy Yan 2019-03-25  682  
31119b56075179 Andy Yan 2019-03-25 @683  static const struct of_device_id rockchip_can_of_match[] = {
31119b56075179 Andy Yan 2019-03-25  684  	{.compatible = "rockchip,can-1.0"},
31119b56075179 Andy Yan 2019-03-25  685  	{},
31119b56075179 Andy Yan 2019-03-25  686  };
31119b56075179 Andy Yan 2019-03-25  687  MODULE_DEVICE_TABLE(of, rockchip_can_of_match);
31119b56075179 Andy Yan 2019-03-25  688  

:::::: The code at line 683 was first introduced by commit
:::::: 31119b560751797c63452b1badad825d6830ac28 can: rockchip_can: add rockchip CAN driver

:::::: TO: Andy Yan <andy.yan@rock-chips.com>
:::::: CC: Marc Kleine-Budde <mkl@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

