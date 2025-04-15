Return-Path: <linux-can+bounces-3405-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5CBA89A5E
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 12:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878013B3C7A
	for <lists+linux-can@lfdr.de>; Tue, 15 Apr 2025 10:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E685D28A1DC;
	Tue, 15 Apr 2025 10:34:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF362820C4
	for <linux-can@vger.kernel.org>; Tue, 15 Apr 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713248; cv=none; b=bkV8ltbMOb7mkMZpE2VYQRpj+L38m/HrrJx1440kXNJ5enKiggU6EgoP0j3STp/G0F1IZ2GJlbzA6Dig6ZOhrEYtwphXLRxkhZFqYL4eRDQhViPOSB0cBt15u32Fc7zLaZdqf40U1EtrKmNKsHkSbjjMYrLPaaX/Cqztyoqi+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713248; c=relaxed/simple;
	bh=vSery/T+MOBdki3IionNkduP7a1BfYltZc+hDxghE6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHUybIz8zF70cIInAD0Hs5JhL7tIJeVdFeoJmEvZF2cJeVe06+uenJSYrnXJst/93jBOEU+JKTD3ZTZb8H5UaashIVZ0YvaxSvNBdTQN0zh+2/vEbyS1BqO7TfVBoY7yKyrd442JQ/auR6ii0g3X/9o2Q62UX4T5u/M7A7h/zSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4dcD-0006Pc-Lq
	for linux-can@vger.kernel.org; Tue, 15 Apr 2025 12:34:05 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1u4dcD-000P5L-1P
	for linux-can@vger.kernel.org;
	Tue, 15 Apr 2025 12:34:05 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 204413F9BE9
	for <linux-can@vger.kernel.org>; Tue, 15 Apr 2025 10:34:05 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 2B00F3F9BD4;
	Tue, 15 Apr 2025 10:34:03 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e3fe0462;
	Tue, 15 Apr 2025 10:34:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Davide Caratti <dcaratti@redhat.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/2] can: fix missing decrement of j1939_proto.inuse_idx
Date: Tue, 15 Apr 2025 12:31:44 +0200
Message-ID: <20250415103401.445981-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250415103401.445981-1-mkl@pengutronix.de>
References: <20250415103401.445981-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Davide Caratti <dcaratti@redhat.com>

Like other protocols on top of AF_CAN family, also j1939_proto.inuse_idx
needs to be decremented on socket dismantle.

Fixes: 6bffe88452db ("can: add protocol counter for AF_CAN sockets")
Reported-by: Oliver Hartkopp <socketcan@hartkopp.net>
Closes: https://lore.kernel.org/linux-can/7e35b13f-bbc4-491e-9081-fb939e1b8df0@hartkopp.net/
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/09ce71f281b9e27d1e3d1104430bf3fceb8c7321.1742292636.git.dcaratti@redhat.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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

base-commit: 65d91192aa66f05710cfddf6a14b5a25ee554dba
-- 
2.47.2



