Return-Path: <linux-can+bounces-6510-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO+FGZ1CiWmK5QQAu9opvQ
	(envelope-from <linux-can+bounces-6510-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 03:12:45 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2D910AFDC
	for <lists+linux-can@lfdr.de>; Mon, 09 Feb 2026 03:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FB9F30086E7
	for <lists+linux-can@lfdr.de>; Mon,  9 Feb 2026 02:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60E429A9E9;
	Mon,  9 Feb 2026 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlJBJrQk"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE828980F;
	Mon,  9 Feb 2026 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770603161; cv=none; b=DiTJajRitACkuDKNj0ACveyoFLDk7B4kRgjH4PIJ6aFL2Hn4/DXIE1AJOqf741u0OjHB0DKW+CQc7YqzdwIWLtQLgD54z/9+9HCHR3UMcnpj+peOKojQjGmDMgfEipDuQ0qmksaTfRBm+LZ6fPZ82MmB9LhBAnCljIx59j4UqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770603161; c=relaxed/simple;
	bh=li3Bz7MB9Db5p57EW1iDijoV/yjuamNyqKYmNRYo6WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WS9cyIawqVPP8IspgCr+K8sAnSrRvDdKOEgOGK27cmv6kY/+0EyjJjt/VNEIFLMdnflrh3Fi0fWfgB7syrcWDyHs5hrEAnFrSFaO8r5g2KCrpj8sxKhnRGZnLErnKUNL+rlVqgtHSKl/OoBpkUpC7t4piPRxI+wElnzSt09KCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlJBJrQk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770603162; x=1802139162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=li3Bz7MB9Db5p57EW1iDijoV/yjuamNyqKYmNRYo6WM=;
  b=IlJBJrQkxZbj8WkChIrfk0TnaCZAvIYOoYJLwNiQV/YznaavQu5CSQjQ
   5xi/q0Nq0XiYny41zGD2/PfjzpW9Vnusxd8yUyZ0GOQIuCA9tH6fniigS
   c1BcMUowNpK/ZU/oUyWze7BFrBf/YxHK3W/Ntf22L5mLhXUy/ODvZT1tW
   g2b6jhtn5rU7slGrVnkYHyMcyjoB2Srh+vbLEdJ/UIV2irqHJ2QHYTlnM
   FZuCKTuCP4vAWWOv4MgTxwuwBW+otcQO1SonHOUcGe6K8zxVwxutqZBmo
   gdzfnUTPpkU9IWr3YrPvQz1zB0+kf3BZp558g3tbenTed7bTfg02lpx7D
   A==;
X-CSE-ConnectionGUID: TbGAjXA/RPWtLaep2YpmVQ==
X-CSE-MsgGUID: ir+wEO6EQf6SK6O791MNkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83152685"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83152685"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 18:12:41 -0800
X-CSE-ConnectionGUID: O3GWCk0XQz68cDcF85WjTA==
X-CSE-MsgGUID: h2jjiJw6QHyTvzyFF1iPiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="211241339"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Feb 2026 18:12:34 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpGlL-00000000mVm-0bVo;
	Mon, 09 Feb 2026 02:12:31 +0000
Date: Mon, 9 Feb 2026 10:12:03 +0800
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
Subject: Re: [PATCH v9 7/7] mmc: host: renesas_sdhi_core: support selecting
 an optional mux
Message-ID: <202602091037.wNIGJdbh-lkp@intel.com>
References: <20260208-rz-sdio-mux-v9-7-9a3be13c1280@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208-rz-sdio-mux-v9-7-9a3be13c1280@solid-run.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6510-lists,linux-can=lfdr.de];
	FREEMAIL_TO(0.00)[solid-run.com,pengutronix.de,kernel.org,linaro.org,axentia.se,iki.fi,kemnade.info,baylibre.com,atomide.com,gmail.com,ti.com,glider.be,sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.959];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 0E2D910AFDC
X-Rspamd-Action: no action

Hi Josua,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Josua-Mayer/phy-can-transceiver-rename-temporary-helper-function-to-avoid-conflict/20260208-234345
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20260208-rz-sdio-mux-v9-7-9a3be13c1280%40solid-run.com
patch subject: [PATCH v9 7/7] mmc: host: renesas_sdhi_core: support selecting an optional mux
config: s390-randconfig-r054-20260209 (https://download.01.org/0day-ci/archive/20260209/202602091037.wNIGJdbh-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260209/202602091037.wNIGJdbh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602091037.wNIGJdbh-lkp@intel.com/

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/mmc/host/renesas_sdhi_core.o: in function `renesas_sdhi_probe':
>> renesas_sdhi_core.c:(.text+0x1996): undefined reference to `devm_mux_state_get_optional_selected'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

