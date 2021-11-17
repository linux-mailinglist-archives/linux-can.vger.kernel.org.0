Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB19454982
	for <lists+linux-can@lfdr.de>; Wed, 17 Nov 2021 16:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhKQPEt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 Nov 2021 10:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhKQPEr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Nov 2021 10:04:47 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ADFC061570
        for <linux-can@vger.kernel.org>; Wed, 17 Nov 2021 07:01:48 -0800 (PST)
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 216C2200371;
        Wed, 17 Nov 2021 16:01:43 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/6] can: peak_usb: add sysfs interface to flashed value
Date:   Wed, 17 Nov 2021 16:01:26 +0100
Message-Id: <20211117150132.37056-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series of patches offers the user the possibility to access in
read/write mode a flashed numerical value for each channel of a PEAK-System
USB - CAN/CANFD interface, through the sysfs interface, under the tree
/sys/class/net/canX and the new entry "dev_num" of the newly created group
"peak_usb". Thus the command :

$ echo /sys/class/net/can0/peak_usb/dev_num

will display the value stored in the internal memory, for the first channel
of the PEAK-System device.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Stephane Grosjean (6):
  can: peak_usb: rename a callback to a more explicit name
  can: peak_usb: add callback to read user value of CANFD devices
  can: peak_usb: correction of a wrong field name
  can: peak_usb: allow flashing of user defined value
  can: peak_usb: replace unregister_netdev() with unregister_candev()
  can: peak_usb: add sysfs interface to internal device user value

 drivers/net/can/usb/peak_usb/pcan_usb.c      | 26 ++++++-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 82 +++++++++++++++++++-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  3 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 48 ++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 23 +++++-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  3 +-
 6 files changed, 173 insertions(+), 12 deletions(-)

-- 
2.25.1

