Return-Path: <linux-can+bounces-5071-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B863BAF5F3
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 09:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186107A2605
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF7D3A8F7;
	Wed,  1 Oct 2025 07:19:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C93770B
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 07:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759303149; cv=none; b=gvCiRYk4hb+sA/Ddr2Ywmbpg1HAs6X0t1xaViE03pDnGd0mClOcaRY0d+MfivxzvexDm9BZpFvEPFuXFK5EH2NZxGnhw0L80B4c910LMbmhHQ6Po0G8yZRFn+mcSGPdHrtC65TdeZS3Hvslf9VBq3Lu5l5Vav+fi3+n69ViOkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759303149; c=relaxed/simple;
	bh=xhk0Sec0q7nBwZjZzn77/Hhj9nqLVfz9KEkfpRYVYXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBWjCvm8ZCJZLLFXwPe4z2cTmkgP8x69XYSFWkoHx0H8MVgXHB52HjsTI1FB0/TnfIp5r4HBhAoPNYbbCAhg3+G11rntPW5wkxvtxAQ8Dtspoy7mzZmzHehCOcwa37xq0WGwUDqDtSjhP/PduR4reWirJSg7CxcGlIlJy3kJCVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v3r73-0003Re-Do; Wed, 01 Oct 2025 09:18:57 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v3r71-001NKH-31;
	Wed, 01 Oct 2025 09:18:55 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v3r71-006R3v-2Z;
	Wed, 01 Oct 2025 09:18:55 +0200
Date: Wed, 1 Oct 2025 09:18:55 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: add missing calls in NETDEV_UNREGISTER
 notification handler
Message-ID: <aNzV3-YY09yDK_T1@pengutronix.de>
References: <3ad3c7f8-5a74-4b07-a193-cb0725823558@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ad3c7f8-5a74-4b07-a193-cb0725823558@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hi Tetsuo,

Thank you for your work. I'll try to review/test it as soon as possible.

Best Regards,
Oleksij

On Sat, Sep 27, 2025 at 09:11:16PM +0900, Tetsuo Handa wrote:
> Currently NETDEV_UNREGISTER event handler is not calling
> j1939_cancel_active_session() and j1939_sk_queue_drop_all().
> This will result in these calls being skipped when j1939_sk_release() is
> called. And I guess that the reason syzbot is still reporting
> 
>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
> 
> is caused by lack of these calls.
> 
> Calling j1939_cancel_active_session(priv, sk) from j1939_sk_release() can
> be covered by calling j1939_cancel_active_session(priv, NULL) from
> j1939_netdev_notify().
> 
> Calling j1939_sk_queue_drop_all() from j1939_sk_release() can be covered
> by calling j1939_sk_netdev_event_netdown() from j1939_netdev_notify().
> 
> Therefore, we can reuse j1939_cancel_active_session(priv, NULL) and
> j1939_sk_netdev_event_netdown(priv) for NETDEV_UNREGISTER event handler.
> 
> Fixes: 7fcbe5b2c6a4 ("can: j1939: implement NETDEV_UNREGISTER notification handler")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>



> ---
> I couldn't tell whether NETDEV_UNREGISTER event handler should also call
> j1939_ecu_unmap_all(), for there seems to be no corresponding call in
> j1939_sk_release()...
> 
>  net/can/j1939/main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> index 3706a872ecaf..a93af55df5fd 100644
> --- a/net/can/j1939/main.c
> +++ b/net/can/j1939/main.c
> @@ -378,6 +378,8 @@ static int j1939_netdev_notify(struct notifier_block *nb,
>  		j1939_ecu_unmap_all(priv);
>  		break;
>  	case NETDEV_UNREGISTER:
> +		j1939_cancel_active_session(priv, NULL);
> +		j1939_sk_netdev_event_netdown(priv);
>  		j1939_sk_netdev_event_unregister(priv);
>  		break;
>  	}
> -- 
> 2.47.3
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

