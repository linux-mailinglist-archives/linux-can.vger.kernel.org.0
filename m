Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78222332069
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 09:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCIIW0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 03:22:26 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:9288 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhCIIWP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 9 Mar 2021 03:22:15 -0500
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 69D705FF9D;
        Tue,  9 Mar 2021 09:22:10 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 2/3] can/peak_usb: add forgotten supported devices
Date:   Tue,  9 Mar 2021 09:21:27 +0100
Message-Id: <20210309082128.23125-3-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210309082128.23125-1-s.grosjean@peak-system.com>
References: <20210309082128.23125-1-s.grosjean@peak-system.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since the peak_usb driver also supports the CAN-USB interfaces
"PCAN-USB X6" and "PCAN-Chip USB" from PEAK-System GmbH, this patch adds
their names to the list of explicitly supported devices.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 6183a42f6491..8e6250c4c417 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -19,6 +19,8 @@
 
 MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB FD adapter");
 MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB Pro FD adapter");
+MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-USB X6 adapter");
+MODULE_SUPPORTED_DEVICE("PEAK-System PCAN-Chip USB");
 
 #define PCAN_USBPROFD_CHANNEL_COUNT	2
 #define PCAN_USBFD_CHANNEL_COUNT	1
-- 
2.25.1

