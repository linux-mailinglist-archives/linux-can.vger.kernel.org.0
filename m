Return-Path: <linux-can+bounces-459-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 425128AC4FC
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 09:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6799C1C21233
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 07:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184F150280;
	Mon, 22 Apr 2024 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="u/FzPVWU"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4A4AEC3;
	Mon, 22 Apr 2024 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769942; cv=none; b=AoUHxFQO5/+M2OqJi3kfSIBLdtz6NjEU6d8TX+5/kzEnSv8ftKhNrL6wi4EB4s6JyYdhGl3OoVgFP5uGUUV/5N4SX9h3kLWfJt2MZKuk/7yqkeHBi3dMGhh6EkzSUothW6XiLLuLH3yCxUqLbpBo7uWyJsdcVdqaSP4mhsuQSBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769942; c=relaxed/simple;
	bh=lj6dAZHU9zdIKsshCr+sylTI6S5hi23UoYkblVikrEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lwSk27fsusx9C42VnqCcwDG9gEoFGszqSnC7peVqQcRutS9vVQ+Js75E0FbWsb17+1gmGN/8FalOWFJZue+hT96rJTzl0KAHp63nf23B03Tobhi16zmvjMpZiasyRGheYUctds0IzMV9PTtJta5FUTvQjXxNydHysDnDTjqwduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=u/FzPVWU; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=w7g7mLr0/TZ347EWR5Oi1PWvGCnThvGAGijuq88Ht74=; b=u/FzPVWU0hPZCHImq5MkUgs9+L
	KKB0ypztvnd/2P574yUhOS59Bk0e5uwKYz3/oGeLqObQdrGQmV7jiGUb8aWNuaC6Gkj0lY9IYUu0f
	68YdA4HSn3eFG06cxuciYT6+C+68cnt5P+2Z6KqauSkrqa7Ypx6NajEfYiM4bV2uVSzs=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1rynWn-001JRH-1G;
	Mon, 22 Apr 2024 08:51:49 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 07/11] can: lin: Add special frame id for rx offload config
Date: Mon, 22 Apr 2024 08:51:10 +0200
Message-Id: <20240422065114.3185505-8-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
References: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A LIN bus supports up to 64 identifiers in one byte. This commit adds a
special frame ID, beyond the actual LIN identifiers, for signaling RX
offload configuration requests. This ID will be utilized in future LIN
enhancements to the CAN broadcast manager.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 include/net/lin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/lin.h b/include/net/lin.h
index 2fe16e142db96..3f78cfda9c657 100644
--- a/include/net/lin.h
+++ b/include/net/lin.h
@@ -18,6 +18,7 @@
 
 #define LIN_ID_MASK		0x0000003FU
 /* special ID descriptions for LIN */
+#define LIN_RXOFFLOAD_DATA_FLAG	0x00000200U
 #define LIN_ENHANCED_CKSUM_FLAG	0x00000100U
 
 static const unsigned char lin_id_parity_tbl[] = {
-- 
2.39.2


