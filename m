Return-Path: <linux-can+bounces-1554-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C83984212
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 11:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62571C24430
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4057D156871;
	Tue, 24 Sep 2024 09:26:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332DF155CBF
	for <linux-can@vger.kernel.org>; Tue, 24 Sep 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169984; cv=none; b=g4mH8FvVr+dZ1CfzKl7jv8WoLmlYgQJ68im7peHXc6c/SWTLiIC1e2f29EHL6NPEThpyw6rFS1858KDzj5ACbRp27zYA6oFb8ZpAts09wRtkU3YtC2hhtrB7TZUv9+GQRgV5guSNp9a8x/1/9RgKf89mtcsNPWLE1y4K8xWdPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169984; c=relaxed/simple;
	bh=Rpiia7W171dhBiA2KDt3R+l32OjCdJgEQC5KzQ/YRWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ltxLDk2wbwZealyN9z5Wys/0vDhI3mlY0QWuxWIesuDJV4vWf0Z9rNQj3HwFXXLmXYyEf47a2tx8iGO+u9kNc1lEQPKv1F3RsOC/me2n8JcCCQom5AJCt18d0+QGkBlaU6XO8zOA/ClCebUONtDlV867UrfTDdcVHEO6KhvhC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
	by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4XCZ893Qbyz4x85r
	for <linux-can@vger.kernel.org>; Tue, 24 Sep 2024 11:20:09 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
	by laurent.telenet-ops.be with cmsmtp
	id G9Kw2D00J1C8whw019Kw7X; Tue, 24 Sep 2024 11:20:02 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st1dq-000ShT-KK;
	Tue, 24 Sep 2024 11:15:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st1du-0003Zv-Gj;
	Tue, 24 Sep 2024 11:15:34 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] can: CAN_ROCKCHIP_CANFD should depend on ARCH_ROCKCHIP
Date: Tue, 24 Sep 2024 11:15:31 +0200
Message-Id: <a4b3c8c1cca9515e67adac83af5ba1b1fab2fcbc.1727169288.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip CAN-FD controller is only present on Rockchip SoCs.  Hence
add a dependency on ARCH_ROCKCHIP, to prevent asking the user about this
driver when configuring a kernel without Rockchip platform support.

Fixes: ff60bfbaf67f219c ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/rockchip/Kconfig b/drivers/net/can/rockchip/Kconfig
index e029e2a3ca4b04df..fd8d9f5eeaa434ac 100644
--- a/drivers/net/can/rockchip/Kconfig
+++ b/drivers/net/can/rockchip/Kconfig
@@ -3,6 +3,7 @@
 config CAN_ROCKCHIP_CANFD
 	tristate "Rockchip CAN-FD controller"
 	depends on OF || COMPILE_TEST
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select CAN_RX_OFFLOAD
 	help
 	  Say Y here if you want to use CAN-FD controller found on
-- 
2.34.1


