Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47A49FC55
	for <lists+linux-can@lfdr.de>; Fri, 28 Jan 2022 16:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbiA1PCR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 28 Jan 2022 10:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiA1PCQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 28 Jan 2022 10:02:16 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E867C061714
        for <linux-can@vger.kernel.org>; Fri, 28 Jan 2022 07:02:16 -0800 (PST)
Received: from localhost.localdomain (unknown [89.158.146.116])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 50734200342;
        Fri, 28 Jan 2022 16:02:13 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/6] can: peak_usb: add ethtool interface to flashed value
Date:   Fri, 28 Jan 2022 16:01:51 +0100
Message-Id: <20220128150157.1222850-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series of patches offers the user the possibility to access in
read/write mode a flashed numerical value for each channel of a PEAK-System
USB - CAN/CANFD interface, through the eeprom access ethtool interface.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Stephane Grosjean (6):
  can: peak_usb: rename a callback to a more explicit name
  can: peak_usb: add callback to read user value of CANFD devices
  can: peak_usb: correction of a wrong field name
  can: peak_usb: allow flashing of user defined value
  can: peak_usb: replace unregister_netdev() with unregister_candev()
  can: peak_usb: add ethtool interface to user defined flashed device
    number

 drivers/net/can/usb/peak_usb/pcan_usb.c      | 35 ++++++++-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 75 +++++++++++++++++++-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  9 ++-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 51 +++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 26 +++++--
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  3 +-
 6 files changed, 187 insertions(+), 12 deletions(-)

-- 
2.25.1

