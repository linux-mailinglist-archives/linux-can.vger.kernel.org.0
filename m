Return-Path: <linux-can+bounces-5854-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA56CB568C
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 10:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D060E300A851
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC392FD68E;
	Thu, 11 Dec 2025 09:47:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582CF381C4
	for <linux-can@vger.kernel.org>; Thu, 11 Dec 2025 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765446449; cv=none; b=ewKOTWB1GaWU6ER2tPtOJUDZYyw2KBWHOwTAU+R8z3xO7fUmqYhzffGt16LHCzxfWdnre3UzcpMlx0c7mpRcAFEfnMl391ptSNu4TMAwf7KoeD3p3iBCO3DB8JtWLlR0IhUzGIpfrxdzTqnbYk4gv0OzZnFwmYuYRUyE/C2HtBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765446449; c=relaxed/simple;
	bh=X3CCS+od8PcioliMJatxwAZSBFE7eDkIh4wqqBXlLns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpTLwM/SpOoAMkWBe0QM2rM8XmZ5twMJYqBHlw4IrXU8UBI7Vg6HMnmHUIfqxIL/W5Wfdm/ouujpMABPBwS5B5HnBu0JxdTmeIdBY6Dc4SM2eIRhJrSll+uaES+7o0wjZOT3HFdi3jnNjWETX9pELfc1PZKOknTTzpHZmjqPDxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vTdGb-00045s-0B; Thu, 11 Dec 2025 10:47:21 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vTdGa-0056dM-2b;
	Thu, 11 Dec 2025 10:47:20 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vTdGa-001J0p-2I;
	Thu, 11 Dec 2025 10:47:20 +0100
Date: Thu, 11 Dec 2025 10:47:20 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: make j1939_session_activate() fail if device
 is no longer registered
Message-ID: <aTqTKFN128IhUyCE@pengutronix.de>
References: <b9653191-d479-4c8b-8536-1326d028db5c@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9653191-d479-4c8b-8536-1326d028db5c@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Tue, Nov 25, 2025 at 10:39:59PM +0900, Tetsuo Handa wrote:
> syzbot is still reporting
> 
>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
> 
> even after commit 93a27b5891b8 ("can: j1939: add missing calls in
> NETDEV_UNREGISTER notification handler") was added. A debug printk() patch
> found that j1939_session_activate() can succeed even after
> j1939_cancel_active_session() from j1939_netdev_notify(NETDEV_UNREGISTER)
> has completed.
> 
> Since j1939_cancel_active_session() is processed with the session list lock
> held, checking ndev->reg_state in j1939_session_activate() with the session
> list lock held can reliably close the race window.
> 
> Reported-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

