Return-Path: <linux-can+bounces-1918-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4AA9C31B0
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 11:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6391F2138F
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 10:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3BA153BEE;
	Sun, 10 Nov 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAkoY2sc"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1CC14F121;
	Sun, 10 Nov 2024 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731236040; cv=none; b=eJu9rUx5kpzhqagc+2FkKvLtowSx3dbxibw0IBr/XDWgx+sihXgCcv2qxt0QiQrVxblLg6kwbAtCfN6xu9gG5PDTqgQVHjVdnUxn2cpXHmLPq0JOUV82WJ/euanmTg2AHAXqOueiTtJ/IIDIighHvj4Pc4sBFpzAonE5fHPHPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731236040; c=relaxed/simple;
	bh=jepY9rdVvObl0SrjcpatpRHlR9HaeeZYJ/sYwE/vpoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd6IWSBa4eVPaH947ebC1sxyZsWHwCY87rixPvmvGuVtQKm961Kxpy9o9aUJ900bLuuBW6nWpsGDFg7UFErZgf3Q7HwbPMPSUpdQkshEd8yvPNP6Bdq1NPmO2My2u2jnbEeMuG0/7Gw1NGs4XBANi4UUWKXJ6nsANFBKe4x1kzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAkoY2sc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731236037; x=1762772037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jepY9rdVvObl0SrjcpatpRHlR9HaeeZYJ/sYwE/vpoY=;
  b=HAkoY2sc/+lWZE14Rf9p52WT1wXYjV9pubNceVjx4eeuvl1D8szicE7b
   dVDyqv23ydcPz4ACJjYl1NpD5qmbjT9+d7swEAZhexq7YlDi40zdqpb0i
   djNPBmNwpppxlsAENURtzVKJFODsxgveNPvbSjXlkX8cuRG4JQer6AhMu
   R2U+ijt19f2moAYIjCM0SK/n1irknLW1tylmNKvPeLkHexWfPvj31wBKU
   dIVpJOnzLJvi7QzR3JA3R5tO5qHmPW9EDW0q8eB4OcOBivet/6BfTgSUF
   ywD4yBHPUq0ovmp4OJZbeqflv4D0AJhFT9XeI39T4qyQGPKmKznP1BBgL
   w==;
X-CSE-ConnectionGUID: n3jZBN9zSZSdgbbnPoQWVg==
X-CSE-MsgGUID: i5trc7fwRcq0NTrwsjtp7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="42158841"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="42158841"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 02:53:56 -0800
X-CSE-ConnectionGUID: Yf3RBR74Su+OBTikUs2MNg==
X-CSE-MsgGUID: QPOnByq+TyuTok3dCYLBMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,142,1728975600"; 
   d="scan'208";a="86115574"
Received: from lkp-server01.sh.intel.com (HELO 7b17a4138caf) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Nov 2024 02:53:51 -0800
Received: from kbuild by 7b17a4138caf with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tA5Zk-00005x-2h;
	Sun, 10 Nov 2024 10:53:48 +0000
Date: Sun, 10 Nov 2024 18:53:27 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Byungho An <bh74.an@samsung.com>,
	Kevin Brace <kevinbrace@bracecomputerlab.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Michal Simek <monstr@monstr.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Zhao Qiang <qiang.zhao@nxp.com>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next] net: use pdev instead of OF funcs
Message-ID: <202411101834.A8QNRx3c-lkp@intel.com>
References: <20241109233821.8619-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109233821.8619-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-use-pdev-instead-of-OF-funcs/20241110-073939
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241109233821.8619-1-rosenp%40gmail.com
patch subject: [PATCH net-next] net: use pdev instead of OF funcs
config: powerpc-ge_imp3a_defconfig (https://download.01.org/0day-ci/archive/20241110/202411101834.A8QNRx3c-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241110/202411101834.A8QNRx3c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411101834.A8QNRx3c-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/freescale/ucc_geth.c: In function 'ucc_geth_free_rx':
   drivers/net/ethernet/freescale/ucc_geth.c:1810:31: warning: variable 'uf_info' set but not used [-Wunused-but-set-variable]
    1810 |         struct ucc_fast_info *uf_info;
         |                               ^~~~~~~
   drivers/net/ethernet/freescale/ucc_geth.c: In function 'ucc_geth_free_tx':
   drivers/net/ethernet/freescale/ucc_geth.c:1849:31: warning: variable 'uf_info' set but not used [-Wunused-but-set-variable]
    1849 |         struct ucc_fast_info *uf_info;
         |                               ^~~~~~~
   drivers/net/ethernet/freescale/ucc_geth.c: In function 'ucc_geth_alloc_tx':
   drivers/net/ethernet/freescale/ucc_geth.c:2142:31: warning: variable 'uf_info' set but not used [-Wunused-but-set-variable]
    2142 |         struct ucc_fast_info *uf_info;
         |                               ^~~~~~~
   drivers/net/ethernet/freescale/ucc_geth.c: In function 'ucc_geth_alloc_rx':
   drivers/net/ethernet/freescale/ucc_geth.c:2204:31: warning: variable 'uf_info' set but not used [-Wunused-but-set-variable]
    2204 |         struct ucc_fast_info *uf_info;
         |                               ^~~~~~~
   drivers/net/ethernet/freescale/ucc_geth.c: In function 'ucc_geth_startup':
   drivers/net/ethernet/freescale/ucc_geth.c:2271:13: warning: variable 'ifstat' set but not used [-Wunused-but-set-variable]
    2271 |         u32 ifstat, i, j, size, l2qt, l3qt;
         |             ^~~~~~
   drivers/net/ethernet/freescale/ucc_geth.c:2261:62: warning: variable 'p_82xx_addr_filt' set but not used [-Wunused-but-set-variable]
    2261 |         struct ucc_geth_82xx_address_filtering_pram __iomem *p_82xx_addr_filt;
         |                                                              ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/freescale/ucc_geth.c: In function 'ucc_geth_rx':
   drivers/net/ethernet/freescale/ucc_geth.c:2996:13: warning: variable 'bdBuffer' set but not used [-Wunused-but-set-variable]
    2996 |         u8 *bdBuffer;
         |             ^~~~~~~~
   drivers/net/ethernet/freescale/ucc_geth.c: In function 'ucc_geth_irq_handler':
   drivers/net/ethernet/freescale/ucc_geth.c:3149:31: warning: variable 'ug_info' set but not used [-Wunused-but-set-variable]
    3149 |         struct ucc_geth_info *ug_info;
         |                               ^~~~~~~
   drivers/net/ethernet/freescale/ucc_geth.c: In function 'ucc_geth_probe':
>> drivers/net/ethernet/freescale/ucc_geth.c:3608:42: error: expected ')' before numeric constant
    3608 |         res = platform_get_resource(ofdev 0, IORESOURCE_MEM);
         |                                    ~     ^~
         |                                          )
>> drivers/net/ethernet/freescale/ucc_geth.c:3608:15: error: too few arguments to function 'platform_get_resource'
    3608 |         res = platform_get_resource(ofdev 0, IORESOURCE_MEM);
         |               ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/freescale/ucc_geth.c:36:
   include/linux/platform_device.h:58:25: note: declared here
      58 | extern struct resource *platform_get_resource(struct platform_device *,
         |                         ^~~~~~~~~~~~~~~~~~~~~


vim +3608 drivers/net/ethernet/freescale/ucc_geth.c

  3555	
  3556	static int ucc_geth_probe(struct platform_device* ofdev)
  3557	{
  3558		struct device *device = &ofdev->dev;
  3559		struct device_node *np = ofdev->dev.of_node;
  3560		struct net_device *dev = NULL;
  3561		struct ucc_geth_private *ugeth = NULL;
  3562		struct ucc_geth_info *ug_info;
  3563		struct resource *res;
  3564		int err, ucc_num, max_speed = 0;
  3565		const unsigned int *prop;
  3566		phy_interface_t phy_interface;
  3567		static const int enet_to_speed[] = {
  3568			SPEED_10, SPEED_10, SPEED_10,
  3569			SPEED_100, SPEED_100, SPEED_100,
  3570			SPEED_1000, SPEED_1000, SPEED_1000, SPEED_1000,
  3571		};
  3572		static const phy_interface_t enet_to_phy_interface[] = {
  3573			PHY_INTERFACE_MODE_MII, PHY_INTERFACE_MODE_RMII,
  3574			PHY_INTERFACE_MODE_RGMII, PHY_INTERFACE_MODE_MII,
  3575			PHY_INTERFACE_MODE_RMII, PHY_INTERFACE_MODE_RGMII,
  3576			PHY_INTERFACE_MODE_GMII, PHY_INTERFACE_MODE_RGMII,
  3577			PHY_INTERFACE_MODE_TBI, PHY_INTERFACE_MODE_RTBI,
  3578			PHY_INTERFACE_MODE_SGMII,
  3579		};
  3580	
  3581		ugeth_vdbg("%s: IN", __func__);
  3582	
  3583		prop = of_get_property(np, "cell-index", NULL);
  3584		if (!prop) {
  3585			prop = of_get_property(np, "device-id", NULL);
  3586			if (!prop)
  3587				return -ENODEV;
  3588		}
  3589	
  3590		ucc_num = *prop - 1;
  3591		if ((ucc_num < 0) || (ucc_num > 7))
  3592			return -ENODEV;
  3593	
  3594		ug_info = devm_kmemdup(&ofdev->dev, &ugeth_primary_info,
  3595				       sizeof(*ug_info), GFP_KERNEL);
  3596		if (!ug_info)
  3597			return -ENOMEM;
  3598	
  3599		ug_info->uf_info.ucc_num = ucc_num;
  3600	
  3601		err = ucc_geth_parse_clock(np, "rx", &ug_info->uf_info.rx_clock);
  3602		if (err)
  3603			return err;
  3604		err = ucc_geth_parse_clock(np, "tx", &ug_info->uf_info.tx_clock);
  3605		if (err)
  3606			return err;
  3607	
> 3608		res = platform_get_resource(ofdev 0, IORESOURCE_MEM);
  3609		if (!res)
  3610			return -ENODEV;
  3611	
  3612		ug_info->uf_info.regs = res->start;
  3613		ug_info->uf_info.irq = platform_get_irq(ofdev, 0);
  3614	
  3615		ug_info->phy_node = of_parse_phandle(np, "phy-handle", 0);
  3616		if (!ug_info->phy_node && of_phy_is_fixed_link(np)) {
  3617			/*
  3618			 * In the case of a fixed PHY, the DT node associated
  3619			 * to the PHY is the Ethernet MAC DT node.
  3620			 */
  3621			err = of_phy_register_fixed_link(np);
  3622			if (err)
  3623				return err;
  3624			ug_info->phy_node = of_node_get(np);
  3625		}
  3626	
  3627		/* Find the TBI PHY node.  If it's not there, we don't support SGMII */
  3628		ug_info->tbi_node = of_parse_phandle(np, "tbi-handle", 0);
  3629	
  3630		/* get the phy interface type, or default to MII */
  3631		prop = of_get_property(np, "phy-connection-type", NULL);
  3632		if (!prop) {
  3633			/* handle interface property present in old trees */
  3634			prop = of_get_property(ug_info->phy_node, "interface", NULL);
  3635			if (prop != NULL) {
  3636				phy_interface = enet_to_phy_interface[*prop];
  3637				max_speed = enet_to_speed[*prop];
  3638			} else
  3639				phy_interface = PHY_INTERFACE_MODE_MII;
  3640		} else {
  3641			phy_interface = to_phy_interface((const char *)prop);
  3642		}
  3643	
  3644		/* get speed, or derive from PHY interface */
  3645		if (max_speed == 0)
  3646			switch (phy_interface) {
  3647			case PHY_INTERFACE_MODE_GMII:
  3648			case PHY_INTERFACE_MODE_RGMII:
  3649			case PHY_INTERFACE_MODE_RGMII_ID:
  3650			case PHY_INTERFACE_MODE_RGMII_RXID:
  3651			case PHY_INTERFACE_MODE_RGMII_TXID:
  3652			case PHY_INTERFACE_MODE_TBI:
  3653			case PHY_INTERFACE_MODE_RTBI:
  3654			case PHY_INTERFACE_MODE_SGMII:
  3655				max_speed = SPEED_1000;
  3656				break;
  3657			default:
  3658				max_speed = SPEED_100;
  3659				break;
  3660			}
  3661	
  3662		if (max_speed == SPEED_1000) {
  3663			unsigned int snums = qe_get_num_of_snums();
  3664	
  3665			/* configure muram FIFOs for gigabit operation */
  3666			ug_info->uf_info.urfs = UCC_GETH_URFS_GIGA_INIT;
  3667			ug_info->uf_info.urfet = UCC_GETH_URFET_GIGA_INIT;
  3668			ug_info->uf_info.urfset = UCC_GETH_URFSET_GIGA_INIT;
  3669			ug_info->uf_info.utfs = UCC_GETH_UTFS_GIGA_INIT;
  3670			ug_info->uf_info.utfet = UCC_GETH_UTFET_GIGA_INIT;
  3671			ug_info->uf_info.utftt = UCC_GETH_UTFTT_GIGA_INIT;
  3672			ug_info->numThreadsTx = UCC_GETH_NUM_OF_THREADS_4;
  3673	
  3674			/* If QE's snum number is 46/76 which means we need to support
  3675			 * 4 UECs at 1000Base-T simultaneously, we need to allocate
  3676			 * more Threads to Rx.
  3677			 */
  3678			if ((snums == 76) || (snums == 46))
  3679				ug_info->numThreadsRx = UCC_GETH_NUM_OF_THREADS_6;
  3680			else
  3681				ug_info->numThreadsRx = UCC_GETH_NUM_OF_THREADS_4;
  3682		}
  3683	
  3684		if (netif_msg_probe(&debug))
  3685			pr_info("UCC%1d at 0x%8llx (irq = %d)\n",
  3686				ug_info->uf_info.ucc_num + 1,
  3687				(u64)ug_info->uf_info.regs,
  3688				ug_info->uf_info.irq);
  3689	
  3690		/* Create an ethernet device instance */
  3691		dev = devm_alloc_etherdev(&ofdev->dev, sizeof(*ugeth));
  3692		if (!dev) {
  3693			err = -ENOMEM;
  3694			goto err_deregister_fixed_link;
  3695		}
  3696	
  3697		ugeth = netdev_priv(dev);
  3698		spin_lock_init(&ugeth->lock);
  3699	
  3700		/* Create CQs for hash tables */
  3701		INIT_LIST_HEAD(&ugeth->group_hash_q);
  3702		INIT_LIST_HEAD(&ugeth->ind_hash_q);
  3703	
  3704		dev_set_drvdata(device, dev);
  3705	
  3706		/* Set the dev->base_addr to the gfar reg region */
  3707		dev->base_addr = (unsigned long)(ug_info->uf_info.regs);
  3708	
  3709		SET_NETDEV_DEV(dev, device);
  3710	
  3711		/* Fill in the dev structure */
  3712		uec_set_ethtool_ops(dev);
  3713		dev->netdev_ops = &ucc_geth_netdev_ops;
  3714		dev->watchdog_timeo = TX_TIMEOUT;
  3715		INIT_WORK(&ugeth->timeout_work, ucc_geth_timeout_work);
  3716		netif_napi_add(dev, &ugeth->napi, ucc_geth_poll);
  3717		dev->mtu = 1500;
  3718		dev->max_mtu = 1518;
  3719	
  3720		ugeth->msg_enable = netif_msg_init(debug.msg_enable, UGETH_MSG_DEFAULT);
  3721		ugeth->phy_interface = phy_interface;
  3722		ugeth->max_speed = max_speed;
  3723	
  3724		/* Carrier starts down, phylib will bring it up */
  3725		netif_carrier_off(dev);
  3726	
  3727		err = devm_register_netdev(&ofdev->dev, dev);
  3728		if (err) {
  3729			if (netif_msg_probe(ugeth))
  3730				pr_err("%s: Cannot register net device, aborting\n",
  3731				       dev->name);
  3732			goto err_deregister_fixed_link;
  3733		}
  3734	
  3735		err = of_get_ethdev_address(np, dev);
  3736		if (err == -EPROBE_DEFER)
  3737			goto err_deregister_fixed_link;
  3738	
  3739		ugeth->ug_info = ug_info;
  3740		ugeth->dev = device;
  3741		ugeth->ndev = dev;
  3742		ugeth->node = np;
  3743	
  3744		return 0;
  3745	
  3746	err_deregister_fixed_link:
  3747		if (of_phy_is_fixed_link(np))
  3748			of_phy_deregister_fixed_link(np);
  3749		of_node_put(ug_info->tbi_node);
  3750		of_node_put(ug_info->phy_node);
  3751		return err;
  3752	}
  3753	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

