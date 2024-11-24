Return-Path: <linux-can+bounces-2198-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE29D7236
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 15:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC7E0B2A2E2
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0DC1D5AA4;
	Sun, 24 Nov 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQICGlIq"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A6C1D5AA0;
	Sun, 24 Nov 2024 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455323; cv=none; b=agPQneL4EPRWo9TDluNqGfsBKkCP2yAO0oQliHgrrWCSWa1A2AHaAnhShrrPyV6Hg3KlHu8o8Re4VLf79/XysoYpIWJHjbu6ccstkTYgE6KasosEz/4eZrU0G+g1+xicxB/s6eIwlu7MM/OY34PQs3Dw9qqEN5P3EzkFFzMTwCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455323; c=relaxed/simple;
	bh=RsnF6x4PMVetVGIzDAtIo4YAcOL9jwve7UP/EMgY8Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6MYE+Rwzd58LwGgFup2qPkTizvzCO9hWJcpv4G8fWr5/C9xCF1JnWQ5kOciKlDglxDzu0JnLtHIFeoyRO2MgfNjVn4yDOVYeqwFEIDYZcWhwuPPQsZS+stk/Q1mj5n819DFCGCHeesgx684c7n7P5j9GCpJetjiFB7dAY+9xGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQICGlIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F9BC4CECC;
	Sun, 24 Nov 2024 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455322;
	bh=RsnF6x4PMVetVGIzDAtIo4YAcOL9jwve7UP/EMgY8Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQICGlIqrSuI2ipPqsggDz+42OxCvxeU9JWC60Xy0akMozx6T4ZcAS3+1e9IMZdvw
	 /znxiKfFV2e3R/I9JkaHxouNy2VtGeCYFTloNEKIlR+U/w8ESAvV5RuzeVVw9E2Dlg
	 sTaKQSYK8DHMHcojRJ1Mlq3a8s66Cf4fvzO4daaH9sGSD5xZz3hj6cIX0qoXMFwPtr
	 KAlBTOcFeoT+qJnfzxKak65wbqaM3z0WH+plL1ZNdOy/7e48ypNRbjvsbzayWSN4nl
	 GbNyeAlh5V1QZajjRPU0LR7cmSWTSNUz5M5vs/6Qys7c9YPW1Y53qwtdqB5VNiVHEt
	 3cYoEh5kaFpqA==
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
Subject: [PATCH AUTOSEL 6.12 041/107] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Sun, 24 Nov 2024 08:29:01 -0500
Message-ID: <20241124133301.3341829-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 707576eeeb582..01f3fbb3b67dc 100644
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


