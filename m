Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED022A9A88
	for <lists+linux-can@lfdr.de>; Fri,  6 Nov 2020 18:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgKFRL0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Nov 2020 12:11:26 -0500
Received: from mail3.ems-wuensche.com ([81.169.186.156]:44226 "EHLO
        mail3.ems-wuensche.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgKFRLW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 6 Nov 2020 12:11:22 -0500
Received: from localhost (unknown [127.0.0.1])
        by h2257714.serverkompetenz.net (Postfix) with ESMTP id 6D594FFBB8
        for <linux-can@vger.kernel.org>; Fri,  6 Nov 2020 17:02:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at h2257714.serverkompetenz.net
X-Spam-Flag: NO
X-Spam-Score: -1.901
X-Spam-Level: 
X-Spam-Status: No, score=-1.901 tagged_above=-9999.9 required=5
        tests=[BAYES_00=-1.9, NO_RECEIVED=-0.001, NO_RELAYS=-0.001,
        URIBL_BLOCKED=0.001] autolearn=unavailable autolearn_force=no
Received: from mail3.ems-wuensche.com ([81.169.186.156])
        by localhost (h2257714.serverkompetenz.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4zNxGTs-ckqE for <linux-can@vger.kernel.org>;
        Fri,  6 Nov 2020 18:02:47 +0100 (CET)
From:   Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
To:     linux-can@vger.kernel.org
Cc:     wg@grandegger.com, mkl@pengutronix.de,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>
Subject: [PATCH 00/17] Add support for CPC-USB/FD CAN FD interface
Date:   Fri,  6 Nov 2020 18:01:49 +0100
Message-Id: <20201106170206.32162-1-uttenthaler@ems-wuensche.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

These patches extend the ems_usb.c driver to support both devices, the
classic CAN CPC-USB/ARM7 and the CAN FD CPC-USB/FD. Also support for
the listen only mode for CPC-USB/ARM7 was implemented. Most issues given
by checkpatch.pl were resolved.

Gerhard Uttenthaler (17):
  can: ems_usb: Fixed warnings given by checkpatch.pl and fixed some
    outdated comments
  can: ems_usb: Added defines and product id needed for CPC-USB/FD
  can: ems_usb: Added CAN FD message representation
  can: ems_usb: Added struct used for CAN FD initialization
  can: ems_usb: Replace constant define RX_BUFFER_SIZE by variable
    bulk_rd_buf_size, because this will have different values for
    CPC-USB/ARM7 and CPC-USB/FD. For the same reason added a function
    pointer ems_usb_write_mode. In device probe function added a switch
    statement to select between CPC-USB/ARM7 and CPC-USB/FD and
    rearranged initialization sequence accordingly.
  can: ems_usb: Added listen only mode for CPC-USB/ARM7 and moved
    evaluation of can.ctrlmode from set_bittiming routine to
    ems_usb_write_mode_arm7 routine. Wrapped a long line.
  can: ems_usb: Added CPC_ClearCmdQueue routine to get access to the
    interface even it is flooded with messages which cannot successfully
    be sent. Set timestamp to 0 in ems_usb_control_cmd.
  can: ems_usb: Modified ems_usb_read_bulk_callback to be able to handle
    also CPC-USB/FD
  can: ems_usb: For CPC-USB/FD added clock definitions, bittiming
    constants, set_bittiming functions, bittiming init function and add
    all that to probe function
  can: ems_usb: Added receive routine for CAN FD messages and its call
    in ems_usb_read_bulk_callback
  can: ems_usb: Added ems_usb_write_mode_fd and its call in device probe
    routine. Fixed indentation.
  can: ems_usb: In ems_usb_start_xmit send only bytes with valid content
    to interface and not the complete buffer. Set first four bytes of
    buffer to 0. Wrapped long lines.
  can: ems_usb: Rearrange code in ems_usb_start_xmit to check with
    can_is_canfd_skb for CAN FD frames.
  can: ems_usb: Added code to handle CAN FD frames in ems_usb_start_xmit
  can: ems_usb: In CAN error handling routine checking which CAN
    controller type is issuing the error
  can: ems_usb: Added error handling part for CPC-USB/FD. Get some
    structures packed
  can: ems_usb: Made another struct packed. Enable CPC-USB/FD by adding
    it to the drivers device table

 drivers/net/can/usb/ems_usb.c | 860 +++++++++++++++++++++++++++-------
 1 file changed, 681 insertions(+), 179 deletions(-)

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
