Return-Path: <linux-can+bounces-5560-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E807C786FF
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 11:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 785F232E87
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D00305953;
	Fri, 21 Nov 2025 10:00:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FD334A3DB
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719211; cv=none; b=LuBrF+r3XP/UHk+TzZX1jLUd95ygbSu8jCOs+Ir1+x1RdGPlh6cKx7Y8xDFrKYXKIDuHq/WArwM80dz4Xf86kLUx/slh1/Jh2R8IPNnloFUXFRKKwElcQ5iCSUUd8NVGK0JqZQtwJh9PsF9wBr65HFy6O2g+kYoA8p9hgs/c8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719211; c=relaxed/simple;
	bh=d3E2DBFCGY5iQ48f4ruG2bjD+doCHzz4kxBZlDCuG0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECC2ft7Uu1KD7T4zDkcHrzmPoE76rcZnmk8GN814ovi5QgBixPL45tgdntwj+0hyLgKtYrX/L2aaooOcDV6YvaRhFKKSZFYs9qSmgu9Z+mMNf8wXW1rPESYPKhel6+ETHqIrIOAhLE5P2+AVclLxXVsow1R7Ic/01CoC5z1prfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vMNvw-0007Rl-CS; Fri, 21 Nov 2025 11:00:04 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vMNvw-001YyZ-0e;
	Fri, 21 Nov 2025 11:00:04 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vMNvw-00Fs20-0I;
	Fri, 21 Nov 2025 11:00:04 +0100
Date: Fri, 21 Nov 2025 11:00:04 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [can/j1939] unregister_netdevice: waiting for vcan0 to become
 free. Usage count = 2
Message-ID: <aSA4JMyFNdliTpli@pengutronix.de>
References: <d2be2d6a-6cbb-4b13-9f86-a6b7fe94983a@I-love.SAKURA.ne.jp>
 <aSArkb7-JNW-BjrG@pengutronix.de>
 <3679c610-5795-4ddf-81ad-a9a043bab3fc@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3679c610-5795-4ddf-81ad-a9a043bab3fc@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Fri, Nov 21, 2025 at 06:33:02PM +0900, Tetsuo Handa wrote:
> On 2025/11/21 18:06, Oleksij Rempel wrote:
> > Hm, looks like we have a race where new session is created in
> > j1939_xtp_rx_rts(), just at the moment where we call
> > j1939_can_rx_unregister().
> > 
> > Haw about following change:
> > 
> > --- a/net/can/j1939/main.c
> > +++ b/net/can/j1939/main.c
> > @@ -214,6 +214,7 @@ static void __j1939_rx_release(struct kref *kref)
> >                                                rx_kref);
> >  
> >         j1939_can_rx_unregister(priv);
> > +       j1939_cancel_active_session(priv, NULL);
> >         j1939_ecu_unmap_all(priv);
> >         j1939_priv_set(priv->ndev, NULL);
> >         mutex_unlock(&j1939_netdev_lock);
> > 
> 
> Well, j1939_cancel_active_session(priv, NULL) is already called from
> j1939_netdev_notify(NETDEV_UNREGISTER). Unless a session is recreated
> after NETDEV_UNREGISTER event was handled, I can't imagine such race.
> 
> We can see that there are three j1939_session_new() calls but only
> two j1939_session_destroy() calls. There might be a refcount leak on
> j1939_session which prevents j1939_priv from dropping final refcount.
> 
>   Call trace for vcan0@ffff888031c9c000 +2 at
>        j1939_session_new+0x127/0x450 net/can/j1939/transport.c:1503
>        j1939_tp_send+0x338/0x8c0 net/can/j1939/transport.c:2018
> 
>   Call trace for vcan0@ffff888031c9c000 +1 at
>        j1939_session_new+0x127/0x450 net/can/j1939/transport.c:1503
>        j1939_session_fresh_new net/can/j1939/transport.c:1543 [inline]
>        j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1628 [inline]
>        j1939_xtp_rx_rts+0xd16/0x18b0 net/can/j1939/transport.c:1749
> 
>   Call trace for vcan0@ffff888031c9c000 -2 at
>        j1939_priv_put+0x23/0x370 net/can/j1939/main.c:184
>        j1939_session_destroy net/can/j1939/transport.c:285 [inline]
>        __j1939_session_release net/can/j1939/transport.c:294 [inline]
>        kref_put include/linux/kref.h:65 [inline]
> 
> Do we want to update
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/net/can/j1939?id=5ac798f79b48065b0284216c7a0057271185a882
> in order to also try tracing refcount for j1939_session ?

Ack.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

