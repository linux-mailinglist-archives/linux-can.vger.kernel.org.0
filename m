Return-Path: <linux-can+bounces-4485-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85253B44754
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 22:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43ED21670B3
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 20:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455EA281525;
	Thu,  4 Sep 2025 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EGcIRJgq"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8C1F872D;
	Thu,  4 Sep 2025 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017868; cv=none; b=jOlG187H2dtd0HOku73iXGey+cIrZeDjQWQRvQrlbdpdF+s5LaWKyHnEBKzwQnBdzwp1O02b/EksQXt0uTftge39XzGMgpbUTNiw88Bc1zEvt5tcmN1VKI37nq7kxTliS2W3MY3/DpgGXaeI6teN7uI4pgp7NXPBYunCAbU873g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017868; c=relaxed/simple;
	bh=mevtwclf1A6YuQKtSnCE5vgxn3iHjDiioyKpOoZocm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRpuxJOYWcD0Ldp/IMvmjqG3ACt2AKzR/CpSa+68RNqUzsRpr14CrLOObBL4w9sQVPeOU6NSmcizx21nrLhEzoEK2Wzx8Z15tbXO+vq6hwOQ2VJtyCAYE/DJuP8u58yHCVnH1sJtEonmFftBSep4KnDhzEojgowY/IRw2ova+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EGcIRJgq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757017867; x=1788553867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mevtwclf1A6YuQKtSnCE5vgxn3iHjDiioyKpOoZocm4=;
  b=EGcIRJgqEIqWWHXeesgjm2iE08Ewgi/7xOgJmVeJNZNx70bLkW6vpbu5
   CiFcNCOOUcPLcwqFC7X7hOuSNdu6qr08EVag30ktRtHadx7XAgcnGUwqv
   sBJ9KC5A7A618JRYaNEg4g3V+qs/mY434HutL3GaHRePI7NjNhl2VFnxX
   FiT90yymHCJs1tXsCtVeh01AqTVebyuU2mFlbYVUUhLg/DawyFA9/+NW8
   ems4eV8LFpkg9nyGC1HUewRnqllVBhwJKhiJz/h47ZhhFyhnyI3gYx3Wa
   yeqDVj2zaqDAfEBeiVFUnvKrgNsZ95zo/gEYCiRuef9QX+WddCiCgn3JZ
   w==;
X-CSE-ConnectionGUID: VGSc2MnuSf6Ihnu7yTrRgA==
X-CSE-MsgGUID: cSydlQqYTqanU0N7xxG46w==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59439383"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59439383"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 13:31:06 -0700
X-CSE-ConnectionGUID: cqgGuh6xSVChlP52I+EWMA==
X-CSE-MsgGUID: KHdVqKHsQOKbz78JUUbx6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="172346642"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 04 Sep 2025 13:31:01 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuGbX-0005sp-0D;
	Thu, 04 Sep 2025 20:30:49 +0000
Date: Fri, 5 Sep 2025 04:29:17 +0800
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
Subject: Re: [PATCH 11/21] can: netlink: add can_dtb_changelink()
Message-ID: <202509050404.ZLQknagH-lkp@intel.com>
References: <20250903-canxl-netlink-prep-v1-11-904bd6037cd9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-canxl-netlink-prep-v1-11-904bd6037cd9@kernel.org>

Hi Vincent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2fd4161d0d2547650d9559d57fc67b4e0a26a9e3]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/can-dev-move-struct-data_bittiming_params-to-linux-can-bittiming-h/20250903-170807
base:   2fd4161d0d2547650d9559d57fc67b4e0a26a9e3
patch link:    https://lore.kernel.org/r/20250903-canxl-netlink-prep-v1-11-904bd6037cd9%40kernel.org
patch subject: [PATCH 11/21] can: netlink: add can_dtb_changelink()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250905/202509050404.ZLQknagH-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509050404.ZLQknagH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509050404.ZLQknagH-lkp@intel.com/

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
>> drivers/net/can/dev/netlink.c:227:6: warning: variable 'data_bittiming' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     227 |         if (fd) {
         |             ^~
   drivers/net/can/dev/netlink.c:236:7: note: uninitialized use occurs here
     236 |         if (!data_bittiming)
         |              ^~~~~~~~~~~~~~
   drivers/net/can/dev/netlink.c:227:2: note: remove the 'if' if its condition is always true
     227 |         if (fd) {
         |         ^~~~~~~
     228 |                 data_bittiming = data[IFLA_CAN_DATA_BITTIMING];
     229 |                 data_tdc = data[IFLA_CAN_TDC];
     230 |                 dbt_params = &priv->fd;
     231 |                 tdc_mask = CAN_CTRLMODE_FD_TDC_MASK;
     232 |         } else {
         |           ~~~~~~
     233 |                 WARN_ON(1); /* Place holder for CAN XL */
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     234 |         }
         |         ~
   drivers/net/can/dev/netlink.c:219:31: note: initialize the variable 'data_bittiming' to silence this warning
     219 |         struct nlattr *data_bittiming, *data_tdc;
         |                                      ^
         |                                       = NULL
   2 warnings generated.


vim +227 drivers/net/can/dev/netlink.c

   215	
   216	static int can_dbt_changelink(struct net_device *dev, struct nlattr *data[],
   217				      bool fd, struct netlink_ext_ack *extack)
   218	{
   219		struct nlattr *data_bittiming, *data_tdc;
   220		struct can_priv *priv = netdev_priv(dev);
   221		struct data_bittiming_params *dbt_params;
   222		struct can_bittiming dbt;
   223		bool need_tdc_calc = false;
   224		u32 tdc_mask;
   225		int err;
   226	
 > 227		if (fd) {
   228			data_bittiming = data[IFLA_CAN_DATA_BITTIMING];
   229			data_tdc = data[IFLA_CAN_TDC];
   230			dbt_params = &priv->fd;
   231			tdc_mask = CAN_CTRLMODE_FD_TDC_MASK;
   232		} else {
   233			WARN_ON(1); /* Place holder for CAN XL */
   234		}
   235	
   236		if (!data_bittiming)
   237			return 0;
   238	
   239		/* Do not allow changing bittiming while running */
   240		if (dev->flags & IFF_UP)
   241			return -EBUSY;
   242	
   243		/* Calculate bittiming parameters based on data_bittiming_const
   244		 * if set, otherwise pass bitrate directly via do_set_bitrate().
   245		 * Bail out if neither is given.
   246		 */
   247		if (!dbt_params->data_bittiming_const && !dbt_params->do_set_data_bittiming &&
   248		    !dbt_params->data_bitrate_const)
   249			return -EOPNOTSUPP;
   250	
   251		memcpy(&dbt, nla_data(data_bittiming), sizeof(dbt));
   252		err = can_get_bittiming(dev, &dbt, dbt_params->data_bittiming_const,
   253					dbt_params->data_bitrate_const,
   254					dbt_params->data_bitrate_const_cnt, extack);
   255		if (err)
   256			return err;
   257	
   258		if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
   259			NL_SET_ERR_MSG_FMT(extack,
   260					   "CAN data bitrate %u bps surpasses transceiver capabilities of %u bps",
   261					   dbt.bitrate, priv->bitrate_max);
   262			return -EINVAL;
   263		}
   264	
   265		memset(&dbt_params->tdc, 0, sizeof(dbt_params->tdc));
   266		if (data[IFLA_CAN_CTRLMODE]) {
   267			struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
   268	
   269			need_tdc_calc = !(cm->mask & tdc_mask);
   270		}
   271		if (data_tdc) {
   272			/* TDC parameters are provided: use them */
   273			err = can_tdc_changelink(dbt_params, data_tdc, extack);
   274			if (err) {
   275				priv->ctrlmode &= ~tdc_mask;
   276				return err;
   277			}
   278		} else if (need_tdc_calc) {
   279			/* Neither of TDC parameters nor TDC flags are provided:
   280			 * do calculation
   281			 */
   282			can_calc_tdco(&dbt_params->tdc, dbt_params->tdc_const, &dbt,
   283				      &priv->ctrlmode, priv->ctrlmode_supported);
   284		} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
   285		   * turned off. TDC is disabled: do nothing
   286		   */
   287	
   288		memcpy(&dbt_params->data_bittiming, &dbt, sizeof(dbt));
   289	
   290		if (dbt_params->do_set_data_bittiming) {
   291			/* Finally, set the bit-timing registers */
   292			err = dbt_params->do_set_data_bittiming(dev);
   293			if (err)
   294				return err;
   295		}
   296	
   297		return 0;
   298	}
   299	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

