Return-Path: <linux-can+bounces-4505-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A16B48379
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 06:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F563BEEA4
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 04:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58C81386C9;
	Mon,  8 Sep 2025 04:57:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E29A2206A9
	for <linux-can@vger.kernel.org>; Mon,  8 Sep 2025 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757307439; cv=none; b=Y4j8QJVxoS1XAx1oTb8xnQJXP0ioUYeDhPz7gdOahz+Pl4BSRovNdm28PCJXvWK6MqDjUAHk0jv1PuMtsFRz/z8a9DZ75F9lulwZc+YPcCv9/W0jxKnHpzPcO6BzXniAADO82mRwL2BVYB2DR9/6fniKrtE5kHpCwSTFy8+rWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757307439; c=relaxed/simple;
	bh=+Yj/8DvTkJae7lsB9tgfHbReVRXpaosKtsfWGMj9iAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr3RtiBPHFaJpOB5xoqR1PGT9sXSFBD3MCLuWHB7IY64vJUViS6SGncOOFlTsyAIUlAurAi8BRUFIWD/QA0eW9O7/4an0f6Q8XiMVrQTq72JTWz2p5gzIl6wCxiDtGRVeTo8qjASikasjUgSsqA6Q/fu5Do+qVcbw0JtkqTcJec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uvTwJ-0007RD-RY; Mon, 08 Sep 2025 06:57:15 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvTwI-000Bta-23;
	Mon, 08 Sep 2025 06:57:14 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvTwI-00BiAg-1h;
	Mon, 08 Sep 2025 06:57:14 +0200
Date: Mon, 8 Sep 2025 06:57:14 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: undo increment when j1939_local_ecu_get()
 fails
Message-ID: <aL5iKvYG6CijWsEF@pengutronix.de>
References: <e7f80046-4ff7-4ce2-8ad8-7c3c678a42c9@I-love.SAKURA.ne.jp>
 <aLqf0-WGRA8-Qb15@pengutronix.de>
 <40478f86-3de1-44c1-ba6f-6de3ed40bdeb@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40478f86-3de1-44c1-ba6f-6de3ed40bdeb@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Sun, Sep 07, 2025 at 04:42:33PM +0900, Tetsuo Handa wrote:
> On 2025/09/05 17:31, Oleksij Rempel wrote:
> > On Sun, Aug 24, 2025 at 07:27:40PM +0900, Tetsuo Handa wrote:
> >> Since j1939_sk_bind() and j1939_sk_release() call j1939_local_ecu_put()
> >> when J1939_SOCK_BOUND was already set, but the error handling path for
> >> j1939_sk_bind() will not set J1939_SOCK_BOUND when j1939_local_ecu_get()
> >> fails, j1939_local_ecu_get() needs to undo priv->ents[sa].nusers++ when
> >> j1939_local_ecu_get() returns an error.
> >>
> >> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > 
> > Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>                                                                                                             
> > Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > 
> > Thank you!
> 
> Thank you for responding.
> Do I need to take some action (e.g. sending to netdev@vger.kernel.org )
> on these three patches?

Nothing is needed for now. As soon as CAN maintainers will have time to
take look at it, the patches will be taken or changes may be requested.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

