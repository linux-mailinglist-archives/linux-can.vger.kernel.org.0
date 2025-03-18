Return-Path: <linux-can+bounces-3150-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DFAA6718C
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 11:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39F917021B
	for <lists+linux-can@lfdr.de>; Tue, 18 Mar 2025 10:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C21207A33;
	Tue, 18 Mar 2025 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Byx16wuY"
X-Original-To: linux-can@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391F2063EA
	for <linux-can@vger.kernel.org>; Tue, 18 Mar 2025 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294388; cv=none; b=V7BJ8ryoLA4MS4Qme6YboiUJzkF96cLpbq6q64UwWpFSozrnXz4nF1Jrkmq0+MvXnxnRS/7FPRSFqOijZbi8WaFhyGWkQnaUGCJPn58F94Mt7gG+E/m2G7xJ+b9nGYwu34Bhm9e6CKqvFSUj6U3RS8dVTYuek92ZQbS+BsNQENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294388; c=relaxed/simple;
	bh=oyX/E9sPF9vH6dnflMgJU9Px9RiYBzuqDs6hkJLZlpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6wbdDwchCHA4PsJalziV7I1FELNm+Ta91NyZPtlconRdcJqd3Fzb4QQmfGSkMVvMtM6lSh+TTVneHMb0ni6XWzQN6kEXK3okZWQEyyGUD0smfHIgZUjlMEJor0VT0Lg1pKKDgdIhrxh4knl8ufyh6p0BWKkjP6BDIkhmmqbudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Byx16wuY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742294382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vjlReZQ0b0uUx1D7XtU3sabRQ2+EQRRJVmZU4eA+1I8=;
	b=Byx16wuYccF9T3Gm6nNkyLDnIC5/nzbwNXny2nh+O5fHSBiaTdD1GDeBEp4IWF4et7EBKx
	/3QA3jUlEVQUCJUHiqQc6IBcqc8AbvTo5JYznLVqIlGNCLlYfgHw2PQ4GhW2JhfPRCD6Jh
	mwd/cZH8gGYtbYVdkg+g2hLXrRrWOP4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-PKc4aKPzMguiU75Z_ETB4Q-1; Tue,
 18 Mar 2025 06:39:39 -0400
X-MC-Unique: PKc4aKPzMguiU75Z_ETB4Q-1
X-Mimecast-MFC-AGG-ID: PKc4aKPzMguiU75Z_ETB4Q_1742294378
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07CCF180AF50;
	Tue, 18 Mar 2025 10:39:37 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.226.73])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 889CF1956094;
	Tue, 18 Mar 2025 10:39:32 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
Subject: [PATCH] can: fix missing decrement of j1939_proto.inuse_idx
Date: Tue, 18 Mar 2025 11:21:41 +0100
Message-ID: <09ce71f281b9e27d1e3d1104430bf3fceb8c7321.1742292636.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Like other protocols on top of AF_CAN family, also j1939_proto.inuse_idx
needs to be decremented on socket dismantle.

Fixes: 6bffe88452db ("can: add protocol counter for AF_CAN sockets")
Reported-by: Oliver Hartkopp <socketcan@hartkopp.net>
Closes: https://lore.kernel.org/linux-can/7e35b13f-bbc4-491e-9081-fb939e1b8df0@hartkopp.net/
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/can/j1939/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 17226b2341d0..6fefe7a68761 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -655,6 +655,7 @@ static int j1939_sk_release(struct socket *sock)
 	sock->sk = NULL;
 
 	release_sock(sk);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 	sock_put(sk);
 
 	return 0;
-- 
2.47.0


