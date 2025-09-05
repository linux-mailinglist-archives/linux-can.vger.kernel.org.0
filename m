Return-Path: <linux-can+bounces-4489-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA9FB4518E
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 10:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64146A62593
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 08:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F8A301484;
	Fri,  5 Sep 2025 08:29:52 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D52FD1A4
	for <linux-can@vger.kernel.org>; Fri,  5 Sep 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060992; cv=none; b=bSqC4iVo0VCgGuTTcYiK3D116PXWzz8wgBfcElL3TxWRxeNAl7RcRNhFFt7ul5m/d59keB0ZVgHR5yPsapck/BDQtkINVWpw+2++RjlNXn752Zmt9ANMPKn9HzBOw/nuWG2yT46gFJIzBNbSD8lbo7hM4FCEGbVeVxygDxfo9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060992; c=relaxed/simple;
	bh=9rdfJyKG2DUhxz14oH6OZktd5zK8IUdQCnL8L2Q9QpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxRVZDpoewRRjXkzNb/c+EphwDBWxGnIq5w7d5CbaIzyLdmmejOkU6t+dvG+8mXkMs38M6L2MYEtoROrndEwBOpvi1RXw5OqVU39P8BlU01OYLScTIP+4TN6dpDY4/mbu/CJzzK2QqehmU3KHDyi/aqfH5tX7Dlmmojbb8BEiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uuRpA-0006ET-8M; Fri, 05 Sep 2025 10:29:36 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uuRp8-003rTW-20;
	Fri, 05 Sep 2025 10:29:34 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uuRp8-004GpZ-1T;
	Fri, 05 Sep 2025 10:29:34 +0200
Date: Fri, 5 Sep 2025 10:29:34 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH] can: j1939: implement NETDEV_UNREGISTER notification
 handler
Message-ID: <aLqfbnVEdoS1whkR@pengutronix.de>
References: <50055a40-6fd9-468f-8e59-26d1b5b3c23d@I-love.SAKURA.ne.jp>
 <aKg9mTaSxzBVpTVI@pengutronix.de>
 <bb595640-0597-4d18-a9e1-f6eb8e6bb50e@I-love.SAKURA.ne.jp>
 <c1e50f41-da30-4cea-859c-05db0ab8040b@I-love.SAKURA.ne.jp>
 <ac9db9a4-6c30-416e-8b94-96e6559d55b2@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac9db9a4-6c30-416e-8b94-96e6559d55b2@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Mon, Aug 25, 2025 at 11:07:24PM +0900, Tetsuo Handa wrote:
> syzbot is reporting
> 
>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
> 
> problem, for j1939 protocol did not have NETDEV_UNREGISTER notification
> handler for undoing changes made by j1939_sk_bind().
> 
> Commit 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct
> callback") expects that a call to j1939_priv_put() can be unconditionally
> delayed until j1939_sk_sock_destruct() is called. But we need to call
> j1939_priv_put() against an extra ref held by j1939_sk_bind() call
> (as a part of undoing changes made by j1939_sk_bind()) as soon as
> NETDEV_UNREGISTER notification fires (i.e. before j1939_sk_sock_destruct()
> is called via j1939_sk_release()). Otherwise, the extra ref on "struct
> j1939_priv" held by j1939_sk_bind() call prevents "struct net_device" from
> dropping the usage count to 1; making it impossible for
> unregister_netdevice() to continue.
> 
> Reported-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> Tested-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Fixes: 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct callback")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

