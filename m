Return-Path: <linux-can+bounces-4490-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3434FB45193
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 10:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F278F5A6817
	for <lists+linux-can@lfdr.de>; Fri,  5 Sep 2025 08:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B8715DBC1;
	Fri,  5 Sep 2025 08:30:38 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C0273804
	for <linux-can@vger.kernel.org>; Fri,  5 Sep 2025 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061038; cv=none; b=Pc09zc/ZQ/mU9+8buFxPzU7fj6aPb26R5eDVRfUI0ZxFVHl/ru2Y7STz90QJrNSkvw6JlyLV1e9sNNjCQM7+Rtte/Q3eZVfsfYftsYhf8/zrKl2BymVRgGuSdm9ABBiW7YLMWefB/oKkIGrhaa0+9vwnOLRbE+h28JE3he/hyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061038; c=relaxed/simple;
	bh=fSUZr85u55qz3E78iqTjDjChbiZpRIa278RUQ6PPAhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuwgCErq4CJZDir4h4aAbEDeQp4Zw/fr6dD7zEy1cyBFpdXXg2ZpNpoTX4Ew8o0de6Ro4ZZQv+E5QP522O2XaBoAxoJlhtVIzQNVaHpgLHnbFyZgeCFKxbPUdcA6J6ivk1cNTLIyOPww0JsNZLXnyaBTbjmoB+/WpvkAA72mF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uuRq2-0006bu-EL; Fri, 05 Sep 2025 10:30:30 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uuRq2-003rTf-0p;
	Fri, 05 Sep 2025 10:30:30 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uuRq2-004Gq7-0T;
	Fri, 05 Sep 2025 10:30:30 +0200
Date: Fri, 5 Sep 2025 10:30:30 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: j1939: call j1939_priv_put() immediately when
 j1939_local_ecu_get() failed
Message-ID: <aLqfpqn80TphoBG2@pengutronix.de>
References: <4f49a1bc-a528-42ad-86c0-187268ab6535@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f49a1bc-a528-42ad-86c0-187268ab6535@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Sun, Aug 24, 2025 at 07:30:09PM +0900, Tetsuo Handa wrote:
> Commit 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct
> callback") expects that a call to j1939_priv_put() can be unconditionally
> delayed until j1939_sk_sock_destruct() is called. But a refcount leak will
> happen when j1939_sk_bind() is called again after j1939_local_ecu_get()
>  from previous j1939_sk_bind() call returned an error. We need to call
> j1939_priv_put() before j1939_sk_bind() returns an error.
> 
> Fixes: 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct callback")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>                                                                                                             
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

