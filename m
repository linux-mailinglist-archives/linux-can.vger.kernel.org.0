Return-Path: <linux-can+bounces-2055-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF139C887F
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 12:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D591D282851
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DB01F8909;
	Thu, 14 Nov 2024 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ua63s7Ns"
X-Original-To: linux-can@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441211F81A7;
	Thu, 14 Nov 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582612; cv=none; b=GP9CzTZQHkaNl3Gg90syb/ZBtPOnAez012CDqH4wYy1WekSfoPy46FXUcIZc5xMtDYzZB1erMLojqgxMv9nH8F135VSvgPpnBRh6hZzrDOKhS1qJCkX3WrcO7bW0q3wDT7ZJJdz4vrmvJtW62ncxEDCccnL5R9NHRJV9i+v4KNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582612; c=relaxed/simple;
	bh=tkzHrrJXOXS7vOUYq3tWDArhR/nWqxSRsKMsB3s0zw4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXoNVKXKvg9udUpcqiWK/RiEskFfcdjZ96f+J6gv3pB+MGBieyIuAEheIMvE9ckEGHaeQgkVOOCUXVSnaVN+nvoqsZpMkDycBxjNTwCEJUm5pIV1+yQhyhXr7qFSaeDK7+VKubd6swOt+Ms7nB/MxPWneItenItetc0qd0duWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ua63s7Ns; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731582610; x=1763118610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tkzHrrJXOXS7vOUYq3tWDArhR/nWqxSRsKMsB3s0zw4=;
  b=ua63s7NslMf4M2K98kN+TCvZjLAUb119+pcsp7o18ZPmEvowXy88W9uj
   z0Hv7Izk5Hfr2RLQpE6/bvIXIPdhnXevawFMACSPJKyIU0QbFVlQo3tQa
   YquAXZPSLoZ/9sg/wJFhta52z8W2JxF01ia/vZVinLOsKydtkQYKQNxUq
   ZTj1cDIdMBXV6CBFyvPMXweXEzxWbyzAhjVOLQHCSTO20cncHYsuKJX3y
   jDXktTZeaHSXpGsqemKzwJZnk5uVqdKY3SHD1BlBfp8EZ/7GT2gyczork
   ex+R15BmnWrsMDYo9Kq7cBejuHqsBCwQzhbyzm5SvKMV3O20xhh7VKqvl
   Q==;
X-CSE-ConnectionGUID: p4ZQJMZoSBKRif35c8c9jg==
X-CSE-MsgGUID: mfgf0lngSeqcO77umlAhyg==
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="34308229"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2024 04:10:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Nov 2024 04:09:28 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 14 Nov 2024 04:09:28 -0700
Date: Thu, 14 Nov 2024 12:07:45 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kurt Kanzenbach
	<kurt@linutronix.de>, Vladimir Oltean <olteanv@gmail.com>, Chris Snook
	<chris.snook@gmail.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, "Russell
 King" <linux@armlinux.org.uk>, "maintainer:MICROCHIP LAN966X ETHERNET DRIVER"
	<UNGLinuxDriver@microchip.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>, Niklas =?utf-8?Q?S=C3=B6derlund?=
	<niklas.soderlund@ragnatech.se>, Doug Berger <opendmb@gmail.com>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, "Broadcom internal kernel review
 list" <bcm-kernel-feedback-list@broadcom.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, Richard Cochran <richardcochran@gmail.com>, "open
 list:MCAN MMIO DEVICE DRIVER" <linux-can@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:RENESAS ETHERNET SWITCH DRIVER"
	<linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCHv2 net-next] net: modernize ioremap in probe
Message-ID: <20241114110745.h6luzb72zkahyr5j@DEN-DL-M31836.microchip.com>
References: <20241111200212.5907-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20241111200212.5907-1-rosenp@gmail.com>

The 11/11/2024 12:02, Rosen Penev wrote:

Hi Rosen,

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> index 3234a960fcc3..375e9a68b9a9 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
> @@ -77,20 +77,12 @@ static int lan966x_create_targets(struct platform_device *pdev,
>          * this.
>          */
>         for (idx = 0; idx < IO_RANGES; idx++) {
> -               iores[idx] = platform_get_resource(pdev, IORESOURCE_MEM,
> -                                                  idx);
> -               if (!iores[idx]) {
> -                       dev_err(&pdev->dev, "Invalid resource\n");
> -                       return -EINVAL;
> -               }
> -
> -               begin[idx] = devm_ioremap(&pdev->dev,
> -                                         iores[idx]->start,
> -                                         resource_size(iores[idx]));
> -               if (!begin[idx]) {
> +               begin[idx] = devm_platform_get_and_ioremap_resource(
> +                       pdev, idx, &iores[idx]);
> +               if (IS_ERR(begin[idx])) {
>                         dev_err(&pdev->dev, "Unable to get registers: %s\n",
>                                 iores[idx]->name);
> -                       return -ENOMEM;
> +                       return PTR_ERR(begin[idx]);
>                 }
>         }
> 

Unfortunately, this breaks the lan966x probe. With this change I get the
following errors:
[    1.705315] lan966x-switch e0000000.switch: can't request region for resource [mem 0xe0000000-0xe00fffff]
[    1.714911] lan966x-switch e0000000.switch: Unable to get registers: cpu
[    1.721607] lan966x-switch e0000000.switch: error -EBUSY: Failed to create targets
[    1.729173] lan966x-switch: probe of e0000000.switch failed with error -16

-- 
/Horatiu

