Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B204DCF51F
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfJHIiC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 04:38:02 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:15025 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbfJHIiC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 8 Oct 2019 04:38:02 -0400
Received: from linux-dev.peak.localnet (unknown [185.109.201.203])
        (Authenticated sender: stephane.grosjean)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 6A663B005C7;
        Tue,  8 Oct 2019 10:37:55 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/2] can/peak_usb/pcan_usb: add rxerr/txerr support
Date:   Tue,  8 Oct 2019 10:35:43 +0200
Message-Id: <20191008083545.4569-1-s.grosjean@peak-system.com>
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

The first patch fixes a potential synchronization loss problem in the
decoding of packets read from buffers received from PCAN-USB.

The second one activates the bus error notification feature in the PCAN-USB
to receive specific packets.

Stephane Grosjean (2):
  can/peak_usb: fix a potential out-of-sync while decoding packets
  can/peak_usb/pcan_usb: add support of rxerr/txerr counters

 drivers/net/can/usb/peak_usb/pcan_usb.c | 192 +++++++++++++++++++++---
 1 file changed, 172 insertions(+), 20 deletions(-)

-- 
2.20.1

