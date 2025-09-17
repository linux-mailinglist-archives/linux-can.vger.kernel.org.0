Return-Path: <linux-can+bounces-4719-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61575B7C3FD
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED512A8429
	for <lists+linux-can@lfdr.de>; Wed, 17 Sep 2025 04:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B14262FD8;
	Wed, 17 Sep 2025 04:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rv/7f1w9"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9F2609D4;
	Wed, 17 Sep 2025 04:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084536; cv=none; b=RLK0w6gz5sjIu2iXafNzcnBKWMu0DyECjUWju+NrSFue/ev2f9xP/z+l1VxuVTPKeqKtCJWYw8gmaDa9HBowGfVBN2tnjrjk3qE202aNxipncpnwFC8xLwR0Blne0T209W/PDpRtyjD/UdBjdnsQ7zfscdLH7hv+xUGLhXWg+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084536; c=relaxed/simple;
	bh=uYbj8hTFtyXtNzgUkUNpzdgT2RSzDLC9LUc8bQgRZBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a43bTnbT6Heu3aGvyw31dbjzcTQQJ0c2CulhWIRuu+ZaV0NxsrXuKi7RKYrI+vHqlWTCq7ptVq2RfH/R9N8VQm4iAZiv9Xj6SetnxsXWvzrytfChAgiuNNIEJr1u4Mj0nON41FyZPm1BCL3sjkfIupmeb0C04yqDL5OwSMHBdJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rv/7f1w9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4105CC4CEF5;
	Wed, 17 Sep 2025 04:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758084536;
	bh=uYbj8hTFtyXtNzgUkUNpzdgT2RSzDLC9LUc8bQgRZBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rv/7f1w9zJFR7lca0t8VtMj/kgaxGo/1dGTPBQ8O659Xd2vSu8Kj1ouUcgLK68wo0
	 oazd3xRb7o6Zzz+qrZwtsuCQj/60M3YUr0SBRjJ3GiXA1DNjncg+HVRZvOhMvRFHuc
	 nbJNPN1zAkeRWtek87+Ubi1BDKsUL6wx+OQy6C57QXNaTMOzfxn73ezKbaHlViotwy
	 SeG6FztKexsI0fXTPnG7NWX5zWxt4Ri1fdvJM5NrwXifNGKqZScimHt5f4oPDi7gIE
	 FRjas/wHzX/ttqdV69Hne0givAtcA3CIJ/z0xQ6rGqBJJQSykyXWuEn27dakdh5JyF
	 A+Gq6V6PtR5IQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 17 Sep 2025 13:48:24 +0900
Subject: [PATCH v2 1/3] can: raw: reorder struct uniqframe's members to
 optimise packing
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-can-raw-repack-v2-1-395e8b3a4437@kernel.org>
References: <20250917-can-raw-repack-v2-0-395e8b3a4437@kernel.org>
In-Reply-To: <20250917-can-raw-repack-v2-0-395e8b3a4437@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=uYbj8hTFtyXtNzgUkUNpzdgT2RSzDLC9LUc8bQgRZBs=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmnbNf/idtj2Kj25o6S5/T/gXrrHwgeisrfUPPZP8fQy
 Sf0TYRbRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIkY3WJk2PJzlZ+g2dRCJsNJ
 pxWftr1kN+HgeNO9+9Uu9cgs6xgvdUaGR/vtskr1i9++NTAJ3/cs5OodC3mb7H9H0yzqlx298qO
 cCQA=
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

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
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


