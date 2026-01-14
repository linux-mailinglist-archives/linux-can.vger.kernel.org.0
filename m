Return-Path: <linux-can+bounces-6133-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EEAD1E07A
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 11:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2468430076BB
	for <lists+linux-can@lfdr.de>; Wed, 14 Jan 2026 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D506F2DECB2;
	Wed, 14 Jan 2026 10:27:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65455163
	for <linux-can@vger.kernel.org>; Wed, 14 Jan 2026 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386429; cv=none; b=Vdhw++WgTC0j/Zh6nuNsviH68c6/Oe2QcLhqJz+9tDFQOeGWYYfVLKwlm+R+86em0ZKczv0IS+xl+HHJXHQ8glmtofWL1os/p759gTnsUPuloylKcWbZ3adw+kRBFwF3MTMmPZwpK3w7oOgYNC46gw/GDnjxo6BM9K4/PPnw7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386429; c=relaxed/simple;
	bh=RUMfVura3/eXw0ZnXPtoe/GJYyeXJ5lVATjElpkcsyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEQM3tTmrcpVhOt8nq699dJIF4MrW+KzxBmg8lcK006s4VhCGtUg4fQFzVEFUuu42Q9ihpR+00k2H0DY3dVqSoNM4w8u9Pu/m6wqDJYq7CN1yUShWmHhEAD6HaETX+/ZpszsjC81UT4jk81cjWWnloTnFZXGM4pAZZcqkCZ6VoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vfy5f-0002sr-Tn; Wed, 14 Jan 2026 11:27:03 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vfy5g-000ZY7-0z;
	Wed, 14 Jan 2026 11:27:03 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vfy5f-00BgzC-1l;
	Wed, 14 Jan 2026 11:27:03 +0100
Date: Wed, 14 Jan 2026 11:27:03 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] can: j1939: deactivate session upon receiving the second
 rts
Message-ID: <aWdvd5lewInHv4TF@pengutronix.de>
References: <faee3f3c-b03d-4937-9202-97ec5920d699@I-love.SAKURA.ne.jp>
 <4b1fbe9d-5ca2-41e9-b252-1304cc7c215a@I-love.SAKURA.ne.jp>
 <aWZXX_FWwXu-ejEk@pengutronix.de>
 <b1212653-8fa1-44e1-be9d-12f950fb3a07@I-love.SAKURA.ne.jp>
 <20260114-sticky-inescapable-spoonbill-52932b-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114-sticky-inescapable-spoonbill-52932b-mkl@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Wed, Jan 14, 2026 at 11:22:34AM +0100, Marc Kleine-Budde wrote:
> On 14.01.2026 00:28:47, Tetsuo Handa wrote:
> > Since j1939_session_deactivate_activate_next() in j1939_tp_rxtimer() is
> > called only when the timer is enabled, we need to call
> > j1939_session_deactivate_activate_next() if we cancelled the timer.
> > Otherwise, refcount for j1939_session leaks, which will later appear as
> >
> >   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2.
> >
> > problem.
> >
> > Reported-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
> > Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> Can you provide a Fixes tag? No need to resend. I'll add it while
> applying.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

