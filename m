Return-Path: <linux-can+bounces-6616-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD24LdOGnGm7IwQAu9opvQ
	(envelope-from <linux-can+bounces-6616-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 17:56:51 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C017A35C
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 17:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 083B03004C3F
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 16:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05973311587;
	Mon, 23 Feb 2026 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l3/ipgNb"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3130F55B;
	Mon, 23 Feb 2026 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865502; cv=none; b=ZeDUoshw+KMFC/yGmckqHXOs2oxYOd1v0v+sOyNjJ3AeOi/WOEnhUJQk6EsNPZT95W4lH65AsWaIx6WTFGS1jRCD9UCh0528Y3s4cCFwAKIZgrm55fq8MKRiNbLR3lBpro7371eVRHQIA1a6PhgxjDkW/h4LZKOHU8ipnzpLmNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865502; c=relaxed/simple;
	bh=StPbs6Tt/ggrYwAMVMDK62w5hYb2NNO3WN+BkwJdyQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTW0y5tUzZyyJqPWfQ17PBIM1i8H3cSyU0h+piT3lCYPZHeRYrXRESHetIPfSY8OeXuM8igL9w872qXalxxWWFHOjwvtK0jG7mBTjt97F9SMAdiJF9AFL7viqgw0jQ4Y9tqYGJFYNU95+MElSkgcqTGm7LTECJyh7qaJ8C3Z4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l3/ipgNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4F3C116C6;
	Mon, 23 Feb 2026 16:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771865502;
	bh=StPbs6Tt/ggrYwAMVMDK62w5hYb2NNO3WN+BkwJdyQs=;
	h=From:To:Cc:Subject:Date:From;
	b=l3/ipgNbWQftv0mdXQVYLVNcdUTRyUhyfyZQpiM6I+NZU3Fw1W5nbVAOP+XZRPXZi
	 GuWLfFbh9ZqYgEK47F0Jzg6oJUaLkmncgqmtNRootjI2+qSvjD27uc8GRUtrVPmW6D
	 IOd+lvzaFaJdur4g39CDLP/OLtfT1PRj16Y7GO9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	stable <stable@kernel.org>
Subject: [PATCH] can: ems_usb: ems_usb_read_bulk_callback(): check the proper length of a message
Date: Mon, 23 Feb 2026 17:51:17 +0100
Message-ID: <2026022316-answering-strainer-a5db@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 46
X-Developer-Signature: v=1; a=openpgp-sha256; l=1652; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=StPbs6Tt/ggrYwAMVMDK62w5hYb2NNO3WN+BkwJdyQs=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlzWlvDbLPbtv1dX/v0UnPtkcty3tzbsnYWKS844s14/ QjjB/dzHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARTQGGuTIZJi1XOCZtlmC/ JmCq/0Hk0+vKBwzz87oj3+2YdiUiddl15xlpR7kVfocvBQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6616-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 312C017A35C
X-Rspamd-Action: no action

When looking at the data in a USB urb, the actual_length is the size of
the buffer passed to the driver, not the transfer_buffer_length which is
set by the driver as the max size of the buffer.

When parsing the messages in ems_usb_read_bulk_callback() properly check
the size both at the beginning of parsing the message to make sure it is
big enough for the expected structure, and at the end of the message to
make sure we don't overflow past the end of the buffer for the next
message.

Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/ems_usb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 4c219a5b139b..9b25dda7c183 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -445,6 +445,11 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 		start = CPC_HEADER_SIZE;
 
 		while (msg_count) {
+			if (start + CPC_MSG_HEADER_LEN > urb->actual_length) {
+				netdev_err(netdev, "format error\n");
+				break;
+			}
+
 			msg = (struct ems_cpc_msg *)&ibuf[start];
 
 			switch (msg->type) {
@@ -474,7 +479,7 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 			start += CPC_MSG_HEADER_LEN + msg->length;
 			msg_count--;
 
-			if (start > urb->transfer_buffer_length) {
+			if (start > urb->actual_length) {
 				netdev_err(netdev, "format error\n");
 				break;
 			}
-- 
2.53.0


