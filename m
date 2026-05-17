Return-Path: <linux-can+bounces-7642-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLsAM6PNCWq2qAQAu9opvQ
	(envelope-from <linux-can+bounces-7642-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 16:16:03 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD655618FD
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 16:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64A8E3004DFE
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 14:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD8F3B840F;
	Sun, 17 May 2026 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="iGPL7977"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA53B4EBD;
	Sun, 17 May 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.112.145.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027358; cv=none; b=kdLV4gUeYw6oOnpYu0cDRkclo1eey4IS4/WNYfo2ho5J4f0RHlSzhYRqbsXWgt1PfhgJhjXEeZ33qaXynP+ZW4VX/6ouauKNgByFIQm8O1azbTUwC5TCCHUpzthW5mxkodgqhX45ZWK++ajjs4KVJqX8H5OZTKd20icYOsZDTk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027358; c=relaxed/simple;
	bh=Qga+mtvz86YHLopOaANdVdDeOH1iglUFDZnSQM3MKCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VUCnVq5YQjRM818/634H19b+EyDtLoZ0Lf85sRS4TFuYIK9dwXZeWA8LqY97cIpSsvVZ36/EjHJNlBFPTzDM5P48fGmXisSXos9j16w+cCBOe2I2hh2OpKkGV171j6ku/ZmUj14stvPRQxLGiNMqUH7p1t/XyecNmujj8sTg2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=iGPL7977; arc=none smtp.client-ip=185.112.145.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date
	:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ROYjdED/XPcRufNK0R//jz4sQ/Lqx1XU3qMXN4nQjJ0=; b=iGPL7977BgnMDW+CgbK0wpi67E
	Bi1gwBiCxmhTTRlHW+cBi+Q2zl7sl+HE7WhZunYyHaD8QIGa8IKAPgxnMxJ1G1fJrVAAwtgXl4yIP
	TitoRltX79BofRzR6eQZNkr0EXBiFRAvRf52UBrcP7C+zflarAS1l3B8Yvg154kl+mIqMH1ngCn41
	4ZdKeJcAl1QTwRZ+EWLJYByaAVoMAK+zIB7qrGJN3N4wRtSLGNP1IeSFP+JhQZwmPQAqZicKyiOug
	sGySRwZV/J0T7A9jYcnEOMLY08qLkdSz2gDZluAF4Rc5ZIZcwOAuM/vn6pRyCCGgc7Ro27a5NY7Jg
	zS9BIjwg==;
Received: from localhost
	by mail-01.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wOcHR-00GB0n-34;
	Sun, 17 May 2026 14:15:46 +0000
From: Berkant Koc <me@berkoc.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Stephane Grosjean <stephane.grosjean@hms-networks.com>
Cc: linux-can@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
Subject: [PATCH 0/2] can: usb: validate URB length in PEAK-USB rx callbacks
Date: Sun, 17 May 2026 15:55:00 +0200
Message-ID: <20260517-can-usb-fix-cover@berkoc.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.0 (/)
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
X-Rspamd-Queue-Id: 1BD655618FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[berkoc.com : SPF not aligned (strict),reject];
	R_DKIM_REJECT(1.00)[berkoc.com:s=1984];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-7642-lists,linux-can=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[berkoc.com:-];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[berkoc.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series mirrors the two gs_usb hardening fixes that landed in 6.18
(commits 6fe9f3279f7d and 395d988f9386) for the two PEAK-System USB
drivers that share the same "walk records inside the bulk-in URB"
pattern: pcan_usb_fd.c and pcan_usb_pro.c. Both decode loops read the
on-wire record header before validating that the URB actually contains
that header, allowing a malicious USB device that emulates a PEAK CAN
adapter to trigger a short read of one or two bytes past the URB
buffer on every poll cycle.

Patch 1 adds a sizeof(struct pucan_msg) check at the top of the
pcan_usb_fd_decode_buf() loop and rejects records whose announced size
is smaller than the header itself.

Patch 2 adds a one-byte check before reading pr->data_type in
pcan_usb_pro_decode_buf(), which is the field used to index the
record-size table.

Both fixes are static-analysis-identified mirrors of the gs_usb
precedent. I did not have access to a PCAN-USB-FD or PCAN-USB-Pro
adapter and therefore no live KASAN trip is attached, but the trigger
condition (URB actual_length below the per-record header size) is
identical to the gs_usb case that Marc Kleine-Budde fixed in November.

A third candidate file, drivers/net/can/usb/usb_8dev.c, was reviewed
for the same pattern but already validates "pos + sizeof(struct
usb_8dev_rx_msg) > urb->actual_length" at the top of its loop and uses
a fixed-size record, so no patch is included for it.

Note: a concurrent series by James Gao (msgid <TYCPR01MB856782BAA657447E5EDDDC1FF0062>) hardens different sites in pcan_usb_pro.c (handle_canmsg + handle_error); the hunks in patch 2/2 here do not overlap.

Berkant Koc (2):
  can: peak_usb: validate URB length in pcan_usb_fd_decode_buf()
  can: peak_usb: validate URB length in pcan_usb_pro_decode_buf()

 drivers/net/can/usb/peak_usb/pcan_usb_fd.c  |  7 ++++---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 15 +++++++++++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.47.3

