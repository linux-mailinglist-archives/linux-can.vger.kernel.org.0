Return-Path: <linux-can+bounces-2200-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E6E9D7360
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 15:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E812853B5
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 14:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DA92274C7;
	Sun, 24 Nov 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRZdaEQA"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC452274C3;
	Sun, 24 Nov 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456055; cv=none; b=Eyr4SVZ14l3RvTzJewtls7lR3yiooDzzHrtwKLUOrDMeW6GxcxxZic4eQaFBZ3TXy4ZDWubW/P2yT72QQ9WhRpMHzl3/IRj6mGwZ9rjREbA22tZOvDG+CT2acFzEhi28X80qG9k01M+IvUgXJF1u8UlCXFuuTr/IBHg1dbv0kCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456055; c=relaxed/simple;
	bh=wgwVZQRIjTYsMf71E6wLgDyZTy9/67gNwHZQjJVqSAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkWOV7+N0ZUmZR7PS7EBu09vYjbbRMK2SIZh1iasFITKdk6Z+U9KHYopNR0DE5kuR4Y5wil6S92Bs1y8cilQoWtmhOnj0nAquCuUQJ2eyjKdl4pD85FLWwBZOV8WUQxL11iLCvgawbeNkJf0VdMhP8JUmP2n+3FoLsOR0fonUaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRZdaEQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA173C4CED1;
	Sun, 24 Nov 2024 13:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456054;
	bh=wgwVZQRIjTYsMf71E6wLgDyZTy9/67gNwHZQjJVqSAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FRZdaEQAputqWbITKoPCY5K6W57Y/JR06XkG2qI6nnlFKPWzeTuHvY5+y3t7cMNL5
	 ej8qt6YKLU8S5scB/8+xbFTmXWCJw/28axHuNtnmtVGKI0bzKr8vNnPuTlMEHp2Fav
	 hsvnh3155KAmncMShNPF6lwaxn2F4HOEcLmoMi37+fOR0iZ+i8UEuqRtooA0MqXnMY
	 V8g+aoD5BJfignDqS6VSmbXrXgQ6J8KVMRgo8/KnwDqXxaW/zR9Ilnwcw+RLNSiUsk
	 aAn9bIAzuVMwBVdblHf3Gqt7ut5VF2k4Vy6IHrNdfJy1fKHChz885hXWoXC3a0X30v
	 GMYPMPNSjLTig==
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
Subject: [PATCH AUTOSEL 6.6 22/61] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Sun, 24 Nov 2024 08:44:57 -0500
Message-ID: <20241124134637.3346391-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 7343fd487dbea..c469fc187f0c7 100644
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


