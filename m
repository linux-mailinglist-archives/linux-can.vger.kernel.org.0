Return-Path: <linux-can+bounces-7215-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJEnFzsXwWn5QQQAu9opvQ
	(envelope-from <linux-can+bounces-7215-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 11:34:35 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C952F02AA
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 11:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F09FC304CA43
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2026 10:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDF238C2CC;
	Mon, 23 Mar 2026 10:32:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037837CD26
	for <linux-can@vger.kernel.org>; Mon, 23 Mar 2026 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261956; cv=none; b=qBMsdJtk4R3AVF5Px8I4xa319XOW4e1Zn7mBQEEtiCWntBN0LgTnPOCvN2M1nT4rOHJClJXpTkg3U2jRFW433dnqpUOMUBPK62IBwfEQooFrpJV8GqEzBYQsQoB4ahcBB2vx2EPRGrTbK0o44HLdRl/P+ZPgwJfZScY5luDIGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261956; c=relaxed/simple;
	bh=j/10nP+8tgQLub4J36KDWeaI4QNXgGTg3m4z0ETE4Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDsFEhE36a/HwrPaN29aNITqn7FPu1UyQjIs0FZ2Bfmg/K99Nhd+P7LXcQqTkABj6T+DwcMNTS3Pl3tgT2c/PovHRHtph3P49EKXUnoARn3BcZYhE8ZbLeJbra3gwvXxGg4nQ9LoQqyPfzrTDkR37QK+1S7IS60rOWvW88JO8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4caC-0008FT-6m; Mon, 23 Mar 2026 11:32:28 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w4caB-001i5j-19;
	Mon, 23 Mar 2026 11:32:27 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0FB5B50A7C0;
	Mon, 23 Mar 2026 10:32:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Ali Norouzi <ali.norouzi@keysight.com>,
	stable@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 4/5] can: gw: fix OOB heap access in cgw_csum_crc8_rel()
Date: Mon, 23 Mar 2026 11:28:00 +0100
Message-ID: <20260323103224.218099-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323103224.218099-1-mkl@pengutronix.de>
References: <20260323103224.218099-1-mkl@pengutronix.de>
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
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-7215-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,keysight.com:email]
X-Rspamd-Queue-Id: D2C952F02AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ali Norouzi <ali.norouzi@keysight.com>

cgw_csum_crc8_rel() correctly computes bounds-safe indices via calc_idx():

    int from = calc_idx(crc8->from_idx, cf->len);
    int to   = calc_idx(crc8->to_idx,   cf->len);
    int res  = calc_idx(crc8->result_idx, cf->len);

    if (from < 0 || to < 0 || res < 0)
        return;

However, the loop and the result write then use the raw s8 fields directly
instead of the computed variables:

    for (i = crc8->from_idx; ...)        /* BUG: raw negative index */
    cf->data[crc8->result_idx] = ...;    /* BUG: raw negative index */

With from_idx = to_idx = result_idx = -64 on a 64-byte CAN FD frame,
calc_idx(-64, 64) = 0 so the guard passes, but the loop iterates with
i = -64, reading cf->data[-64], and the write goes to cf->data[-64].
This write might end up to 56 (7.0-rc) or 40 (<= 6.19) bytes before the
start of the canfd_frame on the heap.

The companion function cgw_csum_xor_rel() uses `from`/`to`/`res`
correctly throughout; fix cgw_csum_crc8_rel() to match.

Confirmed with KASAN on linux-7.0-rc2:
  BUG: KASAN: slab-out-of-bounds in cgw_csum_crc8_rel+0x515/0x5b0
  Read of size 1 at addr ffff8880076619c8 by task poc_cgw_oob/62

To configure the can-gw crc8 checksums CAP_NET_ADMIN is needed.

Fixes: 456a8a646b25 ("can: gw: add support for CAN FD frames")
Cc: stable@vger.kernel.org
Reported-by: Ali Norouzi <ali.norouzi@keysight.com>
Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Ali Norouzi <ali.norouzi@keysight.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260319-fix-can-gw-and-can-isotp-v2-1-c45d52c6d2d8@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/gw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 8ee4d67a07d3..0ec99f68aa45 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -375,10 +375,10 @@ static void cgw_csum_crc8_rel(struct canfd_frame *cf,
 		return;
 
 	if (from <= to) {
-		for (i = crc8->from_idx; i <= crc8->to_idx; i++)
+		for (i = from; i <= to; i++)
 			crc = crc8->crctab[crc ^ cf->data[i]];
 	} else {
-		for (i = crc8->from_idx; i >= crc8->to_idx; i--)
+		for (i = from; i >= to; i--)
 			crc = crc8->crctab[crc ^ cf->data[i]];
 	}
 
@@ -397,7 +397,7 @@ static void cgw_csum_crc8_rel(struct canfd_frame *cf,
 		break;
 	}
 
-	cf->data[crc8->result_idx] = crc ^ crc8->final_xor_val;
+	cf->data[res] = crc ^ crc8->final_xor_val;
 }
 
 static void cgw_csum_crc8_pos(struct canfd_frame *cf,
-- 
2.53.0


