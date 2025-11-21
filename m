Return-Path: <linux-can+bounces-5562-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FA7C7885C
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 11:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B61A44E9E57
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9301634405E;
	Fri, 21 Nov 2025 10:31:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425B6342CA5
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763721104; cv=none; b=HS6LyQ7b++glk02/SzlFhH108CCmoYH73Fd6rwHaz/vW6Zd6UszlfCGIgnhL/gyFcoTT/Qal96JlDlQk/A60cj1l65k7CFjnKVqn2iXuQPdR8nZmE1gPNDVKzWD2qgBQF0WsN4/a0hSZzHdqbZWPna2a9jyXdI6L2nvo24vj0gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763721104; c=relaxed/simple;
	bh=B5mfb2zaAk3LMqKxrNUGJP4r1cOMlgb3FezWa/xTTv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpQfnpK08gqNRjqSUYp6w0rrigZSAFDr4dR+3rqURu/GlaxGGSEX84sMR1dhEa1CXvO1o+y2qpdtuz13gqOPQlcu4OQOV8LTmuxwY1n2mwTBzh4EG/2sgvIOFFkZSE3Clk90gD0uYCc9fF1IvDqQ4BtiYAYsz4gkvvZkY34WhVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vMOQR-0002xX-ST; Fri, 21 Nov 2025 11:31:35 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vMOQR-001ZHY-2F;
	Fri, 21 Nov 2025 11:31:35 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vMOQR-00FsSQ-1w;
	Fri, 21 Nov 2025 11:31:35 +0100
Date: Fri, 21 Nov 2025 11:31:35 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [can/j1939] unregister_netdevice: waiting for vcan0 to become
 free. Usage count = 2
Message-ID: <aSA_hyGuitJDHpB3@pengutronix.de>
References: <d2be2d6a-6cbb-4b13-9f86-a6b7fe94983a@I-love.SAKURA.ne.jp>
 <aSArkb7-JNW-BjrG@pengutronix.de>
 <3679c610-5795-4ddf-81ad-a9a043bab3fc@I-love.SAKURA.ne.jp>
 <aSA4JMyFNdliTpli@pengutronix.de>
 <c95f5436-3e7e-43b8-820b-e380f059b9f8@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c95f5436-3e7e-43b8-820b-e380f059b9f8@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Fri, Nov 21, 2025 at 07:19:24PM +0900, Tetsuo Handa wrote:
> On 2025/11/21 19:00, Oleksij Rempel wrote:
> >> Do we want to update
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/net/can/j1939?id=5ac798f79b48065b0284216c7a0057271185a882
> >> in order to also try tracing refcount for j1939_session ?
> > 
> > Ack.
> > 
> 
> I see.
> 
> By the way, I am thinking
> 
> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 88e7160d4248..f12679446990 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -477,16 +477,22 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
>  		struct net_device *ndev;
>  
>  		ndev = dev_get_by_index(net, addr->can_ifindex);
>  		if (!ndev) {
>  			ret = -ENODEV;
>  			goto out_release_sock;
>  		}
>  
> +		if (ndev->reg_state != NETREG_REGISTERED) {
> +			dev_put(ndev);
> +			ret = -ENODEV;
> +			goto out_release_sock;
> +		}
> +
>  		can_ml = can_get_ml_priv(ndev);
>  		if (!can_ml) {
>  			dev_put(ndev);
>  			ret = -ENODEV;
>  			goto out_release_sock;
>  		}
>  
>  		if (!(ndev->flags & IFF_UP)) {
> 
> as an alternative approach for
> https://lkml.kernel.org/r/9a3f9a95-1f58-4d67-9ab4-1ca360f86f79@I-love.SAKURA.ne.jp
> because I consider that getting a new refcount on net_device should be avoided
> when NETDEV_UNREGISTER event has already started.
> 
> Maybe we can do similar thing for j1939_session in order to avoid getting a new
> refcount on j1939_priv when NETDEV_UNREGISTER event has already started.
> 
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index fbf5c8001c9d..b22568fecba5 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1492,6 +1492,8 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
>  	struct j1939_session *session;
>  	struct j1939_sk_buff_cb *skcb;
>  
> +	if (priv->ndev->reg_state != NETREG_REGISTERED)
> +		return NULL;
>  	session = kzalloc(sizeof(*session), gfp_any());
>  	if (!session)
>  		return NULL;
> 

Yes, it make sense to proactively prevent the session. Good idea.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

