Return-Path: <linux-can+bounces-2205-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6439D7513
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 16:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D32287CF6
	for <lists+linux-can@lfdr.de>; Sun, 24 Nov 2024 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A3D24002F;
	Sun, 24 Nov 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axuR68f4"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D374924002C;
	Sun, 24 Nov 2024 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456644; cv=none; b=NqKvo/3wPvcPqStJ+QzlrYaNsk8CHthakEsqQ+gOqtgDgzVMcsYrnFFQppSIa+sP3HzbsbbNOCwMMP+2uY9V0Kxy6rTgkDqWgoeTa77k6VBPCISxao5CXusxhklz1/+JbQ4EmvyVpXm8UgXyEA2I70BZwhLKG9IoCcZMEgkVUrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456644; c=relaxed/simple;
	bh=nXcFGeitzYT5m1nV1Uogt257741cT1pNjkWWqxUhDuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQ4jBMHRbdKFaYsgIZulQ1z8p738eSNpnpKRco92/0OKOxb+/qqZ1hDNsRhW/pDLbqcb3mQZARXAJBRU7qpRBFiB5MFQuV86rsWxLca7N0xvrkdVnArNpRzEx+abJtr8/DXTjpRNJ3AnrDtJvn6kBsV/Gg8lE8ub/ozs/EeY+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axuR68f4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5069BC4CED1;
	Sun, 24 Nov 2024 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456644;
	bh=nXcFGeitzYT5m1nV1Uogt257741cT1pNjkWWqxUhDuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=axuR68f4nfL7muN598/GYCadku7Z2RELsNl3eI8DoGT1c4PyEwesha/XJRDVIPBwB
	 RXNaazfcWCTmpzI2BTWURxkVWHnac7KqeJhs7x///bYmwXT6bg2zjq/afSmU20Oc5O
	 Tr1D2POpC/7kRLuS+uaDOkx8P8Cjr/ZtazE2jeeLDigtooIZchtTTHLxGz6qAKHZxH
	 Bb+j7H+b4jI1z91jHI2Nwt85N9AOn6phBnGVLdFIL+At9nRgF2MfJ0XFuXfWH0Ji4o
	 +bkqbVAbbaZ+c56MHcmTuBehFfoTokiqF1Sm0vWdihBE5Cn2U7a/rqiT1drKPyjCUZ
	 1hU9QWuHM49IQ==
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
Subject: [PATCH AUTOSEL 4.19 07/21] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Sun, 24 Nov 2024 08:56:40 -0500
Message-ID: <20241124135709.3351371-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135709.3351371-1-sashal@kernel.org>
References: <20241124135709.3351371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
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
index b3edb80921248..2e6fedffddd92 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -187,6 +187,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 		/* release sk on errors */
 		sock_orphan(sk);
 		sock_put(sk);
+		sock->sk = NULL;
 	}
 
  errout:
-- 
2.43.0


