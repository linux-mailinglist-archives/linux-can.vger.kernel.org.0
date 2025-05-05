Return-Path: <linux-can+bounces-3536-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA65AAA7FE
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 02:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6308164888
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 00:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230A129995F;
	Mon,  5 May 2025 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9jQTaxZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D929995B;
	Mon,  5 May 2025 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484716; cv=none; b=e+T9m/QP3DGfAMD6mHIbkV2m5FMR3YH0t8XfEgaQVZYni4I3TDJJlDprI6m6YTHmYGCu5/VpnxNKG6TEOu8Xm/S1Dfe63UVJD3y7gQJaCQk82rBy36lQx5NkXxW1VM3YYjkKfmryRbucaxBaTnT2K2Nkwq3Gw9zdjo+EyK+dJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484716; c=relaxed/simple;
	bh=xqpAfburR2RZ2pQeJrsoUdYNov4dnslFcguio5ycZWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=as6x6kPWzPJQvYUpz/OfmRNDQL61auBQ8uMCjNHll13mhWrWKjvOFy4xIvXPApKbqh2f/4C8W5bFaplul4zPz7FEXAkLsB3XB+HAGDou56Ff1NgQ/4ljUGTvRRQN+Vbf+8wdlHmPc4Id8ZwQZjGdwZ8mh7wpxk3bdeY+x+5UgGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9jQTaxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CABC4CEE4;
	Mon,  5 May 2025 22:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484715;
	bh=xqpAfburR2RZ2pQeJrsoUdYNov4dnslFcguio5ycZWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9jQTaxZPNj6rIlJhY8/WCz4ACLInNquTwKXOYslvHJO+2hQuFKgq0by73TQIB3Lv
	 xwgDjQ6wJJ4LcmmEeoLhS2+1oEy0JmfUtewnw2rncwqtG2nH3Hsr0QOr2b6KTDBOyd
	 MHmZFOZAdvyX1VEbQVt1Zrupb/uO+08NsZSOrFb1CFdluJO6B+2JQS8QI37NFnUMUP
	 rQG5e/gU6u6EOLHRD6I6bSiC6B9DrPrOiodY40YC/SyhEO+lQJoobu/26XhCgEzMLq
	 LgEw5Z5XKmnJagk5+FfO0KQk+sN5c4x4zJiI9NFak8Om6O0X6dGX73XUA1JkXcnZQA
	 Qcl6Hkaveq66w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Davide Caratti <dcaratti@redhat.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	robin@protonic.nl,
	linux-can@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 624/642] can: fix missing decrement of j1939_proto.inuse_idx
Date: Mon,  5 May 2025 18:14:00 -0400
Message-Id: <20250505221419.2672473-624-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 8b1879491472c145c58c3cbbaf0e05ea93ee5ddf ]

Like other protocols on top of AF_CAN family, also j1939_proto.inuse_idx
needs to be decremented on socket dismantle.

Fixes: 6bffe88452db ("can: add protocol counter for AF_CAN sockets")
Reported-by: Oliver Hartkopp <socketcan@hartkopp.net>
Closes: https://lore.kernel.org/linux-can/7e35b13f-bbc4-491e-9081-fb939e1b8df0@hartkopp.net/
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/09ce71f281b9e27d1e3d1104430bf3fceb8c7321.1742292636.git.dcaratti@redhat.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/j1939/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 17226b2341d03..6fefe7a687611 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -655,6 +655,7 @@ static int j1939_sk_release(struct socket *sock)
 	sock->sk = NULL;
 
 	release_sock(sk);
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 	sock_put(sk);
 
 	return 0;
-- 
2.39.5


