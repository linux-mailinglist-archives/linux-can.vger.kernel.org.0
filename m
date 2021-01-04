Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8779F2E9537
	for <lists+linux-can@lfdr.de>; Mon,  4 Jan 2021 13:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhADMpw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Jan 2021 07:45:52 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:31489 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbhADMpv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Jan 2021 07:45:51 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210104124508epoutp037e18f4adaecb45e0e2b81eac254862cb~XCBwqz-4P0927309273epoutp03i
        for <linux-can@vger.kernel.org>; Mon,  4 Jan 2021 12:45:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210104124508epoutp037e18f4adaecb45e0e2b81eac254862cb~XCBwqz-4P0927309273epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609764308;
        bh=x6b3KVLk+Im71pnL1VPiZrNgTpY9lC8K9HNo23bglHw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=h5ma4OlTgrCmdAJ6jn0aA3Uw/7ICFxcD4hv+nSWN58Srv3LyfONQZ4zIgRwgA1JMJ
         ztAMOnU457KIQH0qibeo6GsCS4Ik7sPFpUHl7fZkk8p2Qi6r/l/G/Xie01fVxQnO1X
         nyTrMEPCQBQiCREr/1lljwSwELejN6fOBqc4U0vU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210104124508epcas5p1e3f4ae02e5d82f79615755bc55c0a393~XCBwF2ibW1495714957epcas5p1a;
        Mon,  4 Jan 2021 12:45:08 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.81.15682.4DD03FF5; Mon,  4 Jan 2021 21:45:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210104122607epcas5p3d63c769007bad3cfe00ff0fce99e082c~XBxJxgrDj1662216622epcas5p3u;
        Mon,  4 Jan 2021 12:26:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210104122607epsmtrp259fb06ed6e0f9e65f432d56d678917f4~XBxJw0sP21099410994epsmtrp2O;
        Mon,  4 Jan 2021 12:26:07 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-87-5ff30dd4a7e9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.2F.13470.F5903FF5; Mon,  4 Jan 2021 21:26:07 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210104122606epsmtip1311e1a983de8d8c4ac2ecb62f5e948b2~XBxIpFs3A3129731297epsmtip1M;
        Mon,  4 Jan 2021 12:26:06 +0000 (GMT)
From:   Sriram Dash <sriram.dash@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-can@vger.kernel.org, mkl@pengutronix.de, dmurphy@ti.com,
        pankj.sharma@samsung.com, pankaj.dubey@samsung.com,
        Sriram Dash <sriram.dash@samsung.com>
Subject: [PATCH] MAINTAINERS: Update MCAN MMIO device driver  maintainer
Date:   Mon,  4 Jan 2021 18:01:34 +0530
Message-Id: <20210104123134.16930-1-sriram.dash@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCmpu4V3s/xBrtPslt0n97CarHq+1Rm
        i8u75rBZrF80hcVi0dYv7BbLu+4zW9xYz+7A7tH/18Cjb8sqRo/jN7YzeXzeJBfAEsVlk5Ka
        k1mWWqRvl8CVMfFYL1PBBtaKZ3PPMDcw7mfpYuTgkBAwkdg3w6qLkYtDSGA3o8Si0z9YIZxP
        jBLPjl9ggXC+MUq8+PIJKMMJ1nH2fgM7RGIvo8SOzbOhWlqYJF5Ob2MDqWIT0JbY/OQiM4gt
        IqAgsbn3GVgRs8ACRonfW1aDFQkLeEh8av/MBGKzCKhKbDg8nQnkKF4BG4k/fyQgtslLrN5w
        gBmkV0JgEbvE4WmXoc5wkbj+7RgLhC0s8er4FnYIW0ri87u9bBB2tsTlvufMEHaJxIxXC6Hq
        7SUOXJkDDgBmAU2J9bv0IcKyElNPrQM7h1mAT6L39xMmiDivxI55MLaqxKvbm6FWSUscWHsa
        Ku4h8f3OP7DxQgKxEr8/HGScwCg7C2HDAkbGVYySqQXFuempxaYFhnmp5XrFibnFpXnpesn5
        uZsYwbGu5bmD8e6DD3qHGJk4GA8xSnAwK4nwVlz4EC/Em5JYWZValB9fVJqTWnyIUZqDRUmc
        d4fBg3ghgfTEktTs1NSC1CKYLBMHp1QD07LOIkdLW4c7+3WV7snvrQ05fDyj9ehThXfOaauX
        /3Lo8P+i7iZ9b9/+avOS3+uOXw3ZosBxYuvPsC1y/l2ffFii7FTCX9tNtpTxlE/WvLrWzS30
        ZkLrrr+99yZuWjt7lc6KH3mBB0L/ORrVHa2tk5B587zzxPZTLHMyxE9c2NVtpbTbcqqxSlb9
        t8V8Hsvu/vzc+Kk750GoHcv3hfs9ylYtnGmdI7RVeqEFD7/2jujuGw+Di63uFAi8FTG53iNY
        xJKX+zzX2vnSkcsKl8/0qngrbOifItO5Uc/V7cfbizP8+meLGeyXaIqRDVnMpbbNtS/Z3OlY
        c0FWxtt1X99e21JUtuDbjKTu91+1bzR6KbEUZyQaajEXFScCAANASXFkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGJMWRmVeSWpSXmKPExsWy7bCSnG485+d4g+4jUhbdp7ewWqz6PpXZ
        4vKuOWwW6xdNYbFYtPULu8XyrvvMFjfWszuwe/T/NfDo27KK0eP4je1MHp83yQWwRHHZpKTm
        ZJalFunbJXBlTDzWy1SwgbXi2dwzzA2M+1m6GDk5JARMJM7eb2DvYuTiEBLYzShxd9J7oAQH
        UEJa4uddXYgaYYmV/55D1TQxScxYu5wZJMEmoC2x+clFMFtEQEFic+8zVhCbWWAZo8TK//Yg
        trCAh8Sn9s9MIDaLgKrEhsPTmUDm8wrYSPz5IwExX15i9YYDzBMYeRYwMqxilEwtKM5Nzy02
        LDDMSy3XK07MLS7NS9dLzs/dxAgOGi3NHYzbV33QO8TIxMF4iFGCg1lJhLfiwod4Id6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpimr2SUa1yoLNYma3r5
        v3nSD5Gzqydv1MyRPdOzuyZ0o7h0tKecxZI7F+wsbrd4T1dZvSUgc793kV32PZffrQpyW/8w
        nm6qOapy8HL8vmMBk0VtVpYnf75vrHU5bpM2q/PGE97nBNY7mckYr8zUSktdcv3xqZVaFo2n
        DQ/u4z4yd0fwyrPlS2OqF3nw1kT37zQyjJQqvDJb9naX2ucr1zp5lq3Kq59oMMOnMMN7nVW6
        GVO8pZ5m0Vq3E2+c+OUrT1+3KTGZXCe94voZZSdFHY1QHvYrIuFzN03kt8/4cpRzp+IHxTdt
        O7RFv8dOe7VfJMiHO6/g6KWZ508KxjFk5V27tyE075zw02t57kE/7ZRYijMSDbWYi4oTAfst
        azeJAgAA
X-CMS-MailID: 20210104122607epcas5p3d63c769007bad3cfe00ff0fce99e082c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210104122607epcas5p3d63c769007bad3cfe00ff0fce99e082c
References: <CGME20210104122607epcas5p3d63c769007bad3cfe00ff0fce99e082c@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Update Pankaj Sharma as maintainer for mcan mmio device driver as I
will be moving to a different role.

Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f7..45cea57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10847,7 +10847,7 @@ F:	drivers/media/radio/radio-maxiradio*
 
 MCAN MMIO DEVICE DRIVER
 M:	Dan Murphy <dmurphy@ti.com>
-M:	Sriram Dash <sriram.dash@samsung.com>
+M:	Pankaj Sharma <pankj.sharma@samsung.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
-- 
2.7.4

