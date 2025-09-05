Return-Path: <linux-can+bounces-4491-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CFBB45196
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 10:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9908C1883C55
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 08:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9395627F183;
	Fri,  5 Sep 2025 08:31:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A627144A
	for <linux-can@vger.kernel.org>; Fri,  5 Sep 2025 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061083; cv=none; b=Rkb8AvPTtDy1vAm8DmsARhrIqcewwD4XQM86ZkAYcHR2ar9LFC4ifip7hJWDqcrDz7CvB4YNYUJqY+PLmF69oVseM8RUEAHMMvNuiCjeayzXVoSCOKSwfUtgQQ1Wker6+SPt9iEQEfwUjxRMtNaflwWwUnqDDLmZTF0lvWvjNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061083; c=relaxed/simple;
	bh=YESrZQLIjow9fJ2MHXhfuYa6/NvnQpk2ZHbTaa1FY/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvTU7M99dEapbIptSCdZGTpx4plpb+G5aCzRLxsAFlVW8eJASqOPK09nYuXJz1hVoaX6pc01+AVwohMhI9275GGMnNF7e4Mzfe/jQQ0NC2nA5IjPcDc9keMJqn59+gPRltc11zd5zecx8THhtDsmtxMifHtJp0TSYKEdZ04HkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uuRql-0006tm-Q9; Fri, 05 Sep 2025 10:31:15 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uuRql-003rTl-1O;
	Fri, 05 Sep 2025 10:31:15 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uuRql-004GrL-10;
	Fri, 05 Sep 2025 10:31:15 +0200
Date: Fri, 5 Sep 2025 10:31:15 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maxime Jayat <maxime.jayat@mobile-devices.fr>,
	Elenita Hinds <ecathinds@gmail.com>,
	Bastian Stender <bst@pengutronix.de>, linux-can@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: j1939: undo increment when j1939_local_ecu_get()
 fails
Message-ID: <aLqf0-WGRA8-Qb15@pengutronix.de>
References: <e7f80046-4ff7-4ce2-8ad8-7c3c678a42c9@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7f80046-4ff7-4ce2-8ad8-7c3c678a42c9@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Sun, Aug 24, 2025 at 07:27:40PM +0900, Tetsuo Handa wrote:
> Since j1939_sk_bind() and j1939_sk_release() call j1939_local_ecu_put()
> when J1939_SOCK_BOUND was already set, but the error handling path for
> j1939_sk_bind() will not set J1939_SOCK_BOUND when j1939_local_ecu_get()
> fails, j1939_local_ecu_get() needs to undo priv->ents[sa].nusers++ when
> j1939_local_ecu_get() returns an error.
> 
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>                                                                                                             
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

