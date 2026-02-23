Return-Path: <linux-can+bounces-6614-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK0WDdKBnGnaIgQAu9opvQ
	(envelope-from <linux-can+bounces-6614-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 17:35:30 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 826C6179E04
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 17:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41B2631525C2
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 16:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36416313540;
	Mon, 23 Feb 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cebHZYAj"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DC2313532;
	Mon, 23 Feb 2026 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864248; cv=none; b=QACQVbUKu5hLDwvgxYsZpcmbkr/Oh70e50tCad0+Hk0RgHC8Ez7Z2C0iw3UCaNFokLuPmq/3YfPlXgt4FVpta7K3Dn5MSw5/HTts44OvTo8ArTmdXw/KeQrV5yGwW1FpiKzox9R40ac6AY+1JZmUQ2xcR7xif5msR3LCArJ/IFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864248; c=relaxed/simple;
	bh=FP7qscXI0tj7QbSK1u37RS9JWo9pEA3OWNiBdhOJdxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRd6ltWsK5D8OH/wlHvX2qdM9wCoaDofpOEOfU5ODoLA+hdSBltopIZgK+cqYrl59omBqyZfT3+88OLrNYa1OUZOJU7F+q4A2BD+E4o4bpVg6xnJqScYYigf7JcTeE0hZs5jRUZ73OysiSX0IzMFz3Jj85CofdSuEAZlLH6eHe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cebHZYAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215CFC116D0;
	Mon, 23 Feb 2026 16:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771864247;
	bh=FP7qscXI0tj7QbSK1u37RS9JWo9pEA3OWNiBdhOJdxM=;
	h=From:To:Cc:Subject:Date:From;
	b=cebHZYAjqWSzJDNxuqSLSxXLLAWduiHycjidHW8CFOOQQ5Wula8ey3LLh1oG7HCVG
	 +kCznhhB1p6zQ/VZgZUUhiOdHHy6NiUJkoXEcWHjelM5U2ehIqXVFup3JgnL/f8HKK
	 FxDfBH9jrMcBjXhCSU01mLQWvWYeV4nVz8rqPszc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	stable <stable@kernel.org>
Subject: [PATCH] can: ucan: Fix infinite loop from zero-length messages
Date: Mon, 23 Feb 2026 17:30:20 +0100
Message-ID: <2026022319-huff-absurd-6a18@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 34
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=FP7qscXI0tj7QbSK1u37RS9JWo9pEA3OWNiBdhOJdxM=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlzGmbP7fRdKzPz8juuxacqZjRqXDhvxcjXkbHqxL3MC s7zvmtyO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAi378zzBW+YPYg8bDCWXN+ xcCu3yIyxYuXmDHMjzu66LvxnJnXlp9yO6rAuSdbM0WxBwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6614-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 826C6179E04
X-Rspamd-Action: no action

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
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.53.0


