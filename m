Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316463DD405
	for <lists+linux-can@lfdr.de>; Mon,  2 Aug 2021 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhHBKlZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 Aug 2021 06:41:25 -0400
Received: from smtp03-ext2.udag.de ([62.146.106.30]:50028 "EHLO
        smtp03-ext2.udag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhHBKlY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Aug 2021 06:41:24 -0400
Received: from NBVM2-TW.fritz.box (p54b8ff0e.dip0.t-ipconnect.de [84.184.255.14])
        by smtp03-ext2.udag.de (Postfix) with ESMTPA id 5E20DE012C;
        Mon,  2 Aug 2021 12:41:14 +0200 (CEST)
From:   Thomas Wagner <thomas@the-wagner.de>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, Thomas Wagner <thomas@the-wagner.de>
Subject: [PATCH v2] can: Documentation: Sending with canfd_frame on a CAN 2.0 interface
Date:   Mon,  2 Aug 2021 12:40:48 +0200
Message-Id: <20210802104048.32007-1-thomas@the-wagner.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802102853.29308-1-thomas@the-wagner.de>
References: <20210802102853.29308-1-thomas@the-wagner.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp03-ext2.udag.de;
        auth=pass smtp.auth=thomas@the-wagner.de smtp.mailfrom=thomas@the-wagner.de
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In response to my uncertainty described here
https://lore.kernel.org/linux-can/20210729121417.kysljj4636hmhem2@pengutronix.de/T/#t.

This patch clarifies sending CAN 2.0 frames on CAN FD capable hardware
when the interface is configured as CAN 2.0.

Signed-off-by: Thomas Wagner <thomas@the-wagner.de>
---
 Documentation/networking/can.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index f34cb0e4460e..ac3fe948c888 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -675,6 +675,17 @@ When sending to CAN devices make sure that the device is capable to handle
 CAN FD frames by checking if the device maximum transfer unit is CANFD_MTU.
 The CAN device MTU can be retrieved e.g. with a SIOCGIFMTU ioctl() syscall.
 
+You should also check the MTU in an environment, where the device is CAN
+FD capable, but the interface might be configured for just CAN 2.0. In
+this case the canfd_frame struct can still be used, but when writing to
+the socket write CAN_MTU bytes at most to send a CAN 2.0 frame.
+
+In conclusion, to handle devices with and without CAN FD and with
+interfaces configured as CAN 2.0 or CAN FD:
+- Set the CAN_RAW_FD_FRAMES flag and ignore the error on older kernels
+- Send and receive using the canfd_frame struct
+- Check the bytes received to know, whether you got an CAN 2.0 or FD frame
+- Check the devices MTU to know, whether you can send CAN 2.0 or FD frames
 
 RAW socket option CAN_RAW_JOIN_FILTERS
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.25.1

