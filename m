Return-Path: <linux-can+bounces-5122-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B36BD00D8
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 11:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3723B9E41
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 09:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5263C1DB122;
	Sun, 12 Oct 2025 09:45:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018C212551
	for <linux-can@vger.kernel.org>; Sun, 12 Oct 2025 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760262310; cv=none; b=hN+MoAfDdYODSuFIyRK0G6YklJPHUOglLbggce1Jm9wYPRUxwd2uluJeh08s2hNOAYjToNqm8Yp7mHytRgDTKBWVVhnBSoh69HsAG7pDv0S1ITn+HHkHcinCnul2L1iZGHYmUdGpvV+JAFo2ROiw2YyZNZpij1ss55x4iv7rqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760262310; c=relaxed/simple;
	bh=exHszMMt/tK0SgxzHum4oSUj6rIohx1DcoZzXra370Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bdu3wI9ixgB1x5Tlo/PXp52p2CWIDDgB10TsSXdTgvk0BHPBS5dYTUttFmumlSCaWxigofxgtMVgVWesHD6MghTE0jvjTWd9T0GVgNxKT+nr3CxMqrH/VC8Vh32WXLu+LGL3RrbuBY8Pp6GkI3FSPMJiN3Sb5uuBqoYquuDtJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v7sMx-0006eK-B3; Sun, 12 Oct 2025 11:27:59 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v7sMv-003CLR-2j;
	Sun, 12 Oct 2025 11:27:57 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v7sMv-009qEW-2N;
	Sun, 12 Oct 2025 11:27:57 +0200
Date: Sun, 12 Oct 2025 11:27:57 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: add missing calls in NETDEV_UNREGISTER
 notification handler
Message-ID: <aOt0nS7i9qpH_8QM@pengutronix.de>
References: <3ad3c7f8-5a74-4b07-a193-cb0725823558@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ad3c7f8-5a74-4b07-a193-cb0725823558@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Hi,

On Sat, Sep 27, 2025 at 09:11:16PM +0900, Tetsuo Handa wrote:
> Currently NETDEV_UNREGISTER event handler is not calling
> j1939_cancel_active_session() and j1939_sk_queue_drop_all().
> This will result in these calls being skipped when j1939_sk_release() is
> called. And I guess that the reason syzbot is still reporting
> 
>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
> 
> is caused by lack of these calls.
> 
> Calling j1939_cancel_active_session(priv, sk) from j1939_sk_release() can
> be covered by calling j1939_cancel_active_session(priv, NULL) from
> j1939_netdev_notify().
> 
> Calling j1939_sk_queue_drop_all() from j1939_sk_release() can be covered
> by calling j1939_sk_netdev_event_netdown() from j1939_netdev_notify().
> 
> Therefore, we can reuse j1939_cancel_active_session(priv, NULL) and
> j1939_sk_netdev_event_netdown(priv) for NETDEV_UNREGISTER event handler.
> 
> Fixes: 7fcbe5b2c6a4 ("can: j1939: implement NETDEV_UNREGISTER notification handler")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

I tried to reproduce this issue by making transfers and removing vcan
interface at same time. I have not seen any issue, but may be i'm just
missing some kernel configuration.

In any case it seems to not make anything wrong and looks logically
correct. 
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

