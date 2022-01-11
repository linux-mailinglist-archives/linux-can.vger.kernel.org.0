Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAE048A447
	for <lists+linux-can@lfdr.de>; Tue, 11 Jan 2022 01:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbiAKAXD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Jan 2022 19:23:03 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:37961 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbiAKAXC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Jan 2022 19:23:02 -0500
Received: from localhost.localdomain ([81.154.153.55]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.99]) with ESMTPSA (Nemesis) id
 1MGiAs-1nC58z3qZ0-00Dswl; Tue, 11 Jan 2022 01:23:00 +0100
From:   Phil Greenland <phil@quantulum.co.uk>
To:     mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, Phil Greenland <phil@quantulum.co.uk>
Subject: [PATCH 0/3] can: mcp251xfd: Transceiver suspend, power management and wake-on-can
Date:   Tue, 11 Jan 2022 00:21:07 +0000
Message-Id: <20220111002109.927308-1-phil@quantulum.co.uk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zWqJdu5EG+RFlmN94+r+bSGeUPSSb7h4iOSm5IA4MS1ApwXPcaQ
 k9Ckf5m1cJT2VhNsO380TJ63at5g81TlfLK4PjTCnb4gizUBEog6CTQnquTCwRYosHnzh1N
 yGeU7XxqhBPS8dgBA85KvrHdV6Yo5CdDHrGJHoamkvARs4LoYcJ7ucZI0f4B0dBeWBRP3/6
 ciQrpW+Bdljc/CY0EyVzQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qjbIyALHtGM=:dgqXAgofWzYaCb6us2jq7w
 gSYb+ZzNf5o7UAmny2VWZn3aREq8qjhByQWngB0uewQMtV40nFcrBMEA1vefBszrCKidijlMV
 QmsUlTnyAgQyl/hRVgziRN2UzS7IBeGjHtShWTitvBBEeGwXF9U4FZcXx716PF+3qSUQz9iVn
 W644IDCTyDVp0vZMuBybgwsYO7tj8R9me+m+EaIO/LLZDHAcZ4tX/cwkyVJyRhOUYJAY72bjh
 0pH5yLyLWsxCzpa4yL8v4t8kpX0meChUSfSXWDCMaSYvmr2MsluA5JgnYLS6zJbHRmCurQf7o
 0lNDZQv2AmM7AAmHKJUhX6VrMjIbym0EVBsccB5gdYxhyY5Iq08DSJ3n6w4hjhg4EomisOdCj
 dm7b0T5RamOwK1GnRzPfnijVNGNTKG7qMqE8AOVLWoaGVRDmPivPbMP1vwtU5NwgFJqturkj6
 6KFj+qqpo69yxT82gO9GZzzriMAGmj9r9kT/P751QgRL0IBZgttHlqJBAk0gIEbnzK4Ah3xqF
 ZNOA81yh90b2oNSKSXaVH1qbUZ+X7NY7ImG9D2EZbiimcj9uBJ7d5TY7WlzJM7w3DX+ZLXjFH
 Wi71lgyXFrBD5YHY7X6vNScjsbv7i3a8RPDmp8fGgaqas/GZznoDkrQGMx3gHux2yx4Vpovz7
 Li3aitaG2xivjblpbf5XTLGj6JHBmW2BaPAoqlgEvWdBN85YhnWkH/gEoIhEhBtJau/M=
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

Here's my first go at a patch series adding transceiver control, power management and wake-on-can  support to the mcp251xfd driver.

Few rough edges to sort out, testing and confidence explained with each patch.

First go at using git sendmail too, so hope you get all of these.

Regards,

Phil

Phil Greenland (3):
  can: mcp251xfd: automatic transceiver standby control
  can: mcp251xfd: suspend and resume handlers
  can: mcp251xfd: wake-on-can

 .../net/can/spi/mcp251xfd/mcp251xfd-core.c    | 198 +++++++++++++++---
 .../can/spi/mcp251xfd/mcp251xfd-timestamp.c   |   6 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h     |   3 +
 3 files changed, 172 insertions(+), 35 deletions(-)

-- 
2.25.1

