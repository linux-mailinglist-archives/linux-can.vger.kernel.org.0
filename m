Return-Path: <linux-can+bounces-2644-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DE5A10C1D
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2025 17:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAC1162E0E
	for <lists+linux-can@lfdr.de>; Tue, 14 Jan 2025 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AEE198E9B;
	Tue, 14 Jan 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="c3etpBcQ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051C189B8F;
	Tue, 14 Jan 2025 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871694; cv=none; b=FLoOdTiUYIIP+SjecnMYzYmA40ZX9Svpzzl3bEg1s++AGg3I/K6rlK4qqyApMIWzvyFNPGONFwm2ETQkwDIEHOxrQXhuItWixaCvVAvirOTZyc/kTrUT5jOfBFWUGDHhhUUbKtjCh69m6eLRXmgU/T551ujjU6lNl7RyZbgyL/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871694; c=relaxed/simple;
	bh=sn+Zmy6mCJQb5Vc1n+gYyGej1pawETlFig4e2XvVyXQ=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=h5oUqKNsp6lqdYm93ZRPeNjN4n/VtXIoCu8DM06VNzOGizoxCSFyJwiBDaXaeLoi+5N3yrPVLDkQ/oOKu8fddU1NGCc5yiVcrHLF1QXxkyr5LHM8iCHIey2yv5aEKtKfznnv9WlWe0YQCnkpaCFv3sPZp47VVzl7rAzlxq+u+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=c3etpBcQ; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id E4DEA44D10;
	Tue, 14 Jan 2025 17:11:33 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id ymDZRwU9WmaA; Tue, 14 Jan 2025 17:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1736870788;
	bh=OemNQe47UCdAT5Jy+ItPTfxRHUH7KhRBuUgna1noawY=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=c3etpBcQV8TcrPSKR8njiKdOCv3n99Ya+ESIeT2M4AaCFOXSjpkftsyGs1PfqFgmw
	 kofPLHs1twWuhuCSL69QwgPDHPPj+nNQmwNBN8n7YlwX28yKj8kZj8qt+niay/eqU9
	 3PnV+6AHtltAYIeI350oP2YFM6yyd/XzQWJbXjbBfXs1eWfzrGVHsdCXhkkjYpDOgJ
	 xLyIf82ZzkwBJ5YCB1VQxMG8GJWmLy8p5pyGMyq0HOHgBZtOJRfbPKczJh3M6vYiS1
	 fj0m3cLyax9SFEPVxasKfoxrxhZzu8hRBp+dK9JcqAgIPtSOk7Zi/GIuEVBkEnj5+X
	 yvDmA/j5h5iTw==
Received: from [10.0.1.209] (unknown [80.188.199.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 5EA1D44C85;
	Tue, 14 Jan 2025 17:06:28 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Fedor Pchelkin <pchelkin@ispras.ru>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ctucanfd: handle skb allocation failure
Date: Tue, 14 Jan 2025 17:06:38 +0100
User-Agent: KMail/1.9.10
Cc: Ondrej Ille <ondrej.ille@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Martin Jerabek <martin.jerabek01@gmail.com>,
 linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org,
 stable@vger.kernel.org
References: <20250114152138.139580-1-pchelkin@ispras.ru>
In-Reply-To: <20250114152138.139580-1-pchelkin@ispras.ru>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202501141706.38210.pisa@fel.cvut.cz>

Hello Fedor,

thanks for spotting the problem.

On Tuesday 14 of January 2025 16:21:38 Fedor Pchelkin wrote:
> If skb allocation fails, the pointer to struct can_frame is NULL. This
> is actually handled everywhere inside ctucan_err_interrupt() except for
> the only place.
>
> Add the missed NULL check.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE static
> analysis tool.
>
> Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source
> IP core - bus independent part.") Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

> ---
>  drivers/net/can/ctucanfd/ctucanfd_base.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c
> b/drivers/net/can/ctucanfd/ctucanfd_base.c index 64c349fd4600..f65c1a1e05cc
> 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -867,10 +867,12 @@ static void ctucan_err_interrupt(struct net_device
> *ndev, u32 isr) }
>  			break;
>  		case CAN_STATE_ERROR_ACTIVE:
> -			cf->can_id |= CAN_ERR_CNT;
> -			cf->data[1] = CAN_ERR_CRTL_ACTIVE;
> -			cf->data[6] = bec.txerr;
> -			cf->data[7] = bec.rxerr;
> +			if (skb) {
> +				cf->can_id |= CAN_ERR_CNT;
> +				cf->data[1] = CAN_ERR_CRTL_ACTIVE;
> +				cf->data[6] = bec.txerr;
> +				cf->data[7] = bec.rxerr;
> +			}
>  			break;
>  		default:
>  			netdev_warn(ndev, "unhandled error state (%d:%s)!\n",


-- 

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

