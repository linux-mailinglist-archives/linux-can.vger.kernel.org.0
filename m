Return-Path: <linux-can+bounces-5123-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84115BD0146
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 13:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872C71894E4C
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEAB25784F;
	Sun, 12 Oct 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXoJd0fb"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCD31BDCF;
	Sun, 12 Oct 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760268259; cv=none; b=Y2EWD5KV7Qhr7GfRMXFByuoQGCt+VFp837hXMZ1YvUegGNmWhyz6hWTM5rzYRtGNRpRUqBfczn+yPXNPKogdJP71bWBGQ/yTrsvPpGrtNgrcKG1A82WnEmlaXVOFEnp8u5rGKqslTkyU1ZXrbkdx5SA0B836w2Uoz/ARF6FmfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760268259; c=relaxed/simple;
	bh=8nM7M2R/YQ3nyq7zzGBKueK5f2+Hfv0nMSpOfEVEQaQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fiJ4jAUzIR3ZT9rpV8Xv51YDl9Uw5aukDQWR8MjDA/VzCC0JmvPaQP7r/bgtbMfgo2AuU+PHRwmxXt5/woo5PcQh0eOi94Op7p0ms503NaCmiAUpDbc82HWGDis36l63TBwjqr7n08KrEnt8yY/S2MGXQyQv0LB5E+A90vu5vVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXoJd0fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B553BC4CEE7;
	Sun, 12 Oct 2025 11:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760268259;
	bh=8nM7M2R/YQ3nyq7zzGBKueK5f2+Hfv0nMSpOfEVEQaQ=;
	h=From:Subject:Date:To:Cc:From;
	b=UXoJd0fbYXHk5p5EC+wddbp8jtXvhNU0lylNvxhq3JulMP5GhB6U3Pc6iAoMciwzA
	 7G5C0DOCqJI8HWUMEQfSxkmKKNxX2gFPWFFJFPKLQd/+Li/QkbwB41ptn8Q/tIlFQ+
	 wz6pLQw08TC+PY807gXxz55rnIuy1DEKeePHgFVorGQjWrm5wMves+skkE50L1YbB4
	 KFE3pWUB1o0BlsgdODqK0G5T30+lqUMnU4vr6YOYyddBBFX71OxVxIaBoXM8K9QUqo
	 uFkyEzKjQQl0xY19OGQXCBDgw87BYpzC7/r8Rs59LPw+KX8+5coVRKJp7YXPfWHcFJ
	 eUDywDOa9o9iA==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH 0/2] can: add Transmitter Delay Compensation (TDC)
 documentation
Date: Sun, 12 Oct 2025 20:23:41 +0900
Message-Id: <20251012-can-fd-doc-v1-0-86cc7d130026@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL2P62gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Mj3eTEPN20FN2U/GRdM0ujVPOklBQzYzNLJaCGgqLUtMwKsGHRsbW
 1ABKej6tcAAAA
X-Change-ID: 20251012-can-fd-doc-692e7bdd6369
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=885; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=8nM7M2R/YQ3nyq7zzGBKueK5f2+Hfv0nMSpOfEVEQaQ=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmv+28ov+oLcrP6Znxw7zLzUq+LZx43bKi6z8wznXl/K
 nevqHlPRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgImoMzP893knUn3yyrTiIpft
 DLntB06vK/Xs614dMo/5xcH3l4Wl/jIyXPEW9OV7/rxbP0O0c0P3hUt7w3b8vZB9c/WL/okCreq
 zOQE=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

TDC was added to the kernel in 2021 but I never took time to update
the documentation. The year is now 2025... As we say: "better late
than never"!

The first patch is a small clean up which fixes an incorrect statement
concerning the CAN DLC, the second patch is the real thing and adds
the documentation of how to use the ip tool to configure the TDC.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Vincent Mailhol (2):
      can: remove false statement about 1:1 mapping between DLC and length
      can: add Transmitter Delay Compensation (TDC) documentation

 Documentation/networking/can.rst | 67 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)
---
base-commit: 67029a49db6c1f21106a1b5fcdd0ea234a6e0711
change-id: 20251012-can-fd-doc-692e7bdd6369

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


