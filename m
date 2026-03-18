Return-Path: <linux-can+bounces-7139-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3d5yM9Haumn0cgIAu9opvQ
	(envelope-from <linux-can+bounces-7139-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 18:03:13 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 762282BFDA9
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 18:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6048034F1872
	for <lists+linux-can@lfdr.de>; Wed, 18 Mar 2026 16:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B25253359;
	Wed, 18 Mar 2026 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="MVfM5SUH";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="NCbOVpo5"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFFD1DDC2B;
	Wed, 18 Mar 2026 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852880; cv=pass; b=b4FvXEVqOMaPIt26rlx9t6XRszKLr3pYLXWgdVyTNGUxHzy+y7nBR6Dz9F4OLb6tbz+c+WEGcm6ab4/0PZU72UYTdBohJocKzLT0/c8b0Gn4HIVr/OrqviOXOFUVa8NzXE6tQMin2TDtw7B4SXHlSf9UgwM9vZ3rK2qbbSRRprA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852880; c=relaxed/simple;
	bh=0r3bjBA1FPGil83IoKH01pkuEYwEpG5LS3m+cfIdzPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BJr+/ad23XYtT6kLIWRfTUUSxhgDe2xlB2IwPbP507dhtVN1PJV3yZpxJOruKSaEUihR0RE17dTAMM4l2Ks2RqclqMgVpPXnjksHeDe7JLFxqZ8+npmpevPMRljshPWwgadoFfcpia8Gp9fCZhHrjEvU2NUfi6+RQIhA1Qj47Z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=MVfM5SUH; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=NCbOVpo5; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1773852696; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=P1cg8wDSp4FLwdLfaHy3m6GveRkNsa4W8col7cR2XEzWWT5sUoEOg8SA13vifTWgfR
    Ct1XsD+Af4ovI1Fnl1X9VmOkwpXlZIOSkkUra7/TtcuI3Vz8p+oz/ZwqkT9y4Y5Ki3Tf
    u1gYjxZlNC1uXZHFtU/2V4oE6f9cIS/aUWh9Bpm8YxMVab4bhD4yTbIrI6ezPV6yyLqU
    56oPbBPpL2EHL+YWmnJu9uLnyblSimzn8DA9pKQdk96/nhlIRuaguzd37OsI/80ZqCK4
    j9hiY3laExnH4YvbXxDHouhF8XTx6U/W4WO0vJ36Q14R7RGceNIaCl+AzkWPh5CxTyug
    KF4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773852696;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=uAW4MClx1aJDjN6ESqo+yTHAchyRZHrRKkV3fAuUJ78=;
    b=hmU2Q483u5fVI+Pb2+c71R0TF1Oc6OIv2mRVzhObymLl9nzmyXYsd6utNfSli/6qXX
    wxiYxAssDCaZnXFx3SzguMFqqn2Xo/gsua9JrczdEnGnsIJmHMDcEDqe9LiVyjNNuG71
    xWWi/6onEZxAw+DnKte31CqZaTbIJmiPWr4oppWrH/d8ZT2c7C7yNslRhsDblwFJZIYn
    rshgGJ2ziHVCJi/+2d5Fryi5GtQcwtvz5sFSD4naGPq9zDEYAjhCj7OOHAp1UkQ0xfGV
    NPZrWYoBqmSNlbJ83lGuPZU5NerszQFxBCi1fWJArMKGaYke4X/XS1mHqE5WaLN800Ig
    Xhdw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773852696;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=uAW4MClx1aJDjN6ESqo+yTHAchyRZHrRKkV3fAuUJ78=;
    b=MVfM5SUH3VGe4oHQSx+JTFuHXMdNJafRUGcRIr+5eorfvvmuMH8J7gtCBS72bArqM7
    7eU74iVWPMtZf/ikrbTDZYu6Ka7ZesFrAJVgmvq7YRkY5Tt6I1A7geruC5krJ0+ltpGo
    c87zY6I4qR1sgK5rAgJ5mqqlIXm0W1LmLk7x98eH+07Am2jpW3472aKXhzpoukyJiFii
    inNc06bNoiuOk7gnuiIpdrMraHW9Fdjq+RcE8baVdWgl1ULcAogKv9NAdKiK92ExzcNC
    218qKzTeSNzUnVceMjNgbi8fkLtY0do7moFHbX0hmXUPZDiqpXs8doiwq2WlbI8l5wSr
    Y/jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773852696;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=uAW4MClx1aJDjN6ESqo+yTHAchyRZHrRKkV3fAuUJ78=;
    b=NCbOVpo5P8l62DJF7851HcycOna5IeF0ofWVloDjF7vO+4e63xZuTYADQnssGwwTWQ
    1ljb69dAr8OF7B7J5+BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d22IGpZozQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 18 Mar 2026 17:51:35 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Ali Norouzi <ali.norouzi@keysight.com>,
	stable@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 1/2] can: gw: fix OOB heap access in cgw_csum_crc8_rel()
Date: Wed, 18 Mar 2026 17:51:19 +0100
Message-ID: <20260318165120.17560-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7139-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,keysight.com:email,hartkopp.net:dkim,hartkopp.net:email,hartkopp.net:mid]
X-Rspamd-Queue-Id: 762282BFDA9
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
---
 net/can/gw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 8ee4d67a07d3..0ec99f68aa45 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -373,14 +373,14 @@ static void cgw_csum_crc8_rel(struct canfd_frame *cf,
 
 	if (from < 0 || to < 0 || res < 0)
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
 
 	switch (crc8->profile) {
 	case CGW_CRC8PRF_1U8:
@@ -395,11 +395,11 @@ static void cgw_csum_crc8_rel(struct canfd_frame *cf,
 		crc = crc8->crctab[crc ^ (cf->can_id & 0xFF) ^
 				   (cf->can_id >> 8 & 0xFF)];
 		break;
 	}
 
-	cf->data[crc8->result_idx] = crc ^ crc8->final_xor_val;
+	cf->data[res] = crc ^ crc8->final_xor_val;
 }
 
 static void cgw_csum_crc8_pos(struct canfd_frame *cf,
 			      struct cgw_csum_crc8 *crc8)
 {
-- 
2.51.0


