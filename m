Return-Path: <linux-can+bounces-7644-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PMoEwjQCWoRqwQAu9opvQ
	(envelope-from <linux-can+bounces-7644-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 16:26:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1335561A3A
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 16:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6E243004C79
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 14:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FFD3B774F;
	Sun, 17 May 2026 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="TYXaWNv2"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9EE3B6BFA;
	Sun, 17 May 2026 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.224.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027383; cv=none; b=uLsLBcIZKr0F2/kfirQXj3rKUka5PTeE1u1sTkiw/AbX/2f8gKhqw+osCChtPQ+oq5a8t59BplkYTie43791P8k3WULqUupZc3JowFxP8TwQRdFOUYcVx6s84ZWiNyDOUAgRp6v5VSHl+SncprCmgF67rjKXfI8CZUJsQPXD2nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027383; c=relaxed/simple;
	bh=E+5rE7WnzKpZKHrWJx0IS9bEifvlfmUUp8PYIDd6u1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsUkisnV1KNM08irSJjffZXwD4wB/qGoGbIdhIvza7Ml8V58Amt33KokcnWT3Jc988sHXDbiR2Gd7lqSU+a+WwYcMun/DY2AZbIpEX5M8CgqP7YkdBkf44qduaTgFGBtjZ2RgC2WJ9fnQeazPVyU+z+FfCgRtWeHLqWSN/7pGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=TYXaWNv2; arc=none smtp.client-ip=93.95.224.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZZu/4zOYpHfrXMZxN3vf1rOOegDar5F3Gvvj7NThVoQ=; b=TYXaWNv2rFphn3xJ7Qhr9837d9
	lWcpOToa9FKwo6AL0LKblbXmN5n7PtjmgX53IkGUWP1dIk3nhkEQ2dBMtnTgIsuGYeAzCJorPl2an
	K4fjuFYXBm5fnARmhcenYjC6Tp3c+WDsTcI7cvRJ5dFP1zzxHWb1InZJGtLh2WtA8uiTmklXnWSK2
	ZUFYCg8ykx/bnSMQJ9rNCTKgd74ylgTVai9cw8vpitLY8wF7RVhGvCWseaf0gBc2En9FoJ+3f5FTj
	ecIEn7vI9QUdmW4ffPwXeB087pkYGBPIyc/9Juv1HQuqEZkwJv24OUPvPK43i4rRaZz/tRy0r/I89
	6GBJQqXA==;
Received: from localhost
	by mail-03.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wOcHk-00HFZk-1H;
	Sun, 17 May 2026 14:16:05 +0000
From: Berkant Koc <me@berkoc.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Stephane Grosjean <stephane.grosjean@hms-networks.com>
Cc: linux-can@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
Subject: [PATCH 2/2] can: peak_usb: validate URB length in pcan_usb_pro_decode_buf()
Date: Sun, 17 May 2026 15:55:02 +0200
Message-ID: <20260517-can-usb-fix-2@berkoc.com>
In-Reply-To: <20260517-can-usb-fix-cover@berkoc.com>
References: <20260517-can-usb-fix-cover@berkoc.com>
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
X-Rspamd-Queue-Id: E1335561A3A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.84 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	DMARC_POLICY_REJECT(2.00)[berkoc.com : SPF not aligned (strict),reject];
	R_DKIM_REJECT(1.00)[berkoc.com:s=1984];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-7644-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[berkoc.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-can@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

pcan_usb_pro_decode_buf() walks variable-sized records inside the
bulk-in URB. Each iteration reads pr->data_type (the first byte of the
record) and indexes pcan_usb_pro_sizeof_rec[] with it before checking
that the announced record length fits within msg_end. When the URB
length exactly equals PCAN_USBPRO_MSG_HEADER_LEN (4 bytes),
pcan_msg_init() returns a rec_ptr that already equals msg_end while the
on-wire rec_cnt field can still be non-zero. The first iteration then
reads pr->data_type one byte past the URB buffer.

A malicious USB device that pretends to be a PEAK-System PCAN-USB-Pro
adapter (USB IDs 0c72:000c..0c72:0014 across the Pro and Pro-FD line)
can keep returning short bulk-in URBs and trigger this read on every
poll cycle, leaking one byte of adjacent slab content into the
dispatch table lookup or producing a KASAN slab-out-of-bounds report.

Apply the pattern from commit 6fe9f3279f7d ("can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing header"):
verify that at least one byte remains before dereferencing the record
header.

Identified by static analysis. No KASAN trip available without specific
PEAK CAN-USB-Pro hardware.

Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific part")
Cc: stable@vger.kernel.org # 3.4+
Signed-off-by: Berkant Koc <me@berkoc.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 4bfa8d0fbb32..f7b0304f7c37 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -715,8 +715,19 @@ static int pcan_usb_pro_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 	msg_end = urb->transfer_buffer + urb->actual_length;
 	rec_cnt = le16_to_cpu(*usb_msg.u.rec_cnt_rd);
 	for (; rec_cnt > 0; rec_cnt--) {
-		union pcan_usb_pro_rec *pr = (union pcan_usb_pro_rec *)rec_ptr;
-		u16 sizeof_rec = pcan_usb_pro_sizeof_rec[pr->data_type];
+		union pcan_usb_pro_rec *pr;
+		u16 sizeof_rec;
+
+		/* make sure data_type is readable before dereferencing it */
+		if (rec_ptr >= msg_end) {
+			netdev_err(netdev,
+				   "got frag rec: should inc usb rx buf size\n");
+			err = -EBADMSG;
+			break;
+		}
+
+		pr = (union pcan_usb_pro_rec *)rec_ptr;
+		sizeof_rec = pcan_usb_pro_sizeof_rec[pr->data_type];
 
 		if (!sizeof_rec) {
 			netdev_err(netdev,
-- 
2.47.3


