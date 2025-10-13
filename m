Return-Path: <linux-can+bounces-5174-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA39BD658D
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 23:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E3CD4E96B7
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 21:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F86D2E2840;
	Mon, 13 Oct 2025 21:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bm2FRenb"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF56238C0D;
	Mon, 13 Oct 2025 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760390526; cv=none; b=DS3ogoge5zrhTcFkf/CWMcfjSqmP6djyXBeeM2CdmHNo5VHstYmrMOZH9EPW1ici2hygXwwcHxsJ3+MIAIXo3ArslrUHfm7xhf8Fqfs8ONTI5siGmT7YEmg9sCwSIf/v6OnSUOG1G2Ke+fxq8qmqRM4LSsM7nfuNQOgKKWxcvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760390526; c=relaxed/simple;
	bh=6ntnqTOlJedOJehYxMVQ/LA8XCrMmJACkD0OGAldBQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmrZiye6Rvo5HM7eS1vR6Bl2Pk37sp2cFg73QDhnTsoOcjtoOcf3pLj73cFAEybFIEl30IFNDdmXNGHdX7SD5xOhDn7OZxx6kp6j6jWUhl/d72ZGUUKZWHoAcBKglNLH4CV+iJYnoEVFLakEysW7ThUrcq+3dn2N13bG5Tg6HHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bm2FRenb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760390524; x=1791926524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ntnqTOlJedOJehYxMVQ/LA8XCrMmJACkD0OGAldBQE=;
  b=bm2FRenbs5tg/5AJDlnUiUcpr0WSj7KF/lqwMGfEPOFBdsjEcZJvOjyx
   ltRbT9YQwYdOcTFvD76O0ErVwPZFlvaNPuhJVwJ9vXr+U4lpgixF2mY0s
   1gFXaqrHcxQnsCv6BUeWYn4/2+t658QUWeeJOE5FeiTJov1jZvRcMGAr3
   1CD/GEyIM+ts4Hp1RLcrH4TSD4X5TKaf2Fg135Xa0olDZRR+OQUBV8nCq
   e6195WqADG7DrdVfvrgRQRQ8oMXbBCRJLcvlq2kxrusLrQQ4px9HuSE6/
   udEqzW5ISKiGgCs+iqtOG7gqWYCQPfU8cORTral/gTkbsgTBfe2AgIMa4
   w==;
X-CSE-ConnectionGUID: OymNk6c8RkOk97lRfGshvA==
X-CSE-MsgGUID: MVIq9Ru5SQe/92xwTyJdfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62581839"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="62581839"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 14:22:04 -0700
X-CSE-ConnectionGUID: YYphuXD0SOStTWE89FxKlA==
X-CSE-MsgGUID: gWKK2VwqTlq10RJ+fdQ5ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="180857835"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 13 Oct 2025 14:22:02 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8PzT-00025H-1E;
	Mon, 13 Oct 2025 21:21:59 +0000
Date: Tue, 14 Oct 2025 05:21:34 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: oe-kbuild-all@lists.linux.dev, Vincent Mailhol <mailhol@kernel.org>,
	=?iso-8859-1?Q?St=E9phane?= Grosjean <stephane.grosjean@hms-networks.com>,
	Robert Nawrath <mbro1689@gmail.com>,
	Minh Le <minh.le.aj@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] can: calc_bittiming: add PWM calculation
Message-ID: <202510140553.qo3f0I9s-lkp@intel.com>
References: <20251013-canxl-netlink-v1-8-f422b7e2729f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-canxl-netlink-v1-8-f422b7e2729f@kernel.org>

Hi Vincent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cb6649f6217c0331b885cf787f1d175963e2a1d2]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/can-dev-can_dev_dropped_skb-drop-CAN-FD-skbs-if-FD-is-off/20251013-191232
base:   cb6649f6217c0331b885cf787f1d175963e2a1d2
patch link:    https://lore.kernel.org/r/20251013-canxl-netlink-v1-8-f422b7e2729f%40kernel.org
patch subject: [PATCH 8/9] can: calc_bittiming: add PWM calculation
config: riscv-randconfig-001-20251014 (https://download.01.org/0day-ci/archive/20251014/202510140553.qo3f0I9s-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251014/202510140553.qo3f0I9s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510140553.qo3f0I9s-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/can/dev.h:18,
                    from net/can/raw.c:53:
   include/linux/can/bittiming.h: In function 'can_calc_pwm':
>> include/linux/can/bittiming.h:204:1: warning: no return statement in function returning non-void [-Wreturn-type]
     204 | }
         | ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ARCH_HAS_ELF_CORE_EFLAGS
   Depends on [n]: BINFMT_ELF [=y] && ELF_CORE [=n]
   Selected by [y]:
   - RISCV [=y]


vim +204 include/linux/can/bittiming.h

   200	
   201	static inline int
   202	can_calc_pwm(struct net_device *dev, struct netlink_ext_ack *extack)
   203	{
 > 204	}
   205	#endif /* CONFIG_CAN_CALC_BITTIMING */
   206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

