Return-Path: <linux-can+bounces-4432-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BF0B41931
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3931A88385
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC482F28F8;
	Wed,  3 Sep 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMyvp5yV"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB02F28F4;
	Wed,  3 Sep 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889531; cv=none; b=URN3+Hp16c6mYCGNB0SGm4atbB5ZSRYi1WnMCBQYjhbbWtiess/lJoASohaHPMQKvHayK0iCEiSgaZoTLLKAl8kGZEmLcsuTHxAHKQqXYj2hNVIfMq8/NS51PFllBF41SMRJPdFRwibbTLyV2qu63Q+de3XyN4H/RRRnZKkQfRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889531; c=relaxed/simple;
	bh=vPnP+LzDwFe1AgRH6UfhBv6JEs+VwpyKFj0I1pIxwWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LWdqgMn4799/wDXCyTCiT1fvrxEo8ITEKwtldpQ5EW3tjWhF68Y/ATabWKDinEwiGbeO+1/E7xqhLQejUUQmyCE3MA8wpEQbF69OlQoec5lCmEpEo20gFLp4NpqrXttL2Jj3AJTDlOSDSi7FsWdODfiYK3Yn/FAVuAQaKhDbE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMyvp5yV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8EFC4CEF8;
	Wed,  3 Sep 2025 08:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889530;
	bh=vPnP+LzDwFe1AgRH6UfhBv6JEs+VwpyKFj0I1pIxwWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hMyvp5yV6wDpq6RkWm+ahnGLG0aKExxQN8CqLwZJRapvKgPdQtZPhW5D0C9i3OJg5
	 0tRQq6CUqrZSKtQd/s//pEFmwVNXhqdtOWI+yAUSkIaDo6uT/sLAjkETe4FftI3Y6A
	 wEW/YdNu/Imry1FXkamOJOL0Rs1UsEF66KRCX+Tt7SxNbYBigBpgGb4iVmZxgeDMja
	 qstDxLbcXc1eGt0JfsOUl0J2oLGpA19X/nJuj822P0KDd5ghx4MGOuk5KcKYXfK1QZ
	 xQP+nG3ITC6Ga+8tCnMGaT8Do5WLBtgUv3HADJghMhUm7UaBckMHYhOAxRUspTc+T5
	 2kDOQwPcneDSw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:06 +0900
Subject: [PATCH 07/21] can: netlink: remove comment in can_validate()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-7-904bd6037cd9@kernel.org>
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
In-Reply-To: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=vPnP+LzDwFe1AgRH6UfhBv6JEs+VwpyKFj0I1pIxwWc=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GFvubsrb+e9zXqb0o4tpC2oa+bcUd5wQ5lm80u3Hx
 XNR6pq+HaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACay8Bcjw7EtnOaK3Yyas2VP
 ahwsz7BWWtpUq3/l5y3PohUV3m6O/Qz/VPuZl01naPzNdFCV/2P6a6NPx5+Vt++YOFNsXZGC7kI
 WHgA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The comment in can_validate() is just paraphrasing the code. When
adding CAN XL, updating this comment would add some overhead work for
no clear benefit.

Now that the function has been refactored and split into smaller
pieces, let the code speak for itself. Remove the comment.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index f7b12057bc9c6c286aa0c4341d565a497254296d..6ea629331d20483c5e70567eb1be226a3b09882c 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -143,13 +143,6 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	u32 flags = 0;
 	int err;
 
-	/* Make sure that valid CAN FD configurations always consist of
-	 * - nominal/arbitration bittiming
-	 * - data bittiming
-	 * - control mode with CAN_CTRLMODE_FD set
-	 * - TDC parameters are coherent (details below)
-	 */
-
 	if (!data)
 		return 0;
 

-- 
2.49.1


