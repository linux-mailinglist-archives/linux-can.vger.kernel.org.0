Return-Path: <linux-can+bounces-2318-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E41F9E32AC
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 05:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3C1168758
	for <lists+linux-can@lfdr.de>; Wed,  4 Dec 2024 04:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56C61514CC;
	Wed,  4 Dec 2024 04:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lUm+2gP1"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-14.smtpout.orange.fr [193.252.22.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79A41C85;
	Wed,  4 Dec 2024 04:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287075; cv=none; b=fChxFtLNXwZYmJGyWJk3SgKhrqHxoA8UK9IXH5h7a2L/TZcl2WBpI7tCKXM2CT4s9eb4r1CPJgVGikgNTRW8n8GVrJeV8BLROZuHPgzsejsuA/geysFzNuAoxS9i7iwNYQXn8GB3AXB7QtEYt5+vGSvm7pwBLUz/XQare6i323Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287075; c=relaxed/simple;
	bh=KVaE46aHebdCh6WZ9W4YES3U6O7EbJ4RLpIJXCR51X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVq8ax2ha0YfoUKi/tCtLGVlyq1Rn86Vo0Xs5Tf+Sv4DsZi/vXF1YFtrVzHbXY0dayUpdFanXMTt0+W2b7tAKblFhM3CwrsS/GQUzmLQqHk8Wc8TfVw7ULCSfRKSiUtmDQ8hQL6+hcwPr93PWT2t7AIrm3BDO0WWe+l7NrFgg+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lUm+2gP1; arc=none smtp.client-ip=193.252.22.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f49.google.com ([209.85.218.49])
	by smtp.orange.fr with ESMTPSA
	id Ih93tvZCrLhLoIh93tPDae; Wed, 04 Dec 2024 05:37:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733287069;
	bh=K0YcF5eBl3Z11+dKfpTGFzHX2+zdqIzQuZXVH2EgLzY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=lUm+2gP1XxmDOD/LyukD+yOciYXGCF8ew4ME+OIKlJrSkUZCGRrz7vJVcy5UGncS6
	 pdjRk9d3rZ/crJ+mf2joE75Jl2Jkp5qrZIa46hQ0bdXdvjoI2vOOMU4ei1h7N+98zE
	 eQjf5yUlhb04cuEcRoMroivgel217zXK6Y22DA3TWEqC8BuBb4BbaEmmAh1NViDMcq
	 i/yk57L7vsWrs4rdprmNWcXttneEGFH7XzcOcPvBpyYgY142oijskD69bVWn/HE7PI
	 5TqNdbL4NOHHHRM/riAJLukC2q2ov0re+QaqVKXOYd1+vCvnu4Me0dVfglyHt5B4ok
	 MB2cF5tmeomlQ==
X-ME-Helo: mail-ej1-f49.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 04 Dec 2024 05:37:49 +0100
X-ME-IP: 209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa549d9dffdso1005130366b.2;
        Tue, 03 Dec 2024 20:37:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4eNQxzeWQ3vsWT20h+lgCRlG1pCiESTQbsCQKQF2SLPNLbtr5m3qCFf8zJ6jBwjcAVZwivzYJeiE=@vger.kernel.org, AJvYcCXe/R6ZZjXzBl3aqblCWtnTrq8XgUpmTFTQS1WXFHYLJusaRmjeFU1NOQo2wzzcjvTJptU+F9i9Xh+6EKjU@vger.kernel.org
X-Gm-Message-State: AOJu0YwXuZ82DoBAJ8Y+xEF3Cm2Oc3xU/wSVkCcANoBRRTMuq5ul9n0O
	xYFX7wYQ9Mp9EhmeJxKg8v/QIHjcRhAdVhrxK9S2CY7aye48CwsCyVDBokgnXsoR1Oph+VihK9W
	jb34TUL5RVleEYOnkn/AgRn1PTCk=
X-Google-Smtp-Source: AGHT+IHcBOtplu5vcO94r/xRZCoJTOHel8JRhuKlEs+VKsq8ZPQd0iWFLejRKIealVsnlL0S/aZeCDYmgY5iNzmogOU=
X-Received: by 2002:a17:907:7d94:b0:a99:fc3d:7c76 with SMTP id
 a640c23a62f3a-aa5f7f007e6mr472251266b.37.1733287069264; Tue, 03 Dec 2024
 20:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203231337.182391-1-rosenp@gmail.com>
In-Reply-To: <20241203231337.182391-1-rosenp@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Wed, 4 Dec 2024 13:37:38 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+ykc4xNbGC52cgjw6uLFXZKwkeGDWk=19=nZMnvq_L+A@mail.gmail.com>
Message-ID: <CAMZ6Rq+ykc4xNbGC52cgjw6uLFXZKwkeGDWk=19=nZMnvq_L+A@mail.gmail.com>
Subject: Re: [PATCH] net: simplify resource acquisition + ioremap
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
	maxime.chevallier@bootlin.com, Madalin Bucur <madalin.bucur@nxp.com>, 
	Sean Anderson <sean.anderson@seco.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Rosen,

Thanks for the patch!

On Wed. 4 Dec. 2024 at 08:13, Rosen Penev <rosenp@gmail.com> wrote:
> get resource + request_mem_region + ioremap can all be done by a single
> function.
>
> Replace them with devm_platform_get_and_ioremap_resource or\
> devm_platform_ioremap_resource where res is not used.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/can/sja1000/sja1000_platform.c | 15 ++--------

For the can driver only:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr> # sja1000_platform.c

>  drivers/net/ethernet/freescale/fman/fman.c | 35 +++++-----------------
>  drivers/net/ethernet/lantiq_etop.c         | 25 ++--------------
>  drivers/net/mdio/mdio-octeon.c             | 25 +++-------------
>  4 files changed, 17 insertions(+), 83 deletions(-)

