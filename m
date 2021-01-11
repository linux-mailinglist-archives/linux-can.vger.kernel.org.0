Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4A2F180F
	for <lists+linux-can@lfdr.de>; Mon, 11 Jan 2021 15:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbhAKOXb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Jan 2021 09:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733111AbhAKOXa (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Jan 2021 09:23:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67057C0617AB
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 06:22:12 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kyy5C-0007cE-RJ
        for linux-can@vger.kernel.org; Mon, 11 Jan 2021 15:22:10 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 86CF55C0F3B
        for <linux-can@vger.kernel.org>; Mon, 11 Jan 2021 14:19:32 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 34E245C0F35;
        Mon, 11 Jan 2021 14:19:32 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ba511fa4;
        Mon, 11 Jan 2021 14:19:31 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [net-next v3 00/15] can: dev: cleanup and add CAN frame length handling support
Date:   Mon, 11 Jan 2021 15:19:15 +0100
Message-Id: <20210111141930.693847-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
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

this series splits the CAN driver related infrastructure into several files
(patches 1...6), followed by some cleanup patches (7, 8), and support for CAN
frame length handling (9...14). Totally unrelated is patch 15, which add
software tx timestamping.

I took the path and put the calculated frame length into the struct
can_skb_priv and extended the can_get_echo_skb() and
can_rx_offload_get_echo_skb() to optionally return the CAN frame length.

Marc

---

changes since v2:
- 05: add missing skb.o to Makefile (this time for real)
- 10: added S-o-b and A-b
- 15: moved skb_tx_timestamp()

changes since v1:
- 04: changed copyright
- 05: add missing skb.o to Makefile
- 06: add missing netlink.o to Makefile
- 10: fix comment for CANFD_FRAME_LEN_MAX
- 12: new
- 15: new



