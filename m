Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10F0CF05AA
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2019 20:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390930AbfKETIp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 14:08:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34725 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390812AbfKETIp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 14:08:45 -0500
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1iS4C3-0001dw-5a
        for linux-can@vger.kernel.org; Tue, 05 Nov 2019 20:08:43 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Subject: 
Date:   Tue,  5 Nov 2019 20:08:36 +0100
Message-Id: <20191105190840.20410-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.24.0.rc1
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

picking up Timo's patches.

For convenience this series applies to v5.3, but the
"mcp251x_restart_work_handler fix" is already included in a pull
request.

changes since v3:
- split mcp251x_restart_work_handler fix from "Correctly handle
  restart-ms"
- split "mcp251x_write_2regs" from "Only reset hardware as required"
- reworked GPIO support:
  - use FIELD_GET/FIELD_PREP
  - get rid of most ifdefs, provide no-ops
  - add common prefix to new defines

Please test if the gpios support still works.

Marc


