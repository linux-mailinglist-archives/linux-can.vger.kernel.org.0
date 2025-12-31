Return-Path: <linux-can+bounces-5975-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC797CEC7CE
	for <lists+linux-can@lfdr.de>; Wed, 31 Dec 2025 20:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66BF3007EF4
	for <lists+linux-can@lfdr.de>; Wed, 31 Dec 2025 19:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95E23093DD;
	Wed, 31 Dec 2025 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6un8GJw"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA9308F2A;
	Wed, 31 Dec 2025 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767208764; cv=none; b=l4eqPmPX6Cfj3q13nxVW8e/gjqhjS6+GljN9TZLJvCiTMqr7/6bcq3PvOUU0c9efNoheoymChnzIJOvgC9IjwHNzl70dUwKI7ah/Akx9Zy/CiDzJ4TWc0j2fcuG4MPo7ENkvgV7xlCU9rQ92jvJHb0GKI2i4vTMo5Alwlo4umd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767208764; c=relaxed/simple;
	bh=bPZviCypgh2u3aDPG0qAxGyvZa+1OR4fditZ2kWyeUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezb2oh8UJIrm+k7ibAs8q0ygb61FYQWphAZCadRXlRsnDjKpe8XFm+FysD93Ksfj9XxAMpDFbCBxA4QTA7FAQ6I2v02h5WJfkgK42nRsN9qWnQERuvf7bOK9u+3+3l5CoMQeptrOHEbKfqRqK6VdrCiUynfvaEsVbJasrBzs7lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6un8GJw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767208760; x=1798744760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bPZviCypgh2u3aDPG0qAxGyvZa+1OR4fditZ2kWyeUA=;
  b=g6un8GJwJknHxYHCaXDQ1uHnFKjOKAozTzT72Q8oryrJs2IPY+rGoX0o
   MbMSAjy2Y0KlXtKoq+VUGlNNgnUWjCdklopGPbbmb/CZPY3cbazO2l+Bj
   BAj1vgMeR5DLg6zVlggjzpsnHIzGwPDS4YUX8eGONBiaKIYSqwGz0SzKY
   13zUBorCs53AFKiSZkQZi2VZpnkFtXFNsiAikEz0/Z4LXrxbez33fv2EG
   zj3umZGXJLa1fXpVNEFJrw7ulmP+yJ84cttKZsHb+pRK4N6rL41eNa2ru
   Knsl76Iccs+cYSJswPYzIgzgD+/Vg5hnlMa0D9azLMA3KRH57ZETt/hNk
   g==;
X-CSE-ConnectionGUID: yGd1M9q9TqiM2MgoGwE1Xg==
X-CSE-MsgGUID: 9YyuXY+DQE+Ld5yXdwjwlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="91429078"
X-IronPort-AV: E=Sophos;i="6.21,192,1763452800"; 
   d="scan'208";a="91429078"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 11:19:19 -0800
X-CSE-ConnectionGUID: EYoTpA++R2SJpSRjqjNTsQ==
X-CSE-MsgGUID: 3topCqpnQqml1KUIzQPeLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,192,1763452800"; 
   d="scan'208";a="224990122"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 31 Dec 2025 11:19:12 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vb1iw-000000001QT-1ofA;
	Wed, 31 Dec 2025 19:19:10 +0000
Date: Thu, 1 Jan 2026 03:18:51 +0800
From: kernel test robot <lkp@intel.com>
To: Josua Mayer <josua@solid-run.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Vignesh R <vigneshr@ti.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Message-ID: <202601010305.tpY47HE4-lkp@intel.com>
References: <20251229-rz-sdio-mux-v4-2-a023e55758fe@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229-rz-sdio-mux-v4-2-a023e55758fe@solid-run.com>

Hi Josua,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Josua-Mayer/phy-can-transceiver-rename-temporary-helper-function-to-avoid-conflict/20251229-223153
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20251229-rz-sdio-mux-v4-2-a023e55758fe%40solid-run.com
patch subject: [PATCH v4 2/7] mux: Add helper functions for getting optional and selected mux-state
config: parisc-randconfig-002-20260101 (https://download.01.org/0day-ci/archive/20260101/202601010305.tpY47HE4-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260101/202601010305.tpY47HE4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601010305.tpY47HE4-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h: In function 'mux_control_put':
>> include/linux/mux/consumer.h:138:9: warning: 'return' with a value, in function returning void [-Wreturn-type]
     138 |  return -EOPNOTSUPP;
         |         ^
   include/linux/mux/consumer.h:136:20: note: declared here
     136 | static inline void mux_control_put(struct mux_control *mux)
         |                    ^~~~~~~~~~~~~~~
   drivers/mux/core.c: At top level:
>> drivers/mux/core.c:302:14: error: redefinition of 'mux_control_states'
     302 | unsigned int mux_control_states(struct mux_control *mux)
         |              ^~~~~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:70:28: note: previous definition of 'mux_control_states' was here
      70 | static inline unsigned int mux_control_states(struct mux_control *mux)
         |                            ^~~~~~~~~~~~~~~~~~
>> drivers/mux/core.c:365:5: error: redefinition of 'mux_control_select_delay'
     365 | int mux_control_select_delay(struct mux_control *mux, unsigned int state,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:74:32: note: previous definition of 'mux_control_select_delay' was here
      74 | static inline int __must_check mux_control_select_delay(struct mux_control *mux,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mux/core.c:403:5: error: redefinition of 'mux_state_select_delay'
     403 | int mux_state_select_delay(struct mux_state *mstate, unsigned int delay_us)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:79:32: note: previous definition of 'mux_state_select_delay' was here
      79 | static inline int __must_check mux_state_select_delay(struct mux_state *mstate,
         |                                ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/mux/core.c:425:5: error: redefinition of 'mux_control_try_select_delay'
     425 | int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:84:32: note: previous definition of 'mux_control_try_select_delay' was here
      84 | static inline int __must_check mux_control_try_select_delay(struct mux_control *mux,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mux/core.c:459:5: error: redefinition of 'mux_state_try_select_delay'
     459 | int mux_state_try_select_delay(struct mux_state *mstate, unsigned int delay_us)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:90:32: note: previous definition of 'mux_state_try_select_delay' was here
      90 | static inline int __must_check mux_state_try_select_delay(struct mux_state *mstate,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mux/core.c:477:5: error: redefinition of 'mux_control_deselect'
     477 | int mux_control_deselect(struct mux_control *mux)
         |     ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:118:19: note: previous definition of 'mux_control_deselect' was here
     118 | static inline int mux_control_deselect(struct mux_control *mux)
         |                   ^~~~~~~~~~~~~~~~~~~~
>> drivers/mux/core.c:503:5: error: redefinition of 'mux_state_deselect'
     503 | int mux_state_deselect(struct mux_state *mstate)
         |     ^~~~~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:122:19: note: previous definition of 'mux_state_deselect' was here
     122 | static inline int mux_state_deselect(struct mux_state *mstate)
         |                   ^~~~~~~~~~~~~~~~~~
>> drivers/mux/core.c:625:21: error: redefinition of 'mux_control_get'
     625 | struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
         |                     ^~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:127:35: note: previous definition of 'mux_control_get' was here
     127 | static inline struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
         |                                   ^~~~~~~~~~~~~~~
>> drivers/mux/core.c:638:21: error: redefinition of 'mux_control_get_optional'
     638 | struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name)
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:131:35: note: previous definition of 'mux_control_get_optional' was here
     131 | static inline struct mux_control *mux_control_get_optional(struct device *dev,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mux/core.c:650:6: error: redefinition of 'mux_control_put'
     650 | void mux_control_put(struct mux_control *mux)
         |      ^~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:136:20: note: previous definition of 'mux_control_put' was here
     136 | static inline void mux_control_put(struct mux_control *mux)
         |                    ^~~~~~~~~~~~~~~
>> drivers/mux/core.c:671:21: error: redefinition of 'devm_mux_control_get'
     671 | struct mux_control *devm_mux_control_get(struct device *dev,
         |                     ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:141:35: note: previous definition of 'devm_mux_control_get' was here
     141 | static inline struct mux_control *devm_mux_control_get(struct device *dev, const char *mux_name)
         |                                   ^~~~~~~~~~~~~~~~~~~~
>> drivers/mux/core.c:774:19: error: redefinition of 'devm_mux_state_get'
     774 | struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
         |                   ^~~~~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:145:33: note: previous definition of 'devm_mux_state_get' was here
     145 | static inline struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
         |                                 ^~~~~~~~~~~~~~~~~~
>> drivers/mux/core.c:788:19: error: redefinition of 'devm_mux_state_get_optional'
     788 | struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:149:33: note: previous definition of 'devm_mux_state_get_optional' was here
     149 | static inline struct mux_state *devm_mux_state_get_optional(struct device *dev,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mux/core.c:838:19: error: redefinition of 'devm_mux_state_get_selected'
     838 | struct mux_state *devm_mux_state_get_selected(struct device *dev, const char *mux_name)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:154:33: note: previous definition of 'devm_mux_state_get_selected' was here
     154 | static inline struct mux_state *devm_mux_state_get_selected(struct device *dev,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mux/core.c:854:19: error: redefinition of 'devm_mux_state_get_optional_selected'
     854 | struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/mux/core.c:19:
   include/linux/mux/consumer.h:159:33: note: previous definition of 'devm_mux_state_get_optional_selected' was here
     159 | static inline struct mux_state *devm_mux_state_get_optional_selected(struct device *dev,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from core.c:19:
   include/linux/mux/consumer.h: In function 'mux_control_put':
>> include/linux/mux/consumer.h:138:9: warning: 'return' with a value, in function returning void [-Wreturn-type]
     138 |  return -EOPNOTSUPP;
         |         ^
   include/linux/mux/consumer.h:136:20: note: declared here
     136 | static inline void mux_control_put(struct mux_control *mux)
         |                    ^~~~~~~~~~~~~~~
   core.c: At top level:
   core.c:302:14: error: redefinition of 'mux_control_states'
     302 | unsigned int mux_control_states(struct mux_control *mux)
         |              ^~~~~~~~~~~~~~~~~~
   In file included from core.c:19:
   include/linux/mux/consumer.h:70:28: note: previous definition of 'mux_control_states' was here
      70 | static inline unsigned int mux_control_states(struct mux_control *mux)
         |                            ^~~~~~~~~~~~~~~~~~
   core.c:365:5: error: redefinition of 'mux_control_select_delay'
     365 | int mux_control_select_delay(struct mux_control *mux, unsigned int state,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from core.c:19:
   include/linux/mux/consumer.h:74:32: note: previous definition of 'mux_control_select_delay' was here
      74 | static inline int __must_check mux_control_select_delay(struct mux_control *mux,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~
   core.c:403:5: error: redefinition of 'mux_state_select_delay'
     403 | int mux_state_select_delay(struct mux_state *mstate, unsigned int delay_us)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   In file included from core.c:19:
   include/linux/mux/consumer.h:79:32: note: previous definition of 'mux_state_select_delay' was here
      79 | static inline int __must_check mux_state_select_delay(struct mux_state *mstate,
         |                                ^~~~~~~~~~~~~~~~~~~~~~
   core.c:425:5: error: redefinition of 'mux_control_try_select_delay'
     425 | int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from core.c:19:
   include/linux/mux/consumer.h:84:32: note: previous definition of 'mux_control_try_select_delay' was here
      84 | static inline int __must_check mux_control_try_select_delay(struct mux_control *mux,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   core.c:459:5: error: redefinition of 'mux_state_try_select_delay'
     459 | int mux_state_try_select_delay(struct mux_state *mstate, unsigned int delay_us)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from core.c:19:
   include/linux/mux/consumer.h:90:32: note: previous definition of 'mux_state_try_select_delay' was here
      90 | static inline int __must_check mux_state_try_select_delay(struct mux_state *mstate,
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   core.c:477:5: error: redefinition of 'mux_control_deselect'
     477 | int mux_control_deselect(struct mux_control *mux)
         |     ^~~~~~~~~~~~~~~~~~~~
   In file included from core.c:19:
   include/linux/mux/consumer.h:118:19: note: previous definition of 'mux_control_deselect' was here
     118 | static inline int mux_control_deselect(struct mux_control *mux)
         |                   ^~~~~~~~~~~~~~~~~~~~
   core.c:503:5: error: redefinition of 'mux_state_deselect'
     503 | int mux_state_deselect(struct mux_state *mstate)
         |     ^~~~~~~~~~~~~~~~~~
   In file included from core.c:19:
   include/linux/mux/consumer.h:122:19: note: previous definition of 'mux_state_deselect' was here
     122 | static inline int mux_state_deselect(struct mux_state *mstate)
         |                   ^~~~~~~~~~~~~~~~~~
   core.c:625:21: error: redefinition of 'mux_control_get'
     625 | struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
         |                     ^~~~~~~~~~~~~~~
   In file included from core.c:19:
   include/linux/mux/consumer.h:127:35: note: previous definition of 'mux_control_get' was here
     127 | static inline struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
         |                                   ^~~~~~~~~~~~~~~
   core.c:638:21: error: redefinition of 'mux_control_get_optional'
     638 | struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name)
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from core.c:19:
   include/linux/mux/consumer.h:131:35: note: previous definition of 'mux_control_get_optional' was here
     131 | static inline struct mux_control *mux_control_get_optional(struct device *dev,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~
   core.c:650:6: error: redefinition of 'mux_control_put'
     650 | void mux_control_put(struct mux_control *mux)
         |      ^~~~~~~~~~~~~~~
   In file included from core.c:19:
   include/linux/mux/consumer.h:136:20: note: previous definition of 'mux_control_put' was here
     136 | static inline void mux_control_put(struct mux_control *mux)
         |                    ^~~~~~~~~~~~~~~
   core.c:671:21: error: redefinition of 'devm_mux_control_get'
     671 | struct mux_control *devm_mux_control_get(struct device *dev,
         |                     ^~~~~~~~~~~~~~~~~~~~
   In file included from core.c:19:
   include/linux/mux/consumer.h:141:35: note: previous definition of 'devm_mux_control_get' was here
     141 | static inline struct mux_control *devm_mux_control_get(struct device *dev, const char *mux_name)
         |                                   ^~~~~~~~~~~~~~~~~~~~
   core.c:774:19: error: redefinition of 'devm_mux_state_get'
     774 | struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
         |                   ^~~~~~~~~~~~~~~~~~
   In file included from core.c:19:
   include/linux/mux/consumer.h:145:33: note: previous definition of 'devm_mux_state_get' was here
     145 | static inline struct mux_state *devm_mux_state_get(struct device *dev, const char *mux_name)
         |                                 ^~~~~~~~~~~~~~~~~~
   core.c:788:19: error: redefinition of 'devm_mux_state_get_optional'
     788 | struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from core.c:19:
   include/linux/mux/consumer.h:149:33: note: previous definition of 'devm_mux_state_get_optional' was here
     149 | static inline struct mux_state *devm_mux_state_get_optional(struct device *dev,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   core.c:838:19: error: redefinition of 'devm_mux_state_get_selected'
     838 | struct mux_state *devm_mux_state_get_selected(struct device *dev, const char *mux_name)
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/mux_control_states +302 drivers/mux/core.c

a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  295  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  296  /**
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  297   * mux_control_states() - Query the number of multiplexer states.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  298   * @mux: The mux-control to query.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  299   *
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  300   * Return: The number of multiplexer states.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  301   */
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14 @302  unsigned int mux_control_states(struct mux_control *mux)
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  303  {
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  304  	return mux->states;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  305  }
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  306  EXPORT_SYMBOL_GPL(mux_control_states);
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  307  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  308  /*
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  309   * The mux->lock must be down when calling this function.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  310   */
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  311  static int __mux_control_select(struct mux_control *mux, int state)
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  312  {
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  313  	int ret;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  314  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  315  	if (WARN_ON(state < 0 || state >= mux->states))
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  316  		return -EINVAL;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  317  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  318  	if (mux->cached_state == state)
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  319  		return 0;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  320  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  321  	ret = mux_control_set(mux, state);
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  322  	if (ret >= 0)
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  323  		return 0;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  324  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  325  	/* The mux update failed, try to revert if appropriate... */
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  326  	if (mux->idle_state != MUX_IDLE_AS_IS)
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  327  		mux_control_set(mux, mux->idle_state);
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  328  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  329  	return ret;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  330  }
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  331  
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  332  static void mux_control_delay(struct mux_control *mux, unsigned int delay_us)
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  333  {
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  334  	ktime_t delayend;
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  335  	s64 remaining;
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  336  
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  337  	if (!delay_us)
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  338  		return;
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  339  
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  340  	delayend = ktime_add_us(mux->last_change, delay_us);
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  341  	remaining = ktime_us_delta(delayend, ktime_get());
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  342  	if (remaining > 0)
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  343  		fsleep(remaining);
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  344  }
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  345  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  346  /**
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  347   * mux_control_select_delay() - Select the given multiplexer state.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  348   * @mux: The mux-control to request a change of state from.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  349   * @state: The new requested state.
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  350   * @delay_us: The time to delay (in microseconds) if the mux state is changed.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  351   *
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  352   * On successfully selecting the mux-control state, it will be locked until
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  353   * there is a call to mux_control_deselect(). If the mux-control is already
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  354   * selected when mux_control_select() is called, the caller will be blocked
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  355   * until mux_control_deselect() or mux_state_deselect() is called (by someone
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  356   * else).
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  357   *
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  358   * Therefore, make sure to call mux_control_deselect() when the operation is
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  359   * complete and the mux-control is free for others to use, but do not call
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  360   * mux_control_deselect() if mux_control_select() fails.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  361   *
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  362   * Return: 0 when the mux-control state has the requested state or a negative
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  363   * errno on error.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  364   */
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07 @365  int mux_control_select_delay(struct mux_control *mux, unsigned int state,
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  366  			     unsigned int delay_us)
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  367  {
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  368  	int ret;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  369  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  370  	ret = down_killable(&mux->lock);
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  371  	if (ret < 0)
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  372  		return ret;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  373  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  374  	ret = __mux_control_select(mux, state);
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  375  	if (ret >= 0)
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  376  		mux_control_delay(mux, delay_us);
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  377  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  378  	if (ret < 0)
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  379  		up(&mux->lock);
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  380  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  381  	return ret;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  382  }
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  383  EXPORT_SYMBOL_GPL(mux_control_select_delay);
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  384  
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  385  /**
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  386   * mux_state_select_delay() - Select the given multiplexer state.
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  387   * @mstate: The mux-state to select.
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  388   * @delay_us: The time to delay (in microseconds) if the mux state is changed.
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  389   *
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  390   * On successfully selecting the mux-state, its mux-control will be locked
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  391   * until there is a call to mux_state_deselect(). If the mux-control is already
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  392   * selected when mux_state_select() is called, the caller will be blocked
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  393   * until mux_state_deselect() or mux_control_deselect() is called (by someone
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  394   * else).
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  395   *
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  396   * Therefore, make sure to call mux_state_deselect() when the operation is
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  397   * complete and the mux-control is free for others to use, but do not call
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  398   * mux_state_deselect() if mux_state_select() fails.
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  399   *
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  400   * Return: 0 when the mux-state has been selected or a negative
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  401   * errno on error.
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  402   */
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07 @403  int mux_state_select_delay(struct mux_state *mstate, unsigned int delay_us)
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  404  {
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  405  	return mux_control_select_delay(mstate->mux, mstate->state, delay_us);
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  406  }
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  407  EXPORT_SYMBOL_GPL(mux_state_select_delay);
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  408  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  409  /**
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  410   * mux_control_try_select_delay() - Try to select the given multiplexer state.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  411   * @mux: The mux-control to request a change of state from.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  412   * @state: The new requested state.
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  413   * @delay_us: The time to delay (in microseconds) if the mux state is changed.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  414   *
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  415   * On successfully selecting the mux-control state, it will be locked until
f22d1117b9c3e2 drivers/mux/core.c     Peter Rosin        2022-01-07  416   * mux_control_deselect() is called.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  417   *
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  418   * Therefore, make sure to call mux_control_deselect() when the operation is
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  419   * complete and the mux-control is free for others to use, but do not call
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  420   * mux_control_deselect() if mux_control_try_select() fails.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  421   *
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  422   * Return: 0 when the mux-control state has the requested state or a negative
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  423   * errno on error. Specifically -EBUSY if the mux-control is contended.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  424   */
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07 @425  int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  426  				 unsigned int delay_us)
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  427  {
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  428  	int ret;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  429  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  430  	if (down_trylock(&mux->lock))
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  431  		return -EBUSY;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  432  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  433  	ret = __mux_control_select(mux, state);
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  434  	if (ret >= 0)
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  435  		mux_control_delay(mux, delay_us);
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  436  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  437  	if (ret < 0)
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  438  		up(&mux->lock);
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  439  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  440  	return ret;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  441  }
17b5b576ff5faf drivers/mux/core.c     Vincent Whitchurch 2021-10-07  442  EXPORT_SYMBOL_GPL(mux_control_try_select_delay);
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  443  
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  444  /**
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  445   * mux_state_try_select_delay() - Try to select the given multiplexer state.
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  446   * @mstate: The mux-state to select.
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  447   * @delay_us: The time to delay (in microseconds) if the mux state is changed.
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  448   *
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  449   * On successfully selecting the mux-state, its mux-control will be locked
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  450   * until mux_state_deselect() is called.
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  451   *
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  452   * Therefore, make sure to call mux_state_deselect() when the operation is
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  453   * complete and the mux-control is free for others to use, but do not call
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  454   * mux_state_deselect() if mux_state_try_select() fails.
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  455   *
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  456   * Return: 0 when the mux-state has been selected or a negative errno on
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  457   * error. Specifically -EBUSY if the mux-control is contended.
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  458   */
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07 @459  int mux_state_try_select_delay(struct mux_state *mstate, unsigned int delay_us)
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  460  {
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  461  	return mux_control_try_select_delay(mstate->mux, mstate->state, delay_us);
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  462  }
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  463  EXPORT_SYMBOL_GPL(mux_state_try_select_delay);
84564481bc4520 drivers/mux/core.c     Aswath Govindraju  2022-01-07  464  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  465  /**
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  466   * mux_control_deselect() - Deselect the previously selected multiplexer state.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  467   * @mux: The mux-control to deselect.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  468   *
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  469   * It is required that a single call is made to mux_control_deselect() for
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  470   * each and every successful call made to either of mux_control_select() or
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  471   * mux_control_try_select().
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  472   *
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  473   * Return: 0 on success and a negative errno on error. An error can only
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  474   * occur if the mux has an idle state. Note that even if an error occurs, the
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  475   * mux-control is unlocked and is thus free for the next access.
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  476   */
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14 @477  int mux_control_deselect(struct mux_control *mux)
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  478  {
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  479  	int ret = 0;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  480  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  481  	if (mux->idle_state != MUX_IDLE_AS_IS &&
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  482  	    mux->idle_state != mux->cached_state)
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  483  		ret = mux_control_set(mux, mux->idle_state);
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  484  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  485  	up(&mux->lock);
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  486  
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  487  	return ret;
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  488  }
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  489  EXPORT_SYMBOL_GPL(mux_control_deselect);
a3b02a9c6591ce drivers/mux/mux-core.c Peter Rosin        2017-05-14  490  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

