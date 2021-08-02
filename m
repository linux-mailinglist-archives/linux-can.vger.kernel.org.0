Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED67D3DD3B0
	for <lists+linux-can@lfdr.de>; Mon,  2 Aug 2021 12:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhHBK3m (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 Aug 2021 06:29:42 -0400
Received: from rspamd-proxy-01.udag.de ([62.146.106.33]:51998 "EHLO
        smtp02-ext3.udag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhHBK3l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Aug 2021 06:29:41 -0400
Received: from NBVM2-TW.fritz.box (p54b8ff0e.dip0.t-ipconnect.de [84.184.255.14])
        by smtp02-ext3.udag.de (Postfix) with ESMTPA id 1DD02E03ED;
        Mon,  2 Aug 2021 12:29:31 +0200 (CEST)
From:   Thomas Wagner <thomas@the-wagner.de>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, Thomas Wagner <thomas@the-wagner.de>
Subject: [PATCH] can: Documentation: Sending with canfd_frame on a CAN 2.0 interface
Date:   Mon,  2 Aug 2021 12:28:53 +0200
Message-Id: <20210802102853.29308-1-thomas@the-wagner.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp02-ext3.udag.de;
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
 Documentation/networking/can.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index f34cb0e4460e..af94ece79d5e 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -675,6 +675,20 @@ When sending to CAN devices make sure that the device is capable to handle
 CAN FD frames by checking if the device maximum transfer unit is CANFD_MTU.
 The CAN device MTU can be retrieved e.g. with a SIOCGIFMTU ioctl() syscall.
 
+You should also check the MTU in an environment, where the device is CAN
+FD capable, but the interface might be configured for just CAN 2.0. In
+this case the canfd_frame struct can still be used, but when writing to
+the socket write CAN_MTU bytes at most to send a CAN 2.0 frame.
+
+In conclusion:
+- Set the CAN_RAW_FD_FRAMES flag and ignore the error on older kernels
+- Send and receive using the canfd_frame struct
+- Check the bytes received to know, whether you got an CAN 2.0 or FD frame
+- Check the devices MTU to know, whether you can send CAN 2.0 or FD frame
+
+Building your application using always the canfd_frame, setting the  this enables it to run on devices with and
+without CAN FD hardware. It also handles the possibility of interfaces that
+are configured as CAN 2.0 or CAN FD on CAN FD hardware.
 
 RAW socket option CAN_RAW_JOIN_FILTERS
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.25.1

