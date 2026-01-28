Return-Path: <linux-can+bounces-6385-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIa3FWCXemku8QEAu9opvQ
	(envelope-from <linux-can+bounces-6385-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 00:10:24 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C30EDA9DA8
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 00:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BA6830185AD
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 23:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3702C32E724;
	Wed, 28 Jan 2026 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9vUvmwo"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AF320CB1;
	Wed, 28 Jan 2026 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769641794; cv=none; b=pAOo23kLAT5zp18ZsC+wq1Nj8gzciW12hBLHVBbqJ2yjIj1M/cTpk2OgnyRNSxoeYr2RHv01FXvECP4xDhUiiTg8t79O7veP37UOlCr2PZXmR2W0+X9w8s55youHCEnZ0xNMU07eHmdLBNR7dO0xUbr9gYdOD8jxWh6j70YI570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769641794; c=relaxed/simple;
	bh=o67jrujsjxrXCYiTT2MYB48pD0sWDtqltINhWwNs+4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGbWQq5/tdzst+e5BFaHWKaDn6U6iuLAyygJK23NkAcpy/N6scG8QzyCzM3z6eV1bvO146jC7Yoi3QmZhQ0r8HW3Bf4SojkIWrZux3p9sNZ2wEeu5gQCtlpM35UiesjRwP7ODMtHw8lacNnw07QeHuBjo8oFocf7ZygGGev8ZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9vUvmwo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769641793; x=1801177793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o67jrujsjxrXCYiTT2MYB48pD0sWDtqltINhWwNs+4c=;
  b=n9vUvmwowxtan1HS5LHlaA2M3trgJgmU8hUUERLtsWe5atmsfmvweUxt
   MI8POmULqUI3hm9w4FaZXMyt7+z9nmtfg+LM98Y0YaCFqZo8VCDpsrACa
   eAX0rWUvy7T8HDJ3l1pDe7EDuEubOwhxT8tFU1GTmm42sa38pArc0/kO2
   ZIvMaGmROOgiZsYuHEldLGx5nxvcryclubIPOUsKyQxexAPXHf/wAXDfV
   TaN9KUL3WHquATwCzo4+g4QExlcHPNsiNWWzLIcw3PhymTMKweIXHwgSH
   P769Q68KbblvrlC9+qVEDkD8a0EL1dve35Wair9kxFDqOPhdOWoK2LBcQ
   Q==;
X-CSE-ConnectionGUID: SdjWPlFoR86QU46cwTyesA==
X-CSE-MsgGUID: rXQi76CSRg6xoiYu9MTQCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="81185480"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="81185480"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:09:52 -0800
X-CSE-ConnectionGUID: yUgXZ58CRTGI0RjtolXkpw==
X-CSE-MsgGUID: 0K/wPvbCRKWuv6+pB8QwTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="239135293"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 28 Jan 2026 15:09:50 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlEfT-0000000027R-1K0G;
	Wed, 28 Jan 2026 23:09:47 +0000
Date: Thu, 29 Jan 2026 00:09:19 +0100
From: kernel test robot <lkp@intel.com>
To: Arun Muthusamy <arun.muthusamy@gaisler.com>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mkl@pengutronix.de,
	mailhol@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: Re: [PATCH v4 02/15] net: can: Convert gaisler,grcan to DT schema
Message-ID: <202601290045.AC0xSS8q-lkp@intel.com>
References: <20260128144921.5458-3-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128144921.5458-3-arun.muthusamy@gaisler.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6385-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: C30EDA9DA8
X-Rspamd-Action: no action

Hi Arun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4001bda0cc911fcdd3dde36963a17f4eac173d7d]

url:    https://github.com/intel-lab-lkp/linux/commits/Arun-Muthusamy/dt-bindings-Add-vendor-prefix-for-Frontgrade-Gaisler-AB/20260128-230131
base:   4001bda0cc911fcdd3dde36963a17f4eac173d7d
patch link:    https://lore.kernel.org/r/20260128144921.5458-3-arun.muthusamy%40gaisler.com
patch subject: [PATCH v4 02/15] net: can: Convert gaisler,grcan to DT schema
reproduce: (https://download.01.org/0day-ci/archive/20260129/202601290045.AC0xSS8q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601290045.AC0xSS8q-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: MAINTAINERS references a file that doesn't exist: Documentation/sphinx/parse-headers.pl
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/bridge/megachips-stdpxxxx-ge-b850v3-fw.txt
   Warning: arch/powerpc/sysdev/mpic.c references a file that doesn't exist: Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
   Warning: arch/riscv/kernel/kexec_image.c references a file that doesn't exist: Documentation/riscv/boot-image-header.rst
   Warning: drivers/clocksource/timer-armada-370-xp.c references a file that doesn't exist: Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.txt
>> Warning: drivers/net/can/grcan.c references a file that doesn't exist: Documentation/devicetree/bindings/net/can/grcan.txt
   Warning: include/rv/da_monitor.h references a file that doesn't exist: Documentation/trace/rv/da_monitor_synthesis.rst
   Warning: rust/kernel/sync/atomic/ordering.rs references a file that doesn't exist: srctree/tools/memory-model/Documentation/explanation.txt
   Using alabaster theme
   ERROR: Cannot find file ./include/linux/pci.h
   WARNING: No kernel-doc for file ./include/linux/pci.h

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

