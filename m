Return-Path: <linux-can+bounces-6250-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A/KKPoAcWmgbAAAu9opvQ
	(envelope-from <linux-can+bounces-6250-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 17:38:18 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DB05A00B
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BC37A26B61
	for <lists+linux-can@lfdr.de>; Wed, 21 Jan 2026 15:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF4147A0D6;
	Wed, 21 Jan 2026 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBATCApT"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC203C008E;
	Wed, 21 Jan 2026 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006992; cv=none; b=LO8rMUnWuUtSSwti7Jb6OeONWhxgax1Wfs0ebJEJ9GFpx+s/8BcBaMCFQJVenzA45Ng2f+mCDSYF1vAmcXgwzCc04f42/OAc+R4IPvXV3NUPwrr2/qO8wpOxKeVJPsKEoOHJwIh2y+eKOe6cWvO1Is/+V3AlE1sBL2e+p8X+jM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006992; c=relaxed/simple;
	bh=6LTNJOg2E8MaKxl1xCHKvy5jwJaoAeaRCG+agnK2yY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cauelZZt9Vxe1N2S6Ngyk56pN9PUC6O0OCtowIEN6zgP/vOXI8oNZsxdZ/QzD6kNXzZ833v6wdV4kJw/KXwh0koG6fEuZiHefFTFyu/7KzILCAWI6+VsehDWB1hU+nN6mzoBf8GZ9xTVVl+64wdkseFVeS647XzAvsJOW59p6sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBATCApT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769006991; x=1800542991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6LTNJOg2E8MaKxl1xCHKvy5jwJaoAeaRCG+agnK2yY8=;
  b=QBATCApTNclQtfCtM8qF18hoPqgLFjfIIFA223ORHq+oq9IdRg7CvTlj
   3Q8QEIkva4enhUdsOa6C/2Y2OsWLZRvc5StxdQIY89g79oyjWjJXf22Jt
   naZUCxEeLYte9Y/tHAyFEdy/KJcHvftCRe2C+RfO98JSkYK2E/O/TJeRC
   LzJX1MSUKwuP9dOFmC++NoJvL1cLk1janrALa4b5gEULV57GwlCovzGPD
   LDqGBmYaO2h70Gp7FRQ+H93MXsnBKZbp6wt0fAZX55tWfSD82YyaErerR
   LPs196vcVYskgL4yuaiEBaTpU4g6hgwiZUteVs1gAzk9+n0VhZ0zBQ/OL
   A==;
X-CSE-ConnectionGUID: xcqdNcMiS+69pLtcRktYbg==
X-CSE-MsgGUID: ZApQ79opR9+ZNqLaD6kxRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="74087018"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="74087018"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 06:49:48 -0800
X-CSE-ConnectionGUID: n3tKdQlJR0Kh2goUKtuKHg==
X-CSE-MsgGUID: FgiU5irsRD68qf9iNbOS1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="229432837"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 21 Jan 2026 06:49:41 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viZWc-00000000RJx-31ND;
	Wed, 21 Jan 2026 14:49:38 +0000
Date: Wed, 21 Jan 2026 22:49:09 +0800
From: kernel test robot <lkp@intel.com>
To: Josua Mayer <josua@solid-run.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Message-ID: <202601212215.qNGA0wVh-lkp@intel.com>
References: <20260121-rz-sdio-mux-v6-2-38aa39527928@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-rz-sdio-mux-v6-2-38aa39527928@solid-run.com>
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6250-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[solid-run.com,pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,01.org:url]
X-Rspamd-Queue-Id: 36DB05A00B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Josua,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Josua-Mayer/phy-can-transceiver-rename-temporary-helper-function-to-avoid-conflict/20260121-173607
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20260121-rz-sdio-mux-v6-2-38aa39527928%40solid-run.com
patch subject: [PATCH v6 2/7] mux: Add helper functions for getting optional and selected mux-state
config: i386-randconfig-001-20260121 (https://download.01.org/0day-ci/archive/20260121/202601212215.qNGA0wVh-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260121/202601212215.qNGA0wVh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601212215.qNGA0wVh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/mux/core.c:56 struct member 'mstate' not described in 'devm_mux_state_state'
>> Warning: drivers/mux/core.c:56 struct member 'mstate' not described in 'devm_mux_state_state'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

