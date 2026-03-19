Return-Path: <linux-can+bounces-7164-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JhDF8kcvGlEsQIAu9opvQ
	(envelope-from <linux-can+bounces-7164-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:56:57 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E659B2CE1D5
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 16:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E95E306B5A2
	for <lists+linux-can@lfdr.de>; Thu, 19 Mar 2026 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F1E3E8C68;
	Thu, 19 Mar 2026 15:48:02 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8E1A9FA8
	for <linux-can@vger.kernel.org>; Thu, 19 Mar 2026 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935282; cv=none; b=RiahOHGogQ2Nn+h4wY8eWSUXhRjquQykwnDgjgVfz7yuXAqjTTVxQDQ0tU4ZeSVwnfbit+HHTz9TypPinWdAf4xG79rrufN2wRAqHgCrR3DWczsvnizNdCgDR8PcDhYJDVCuLOXcpEolNYBAfhS4vRn86F/YjbGf/6wiVdDXm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935282; c=relaxed/simple;
	bh=9YjFbyf6MbFbBrwmbwiJ7BVWYB88msn7frDT7JDfMWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaSNUde3XCELKhIPVwqhtTB/p9vfumdDhdnGS91P0KQWHYANs+smXfGKNhiJ00h7fxPklOd+JhondV3LSoW2wneA9Sk/P34MjK2z1m/mPOw8Kkk0rUQCe/nQJb17ErgqU5eTL6rmERdGZFEhALQRPQkW89ZBEcVXzE92rZN/luI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3FbI-0002Tj-My; Thu, 19 Mar 2026 16:47:56 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1w3FbH-0016Eu-36;
	Thu, 19 Mar 2026 16:47:55 +0100
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A2A145086A0;
	Thu, 19 Mar 2026 15:47:55 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 19 Mar 2026 16:47:44 +0100
Subject: [PATCH can v2 1/2] can: gw: fix OOB heap access in
 cgw_csum_crc8_rel()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-fix-can-gw-and-can-isotp-v2-1-c45d52c6d2d8@pengutronix.de>
References: <20260319-fix-can-gw-and-can-isotp-v2-0-c45d52c6d2d8@pengutronix.de>
In-Reply-To: <20260319-fix-can-gw-and-can-isotp-v2-0-c45d52c6d2d8@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, Ali Norouzi <ali.norouzi@keysight.com>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2541; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Dnr0NMi/jlEaMAJbX4a29xhYmxyc8JMG4yEOKNtVdoU=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjcI7XSQM7nyNYt6yZ4L/rT6HHSP2ZT4XpLBZaJp69Mu
 x9befSecEcpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAmMqOTkWGl6P963mAth5O/
 Lr3Vrt0dce2Ace3iYEsd8QuzFdUeabIwMrw9tm1h2YnZDpF5k11ftv1ieL0q8uwPbY6FnQUvXNz
 i1vEDAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_FROM(0.00)[bounces-7164-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[keysight.com:email,pengutronix.de:email,pengutronix.de:mid,hartkopp.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E659B2CE1D5
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


