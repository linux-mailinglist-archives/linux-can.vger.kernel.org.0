Return-Path: <linux-can+bounces-7390-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFzBDaCZ52kV+QEAu9opvQ
	(envelope-from <linux-can+bounces-7390-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 17:37:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B8243CCD1
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 17:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 525073002793
	for <lists+linux-can@lfdr.de>; Tue, 21 Apr 2026 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7CC29B77E;
	Tue, 21 Apr 2026 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="FdIglaFa"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D7F286881;
	Tue, 21 Apr 2026 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785663; cv=none; b=sAllxDIz0ZXOrZQrqfeK8XHboJaGSh/AdTbP4cGeEpnzt7gkVFyJDG+znmhP8cYok7SEsl7BGTY1WNzux0G9xmAWeuXAPZV0veJiQswmVgf567fkJhP12hlrXj2W9+/KhjoqeTHeZVWpF+BUpSNet4fcpxZ8ngeiBQxNLQ13PeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785663; c=relaxed/simple;
	bh=05VB/0CeoA3PzputJLezPph/9pcVsdbesFI4ZgjeEoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EJYVVtFoPoqpiaL/GWdgooI41W+FTiKiz1JZlMvKvLvMPuS2n51MPVPb192lkMic83v5sVUzBUh439Z+Eoso830msCuMOD7R1QGuVO8bqnhDpd/JJPPIcPM+ke8SYoClZYOtRMlbedG3ydaMHC4+hA3f4KGuJxZdT3hxEi5J71o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=FdIglaFa; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1776785659; x=1777390459;
	i=alexander.hoelzl@gmx.net;
	bh=5GOc0VUJ/18t/1y14YbzE56X/UhnFlGRlnxbnzQDgv8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FdIglaFaDi1gHjXkgZ5Cx0yZLv0Wslwnugu8iGviGbGo9NDE1PnQv4srHIyjW8dv
	 py0XeYW9vfVFiJm1vRVDtmCKkk0/C9n6x9mcFq6dkdzCPKpPB8NI/CcI4kfjJ3qtP
	 2utk3jiPAa/g44BEcO7uh5sWXKLPru92Av2WGUSxMTwNGoPhoc3kU5Y1rhSJkTJJC
	 GmsDY4oOzCE3EMpgn5fj+QZGUdvopumKC53ASiWi45b8VcBXivW9RvYLjx2SkJSWF
	 7mO7gY7rhm3A5MTt6Tb6/tPAgma8JSX9qUfXnpK/EVMTsLgYRNoyGWGQwDQYkLGQ3
	 S5fSXIC6VuZ8D8u9lQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGz1V-1wA0RE0Xdz-006V2q; Tue, 21
 Apr 2026 17:34:19 +0200
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: robin@protonic.nl,
	o.rempel@pengutronix.de
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: [PATCH] can: j1939: fix wrong rx timeout for CTS hold messages
Date: Tue, 21 Apr 2026 17:31:54 +0200
Message-ID: <20260421153152.87772-3-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cnUzQUCurrPLxmI3JwYZch0THiwxQhDNsJ6wwtQN+XJSVsQE0XY
 MhS1oKPUnvob7Pi3bVh3KfpYw0TpK/kjazcs5JPkv/NQrd8UCV60Kdp8P6uYnJeZw7zLW4F
 pspPQvw5aIaIfFlsAPHupgBaCNXht9KSpiaXRwuBq5UK82TOZaN4zV2UkJXLybx/85hgeW1
 x8RUU+v51iMs3KUDXgsuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hPP0sTREVzM=;K3oFEzCyGzIhXHzK/Du10/XvPVt
 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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7390-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.net];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,vger.kernel.org,gmx.net];
	DKIM_TRACE(0.00)[gmx.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95B8243CCD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In J1939 segmented transport, a CTS message with data byte 2 set to zero i=
s interpreted as a hold message.
This instructs the transmitter of the segmented message to hold the connec=
tion open but to delay sending.
According to the J1939-21 standard, section 5.10.2.4 the timeout T4 after =
which an held open session is invalidated is
1050 ms, not 550 as implemented currently.
The 550 ms are problematic if a device uses hold messages and assumes it c=
an wait for more than 550 ms before it has
to resend the hold message.

This patch changes the T4 timeout used in the implementation from 550 ms t=
o 1050.

Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
=2D--
 net/can/j1939/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da..7ad56b5f17b9 100644
=2D-- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1479,7 +1479,7 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, =
struct sk_buff *skb)
 		}
 	} else {
 		/* CTS(0) */
-		j1939_tp_set_rxtimeout(session, 550);
+		j1939_tp_set_rxtimeout(session, 1050);
 	}
 	return;
=20
=2D-=20
2.43.0


