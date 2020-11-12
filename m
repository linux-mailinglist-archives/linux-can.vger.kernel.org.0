Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA7C2B0C2F
	for <lists+linux-can@lfdr.de>; Thu, 12 Nov 2020 19:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgKLSE3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 12 Nov 2020 13:04:29 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:52451 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKLSE3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Nov 2020 13:04:29 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 84E01FF925
        for <linux-can@vger.kernel.org>; Thu, 12 Nov 2020 18:04:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uFfXh3VVgyHF for <linux-can@vger.kernel.org>;
        Thu, 12 Nov 2020 19:04:26 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH v2 00/16]  Add support for CPC-USB/FD CAN FD interface
Date:   Thu, 12 Nov 2020 19:03:30 +0100
Message-Id: <20201112180346.29070-1-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

These patches extend the ems_usb.c driver to support both devices, the
classic CAN CPC-USB/ARM7 and the CAN FD CPC-USB/FD. After fixing issues given
by checkpatch.pl and adding the CPC_ClearCmdQueue function all needed parts
to support CAN FD were added step by step. Also added is support for the
listen only mode for CPC-USB/ARM7 now.
The last patch enables the driver for CPC-USB/FD.

Gerhard Uttenthaler (16):
  can: ems_usb: Fixed warnings and comments
  can: ems_usb: Added CPC_ClearCmdQueue routine.
  can: ems_usb: Fixed non C99 style initialization
  can: ems_usb: Added CAN FD message representation
  can: ems_usb: Added CAN FD initialization struct
  can: ems_usb: Made RX_BUFFER_SIZE, ems_usb_write_mode and
    ems_usb_probe device dependent
  can: ems_usb: Added listen only mode for CPC-USB/ARM7
  can: ems_usb: Modified ems_usb_read_bulk_callback to handle also
    CPC-USB/FD
  can: ems_usb: Added CAN controller initialization for CAN FD
  can: ems_usb: Added receive routine for CAN FD messages
  can: ems_usb: Added ems_usb_write_mode_fd
  can: ems_usb: Fixed ems_usb_start_xmit for CAN FD
  can: ems_usb: Made CAN error reporting CAN controller dependent
  can: ems_usb: Made structs packed
  can: ems_usb: Added error reporting for CPC-USB/FD
  can: ems_usb: Enable CPC-USB/FD support

 drivers/net/can/usb/ems_usb.c | 858 +++++++++++++++++++++++++++-------
 1 file changed, 682 insertions(+), 176 deletions(-)

-- 
2.26.2

-- 
EMS Dr. Thomas Wuensche e.K.
Sonnenhang 3
85304 Ilmmuenster
HR Ingolstadt, HRA 170106

Phone: +49-8441-490260
Fax  : +49-8441-81860
http://www.ems-wuensche.com
