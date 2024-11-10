Return-Path: <linux-can+bounces-1945-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 878FE9C33D0
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 17:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4146F1F212C9
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A1A4DA04;
	Sun, 10 Nov 2024 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="FFkxxDRa"
X-Original-To: linux-can@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C61E136E3B;
	Sun, 10 Nov 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731256824; cv=none; b=iSuXuXIky6BB/7BR7upixxKoeGmSW1MtJxF1eoCBEyIJczYNwnMuSVfrnKnA0gtSv+NdfLjolSIQka2AzEul6gRGf+avprAt95o/+w7Qetuzv2bT9GuwkVOs/01Eka+KkKjovFnDCo3C6Oh3YUmegS7pHr+Mwo8kg3/VoxMzeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731256824; c=relaxed/simple;
	bh=2K5caTP3z34WOhy1GQkAjTSSj/hs1LyjIWxZCrtUmSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0EOzBhjxZTv2kRKAnnOmIL48ylhw47qucJNI3NES6TU+zCAI+oaObcMVVyLPDG2CIfkFk7X93YrzigONM6xGWH5cCrVb941GL7Ctj9WZ/kWdH0nV1ZbCb1Ox4UmvVpop6cZ5BuobIpoQUCJ1yZW5IQB7p3qYuOKE8meNQlXw7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=FFkxxDRa; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 4AAGbouY3930604;
	Sun, 10 Nov 2024 17:37:50 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 4AAGbouY3930604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1731256670;
	bh=5+y2QMykRjhaG+PDz43DPVOX9kNsX0ZYGqEKpJPmxSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFkxxDRaq1CSSsHRAAocoXu+u98Fyc5BN4GR4nHWXkWF9G4P4eEIgMKVy9d4t4ZBx
	 67hd1nY0BOtuujJ85otrSRji5KektIdUuvhwvsToPqe4Q8utQnGKfPgxcaEBz42GxQ
	 aqLq3/kra2W7ijiY9fEnrh/5yk7KY5bQZ8QjDUt0=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 4AAGblIR3930603;
	Sun, 10 Nov 2024 17:37:47 +0100
Date: Sun, 10 Nov 2024 17:37:47 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Vladimir Oltean <olteanv@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Pantelis Antoniou <pantelis.antoniou@gmail.com>,
        Marcin Wojtas <marcin.s.wojtas@gmail.com>,
        Byungho An <bh74.an@samsung.com>,
        Kevin Brace <kevinbrace@bracecomputerlab.com>,
        Michal Simek <michal.simek@amd.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, Zhao Qiang <qiang.zhao@nxp.com>,
        "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
        "open list:FREESCALE SOC FS_ENET DRIVER" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH net-next] net: use pdev instead of OF funcs
Message-ID: <20241110163747.GA3930570@electric-eye.fr.zoreil.com>
References: <20241109233821.8619-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109233821.8619-1-rosenp@gmail.com>
X-Organisation: Land of Sunshine Inc.

Rosen Penev <rosenp@gmail.com> :
> np here is ofdev->dev.of_node. Better to use the proper functions as
> there's no use of children or anything else.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
[...]
> diff --git a/drivers/net/ethernet/via/via-rhine.c b/drivers/net/ethernet/via/via-rhine.c
> index 894911f3d560..f079242c33e2 100644
> --- a/drivers/net/ethernet/via/via-rhine.c
> +++ b/drivers/net/ethernet/via/via-rhine.c
> @@ -1127,7 +1127,7 @@ static int rhine_init_one_platform(struct platform_device *pdev)
>  	if (IS_ERR(ioaddr))
>  		return PTR_ERR(ioaddr);
>  
> -	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	irq = platform_get_irq(pdev, 0);
>  	if (!irq)
>  		return -EINVAL;
>  
> diff --git a/drivers/net/ethernet/via/via-velocity.c b/drivers/net/ethernet/via/via-velocity.c
> index dd4a07c97eee..4aac9599c14d 100644
> --- a/drivers/net/ethernet/via/via-velocity.c
> +++ b/drivers/net/ethernet/via/via-velocity.c
> @@ -2950,7 +2950,7 @@ static int velocity_platform_probe(struct platform_device *pdev)
>  	if (!info)
>  		return -EINVAL;
>  
> -	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	irq = platform_get_irq(pdev, 0);
>  	if (!irq)
>  		return -EINVAL;
>  

The change makes sense. However neither the description nor the commit message
really match here.

-- 
Ueimor

