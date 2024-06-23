Return-Path: <linux-can+bounces-848-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6510913EA8
	for <lists+linux-can@lfdr.de>; Sun, 23 Jun 2024 23:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F291C20C5F
	for <lists+linux-can@lfdr.de>; Sun, 23 Jun 2024 21:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078911850A3;
	Sun, 23 Jun 2024 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UBh1C89c"
X-Original-To: linux-can@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-215.smtpout.orange.fr [193.252.23.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B22184106;
	Sun, 23 Jun 2024 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719179993; cv=none; b=iJAEjY1n6zYjgEd9KzN02kNyT9F3boIMWWOgzesBpoD/RAU1USskyceYBZYtkSxPi0aXeIOLNdA76h/NmTBcS5pU0oRCIl4a6Qxo2UOxBC59lHVS1ODcAjiqTZxi985fZMVl3SGY21eI4w/rl7simD52xyYR+vMCEet3BHVbAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719179993; c=relaxed/simple;
	bh=v5DO2TAftI73ww3uvdwE1NNig1frErR46ykjHVHR9AA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kNHnBpH3STogmmA9TW+MJFn+oBuwKCVfjjBSdqOemNscGb4fScI62DNAfbC+r2IWKVidltkxyc1Q4rc3796Kc5r6rqBvnRboAJ/Ix4fwRkbzmrpotHyMGx6+ypPe3RJWXNwMndotPnVJwNlWA9AtDl1wbWmLplpGaLdjnMobmLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UBh1C89c; arc=none smtp.client-ip=193.252.23.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id LTPSshmixRlahLTPSsC1Ba; Sun, 23 Jun 2024 22:02:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719172922;
	bh=ynHaVTacZiZSj/BhHnX4o1QTUyOa26DsYCafYGhsZE4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UBh1C89cSr13phxYPzXWS+0Ot+tiBxc+1D//5F9pDWUKU2erMXrOPuko/W6Qql2p3
	 NOEoiOx5NdJ+mbGA6/42sOApPf+zKqcDN0K7NQ39kxvDPl7K7l4PGvijUqZbOfVyFC
	 KKaRz9AeelJuqJsy6aNMo8hhly+Cr9lUDv0sOKO8HZ/DO1ekbTEs5zFKU9AB8FgxrB
	 QGZ1Pj6p42rme96nG/H/b5LnRBwpfK7dZBGonlmU4/uICqSQMtMXME71fuI4ZUlaCM
	 LqKcZm1AWPxFcqsIEX7iAYoyXqwzCnz/s6iQ6DofijotncrfiMrOqhhCTy6J76jQs2
	 4U1wjig3mvGfg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 23 Jun 2024 22:02:02 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] can: m_can: Constify struct m_can_ops
Date: Sun, 23 Jun 2024 22:01:50 +0200
Message-ID: <a17b96d1be5341c11f263e1e45c9de1cb754e416.1719172843.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct m_can_ops' is not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   4806	    520	      0	   5326	   14ce	drivers/net/can/m_can/m_can_pci.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   4862	    464	      0	   5326	   14ce	drivers/net/can/m_can/m_can_pci.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/net/can/m_can/m_can.h          | 2 +-
 drivers/net/can/m_can/m_can_pci.c      | 2 +-
 drivers/net/can/m_can/m_can_platform.c | 2 +-
 drivers/net/can/m_can/tcan4x5x-core.c  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 3a9edc292593..92b2bd8628e6 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -91,7 +91,7 @@ struct m_can_classdev {
 
 	ktime_t irq_timer_wait;
 
-	struct m_can_ops *ops;
+	const struct m_can_ops *ops;
 
 	int version;
 	u32 irqstatus;
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index 45400de4163d..d72fe771dfc7 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -77,7 +77,7 @@ static int iomap_write_fifo(struct m_can_classdev *cdev, int offset,
 	return 0;
 }
 
-static struct m_can_ops m_can_pci_ops = {
+static const struct m_can_ops m_can_pci_ops = {
 	.read_reg = iomap_read_reg,
 	.write_reg = iomap_write_reg,
 	.write_fifo = iomap_write_fifo,
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index df0367124b4c..983ab80260dd 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -68,7 +68,7 @@ static int iomap_write_fifo(struct m_can_classdev *cdev, int offset,
 	return 0;
 }
 
-static struct m_can_ops m_can_plat_ops = {
+static const struct m_can_ops m_can_plat_ops = {
 	.read_reg = iomap_read_reg,
 	.write_reg = iomap_write_reg,
 	.write_fifo = iomap_write_fifo,
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index a42600dac70d..f15619d31065 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -357,7 +357,7 @@ static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
 	return 0;
 }
 
-static struct m_can_ops tcan4x5x_ops = {
+static const struct m_can_ops tcan4x5x_ops = {
 	.init = tcan4x5x_init,
 	.read_reg = tcan4x5x_read_reg,
 	.write_reg = tcan4x5x_write_reg,
-- 
2.45.2


