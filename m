Return-Path: <linux-can+bounces-5776-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3CCC940D6
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 16:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4DB3A74B7
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313B221FF36;
	Sat, 29 Nov 2025 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMo0SbF0"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060951AA7BF;
	Sat, 29 Nov 2025 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764430196; cv=none; b=ZzvVNEegAGL9ZjugCGz6x+XYbVui3s2uCVGf57/FjWxrm//jX5nnQS3hkoyYYdBr4fCaHBBUmG7ox/G2Dx0ZcFKJQyKXYNPHhO8wFIOADYPFnfTiz510gWvMYRTWT96lcQ6pMIhpuB4i/Qjf5CqGLszQTXWdf4R+fmRKdQ5KMEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764430196; c=relaxed/simple;
	bh=M4KKHo72Z25bXFP51FFH0SkrJdmV0dkgh6ZN6tjjy80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CoXYbtA9FtaGP/SpHoi5nT4lk47A/rkgbzaXJD8mRQRZ75a3mWupbGT5haAznFnUEXdc3nmMEThfKZ8/aTPyr0mYiUa2nCqzZreZRJNh0h1qNzzXLn/XR3IFfAi59lntVlbp9FnIlr07zuU0u1IZAA3xmB5ZmAAbDWnZRgxWqkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMo0SbF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1ADC4CEF7;
	Sat, 29 Nov 2025 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764430195;
	bh=M4KKHo72Z25bXFP51FFH0SkrJdmV0dkgh6ZN6tjjy80=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PMo0SbF0/UcJyI9yq5qWBPjV4lxx70BR/9osWcUCaKEhmPalnxAuMmC9vI1tTrvn0
	 hEWZeEAswhXJMFC0aMzAIf3+LzdoVnIrIh4xBtSFF0JY6FJll5Eel0wq2YG0dHK0DX
	 R0zhZB6nBkK+CfmhCv+h6sGDteWf1IMk+ZfF67iQNiYoQ9KOAuk/3te0NLVgzH4tp4
	 ookJKSuOV2zbrZg+/zc+nzbznEG6JM2oodJVDzCk9aEfhKM82CjzphYtW3xSw3ltrv
	 KPpC3ummhQp1eIzdEq91EkDL5EZpTIX3DThdrOcsun4xW2dVrh1nCiVaNkHaZjFBgs
	 FE6Ct2+39/YmQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sat, 29 Nov 2025 16:29:07 +0100
Subject: [PATCH 2/7] iplink_can: print_usage: change unit for minimum time
 quanta to mtq
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251129-canxl-netlink-v1-2-96f2c0c54011@kernel.org>
References: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
In-Reply-To: <20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=M4KKHo72Z25bXFP51FFH0SkrJdmV0dkgh6ZN6tjjy80=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDJnagqGrCi+1pRyTTW/7vNH0/kUdhXNxXbvVfs0tmL5Ca
 rvdV9P1HaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACZy4Sojw2FNnswLBWuzeT7v
 vS2z9t76Er+gnXvWnm7ybslbl7y84jrDP8s1DoHF+Yn2WZtt3z6w//D7+rVqzoaZKea5okaMNx9
 dYQQA
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


