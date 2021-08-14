Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5413EC1AF
	for <lists+linux-can@lfdr.de>; Sat, 14 Aug 2021 11:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbhHNJeo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 14 Aug 2021 05:34:44 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:40111 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbhHNJej (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 14 Aug 2021 05:34:39 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d19 with ME
        id hMa0250070zjR6y03Ma8cH; Sat, 14 Aug 2021 11:34:10 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Aug 2021 11:34:10 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] MAINTAINERS: add Vincent MAILHOL as maintainer for the ETAS ES58X CAN/USB driver
Date:   Sat, 14 Aug 2021 18:33:53 +0900
Message-Id: <20210814093353.74391-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Adding myself (Vincent Mailhol) as a maintainer for the ETAS ES58X
CAN/USB driver.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
When sending the patches for the ETAS ES58X driver, I looked at what
other drivers were doing and realized that most of these did not
update the MAINTAINERS file. At that time, I candidly thought that the
MODULE_AUTHOR macro was sufficient for that. Following this e-mail:
https://lore.kernel.org/linux-can/20210809175158.5xdkqeemjo3hqwcw@pengutronix.de/
it appeared that I should have done so.

This patch fixes it. :)
---
MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41fcfdb24a81..9a164f4eeee6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11347,6 +11347,12 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/phy/mxl-gpy.c
 
+ETAS ES58X CAN/USB DRIVER
+M:	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/usb/etas_es58x/
+
 MCAB MICROCHIP CAN BUS ANALYZER TOOL DRIVER
 R:	Yasushi SHOJI <yashi@spacecubics.com>
 L:	linux-can@vger.kernel.org
-- 
2.31.1

