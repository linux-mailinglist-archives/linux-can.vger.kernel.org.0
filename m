Return-Path: <linux-can+bounces-4400-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C55B3CBDA
	for <lists+linux-can@lfdr.de>; Sat, 30 Aug 2025 17:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C8937A5BCA
	for <lists+linux-can@lfdr.de>; Sat, 30 Aug 2025 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD8A2472A2;
	Sat, 30 Aug 2025 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je17TPWq"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2120E31C;
	Sat, 30 Aug 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756567294; cv=none; b=JwLMEtFzROQ3Lv7vuUUuaES/fXXnRNYCZMgDF5KMRPeHXD4phg4xRJzEvdPbeNM5fzj80MYwGDAJdlODfBEkd7b0MplOL25WZ/NlGEhQpmbxImbLFII2HjEtZxp7AAY8gcpL2RSwNse1oiwY+N10g+quR9txMlcprHRnaKRPcH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756567294; c=relaxed/simple;
	bh=g5UU/144ojBYlenHLpyrq4lo0+n4N2oxjJnhjUOnT1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lfiz5mEb+1ySQzKXBVltMlTWSGuVtROygjRaRD+bLxFlQKLt4vOmbGL7mkuK3duYvdU2o0wC7i3ZmV4e5MlD+73jUH+Y915D5MoynPM/NJg5JXrqaoTopuolH0v8Adycenk6sGytulkg/ylNcT5kqJJw0NxL58UFD89PNN7s6uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je17TPWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4A3C4CEEB;
	Sat, 30 Aug 2025 15:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756567292;
	bh=g5UU/144ojBYlenHLpyrq4lo0+n4N2oxjJnhjUOnT1s=;
	h=From:To:Cc:Subject:Date:From;
	b=je17TPWqonagwtBh0gavoxtB8xb03ELRc83YkQ6a2d9upcoA8VD1qnsFF2pROLrWI
	 YI7IQSrq00qXYIJIwAFe8KCGKr9Ns1Wd3KdbpSy0VVNyJTskSrc+sG39Y5ny/YJPgy
	 EbPINyCV1PJNldXsyU20IHhSBxYmKobMIc1Zw37CMep9LzVDkdWdrdYFpIBPQRjAGU
	 zTakTjJhflO8+VhjmnhYneATmf6rgfiuRXICXPrtl6RbRJqJbAxa6+UwJDbNXboXkp
	 In6d101pDJslTRTJaHuhr/0wQVZ1T5zzJtxZJRAdhs9R1W0RwnTE2YnfGU7SHJWcS2
	 i2XuP7vLp6Zcg==
From: Vincent Mailhol <mailhol@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH] can: dev: sort includes by alphabetical order
Date: Sun, 31 Aug 2025 00:20:17 +0900
Message-ID: <20250830152107.694201-2-mailhol@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=mailhol@kernel.org; h=from:subject; bh=g5UU/144ojBYlenHLpyrq4lo0+n4N2oxjJnhjUOnT1s=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmbxR7f+560bQFnkNr0aF+269f5ubvyfGYebNOaZbqEs 7TpTa1nRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIl8WMHwPyU00Ehrve6Ft1xH vk1PU3vfIrybW/HSzuX28iw7tm9hNWdkuMvx7eD7I8bX5/issl1RZcr1ySRw36eMTvdwzfgVrTP KOQE=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Includes are out of order in

  drivers/net/can/dev/dev.c

Sort them by alphabetical order.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
This patch used to be in my preparation series for CAN XL, but, after
some refactoring, is not needed any more. So this patch became an
orphan.

But instead of putting it in the trash can, it is still better to send
as a standalone. That will be one thing less that we will have to take
care about in the future.
---
 drivers/net/can/dev/dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 3913971125de..99b78cbb2252 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -4,17 +4,17 @@
  * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
  */
 
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/netdevice.h>
-#include <linux/if_arp.h>
-#include <linux/workqueue.h>
 #include <linux/can.h>
 #include <linux/can/can-ml.h>
 #include <linux/can/dev.h>
 #include <linux/can/skb.h>
 #include <linux/gpio/consumer.h>
+#include <linux/if_arp.h>
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
 #include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
 
 static void can_update_state_error_stats(struct net_device *dev,
 					 enum can_state new_state)
-- 
2.49.1


