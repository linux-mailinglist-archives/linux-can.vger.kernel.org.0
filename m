Return-Path: <linux-can+bounces-6682-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGnYK3avpWleEQAAu9opvQ
	(envelope-from <linux-can+bounces-6682-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:40:38 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA97C1DC044
	for <lists+linux-can@lfdr.de>; Mon, 02 Mar 2026 16:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1BA43073608
	for <lists+linux-can@lfdr.de>; Mon,  2 Mar 2026 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD7941C0AC;
	Mon,  2 Mar 2026 15:28:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B10A411627
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465296; cv=none; b=H/xfs8gKvIEn6Vsf3MkuSTsvx9jFnMS4UHo/ZU4tnDWYncgytWlo6X9VA6inaqnLWAyd4iRjf7BX1eHUaEL9rqthOVwC6bGuUcGBcCOl5ShY/yH5qHhY+QRK3OpKnYOP0HvrkusUF0X5hSdLN+vJUJCOINIu5qH/WQ/knjjqVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465296; c=relaxed/simple;
	bh=fxloLn3Yxk0QYlcgqUvBz/l3tfOezX52/8JTNwhCxNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7vzq7Lfk2HT4ifKLF04wfj3aXIwSE58YrhLPTUGMJK9QkbK3BL+ByatPHbYBOUFquejmnRjf+umikhSH35Lj09+LdfV9yqbQCY8rkXq+o7uv1bCz9jgUruSoIE7AN9P63PnMNhvtlIsClzOe67KwAEWDWP403BRNM4jpT8sHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Be-0004kN-Lt; Mon, 02 Mar 2026 16:27:58 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Bc-003P0k-28;
	Mon, 02 Mar 2026 16:27:58 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C0BC84F546F;
	Mon, 02 Mar 2026 15:27:57 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org
Subject: [PATCH net 06/12] can: ucan: Fix infinite loop from zero-length messages
Date: Mon,  2 Mar 2026 16:16:12 +0100
Message-ID: <20260302152755.1700177-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302152755.1700177-1-mkl@pengutronix.de>
References: <20260302152755.1700177-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: BA97C1DC044
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-6682-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.909];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,pengutronix.de:mid,pengutronix.de:email]
X-Rspamd-Action: no action

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

If a broken ucan device gets a message with the message length field set
to 0, then the driver will loop for forever in
ucan_read_bulk_callback(), hanging the system.  If the length is 0, just
skip the message and go on to the next one.

This has been fixed in the kvaser_usb driver in the past in commit
0c73772cd2b8 ("can: kvaser_usb: leaf: Fix potential infinite loop in
command parsers"), so there must be some broken devices out there like
this somewhere.

Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: stable@kernel.org
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026022319-huff-absurd-6a18@gregkh
Fixes: 9f2d3eae88d2 ("can: ucan: add driver for Theobroma Systems UCAN devices")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index c79508b1c43e..0ea0ac75e42f 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -748,7 +748,7 @@ static void ucan_read_bulk_callback(struct urb *urb)
 		len = le16_to_cpu(m->len);
 
 		/* check sanity (length of content) */
-		if (urb->actual_length - pos < len) {
+		if ((len == 0) || (urb->actual_length - pos < len)) {
 			netdev_warn(up->netdev,
 				    "invalid message (short; no data; l:%d)\n",
 				    urb->actual_length);
-- 
2.51.0


