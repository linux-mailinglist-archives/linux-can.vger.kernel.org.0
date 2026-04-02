Return-Path: <linux-can+bounces-7318-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPTyNn4+zmkImQYAu9opvQ
	(envelope-from <linux-can+bounces-7318-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 12:01:34 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A83875DE
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 12:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF67930A10BD
	for <lists+linux-can@lfdr.de>; Thu,  2 Apr 2026 09:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DF03C73C0;
	Thu,  2 Apr 2026 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoeUGii4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PovB9XFw"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C917B3DCD80
	for <linux-can@vger.kernel.org>; Thu,  2 Apr 2026 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123649; cv=none; b=NmYV8/ofg/TL2MmL95vzDPDqYRcKUP2JJ7BWny018TplY7crWQEvOhOBiImKleRcwm/FXrJtnrw9o8aRyg3ctbM0cW041QtuGKEK3C+we6sZe4jA9sTg70pVjj/Tj72bP1v5OFkgLk3km2kOOSxma8D+l2jbbXCNykRgs+iaRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123649; c=relaxed/simple;
	bh=kzXmK1LyQ7Pxz5auKaOrqKn1PR5xdPEBrfI8KMqG3Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tll7y70dadIWLTpQaHTjImiAFyl7utEgHBoayRkUMpHuWHxUyG/r61xnKNDdmUUhR1ZplpG4DwI5KXNt1+arHqzGMxx8Wt6SG3WOt9Nndl9u4ReQaJafxm2V2CxaLyEmqwsnH10beCpNcLdi8FXakkM6jpNYagm+oLygT4/UYXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoeUGii4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PovB9XFw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775123645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9brIZXgm8f6iWI3LrJCz8H9WO/3Jzr4RfpoeDF6A6xA=;
	b=MoeUGii4eoYWcC2kiVKzi8NrHMMzLKYQr/U/0Qqgha0BjBJVgl9st2EF9URosi6JdmROZK
	CFZa8FwEWM76hENuXZv6iCOvB14pE2mx6j938BTN1lE2yFfBCXi8RX6iWBcQh64JksZCKk
	ZLSnLz9AuzkgWeIKlaGPzXYRNyzcVHg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-I1c0D0QGPiSyZ5IJoowSbA-1; Thu, 02 Apr 2026 05:54:02 -0400
X-MC-Unique: I1c0D0QGPiSyZ5IJoowSbA-1
X-Mimecast-MFC-AGG-ID: I1c0D0QGPiSyZ5IJoowSbA_1775123641
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b8c472f3eso540153f8f.0
        for <linux-can@vger.kernel.org>; Thu, 02 Apr 2026 02:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775123641; x=1775728441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9brIZXgm8f6iWI3LrJCz8H9WO/3Jzr4RfpoeDF6A6xA=;
        b=PovB9XFwNE6Zi87V0Cb+bXTs/crDqqRspeAI5bycxfXj1y29XAq2H+rm2Um1BBMeSS
         MzpUPpC91VRHji8eRZ3KuvENjM+a0zZKJEHvoZGdr/VE666kE2F2Gf+vqeAzG9bpYwMj
         iInFdzlPym8hEig3HkbpctfRS1Q42uhrm9/wPI3cNUsALsbKqhqiddDtbvJEugAZ7e9h
         lyG40kfF3wVnnqsD0WgT9IMFTdj0Zp6iB3+qfcwZ6/6nzYkJIJfFooM8z/KoNE5bcQBZ
         +pYZRSLTCpwDT2wqxx4S+5EuPT/QSPy9F9YZH/BrtBi5qJOGxv1u3gdo1WKsxSiPbHFU
         qwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123641; x=1775728441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9brIZXgm8f6iWI3LrJCz8H9WO/3Jzr4RfpoeDF6A6xA=;
        b=nfKoIZbE5L1SxoEu3XQxszYGt8lmf8fZLFOQNqAtaTsl9zKwdAE7HuHewTPvF7QIVR
         KXSm37XUzU3lxG1+zcc2OsorfXaGU57xgcWj8At4O1IIDWPhVTZl+GPW1ovDJW0l/GD3
         bWUbET+yjI3NMmo2KFlXdoMbdnkMxHaBz4isT8+Ruvb6NKllEAOJQ4nLY+VR2NjpEEJn
         QIW4fx22UvtQpYxkHEYBcu0qUtbtD6aranyis3pEWYtLJGiKn4F+hfPK5xh90rVGekqi
         iTkOFlHE7SEgbo+Mz6Vh9PDqqaW+eKmTVlkFb5XccQ7UAFCUwHgGf4mB0MSRHLHPLa9L
         6A3A==
X-Forwarded-Encrypted: i=1; AJvYcCWw4qe1hmg/HRj3Eeh16R1m6EgmGkt6/0tjXAirTgnrf4MJxCbsRPaY5TfjA76V/Pec0gQ5oahh8vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8THbOjsKkl0DNkyQ7peSwNS7XmeEsta0V5AD+iGn8rNhS7AuR
	HMrhNU3hq98+Abh32a7KePkns12AQ2aKI+E5c8ZGau6zS/IFTJjOkIpdjPEZPzqQvV4kqVukET+
	g983Ffv0pxed4Oj2uS+NtWyKw/gWBCebylh+kDEMJUD3SU2465u1RJikBpI1aaQ==
X-Gm-Gg: ATEYQzw1Peoraml+DN1uU/imtyaka7huLj0RhnNCzevHzMqYDDK16L1hOG8FjqAY4xD
	O2iSybCvxl9DclyVw2KS1dJ6zlMlZgvKg9Lpt/h5G/kvhMnKZVX0r8F2s9L+MOW4lE8770HwgkK
	W2+NoN+qlUbyHaWqdhTV2cyze7BNt9sm8sMP+8Xfe8yBwgIib5i2YeWtYaYChFzk+9C252hft2K
	CbteNDdr2vyNzFgLws1DFl7u8Mwe2dtqV7qWm52j+kbuOzkalxoXbfgZDalo+wnsoy1H+xmdA3M
	iMbuk8cOtl+hiD3SaAZrkNNGG/2oIpW2WJnwPwddfCCNuXRBphCek34bPH/9wLxYvCZzeAfwlxb
	zLMHFogxBTPcP/OVQtmc13JAUrxYiXZssohZ6BOiCrzKtekI=
X-Received: by 2002:a05:6000:2c07:b0:43b:43ae:8c2e with SMTP id ffacd0b85a97d-43d1f277a14mr4541944f8f.51.1775123640939;
        Thu, 02 Apr 2026 02:54:00 -0700 (PDT)
X-Received: by 2002:a05:6000:2c07:b0:43b:43ae:8c2e with SMTP id ffacd0b85a97d-43d1f277a14mr4541899f8f.51.1775123640463;
        Thu, 02 Apr 2026 02:54:00 -0700 (PDT)
Received: from fedora (185-219-167-200-static.vivo.cz. [185.219.167.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm6673371f8f.3.2026.04.02.02.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:54:00 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: mvaralar@redhat.com,
	virtualization@lists.linux.dev,
	linux-can@vger.kernel.org
Cc: dbassey@redhat.com,
	harald.mommer@oss.qualcomm.com,
	mkl@pengutronix.de,
	mailhol@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	mikhail.golubev-ciuchea@oss.qualcomm.com,
	sgarzare@redhat.com,
	francesco@valla.it
Subject: Re: [PATCH v13] can: virtio: Add virtio CAN driver
Date: Thu,  2 Apr 2026 11:52:43 +0200
Message-ID: <20260402095243.647258-1-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <acLNB9PYmJ9L0Wvc@fedora>
References: <acLNB9PYmJ9L0Wvc@fedora>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7318-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[dbassey@redhat.com,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C1A83875DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Matias,

I've been testing PATCH v13 of the virtio CAN driver and encountered a
FORTIFY_SOURCE panic when transmitting frames:

	sh-5.3# cansend can0 123#DEADBEEF                                                                                     
	[   51.700501] Kernel BUG at __fortify_panic+0x9/0xb [verbose debug info unavailable]                                 
	[   51.700798] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI                                                      
	[   51.700881] CPU: 2 UID: 0 PID: 374 Comm: cansend Tainted: G        W          6.12.76 #1                           
	[   51.701070] Tainted: [W]=WARN                                                                                      
	[   51.701143] RIP: 0010:__fortify_panic+0x9/0xb                                                                      
	[   51.701212] Code: 01 00 00 e9 58 7e c2 ff cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90  
	90 40 0f b6 ff e8 57 a9 c2 ff <0f> 0b 48 8b 54 24 08 48 8b 74 24 10 4c 8d 44 24 1d 4c 89 e1 48 c7                     
	[   51.701406] RSP: 0018:ffffc900001ffb10 EFLAGS: 00010246                                                            
	[   51.701454] RAX: 0000000000000000 RBX: ffff888100ea8780 RCX: 0000000000000003                                      
	[   51.701530] RDX: 0000000000000000 RSI: ffffc900001ff9b8 RDI: 0000000000000001                                      
	[   51.701625] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000fffffbff                                      
	[   51.701700] R10: ffffffff82239ee0 R11: ffffc900001ff9b0 R12: ffff888100ea8000                                      
	[   51.701789] R13: ffff888100817200 R14: ffff88810037cda0 R15: ffffc900001ffb48                                      
	[   51.701866] FS:  00007f7c4cda3740(0000) GS:ffff88812bd00000(0000) knlGS:0000000000000000                           
	[   51.701948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033                                                      
	[   51.702007] CR2: 00007f7c4ceffdc0 CR3: 0000000100d12000 CR4: 0000000000350eb0                                      
	[   51.702072] Call Trace:                                                                                            
	[   51.702105]  <TASK>                                                                                                
	[   51.702126]  ? virtio_can_start_xmit.cold+0x2b/0x4d                                                                
	[   51.702171]  ? srso_alias_return_thunk+0x5/0xfbef5 

The issue is in virtio_can_start_xmit() where can_tx_msg->tx_out.length
is set AFTER memcpy(can_tx_msg->tx_out.sdu, ...). Since sdu[] uses
__counted_by_le(length), FORTIFY_SOURCE sees length=0 during the copy
and panics.

The fix is to set length before the memcpy:

diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
index xxx..yyy 100644
--- a/drivers/net/can/virtio_can.c
+++ b/drivers/net/can/virtio_can.c
@@ -308,6 +308,7 @@ static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
 
 	can_tx_msg->tx_out.msg_type = cpu_to_le16(VIRTIO_CAN_TX);
+	can_tx_msg->tx_out.length = cpu_to_le16(cf->len);
 	can_flags = 0;
 
 	if (cf->can_id & CAN_EFF_FLAG) {
@@ -322,7 +323,6 @@ static netdev_tx_t virtio_can_start_xmit(struct sk_buff *skb,
 		can_flags |= VIRTIO_CAN_FLAGS_FD;
 
 	can_tx_msg->tx_out.flags = cpu_to_le32(can_flags);
-	can_tx_msg->tx_out.length = cpu_to_le16(cf->len);
 
 	sg_init_one(&sg_out, &can_tx_msg->tx_out, hdr_size + cf->len);

Tested with vhost-device-can backend, and it works correctly after this fix.

Thanks,
Dorinda Bassey


