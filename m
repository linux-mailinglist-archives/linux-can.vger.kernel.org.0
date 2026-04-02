Return-Path: <linux-can+bounces-7320-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHMRHSNLzmmjmgYAu9opvQ
	(envelope-from <linux-can+bounces-7320-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 12:55:31 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B347B387F9A
	for <lists+linux-can@lfdr.de>; Thu, 02 Apr 2026 12:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6463C3014C06
	for <lists+linux-can@lfdr.de>; Thu,  2 Apr 2026 10:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA63921F8;
	Thu,  2 Apr 2026 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6E7PHYT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="taYG/Vb0"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C101C35E95A
	for <linux-can@vger.kernel.org>; Thu,  2 Apr 2026 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127293; cv=none; b=lAzx0xNaRVnz/tAzr/IyL57qoaeY42dnZJRFlibZOI6XVa4DJe2WsBUYaV6Gk5cAHwKVdiaLLarA4ZbTVVd5w+tHKh/XT6PhN0UUv8eZjeaEmICBslszn1gFbrhGxqUCYcW8eAMkj564AR8Q80Sb/vw7esOdmqnYkLLI7hJhB6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127293; c=relaxed/simple;
	bh=L8OSfdSrUzwlc7XHc87PBimUe2do0GyLKH75wEtb4XE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KCcvAiZy6QKVjdkpyUxfMO+8RryMshYOK6FHv59i4zoTGHhi+9CTBDnddH8g683PqTgj/oiedNRyAIfQrauCyzD7E4lPzsu0dZX2gz4IszJtsR9RoB/ve/V1rrHw1LLHysYktv5DfY/GLFhyKrnIeXOUAb5X+glX+eEGTYV/03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6E7PHYT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=taYG/Vb0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775127290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfntzrCc3i8ggEz52wONssTEIrWSiHGoqS04l18kz/E=;
	b=A6E7PHYTt7eKLdeX2iPMQPZZjAbMP53dxBh6qW+p4v5dty8CLSQAdcZFd1H5zhLW+//P8M
	qgcd0iZo4B6GEoRhOH85zQOr0UtcDbohVi2jMwcNXSFfF1/xZB+w2UL2wJfQq0OKt3FwTh
	GORvx8Dhx3Hf7lvS0mwA+p1/2F5xVek=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-Aw_U5K7OOGaypgvSGnkj0A-1; Thu, 02 Apr 2026 06:54:49 -0400
X-MC-Unique: Aw_U5K7OOGaypgvSGnkj0A-1
X-Mimecast-MFC-AGG-ID: Aw_U5K7OOGaypgvSGnkj0A_1775127288
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4852ccff333so8892245e9.2
        for <linux-can@vger.kernel.org>; Thu, 02 Apr 2026 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775127288; x=1775732088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfntzrCc3i8ggEz52wONssTEIrWSiHGoqS04l18kz/E=;
        b=taYG/Vb0dfZ064Es3Oh4VRsZQ+KMx/nZ+6fReucqDGzNvrz28vSDjaXCxR1tgE7ks4
         RNHhaz1Bw9AdcpW+JMRHDbdy8MDtVgmZQF+hVt5iwyjv+7TG1h5M6FaUuPjdvm6xTtoR
         daxBD6Wu0xCV496URVNI33W2W10KEsLbPfGr1XwOrjzL6bN2knlvoeAy8f3gu5dDYMoc
         LyVeH8wf/DwmiFA+aUPFoYrdPi4oYihVsxPlm5PcWGzBRqHBBPBaubuZ9jHCKzVIipAc
         Z9gkzChWp6ioBw+D2PljCbhPqpqtfOw6KdDgFweHw3pkXahNwQiEiCIo9iTb6p5F9egd
         Qe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775127288; x=1775732088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UfntzrCc3i8ggEz52wONssTEIrWSiHGoqS04l18kz/E=;
        b=L4xtvR/m2PwVzWq8yiTPepUoNN2D9oSdJNqf4eU5HCN1KaXebfBYdn0reuz+XngklK
         LojZ1Uuf0JHTesM388TIfLmUM64IBE/wFvR4DgMzWBJ3Q2E6CEzkJH+NuAW7sjTxUMOg
         LveIiCV8mqjB8I4dEMK6lz+Fkegbg8PEBpvb+l4uMW59I1O5GcNjHSWYtQJtLc8nY70B
         lV+HjAsPLC5BtmyJZQaaMfM71M/NuRvxHgnH7dLR3LoMM7XiPHKbFVz+9q/W9DRSIQFN
         uDuFjgDSAR45zbGBgwIEF9LFeMDt5EIV8bb3Xa/Cy6j4Id2tuODge1s3WN8j/Xswd2u7
         DDjg==
X-Gm-Message-State: AOJu0Ywb8EyOvSjVjz38YHW+QgYNkx9+8BzHqeRX0UjdIQPLMd6bfqOW
	/Yl9soZUxtEQu5NmoqO3qPiLEvTVJHwSX59j+k64Xg6JPdZLYSkwzfXul6eR0nJLcqqTip3tSPF
	X5MFw+6iKpig5VsC8GbaoqmPNkOdjywTuu0rAjbU4V+L27GrIsU7KW+m0MhkWGw==
X-Gm-Gg: ATEYQzwfcgVQ9G41QNcKGNb7rsYwBJhYhSKqJlf1vL43h8AHorl+uTPSVkj874POZsf
	Oq5JmsuvFt0VcAyN3xZCpVJHEOQQCEY9qys22l/G8Hh0eTFt4zo7bp65Lq5Dzg9Dl6Hzqdr84ZJ
	pqaKYW32bc2pXnzFHFa9+U4cehyVPdcsKVlVEKsrwZYIUd2JDM9ieAIee6pNxjwd6kov/6jyvNC
	Wu6KIImdliaCj//qGck6fXGEFdB88JGdL+S1RHFGlkrfkArPCeYkxq6gVcDHJFfNXgoQNbE1Opp
	2Hks6F+wUGxsF5B/E0ZfDCpGvS9gigt/BPYXxUSWO1AICDqYw7MdrfYv8AeSLNiv68jjTWQXBKR
	sEt/z2ucnSxyaEQR0XfGFoCrWbAzPNZpS+OHoBcAOcEpsMcu/l4ApVDpBUNzX3fuKSravAdmQoM
	8pDhZ1dLrvL47plPy9VQ==
X-Received: by 2002:a05:600c:3b1e:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48883563102mr117892165e9.11.1775127288376;
        Thu, 02 Apr 2026 03:54:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1e:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48883563102mr117891705e9.11.1775127287845;
        Thu, 02 Apr 2026 03:54:47 -0700 (PDT)
Received: from fstornio-thinkpadx1carbongen11.remote.csb (net-2-34-60-62.cust.vodafonedsl.it. [2.34.60.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a630922sm234489435e9.0.2026.04.02.03.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 03:54:47 -0700 (PDT)
From: Filippo Storniolo <fstornio@redhat.com>
Date: Thu, 02 Apr 2026 12:54:02 +0200
Subject: [PATCH RFC can-next 1/3] af_can: ensure sk_protocol is always set
 on socket creation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-feat-can-diag-v1-1-245b56434c1b@redhat.com>
References: <20260402-feat-can-diag-v1-0-245b56434c1b@redhat.com>
In-Reply-To: <20260402-feat-can-diag-v1-0-245b56434c1b@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 "David S. Miller" <davem@davemloft.net>, 
 Urs Thuermann <urs.thuermann@volkswagen.de>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-can@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Radu Rendec <rrendec@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Filippo Storniolo <fstornio@redhat.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-7320-lists,linux-can=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fstornio@redhat.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B347B387F9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 0502b030d23851652be252f1342861332ce97367..f07394d44cdc97a09a4f7b0769b493b31ad6f4e3 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -419,7 +419,6 @@ static int j1939_sk_init(struct sock *sk)
 	/* j1939_sk_sock_destruct() depends on SOCK_RCU_FREE flag */
 	sock_set_flag(sk, SOCK_RCU_FREE);
 	sk->sk_destruct = j1939_sk_sock_destruct;
-	sk->sk_protocol = CAN_J1939;
 
 	return 0;
 }

-- 
2.51.0


