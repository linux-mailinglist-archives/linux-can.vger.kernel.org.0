Return-Path: <linux-can+bounces-7536-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OCIOidB+2lPYgMAu9opvQ
	(envelope-from <linux-can+bounces-7536-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 15:24:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CE24DAEA8
	for <lists+linux-can@lfdr.de>; Wed, 06 May 2026 15:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75A9B302173A
	for <lists+linux-can@lfdr.de>; Wed,  6 May 2026 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A2D472782;
	Wed,  6 May 2026 13:21:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DD73F65EB
	for <linux-can@vger.kernel.org>; Wed,  6 May 2026 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073670; cv=none; b=gi+XJj1m5C+k4FutpuPS8OD2dV2bfs+O48OB3qyPH2E77FW2p5T4yNL80qXr4qppEzna8uHCTRN9vtDGlfd1EtquFVgtRxI9qbRLy+bHAd7WpMSIDpqwpLkoQ3GzMVikQH0p9QT+QxlaAcwvbV17VXEoqMBIprYKh54A9wcH4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073670; c=relaxed/simple;
	bh=5EUUu3Lw3WTMqpz32cGXnM2msPkOcW9Lo9DgKRANOMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjpfNaNSKt1/oOz8NpKcPQBN7tpinWYxHDEDeknsZeQVX4YHt6d+KVq4GZTBONnFVmEEhNrsBsUaoPc8Er0DVhnyoCUDEmHthm3QCEmfRJreSE3nV8SmL4vpbwP3GGhkOPx7eYEmWzC8qXFxTeQciILxKMNnThkMxNE7VyqrUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wKcBV-0005G0-E4; Wed, 06 May 2026 15:21:05 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wKcBU-000kcy-22;
	Wed, 06 May 2026 15:21:05 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wKcBU-00000003UgB-42PM;
	Wed, 06 May 2026 15:21:04 +0200
Date: Wed, 6 May 2026 15:21:04 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexander =?utf-8?B?SMO2bHps?= <alexander.hoelzl@gmx.net>
Cc: robin@protonic.nl, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-can@vger.kernel.org
Subject: Re: [PATCH] Fix J1939 implementation not handling holds correctly
Message-ID: <aftAQHcRYhw1PO8B@pengutronix.de>
References: <20260504221833.53629-1-alexander.hoelzl@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504221833.53629-1-alexander.hoelzl@gmx.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 88CE24DAEA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7536-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test_raw_filter.sh:url,pengutronix.de:mid,pengutronix.de:url,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 12:18:33AM +0200, Alexander Hölzl wrote:
> The J1939 protocol allows the receiver of directed segemented messages
> to hold the data transfer. The kernel implementation did not handle hold
> messages correctly was not able to resume from a hold.
> Additionally the incorrect timeout for a held open connection was
> changed to 1050ms.
> Some simple tests for the general protocol behavior have been added.
> 
> This is just an initial draft I'm just looking for some feedback
> if the general setup is acceptable.
> 
> Also I still have some points I'm not sure about.
> 1. There is no check for the reception of a CTS during an ongoing data
>    transfer. According to the standard it is illegal, but I dont think
>    the implementation cares about it. J1939_XTP_ABORT_GENERIC is never
>    referenced and the previous check I removed only really prevented
>    consecutive CTS which are legal if they are holds. Should I add a
>    check for this? This seems to be a slightly different problem so I
>    did not address it.

Current I do not have opinion about this. As long as it is in a separate
patch with enough explanation and tests - I'm OK.

> 2. Should userspace be notified about holds? I don't think the standard
>    gives a maximum 'hold open time' so in theory it could be held
>    indefinetly. This might be a situation a user could be intrested in
>    even though it is rather theoretical.

Yes, it will be good to have a user space feedback. But, it would block
resources. Will we get difference scenarios where we still have an open
session which is blocking other transfers?

> Please tell me what you think.
> 
> Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
> ---
>  net/can/j1939/transport.c                     |  50 ++--
>  tools/testing/selftests/net/can/.gitignore    |   1 +
>  tools/testing/selftests/net/can/Makefile      |   8 +-
>  tools/testing/selftests/net/can/config        |   1 +
>  .../testing/selftests/net/can/test_cts_hold.c | 269 ++++++++++++++++++
>  .../selftests/net/can/test_cts_hold.sh        |  45 +++
>  6 files changed, 355 insertions(+), 19 deletions(-)
>  create mode 100644 tools/testing/selftests/net/can/test_cts_hold.c
>  create mode 100755 tools/testing/selftests/net/can/test_cts_hold.sh
> 
> diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
> index df93d57907da..e53a9fbe82a9 100644
> --- a/net/can/j1939/transport.c
> +++ b/net/can/j1939/transport.c
> @@ -1442,9 +1442,27 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
>  
>  	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
>  
> -	if (session->last_cmd == dat[0]) {
> -		err = J1939_XTP_ABORT_DUP_SEQ;
> -		goto out_session_cancel;
> +	session->last_cmd = dat[0];
> +
> +	/* TODO
> +	 *according to the standard it is illegal to send a CTS while data transfer is ongoing.
> +	 * If a CTS is sent while data transfer is ongoing an abort with code 4 should be sent.
> +	 * The previous check I removed was simply (session->last_cmd == dat[0]).
> +	 * This did not check for a invalid CTS after some data frames had already been
> +	 * sent but before all of them were sent.
> +	 * So CTS(0), CTS(5) was illegal. CTS(5), DAT, CTS(5) was legal,
> +	 * even though only one data frame has been sent instead of 5.
> +	 * Should a check for this also be added?
> +	 */
> +	if (!dat[1]) {

We need a helper function or some defines for different CTS variants.

> +		/* CTS(0) */
> +		if (session->transmission) {
> +			/* TODO notify error queue about hold messages? */

Yes. Can be done in a separate patch.

> +			j1939_session_txtimer_cancel(session);
> +		}
> +		j1939_tp_set_rxtimeout(session, 1050);

I guess we need defines for timouts too.

> +		netdev_dbg(session->priv->ndev, "%s: 0x%p received CTS hold\n", __func__, session);
> +		return;
>  	}
>  
....

> diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
> index 764a53fc837f..96ef18ae986d 100644
> --- a/tools/testing/selftests/net/can/.gitignore
> +++ b/tools/testing/selftests/net/can/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  test_raw_filter
> +test_cts_hold
> \ No newline at end of file
> diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
> index 5b82e60a03e7..182346682bce 100644
> --- a/tools/testing/selftests/net/can/Makefile
> +++ b/tools/testing/selftests/net/can/Makefile
> @@ -4,8 +4,12 @@ top_srcdir = ../../../../..
>  
>  CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
>  
> -TEST_PROGS := test_raw_filter.sh
> +TEST_PROGS := \
> +	test_raw_filter.sh \
> +	test_cts_hold.sh \
>  
> -TEST_GEN_FILES := test_raw_filter
> +TEST_GEN_FILES := \
> +	test_raw_filter \
> +	test_cts_hold \
>  
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
> index 188f79796670..cb538ed93ae4 100644
> --- a/tools/testing/selftests/net/can/config
> +++ b/tools/testing/selftests/net/can/config
> @@ -1,3 +1,4 @@
>  CONFIG_CAN=m
>  CONFIG_CAN_DEV=m
>  CONFIG_CAN_VCAN=m
> +CONFIG_CAN_J1939=m
> \ No newline at end of file
> diff --git a/tools/testing/selftests/net/can/test_cts_hold.c b/tools/testing/selftests/net/can/test_cts_hold.c
> new file mode 100644
> index 000000000000..a36efb099522
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_cts_hold.c

Sashiko has here some comments for this file.
https://sashiko.dev/#/patchset/20260504221833.53629-1-alexander.hoelzl%40gmx.net

> +/* Test holding RTS/CTS transport on first frame and resuming immediatley */
> +TEST_F(can_env, test_hold_resume_immediate)
> +/* Test send hold in transport session and resuming */
> +TEST_F(can_env, test_hold_resume)
> +/* Test timeout after not resuming hold */
> +TEST_F(can_env, test_hold_timeout)
 
Nice!

It would be good to add usual transfer test as baseline to make sure
stack works as expected. I guess a simple 2 frame TP should be enough.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

