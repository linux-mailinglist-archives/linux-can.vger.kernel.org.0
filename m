Return-Path: <linux-can+bounces-8007-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FEodGsV/S2qsSQEAu9opvQ
	(envelope-from <linux-can+bounces-8007-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 12:13:25 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE62C70EF86
	for <lists+linux-can@lfdr.de>; Mon, 06 Jul 2026 12:13:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8007-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8007-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A184D3063AA6
	for <lists+linux-can@lfdr.de>; Mon,  6 Jul 2026 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0E348033E;
	Mon,  6 Jul 2026 09:28:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B438E113;
	Mon,  6 Jul 2026 09:27:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330082; cv=none; b=m7eyzT67AFcV3shN/XLdndZ+q9hfJps8L9ZGvIlXrNrUjDRYvFwHPK97KAMnTx0k5evPZXLdP7Xw8G4uX13ab6RSREPZuoHB8nBtrju+Oi3SurzeFK99nElKRQABIQWZxNOYr61wtJOch28fbsPCJKNvZRkJmXAD2DbZDzCcQ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330082; c=relaxed/simple;
	bh=qKLysQg1XYAGmBo19L+TYY0i/1VlXIM6iW5VVO9i1hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUYQM44IOJhgXeyFCG0hM9TKM86znxboBmll5OTL/La8230xpMKWqHwVlv9ppvLjRLJbSYeOdntMUxHImQL4T1VjHMExY9M8cA5vwKXTxhkMUo3HwNUZ06GIzcpAjX95IHxm13JK7HcC65c2DtGuUIPF0GBMfGb2qNBMm57WopQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowABX9c0ZdUtqomHxBA--.1220S2;
	Mon, 06 Jul 2026 17:27:53 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Vincent Mailhol <mailhol@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: ems_usb: validate CPC message lengths
Date: Mon,  6 Jul 2026 17:27:52 +0800
Message-ID: <20260706092752.79600-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABX9c0ZdUtqomHxBA--.1220S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw15WFyxZFWkXF48ZF1DJrb_yoW8Zw4DpF
	15AFs5Zr1UXrW2q3yft3Z7A34fX3Z2kF17GrZ2y3Wfuw1DX3WDGr1UGryYga4DXF13C3sa
	9wsrJFy5GaySk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8-
	B_UUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-8007-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:pengpeng@iscas.ac.cn,m:mailhol@kernel.org,m:gregkh@linuxfoundation.org,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE62C70EF86

ems_usb_read_bulk_callback() walks CPC messages packed in one USB
receive buffer.

Check that each declared message fits in the URB payload. Also require the
type-specific payload to cover the fields used by the CAN, state, error and
overrun handlers.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/can/usb/ems_usb.c | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 9b25dda7c183..24cf8f651f8f 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -409,6 +409,40 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 		netif_rx(skb);
 }
 
+static bool ems_usb_rx_msg_len_valid(struct ems_cpc_msg *msg)
+{
+	size_t len = msg->length;
+	size_t can_len;
+
+	switch (msg->type) {
+	case CPC_MSG_TYPE_CAN_STATE:
+		return len >= sizeof(msg->msg.can_state);
+
+	case CPC_MSG_TYPE_CAN_FRAME:
+	case CPC_MSG_TYPE_EXT_CAN_FRAME:
+	case CPC_MSG_TYPE_RTR_FRAME:
+	case CPC_MSG_TYPE_EXT_RTR_FRAME:
+		if (len < CPC_CAN_MSG_MIN_SIZE)
+			return false;
+
+		if (msg->type == CPC_MSG_TYPE_RTR_FRAME ||
+		    msg->type == CPC_MSG_TYPE_EXT_RTR_FRAME)
+			return true;
+
+		can_len = can_cc_dlc2len(msg->msg.can_msg.length & 0xf);
+		return len >= CPC_CAN_MSG_MIN_SIZE + can_len;
+
+	case CPC_MSG_TYPE_CAN_FRAME_ERROR:
+		return len >= sizeof(msg->msg.error);
+
+	case CPC_MSG_TYPE_OVERRUN:
+		return len >= sizeof(msg->msg.overrun);
+
+	default:
+		return true;
+	}
+}
+
 /*
  * callback for bulk IN urb
  */
@@ -451,6 +485,15 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 			}
 
 			msg = (struct ems_cpc_msg *)&ibuf[start];
+			if (msg->length >
+			    urb->actual_length - start - CPC_MSG_HEADER_LEN) {
+				netdev_err(netdev, "format error\n");
+				break;
+			}
+			if (!ems_usb_rx_msg_len_valid(msg)) {
+				netdev_err(netdev, "format error\n");
+				break;
+			}
 
 			switch (msg->type) {
 			case CPC_MSG_TYPE_CAN_STATE:
-- 
2.43.0


