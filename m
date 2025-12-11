Return-Path: <linux-can+bounces-5853-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0D3CB5689
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 10:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C9F73010CCA
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698662FD67B;
	Thu, 11 Dec 2025 09:46:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58906381C4
	for <linux-can@vger.kernel.org>; Thu, 11 Dec 2025 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765446414; cv=none; b=OSZlQG6clopabYK2a01Kx0wrBFGZfvN9zkp/cZ+nMA/Nlk+gCEE9o7uWXY3geY7bIuf9yUHDtMzNnnWfyVP/N/BnIleUcVT+MUT54JU9F6WoTcIlOdl4PZsjFI9AB9BetqwpQiUmAs8L6j8uDg9xRYNtYwTXjYK1NViycR44ZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765446414; c=relaxed/simple;
	bh=wTBujD56NRS3PE4o06xGGSDbop0diyPY+CUVYEqVqEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1PCSuWxB+oksUvsBK1w6Bi9fSgMeLBKNQe0dHJe9BTHWWyGP2fawzUPWq3bjCSaCkWalvQBAvfMf1/Z2CeKgBXKcAlENs6MUbfqTFNXoaElLY8qEAtdXD8Ij3XJ1jXqGLCRHOHFoJVO2ybYOsKamu++HSEOAh2coZWYejAQGcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vTdFt-0003xy-BU; Thu, 11 Dec 2025 10:46:37 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vTdFr-0056dG-2G;
	Thu, 11 Dec 2025 10:46:35 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vTdFr-001J0Y-1w;
	Thu, 11 Dec 2025 10:46:35 +0100
Date: Thu, 11 Dec 2025 10:46:35 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: make j1939_session_activate() fail if device
 is no longer registered
Message-ID: <aTqS-6tw1eokG32E@pengutronix.de>
References: <b9653191-d479-4c8b-8536-1326d028db5c@I-love.SAKURA.ne.jp>
 <33947a8d-18b2-4aa1-a4f5-5d90c4619b65@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <33947a8d-18b2-4aa1-a4f5-5d90c4619b65@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hi,

On Tue, Dec 09, 2025 at 06:43:12PM +0900, Tetsuo Handa wrote:
> Ping?

Sorry for delay.

> On 2025/11/25 22:39, Tetsuo Handa wrote:
> > Should we also make j1939_sk_queue_activate_next_locked() and
> > j1939_xtp_rx_rts_session_new() not to emit bogus warning message?
> linux-next-20251208 has gotten a trace with
> j1939_sk_queue_activate_next_locked() and j1939_xtp_rx_rts_session_new().
> Do we want to make these functions not to emit bogus warning message?
> 
> > Is this error case rare enough to tolerate bogus warning message?

Good question. You are right, error messages do not reflect the reality.

May be something like this?

j1939_sk_queue_activate_next_locked(struct j1939_session *session)

	ret = j1939_session_activate(first);
	if (ret) {
		if (ret == -EAGAIN || ret == -EBUSY)
			netdev_warn_once(first->priv->ndev,
					 "%s: 0x%p: Identical session is already activated.\n",
					 __func__, first);
		else
			netdev_warn_once(first->priv->ndev,
					 "%s: 0x%p: Activation failed with err %i.\n",
					 __func__, first, ret);

		first->err = ret;
		goto activate_next;
	}


j1939_xtp_rx_rts_session_new(struct j1939_priv *priv, struct ...

	ret = j1939_session_activate(session);
	if (ret) {
		if (ret == -EAGAIN)
			netdev_alert(priv->ndev, "%s: 0x%p: concurrent session with same addr (%02x %02x) is already active.\n",
			     __func__, session, skcb.addr.sa, skcb.addr.da);
		else
			netdev_warn(priv->ndev, "%s: 0x%p: session activation failed: %i\n",
				    __func__, session, ret);

		j1939_session_put(session);
		return NULL;

This can be done in a separate patch later.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

