Return-Path: <linux-can+bounces-2068-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A379D9CE12A
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2024 15:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E162810D2
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2024 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326A71C07F6;
	Fri, 15 Nov 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MWpnVAZN"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF671B6D04;
	Fri, 15 Nov 2024 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680647; cv=none; b=kOY2zf8XCu3GCVFrmhXyS3x84n0N4BASFDH2MvlypvbSfzrwsj+bfb1Fcj6iL7rSJBreOxhvj6+qe0qRynodkUGbJGKMBdKfQxkVJMt1Oivy/R1ypSA22jbipnnhaoiS6DLvHEh0ifeQVzCrPPlqNmR7uGUe9fQP45l67dsm4D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680647; c=relaxed/simple;
	bh=ZAJm8sRyMgHeqDYq2g0gYxruxP8A5hFarzJKR1sexLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUMkGkEoNjEWrggYKuNdf9YdL7fcGeIvTNDGPHec+CVcYRkitRer1x1P3y1xuN5Jktsv2J2scaGG6ynAkDu2CKtP+3MujkfCzo23sAW4qiV1dORXz4cQPuUV5IPg9kSnf3mw1SlZjNFsMYOqapFiL3DuHNubA/xb5CB3vDG+87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MWpnVAZN; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BxEktwCuEW6lUBxEltPHts; Fri, 15 Nov 2024 15:23:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731680636;
	bh=VzeyJ15d8Kqt4SkaG0aV0KP9QtJ7VgXr88uy/APDKRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=MWpnVAZNEJiLHDbpNLOP4V35gS1DW7I/JTyWUqdUHi6N8QcceCI20QtsrKGlwKGhX
	 AbkJFvROsMAZVcKM7DoXXTs83Ayhk5s3r4KPYfzefKV3xLi8TQ7z14TyhBV5eCBUfc
	 Xsv1bJ1v9AgWKx47P5BlZiXGAOYJ7R4wHhXf0Tavok8dymzBIOBdpbHsGDPxY1H7eb
	 QsNyNwB4mvd0Ru59L2jI4swh/6QiDCFxJkQE+k9UKhMA97eZRIzRq8KWanwtGgFAfO
	 18RyE5x0hFYYsRgRQazkqiu9nftdLN8wqEwWudEynuA9jD/A56COhMu6dUn3xwK7JH
	 WPotjHIfJZ2yg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 Nov 2024 15:23:56 +0100
X-ME-IP: 124.33.176.97
Message-ID: <e18c1e3d-4342-4ddc-93d3-975ecc336185@wanadoo.fr>
Date: Fri, 15 Nov 2024 23:23:49 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH can-next v2 1/3] can: m_can: add deinit callback
To: Sean Nyekjaer <sean@geanix.com>,
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241115-tcan-standby-v2-0-4eb02026b237@geanix.com>
 <20241115-tcan-standby-v2-1-4eb02026b237@geanix.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241115-tcan-standby-v2-1-4eb02026b237@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/11/2024 at 17:15, Sean Nyekjaer wrote:
> This is added in preparation for calling standby mode in the tcan4x5x
> driver or other users of m_can.
> For the tcan4x5x; If Vsup 12V, standby mode will save 7-8mA, when the
> interface is down.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/net/can/m_can/m_can.c | 10 +++++++---
>  drivers/net/can/m_can/m_can.h |  1 +
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index a7b3bc439ae596527493a73d62b4b7a120ae4e49..667c70f8dc5e7e8b15b667119b63dea1fe667e8a 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1750,12 +1750,16 @@ static void m_can_stop(struct net_device *dev)
>  
>  	/* Set init mode to disengage from the network */
>  	ret = m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
> -	if (ret)
> -		netdev_err(dev, "failed to enter standby mode: %pe\n",
> -			   ERR_PTR(ret));
>  
>  	/* set the state as STOPPED */
>  	cdev->can.state = CAN_STATE_STOPPED;
> +
> +	if (!ret && cdev->ops->deinit)
> +		ret = cdev->ops->deinit(cdev);

Question: is there a reason not to try to deinit() even if the
m_can_cccr_update_bits() failed?

> +	if (ret)
> +		netdev_err(dev, "failed to enter standby mode: %pe\n",
> +			   ERR_PTR(ret));>  }
>  
>  static int m_can_close(struct net_device *dev)
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index 92b2bd8628e6b31370f4accbc2e28f3b2257a71d..6206535341a22a68d7c5570f619e6c4d05e6fcf4 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -68,6 +68,7 @@ struct m_can_ops {
>  	int (*write_fifo)(struct m_can_classdev *cdev, int addr_offset,
>  			  const void *val, size_t val_count);
>  	int (*init)(struct m_can_classdev *cdev);
> +	int (*deinit)(struct m_can_classdev *cdev);
>  };
>  
>  struct m_can_tx_op {
> 

Yours sincerely,
Vincent Mailhol


