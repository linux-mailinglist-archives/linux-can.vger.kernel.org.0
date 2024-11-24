Return-Path: <linux-can+bounces-2204-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5197D9D74D0
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 16:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD95168135
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 15:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB98A24835F;
	Sun, 24 Nov 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plHJ8VHL"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCA24835D;
	Sun, 24 Nov 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456569; cv=none; b=OYx9fog4UKyf/GCtThLXCqG1uJzVL2aP/ETZeRwloC+ohB31FWL5drp44f6yBsNvoM3Xc6Lru1pyTMWj55B66eCWfPySZhDYNzd91MWp3h9JCgWbSdEcx02b8+esNIDsPwx8ip/kwNrHIG5/rNzpNNh7U1H+oAAsfFblRU86aj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456569; c=relaxed/simple;
	bh=+HqknN0c1m9ygXQTx0fENNqmE1KpkeEwBt01jGR93E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUHRIJDfOMhrMOGxdlu0tDIm9yYun3eybwJUsCo5dHrog3kP56wd99NjKW2NwrMimR1Oo9fFiPclbq2Ar/kdWpX28ceyGXF5UIszQpHCcakSiLVuHXbMSKluFISjlz9HarzijOJwUYOC2GAVwwP8p53gDqifxAU9fjXfzMWQ1JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plHJ8VHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA34C4CED7;
	Sun, 24 Nov 2024 13:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456569;
	bh=+HqknN0c1m9ygXQTx0fENNqmE1KpkeEwBt01jGR93E8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plHJ8VHLvbv7e8J1aduAjM3tx2V84rjDdzdaflFORG5vD+hMlwf6gfstbk7mKszvv
	 wIspEgfzqpyIxC/waDtxGNesanyuXJIMF/8gquApy/Xkof0wZ+VyJgixRh7fY8OCOQ
	 Vri88ylPLqSWldAOvGLqOt9Ye7a0viBRpvC/ISkB9rHMwxlDuHd2+UKDVE1J78QqmT
	 L3qVMv/V0cHz3bNhPik2Kug4yutD0evV9KtF5oqmoDyf+S9rW5wsUy0z1HX/Z46KK9
	 WE+5PFABDrHfYXtTmoOZDDWA/oZaRSpCqEVV+jiRsHj1FCXObH6Osx5P1Oq1qyRBMR
	 171WO20GvPAqg==
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
Subject: [PATCH AUTOSEL 5.4 10/28] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Sun, 24 Nov 2024 08:55:10 -0500
Message-ID: <20241124135549.3350700-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index b396c23561d63..bc06016a4fe90 100644
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


