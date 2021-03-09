Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E9033206C
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 09:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhCIIWZ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 03:22:25 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:8296 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230140AbhCIIWH (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 9 Mar 2021 03:22:07 -0500
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 140DE5FFD0;
        Tue,  9 Mar 2021 09:22:03 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/3] can/peak_usb: Added improvement to the peak_usb driver
Date:   Tue,  9 Mar 2021 09:21:25 +0100
Message-Id: <20210309082128.23125-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series of patches adds the following improvements:

- allows to identify CAN ports by their LEDs
- completes the list of devices supported by the module
- adds ONE_SHOT mode to some devices

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Stephane Grosjean (3):
  can/peak_usb: add support of ethtool set_phys_id() callback
  can/peak_usb: add forgotten supported devices
  can/peak_usb: add support of ONE_SHOT mode

 drivers/net/can/usb/peak_usb/pcan_usb.c      | 47 ++++++++++++++++++++
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  4 ++
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 +
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 47 ++++++++++++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c  | 46 +++++++++++++++++--
 drivers/net/can/usb/peak_usb/pcan_usb_pro.h  |  6 +++
 6 files changed, 144 insertions(+), 8 deletions(-)

-- 
2.25.1

