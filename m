Return-Path: <linux-can+bounces-1217-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7E7964502
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 14:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE02B1C24BB4
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2024 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BAB1B8EB2;
	Thu, 29 Aug 2024 12:35:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2589C1B8E96
	for <linux-can@vger.kernel.org>; Thu, 29 Aug 2024 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934940; cv=none; b=HQSE04eotkIbV6THS4IDU0FRDprEg9XyYDRLDzJQOboZ1q56sRYXzcvo2shGUT+gEFkBdIeRJyMqvJj7kRXH/0SZqkZW1bnWTbExkkcLAlHhlCm/OEhTXQ7rR6ajI73+Dms2RruutEZLXwDz71P8PPBmRMH7M5KXETE/V+mqjZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934940; c=relaxed/simple;
	bh=PgVytScBI+hRqqr2CwhxNTOrlCG/eQatOarv7+nb0a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IASf4NUp9BN5zem0QOwNdwM8gyoZgoNB7N4kwAnBM5+/WKn00SM1fQCPkvSwyldE72S+TgiOqKR2y/AAQUN6M+BizJvO1Q1h+8qQpryIFduPZiblTCFlpnf7iOCOyXUPLwDcuehV5i1Wg9aJjSXFwnevoPoOatUuSclQe4b9Ch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sjeN9-0005b6-EJ; Thu, 29 Aug 2024 14:35:31 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sjeN7-003ueH-3P; Thu, 29 Aug 2024 14:35:29 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sjeN7-00Cei6-01;
	Thu, 29 Aug 2024 14:35:29 +0200
Date: Thu, 29 Aug 2024 14:35:28 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Zhang Changzhong <zhangchangzhong@huawei.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Robin van der Gracht <robin@protonic.nl>
Subject: Re: [PATCH can-next] net: can: j1939: use correct function name in
 comment
Message-ID: <ZtBrELQB-_HJAGUA@pengutronix.de>
References: <1724935703-44621-1-git-send-email-zhangchangzhong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1724935703-44621-1-git-send-email-zhangchangzhong@huawei.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Thu, Aug 29, 2024 at 08:48:23PM +0800, Zhang Changzhong wrote:
> The function j1939_cancel_all_active_sessions() was renamed to
> j1939_cancel_active_session() but name in comment wasn't updated.
> 
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Can you please add fixes tag
Fixes: 9d71dd0c70099 ("can: add support of SAE J1939 protocol")

Thank you!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

