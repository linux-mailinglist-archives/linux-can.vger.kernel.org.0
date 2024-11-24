Return-Path: <linux-can+bounces-2199-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B632B9D727A
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 15:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B56A28C745
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 14:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745FB1FBCA2;
	Sun, 24 Nov 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nphFBm1N"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496AD1FBCA1;
	Sun, 24 Nov 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455786; cv=none; b=lFLTPMGnPLmVrbtjuwL9n1o7vIYhyxgkg1Y3L5+ygps6CSv7bKBB6607E88Mg8g6fXk7MPYm5+wouEEiljs5Ex4izCopy5IR9OmFghp8f1oFOz2By/PELehhO/HDC8J4Sa9Qf/b3gwMzDd915EVOhIMyzCt1FfmFP9rOcEzBLzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455786; c=relaxed/simple;
	bh=RsnF6x4PMVetVGIzDAtIo4YAcOL9jwve7UP/EMgY8Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poMy/DmsJwu2sESOvyKgW7yBdvTgp4PsTtLRMk78QtHS1EDgSSh+hX/PVRsw+UzM6RN6blZZGxvbtbQyC5QqhmEZHwbe3HerCNBUFg084lnhm2wzNnUZ6FgSHKx/H33c3ku4apl50cvEiMaYbl/0Xqj5Dbay6whwvkPv3/00MMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nphFBm1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13171C4CECC;
	Sun, 24 Nov 2024 13:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455786;
	bh=RsnF6x4PMVetVGIzDAtIo4YAcOL9jwve7UP/EMgY8Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nphFBm1N7prQ/yZzzpdccoDuxujvbPVK6OogUtdLdSivoJRgCqXMTZSjWqfv6v9F3
	 XXMW6+QZEvyJTAxrDbr6XNnQedT3kGC2iwdyWSXRT/CH9UcHDPKrX5bf1ItWrd80vx
	 BUukMXy7Xl8B6zfHEohjtc7pit9ZrxpmAb39MaZh7d75q3kAsFjdAoiU/bGy5UTv7X
	 4xKrfihnkkKeZ9EB+8tcMgTyXOxr2O0cwPScCK0TgVt50oGkUqWks7KToWI5MGG3JS
	 XHxETvM4VZnSXpO0WMS3o028V2410Klv3FT6f84Qd12KlknDh+6YBrRMwpD2gDTvE+
	 gJ3zGviTL7wXg==
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
Subject: [PATCH AUTOSEL 6.11 35/87] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Sun, 24 Nov 2024 08:38:13 -0500
Message-ID: <20241124134102.3344326-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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


