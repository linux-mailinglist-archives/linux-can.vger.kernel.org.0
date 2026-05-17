Return-Path: <linux-can+bounces-7643-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id me3HBM7PCWreqgQAu9opvQ
	(envelope-from <linux-can+bounces-7643-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 16:25:18 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F135619D8
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 16:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1683330028C3
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 14:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8D23B52F1;
	Sun, 17 May 2026 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b="BHLYLuAA"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E13B7742;
	Sun, 17 May 2026 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.112.145.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027381; cv=none; b=LBf/xuFFhNY0pXtxcED4+bvOB5uOnSUipwy8igfH2FfNjSvSjeJLLgOkSxhin5ZKf68SVrCIeJ47ipRTznEXGSAEIwaVTQNpJcY8cmY5kcWMsnW47e2FtI6I4rw3fkeM6nsmt82iRXNVYHVmgI+4juh8SgY+ZygJ4UjrdOpwlKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027381; c=relaxed/simple;
	bh=85gBWQxdegiTwkYwL7s4UdSq1wrq7dfldbj1E6oPWLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gILLhSZTSBEqAQCQIK7V1MBspi/MnDTWpiZMlfiJCdv1K8lDZy1rVNxvHfL6DYIvcajvcKLf4ZRcDqXfnk9tmZshuzeFWiEq2kUqZ09xCi61E2hl1pDcVzlzNIqECKEBV96iiBlldzK1c7XfJ2WsGe3rJ9SHjSPA71mYy0k68Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com; spf=pass smtp.mailfrom=berkoc.com; dkim=pass (2048-bit key) header.d=berkoc.com header.i=@berkoc.com header.b=BHLYLuAA; arc=none smtp.client-ip=185.112.145.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkoc.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com;
	s=1984; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Taz36b0OeGtwr42qKl6eT5tEtMR06TYfgdbmRhMuCfs=; b=BHLYLuAAd8MFWeVGIK1QQk+hUo
	Mv6dE/pldAns3sbhGyVYDvfE08MfKQP+fsjsLA4L5Nb3RxT9mMjSy+RHBwmDAYd67E+JDHgXfKpU+
	ZpKzzBG1O/JoHspE+ItW8+wbxqYBFXdaPCrfMMvlcmGJGHPI46gnaxpKdn+Ye4CrRrfYb3uyk9TLV
	bhhj8+b/r8hfNm/puhGY/zTLghvAjjrsJdQ6wn8g7sssGl1J277EbOlcRc1mnyp6epnlKEjGkOduh
	yR348FucBqNxQjD/xyfkDxNzbOnGm+JCa5WrbJGAQNpKfQp5evRorACqIVrKd0Fz9eZIk3/nMxWE6
	O/DKgFOw==;
Received: from localhost
	by mail-01.1984.is with utf8esmtp (Exim 4.96)
	(envelope-from <me@berkoc.com>)
	id 1wOcHa-00GB1t-2U;
	Sun, 17 May 2026 14:15:55 +0000
From: Berkant Koc <me@berkoc.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Stephane Grosjean <stephane.grosjean@hms-networks.com>
Cc: linux-can@vger.kernel.org,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
Subject: [PATCH 1/2] can: peak_usb: validate URB length in pcan_usb_fd_decode_buf()
Date: Sun, 17 May 2026 15:55:01 +0200
Message-ID: <20260517-can-usb-fix-1@berkoc.com>
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
X-Rspamd-Queue-Id: 13F135619D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.84 / 15.00];
	SEM_URIBL_FRESH15(3.00)[berkoc.com:email];
	DMARC_POLICY_REJECT(2.00)[berkoc.com : SPF not aligned (strict),reject];
	R_DKIM_REJECT(1.00)[berkoc.com:s=1984];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7643-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[berkoc.com:-];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	FROM_NEQ_ENVFROM(0.00)[me@berkoc.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

pcan_usb_fd_decode_buf() walks records inside the bulk-in URB by reading
the 12-byte struct pucan_msg header from the front of each record. The
existing loop only verifies that msg_ptr is below msg_end before
dereferencing rx_msg->size and rx_msg->type, which means a short URB
that contains between 1 and 11 bytes of payload causes a two-byte
out-of-bounds read of the rx_msg->size and rx_msg->type fields. The
fragment check that follows compares the announced size against msg_end
but lands after the header has already been read.

A malicious USB device that pretends to be a PEAK-System PCAN-USB-FD
adapter (USB IDs 0c72:0012, 0c72:0014, 0c72:0016) can keep returning
short bulk-in URBs and trigger this read on every poll cycle, leaking
adjacent slab content via the dispatched decode paths or simply
producing a KASAN slab-out-of-bounds report.

Apply the pattern from commit 6fe9f3279f7d ("can: gs_usb: gs_usb_receive_bulk_callback(): check actual_length before accessing header"):
require that at least sizeof(struct pucan_msg) bytes remain before each
iteration, and reject records whose announced size is smaller than the
header itself.

Identified by static analysis. No KASAN trip available without specific
PEAK CAN-FD hardware.

Fixes: 0a25e1f4f185 ("can: peak_usb: add support for PEAK new CANFD USB adapters")
Cc: stable@vger.kernel.org # 4.0+
Signed-off-by: Berkant Koc <me@berkoc.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index eb4f5884ad73..63d93f90165c 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -726,7 +726,7 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 	/* loop reading all the records from the incoming message */
 	msg_ptr = urb->transfer_buffer;
 	msg_end = urb->transfer_buffer + urb->actual_length;
-	for (; msg_ptr < msg_end;) {
+	while (msg_ptr + sizeof(struct pucan_msg) <= msg_end) {
 		u16 rx_msg_type, rx_msg_size;
 
 		rx_msg = (struct pucan_msg *)msg_ptr;
@@ -738,8 +738,9 @@ static int pcan_usb_fd_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 		rx_msg_size = le16_to_cpu(rx_msg->size);
 		rx_msg_type = le16_to_cpu(rx_msg->type);
 
-		/* check if the record goes out of current packet */
-		if (msg_ptr + rx_msg_size > msg_end) {
+		/* check if the record fits inside the current packet */
+		if (rx_msg_size < sizeof(struct pucan_msg) ||
+		    msg_ptr + rx_msg_size > msg_end) {
 			netdev_err(netdev,
 				   "got frag rec: should inc usb rx buf sze\n");
 			err = -EBADMSG;
-- 
2.47.3


