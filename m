Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5A71150DA
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 14:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfLFNNY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 08:13:24 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53281 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfLFNNY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Dec 2019 08:13:24 -0500
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1idDQ9-00047p-6V; Fri, 06 Dec 2019 14:13:21 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH] can: j1939: Fix address claim code example
Date:   Fri,  6 Dec 2019 14:13:19 +0100
Message-Id: <20191206131319.20585-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

During development the define J1939_PGN_ADDRESS_REQUEST was renamed to
J1939_PGN_REQUEST. It was forgotten to adjust the documentation
accordingly.

This patch fixes the name of the symbol.

Reported-by: https://github.com/linux-can/can-utils/issues/159#issuecomment-556538798
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/networking/j1939.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/j1939.rst b/Documentation/networking/j1939.rst
index dc60b13fcd09..f5be243d250a 100644
--- a/Documentation/networking/j1939.rst
+++ b/Documentation/networking/j1939.rst
@@ -339,7 +339,7 @@ To claim an address following code example can be used:
 			.pgn = J1939_PGN_ADDRESS_CLAIMED,
 			.pgn_mask = J1939_PGN_PDU1_MAX,
 		}, {
-			.pgn = J1939_PGN_ADDRESS_REQUEST,
+			.pgn = J1939_PGN_REQUEST,
 			.pgn_mask = J1939_PGN_PDU1_MAX,
 		}, {
 			.pgn = J1939_PGN_ADDRESS_COMMANDED,
-- 
2.24.0

