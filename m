Return-Path: <linux-can+bounces-7393-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMq5ITKX6WksegIAu9opvQ
	(envelope-from <linux-can+bounces-7393-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 23 Apr 2026 05:51:14 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBAA44C984
	for <lists+linux-can@lfdr.de>; Thu, 23 Apr 2026 05:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192C43046EAB
	for <lists+linux-can@lfdr.de>; Thu, 23 Apr 2026 03:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B70C3314AE;
	Thu, 23 Apr 2026 03:50:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1052E282B
	for <linux-can@vger.kernel.org>; Thu, 23 Apr 2026 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916213; cv=none; b=IXYcA0A3+SKeFStQUu0vriIeiizgf1ol8P/AWVhggoWgSk0KxJTecfvzqa6uzUHekZdwlQC68uAB0FQO0myLIkeE0X0YXRZtD3MyQMgtiSSBYCqXrGbyyQhpjAoImAuyW3htiSugyWN7X5oahfEYa9wDuH8oMBo7pt13GLw2Q4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916213; c=relaxed/simple;
	bh=ZdL+/jN/ovOG7UfEMywWY7Pd2rVoztzv4iswm0WEv7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hb2VkoCTgfkxdJCnG9eKotAzuDbxNKfrS2NTZcDeDrCyG3yuwfN6RzIvdyXTYStzVSsOu+62I+R98v0FAk9eq+HzwPM4NqLs26b7H7crtv1qhVszOCx3/GyJ5gmnU3tn4tIAmT6udSOnxYgKV99km9+0HnJ2Oe7fIGekFZ8SH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wFl4i-0005Fc-Sv; Thu, 23 Apr 2026 05:50:00 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wFl4i-006laS-1E;
	Thu, 23 Apr 2026 05:50:00 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wFl4i-0000000AQQ6-18j7;
	Thu, 23 Apr 2026 05:50:00 +0200
Date: Thu, 23 Apr 2026 05:50:00 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexander =?utf-8?B?SMO2bHps?= <alexander.hoelzl@gmx.net>
Cc: robin@protonic.nl, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: fix wrong rx timeout for CTS hold messages
Message-ID: <aemW6JThLpOu5BNg@pengutronix.de>
References: <20260421153152.87772-3-alexander.hoelzl@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421153152.87772-3-alexander.hoelzl@gmx.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7393-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FREEMAIL_TO(0.00)[gmx.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBBAA44C984
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Alexander,

On Tue, Apr 21, 2026 at 05:31:54PM +0200, Alexander Hölzl wrote:
> In J1939 segmented transport, a CTS message with data byte 2 set to zero is interpreted as a hold message.
> This instructs the transmitter of the segmented message to hold the connection open but to delay sending.
> According to the J1939-21 standard, section 5.10.2.4 the timeout T4 after which an held open session is invalidated is
> 1050 ms, not 550 as implemented currently.
> The 550 ms are problematic if a device uses hold messages and assumes it can wait for more than 550 ms before it has
> to resend the hold message.
> 
> This patch changes the T4 timeout used in the implementation from 550 ms to 1050.
> 
> Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>

LGTM. Thank you!

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>


Sashico detected one more potential issue, not related to this patch:
https://sashiko.dev/#/patchset/20260421153152.87772-3-alexander.hoelzl%40gmx.net

If you have time, can you please verify it?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

