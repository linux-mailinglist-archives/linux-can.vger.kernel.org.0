Return-Path: <linux-can+bounces-3973-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CAEB02F51
	for <lists+linux-can@lfdr.de>; Sun, 13 Jul 2025 10:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E4117CC82
	for <lists+linux-can@lfdr.de>; Sun, 13 Jul 2025 08:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28141EF38F;
	Sun, 13 Jul 2025 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bl2lw19C"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184661E5729;
	Sun, 13 Jul 2025 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752393891; cv=none; b=D0z0x8Mgm7jBVWlORev+5BMgCBt/+RsNm79GJUpMLkTsAEWAopoj7gEftwIedVCn7AoxLu3cNUbW8RymJGkJPanTZOqEiB9oQIyyNEvJcxweD6fjyaWkkSSxk6fBAcFdvvAxPYetPw9gdKVuWYGpmGYApDUloPCZTG7pZurUtGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752393891; c=relaxed/simple;
	bh=3rZgR0l8Z1qRedXY9QRMZ0hp1DP2iberLTIl38XaMM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uJs3e26pwjzjDDcCfpshahF1KYwCemAIz7WVSumaDlutjoUSl9DY5fJRaYwNpR9N9XFQURzN/K+oBjGtS0RJCTRDjmiQ5t710LraoLiarJnrQOIpK1fR/yISbE2my8TLSaxnkGHUcwMZpfVp+eMDMbCbE/Oy6d5HaDdT/IA9DUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bl2lw19C; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id arfyuJE25DfrTargOuRCKM; Sun, 13 Jul 2025 10:03:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752393817;
	bh=firp9q+7E9bpWdAhibT2eizu9TvLkkpFwp09yRSRLUM=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=bl2lw19CRmjS9TwCGTrIFGfw6uJOVhwVUMSQR/bj1lvjLM3U8REMsKRwaJ8hKsP9q
	 ghKaR+jbN3a3awdrtbdf9Fn9e3XmMLCoaMYSw+9Lx4DSFK3gQxTFjeY9yd+Mm5Kepr
	 jn0XRu10J98CrlJj3wz7nw0jneOznWnj55pK0MFWLHd6NOlQLWzjKZnotEUQ8N9baD
	 4Tv1vuuFeZViHpp2poss1DtfmYPHw31V5h8kaUVrKpnjqyAPffMnxyItNR7hgTrXdL
	 0cna6EBsKQEgZuKPF6OikmgN1IsgJ7GnopBfNurZLP2zO29oyB2TKs4wHI1Oa+s77O
	 KCC9AvzM7012A==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 13 Jul 2025 10:03:37 +0200
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Sun, 13 Jul 2025 17:02:44 +0900
Subject: [PATCH 2/3] can: ti_hecc: Kconfig: add COMPILE_TEST
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-can-compile-test-v1-2-b4485e057375@wanadoo.fr>
References: <20250713-can-compile-test-v1-0-b4485e057375@wanadoo.fr>
In-Reply-To: <20250713-can-compile-test-v1-0-b4485e057375@wanadoo.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=704;
 i=mailhol.vincent@wanadoo.fr; h=from:subject:message-id;
 bh=3rZgR0l8Z1qRedXY9QRMZ0hp1DP2iberLTIl38XaMM8=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnFGb6xh5/8/NNn+cC2cHLZjLKljc/lA9ftZxDhzMo+e
 mti3k63jlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABPxjWZkuHPwI+PNI1M+lbyx
 P32CweN68p3dUxIF49aa/Zi0XzL1/n2GPzwmjd0eHoUPW5W01WbbOH7i3iT7cUdEpO3HT99Vouw
 2cQIA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

ti_hecc depends on ARM. Add COMPILE_TEST so that this driver can also
be built on other platforms.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index cf989bea9aa33356a94a9bb495d4c22ae907d436..d58fab0161b3ea6e12047c3fa0f884d0142002e7 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -201,7 +201,7 @@ config CAN_SUN4I
 	  be called sun4i_can.
 
 config CAN_TI_HECC
-	depends on ARM
+	depends on ARM || COMPILE_TEST
 	tristate "TI High End CAN Controller"
 	select CAN_RX_OFFLOAD
 	help

-- 
2.49.1


