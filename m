Return-Path: <linux-can+bounces-4773-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D66BB8D6A2
	for <lists+linux-can@lfdr.de>; Sun, 21 Sep 2025 09:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A063168239
	for <lists+linux-can@lfdr.de>; Sun, 21 Sep 2025 07:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F62D3EFB;
	Sun, 21 Sep 2025 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDuSGgdh"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22FF2D3ED8;
	Sun, 21 Sep 2025 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758439992; cv=none; b=E4+SLjb4hKG05Fsf+za1TWD0PYmN2QkFzgZ8DOc2SIGO0H/uYsheGWCiwcQKUgReN25j1pVvT68AamLD3lKx/2sZOeA3eEd9aK6oz8albEbUjZcbiXhjNmFiJm4eOQwVeEkmERZ96GlaCvP9Sufmheq4ERYuup6AS8eMZkLQQBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758439992; c=relaxed/simple;
	bh=Bk4FJR21WL13RpJ+hnlFO1KeNGZZtOL+Fwo4hy7IXiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiU8Y1YOBDZbnXhMsiUGDYxWH6gWj8D7XvdDhriTWDeOkQSWz9TKExJ2My/XILHVNrYLT/x9L4Y8qFExKXnguANM+IYY6QQsj1l918Zv5DM/JTDCXbjp94GM822BhuYhhGQHko7FaekwWcbx/3W/1pH5lIkEOT1cnW7hRwcs+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDuSGgdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E38EC4CEF7;
	Sun, 21 Sep 2025 07:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758439991;
	bh=Bk4FJR21WL13RpJ+hnlFO1KeNGZZtOL+Fwo4hy7IXiM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UDuSGgdhaY8gAC+ATuLeGKC1tvVC3zdA7ZV6/DD8hv8Ubf4HNazbNboSncwxsIFac
	 0vVvUq+Lx92LGLPm25kF6iWYLMoq1au2TgvRCR6PBIGyc65l2ijmKwEttoMjBL7XIn
	 EzCcdljJUMPE3lWBDI+TGzfDfX/1g+vyZ2KkErLs8D1tyY7CivzeKNEEf9QnuANos+
	 98Z1PJQRgzKSB7nZArn/TaVvbabSl1VW2IGxTLGr6ivJlBd2eXwnBtASl3Bny0QP6G
	 uasz62ucDmUadgcXWHow8yELO9PEpEJzd9U8GeqWzizhmEn2sl4RFa6/MALuJHiTC6
	 hIiG9rXOuEt7Q==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Sun, 21 Sep 2025 16:32:31 +0900
Subject: [PATCH iproute2-next 2/3] iplink_can: fix SPDX-License-Identifier
 tag format
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-iplink_can-checkpatch-fixes-v1-2-1ddab98560cd@kernel.org>
References: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
In-Reply-To: <20250921-iplink_can-checkpatch-fixes-v1-0-1ddab98560cd@kernel.org>
To: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org, 
 linux-can@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=Bk4FJR21WL13RpJ+hnlFO1KeNGZZtOL+Fwo4hy7IXiM=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnnV+l1RsTO+vFW6M2L+jThvQxxub7RHBHye467blbdu
 0OXw8qko5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwETuXGdkePzWIffu1QudJ/6u
 jvafUL3G+NMZQcfO46m8AmJsUf1R2xj+Svi9C0plZ/zd+pa3S4mzZIfbBbP2tEThV9/uh+Qmy+T
 zAgA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

In .c files, the SPDX tag uses the C++ comment style.

Fix below checkpatch.pl warning:

  WARNING: Improper SPDX comment style for 'ip/iplink_can.c', please use '//' instead
  #1: FILE: ip/iplink_can.c:1:
  +/* SPDX-License-Identifier: GPL-2.0-or-later */

  WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
  #1: FILE: ip/iplink_can.c:1:
  +/* SPDX-License-Identifier: GPL-2.0-or-later */

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 ip/iplink_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 1afdf08825f3d9cbbb0454592d2ed7dc1388a6de..56c258b023ef57e37574f44981b76086a0a140db 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * iplink_can.c	CAN device support
  *

-- 
2.49.1


