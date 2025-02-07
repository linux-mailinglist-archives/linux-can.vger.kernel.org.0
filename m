Return-Path: <linux-can+bounces-2745-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1259FA2BC57
	for <lists+linux-can@lfdr.de>; Fri,  7 Feb 2025 08:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570DC167B80
	for <lists+linux-can@lfdr.de>; Fri,  7 Feb 2025 07:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0537C1A76DA;
	Fri,  7 Feb 2025 07:36:11 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDFA1A2C0B;
	Fri,  7 Feb 2025 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913770; cv=none; b=iWrvLgfmCklD69UHfV5cX4SNB56akciEwm/vCEEfWKBlaXXpz+mPU9Lsn+9EAiNYTGQ2UfMHtliIp8YtQR99SePNiNyLLZaWfCspSbfILLZ2M8lCqMm6ZfbecIZx9+/4xIHzEk/LfF5Kw1psLCrQG9Y8VfGNZnlEuYwplzXzfDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913770; c=relaxed/simple;
	bh=KP0xPlJQnncOfGBLdKus6e0ffsRrhdP0K7kpQJEhrmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EnO9dCmmhiwM167qlyJiz9kUicDTAIl7pobJ4JEX38sdB65W/VYpuXLlq5bm5s/2kbZjlO5hK+3+qM0QyGcVJ5wAW+twYGBcZyQ74MCAo4h+LSeUGulPOiCTR3lrfpv74ETBF8u+oruGKrqavCEtQ4xqLB86Wzw/wOfGUuS1Wlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id EZP00148;
        Fri, 07 Feb 2025 15:34:48 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Feb 2025 15:34:47 +0800
Received: from locahost.localdomain (10.94.12.190) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Feb 2025 15:34:47 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <mkl@pengutronix.de>, <manivannan.sadhasivam@linaro.org>,
	<thomas.kopp@microchip.com>, <mailhol.vincent@wanadoo.fr>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <cem@kernel.org>,
	<djwong@kernel.org>, <corbet@lwn.net>
CC: <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [v2] Documentation: Remove repeated word in docs
Date: Fri, 7 Feb 2025 15:34:29 +0800
Message-ID: <20250207073433.23604-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Jtjnmail201617.home.langchao.com (10.100.2.17) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 20252071534487ca61296d0d4a6ca2047d9cd90f405c0
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Remove the repeated word "to" docs.

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml      | 2 +-
 Documentation/filesystems/xfs/xfs-online-fsck-design.rst      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
index 2a98b26630cb..c155c9c6db39 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
@@ -40,7 +40,7 @@ properties:
 
   microchip,rx-int-gpios:
     description:
-      GPIO phandle of GPIO connected to to INT1 pin of the MCP251XFD, which
+      GPIO phandle of GPIO connected to INT1 pin of the MCP251XFD, which
       signals a pending RX interrupt.
     maxItems: 1
 
diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
index 12aa63840830..e231d127cd40 100644
--- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
@@ -4521,8 +4521,8 @@ Both online and offline repair can use this strategy.
 | For this second effort, the ondisk parent pointer format as originally   |
 | proposed was ``(parent_inum, parent_gen, dirent_pos) → (dirent_name)``.  |
 | The format was changed during development to eliminate the requirement   |
-| of repair tools needing to to ensure that the ``dirent_pos`` field       |
-| always matched when reconstructing a directory.                          |
+| of repair tools needing to ensure that the ``dirent_pos`` field always   |
+| matched when reconstructing a directory.                                 |
 |                                                                          |
 | There were a few other ways to have solved that problem:                 |
 |                                                                          |
-- 
2.43.0


