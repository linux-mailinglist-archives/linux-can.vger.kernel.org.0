Return-Path: <linux-can+bounces-1043-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F6B93F646
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 15:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F55DB23520
	for <lists+linux-can@lfdr.de>; Mon, 29 Jul 2024 13:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1757315697B;
	Mon, 29 Jul 2024 13:07:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A69156F30
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258428; cv=none; b=Zqu/yQIvzIT8SxjKgiAxqfh6ZdV5Dy4PjwnYOTEK691hbRONMdHzJ7Ud87A1BQme6QWoRXKW1hvbsA+3qu6Ve1C3QGEgiuLOkJqmxtl0TgDG5avKRHqWeHh/Zvg2/73QfxcEh8mGLwLf4iEA9XjDhkDvU1zNHS+fOvhwfWiU/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258428; c=relaxed/simple;
	bh=Hdngpw8CwFryUxkp1A2LVjdUgbMRjfZVxon6tGzbtPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D21iGgA0BGjPXHPkmLI1AiU+SmxKsQM6jqOvRxg0HOEFO6hzZrkvb2zr+nelfsew7BS64hHJB/JNNsm/K8z1v5IeKPLZlLna4PFtuhvNxy5poRd/eI/fXqwlvRG379jAtFReLf0Jb+4/cG/Kq3vUkgj3gpaLH+7i/LK/dKdcDto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5g-0000Oc-Iq
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:04 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sYQ5f-00334R-NT
	for linux-can@vger.kernel.org; Mon, 29 Jul 2024 15:07:03 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 68D66310E15
	for <linux-can@vger.kernel.org>; Mon, 29 Jul 2024 13:07:03 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E4644310D9B;
	Mon, 29 Jul 2024 13:06:51 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 57c693f5;
	Mon, 29 Jul 2024 13:06:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 29 Jul 2024 15:05:39 +0200
Subject: [PATCH can-next 08/21] can: rockchip_canfd: add notes about known
 issues
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-rockchip-canfd-v1-8-fa1250fd6be3@pengutronix.de>
References: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
In-Reply-To: <20240729-rockchip-canfd-v1-0-fa1250fd6be3@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Hdngpw8CwFryUxkp1A2LVjdUgbMRjfZVxon6tGzbtPc=;
 b=owGbwMvMwMWoYbHIrkp3Tz7jabUkhrTlkw+cbNztw3N49nPf+wVXfEKnfTFKfdnm4ll1+ln//
 wpFLXaLTkZjFgZGLgZZMUWWAIddbQ+2sdzV3GMXDzOIlQlkCgMXpwBM5N019t9sObUvGvz6ZM4s
 k3/1uqLzkXOXCaONv/Yazkitu/dWJ37u2397m/UJS9aWW7eEjy+0MjY+Fq87JU27OEA/x674/AN
 /8dzzRsphYhYzG1PZ5JqXb9ha1f71Eo+bwbzKCbV7rVxnMHPV3FJNUD74UKTFvO+X+Pac2fluLm
 XcRns8+w7tMpKxeKd4tmWlTOcG4/eZek1X+F5zGx29+VxVXjt1u9/unD8eGU/VXeymKj/wmOgoL
 xcUdXxdxZu5N7STiz6J66a9mKDT7Nxt5nvo6Zc0+Ul1lz+o3taMkj++bXrensCMfao8B6yE/98W
 kdHL3Pbr7jS5p71c+4vb2l0fcuRMe+CmWBP9pM/WRVsWAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Even the rk3568v3 has some known issues. Document them together with a
reproducer.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index c008953ccfc8..b5ad8633a8a6 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -369,6 +369,26 @@
  */
 #define RKCANFD_QUIRK_CANFD_BROKEN BIT(12)
 
+/* known issues with rk3568v3:
+ *
+ * - Overload situation during high bus load
+ *   To reproduce:
+ *   host:
+ *     # add a 2nd CAN adapter to the CAN bus
+ *     cangen can0 -I 1 -Li -Di -p10 -g 0.3
+ *     cansequence -rve
+ *   DUT:
+ *     cangen can0 -I2 -L1 -Di -p10 -c10 -g 1 -e
+ *     cansequence -rv -i 1
+ *
+ * - TX starvation after repeated Bus-Off
+ *   To reproduce:
+ *   host:
+ *     sleep 3 && cangen can0 -I2 -Li -Di -p10 -g 0.0
+ *   DUT:
+ *     cangen can0 -I2 -Li -Di -p10 -g 0.05
+ */
+
 enum rkcanfd_model {
 	RKCANFD_MODEL_RK3568V2 = 0x35682,
 	RKCANFD_MODEL_RK3568V3 = 0x35683,

-- 
2.43.0



