Return-Path: <linux-can+bounces-6130-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA65D1DF65
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 11:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DD9D302AFF1
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 10:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7879327B32C;
	Wed, 14 Jan 2026 10:17:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C543559E2
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385876; cv=none; b=unLD5apQVbjQoBC12FY7ORi9YJMNU2/yAj08ye9840EQrbkDGL8w+3iclUjZJ0zSwwGAqE7MhZlZ9LYdkRIkQYxrrpL3BQkdjA5ar9+u2KVAVsk+T1zjOgAAP2OQIN18VgHPuDu9/oTjmYesM6GzkWK2rYhKvmuCKNHsabkzmrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385876; c=relaxed/simple;
	bh=QqkDEFk5dyPKAN8J1Ws7pi1hlPYnkNwaLkrtUjgQAis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3V0vP7EvBi8s4EkATDqQvb3HXH0uUucVpy3OGceYx/1zW+yEKjYJ72Nohz2oYJ0ySEUmavnZCOXE1w73vMuiAmhA7BrXydUD9dtpn/opgwViUCKgM/AeL1Tgy6GzJEoIWKggr5UTxGeqdCsV2NFD0q9+ABLj1FOpha29FifYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vfxwi-0001Za-V2; Wed, 14 Jan 2026 11:17:48 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vfxwh-000ZXO-2x;
	Wed, 14 Jan 2026 11:17:47 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vfxwh-00Bgx4-0Q;
	Wed, 14 Jan 2026 11:17:47 +0100
Date: Wed, 14 Jan 2026 11:17:47 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] can: j1939: deactivate session upon receiving the second
 rts
Message-ID: <aWdtS3_i0VQLImax@pengutronix.de>
References: <faee3f3c-b03d-4937-9202-97ec5920d699@I-love.SAKURA.ne.jp>
 <4b1fbe9d-5ca2-41e9-b252-1304cc7c215a@I-love.SAKURA.ne.jp>
 <aWZXX_FWwXu-ejEk@pengutronix.de>
 <b1212653-8fa1-44e1-be9d-12f950fb3a07@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1212653-8fa1-44e1-be9d-12f950fb3a07@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Wed, Jan 14, 2026 at 12:28:47AM +0900, Tetsuo Handa wrote:
> Since j1939_session_deactivate_activate_next() in j1939_tp_rxtimer() is
> called only when the timer is enabled, we need to call
> j1939_session_deactivate_activate_next() if we cancelled the timer.
> Otherwise, refcount for j1939_session leaks, which will later appear as
> 
>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2.
> 
> problem.
> 
> Reported-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

