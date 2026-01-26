Return-Path: <linux-can+bounces-6307-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W1RwLBxHd2lbdwEAu9opvQ
	(envelope-from <linux-can+bounces-6307-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 11:51:08 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D587492
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 11:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 763483018174
	for <lists+linux-can@lfdr.de>; Mon, 26 Jan 2026 10:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FCC330D4C;
	Mon, 26 Jan 2026 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="CkPDPO9K";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="3EWNTRVm"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDF3330660
	for <linux-can@vger.kernel.org>; Mon, 26 Jan 2026 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424374; cv=pass; b=b8cVFwhMXQ65+IkgYxJh8UQBU7MLkieJBB0uYP3xe9EnGiYmYNYZipp9QGk4DO0feffglGQGiCrWF8VAJh2Xs6Vp3uDRkThBv5cfTSrcZEo0y1/qHBDNsZtaNQMZ7tnewEcegdgc0tLt/LJeZYexmymWA8OcDaJ0//6rd+khW1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424374; c=relaxed/simple;
	bh=CDQyYGThGTa+ZdO2MqqXV8qsfum++3t4R9D1fte9Zl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MEtDAGb2s7It4dy3eZqWnJGQ58Krumh56feMpeTjEvBdU4hhuwVB18bJP8ShmlMExxV8tsF/kDc4Zqx/R5zyk9ATJTwvdjNjyvLx93rOtqX0PxrMmgzt82sD/xayvk2r48KelWaKodJnP1eR3ZXFioGZKHB85sF5c0dbrojw9ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=CkPDPO9K; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=3EWNTRVm; arc=pass smtp.client-ip=85.215.255.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769424354; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TNF5PsEBiBvdbWLu2UYZEqGUqgXmhPQSC2GuE9d/Wn3h1cO/pEK+4Z5c/biND4BMVG
    cnKGlpjXfqpapjo+9EQKcYmYfz++q/gj3nEoGkpII0fwCz1jYF1Mvx4NMpvJEX3kCIFH
    JViSryvj2LKA18PjIZXMbdapHbdeWrsycdvuNLvfS8e09FyuLTPRQdTEbVP8YSxuuC9/
    pbtBAiI87qyiNaRaU1IUoPGO9bqD8cbeOJG/HaH2wiyJQ4Jlbx5YDAVQYAA+sjsQFuqh
    6T2PYn7+jXT3TO8dqBMHp6/+/8ktkkvTjdCBRQi9bDt6Aejgts5sFDfTpsm7iaoQVK6N
    Y4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769424354;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=x31/POMbJ/Zxm8vyc2AcB5zug6YWVQvKxLdMOeHP3r8=;
    b=cAqrjq35nJ3+Gy83QWZE6vaw3ycCNX24+Yu9/zcY2BTA8rWgvo85XvjnA4o66YOIjc
    fJEUK41tIzskvHwEcDOF7f/OIFQVAZjnn4is/DLF115AOk37Xhb6uXm5r7EacmoBFR47
    WyCVPDMjqYJsG2brQRcDPF4T5C57F9E8WVjvOVOz/bUP6S38BfO7/2nbOP81RI1JtnVl
    8L7Pyohhw5beGkDW7cgW7Igm+OcImqs8Bm3NiFQi8JBYpyH5eWadSeOOL7rYPaiEXVkL
    jSa2uDUAb7LFhzWkKEG1Ske4ZRLauxGSA4V0+3PxC8nZlNwEDpoMUiPal7SI1l6ttStY
    rJnw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769424354;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=x31/POMbJ/Zxm8vyc2AcB5zug6YWVQvKxLdMOeHP3r8=;
    b=CkPDPO9KhdOfWja3KQEAzfZG3D7D5WxI2g8GtS56OE/+z1VtpavDX/sSvlsagZXb8l
    dNOKytBQhp7Bo8EEF7dLDtPzcLkbuL3QEI6Xu1Unq7Jn+LOhXfScctSFAu89EtoXMLty
    RWZK5iswlS/NR+i4D4alTAXCyIPqSHhbWkgcL6t302ambhVbIo8FsNzvwV3gNo+q8Zlm
    ro0eTkoDGuEsi94Q/E/JOG6TI7BKgMlIR1wy+agiywjXM1bXJy/liFcLb308cPE50wtg
    GfZdLQCOdt9/aMXOVsc69ddRZa8h6E9t9pXIaB0M5wRE6H9HLlaNz9Gv/KeASM2XddlD
    xKSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769424354;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=x31/POMbJ/Zxm8vyc2AcB5zug6YWVQvKxLdMOeHP3r8=;
    b=3EWNTRVm3Pj3YGC/tDA9GcZv7UkaLbytyCa1i2ZIi+TahOHXBdM8KhE66JaCggVAat
    8CjMtO8jyOlzva4GWbCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s1YTqptmo87qzm6sElmZEI+VN6rw=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20QAjsbVg
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Jan 2026 11:45:54 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v2] dummy_can: fix packet statistics
Date: Mon, 26 Jan 2026 11:45:40 +0100
Message-ID: <20260126104540.21024-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6307-lists,linux-can=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,hartkopp.net:email,hartkopp.net:dkim,hartkopp.net:mid]
X-Rspamd-Queue-Id: 985D587492
X-Rspamd-Action: no action

The former implementation was only counting the tx_packets value but not
the tx_bytes as the skb was dropped on driver layer.
By enabling the CAN echo support (IFF_ECHO) in dummy_can_init() the code
to put and get the echo skb is activated and the tx_bytes are counted
correctly.

Fixes: 816cf430e84b ("can: add dummy_can driver")
Cc: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dummy_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/dummy_can.c b/drivers/net/can/dummy_can.c
index 41953655e3d3..cd23de488edc 100644
--- a/drivers/net/can/dummy_can.c
+++ b/drivers/net/can/dummy_can.c
@@ -239,10 +239,11 @@ static int __init dummy_can_init(void)
 	if (!dev)
 		return -ENOMEM;
 
 	dev->netdev_ops = &dummy_can_netdev_ops;
 	dev->ethtool_ops = &dummy_can_ethtool_ops;
+	dev->flags |= IFF_ECHO; /* enable echo handling */
 	priv = netdev_priv(dev);
 	priv->can.bittiming_const = &dummy_can_bittiming_const;
 	priv->can.bitrate_max = 20 * MEGA /* BPS */;
 	priv->can.clock.freq = 160 * MEGA /* Hz */;
 	priv->can.fd.data_bittiming_const = &dummy_can_fd_databittiming_const;
-- 
2.47.3


