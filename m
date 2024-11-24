Return-Path: <linux-can+bounces-2203-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B028F9D748C
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 16:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515311673A0
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88F02429FA;
	Sun, 24 Nov 2024 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScuGeRtr"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6B22429F2;
	Sun, 24 Nov 2024 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456473; cv=none; b=f8pfODBiZ86awIaUhLUeowsWVpTM3pILs4/eEDWNR7w+xMvg3NXBYcrpBdFEmZOI64E0ODv6IXqrqPqF2dPSAPPYZuKQm51ArB6zAuqIZLeLpPFoTKB2Zy+QRS7TPA+nBcVLM90+d6jbHVsv46p7G9+Jk8hQ0GdvATDf5BTbN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456473; c=relaxed/simple;
	bh=FdEuquO+BMJ7NLsyf8rIrSzWWVSJsKTgjOe5gfM1TU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qi48Cv2x6GC1ryzQVB75Til4szA9nDP/K8W4dFMdN/LRkQWydeK04SyHQYQGwCO13gOl16e7JxpcvyzEF17HFP2fgXempL3RPiImjJnwGLsavN0eUwm1ngj9CBs5bswuBVVYxYm+46/RNDEnseDm3TejV0WTrS/KkUlwsHuis0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScuGeRtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CBAC4CECC;
	Sun, 24 Nov 2024 13:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456473;
	bh=FdEuquO+BMJ7NLsyf8rIrSzWWVSJsKTgjOe5gfM1TU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ScuGeRtrNiRLZoFkeyWfjmwWZsZbHXY1jnTOojUVISjA3kwa2jFibtoNeSp9S2Hlu
	 8X2FThyr9uqb4MvaeFWt0cuEX6cfIighPlsQiM5slFOICYMtIByK1mBb/BzY8IrdAw
	 NJcWaZoM/XIgRB1sBkc4Su8FsHV1FMqIOaTeTkJnqyZfTJScNkQOpfolpHm8WcDleh
	 phSspBta+gxa0Bn/DUeqpKuv4zwpWRm+xsHDuMUS5p/im3fEy3JfGkBqyzOzVwpdIw
	 O4bl8fFwTAG9tuLXgXdFDghOg1xJYiokUck6Lt8scBt4ZGEYY/ygi8Ogb+30GjbyZ1
	 DB0qeJUe3hEFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ignat Korchagin <ignat@cloudflare.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	socketcan@hartkopp.net,
	linux-can@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 12/33] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Sun, 24 Nov 2024 08:53:24 -0500
Message-ID: <20241124135410.3349976-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135410.3349976-1-sashal@kernel.org>
References: <20241124135410.3349976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Ignat Korchagin <ignat@cloudflare.com>

[ Upstream commit 811a7ca7320c062e15d0f5b171fe6ad8592d1434 ]

On error can_create() frees the allocated sk object, but sock_init_data()
has already attached it to the provided sock object. This will leave a
dangling sk pointer in the sock object and may cause use-after-free later.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://patch.msgid.link/20241014153808.51894-5-ignat@cloudflare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/can/af_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 79f24c6f43c8c..de47c16b134bf 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -171,6 +171,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 		/* release sk on errors */
 		sock_orphan(sk);
 		sock_put(sk);
+		sock->sk = NULL;
 	}
 
  errout:
-- 
2.43.0


