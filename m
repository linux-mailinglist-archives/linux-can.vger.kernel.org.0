Return-Path: <linux-can+bounces-5547-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B6AC780BC
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 5B4AE2B96C
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4227633EAE7;
	Fri, 21 Nov 2025 09:06:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E1233E374
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763715993; cv=none; b=HujuzpD0lCG7u9kVoVUGGEXaF6hXmS8cJaX6Jmi/AJZlr03UsHn9sx0KEpI39Vo0KCmnz/bDYzAHORhoAPuljtN2r3dNWHhPVUanNCQai7m4o62nkvBCBP90npe7rBHq0+7QNIV01Ytdsnc1vp15K04t5PSNf+lau286R6Emz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763715993; c=relaxed/simple;
	bh=aBZVXTtliSl0fE61ooeiKF65NPIvHb168yUY1QfBc/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLi1CU0sOWE0GO3C/1Rd7ROP061NVO7ovhKZ0mi0BmfzqccC3i3ol2r2QdaWbvI84Xw7TnF6vCW4OFaIc08cLWKbRK5WomCqq8u0plm3IX0anzqkxhWSlRHM/iXLJcqoBhllV158+jacvpoRhCDOLPxCezPjo2wH+aU/tqhZHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vMN62-0002FF-8O; Fri, 21 Nov 2025 10:06:26 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vMN61-001YpB-0r;
	Fri, 21 Nov 2025 10:06:25 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vMN61-00FrJC-0U;
	Fri, 21 Nov 2025 10:06:25 +0100
Date: Fri, 21 Nov 2025 10:06:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [can/j1939] unregister_netdevice: waiting for vcan0 to become
 free. Usage count = 2
Message-ID: <aSArkb7-JNW-BjrG@pengutronix.de>
References: <d2be2d6a-6cbb-4b13-9f86-a6b7fe94983a@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2be2d6a-6cbb-4b13-9f86-a6b7fe94983a@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hello Tetsuo,

On Thu, Nov 20, 2025 at 07:11:22PM +0900, Tetsuo Handa wrote:
> Hello.
> 
> I am using a debug printk() patch for j1939_priv which records/counts where
> refcount for j1939_priv has changed, and syzbot succeeded to record/count a
> j1939_priv leak in next-20251119
> ( https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 ).
> 
> The output from the debug printk() patch is shown below. I think that
> understanding what actions have been taken on this j1939_priv object will
> help you finding the cause of j1939_priv leak bug.

Hm, looks like we have a race where new session is created in
j1939_xtp_rx_rts(), just at the moment where we call
j1939_can_rx_unregister().

Haw about following change:

--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -214,6 +214,7 @@ static void __j1939_rx_release(struct kref *kref)
                                               rx_kref);
 
        j1939_can_rx_unregister(priv);
+       j1939_cancel_active_session(priv, NULL);
        j1939_ecu_unmap_all(priv);
        j1939_priv_set(priv->ndev, NULL);
        mutex_unlock(&j1939_netdev_lock);

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

