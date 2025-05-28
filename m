Return-Path: <linux-can+bounces-3723-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD1CAC713D
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 21:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BD91BA36BF
	for <lists+linux-can@lfdr.de>; Wed, 28 May 2025 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63FBE55B;
	Wed, 28 May 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="M/GEbG/Z"
X-Original-To: linux-can@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C5C8F77;
	Wed, 28 May 2025 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748458816; cv=none; b=Ax72uFsszW9EKirGAJXYXXTMhG7Wl6Gwde9zoQEudkkcXvFIcN9VGlupj0TQ4VJLjKrJAkwSH3Igr5XAHUX7ka4ytF8XiJnbE2JyY3Wiyinkp+ZgK/bUjuOi9RceF5rncdqVkZ5oHWbeLXEWeGNnchzQfuMMfyJ/jhrN6UjW5M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748458816; c=relaxed/simple;
	bh=UaKMHRZBd7AWy004H7nm4vmB+jEJR1s+RN6zOGZ1qEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT0UXKwjsK9byw5hB4BbUBwqGR9yfIFzLK0Jb+zcuZwMmO16in4Pxlo8dHURBI9dlC4LMPO+5SF8wmubPRlcUc2ZmC9p4gnPlFf+bVaK9PAGfLdfUjcFq92Ezw4CxGQKaHrzIvTXKLEXVn0Z/y5jU8jSYKNZ4Ueszf109j9hWaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=M/GEbG/Z; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.4])
	by mail.ispras.ru (Postfix) with ESMTPSA id 07FE8552F529;
	Wed, 28 May 2025 19:00:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 07FE8552F529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1748458807;
	bh=jBnZvA0dX2DgUTk97L2hMnnZI0PaWLfEus3H8uNv01Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/GEbG/Zu5rVfNsh68P188EVPtscKIPjHaR5BbZA/2WBrp3xNVuEVAK6uUS2YY9mk
	 ynxQQkypRJL4VmTsmV6EKarqeTB8pPzjy1GaKFxaSEfyx17+IqhBJ0/nPrTjtLguuv
	 a9OPMGk0z0nUcmcqlRJCJEMpmQCps0Yzshh7DJWM=
Date: Wed, 28 May 2025 22:00:06 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Axel Forsman <axfo@kvaser.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] can: kvaser_pciefd: refine error prone echo_skb_max
 handling logic
Message-ID: <pjk5hmqqbhhbx3zq2hqc5soqrbb4ymcwicpugj7u7xs4wk3lfk@jfz4kqhagz3x>
References: <20250528091038.4264-1-pchelkin@ispras.ru>
 <87wma1nf7c.fsf@kvaser.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wma1nf7c.fsf@kvaser.com>

On Wed, 28. May 13:32, Axel Forsman wrote:
> Thanks for finding and fixing this bug.
> 
> Fedor Pchelkin <pchelkin@ispras.ru> writes:
> 
> > Actually the trick with rounding up allows to calculate seq numbers
> > efficiently, avoiding a more consuming 'mod' operation used in the
> > current patch.
> 
> Indeed, that was the intention.
> 
> > So another approach to fix the problem would be to precompute the rounded
> > up value of echo_skb_max and pass it to alloc_candev() making the size of
> > the underlying echo_skb[] sufficient.
> 
> I believe that is preferable---if memory usage is a concern
> KVASER_PCIEFD_CAN_TX_MAX_COUNT could be lowered by one.
> Something like the following:
> 
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
> index f6921368cd14..0071a51ce2c1 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -966,7 +966,7 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>                 u32 status, tx_nr_packets_max;
> 
>                 netdev = alloc_candev(sizeof(struct kvaser_pciefd_can),
> -                                     KVASER_PCIEFD_CAN_TX_MAX_COUNT);
> +                                     roundup_pow_of_two(KVASER_PCIEFD_CAN_TX_MAX_COUNT));
>                 if (!netdev)
>                         return -ENOMEM;
> 
> @@ -995,7 +995,6 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
>                 can->tx_max_count = min(KVASER_PCIEFD_CAN_TX_MAX_COUNT, tx_nr_packets_max - 1);
> 
>                 can->can.clock.freq = pcie->freq;
> -               can->can.echo_skb_max = roundup_pow_of_two(can->tx_max_count);
>                 spin_lock_init(&can->lock);
> 
>                 can->can.bittiming_const = &kvaser_pciefd_bittiming_const;

Got it, thanks for review!

Setting KVASER_PCIEFD_CAN_TX_MAX_COUNT - value representing something like
the count of pending tx frames - to 17 (not even a multiple of 2) is quite
strange to me. This was probably done due to some hardware or protocol
specs though I've failed to find any evidence available in public access.

Will send v2 soon.

