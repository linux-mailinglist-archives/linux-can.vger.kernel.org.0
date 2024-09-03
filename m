Return-Path: <linux-can+bounces-1331-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F596A511
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE2D1F25488
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AB418CC15;
	Tue,  3 Sep 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UtG3Hw/j"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3462B18BC1C;
	Tue,  3 Sep 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383428; cv=none; b=idTt9v8UEXBOQRrtASXCktPZ5rVx3SLGQ+52+twaCsYHd55N1yBrt0nJkNljocVMV9um4kAfQY900BGEvayNKXkvzoXX9gqE/np5uVT8bRFNS7f7UnCDqKryZWzmsViqA+MWONntqetr6WOFHwpxjZBAhKuf0v7Zqn/GvCkIjMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383428; c=relaxed/simple;
	bh=0l4evwdyan87dgGb7txNM2qR7iGQ5qw8nvVrzVmrYsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8SMDPeF+qfT36J1/ljfTMKuzjlVuW/TF01mJktQ9RpubzTImLah3qgBAgxe8MVu6ulcptbnZAgXMMMX276I+RiqMxwe+vNYBnfkmYXkVqkw/T7tQPPdnsSl+ZnM9vY6CoBZbU6Wg5NFzeh+0Yp67a0JewkqT/gfbFFJk8KWct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UtG3Hw/j; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725383427; x=1756919427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0l4evwdyan87dgGb7txNM2qR7iGQ5qw8nvVrzVmrYsk=;
  b=UtG3Hw/jA6gYkB7bpJDEV6DJ+SB4FIXfo+D3+xNQ6Vz3JYJzdRjmatoG
   i9Mqgn/qMap+3r2g4nvnj+q+hp7aceV6ifYv/6aUE8ObZrpWdxC2MYx/d
   i3kl3SzcATJm6wXrDApJtFpRfulRLlbTuMbsjXA/e5GtFtb1KhB4griwx
   QW0QdUdJVv4/vLHGSnW3okP0plzfczvUCMJMq10VIPFjlWP2UKAu5CpH7
   oLdMdg2Ya3UPf4vaq64jXNrt84IxJ3Q4uL67YWT5nJTMVUrE3qiylssIi
   6crU3Fe68RO9Y3LIQfUiiLjPtGA9POz4kknefL13BR9BXZzqyQJqj9GGs
   w==;
X-CSE-ConnectionGUID: +Atj3CcKSdSzYuKHvgv8tg==
X-CSE-MsgGUID: 8EdiBQCMTcKvflmaLTdfBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34662246"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="34662246"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 10:10:26 -0700
X-CSE-ConnectionGUID: 8wDNQEu0Qga0yw2/nvqSwg==
X-CSE-MsgGUID: s/qtCeb5QmWdBmBdcM73FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="95713609"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Sep 2024 10:10:21 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slX2p-0006wY-04;
	Tue, 03 Sep 2024 17:10:19 +0000
Date: Wed, 4 Sep 2024 01:09:26 +0800
From: kernel test robot <lkp@intel.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de,
	Alibek Omarov <a1ba.omarov@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	David Jander <david.jander@protonic.nl>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next v4 01/20] dt-bindings: can: rockchip_canfd: add
 rockchip CAN-FD controller
Message-ID: <202409040039.TNDhtsSe-lkp@intel.com>
References: <20240903-rockchip-canfd-v4-1-1dc3f3f32856@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-rockchip-canfd-v4-1-1dc3f3f32856@pengutronix.de>

Hi Marc,

kernel test robot noticed the following build warnings:

[auto build test WARNING on da4f3b72c8831975a06eca7e1c27392726f54d20]

url:    https://github.com/intel-lab-lkp/linux/commits/Marc-Kleine-Budde/dt-bindings-can-rockchip_canfd-add-rockchip-CAN-FD-controller/20240903-173243
base:   da4f3b72c8831975a06eca7e1c27392726f54d20
patch link:    https://lore.kernel.org/r/20240903-rockchip-canfd-v4-1-1dc3f3f32856%40pengutronix.de
patch subject: [PATCH can-next v4 01/20] dt-bindings: can: rockchip_canfd: add rockchip CAN-FD controller
reproduce: (https://download.01.org/0day-ci/archive/20240904/202409040039.TNDhtsSe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409040039.TNDhtsSe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/net/can/rockchip,rk3568-canfd.yaml
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

