Return-Path: <linux-can+bounces-1946-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82609C348F
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 21:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471341F21264
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B151537C6;
	Sun, 10 Nov 2024 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8O8zOri"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4CC14AD3D;
	Sun, 10 Nov 2024 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731270530; cv=none; b=RivYwMpjl/26x987LeGCxJeFvYvHy1x+5h77NfoEoP8oE1iQQLEA1QomFH4kubqYMlDcK3mLtG86KbYxet1WsP4AF5+hvLxl0YWzE1VY3dsgu6i2mXX93vU1vg52KAIc70RPTM35OzeodW1CXaklfshHu4piVmBId/MJS+W0kyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731270530; c=relaxed/simple;
	bh=FvnTiVPgZAi2hqZnRMSEkHuWe8Mf6RYiWEemVzAI0ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm9dC02COyRNyIeTD1uxryEHMN9jO7PR7C8x+mAQ09IztOesyhUVlUTThvMG044bF91cWn095cYLN67ZxD3nWc3IY2WpBxCqEM53BSGfVvpMM0DvU8etZklrUoT0IQYpj9dOCCAbX0z/Pz6Z+mhpvMfOD+n5bF/6nGRID6Xkvz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8O8zOri; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731270527; x=1762806527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FvnTiVPgZAi2hqZnRMSEkHuWe8Mf6RYiWEemVzAI0ZE=;
  b=g8O8zOriLnYV5RrKp4PdBVOh70Q4B/pf6bF2+ik0OlWrT10fAZr52EYK
   9Ay/ue4CQc63ZmRXG1N51mgV5ySDpmBdd9AEzxXvb+wsfsd1tOoNrjsRI
   9qG/IM5qpqeYjx13qCsNVaKFIgyIfs+vkXBZWd2Y/40gNPZPP7Cgk0XaK
   M2WAxIreEsfNSj+n3x2ULkpmxbrNv7E2OkWrjdUuXxUZOGnbBBT7Y3ce1
   4WecUx7yD68Zl5bkxbgVrGqJkJ7jTRYpFh6c36WazMw9Esz7WiSg22adF
   dlChv5UuMU5l9qP+oc2629yCzabVmBSsj0v7I8Cb2Z55HL3ZmRFuU0HUS
   g==;
X-CSE-ConnectionGUID: Sv8QtlN4Sc2CDUw3vobuzw==
X-CSE-MsgGUID: 3q60AiFbSgaquPjrz0BMWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="30480868"
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; 
   d="scan'208";a="30480868"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 12:28:46 -0800
X-CSE-ConnectionGUID: rRkfPIAPRI+FgYG14Dvbxw==
X-CSE-MsgGUID: Z77/dryGTv+u8YvCuAQbpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; 
   d="scan'208";a="87012007"
Received: from lkp-server01.sh.intel.com (HELO 7b17a4138caf) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 Nov 2024 12:28:40 -0800
Received: from kbuild by 7b17a4138caf with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAEY2-0000NZ-0x;
	Sun, 10 Nov 2024 20:28:38 +0000
Date: Mon, 11 Nov 2024 04:28:00 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	Chris Snook <chris.snook@gmail.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] net: modernize ioremap in probe
Message-ID: <202411110419.EQz0nIvL-lkp@intel.com>
References: <20241109233641.8313-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109233641.8313-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on next-20241108]
[cannot apply to mkl-can-next/testing net/main linus/master v6.12-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-modernize-ioremap-in-probe/20241110-073751
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241109233641.8313-1-rosenp%40gmail.com
patch subject: [PATCH] net: modernize ioremap in probe
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241111/202411110419.EQz0nIvL-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241111/202411110419.EQz0nIvL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411110419.EQz0nIvL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/freescale/xgmac_mdio.c:16:
   In file included from include/linux/acpi_mdio.h:9:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/net/ethernet/freescale/xgmac_mdio.c:16:
   In file included from include/linux/acpi_mdio.h:9:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/freescale/xgmac_mdio.c:16:
   In file included from include/linux/acpi_mdio.h:9:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/net/ethernet/freescale/xgmac_mdio.c:16:
   In file included from include/linux/acpi_mdio.h:9:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/net/ethernet/freescale/xgmac_mdio.c:395:45: warning: variable 'res' is uninitialized when used here [-Wuninitialized]
     395 |         snprintf(bus->id, MII_BUS_ID_SIZE, "%pa", &res->start);
         |                                                    ^~~
   drivers/net/ethernet/freescale/xgmac_mdio.c:375:22: note: initialize the variable 'res' to silence this warning
     375 |         struct resource *res;
         |                             ^
         |                              = NULL
   8 warnings generated.


vim +/res +395 drivers/net/ethernet/freescale/xgmac_mdio.c

909bea73485fab5 Tobias Waldekranz 2022-01-26  370  
33897cc869eef8b Bill Pemberton    2012-12-03  371  static int xgmac_mdio_probe(struct platform_device *pdev)
9f35a7342cff0be Timur Tabi        2012-08-20  372  {
ac53c26433b51f1 Marcin Wojtas     2021-06-25  373  	struct fwnode_handle *fwnode;
73ee5442978b2dd Shaohui Xie       2015-03-16  374  	struct mdio_fsl_priv *priv;
15e7064e8793352 Calvin Johnson    2021-06-11  375  	struct resource *res;
15e7064e8793352 Calvin Johnson    2021-06-11  376  	struct mii_bus *bus;
9f35a7342cff0be Timur Tabi        2012-08-20  377  	int ret;
9f35a7342cff0be Timur Tabi        2012-08-20  378  
229f4bb47512ece Calvin Johnson    2020-06-22  379  	/* In DPAA-1, MDIO is one of the many FMan sub-devices. The FMan
229f4bb47512ece Calvin Johnson    2020-06-22  380  	 * defines a register space that spans a large area, covering all the
229f4bb47512ece Calvin Johnson    2020-06-22  381  	 * subdevice areas. Therefore, MDIO cannot claim exclusive access to
229f4bb47512ece Calvin Johnson    2020-06-22  382  	 * this register area.
229f4bb47512ece Calvin Johnson    2020-06-22  383  	 */
9f35a7342cff0be Timur Tabi        2012-08-20  384  
1d14eb15dc2c396 Tobias Waldekranz 2022-01-26  385  	bus = devm_mdiobus_alloc_size(&pdev->dev, sizeof(struct mdio_fsl_priv));
9f35a7342cff0be Timur Tabi        2012-08-20  386  	if (!bus)
9f35a7342cff0be Timur Tabi        2012-08-20  387  		return -ENOMEM;
9f35a7342cff0be Timur Tabi        2012-08-20  388  
9f35a7342cff0be Timur Tabi        2012-08-20  389  	bus->name = "Freescale XGMAC MDIO Bus";
c0fc8e6dcee40cf Andrew Lunn       2023-01-09  390  	bus->read = xgmac_mdio_read_c22;
c0fc8e6dcee40cf Andrew Lunn       2023-01-09  391  	bus->write = xgmac_mdio_write_c22;
c0fc8e6dcee40cf Andrew Lunn       2023-01-09  392  	bus->read_c45 = xgmac_mdio_read_c45;
c0fc8e6dcee40cf Andrew Lunn       2023-01-09  393  	bus->write_c45 = xgmac_mdio_write_c45;
9f35a7342cff0be Timur Tabi        2012-08-20  394  	bus->parent = &pdev->dev;
229f4bb47512ece Calvin Johnson    2020-06-22 @395  	snprintf(bus->id, MII_BUS_ID_SIZE, "%pa", &res->start);
9f35a7342cff0be Timur Tabi        2012-08-20  396  
73ee5442978b2dd Shaohui Xie       2015-03-16  397  	priv = bus->priv;
865bbb2945a1614 Rosen Penev       2024-11-09  398  	priv->mdio_base = devm_platform_ioremap_resource(pdev, 0);
865bbb2945a1614 Rosen Penev       2024-11-09  399  	if (IS_ERR(priv->mdio_base))
865bbb2945a1614 Rosen Penev       2024-11-09  400  		return PTR_ERR(priv->mdio_base);
9f35a7342cff0be Timur Tabi        2012-08-20  401  
15e7064e8793352 Calvin Johnson    2021-06-11  402  	/* For both ACPI and DT cases, endianness of MDIO controller
15e7064e8793352 Calvin Johnson    2021-06-11  403  	 * needs to be specified using "little-endian" property.
15e7064e8793352 Calvin Johnson    2021-06-11  404  	 */
229f4bb47512ece Calvin Johnson    2020-06-22  405  	priv->is_little_endian = device_property_read_bool(&pdev->dev,
07bf2e11ad05868 Julia Lawall      2016-08-05  406  							   "little-endian");
73ee5442978b2dd Shaohui Xie       2015-03-16  407  
6198c722019774d Tobias Waldekranz 2022-01-18  408  	priv->has_a009885 = device_property_read_bool(&pdev->dev,
6198c722019774d Tobias Waldekranz 2022-01-18  409  						      "fsl,erratum-a009885");
229f4bb47512ece Calvin Johnson    2020-06-22  410  	priv->has_a011043 = device_property_read_bool(&pdev->dev,
1d3ca681b9d9575 Madalin Bucur     2020-01-22  411  						      "fsl,erratum-a011043");
1d3ca681b9d9575 Madalin Bucur     2020-01-22  412  
909bea73485fab5 Tobias Waldekranz 2022-01-26  413  	xgmac_mdio_set_suppress_preamble(bus);
909bea73485fab5 Tobias Waldekranz 2022-01-26  414  
dd8f467eda72cda Tobias Waldekranz 2022-01-26  415  	ret = xgmac_mdio_set_mdc_freq(bus);
dd8f467eda72cda Tobias Waldekranz 2022-01-26  416  	if (ret)
dd8f467eda72cda Tobias Waldekranz 2022-01-26  417  		return ret;
dd8f467eda72cda Tobias Waldekranz 2022-01-26  418  
105b0468d7b2e67 zhaoxiao          2022-08-18  419  	fwnode = dev_fwnode(&pdev->dev);
ac53c26433b51f1 Marcin Wojtas     2021-06-25  420  	if (is_of_node(fwnode))
ac53c26433b51f1 Marcin Wojtas     2021-06-25  421  		ret = of_mdiobus_register(bus, to_of_node(fwnode));
ac53c26433b51f1 Marcin Wojtas     2021-06-25  422  	else if (is_acpi_node(fwnode))
ac53c26433b51f1 Marcin Wojtas     2021-06-25  423  		ret = acpi_mdiobus_register(bus, fwnode);
ac53c26433b51f1 Marcin Wojtas     2021-06-25  424  	else
ac53c26433b51f1 Marcin Wojtas     2021-06-25  425  		ret = -EINVAL;
9f35a7342cff0be Timur Tabi        2012-08-20  426  	if (ret) {
9f35a7342cff0be Timur Tabi        2012-08-20  427  		dev_err(&pdev->dev, "cannot register MDIO bus\n");
9f35a7342cff0be Timur Tabi        2012-08-20  428  		return ret;
9f35a7342cff0be Timur Tabi        2012-08-20  429  	}
9f35a7342cff0be Timur Tabi        2012-08-20  430  
1d14eb15dc2c396 Tobias Waldekranz 2022-01-26  431  	platform_set_drvdata(pdev, bus);
9f35a7342cff0be Timur Tabi        2012-08-20  432  
9f35a7342cff0be Timur Tabi        2012-08-20  433  	return 0;
9f35a7342cff0be Timur Tabi        2012-08-20  434  }
9f35a7342cff0be Timur Tabi        2012-08-20  435  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

