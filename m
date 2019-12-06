Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C043C11546C
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 16:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLFPiu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 10:38:50 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:40321 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfLFPiu (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Dec 2019 10:38:50 -0500
Received: from linux-dev.peak.localnet (unknown [185.109.201.203])
        (Authenticated sender: stephane.grosjean)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 54C1BB00585;
        Fri,  6 Dec 2019 16:38:46 +0100 (CET)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/2 v2] can/peak_usb/pcan_usb: add rxerr/txerr support
Date:   Fri,  6 Dec 2019 16:38:01 +0100
Message-Id: <20191206153803.17725-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This series of two patches provides support for CAN error counters rxerr/
txerr when the CAN-USB PCAN-USB interface of PEAK-System GmbH is used to
access the CAN bus.

The first patch documents former numeric values used in commands sent to
the PCAN-USB device.

The second one activates the bus event notification feature in the PCAN-USB
to receive specific packets.

Stephane Grosjean (2):
  can/peak_usb/pcan_usb: Document the commands sent to the device
  can/peak_usb/pcan_usb: add support of rxerr/txerr counters

 drivers/net/can/usb/peak_usb/pcan_usb.c | 166 ++++++++++++++++++++----
 1 file changed, 143 insertions(+), 23 deletions(-)

-- 
2.20.1

