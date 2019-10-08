Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B43CF452
	for <lists+linux-can@lfdr.de>; Tue,  8 Oct 2019 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfJHHwb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Oct 2019 03:52:31 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52367 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbfJHHwb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2019 03:52:31 -0400
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iHkIH-0005p5-K8; Tue, 08 Oct 2019 09:52:29 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
Subject: [PATCH v3 0/4] can: c_can/rx-offload
Date:   Tue,  8 Oct 2019 09:52:22 +0200
Message-Id: <20191008075226.12544-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

taking up Kurt's work. I've cleaned up the rx-offload and c_can patches
a bit. Untested as I don't have any hardware at hand.

I just looked at the c_can and d_can datasheets. Am I right, that both
cores don't have a timestamp register to indicate when a CAN frame has
been received?

regards,
Marc

Changes since v2:
- added can_rx_offload_add_manual()
- cleaned up c_can_isr()
  - remove unneeded dev_id cast
  - rename intreg -> reg_int to match the rest of the code
  - use { } on both sides of if else
  - fix return value
- use can_rx_offload_add_manual() instead of can_rx_offload_add_fifo()
- move can_rx_offload_add_manual()/can_rx_offload_del() to
  register_c_can_dev()/unregister_c_can_dev()
- move include rx-offload.h to c_can.h



