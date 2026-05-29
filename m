Return-Path: <linux-can+bounces-7728-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGhUCkHzGGoMpQgAu9opvQ
	(envelope-from <linux-can+bounces-7728-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 29 May 2026 04:00:33 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A5D5FC3DB
	for <lists+linux-can@lfdr.de>; Fri, 29 May 2026 04:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9C37301B243
	for <lists+linux-can@lfdr.de>; Fri, 29 May 2026 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8666134C990;
	Fri, 29 May 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnY/y2FJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82803612D5;
	Fri, 29 May 2026 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780020027; cv=none; b=REv62zTBtWNTmtHhwTbzVuMiIgB0lFCcz4GOFiabgDlL7C0WVi92EGo5ZyQlxOnuFkorJzW59dJKKoGzgH5YpvN1HrRpqEdG+ZTqZE+ZzK2SMbkbdafU2VWLHQ16Yxme2a1GaSG4gpJJDV9cTZ0i/UZGQFjNXK2WW4EkAYEZLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780020027; c=relaxed/simple;
	bh=v7SUI5JPIDJF7swbx4MsnsnbEBHDeSvQQx/6or3YF0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJIkSZlRgz0ligWimFkukb6aRCBBqyXuQOziZql2bNwSVUJE32WulJ35hMcUG3QCkykfMXVV0ZZ3+C6N8DfPena5KBiM84Zrp8dza8SLqaFMGHXHGkixLXJipm+tqcdRX2v5qRrAcHmUlA9jNOuvzxc6y9h0pmE/Rz7Kgnf6AjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnY/y2FJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780020027; x=1811556027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v7SUI5JPIDJF7swbx4MsnsnbEBHDeSvQQx/6or3YF0s=;
  b=hnY/y2FJ1D0BXYK+8sl0UA7LSsmHRv8GoRg5oA/NYSbsSeSJoX6pyaSx
   3RyDjcej+luRxEkPasX8N+1Lf+NaAMRZ8sTawjxsGDcwcQ7ddXfOr0Lyb
   1A38L7JeeJILbu11z3KFbrJSDjbGMhQ1BnaxqDyNihWA9icv8LsL8EMVO
   Zv1imdKMDTd8ztkqvim60HGUqXq/Uc2DbYDfU9j/VmSRAb4csJkMz9vc8
   C95AmieFMKV4YsF7NiY9cTSt7wZWLMyhcOce9JXnY3peCSD+n+sPdX6IM
   qc0Zr09orX4xf/gXXNYPbyvW2DqtroH4lmkT2dL4J0OsNrDiLxg4/4ymw
   g==;
X-CSE-ConnectionGUID: 7H7NBzrFQGu+5O9vpJcaBg==
X-CSE-MsgGUID: uv0FfuvCR5+FZ4r5qHbufA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="81054079"
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="81054079"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 19:00:26 -0700
X-CSE-ConnectionGUID: KAmQrINJTRiB8jymJW2/UA==
X-CSE-MsgGUID: gegDXNHeQG26tWvke58ANw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,174,1774335600"; 
   d="scan'208";a="236364381"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 28 May 2026 19:00:23 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSmWK-000000006fW-3PRA;
	Fri, 29 May 2026 02:00:20 +0000
Date: Fri, 29 May 2026 10:00:00 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] can: flexcan: Drop unused platform driver data
Message-ID: <202605290912.Y77fySxN-lkp@intel.com>
References: <20260528094540.1867783-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528094540.1867783-2-u.kleine-koenig@baylibre.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-7728-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-can@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 41A5D5FC3DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e7d700e14934e68f86338c5610cf2ae76798b663]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig-The-Capable-Hub/can-flexcan-Drop-unused-platform-driver-data/20260528-181620
base:   e7d700e14934e68f86338c5610cf2ae76798b663
patch link:    https://lore.kernel.org/r/20260528094540.1867783-2-u.kleine-koenig%40baylibre.com
patch subject: [PATCH v1] can: flexcan: Drop unused platform driver data
config: i386-buildonly-randconfig-002-20260529 (https://download.01.org/0day-ci/archive/20260529/202605290912.Y77fySxN-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260529/202605290912.Y77fySxN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605290912.Y77fySxN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/can/flexcan/flexcan-core.c:296:42: warning: unused variable 'fsl_mcf5441x_devtype_data' [-Wunused-const-variable]
     296 | static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/fsl_mcf5441x_devtype_data +296 drivers/net/can/flexcan/flexcan-core.c

4b702878afc375 drivers/net/can/flexcan.c              Marc Kleine-Budde 2020-09-22  295  
d9cead75b1c66b drivers/net/can/flexcan.c              Angelo Dureghello 2021-07-02 @296  static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
d9cead75b1c66b drivers/net/can/flexcan.c              Angelo Dureghello 2021-07-02  297  	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
c5c88591040ee7 drivers/net/can/flexcan/flexcan-core.c Marc Kleine-Budde 2022-01-07  298  		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
d945346db1ef41 drivers/net/can/flexcan/flexcan-core.c Marc Kleine-Budde 2022-08-11  299  		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
d945346db1ef41 drivers/net/can/flexcan/flexcan-core.c Marc Kleine-Budde 2022-08-11  300  		FLEXCAN_QUIRK_SUPPORT_RX_FIFO,
d9cead75b1c66b drivers/net/can/flexcan.c              Angelo Dureghello 2021-07-02  301  };
d9cead75b1c66b drivers/net/can/flexcan.c              Angelo Dureghello 2021-07-02  302  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

