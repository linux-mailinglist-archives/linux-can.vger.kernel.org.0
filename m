Return-Path: <linux-can+bounces-3682-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C845CAC2FF0
	for <lists+linux-can@lfdr.de>; Sat, 24 May 2025 15:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40497AAB5F
	for <lists+linux-can@lfdr.de>; Sat, 24 May 2025 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004E41DE3C4;
	Sat, 24 May 2025 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeuQqIKU"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766B77E9;
	Sat, 24 May 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748094966; cv=none; b=DPNLYyVYV0ybu7nYrOXxc+pm9ZuhD5iE5uDFXD4hS3uig5ZLOaTydQoSllOjvCrCKgg2aNVqWQRyZ5RcL/dFwK0CURQpCy0it454tzgLuCld2Vsfe4RLKUHiGNThHUaOHDKruUzvGa5eoXPPB+GQvcJv7DwtNpX9+RF5ei+V0DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748094966; c=relaxed/simple;
	bh=nT6QCH2t9NHJHSkhiqFg+TCciSaU2u+6fD4wOw0my9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCvO6AtVXaHK3fvhmjXhJ9KbYr5YyBXI7UUQKdWsDsoqhiGbTugB5q7sHrVWQIx+mpS3CnHVDiXJFzpkbn0DDTWR7YGG1v/LgAVPJ2sbl9c463Cle1A90o1Tl3jDo26MHU9j7O+YmhImw+t37XbwekIDpB0dPCAkPaLw2KJ+17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeuQqIKU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748094964; x=1779630964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nT6QCH2t9NHJHSkhiqFg+TCciSaU2u+6fD4wOw0my9A=;
  b=BeuQqIKU4IVeSsYLWnOLX3xzOXMOzW8y/2argsWJwzj2XdMFLYQdNcAj
   zcDeHC8V1g/RVjm2MkI/4AyFu48x+cIY/L7b97Wmxt55/WIS8Lwv+L6Oi
   gaicJqAs+B0g1DuWpK0NTVQ0Cwg33M+8Io96DNrhqBb78suTaz5Httwl/
   kvLoxEbQy1g8EZLq0oKm3Z7wUdVRJniQcTAAmaYQ7Frbi8X081y/4j62v
   AudbYNq7dyLHfynlBI1Y2cJOGPGF3CGopOdg0DZP9nuio8VgRQX+EsBU8
   1JnCbxY3PnYvg2aa8YKBIBTb+8zvhfnz86DSfEh9nVff0TF6wtk8xNVMM
   w==;
X-CSE-ConnectionGUID: Wg4C2iknSvi4kFyalkIRoA==
X-CSE-MsgGUID: QIYSUhqtTHym9wbsn/ZXoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11443"; a="52755537"
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="52755537"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 06:56:04 -0700
X-CSE-ConnectionGUID: xlrkOS08SuWnWMtbmXAaIA==
X-CSE-MsgGUID: w/KrP6sOS9GvTY79VoUOGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="141440807"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 May 2025 06:56:00 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uIpLx-000REG-2q;
	Sat, 24 May 2025 13:55:57 +0000
Date: Sat, 24 May 2025 21:55:56 +0800
From: kernel test robot <lkp@intel.com>
To: Elaine Zhang <zhangqing@rock-chips.com>, mkl@pengutronix.de,
	kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	cl@rock-chips.com, kever.yang@rock-chips.com
Cc: oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/4] net: can: rockchip: add can for RK3576 Soc
Message-ID: <202505242132.Mau7vNde-lkp@intel.com>
References: <20250523075422.4010083-4-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523075422.4010083-4-zhangqing@rock-chips.com>

Hi Elaine,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkl-can-next/testing]
[also build test WARNING on robh/for-next linus/master v6.15-rc7 next-20250523]
[cannot apply to rockchip/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elaine-Zhang/dt-bindings-can-rockchip_canfd-add-rk3576-CAN-FD-controller/20250523-211340
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
patch link:    https://lore.kernel.org/r/20250523075422.4010083-4-zhangqing%40rock-chips.com
patch subject: [PATCH v5 3/4] net: can: rockchip: add can for RK3576 Soc
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250524/202505242132.Mau7vNde-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250524/202505242132.Mau7vNde-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505242132.Mau7vNde-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/can/rockchip/rockchip_canfd-tx.c: In function 'rkcanfd_handle_rk3576_tx_int':
>> drivers/net/can/rockchip/rockchip_canfd-tx.c:173:25: warning: variable 'skb' set but not used [-Wunused-but-set-variable]
     173 |         struct sk_buff *skb;
         |                         ^~~
   In file included from drivers/net/can/rockchip/rockchip_canfd-tx.c:9:
   drivers/net/can/rockchip/rockchip_canfd.h: At top level:
   drivers/net/can/rockchip/rockchip_canfd.h:699:29: warning: 'priv' defined but not used [-Wunused-variable]
     699 | static struct rkcanfd_priv *priv;
         |                             ^~~~


vim +/skb +173 drivers/net/can/rockchip/rockchip_canfd-tx.c

   168	
   169	int rkcanfd_handle_rk3576_tx_int(struct rkcanfd_priv *priv)
   170	{
   171		struct net_device_stats *stats = &priv->ndev->stats;
   172		unsigned int tx_tail;
 > 173		struct sk_buff *skb;
   174		unsigned int frame_len = 0;
   175	
   176		tx_tail = rkcanfd_get_tx_tail(priv);
   177		skb = priv->can.echo_skb[tx_tail];
   178	
   179		/* Manual handling of CAN Bus Error counters. See
   180		 * rkcanfd_get_corrected_berr_counter() for detailed
   181		 * explanation.
   182		 */
   183		if (priv->bec.txerr)
   184			priv->bec.txerr--;
   185	
   186		stats->tx_bytes +=
   187			can_rx_offload_get_echo_skb_queue_tail(&priv->offload,
   188							       tx_tail, &frame_len);
   189		stats->tx_packets++;
   190		WRITE_ONCE(priv->tx_tail, priv->tx_tail + 1);
   191		netif_subqueue_completed_wake(priv->ndev, 0, 1, frame_len,
   192					      rkcanfd_get_effective_tx_free(priv),
   193					      RKCANFD_TX_START_THRESHOLD);
   194		return 0;
   195	}
   196	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

