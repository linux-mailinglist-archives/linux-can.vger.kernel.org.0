Return-Path: <linux-can+bounces-7818-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pKFTM8mgKWqvawMAu9opvQ
	(envelope-from <linux-can+bounces-7818-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:37:13 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4320B66BFEA
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:37:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="FX0HxI/t";
	dkim=pass header.d=redhat.com header.s=google header.b=sHQpFu7w;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7818-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7818-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F371F301702A
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 17:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8308E347536;
	Wed, 10 Jun 2026 17:25:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A89E342C8B
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 17:25:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781112354; cv=none; b=VSMdLNkMPSnDGBXi8au6KjnShfTGs8SrP3tMSemW/w/tsx6yK3smYbrKa0G6ynpEGvsvqs5ePhwg0zWbrjCLgfQOiIaO2CMtuk1uemS++NH2BaLfiBPxtjHAoHiPJrgvzRH27GPTyQjJsa/kRQd33FQjpNn3u2f191+EhbeemoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781112354; c=relaxed/simple;
	bh=InVedcI/+FDKV2aaM6BGSSMHBkbqktEU0XyYvAiNJTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ui0aCI7xACoGhIRZ7qWSETSGJGgWGnS9KYyR3GKC4xmyg3C+WIXV3vhxbtcpHX19ggqwlfEGlnUkxAYiPq5FO5x+q7SpDXbzbR8AdnoHOFr51OgXo66FkkDWOp3wwSmyqWnrEF7akQTjGZRloGQYFJ6w2C3XfE68q6CwvPbHqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FX0HxI/t; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sHQpFu7w; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781112352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4Gt9ZnpRGrdkzXd1xO8NAiKWNA/dH79qAiF/6fH26E=;
	b=FX0HxI/tgrwZ+L7nCOE0U/stLMPbFyTwWdbqVnFuqWHAvLrPMFn5hbvOpT1+jR67uzb2Xa
	1Ra+BVpZhg7KFBL1IYHnq69X/DO3bbaheXoUGgz1LagUoQoHQTjdw96fVWRt5Wd3RLQpl6
	BX/jurm4eHBE+Q4Q5oS7D8B5iByjhsY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-eMOc4h6mPeOa_0o_d78M6w-1; Wed, 10 Jun 2026 13:25:49 -0400
X-MC-Unique: eMOc4h6mPeOa_0o_d78M6w-1
X-Mimecast-MFC-AGG-ID: eMOc4h6mPeOa_0o_d78M6w_1781112348
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-91579011fd1so1049308985a.1
        for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 10:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781112348; x=1781717148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4Gt9ZnpRGrdkzXd1xO8NAiKWNA/dH79qAiF/6fH26E=;
        b=sHQpFu7wO86J55BIIQ2fgUOJEL0LI/XilXBLj0tzRkldmryUhFW7nG2ssAxM28hIMj
         wH7OLXxGoxdvqiVs40tEiM1WF7DTQNBwnx4sBGl2cZ3k26loeAXkH0eRMMCh7H9R9chh
         MzSj3BUqI8SylLhuJMDHKBCXaosuT2wg4C4AUSXtA/hE/DvP77TEusZwJ3Hx7Y25Tr9C
         r5zEFKpHUm2YjrFczDGKjsGWVzKMZoccvt2lApswpPK9sNySX9Gfz68ntcx5K9FuUc6M
         f3v8wYCMu2xJMHOk+dLOc895XkBdFgGIJaPWwFJiP/Qs/e/tbq/ezAMRKmsdERDWu5M/
         M7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781112348; x=1781717148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m4Gt9ZnpRGrdkzXd1xO8NAiKWNA/dH79qAiF/6fH26E=;
        b=VQKyAhYo7J60+RBZxJNsGsYJVQHjYGyKaIU1sNCtWXYWNFEryduMcyEZU2tfJeckEe
         8ZtTLkB/WvtBuBNTDIXzzowQtE1m70WnGwKs9N4BXDNqUn03hC76tUGkpEEpXD0snN2E
         OkKrbqMNHVPAWgVm7OAY0lg34AMtThPCaEoR6k18l2XLOWeITpSLTa/0M/wMutn03CwQ
         pXQ22Adp6uqSm6dEhlQqxEjY9Hqfhb3DV94MTS0h9picdx/vpxNoXPcGqrFNDMSk5p/O
         tDmxSIvNfBlYWXGXtvDF/JurQAwabNi0Pl9JdhtypHUnXFf2tt50JEmsmtSOgkBF3JYD
         ORpA==
X-Gm-Message-State: AOJu0Yx38psUIGIWpXO2i6OGxf3t4dO07hT4btakIFVhZgU0u/igWWO/
	4ejybWSLYmQVmiEZLdja+cyCowiBmWVQ5ZgqkaiNwPxh3fwtQ/Zu6WA10MdSti5loPZen4JhdwM
	QEtJHm4nje6RcR2VoIOeCguqek5CZvSt8pvyXTbmpm/VeLiUA2VQfyGCBDIZi1ZQ4YKVndR/6
X-Gm-Gg: Acq92OE0dOg4JlqEEjdLs2UZ5pMOxqKGn9pfjn8X2FSyZvS950Dwrjztcfr3QwAIIQE
	80/bD/Ofvl2np2PU9qo/JqxMhaxVZDlh0oUVAW3zLTpIfYXNt5gagyXxsAuAFQWjvno2upIQkhW
	8Hn2nV0uTP6qtjyP5T38h7YQ6FREuPUlmWxBO3mQpxohzqWh3LQRWTDJAH0UwTDBcgPe3VfXiel
	MYTrwom2FfFFo3in4R9GoVDNr9DIstIv5AE1jl9qkrCiVqF7Hwdm4QQv3oueInSfiHL7Lm7qEGL
	XE1w+Z/R8cy1FJZd56o63RjJUpfXi1vpnNVyvxzvpKKM2932OPTvjHTpXG489/4dVvmblwfdsZ0
	HT1Nfkk988TAByLqdUKk3/fPGJDNIpb5QEWTxQAcL6CqZrO+sD3okB0z1wmK5j38keFaoGgYPy+
	0dIaljVoBRDYCo4AAyfOxT8yVKdIJl5dxusPoi
X-Received: by 2002:a05:620a:28d1:b0:915:4c90:34fc with SMTP id af79cd13be357-915a9c12fd0mr4199906485a.11.1781112348362;
        Wed, 10 Jun 2026 10:25:48 -0700 (PDT)
X-Received: by 2002:a05:620a:28d1:b0:915:4c90:34fc with SMTP id af79cd13be357-915a9c12fd0mr4199900185a.11.1781112347793;
        Wed, 10 Jun 2026 10:25:47 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb (net-93-66-125-181.cust.vodafonedsl.it. [93.66.125.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381abfsm2532946085a.27.2026.06.10.10.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:25:47 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Wed, 10 Jun 2026 19:24:44 +0200
Subject: [PATCH can-next 1/3] af_can: ensure sk_protocol is always set on
 socket creation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-feat-can-diag-v1-1-021e3f1631a0@redhat.com>
References: <20260610-feat-can-diag-v1-0-021e3f1631a0@redhat.com>
In-Reply-To: <20260610-feat-can-diag-v1-0-021e3f1631a0@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, Filippo Storniolo <fstornio@redhat.com>, 
 Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-7818-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fstornio@redhat.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:robin@protonic.nl,m:o.rempel@pengutronix.de,m:kernel@pengutronix.de,m:urs.thuermann@volkswagen.de,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-can@vger.kernel.org,m:fstornio@redhat.com,m:dcaratti@redhat.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fstornio@redhat.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4320B66BFEA

From: Davide Caratti <dcaratti@redhat.com>

Currently, only j1939 assigns a value to 'sk_protocol'. As a prerequisite
for the implementation of CAN sockets diagnostics, AF_CAN sockets need an
easy way to determine which protocol is on top of an existing socket.

POC test using can-tests:

 | # perf probe -m can_j1939 --add "j1939_sk_recvmsg sock->sk->sk_protocol"
 | # perf record -e probe:j1939_sk_recvmsg -aR -- ./j1939/tst-j1939-ac
 | [...]
 | # perf script
 | tst-j1939-ac  5807 [002] 322767.312599: probe:j1939_sk_recvmsg: (ffffffffc0b29a14) sk_protocol=0x7
 |  ^^^ 0x7, that's CAN_J1939

 | # perf probe -m can_raw --add "raw_recvmsg sock->sk->sk_protocol"
 | # perf record -e probe:raw_recvmsg -aR ./netlayer/tst-rcv-own-msgs vcan0
 | # perf script
 | [...]
 | tst-rcv-own-msg  5816 [001] 323173.651122: probe:raw_recvmsg: (ffffffffc0b20154) sk_protocol=0x1
 |  ^^^ 0x1, that's CAN_RAW. It was 0x0 on unpatched kernel

Storing the "protocol" value in can_create() fixes the problem. This also
fixes AF_CAN support for the following system call:

 | getsockopt(..., SOL_SOCKET, SO_PROTOCOL, &proto, sizeof(proto))

that was assigning 0 to 'proto' since the earliest kernel versions.

Fixes: 0d66548a10cb ("[CAN]: Add PF_CAN core module")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/can/af_can.c       | 1 +
 net/can/j1939/socket.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 7bc86b176b4de32dddeab5a42a420d62434fcd7f..65af259469854fc19cda0d7dd01c7b4da2ec0f4c 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -162,6 +162,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 	}
 
 	sock_init_data(sock, sk);
+	sk->sk_protocol = protocol;
 	sk->sk_destruct = can_sock_destruct;
 
 	if (sk->sk_prot->init)
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 50a598ef5fd4a5f5e007816a341e04ddbcc724e6..ccd43ff5519c72f209b53bf74b833acd6ffe9728 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -420,7 +420,6 @@ static int j1939_sk_init(struct sock *sk)
 	/* j1939_sk_sock_destruct() depends on SOCK_RCU_FREE flag */
 	sock_set_flag(sk, SOCK_RCU_FREE);
 	sk->sk_destruct = j1939_sk_sock_destruct;
-	sk->sk_protocol = CAN_J1939;
 
 	return 0;
 }

-- 
2.53.0


