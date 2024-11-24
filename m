Return-Path: <linux-can+bounces-2201-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DD79D7727
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 19:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7B61C04EF9
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 14:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036FE1F80FA;
	Sun, 24 Nov 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfuYTyXZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B81F80F6;
	Sun, 24 Nov 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456227; cv=none; b=JT6bwvKOP4Kb1SiQhoCPHZqMfF6x/n5pjfBFxWGJCLTuHugaESTbPOFt47BoNo/mKxz0y2GgBlyfKnCMyYJj8XyaHSmakQzIXIApu5g9AKY6aawCI6KKT9EUVfc8GPY9CvhmRvAuNKpsMtUSQNgJN6ZQzP4/Ooo5+LyEgC0afQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456227; c=relaxed/simple;
	bh=7TKE83EbFR0EOqzF0Q9MNQnyd/fQ0b8Ks//D1/4rEF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isjA18ao4N2nVknXQ+rIqOQJn1d0l/08LSY4ex7MII9BSNm+vnifRqJSUyXgbcCJIlN+TdfMULWS3tekbNHco+6OFP8l5HYLzrKPr9zweQFjs+Z2cae0AYQ+thrprTUmJg+FGEE9PyReBacPJ902EKL8KCy6C7rxYTJtHRi4UzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfuYTyXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A972C4CECC;
	Sun, 24 Nov 2024 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456227;
	bh=7TKE83EbFR0EOqzF0Q9MNQnyd/fQ0b8Ks//D1/4rEF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BfuYTyXZQSr751uBTHf2uBPsEILCJHAn+HJAcqRI963+SWhX1REwAx43O8NsIhHGA
	 k46SyvUFXBslIlXpwovd9aXgGEXXXUveD+c4I1gGNPhSZmi5WUPAGI2ADolO7b4fIK
	 GzGih9LfC4kVMouRb3F2meHR+qCORfuiGwnCMwbCa/uxK8y4m6edVrpLaJUu+DcF1g
	 GWu0ZiyFtVT84usx1oFXsLEuSZcCUcgoMFruxOhm0Qp0k5XR1wycotz9MnBVx+2rMb
	 8PFUGJSOML3T2NZcDWS4PsUR7wnyDhlrV/r4Gg+msS9ykazU4DdN3qx0gDHmlQszzx
	 9EeitdaUW0q+A==
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
Subject: [PATCH AUTOSEL 6.1 18/48] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Sun, 24 Nov 2024 08:48:41 -0500
Message-ID: <20241124134950.3348099-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index c69168f11e44a..7d8543e877b44 100644
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


