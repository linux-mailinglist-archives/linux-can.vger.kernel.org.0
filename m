Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ECC47E6A7
	for <lists+linux-can@lfdr.de>; Thu, 23 Dec 2021 18:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349414AbhLWRLz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Thu, 23 Dec 2021 12:11:55 -0500
Received: from projects.drlauer-research.com ([88.99.0.140]:40312 "EHLO
        projects.drlauer-research.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349401AbhLWRLz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Dec 2021 12:11:55 -0500
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Dec 2021 12:11:55 EST
Received: from smtpclient.apple (b2b-109-90-164-198.unitymedia.biz [109.90.164.198])
        by projects.drlauer-research.com (Postfix) with ESMTPSA id 3E6D24802B1
        for <linux-can@vger.kernel.org>; Thu, 23 Dec 2021 18:05:19 +0100 (CET)
From:   "Dr. Michael Lauer" <mickey@vanille.de>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Dual CAN(FD) board w/ MACP251xfd
Message-Id: <A271F63C-FA42-4864-A621-C5195A35EC83@vanille.de>
Date:   Thu, 23 Dec 2021 18:05:18 +0100
To:     linux-can@vger.kernel.org
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        projects.drlauer-research.com
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Please forgive me, if this is not the proper list for this message,
but as far as I know the developer of the mcp251xfd driver is also reading here.

I recently acquired a Dual CAN FD HAT (https://www.waveshare.com/wiki/2-CH_CAN_FD_HAT)
to run on my Raspberry PI 4. Currently, this is using kernel 5.15.11, but for some
reason, only one of the two ports are recognized. Instead of detecting the 2nd port,
it seems to just _renames_ the port. Here is the relevant kernel log:

[    5.495409] CAN device driver interface
[    5.552660] spi_master spi1: will run message pump with realtime priority
[    5.559885] mcp251xfd spi1.0 (unnamed net_device) (uninitialized): Detected MCP2518FD, but firmware specifies a MCP2517FD. Fixing up.
[    5.580908] vc4-drm gpu: bound fe400000.hvs (ops vc4_hvs_ops [vc4])
[    5.585428] Registered IR keymap rc-cec
[    5.599117] rc rc0: vc4 as /devices/platform/soc/fef00700.hdmi/rc/rc0
[    5.601698] mcp251xfd spi1.0 can0: MCP2518FD rev0.0 (-RX_INT -MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:40.00MHz m:20.00MHz r:17.00MHz e:16.66MHz) successfully initialized.
[    5.633622] input: vc4 as /devices/platform/soc/fef00700.hdmi/rc/rc0/input3
[    5.677448] vc4-drm gpu: bound fef00700.hdmi (ops vc4_hdmi_ops [vc4])
[    5.697059] Registered IR keymap rc-cec
[    5.698682] mcp251xfd spi1.0 can1: renamed from can0

The activated overlays in config.txt are

dtoverlay=2xMCP2517FD
dtoverlay=2xMCP2518FD-spi0

Perhaps anyone of you has a similar config and can tell me what could be wrong?

Best,

Mickey.

