Return-Path: <linux-can+bounces-3681-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB918AC2F35
	for <lists+linux-can@lfdr.de>; Sat, 24 May 2025 13:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454FE4A26FA
	for <lists+linux-can@lfdr.de>; Sat, 24 May 2025 11:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A86F1E1E1F;
	Sat, 24 May 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UmwZttNc"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08251E00B4;
	Sat, 24 May 2025 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748084392; cv=none; b=j6soKpSmMi5AW5w5du0aeNeAsHMrjg0JCIWdA1KHH6XfWYwdd5X0RdTyyCma7HLhdTzCjBp0j/GFot1I7B7mHhDVOvLX2gbEwIMqA3buQhyelW1IEvIRbQRjtcPiIXUIMlBiWcrZL7Uj/c0bd9vLaj4CHZkQJ3xExax8kOQ+LQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748084392; c=relaxed/simple;
	bh=am5CZEL1GEppvkfskPtSLJbGMlXiDh88jJ3Sw8xP1P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aReJM3QjIighwV4kMg1SUgVY4gkGFeQW5oiT4Kq85LtOzBjfLRpjbk4NLTUgoxUNIfmIMpqIaCTQu3gG6PDcJH591zjO1GTTWmHCTcfd+FpHDG7TpUAOXf00yJ0AyihVsiX9IwUFV4+DmMAipkPaBDP94C0v3yBTBeCH8LQ2Gjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UmwZttNc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748084391; x=1779620391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=am5CZEL1GEppvkfskPtSLJbGMlXiDh88jJ3Sw8xP1P4=;
  b=UmwZttNcnl2Zt83w+7d6ouTmtfLt1x45j1Y2Igb/NvLCrGnJqoSq3JFa
   Pvsu6Lx0HCXh6lqWLwceJfvpMyGW+9FmfLpSkSp0WzQC5Sktok4knD6A5
   CN/he9kKSM1TswA930TD6bhtFq7/2DI8qDI7j7g+b+k60Ig04/XF7YunL
   wbCsryUxR8nC0MJ7r7rHK7cEf1Iofq2fjH2zJlZTCAHdegeC/9yXgHoO/
   x09sw0y7fScabf7WVaROIt2mblox+iS9L6uNezTWLuiKkR+DJ708NL3s7
   Z1ktNIZnTEz9Mt5w1gNMRGsWRQaZs0FemcjTaHXZLPWLwkTw07UHZAnud
   g==;
X-CSE-ConnectionGUID: ggJqbRMvRbCc9CDJ9DxGrQ==
X-CSE-MsgGUID: TmHZa4QuSy+DoxFgJh5teg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61532494"
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="61532494"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 03:59:50 -0700
X-CSE-ConnectionGUID: aEIjQGFITtieISE43Lb8Wg==
X-CSE-MsgGUID: dDtghmnrRTmokGr6y73H6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="146509247"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 24 May 2025 03:59:46 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uImbQ-000R8u-1K;
	Sat, 24 May 2025 10:59:44 +0000
Date: Sat, 24 May 2025 18:59:35 +0800
From: kernel test robot <lkp@intel.com>
To: Elaine Zhang <zhangqing@rock-chips.com>, mkl@pengutronix.de,
	kernel@pengutronix.de, mailhol.vincent@wanadoo.fr, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	cl@rock-chips.com, kever.yang@rock-chips.com
Cc: oe-kbuild-all@lists.linux.dev, linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/4] net: can: rockchip: Refactor the
 rkcanfd_devtype_data structure
Message-ID: <202505241818.tw02Bia6-lkp@intel.com>
References: <20250523075422.4010083-3-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523075422.4010083-3-zhangqing@rock-chips.com>

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
patch link:    https://lore.kernel.org/r/20250523075422.4010083-3-zhangqing%40rock-chips.com
patch subject: [PATCH v5 2/4] net: can: rockchip: Refactor the rkcanfd_devtype_data structure
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20250524/202505241818.tw02Bia6-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250524/202505241818.tw02Bia6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505241818.tw02Bia6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/can/rockchip/rockchip_canfd-core.c:25:
>> drivers/net/can/rockchip/rockchip_canfd.h:439:29: warning: 'priv' defined but not used [-Wunused-variable]
     439 | static struct rkcanfd_priv *priv;
         |                             ^~~~


vim +/priv +439 drivers/net/can/rockchip/rockchip_canfd.h

   438	
 > 439	static struct rkcanfd_priv *priv;
   440	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

