Return-Path: <linux-can+bounces-2057-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF79C8B0A
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 13:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1FC3B258E5
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F0C1FA84A;
	Thu, 14 Nov 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CYwFkk7M"
X-Original-To: linux-can@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0AF1E883F;
	Thu, 14 Nov 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588639; cv=none; b=EUArDRk1MhSYu4WBiiZG5k9GWWqteFHDuOI/e783TLK43mT/Dj3iZSBroNFXZ2ysDnM//cim7P2plfhf7deMHdfM7XmvshvIxSmA+3xqt4o+jgVFN3PxQaWP1QFt+iJEbV6X5WtBeIzxfdqVQ4901Rc2SoZww3mrMNanu6WZM4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588639; c=relaxed/simple;
	bh=30EemVlxXVCzIcM8CElgaclSsg05Fk11b5D/AnIKsZ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfWv+qa0niIDQGWrkK6ZgLMTExuZvOexCZDqRYD6XjdbwVewPopc80N53z466WjNx62opn/7tbJGQ3aOOXl3cB5licst39HVVKDwuOmU/07rKS/iADiKhMwtRtWuHgCziEUodiTDEOYugywTMzb7duCE14mM7rh6I/LB5d0zjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CYwFkk7M; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731588637; x=1763124637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=30EemVlxXVCzIcM8CElgaclSsg05Fk11b5D/AnIKsZ4=;
  b=CYwFkk7MfqRdAi6EzXhh7uSH2ZaYMtixGzHJuO5i40ru5HwAXW8U1nsq
   bFEuok/mZ1oox8kPaD38G5OzLp5dtbx1p5ZsHY7nRIkQQVFXbfSxyRjfX
   rTz7LUpdlhbO3ntqqRGk/HxJBBqDASDH4WKRzUvT/MvCqJHlfxvtJ1DDd
   8irgCHHXZg3mzBo6T6gNDsDT6ruujf3gxeCGMny2Py0h88R1/EC997RlS
   vUq3UamIOJ+UOZjw735qsAzLb9bArDg/HX1EVZavFsEg4KVyXOKmfson1
   lfoZ/iuO9AvyyvpJRVBUi7N7Jm5kskms2W8oCsTgfUlByyt/dcPQeZe60
   A==;
X-CSE-ConnectionGUID: dprYk6rmQCadJdxyql8mEA==
X-CSE-MsgGUID: b6rLs88DS46y5i09HfzQkw==
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="201749152"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2024 05:50:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Nov 2024 05:50:05 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 14 Nov 2024 05:50:01 -0700
Date: Thu, 14 Nov 2024 12:50:01 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kurt Kanzenbach
	<kurt@linutronix.de>, Vladimir Oltean <olteanv@gmail.com>, Chris Snook
	<chris.snook@gmail.com>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, "Russell
 King" <linux@armlinux.org.uk>, Horatiu Vultur <horatiu.vultur@microchip.com>,
	"maintainer:MICROCHIP LAN966X ETHERNET DRIVER"
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
Message-ID: <20241114125001.3hykb6dnzmt7bkti@DEN-DL-M70577>
References: <20241111200212.5907-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241111200212.5907-1-rosenp@gmail.com>

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

Seems like this causes some trouble in the lan969x (see Horatius
comment). While at it, maybe reformat this line - checkpatch is
complaining:

CHECK: Lines should not end with a '('
#314: FILE: drivers/net/ethernet/microchip/lan966x/lan966x_main.c:80:
+		begin[idx] = devm_platform_get_and_ioremap_resource(

/Daniel

> +               if (IS_ERR(begin[idx])) {
>                         dev_err(&pdev->dev, "Unable to get registers: %s\n",
>                                 iores[idx]->name);
> -                       return -ENOMEM;
> +                       return PTR_ERR(begin[idx]);
>                 }
>         }
> 


