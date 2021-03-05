Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9E432EBCA
	for <lists+linux-can@lfdr.de>; Fri,  5 Mar 2021 14:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCENCd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Mar 2021 08:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhCENCR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Mar 2021 08:02:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C8FC061574
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 05:02:17 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lIA5v-0006FE-Jg
        for linux-can@vger.kernel.org; Fri, 05 Mar 2021 14:02:15 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id AA1C25EE835
        for <linux-can@vger.kernel.org>; Fri,  5 Mar 2021 13:02:13 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4D26D5EE82D;
        Fri,  5 Mar 2021 13:02:13 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5872892e;
        Fri, 5 Mar 2021 13:02:12 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dario Binacchi <dariobin@libero.it>
Subject: [PATCH v6 0/12] can: c_can: add support to 64 message objects
Date:   Fri,  5 Mar 2021 14:01:59 +0100
Message-Id: <20210305130211.2860914-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

this series picks up Dario Binacchi's patches and adds some cleanup
patches in front.

The D_CAN controller supports up to 128 messages. Until now the driver
only managed 32 messages although Sitara processors and DRA7 SOC can
handle 64.

The series was tested on a beaglebone board.

Note:
I have not changed the type of tx_field (belonging to the c_can_priv
structure) to atomic64_t because I think the atomic_t type has size
of at least 32 bits on x86 and arm, which is enough to handle 64
messages.
http://marc.info/?l=linux-can&m=139746476821294&w=2 reports the results
of tests performed just on x86 and arm architectures.

Changes in v6:
- make patches
  [PATCH v5 0/11] can: c_can: add support to 64 message objects
  [PATCH v5 0/11] can: c_can: add support to 64 message objects
  separate again, they have been squashed accidentally 

Changes in v5:
- Add cleanup patches
- alloc_c_can_dev(): make use of struct_size()

Changes in v4:
- Restore IF_RX interface.
- Add a comment to clarify why IF_RX interface is used instead of IF_TX.
- Use GENMASK() for setting msg_obj_rx_mask.
- Use BIT() for setting single bits and GENMASK() for setting masks.

Changes in v3:
- Use unsigned int instead of int as type of the msg_obj_* fields
  in the c_can_priv structure.
- Replace (u64)1 with 1UL in msg_obj_rx_mask setting.
- Use unsigned int instead of int as type of the msg_obj_num field
  in c_can_driver_data and c_can_pci_data structures.

Changes in v2:
- Fix compiling error reported by kernel test robot.
- Add Reported-by tag.
- Pass larger size to alloc_candev() routine to avoid an additional
  memory allocation/deallocation.
- Add message objects number to PCI driver data.


