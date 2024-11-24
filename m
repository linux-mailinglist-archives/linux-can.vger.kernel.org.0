Return-Path: <linux-can+bounces-2202-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CDD9D7564
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 16:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C3BC22BEA
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FEC23BFC0;
	Sun, 24 Nov 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2zr/kB8"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E923BFBC;
	Sun, 24 Nov 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456363; cv=none; b=gcHK/IwDJgybOBCG4ifZTvdfdKtVPJR/F6lKfWEmQ3lv4gAG7X9y/3xa6KNpD77n/atdXh6qok4wmPYR08o4bjj+0qMVjMS+Db1gOhUP2T/YH011fFMritC1O/J41b5brMTfaqgSZW+xjED8MIKLSk6+XED5mk9yA64XAY6Xlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456363; c=relaxed/simple;
	bh=YyXQYZt6mzbq5ylvSj/AxWvvGOXj52BZziu6aIbpytY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHs88/aKX8bvGsEBlC0W48LXyuBX2QJ0zJfNWswsOhHsQbeZoXmfamfkAPMTwiJ5RwSYvBEdxecl4yz10oNim5OrD++C9P4SjGgglgd8I+s0HiZTZTVp5DuGanzwVIJvY3ZXpQRVUy9kbG/MEa199JJLFVCfnfU0WZChWbDOK6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2zr/kB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F77FC4CECC;
	Sun, 24 Nov 2024 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456362;
	bh=YyXQYZt6mzbq5ylvSj/AxWvvGOXj52BZziu6aIbpytY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j2zr/kB8pgaqkDKKfY5pNrR82rHgVfvGoQjX/VeuUF5hAdEN2R3wt2N6YWVh6NMx4
	 s+7VF396ffLWeKGn1+mPQbOVR8wMF6XZID+Pxbx42lohD3e0K1iYOlU6Y5nKCHOhNb
	 dhwyyaKaFV+Gv+fv8517nl1MFATllEcDvK0sYA6apyQCftumMuL8s89z/WXgG/5I43
	 Hn+vLOIOo/qshZBBkWy2UPkY8pGIyP+F/LnYTZf4GGyPj+BrZta3SqEsYIT4Xf45MI
	 4AhOj27eIW4RX21MX/78/MoDNWPhVKKfr4UxfFr7PdONlOowtZUbgY5L4VrIG7YhWb
	 8N5yIFgYt+Fvg==
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
Subject: [PATCH AUTOSEL 5.15 12/36] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Sun, 24 Nov 2024 08:51:26 -0500
Message-ID: <20241124135219.3349183-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index 20d2dcb7c97ae..4e728b3da40b3 100644
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


