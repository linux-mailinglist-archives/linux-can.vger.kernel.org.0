Return-Path: <linux-can+bounces-5855-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9CDCB5695
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 10:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C05C33007E57
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7FD1C860C;
	Thu, 11 Dec 2025 09:49:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990A22128B
	for <linux-can@vger.kernel.org>; Thu, 11 Dec 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765446589; cv=none; b=p9BlMHLNX1yMyZaElaNZAU/78lR3qkCGmnXovC8Hnat5xOfQENYv0uQkW99iNCF69Eeu4qaL/bTd+K5rYtHNIixzhiXkstF2aGsQ/EdzFizBEyWgcqYfSEtCdZ1QZPLYnFqkMYYwui9UPW2ABwmjpxQU00AsrrePDQ+f+FFqGGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765446589; c=relaxed/simple;
	bh=ffa8cY0zq+xDPFWeHkActUSpP0cTxhSyuTbK8o5SkZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msTzKOIUhUdiH3Gquz76dHqe8ZGvDJfFMxqfBBxRRjX0cfdTtva7GSU5ND55OjFV7mw8GF9BtLsQNz1SVuJ0Yd5B0UOYatK62fVXn5RWPQILudjg3Xf4KbUDRqNq63OYu6tddX/6r8Yh/Bz/Hpa+cuanRHyl9zswgYMT/tNrYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vTdIs-0004Sy-6R; Thu, 11 Dec 2025 10:49:42 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vTdIr-0056da-3B;
	Thu, 11 Dec 2025 10:49:41 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vTdIr-001J21-2q;
	Thu, 11 Dec 2025 10:49:41 +0100
Date: Thu, 11 Dec 2025 10:49:41 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: j1939: make j1939_sk_bind() fail if device is no
 longer registered
Message-ID: <aTqTtVAU11_NiJOf@pengutronix.de>
References: <9a3f9a95-1f58-4d67-9ab4-1ca360f86f79@I-love.SAKURA.ne.jp>
 <5732921e-247e-4957-a364-da74bd7031d7@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5732921e-247e-4957-a364-da74bd7031d7@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Tue, Nov 25, 2025 at 10:43:12PM +0900, Tetsuo Handa wrote:
> There is a theoretical race window in j1939_sk_netdev_event_unregister()
> where two j1939_sk_bind() calls jump in between read_unlock_bh() and
> lock_sock().
> 
> The assumption jsk->priv == priv can fail if the first j1939_sk_bind()
> call once made jsk->priv == NULL due to failed j1939_local_ecu_get() call
> and the second j1939_sk_bind() call again made jsk->priv != NULL due to
> successful j1939_local_ecu_get() call.
> 
> Since the socket lock is held by both j1939_sk_netdev_event_unregister()
> and j1939_sk_bind(), checking ndev->reg_state with the socket lock held can
> reliably make the second j1939_sk_bind() call fail (and close this race
> window).
> 
> Fixes: 7fcbe5b2c6a4 ("can: j1939: implement NETDEV_UNREGISTER notification handler")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

I guess, this one is needed too:
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

