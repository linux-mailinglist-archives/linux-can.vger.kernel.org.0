Return-Path: <linux-can+bounces-6121-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 838A6D197DB
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 15:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCECA3006F72
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6886F2836B5;
	Tue, 13 Jan 2026 14:32:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E0327EC80
	for <linux-can@vger.kernel.org>; Tue, 13 Jan 2026 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314730; cv=none; b=QgGatOhGAxe0C2R+Z67EAl6+sscQ0kQlHE2mFfGuHCGdAFOM49EVnwwZk3uKvnCDr40ey6QuGa/i8grYjqPmax9k4ho3TSKfMMUcAxBA0wdfN2L8aYjjFXGrZhj0ieBAgr+SWGqYxe4Buv0v8br6qaNA9d2p4grc8uCY0tc0tsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314730; c=relaxed/simple;
	bh=UUC360G7hHA1urjzlmBV49AhilqbSpaiCfBOoZFfi0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQUlvQoJKtvy/NEsmvHTaxUB/FVQt7qxoca1Q0+4KqAP0WD9dpXBHatPO/1zb3yVYiRJwK84/GGyRFvzS0sSQukga3ZGZH+HF+OWbi9d/hwtJ2pWgMHOgZ/nq+UmjyiSaZ8bfNKIcvOsYSgLFNmc0pqNGkeZ4V3oNFMQlIs+X/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vffRB-0007zC-Qz; Tue, 13 Jan 2026 15:32:01 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vffRA-000RDq-0Y;
	Tue, 13 Jan 2026 15:31:59 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vffR9-009thO-1D;
	Tue, 13 Jan 2026 15:31:59 +0100
Date: Tue, 13 Jan 2026 15:31:59 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	Network Development <netdev@vger.kernel.org>
Subject: Re: can: j1939: unregister_netdevice: waiting for vcan0 to become
 free.
Message-ID: <aWZXX_FWwXu-ejEk@pengutronix.de>
References: <faee3f3c-b03d-4937-9202-97ec5920d699@I-love.SAKURA.ne.jp>
 <4b1fbe9d-5ca2-41e9-b252-1304cc7c215a@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b1fbe9d-5ca2-41e9-b252-1304cc7c215a@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hi,

On Tue, Jan 13, 2026 at 12:46:30PM +0900, Tetsuo Handa wrote:
> Currently, the (session->last_cmd != 0) path in j1939_xtp_rx_rts_session_active() is
> preventing the (session->state == J1939_SESSION_WAITING_ABORT) path in j1939_tp_rxtimer()
>  from being called. This results in two j1939_priv refcounts leak (which in turn results in
> one net_device refcount leak) due to j1939_session_deactivate_activate_next() being not called.
> 
> This problem goes away if I do either
> 
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1689,16 +1692,18 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
> 
>         if (session->last_cmd != 0) {
>                 /* we received a second rts on the same connection */
> -               netdev_alert(priv->ndev, "%s: 0x%p: connection exists (%02x %02x). last cmd: %x\n",
> +               netdev_alert(priv->ndev, "%s (modified): 0x%p: connection exists (%02x %02x). last cmd: %x\n",
>                              __func__, session, skcb->addr.sa, skcb->addr.da,
>                              session->last_cmd);
> 
> +               /*
>                 j1939_session_timers_cancel(session);
>                 j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
>                 if (session->transmission)
>                         j1939_session_deactivate_activate_next(session);
> 
>                 return -EBUSY;
> +               */
>         }
> 
>         if (session->skcb.addr.sa != skcb->addr.sa ||
> 
> or
> 
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1697,6 +1700,11 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
>                 j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
>                 if (session->transmission)
>                         j1939_session_deactivate_activate_next(session);
> +               else if (session->state == J1939_SESSION_WAITING_ABORT) {

This way looks better for me. May be add a comment like this:
            /* Force deactivation for the receiver.
             * If we rely on the timer starting in j1939_session_cancel, 
             * a second RTS call here will cancel that timer and fail 
             * to restart it because the state is already WAITING_ABORT.
             */

> +                       netdev_alert(priv->ndev, "%s (modified): 0x%p: abort rx timeout. Force session deactivation\n",
> +                                    __func__, session);
> +                       j1939_session_deactivate_activate_next(session);
> +               }
> 
>                 return -EBUSY;
>         }
> 
> . But what is the correct approach?

The second one. Thank you for your work.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

