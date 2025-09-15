Return-Path: <linux-can+bounces-4695-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D126DB574DA
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 11:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B968188C5AD
	for <lists+linux-can@lfdr.de>; Mon, 15 Sep 2025 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3ED2F60B3;
	Mon, 15 Sep 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghI5+AMT"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BFF2F532F;
	Mon, 15 Sep 2025 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928253; cv=none; b=VgSJquI+Z9bug79t3kIgG25mxVE7+cSq1ow7+ReAahkxQsBNir5vc0RoHdZOJrR2yLNvf4gbWWOfTBDdOpWge4PcQ7IinCwskSgg2+jukx7Z1VXC04kytpikejUXfCIFatlRAnj7TM6jIMHeBkcOientNDH83aBZCMLBXyxRuts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928253; c=relaxed/simple;
	bh=gm+woyX1D71Rz/dX+IbC3aBt0rZz/g3wLYE4eykaqrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1DmiplcP3lKqSH+mwlT3Qenq9tOH8veHyvH+e2CeKFAFVHSrDQYeCrUub/Kx+HzU/wi1qDhtp6+CthVP2FzdWMpTxZ5CoWW9fSR18fnUn/BASkTvrqT6sMdEFAuTtHQAapP5gcqT0RK2dEJPjdpRFPO93JcQHGkaSaJMurM2t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghI5+AMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E735C4CEF5;
	Mon, 15 Sep 2025 09:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757928252;
	bh=gm+woyX1D71Rz/dX+IbC3aBt0rZz/g3wLYE4eykaqrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ghI5+AMT63tI+DNjURhsoN9xbturA4qb9aH7BS7/KF6aRAGzCMNdFgaheAKgK4W0c
	 LlTF+0N4y3KCZLyFLL8UJkAa0APo8IgPjdKzU1vf4cFAnK6A+RYoQQYoSiVSMeo+P1
	 fWOskuzh6adYPpF37iN25dEV0F51d14Y4LhdmxBgOZ3pQbYYD1xHpb8W9r68Zz9w61
	 fpYb4VLMSfaQcB9FQml43BzoK7CuVU3mD9+xFimat/qQIZ9bJ1MY3LXddAK3hBuCPQ
	 cIr7xPjP0/lVs1U6bg76HLj6Bzl6gweiIXvDtotUg0oq1vJ4sRc8FB86ZYLklYQeB0
	 eV/rGRnpkPNBA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 15 Sep 2025 18:23:13 +0900
Subject: [PATCH 1/3] can: raw: reorder struct uniqframe's members to
 optimise packing
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-can-raw-repack-v1-1-5ea293bc6d33@kernel.org>
References: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
In-Reply-To: <20250915-can-raw-repack-v1-0-5ea293bc6d33@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=gm+woyX1D71Rz/dX+IbC3aBt0rZz/g3wLYE4eykaqrI=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnHbxukqhSwZXX+91z25/mRHdFHuxaWlweZHF1jnbYml
 7nj382VHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACai18/wv2LF2YlT2I6fNdmy
 89dFAYWXWxr5/0hcmLBXXkWyrXvarw6G/7XF3x0mdcw5oJV230rhqclUnijl1aE+128w1GpJ8Ew
 4yQoA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

struct uniqframe has one hole. Reorder the fields to save 8 bytes.

Statistics before:

  $ pahole --class_name=uniqframe net/can/raw.o
  struct uniqframe {
  	int                        skbcnt;               /*     0     4 */

  	/* XXX 4 bytes hole, try to pack */

  	const struct sk_buff  *    skb;                  /*     8     8 */
  	unsigned int               join_rx_count;        /*    16     4 */

  	/* size: 24, cachelines: 1, members: 3 */
  	/* sum members: 16, holes: 1, sum holes: 4 */
  	/* padding: 4 */
  	/* last cacheline: 24 bytes */
  };

...and after:

  $ pahole --class_name=uniqframe net/can/raw.o
  struct uniqframe {
  	const struct sk_buff  *    skb;                  /*     0     8 */
  	int                        skbcnt;               /*     8     4 */
  	unsigned int               join_rx_count;        /*    12     4 */

  	/* size: 16, cachelines: 1, members: 3 */
  	/* last cacheline: 16 bytes */
  };

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 net/can/raw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 76b867d21def209f5c6d236604c0e434a1c55a4d..db21d8a8c54d1b6a25a72c7a9d11d5c94f3187b5 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -75,8 +75,8 @@ MODULE_ALIAS("can-proto-1");
  */
 
 struct uniqframe {
-	int skbcnt;
 	const struct sk_buff *skb;
+	int skbcnt;
 	unsigned int join_rx_count;
 };
 

-- 
2.49.1


