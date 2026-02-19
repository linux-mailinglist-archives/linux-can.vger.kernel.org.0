Return-Path: <linux-can+bounces-6597-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N9yI68/l2lXwAIAu9opvQ
	(envelope-from <linux-can+bounces-6597-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 17:51:59 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71068160CE8
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 17:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C92233030EF9
	for <lists+linux-can@lfdr.de>; Thu, 19 Feb 2026 16:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CD334CFCC;
	Thu, 19 Feb 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIAEoh8N"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA134CFAE;
	Thu, 19 Feb 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771519909; cv=none; b=AEqlmUs0CdhHeuxR5sWONxMzmZqb1fHNOQjMtyoTBvSuwZvNWHxCr3fW3dJm8Umhx+xakYSBATgkr2De9P5XZHLIe8hOWS3JiIVJxNGKEmtlo2MnXmuwipiUxDrYoa97KDkunBR9GWgxiqSDPv+/0HzLWC03ez24PMS35fY/5o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771519909; c=relaxed/simple;
	bh=Ndj7MZu1RYgFXaRQMR5Ww5AM02i+hNiCGZqxPAQvqAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgjcwGR+nglWtAVDGRZsJegj/qQp9PDXidgRNRYRoV+N2eEpy0G0AFSGA9y/W0aovg5Vk9oJGSUzWD6MDICktpCa6ASQrrvMsm7Hh5Bw4wSII1TUYjcTu7Ui7vYEn7c4ZGumeGNtB7PL4jLxGYqS4DIsxSwd6cz3TVbhWkkcGro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIAEoh8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4883C19421;
	Thu, 19 Feb 2026 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771519908;
	bh=Ndj7MZu1RYgFXaRQMR5Ww5AM02i+hNiCGZqxPAQvqAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WIAEoh8NKt64kCCMP6Kuru4FIahCUMvNgqddpu9JRwdatalVOjE+QXKfW2uu17baS
	 oXBpJOpWVhvvI4pjnOTk7rHT8mPqDMS++3JFMXPx2UfFoZMCVzmV1yWn4EnDa0vE3h
	 U/KzBvX8+So47N8SjQOpcD8dZ2PDrsiR9NG33xPP2qMbQGmYfmCQgqnBFyfxSC3bPv
	 3vpBprX0UKifMCAsoQ/g4AH4iTnCQ+Gokp/IKRYM4AQR4eKsi/1fIzigQzB9YCKgsI
	 jA6LLCb1wRHIbh/RYZkvdCP3pRapADgSEbKqYF5m0l/MY1WMm8PwRAGTIlc6LgtxjV
	 2C55cqc7gsiUw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A365CE9A051;
	Thu, 19 Feb 2026 16:51:48 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Thu, 19 Feb 2026 17:51:17 +0100
Subject: [PATCH v3 1/3] can: bcm: fix locking for bcm_op runtime updates
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-bcm_spin_lock_init-v3-1-c61026740d7b@hartkopp.net>
References: <20260219-bcm_spin_lock_init-v3-0-c61026740d7b@hartkopp.net>
In-Reply-To: <20260219-bcm_spin_lock_init-v3-0-c61026740d7b@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771519907; l=1553;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=XQu0DK6j8SlJ077Pj9O4qw1EtV49i3xT6l7+T5PUHaM=;
 b=ZffYcnzmkUyzxhttrdkJTF2yjTZSj9Njia7OwlRQeUSeM3XgkMKXvfl1kgQyd2XB3IRSXsq1z
 wcmIzFCjZJ7DX2uQiXhgyyVgMamm1kMxu0OSplfq4H9e/hXa9QRtVAx
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6597-lists,linux-can=lfdr.de,socketcan.hartkopp.net];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[socketcan@hartkopp.net];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-can@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-can,5b11eccc403dd1cea9f8];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:mid,hartkopp.net:email,hartkopp.net:replyto]
X-Rspamd-Queue-Id: 71068160CE8
X-Rspamd-Action: no action

From: Oliver Hartkopp <socketcan@hartkopp.net>

Commit c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
added a locking for some variables that can be modified at runtime when
updating the sending bcm_op with a new TX_SETUP command in bcm_tx_setup().

Usually the RX_SETUP only handles and filters incoming traffic with one
exception: When the RX_RTR_FRAME flag is set a predefined CAN frame is
sent when a specific RTR frame is received. Therefore the rx bcm_op uses
bcm_can_tx() which uses the bcm_tx_lock that was only initialized in
bcm_tx_setup(). Add the missing spin_lock_init() when allocating the
bcm_op in bcm_rx_setup() to handle the RTR case properly.

Fixes: c2aba69d0c36 ("can: bcm: add locking for bcm_op runtime updates")
Reported-by: syzbot+5b11eccc403dd1cea9f8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-can/699466e4.a70a0220.2c38d7.00ff.GAE@google.com/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index b7324e9c955b..fd9fa072881e 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1174,10 +1174,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		/* insert new BCM operation for the given can_id */
 		op = kzalloc(OPSIZ, GFP_KERNEL);
 		if (!op)
 			return -ENOMEM;
 
+		spin_lock_init(&op->bcm_tx_lock);
 		op->can_id = msg_head->can_id;
 		op->nframes = msg_head->nframes;
 		op->cfsiz = CFSIZ(msg_head->flags);
 		op->flags = msg_head->flags;
 

-- 
2.51.0



