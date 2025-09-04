Return-Path: <linux-can+bounces-4486-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0237FB44900
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 00:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5B57B58D1
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 22:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7391C2D7DFF;
	Thu,  4 Sep 2025 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBJnOU+n"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12B2D7DC8;
	Thu,  4 Sep 2025 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023365; cv=none; b=GgMMLyBvEshRXk5/yvid5PS5BEruXZV6qgDV96aakGKGRrhhdbXwtGaTB4DT5MydP7rfMnS7atSStCl3JkpgiyENdYpV+LOWlq9jf9n8jDT/pr5yYck3kaXqZstEZ/K3HL+7AuKptiMft9+SGrBnM73pZvNzqvKMj4XfLi2S5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023365; c=relaxed/simple;
	bh=YGBOBYVHcwskEjwSDQ07AodkAK4jg+Ii7MFxCwoqKqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABSMP8CEqO2tKaFQGzXFFgSkEo9lCK5uog7vFCEy3yTcWfLhV5K3A6Uyi1lHqq+0Vm9XlrTKhZl6cVx4iffzFgR8DAXeiui5MyvjSYYOvQPSaEgYg57Mb97ZyjwD52hjhoJ53/OJ99goVnD5tps6O+H2uhNHlzyO7VIeXbe2Dv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBJnOU+n; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757023364; x=1788559364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YGBOBYVHcwskEjwSDQ07AodkAK4jg+Ii7MFxCwoqKqw=;
  b=aBJnOU+nz8c2pNAdcOmp46inGxoL/Pz+9Tj57XeBQ4bd+17DmXK5BzYP
   8Xs3VDveSxnyMwmozBvyX3/2sAyllLkTRf2HdJYEAXoJ1HP2n1XflJxJd
   DnHozAy2DpEOdfWH/deRCu8tXh+Gy9qzYm6cxQvuCwZi7Iu/kM+VWoUw3
   HD7kpOuUE2fiXUX+64upKEB5cwanZwSPQkDtZJDB5suhQFDS7rRQYSr/c
   +tJtItvgeWhWeoKHMx0qoChIUIzHgLkLkjo7SkgRudCIdThi020g8DfjP
   j4sfilJm0xWmdnyMCA6YZGqJcz2nDHOmD//d+6mNO3X3m60dE9E71AJsw
   A==;
X-CSE-ConnectionGUID: GXyamMTqSCqlt2NYBj8Kqw==
X-CSE-MsgGUID: 5JbHSfMCRWOUTwlrP9pcgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="70805160"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="70805160"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 15:02:43 -0700
X-CSE-ConnectionGUID: L94f7WjeSmWfsbvS5lsy2g==
X-CSE-MsgGUID: 1y1YUecNQs6jp+xNNArMdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="177260579"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 04 Sep 2025 15:02:40 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuI29-0005yR-24;
	Thu, 04 Sep 2025 22:02:37 +0000
Date: Fri, 5 Sep 2025 06:01:29 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Vincent Mailhol <mailhol@kernel.org>,
	=?iso-8859-1?Q?St=E9phane?= Grosjean <stephane.grosjean@hms-networks.com>,
	Robert Nawrath <mbro1689@gmail.com>,
	Minh Le <minh.le.aj@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/21] can: netlink: make can_tdc_fill_info() FD agnostic
Message-ID: <202509050541.1FKRbqOi-lkp@intel.com>
References: <20250903-canxl-netlink-prep-v1-18-904bd6037cd9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-canxl-netlink-prep-v1-18-904bd6037cd9@kernel.org>

Hi Vincent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2fd4161d0d2547650d9559d57fc67b4e0a26a9e3]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/can-dev-move-struct-data_bittiming_params-to-linux-can-bittiming-h/20250903-170807
base:   2fd4161d0d2547650d9559d57fc67b4e0a26a9e3
patch link:    https://lore.kernel.org/r/20250903-canxl-netlink-prep-v1-18-904bd6037cd9%40kernel.org
patch subject: [PATCH 18/21] can: netlink: make can_tdc_fill_info() FD agnostic
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250905/202509050541.1FKRbqOi-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509050541.1FKRbqOi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509050541.1FKRbqOi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/can/dev/netlink.c:111:6: warning: variable 'is_on' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     111 |         if (ifla_can_data_bittiming == IFLA_CAN_DATA_BITTIMING) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/can/dev/netlink.c:119:6: note: uninitialized use occurs here
     119 |         if (is_on) {
         |             ^~~~~
   drivers/net/can/dev/netlink.c:111:2: note: remove the 'if' if its condition is always true
     111 |         if (ifla_can_data_bittiming == IFLA_CAN_DATA_BITTIMING) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     112 |                 data_tdc = data[IFLA_CAN_TDC];
     113 |                 tdc_flags = flags & CAN_CTRLMODE_FD_TDC_MASK;
     114 |                 is_on = flags & CAN_CTRLMODE_FD;
     115 |         } else {
         |           ~~~~~~
     116 |                 WARN_ON(1); /* Place holder for CAN XL */
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     117 |         }
         |         ~
   drivers/net/can/dev/netlink.c:108:12: note: initialize the variable 'is_on' to silence this warning
     108 |         bool is_on;
         |                   ^
         |                    = 0
   drivers/net/can/dev/netlink.c:281:6: warning: variable 'data_bittiming' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     281 |         if (fd) {
         |             ^~
   drivers/net/can/dev/netlink.c:290:7: note: uninitialized use occurs here
     290 |         if (!data_bittiming)
         |              ^~~~~~~~~~~~~~
   drivers/net/can/dev/netlink.c:281:2: note: remove the 'if' if its condition is always true
     281 |         if (fd) {
         |         ^~~~~~~
     282 |                 data_bittiming = data[IFLA_CAN_DATA_BITTIMING];
     283 |                 data_tdc = data[IFLA_CAN_TDC];
     284 |                 dbt_params = &priv->fd;
     285 |                 tdc_mask = CAN_CTRLMODE_FD_TDC_MASK;
     286 |         } else {
         |           ~~~~~~
     287 |                 WARN_ON(1); /* Place holder for CAN XL */
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     288 |         }
         |         ~
   drivers/net/can/dev/netlink.c:273:31: note: initialize the variable 'data_bittiming' to silence this warning
     273 |         struct nlattr *data_bittiming, *data_tdc;
         |                                      ^
         |                                       = NULL
>> drivers/net/can/dev/netlink.c:591:6: warning: variable 'dbt_params' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     591 |         if (ifla_can_tdc == IFLA_CAN_TDC) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/can/dev/netlink.c:598:14: note: uninitialized use occurs here
     598 |         tdc_const = dbt_params->tdc_const;
         |                     ^~~~~~~~~~
   drivers/net/can/dev/netlink.c:591:2: note: remove the 'if' if its condition is always true
     591 |         if (ifla_can_tdc == IFLA_CAN_TDC) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     592 |                 dbt_params = &priv->fd;
     593 |                 tdc_is_enabled = can_fd_tdc_is_enabled(priv);
     594 |                 tdc_manual = priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL;
     595 |         } else {
         |           ~~~~~~
     596 |                 WARN_ON(1); /* Place holder for CAN XL */
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     597 |         }
         |         ~
   drivers/net/can/dev/netlink.c:585:42: note: initialize the variable 'dbt_params' to silence this warning
     585 |         struct data_bittiming_params *dbt_params;
         |                                                 ^
         |                                                  = NULL
   3 warnings generated.


vim +591 drivers/net/can/dev/netlink.c

   580	
   581	static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev,
   582				     int ifla_can_tdc)
   583	{
   584		struct can_priv *priv = netdev_priv(dev);
   585		struct data_bittiming_params *dbt_params;
   586		const struct can_tdc_const *tdc_const;
   587		struct can_tdc *tdc;
   588		struct nlattr *nest;
   589		bool tdc_is_enabled, tdc_manual;
   590	
 > 591		if (ifla_can_tdc == IFLA_CAN_TDC) {
   592			dbt_params = &priv->fd;
   593			tdc_is_enabled = can_fd_tdc_is_enabled(priv);
   594			tdc_manual = priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL;
   595		} else {
   596			WARN_ON(1); /* Place holder for CAN XL */
   597		}
   598		tdc_const = dbt_params->tdc_const;
   599		tdc = &dbt_params->tdc;
   600	
   601		if (!tdc_const)
   602			return 0;
   603	
   604		nest = nla_nest_start(skb, ifla_can_tdc);
   605		if (!nest)
   606			return -EMSGSIZE;
   607	
   608		if (tdc_manual &&
   609		    (nla_put_u32(skb, IFLA_CAN_TDC_TDCV_MIN, tdc_const->tdcv_min) ||
   610		     nla_put_u32(skb, IFLA_CAN_TDC_TDCV_MAX, tdc_const->tdcv_max)))
   611			goto err_cancel;
   612		if (nla_put_u32(skb, IFLA_CAN_TDC_TDCO_MIN, tdc_const->tdco_min) ||
   613		    nla_put_u32(skb, IFLA_CAN_TDC_TDCO_MAX, tdc_const->tdco_max))
   614			goto err_cancel;
   615		if (tdc_const->tdcf_max &&
   616		    (nla_put_u32(skb, IFLA_CAN_TDC_TDCF_MIN, tdc_const->tdcf_min) ||
   617		     nla_put_u32(skb, IFLA_CAN_TDC_TDCF_MAX, tdc_const->tdcf_max)))
   618			goto err_cancel;
   619	
   620		if (tdc_is_enabled) {
   621			u32 tdcv;
   622			int err = -EINVAL;
   623	
   624			if (tdc_manual) {
   625				tdcv = tdc->tdcv;
   626				err = 0;
   627			} else if (dbt_params->do_get_auto_tdcv) {
   628				err = dbt_params->do_get_auto_tdcv(dev, &tdcv);
   629			}
   630			if (!err && nla_put_u32(skb, IFLA_CAN_TDC_TDCV, tdcv))
   631				goto err_cancel;
   632			if (nla_put_u32(skb, IFLA_CAN_TDC_TDCO, tdc->tdco))
   633				goto err_cancel;
   634			if (tdc_const->tdcf_max &&
   635			    nla_put_u32(skb, IFLA_CAN_TDC_TDCF, tdc->tdcf))
   636				goto err_cancel;
   637		}
   638	
   639		nla_nest_end(skb, nest);
   640		return 0;
   641	
   642	err_cancel:
   643		nla_nest_cancel(skb, nest);
   644		return -EMSGSIZE;
   645	}
   646	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

