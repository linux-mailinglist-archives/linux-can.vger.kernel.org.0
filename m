Return-Path: <linux-can+bounces-1159-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D926294A1F9
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 09:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38026B23049
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 07:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA121C4612;
	Wed,  7 Aug 2024 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGuYFa0h"
X-Original-To: linux-can@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDFE18D651;
	Wed,  7 Aug 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723016884; cv=none; b=MuEhZHQIZvt93g0JT7P43XlyA87w/t3Zl51kUAPMSAjFD6iRrxyf9xJFgCDEz5Wb1TnmTpyOGaft5UR+VYdZAah0HeRtNHKShbyXndIkFyRoXqiZ13XuGfSKKaSPaYaSArAHvLTV26J37KgbGciUt34nshV9PdLgG+KuvK4zbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723016884; c=relaxed/simple;
	bh=KOntnmL5V9k9tJeYTDbi+yWu/u8mY1h1WypQDPeLepg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC0A4Eh6N3cKY+P+dRXH4Vye3ScYdSVWiO+s6OLLskd8hRjPW8SjVxfTXbnWLVK8K004+ZQ8F4286uvVBB1hCfG8ge2KKIKFuOX1WOnz6NbPbzUSeUeiaNA+IiKEHywSPUe1NZupXR8pjUcli4egIY6QjwvKpkynFgcTBrK5/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGuYFa0h; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723016881; x=1754552881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KOntnmL5V9k9tJeYTDbi+yWu/u8mY1h1WypQDPeLepg=;
  b=KGuYFa0h+K0hUxqsTaPZ/86H+b3pf2VtOP1UclMRkmqb6ajMX7wCoiH1
   xZuNZFKAwu1N+8C8CFO+/TRuLFdXQDo0qdB778lI8VRbxiIWqs8IMDKEO
   DVkLUASS/qgOgAPhOyEA1EzOFq5FZXLxrNIzoPFZVbzXW13qejI6rlGHq
   9l35tDKyU40xFAW0nX+M/lAw+2r0gDy9Mr0SsszQSvzWYjOIYnnWK30yv
   XSmapmV7UJMp+ogp4ss1XfUgXKezDUhtKtbiAAlOO+83y2BDbu38qv4Ec
   RHCky94rZHc8iJ0BTTPlNNqqBb51JL6P0xOW2zFkorw+Xgd2INbgFfiRJ
   w==;
X-CSE-ConnectionGUID: y13Nu30QRCqzhJejDOMkZw==
X-CSE-MsgGUID: zDZeTAJxSVumqWyRl5vXSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="24950365"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="24950365"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 00:48:00 -0700
X-CSE-ConnectionGUID: eo17zUZSREGWtjlFCdcs+g==
X-CSE-MsgGUID: 95mssAqLTe2KQc4AdlUGzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="61591264"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 07 Aug 2024 00:47:55 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbbOi-0005De-1Y;
	Wed, 07 Aug 2024 07:47:52 +0000
Date: Wed, 7 Aug 2024 15:47:43 +0800
From: kernel test robot <lkp@intel.com>
To: Anup Kulkarni <quic_anupkulk@quicinc.com>, mkl@pengutronix.de,
	manivannan.sadhasivam@linaro.org, thomas.kopp@microchip.com,
	mailhol.vincent@wanadoo.fr, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	quic_msavaliy@quicinc.com, quic_vdadhani@quicinc.com,
	Anup Kulkarni <quic_anupkulk@quicinc.com>
Subject: Re: [PATCH v1] can: mcp251xfd: Enable transceiver using gpio
Message-ID: <202408071217.7AvSrhxI-lkp@intel.com>
References: <20240806090339.785712-1-quic_anupkulk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806090339.785712-1-quic_anupkulk@quicinc.com>

Hi Anup,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkl-can-next/testing]
[also build test WARNING on net-next/main net/main linus/master v6.11-rc2 next-20240806]
[cannot apply to mani-mhi/mhi-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anup-Kulkarni/can-mcp251xfd-Enable-transceiver-using-gpio/20240806-175105
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git testing
patch link:    https://lore.kernel.org/r/20240806090339.785712-1-quic_anupkulk%40quicinc.com
patch subject: [PATCH v1] can: mcp251xfd: Enable transceiver using gpio
config: x86_64-buildonly-randconfig-001-20240806 (https://download.01.org/0day-ci/archive/20240807/202408071217.7AvSrhxI-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240807/202408071217.7AvSrhxI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408071217.7AvSrhxI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:2081:69: warning: variable 'priv' is uninitialized when used here [-Wuninitialized]
    2081 |         err = device_property_read_u32(&spi->dev, "gpio-transceiver-pin", &priv->transceiver_pin);
         |                                                                            ^~~~
   drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:2035:29: note: initialize the variable 'priv' to silence this warning
    2035 |         struct mcp251xfd_priv *priv;
         |                                    ^
         |                                     = NULL
   1 warning generated.


vim +/priv +2081 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c

  2031	
  2032	static int mcp251xfd_probe(struct spi_device *spi)
  2033	{
  2034		struct net_device *ndev;
  2035		struct mcp251xfd_priv *priv;
  2036		struct gpio_desc *rx_int;
  2037		struct regulator *reg_vdd, *reg_xceiver;
  2038		struct clk *clk;
  2039		bool pll_enable = false;
  2040		u32 freq = 0;
  2041		int err;
  2042	
  2043		if (!spi->irq)
  2044			return dev_err_probe(&spi->dev, -ENXIO,
  2045					     "No IRQ specified (maybe node \"interrupts-extended\" in DT missing)!\n");
  2046	
  2047		rx_int = devm_gpiod_get_optional(&spi->dev, "microchip,rx-int",
  2048						 GPIOD_IN);
  2049		if (IS_ERR(rx_int))
  2050			return dev_err_probe(&spi->dev, PTR_ERR(rx_int),
  2051					     "Failed to get RX-INT!\n");
  2052	
  2053		reg_vdd = devm_regulator_get_optional(&spi->dev, "vdd");
  2054		if (PTR_ERR(reg_vdd) == -ENODEV)
  2055			reg_vdd = NULL;
  2056		else if (IS_ERR(reg_vdd))
  2057			return dev_err_probe(&spi->dev, PTR_ERR(reg_vdd),
  2058					     "Failed to get VDD regulator!\n");
  2059	
  2060		reg_xceiver = devm_regulator_get_optional(&spi->dev, "xceiver");
  2061		if (PTR_ERR(reg_xceiver) == -ENODEV)
  2062			reg_xceiver = NULL;
  2063		else if (IS_ERR(reg_xceiver))
  2064			return dev_err_probe(&spi->dev, PTR_ERR(reg_xceiver),
  2065					     "Failed to get Transceiver regulator!\n");
  2066	
  2067		clk = devm_clk_get_optional(&spi->dev, NULL);
  2068		if (IS_ERR(clk))
  2069			return dev_err_probe(&spi->dev, PTR_ERR(clk),
  2070					     "Failed to get Oscillator (clock)!\n");
  2071		if (clk) {
  2072			freq = clk_get_rate(clk);
  2073		} else {
  2074			err = device_property_read_u32(&spi->dev, "clock-frequency",
  2075						       &freq);
  2076			if (err)
  2077				return dev_err_probe(&spi->dev, err,
  2078						     "Failed to get clock-frequency!\n");
  2079		}
  2080	
> 2081		err = device_property_read_u32(&spi->dev, "gpio-transceiver-pin", &priv->transceiver_pin);
  2082			if (err)
  2083				return dev_err_probe(&spi->dev, err,
  2084						     "Failed to get gpio transceiver pin!\n");
  2085	
  2086		/* Sanity check */
  2087		if (freq < MCP251XFD_SYSCLOCK_HZ_MIN ||
  2088		    freq > MCP251XFD_SYSCLOCK_HZ_MAX) {
  2089			dev_err(&spi->dev,
  2090				"Oscillator frequency (%u Hz) is too low or high.\n",
  2091				freq);
  2092			return -ERANGE;
  2093		}
  2094	
  2095		if (freq <= MCP251XFD_SYSCLOCK_HZ_MAX / MCP251XFD_OSC_PLL_MULTIPLIER)
  2096			pll_enable = true;
  2097	
  2098		ndev = alloc_candev(sizeof(struct mcp251xfd_priv),
  2099				    MCP251XFD_TX_OBJ_NUM_MAX);
  2100		if (!ndev)
  2101			return -ENOMEM;
  2102	
  2103		SET_NETDEV_DEV(ndev, &spi->dev);
  2104	
  2105		ndev->netdev_ops = &mcp251xfd_netdev_ops;
  2106		ndev->irq = spi->irq;
  2107		ndev->flags |= IFF_ECHO;
  2108	
  2109		priv = netdev_priv(ndev);
  2110		spi_set_drvdata(spi, priv);
  2111		priv->can.clock.freq = freq;
  2112		if (pll_enable)
  2113			priv->can.clock.freq *= MCP251XFD_OSC_PLL_MULTIPLIER;
  2114		priv->can.do_set_mode = mcp251xfd_set_mode;
  2115		priv->can.do_get_berr_counter = mcp251xfd_get_berr_counter;
  2116		priv->can.bittiming_const = &mcp251xfd_bittiming_const;
  2117		priv->can.data_bittiming_const = &mcp251xfd_data_bittiming_const;
  2118		priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
  2119			CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
  2120			CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
  2121			CAN_CTRLMODE_CC_LEN8_DLC;
  2122		set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
  2123		priv->ndev = ndev;
  2124		priv->spi = spi;
  2125		priv->rx_int = rx_int;
  2126		priv->clk = clk;
  2127		priv->pll_enable = pll_enable;
  2128		priv->reg_vdd = reg_vdd;
  2129		priv->reg_xceiver = reg_xceiver;
  2130		priv->devtype_data = *(struct mcp251xfd_devtype_data *)spi_get_device_match_data(spi);
  2131	
  2132		/* Errata Reference:
  2133		 * mcp2517fd: DS80000792C 5., mcp2518fd: DS80000789E 4.,
  2134		 * mcp251863: DS80000984A 4.
  2135		 *
  2136		 * The SPI can write corrupted data to the RAM at fast SPI
  2137		 * speeds:
  2138		 *
  2139		 * Simultaneous activity on the CAN bus while writing data to
  2140		 * RAM via the SPI interface, with high SCK frequency, can
  2141		 * lead to corrupted data being written to RAM.
  2142		 *
  2143		 * Fix/Work Around:
  2144		 * Ensure that FSCK is less than or equal to 0.85 *
  2145		 * (FSYSCLK/2).
  2146		 *
  2147		 * Known good combinations are:
  2148		 *
  2149		 * MCP	ext-clk	SoC			SPI			SPI-clk		max-clk	parent-clk	config
  2150		 *
  2151		 * 2518	20 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	 8333333 Hz	 83.33%	600000000 Hz	assigned-clocks = <&ccu CLK_SPIx>
  2152		 * 2518	40 MHz	allwinner,sun8i-h3	allwinner,sun8i-h3-spi	16666667 Hz	 83.33%	600000000 Hz	assigned-clocks = <&ccu CLK_SPIx>
  2153		 * 2517	40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	default
  2154		 * 2518	40 MHz	atmel,sama5d27		atmel,at91rm9200-spi	16400000 Hz	 82.00%	 82000000 Hz	default
  2155		 * 2518	40 MHz	fsl,imx6dl		fsl,imx51-ecspi		15000000 Hz	 75.00%	 30000000 Hz	default
  2156		 * 2517	20 MHz	fsl,imx8mm		fsl,imx51-ecspi		 8333333 Hz	 83.33%	 16666667 Hz	assigned-clocks = <&clk IMX8MM_CLK_ECSPIx_ROOT>
  2157		 *
  2158		 */
  2159		priv->spi_max_speed_hz_orig = spi->max_speed_hz;
  2160		priv->spi_max_speed_hz_slow = min(spi->max_speed_hz,
  2161						  freq / 2 / 1000 * 850);
  2162		if (priv->pll_enable)
  2163			priv->spi_max_speed_hz_fast = min(spi->max_speed_hz,
  2164							  freq *
  2165							  MCP251XFD_OSC_PLL_MULTIPLIER /
  2166							  2 / 1000 * 850);
  2167		else
  2168			priv->spi_max_speed_hz_fast = priv->spi_max_speed_hz_slow;
  2169		spi->max_speed_hz = priv->spi_max_speed_hz_slow;
  2170		spi->bits_per_word = 8;
  2171		spi->rt = true;
  2172		err = spi_setup(spi);
  2173		if (err)
  2174			goto out_free_candev;
  2175	
  2176		err = mcp251xfd_regmap_init(priv);
  2177		if (err)
  2178			goto out_free_candev;
  2179	
  2180		err = can_rx_offload_add_manual(ndev, &priv->offload,
  2181						MCP251XFD_NAPI_WEIGHT);
  2182		if (err)
  2183			goto out_free_candev;
  2184	
  2185		err = mcp251xfd_register(priv);
  2186		if (err) {
  2187			dev_err_probe(&spi->dev, err, "Failed to detect %s.\n",
  2188				      mcp251xfd_get_model_str(priv));
  2189			goto out_can_rx_offload_del;
  2190		}
  2191	
  2192		return 0;
  2193	
  2194	out_can_rx_offload_del:
  2195		can_rx_offload_del(&priv->offload);
  2196	out_free_candev:
  2197		spi->max_speed_hz = priv->spi_max_speed_hz_orig;
  2198	
  2199		free_candev(ndev);
  2200	
  2201		return err;
  2202	}
  2203	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

