Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8706810F654
	for <lists+linux-can@lfdr.de>; Tue,  3 Dec 2019 05:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfLCEfi (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 Dec 2019 23:35:38 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:36512 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfLCEfi (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 Dec 2019 23:35:38 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191203043534epoutp04087781afe05fb934b13a7aeb7fae0a2f~cwmsGacPr2735727357epoutp04c
        for <linux-can@vger.kernel.org>; Tue,  3 Dec 2019 04:35:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191203043534epoutp04087781afe05fb934b13a7aeb7fae0a2f~cwmsGacPr2735727357epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1575347734;
        bh=P9rxL3OL4SEg0KsZyLRZeF48h8yL9UuF4kxFDbXNgnA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=GY2QtC3IXCVaDQucCO0ryWIl5qiRI0YULNDevAaMfkq+HQJA0UnIfp6eM2BHdsXbK
         3lv705s7juQk+CR8RCnDDrW7tSHd926F5/v0tuFx6qWFl9OxX1yXh88crGCAPb6Tym
         0rJOoLtlW5O/6D18B3cLfQrvdhkAwuk6HAld/r4s=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20191203043533epcas5p1c22e61b0256413395a992db05ed9a378~cwmrbCSDT1744717447epcas5p1h;
        Tue,  3 Dec 2019 04:35:33 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.05.19629.516E5ED5; Tue,  3 Dec 2019 13:35:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20191203043533epcas5p19bfc21e2b03db7f27c6d84cda6824d27~cwmrFfHUG1745117451epcas5p1L;
        Tue,  3 Dec 2019 04:35:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191203043533epsmtrp26c955d363851275865794cb3f9fd7069~cwmrEpCCV2179821798epsmtrp2c;
        Tue,  3 Dec 2019 04:35:33 +0000 (GMT)
X-AuditID: b6c32a4b-32dff70000014cad-de-5de5e615dc45
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.3E.10238.516E5ED5; Tue,  3 Dec 2019 13:35:33 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191203043531epsmtip112ec90d213a7f631732fdf252fca5a7b~cwmpKRZf72615026150epsmtip1W;
        Tue,  3 Dec 2019 04:35:31 +0000 (GMT)
From:   Sriram Dash <sriram.dash@samsung.com>
To:     linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        linux-can@vger.kernel.org, wg@grandegger.com
Cc:     mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, robh@kernel.org, dmurphy@ti.com,
        rcsekar@samsung.com, pankaj.dubey@samsung.com,
        pankj.sharma@samsung.com, Sriram Dash <sriram.dash@samsung.com>
Subject: [PATCH] MAINTAINERS: add myself as maintainer of MCAN MMIO device
 driver
Date:   Tue,  3 Dec 2019 09:59:09 +0530
Message-Id: <1575347349-32689-1-git-send-email-sriram.dash@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZdlhTU1f02dNYg6bzBhZzzrewWHSf3sJq
        0bx4PZvFqu9TmS0u75rDZvH+UyeTxfpFU1gsFm39wm6xvOs+s8WsCztYLf7v2cFucWM9u8XS
        eztZHXg9tqy8yeTx8dJtRo9NqzrZPPbPXcPu0f/XwKNvyypGj+M3tjN5fN4kF8ARxWWTkpqT
        WZZapG+XwJXxYddV9oIG9op9J16yNDD+YO1i5OSQEDCR+PL9E3MXIxeHkMBuRokjCxcxQjif
        GCV+TJvDBOF8Y5S4cGwLI0zLz8NN7CC2kMBeRolzr/khilqYJC7/fgBWxCagLbH5yUWguRwc
        IgIpEvO+uIDUMAs8Y5Q4teQiE0iNsECwxOVjO8HqWQRUJR78mAtm8wq4Sxx51csMsUxO4ua5
        TrD7JASOsEn82L0R6nAXiZ03/kBdJCzx6vgWdghbSuLzu71sEHa2xOW+51CDSiRmvFrIAmHb
        Sxy4MocF5DhmAU2J9bv0QcLMAnwSvb+fMIGEJQR4JTrahCCqVSVe3d4MNV1a4sDa00wQtofE
        u3WXmCDhECvx6tAU9gmMMrMQhi5gZFzFKJlaUJybnlpsWmCcl1quV5yYW1yal66XnJ+7iRGc
        NLS8dzBuOudziFGAg1GJh/fAnyexQqyJZcWVuYcYJTiYlUR4t0k8jRXiTUmsrEotyo8vKs1J
        LT7EKM3BoiTOO4n1aoyQQHpiSWp2ampBahFMlomDU6qB0UHvQ0roRzmTnHdzTnysMWiLmtHc
        sumisDXP3P7Lez805di7WayMj068EJVpNSNk+su0Lxx9OcvP3u941ceaXCru+jZi4vSbG1LE
        /jjF7eetKtk8J+6p3ow/T+NSJNfVtp7oV7uyuLUghEMtcJq21+77C5wapHf5mj3o/R7QXjjx
        tKHzit0rlViKMxINtZiLihMB94sF2RYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnK7os6exBl96xC3mnG9hseg+vYXV
        onnxejaLVd+nMltc3jWHzeL9p04mi/WLprBYLNr6hd1iedd9ZotZF3awWvzfs4Pd4sZ6doul
        93ayOvB6bFl5k8nj46XbjB6bVnWyeeyfu4bdo/+vgUffllWMHsdvbGfy+LxJLoAjissmJTUn
        syy1SN8ugSvjw66r7AUN7BX7TrxkaWD8wdrFyMkhIWAi8fNwEzuILSSwm1HiyETxLkYOoLi0
        xM+7uhAlwhIr/z0HKuECKmlikvjb1sMGkmAT0JbY/OQiM0i9iECGxLX3+iA1zAIfGCVO3loI
        ViMsEChx4dJrJhCbRUBV4sGPuYwgNq+Au8SRV73MEAvkJG6e62SewMizgJFhFaNkakFxbnpu
        sWGBYV5quV5xYm5xaV66XnJ+7iZGcGBqae5gvLwk/hCjAAejEg/vgT9PYoVYE8uKK3MPMUpw
        MCuJ8G6TeBorxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdp3rFIIYH0xJLU7NTUgtQimCwTB6dU
        A+NkwduPEg8yRGlkcYpPebHUa/V+JS49Fy3/n32Nfz+KSBtH/BZ041z9Vf1D36YNHS/NtY3t
        ftWq3fVLXOmpXmzbOnn7ffOLXz5UvixeMbfCcnfFnQbZJGYdv+W3feMkd38ODJyqpd3/UyHo
        +Y1znB/fX7a067J5/UAvMYPNyp8l47VfIeP640osxRmJhlrMRcWJAMm9yZtIAgAA
X-CMS-MailID: 20191203043533epcas5p19bfc21e2b03db7f27c6d84cda6824d27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191203043533epcas5p19bfc21e2b03db7f27c6d84cda6824d27
References: <CGME20191203043533epcas5p19bfc21e2b03db7f27c6d84cda6824d27@epcas5p1.samsung.com>
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Since we are actively working on MMIO MCAN device driver,
as discussed with Marc, I am adding myself as a maintainer.

Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc36fe5..64ecf11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10082,6 +10082,15 @@ W:	https://linuxtv.org
 S:	Maintained
 F:	drivers/media/radio/radio-maxiradio*
 
+MCAN MMIO DEVICE DRIVER
+M:	Sriram Dash <sriram.dash@samsung.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/m_can.txt
+F:	drivers/net/can/m_can/m_can_platform.c
+F:	drivers/net/can/m_can/m_can.c
+F:	drivers/net/can/m_can/m_can.h
+
 MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
-- 
2.7.4

