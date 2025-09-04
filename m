Return-Path: <linux-can+bounces-4484-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2345B445BD
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 20:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CEF1CC1227
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 18:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7790A254855;
	Thu,  4 Sep 2025 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jd3hjVEO"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65BE229B2E;
	Thu,  4 Sep 2025 18:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011670; cv=none; b=PEmOEJjgw7rbwhQaZUH3wvYWFcicS94/KCyu7dSJDXzoDUV2ez0XKeCdx1LE/mNgjXccfdqWzH43TCNGoyAKIRXKIvp5kgfuLhWS0wXDxXXtPg98PN4RN4ArlknlRMoOLNgldmpFlfGgVjtAST9rwZiJDpYNC3bal25yjt/gK28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011670; c=relaxed/simple;
	bh=KzUGxTop9JhPXBG4T/1leWl65MjxiWSzlGCzfJwjlsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A12a3NQCpUYr2bBk/R0B2rQkPivTMSZHBVYXhp4vRE4uqjumSts0JmSkCvgKQQqezi68l2OIOH2eM/x1xiuWRGvOk9nqy8d7qa1fcF/6s5k1ON31ytYL9wfiM+clCBbFC3IHOc+jhACwDYUSvQhudTK4cVGbp7icfosPovEC+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jd3hjVEO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757011669; x=1788547669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KzUGxTop9JhPXBG4T/1leWl65MjxiWSzlGCzfJwjlsQ=;
  b=Jd3hjVEOYEJvilCPA2LjzrYVtbtu62ros5qiwyfKyp+54bCkIAERuZfm
   +hNabt4h1eJobfYFTrCN1VaPL0q4MXyl2UZqCdT+ARtXZmVk/69tHiDfl
   SSxZtRK97Uk0AbKFFPW2ITo2MU+qK5tJ++6J1tV2dap0bwDOkk6U4CLww
   UKzNLZhdeYb+NEzYDA3TBuc9ycl5WPSTAEopKYAt1C00KhPgeMUvOKniq
   yqnD1jmZTECN6bIHzm6Mm228ziv3B8jHN8OH+q3xo+u01UGv2DnEq9E4C
   pKqqvpYqo+9ZLJZ1nzcaUGcCWVdfxVQhutgpf8gDlJtGkp4rjPJTnIHgn
   g==;
X-CSE-ConnectionGUID: 8gdnTTCVRSuwRx30GBU5Dg==
X-CSE-MsgGUID: uK5OidPgRW2O+/88d2wkyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="69978547"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="69978547"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 11:47:48 -0700
X-CSE-ConnectionGUID: UM8whEFzQOK8xu7mfj6JoQ==
X-CSE-MsgGUID: SZWJjCQXSYizn4utPvz7kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="176091002"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 04 Sep 2025 11:47:45 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuEzm-0005dr-13;
	Thu, 04 Sep 2025 18:47:42 +0000
Date: Fri, 5 Sep 2025 02:46:11 +0800
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
Subject: Re: [PATCH 06/21] can: netlink: add can_validate_databittiming()
Message-ID: <202509050259.NjPdQyAD-lkp@intel.com>
References: <20250903-canxl-netlink-prep-v1-6-904bd6037cd9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-canxl-netlink-prep-v1-6-904bd6037cd9@kernel.org>

Hi Vincent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2fd4161d0d2547650d9559d57fc67b4e0a26a9e3]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Mailhol/can-dev-move-struct-data_bittiming_params-to-linux-can-bittiming-h/20250903-170807
base:   2fd4161d0d2547650d9559d57fc67b4e0a26a9e3
patch link:    https://lore.kernel.org/r/20250903-canxl-netlink-prep-v1-6-904bd6037cd9%40kernel.org
patch subject: [PATCH 06/21] can: netlink: add can_validate_databittiming()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250905/202509050259.NjPdQyAD-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509050259.NjPdQyAD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509050259.NjPdQyAD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/can/dev/netlink.c:111:6: warning: variable 'is_on' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
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
   1 warning generated.


vim +111 drivers/net/can/dev/netlink.c

   101	
   102	static int can_validate_databittiming(struct nlattr *data[],
   103					      struct netlink_ext_ack *extack,
   104					      int ifla_can_data_bittiming, u32 flags)
   105	{
   106		struct nlattr *data_tdc;
   107		u32 tdc_flags;
   108		bool is_on;
   109		int err;
   110	
 > 111		if (ifla_can_data_bittiming == IFLA_CAN_DATA_BITTIMING) {
   112			data_tdc = data[IFLA_CAN_TDC];
   113			tdc_flags = flags & CAN_CTRLMODE_FD_TDC_MASK;
   114			is_on = flags & CAN_CTRLMODE_FD;
   115		} else {
   116			WARN_ON(1); /* Place holder for CAN XL */
   117		}
   118	
   119		if (is_on) {
   120			if (!data[IFLA_CAN_BITTIMING] || !data[ifla_can_data_bittiming])
   121				return -EOPNOTSUPP;
   122		}
   123	
   124		if (data[ifla_can_data_bittiming] || data_tdc) {
   125			if (!is_on)
   126				return -EOPNOTSUPP;
   127		}
   128	
   129		err = can_validate_bittiming(data, extack, ifla_can_data_bittiming);
   130		if (err)
   131			return err;
   132	
   133		err = can_validate_tdc(data_tdc, extack, tdc_flags);
   134		if (err)
   135			return err;
   136	
   137		return 0;
   138	}
   139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

