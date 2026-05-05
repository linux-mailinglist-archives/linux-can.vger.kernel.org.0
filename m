Return-Path: <linux-can+bounces-7528-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePVeJEQb+mkJJgMAu9opvQ
	(envelope-from <linux-can+bounces-7528-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 18:31:00 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADAD4D14F7
	for <lists+linux-can@lfdr.de>; Tue, 05 May 2026 18:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA7B830078A0
	for <lists+linux-can@lfdr.de>; Tue,  5 May 2026 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE1548AE1A;
	Tue,  5 May 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3c57A43"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0F3EE1C4;
	Tue,  5 May 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998391; cv=none; b=b2XqrhMSx9cgqNL5aIJy/EEMCa4y7XwGuepE7hurErLXRA/YP+qllxrFRA6frgYh6ik4XxdbRKMG3XxjzkJ5CpIYcU/98fjbb+v02TWZrWiYpLGc2cW3qHOoHeERPPSI7gFQjYbtQab9wwxkU+/yVJgo2bijO+gucVg7GiOaj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998391; c=relaxed/simple;
	bh=d9oRhAaRGwydDiDuK7BhCRvRWDp8pOBlU9+d0qcoLXY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YjO8IVpMtSzCXGDC2g79qdmSNbTcXozg1SPKqgVjg/MPfo+j/eJYcAoIiSrMv0yC2XUaaLSE6CFwkfpe0i40Hb0Ukrk+jajW6M67+pxCmfcbur3xRzWfG3w1C/EKjxUMVnc8yjw1nBI3bv2L42x3uN9ljDkWbOiEsxuHHHZEPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3c57A43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7D5C2BCB4;
	Tue,  5 May 2026 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777998391;
	bh=d9oRhAaRGwydDiDuK7BhCRvRWDp8pOBlU9+d0qcoLXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P3c57A43Ly9U95oakv1tzSfsBDMAQvbGX3L5fDur0PPxN8g/BkGWOrF0IQ1vnb8kn
	 q5FpFULXXt5CFm8Sy/qdB+pGfZ+595OPQ/+H2h/dpiAmaAvc14vlTx4Z7a774smhAG
	 mRi8mWrUgi+n3TQ7klBwMiCHYz3eCKtTXeoo5Vugwd9W8wFUQWC/qxp4tUJmAVvLgS
	 jHSgvFYD9WkXPVvCXJZvfwe/RjozMVbFHi4OoCu3mLeSQZDLHCSt79QQSlDeG2UmtL
	 GPSyoqLckepvJjFkRnrQa3yfyKh+iIz18B0bEQzeLYkJERNnopW8hE0+mQWVZV5SLC
	 bwYA1sJR8mQqw==
Date: Tue, 5 May 2026 11:26:29 -0500
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
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manikandan K Pillai <mpillai@cadence.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Tom Joseph <tjoseph@cadence.com>
Subject: Re: [PATCH v8 phy-next 01/31] PCI: cadence: Preserve all error codes
 in cdns_plat_pcie_probe()
Message-ID: <20260505162629.GA734488@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505100523.1922388-2-vladimir.oltean@nxp.com>
X-Rspamd-Queue-Id: 2ADAD4D14F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7528-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cadence.com:email]

[+cc Tom, author of bd22885aa188 in case there's something subtle here]

On Tue, May 05, 2026 at 01:04:53PM +0300, Vladimir Oltean wrote:
> The blamed commit functionally changed the error path of
> cdns_pcie_host_probe(), now cdns_plat_pcie_probe().
> 
> When the old code path executed "goto err_get_sync", the PCIe controller
> probe function propagated the pm_runtime_get_sync() error code. The new
> code doesn't, and returns 0.
> 
> Similarly for the "goto err_init" previously triggered by
> cdns_pcie_host_init() errors, and now triggered by
> cdns_pcie_host_setup() and cdns_pcie_ep_setup() errors. These are not
> propagated and will result in probing success, which is incorrect.
> 
> Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Manikandan K Pillai <mpillai@cadence.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>

I guess this driver is orphaned.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> v7->v8: patch is new, issue was flagged by Sashiko
> https://sashiko.dev/#/patchset/20260430110652.558622-1-vladimir.oltean@nxp.com
> ---
>  drivers/pci/controller/cadence/pcie-cadence-plat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> index b067a3296dd3..8b12a46b5601 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -126,7 +126,7 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  	while (phy_count--)
>  		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
>  
> -	return 0;
> +	return ret;

This affects cases where pm_runtime_get_sync(),
cdns_pcie_host_setup(), or cdns_pcie_ep_setup() return failure.

Seems right to me to fail the probe when these fail.

Not all users of pm_runtime_get_sync() check for failure, but I think
all the other controller drivers that do check return failures from
the .probe().

>  }
>  
>  static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
> -- 
> 2.34.1
> 

