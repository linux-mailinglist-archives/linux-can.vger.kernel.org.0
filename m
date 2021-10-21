Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BFB435CBD
	for <lists+linux-can@lfdr.de>; Thu, 21 Oct 2021 10:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhJUIRu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Oct 2021 04:17:50 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:45216 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhJUIRp (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 21 Oct 2021 04:17:45 -0400
Received: from localhost.localdomain (unknown [89.158.142.148])
        (Authenticated sender: stephane.grosjean@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id D2DFB5FFD3;
        Thu, 21 Oct 2021 10:15:25 +0200 (CEST)
From:   Stephane Grosjean <s.grosjean@peak-system.com>
To:     linux-can Mailing List <linux-can@vger.kernel.org>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>
Subject: [PATCH 0/2 v2] can: peak_usb: PCAN-USB bus state fix and info ordering
Date:   Thu, 21 Oct 2021 10:15:03 +0200
Message-Id: <20211021081505.18223-1-s.grosjean@peak-system.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This bundle of changes:
- corrects a potential bad transition to ERROR_PASSIVE or ERROR_WARNING
  state if BERR reporting was not explicitly requested for the can
  interface associated with the PCAN-USB,
- reorders the information displayed when the PCAN-USB is detected, when it
  can benefit from a firmware update.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Stephane Grosjean (2):
  can: peak_usb: always ask for BERR reporting for PCAN-USB devices
  can: peak_usb: exchange the order of information messages

 drivers/net/can/usb/peak_usb/pcan_usb.c | 27 ++++++++++++-------------
 1 file changed, 13 insertions(+), 14 deletions(-)

-- 
2.25.1

