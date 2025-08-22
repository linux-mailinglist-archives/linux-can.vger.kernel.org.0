Return-Path: <linux-can+bounces-4308-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE5BB3146B
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 11:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01F8BA2BD0
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0942321ABC9;
	Fri, 22 Aug 2025 09:51:32 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0D1C3306
	for <linux-can@vger.kernel.org>; Fri, 22 Aug 2025 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856291; cv=none; b=H12uNrv08d8f7JR+ZKSmXYCwl9TLciV1CwP0VMc4zKOHaPCz0O03SjPsjokr1JCLMMo+ewKzxWcUOl/t/Kg8QPlMK4w3jyUmLG88i8n8ntYGNbiE6dlzuDkfvhbRjVyX7T0s48VVed3ueefi1KA2E5R3no8pGykwl8Rt1Ee3wwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856291; c=relaxed/simple;
	bh=8v1zu7FbFT5zGaFyS+U86qwFLsQ4LJfn2ILDpx4uklQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRih/dLbVLdG8yWfburQOo8hFiYXvlh3X5MRq5zm/9ZeLQUPJW4YJNZ5kfMV0M/X5II0OMVWMOK6XEqBQ89XH+3mDEd8G6Atho2PQFjJrhSXhnUNO240PtoZvzqlxxRZCxgnhAn6YbgyoOe6XBP3p4mVScb/9s2UbFioDZ0FaRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1upOQd-0000nC-6n; Fri, 22 Aug 2025 11:51:23 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1upOQb-001YYS-1P;
	Fri, 22 Aug 2025 11:51:21 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1upOQb-00A5Ry-10;
	Fri, 22 Aug 2025 11:51:21 +0200
Date: Fri, 22 Aug 2025 11:51:21 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: can/j1939: hung inside rtnl_dellink()
Message-ID: <aKg9mTaSxzBVpTVI@pengutronix.de>
References: <50055a40-6fd9-468f-8e59-26d1b5b3c23d@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50055a40-6fd9-468f-8e59-26d1b5b3c23d@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hello Tetsuo,

On Sat, Aug 16, 2025 at 03:51:54PM +0900, Tetsuo Handa wrote:
> Hello.
> 
> I made a minimized C reproducer for
> 
>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
> 
> problem at https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 , and
> obtained some data using debug printk() patch. It seems that the cause is
> net/can/j1939/ does not handle NETDEV_UNREGISTER notification
> while net/can/j1939/ can directly call rtnl_dellink() via sendmsg().

Sorry for long delay and than you for your investigation!

> The minimized C reproducer is shown below.
....

> Therefore, I guess that either
> 
>   j1939_netdev_notify() is handling NETDEV_UNREGISTER notification
> 
> or
> 
>   rtnl_dellink() can be called via sendmsg() despite the j1939 socket
>   are in use
> 
> is wrong. How to fix this problem?

I assume the first variant is correct. Can you please test following change:
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -370,6 +370,7 @@
 		goto notify_done;
 
 	switch (msg) {
+	case NETDEV_UNREGISTER:
 	case NETDEV_DOWN:
 		j1939_cancel_active_session(priv, NULL);
 		j1939_sk_netdev_event_netdown(priv);

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

