Return-Path: <linux-can+bounces-1426-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F306496FCA6
	for <lists+linux-can@lfdr.de>; Fri,  6 Sep 2024 22:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1431281F89
	for <lists+linux-can@lfdr.de>; Fri,  6 Sep 2024 20:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059ED1D363B;
	Fri,  6 Sep 2024 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q29skeIB"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BE13B584;
	Fri,  6 Sep 2024 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654408; cv=none; b=A5yT2x0eKcbdrsG1F8JH0v1cSPTvT6yN4LwDhWM13uTaOp+4OVcs5rcp3C3iGRpIGWC4vZF+0eOl/3+74+Wz4YjN3kkiQ1wDwZvV+GOkpk5dHWrH0LZFm2qlRijqnKTgWSTSABxMwYols0lCpgLIP7YaDkEywlbZzfXbd5ErLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654408; c=relaxed/simple;
	bh=MPbtgiPJVj+l9qLuZhnBJN2NfyrB5fLloQlhRvm4ZxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HY41rSk1wQCuqxNqOqDOJSlC6pGvfJzllSmEK7elysbOPs+A1rdy/234GhdvQiEn8j/T5Fh1fk05SwHlbJNU2sYXshvSfVjQE+0E3NwVhDOwv2tgLuxqhqpc/Peiyn6duIVgah6mbLgRkZpfgiKI3wVeuQ9QtdTyQ/9JyUwtP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q29skeIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822D9C4CEC4;
	Fri,  6 Sep 2024 20:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725654408;
	bh=MPbtgiPJVj+l9qLuZhnBJN2NfyrB5fLloQlhRvm4ZxE=;
	h=From:Date:Subject:To:Cc:From;
	b=Q29skeIBfe/ADVoArWG1Z7hNhEn79RUO7d9jC8IzbYgH6bbtkp70z4T1432vtX+KP
	 /YJTZ9AaIPxGj0LGEtN88z34p3gU7PdCYob0wv8lLlKPszV5sxhHmqplY+1kYDIiL0
	 7HeD5+mtxvrc84AT+StpsQPdVrWpO+ZVTot4Rr6kMO+kIJYLtITBkHQEYiLTlg5uy4
	 qBWPfEf2obH7Djd+hkHct1y65KfVd6yuD8gMtncSEz1sisJQ1KOGZtuIindbKNW8zO
	 rc5TLhM8RehPOV7Gu2BOtXcGXPK4pL72Fb9prz1C7yEBhtQmC7z42HdIeV7oJLK9mr
	 KmOUzsTowHfGQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 06 Sep 2024 13:26:41 -0700
Subject: [PATCH] can: rockchip_canfd: fix return type of
 rkcanfd_start_xmit()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-rockchip-canfd-wifpts-v1-1-b1398da865b7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIBl22YC/x3MSwqAMAwA0atI1gZqFX9XERc1phqEWlpRQby7x
 eVbzDwQOQhH6LMHAp8SZXcJRZ4BrcYtjDIng1a6Up2qMey00SoeyTg74yXWHxFL001NzQ1p3UJ
 qfWAr9/8dxvf9AOTsc0xnAAAA
X-Change-ID: 20240906-rockchip-canfd-wifpts-3a9b76e7c228
To: Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3084; i=nathan@kernel.org;
 h=from:subject:message-id; bh=MPbtgiPJVj+l9qLuZhnBJN2NfyrB5fLloQlhRvm4ZxE=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGm3U9szRYMXm7c84v3/ZNn6WTP2T6iQYVi3aNeksn/LY
 qpF9vxu7ChlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATEa1l+Kd7zNbk8zyJx4ER
 BQcVQl5fKFF6dOPIzBk1p8T3G9nlWDIzMnwJnJfpp7pxdcWLS/ZrO2e1ydZZ1Qs6Ptx11P2OeZz
 3ExYA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed. A
warning in clang aims to catch these at compile time, which reveals:

  drivers/net/can/rockchip/rockchip_canfd-core.c:770:20: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
    770 |         .ndo_start_xmit = rkcanfd_start_xmit,
        |                           ^~~~~~~~~~~~~~~~~~

->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
'netdev_tx_t', not 'int' (although the types are ABI compatible). Adjust
the return type of rkcanfd_start_xmit() to match the prototype's to
resolve the warning.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/net/can/rockchip/rockchip_canfd-tx.c | 2 +-
 drivers/net/can/rockchip/rockchip_canfd.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index f954f38b955f6dc26b856e4c2f40e20256a7f114..865a15e033a9e50f44af342eec43d4ba10b40fa7 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -63,7 +63,7 @@ void rkcanfd_xmit_retry(struct rkcanfd_priv *priv)
 	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
 }
 
-int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct rkcanfd_priv *priv = netdev_priv(ndev);
 	u32 reg_frameinfo, reg_id, reg_cmd;
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index 3efd7f174e14c2b67b1feef897bc34336f578226..93131c7d7f54d036727356ca9a2d36dcf24d702b 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -546,7 +546,7 @@ void rkcanfd_timestamp_stop_sync(struct rkcanfd_priv *priv);
 
 unsigned int rkcanfd_get_effective_tx_free(const struct rkcanfd_priv *priv);
 void rkcanfd_xmit_retry(struct rkcanfd_priv *priv);
-int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev);
+netdev_tx_t rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev);
 void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
 				unsigned int *frame_len_p);
 

---
base-commit: 52fc70a32573707f70d6b1b5c5fe85cc91457393
change-id: 20240906-rockchip-canfd-wifpts-3a9b76e7c228

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


