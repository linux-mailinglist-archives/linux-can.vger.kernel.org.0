Return-Path: <linux-can+bounces-5799-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC96CC9975F
	for <lists+linux-can@lfdr.de>; Mon, 01 Dec 2025 23:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7AF93A5CF2
	for <lists+linux-can@lfdr.de>; Mon,  1 Dec 2025 22:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B214A29BDBA;
	Mon,  1 Dec 2025 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+v5xh8Y"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA336D503;
	Mon,  1 Dec 2025 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629792; cv=none; b=StW29uhbfAqBA1PES4i2GIwvvvvQUiflRjFdkkNVGBvpRxPcSpt+KIC3qDJ6K8fWOks1xxHQE5UKrXH3sEFZz7ExVWe//OKHNURPw3NCCDkv9CWmDz9b900IKLmzaNCz3Emdytdcf2+3bsPgDWFACB3e1Xb5HTruiQUJ4UPKqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629792; c=relaxed/simple;
	bh=M4KKHo72Z25bXFP51FFH0SkrJdmV0dkgh6ZN6tjjy80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+Xw3Ij+/waaqpR9TOAVaEEXGCalj03ztDvGNkkWxxzBtuCY2LnxIYBKGVJQVL1Gg5VgGRC6lvzHvi25X6Vq3f8ZsD9wzJxZCKCXWgVTJR2ukE/SR7NqBdbzLMKat3uO43EIhkK+5TiuKoSMkd7Slzf8JB4IE90tkmE4Wyi4YII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+v5xh8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50C9C4CEF1;
	Mon,  1 Dec 2025 22:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629792;
	bh=M4KKHo72Z25bXFP51FFH0SkrJdmV0dkgh6ZN6tjjy80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g+v5xh8YVzALLkgHv79stU08f4QBSdLTdL94G7yp4y3YcfQFQnb1gi6Sj2UzvGZS/
	 YzhjApyQBInEJ4inDZRAoDRClqQhBPSxskYvQBpGoSfWRHxAHBh4QsN7aAhdHgLoXT
	 ZAuv14PygV2OTcAC4nvNSaYz0K0YcJml6mD44N1easrgC0Yz33Ew122pwFpxAL0OLH
	 l3z5f5yCYKAmcsWR29SttNXNbF5BcAt1I1aEtdykEXOY+gQhNxXElCzfSeg2sOTFEW
	 JI/ByfxyhpDxN/UB0e1EdCthCryYcvVTRW/sRHYkMrOG9BcbJ079wEoEoK98UIKc1M
	 0dDReCxbFrzCA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 01 Dec 2025 23:55:10 +0100
Subject: [PATCH iproute2-next v2 2/7] iplink_can: print_usage: change unit
 for minimum time quanta to mtq
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-canxl-netlink-v2-2-dadfac811872@kernel.org>
References: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org>
In-Reply-To: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: Rakuram Eswaran <rakuram.e96@gmail.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>, 
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=M4KKHo72Z25bXFP51FFH0SkrJdmV0dkgh6ZN6tjjy80=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJl6soyMF3Z+q/7h2n7k0MFnjI8NFTPULilPkvpbYZv4t
 Cjhpr5VRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgImICTEybHrn92arrZG76rED
 x1i7dRYH8m6X4j4c+U622WHVpuWcaYwMa/zPuOiX7OYqPZS6/NO2oESZ/jkhkzfs2W2S/3qbQko
 LCwA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

In the vast majority of the available CAN datasheets, the minimum time
quanta is abbreviated as "mtq". Note that the ISO standard uses "tqmin"
(with the "min" part as a subscript).

One fact is that no one seems to be using "tc". I was actually the one who
initially proposed to use "tc", but I can not recall anymore the reasoning
behind that.

Change the minimum time quanta unit from "tc" to "mtq" to follow what the
majority of the industry does.

Fixes: 0c263d7c36ff ("iplink_can: add new CAN FD bittiming parameters: Transmitter Delay Compensation (TDC)")
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 ip/iplink_can.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index f3640fe0..ee27659c 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -56,9 +56,9 @@ static void print_usage(FILE *f)
 		"\t	PHASE-SEG1	:= { NUMBER in tq }\n"
 		"\t	PHASE-SEG2	:= { NUMBER in tq }\n"
 		"\t	SJW		:= { NUMBER in tq }\n"
-		"\t	TDCV		:= { NUMBER in tc }\n"
-		"\t	TDCO		:= { NUMBER in tc }\n"
-		"\t	TDCF		:= { NUMBER in tc }\n"
+		"\t	TDCV		:= { NUMBER in mtq }\n"
+		"\t	TDCO		:= { NUMBER in mtq }\n"
+		"\t	TDCF		:= { NUMBER in mtq }\n"
 		"\t	RESTART-MS	:= { 0 | NUMBER in ms }\n"
 		);
 }

-- 
2.51.2


