Return-Path: <linux-can+bounces-6913-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEXfJNexqGkzwgAAu9opvQ
	(envelope-from <linux-can+bounces-6913-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 23:27:35 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11472208849
	for <lists+linux-can@lfdr.de>; Wed, 04 Mar 2026 23:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E525B30E6FFA
	for <lists+linux-can@lfdr.de>; Wed,  4 Mar 2026 22:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2049E38C2D4;
	Wed,  4 Mar 2026 22:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT8h8wa9"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601C38911B;
	Wed,  4 Mar 2026 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663050; cv=none; b=rUgGkZxBUuDbYB6P1kMQ+QI5QLNLxdcxMPqCCKhL1O+CFjnGDM9NODV0ZliLHFXA53g16ZeRChHTKm9HPIWissYrd9O0Is0W8DQ+lmX7axw1QtVFw4j1ed3UX2XsG6wPtxKGb1ut6AMEAhTT3HGji1FqUY25Q5mk5lPojpOAwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663050; c=relaxed/simple;
	bh=LZ6aRV4NLElGe+XvDNm2H6HYU4en15K91g1Y0+5t5ls=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qtZjAM6ICjfGcOkdT4r76joAOupI30P0bL8qQYnaHNMEsZy+YihIex4nW49bjBD27r/fimB9o9DhMX8V2kwbefoPWEgRA8zNTraQsnXfV1JIcE0brecmV8bPr5upJbJmbia/crJvJr15WvOZNtaeXFunFiuG2Kv5Pqm9pbyGW+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT8h8wa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78788C4CEF7;
	Wed,  4 Mar 2026 22:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772663049;
	bh=LZ6aRV4NLElGe+XvDNm2H6HYU4en15K91g1Y0+5t5ls=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JT8h8wa9YGAM78bb/3oWwxOczIdTWP1RLevWv9SASlMV3F23HjV3aS0cAufk5oNIv
	 Zbq+dj2V5Q1lrbLpdEf4tkfURlQheh0zpocuRg02jBYOuKwCUWiLX08zynlr3zyeeI
	 6w6Tf3erGb8F5L7qg0ORfQYnKFUxrQFLM83fJWOTVoAGPovAII829usbx5s2g7ZftI
	 8F0q5T73eVmTAvQiaF4BLlcaiBz/Wo2J+jlfrwYZ9ZRmUbse8mrHowz62l44VtX+79
	 VS3gNkNik1DtEJIOtsvBEoQRsmWSal1XE2ICQqhs17+ZVBYOWkmudGUSL2q9myTyT4
	 S8ZfZ2xwzNClw==
Date: Wed, 4 Mar 2026 16:24:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Shawn Guo <shawn.guo@linaro.org>,
	Yixun Lan <dlan@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH phy-next 02/22] PCI: add missing headers transitively
 included by <linux/phy/phy.h>
Message-ID: <20260304222408.GA40990@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304175735.2660419-3-vladimir.oltean@nxp.com>
X-Rspamd-Queue-Id: 11472208849
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6913-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,kernel.org,linaro.org,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,microchip.com,google.com,sntech.de,gmail.com,nvidia.com,rock-chips.com,starfivetech.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:email,linaro.org:email,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,starfivetech.com:email,nvidia.com:email]
X-Rspamd-Action: no action

Update subject line to match history:

  PCI: Add missing headers transitively included by <linux/phy/phy.h>

On Wed, Mar 04, 2026 at 07:57:15PM +0200, Vladimir Oltean wrote:
> The tegra as well as a few dwc PCI controller drivers uses PM runtime
> operations without including the required <linux/pm_runtime.h> header.
> 
> Similarly, pcie-rockchip-host, pcie-starfive as well as a few dwc PCI
> controllers use the regulator consumer API without including
> <linux/regulator/consumer.h>.
> 
> It seems these function prototypes were indirectly provided by
> <linux/phy/phy.h>, mostly by mistake (none of the functions it exports
> need it).
> 
> Before the PHY header can drop the unnecessary includes, make sure the
> PCI controller drivers include what they use.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

With the subject line update:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Yixun Lan <dlan@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Kevin Xie <kevin.xie@starfivetech.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c     | 1 +
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
>  drivers/pci/controller/dwc/pcie-histb.c       | 1 +
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     | 1 +
>  drivers/pci/controller/dwc/pcie-spacemit-k1.c | 2 ++
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 1 +
>  drivers/pci/controller/pci-tegra.c            | 1 +
>  drivers/pci/controller/pcie-rockchip-host.c   | 1 +
>  drivers/pci/controller/plda/pcie-starfive.c   | 1 +
>  9 files changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 20fa4dadb82a..642e4c45eefc 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -24,6 +24,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/resource.h>
>  #include <linux/signal.h>
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 5b17da63151d..e0079ec108ab 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -21,6 +21,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  
>  #include "../../pci.h"
> diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
> index a52071589377..432a54c5bfce 100644
> --- a/drivers/pci/controller/dwc/pcie-histb.c
> +++ b/drivers/pci/controller/dwc/pcie-histb.c
> @@ -18,6 +18,7 @@
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/resource.h>
>  #include <linux/reset.h>
>  
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 18460f01b2c6..e417122da51d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -19,6 +19,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  #include <linux/module.h>
> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> index be20a520255b..dbec159fd458 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -15,7 +15,9 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/types.h>
>  
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 06571d806ab3..3378a89580ab 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -27,6 +27,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/resource.h>
>  #include <linux/types.h>
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 512309763d1f..a2c1662b6e81 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -36,6 +36,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index ee1822ca01db..46adb4582fcc 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -24,6 +24,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "../pci.h"
>  #include "pcie-rockchip.h"
> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
> index 298036c3e7f9..22344cca167b 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -21,6 +21,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include "../../pci.h"
>  
> -- 
> 2.43.0
> 

