Return-Path: <linux-can+bounces-1352-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BE996B443
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 10:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42751F279F9
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 08:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A009197549;
	Wed,  4 Sep 2024 08:13:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3EC194138
	for <linux-can@vger.kernel.org>; Wed,  4 Sep 2024 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725437633; cv=none; b=JSD2pb74kgmeWXyl9ohiY4AxBVewrC6YE2wXiP6K2PFkLXg5NppiaSI+fdRvduGMXaalqkMmt6WvW59EsudkseabTH6Y8Hlsk5p+4RKb5Xj7PrWHYIRNIgtBTETiAFbhcJnuqxAgCDYxBNLHl5+3qPK2cfEpMIiVA7FoWWpYJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725437633; c=relaxed/simple;
	bh=Rb+DPh6I1pIZR5OwMWvyyqc8QfjnlVzZzpFMC3B2FWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aa7SjMael5nZhudp0swNI+pq/e4f/vQORTRW2RTHmNTm7bxXn+MJNj+Dj8RZkGPe5TDQ2y35POHMKja29hV+x0vNY2S5e+CQBHnrA4lOTTFPEvwN8NhyVT39uOgWp/F83qeWtWGa9ZO/AKFX8n3BltVf6SFQWdDXgQqOUe3BN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll9B-00081Q-LF
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 10:13:49 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sll95-005P89-O7
	for linux-can@vger.kernel.org; Wed, 04 Sep 2024 10:13:43 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 67DDD332140
	for <linux-can@vger.kernel.org>; Wed, 04 Sep 2024 08:13:43 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id AAAFB331F80;
	Wed, 04 Sep 2024 08:13:23 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e6ea4fa5;
	Wed, 4 Sep 2024 08:13:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 04 Sep 2024 10:13:01 +0200
Subject: [PATCH can-next v5 17/20] can: rockchip_canfd: enable full TX-FIFO
 depth of 2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-rockchip-canfd-v5-17-8ae22bcb27cc@pengutronix.de>
References: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
In-Reply-To: <20240904-rockchip-canfd-v5-0-8ae22bcb27cc@pengutronix.de>
To: kernel@pengutronix.de, Alibek Omarov <a1ba.omarov@gmail.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 David Jander <david.jander@protonic.nl>
Cc: Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Rb+DPh6I1pIZR5OwMWvyyqc8QfjnlVzZzpFMC3B2FWI=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm2Baa9Yf0fCxin2ZXtp3E0KOMrjKP17dCPUqD7
 RxC4kNYcE2JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZtgWmgAKCRAoOKI+ei28
 bypHCACGvzXBm5xaLbC+jTRhI7Bitk+lQObU8e+CZ1jAQRr+XrC7qHXZnbPFKyo9FVpXpJ/VLQD
 5nBjeDwQGROij0e8xIwXePnKZwoz7+ZszhJOZ5+keqYTzFq4XRfHDLGKD74xlP/9pjSqH53oRg0
 wR/gJaxkaIYpvQuZqZB3NkteuLV+6rpJga5X5hb3/Z8Jg4Zxu+6fJ4iCd8KI5BuoNcuI8vq4FrI
 DM4aCwPBANArneaHJ4zefOQdBi7Z8loxhmH7ooMa0GsH0iiP7ITuwP2v8M1hEpgXfIXBaIpsrVX
 2ZFyv+Fl0ovCMr9Tt9rP8cIFfihc1aWRsioXRHz1GnBMumau
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

The previous commit prepared the TX path to make use of the full
TX-FIFO depth as much as possible. Increase the available TX-FIFO
depth to the hardware maximum of 2.

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 37d90400429f..6be2865ec95a 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -288,7 +288,7 @@
 
 #define DEVICE_NAME "rockchip_canfd"
 #define RKCANFD_NAPI_WEIGHT 32
-#define RKCANFD_TXFIFO_DEPTH 1
+#define RKCANFD_TXFIFO_DEPTH 2
 #define RKCANFD_TX_STOP_THRESHOLD 1
 #define RKCANFD_TX_START_THRESHOLD 1
 

-- 
2.45.2



