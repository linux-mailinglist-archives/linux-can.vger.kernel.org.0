Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF8E927A7
	for <lists+linux-can@lfdr.de>; Mon, 19 Aug 2019 16:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHSOzG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 19 Aug 2019 10:55:06 -0400
Received: from mx.krause.de ([88.79.216.98]:35246 "EHLO mx.krause.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfHSOzG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 19 Aug 2019 10:55:06 -0400
X-Greylist: delayed 322 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Aug 2019 10:55:05 EDT
Received: from [172.20.10.125] (port=26583 helo=mail.horstmanngroup.de)
        by mx.krause.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <t.schluessler@krause.de>)
        id 1hziyY-00039e-2C; Mon, 19 Aug 2019 16:49:38 +0200
Received: from HG-SRV-053.HG.local (172.20.10.125) by HG-SRV-053.HG.local
 (172.20.10.125) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 19 Aug
 2019 16:49:38 +0200
Received: from HG-SRV-053.HG.local ([::1]) by HG-SRV-053.HG.local ([::1]) with
 mapi id 15.00.1367.000; Mon, 19 Aug 2019 16:49:38 +0200
X-CTCH-RefID: str=0001.0A0C0204.5D5AB702.00A5,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   =?iso-8859-1?Q?Schl=FC=DFler=2C_Timo?= <t.schluessler@krause.de>
To:     "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Add GPIO support for mcp251x driver
Thread-Topic: Add GPIO support for mcp251x driver
Thread-Index: AdVWmfxSduWoGL3+RY65gXm3I2iEOA==
Date:   Mon, 19 Aug 2019 14:49:38 +0000
Message-ID: <73336c447238499985c2ca6df1075a52@HG-SRV-053.HG.local>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.30.30]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

what do you think would be the right way to control the GPIOs of the MCP251x/25625 from userland? Is this something that should be done using a SIOCDEVPRIVATE ioctl? Where should this get documented?
I could imagine something like this, but am not sure whether this is the right way to go.

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 12358f0..2a14d5d 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -77,6 +77,8 @@


 /* MPC251x registers */
+#define BFPCTRL                        0x0c
+#define TXRTSCTRL              0x0d
 #define CANSTAT              0x0e
 #define CANCTRL              0x0f
 #  define CANCTRL_REQOP_MASK       0xe0
@@ -971,11 +973,48 @@ static int mcp251x_open(struct net_device *net)
        return ret;
 }

+static int mcp251x_gpio_ctrl(struct net_device *net, struct ifreq *rq)
+{
+       struct mcp251x_priv *priv = netdev_priv(net);
+       struct spi_device *spi = priv->spi;
+       struct mcp251x_gpio_ctrl ctrl;
+       bool copy_back = false;
+
+       if (copy_from_user(&ctrl, rq->ifr_data, sizeof(ctrl)))
+               return -EFAULT;
+
+       mutex_lock(&priv->mcp_lock);
+       if (ctrl.txnrts) { // only do SPI transfer if necessary
+               ctrl.txnrts = mcp251x_read_reg(spi, TXRTSCTRL);
+               copy_back = true;
+       }
+       if (ctrl.rxnbf_mask) // only do SPI transfer if necessary
+               mcp251x_write_bits(spi, BFPCTRL, ctrl.rxnbf_mask, ctrl.rxnbf);
+       mutex_unlock(&priv->mcp_lock);
+
+       if (copy_back &&
+           copy_to_user(rq->ifr_data, &ctrl, sizeof(struct mcp251x_gpio_ctrl)))
+               return -EFAULT;
+
+       return 0;
+}
+
+static int mcp251x_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
+{
+       switch (cmd) {
+       case SIOCGPIOCTRL:
+               return mcp251x_gpio_ctrl(net, rq);
+       default:
+               return -EOPNOTSUPP;
+       }
+}
+
 static const struct net_device_ops mcp251x_netdev_ops = {
        .ndo_open = mcp251x_open,
        .ndo_stop = mcp251x_stop,
        .ndo_start_xmit = mcp251x_hard_start_xmit,
        .ndo_change_mtu = can_change_mtu,
+       .ndo_do_ioctl = mcp251x_ioctl,
 };

 static const struct of_device_id mcp251x_of_match[] = {
diff --git a/include/uapi/linux/can/mcp251x.h b/include/uapi/linux/can/mcp251x.h
index e69de29..9528ef3 100755
--- a/include/uapi/linux/can/mcp251x.h
+++ b/include/uapi/linux/can/mcp251x.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/*
+ * linux/can/mcp251x.h
+ *
+ * Definitions for MCP251x GPIO control
+ */
+
+#ifndef _UAPI_CAN_MCP251X_H
+#define _UAPI_CAN_MCP251X_H
+
+#define SIOCGPIOCTRL SIOCDEVPRIVATE
+
+#define MCP251X_RX0BF_MASK 0x15
+#define MCP251X_RX0BF_LOW 0x04
+#define MCP251X_RX0BF_HIGH 0x14
+#define MCP251X_RX0BF_BUFFER_FULL 0x05
+#define MCP251X_RX0BF_DISABLED 0x0
+
+#define MCP251X_RX1BF_MASK 0x2A
+#define MCP251X_RX1BF_LOW 0x08
+#define MCP251X_RX1BF_HIGH 0x28
+#define MCP251X_RX1BF_BUFFER_FULL 0x0A
+#define MCP251X_RX1BF_DISABLED 0x0
+
+#define MCP251X_TX0RTS_SET 0x08
+#define MCP251X_TX1RTS_SET 0x10
+#define MCP251X_TX2RTS_SET 0x20
+
+struct mcp251x_gpio_ctrl {
+       __u8 txnrts;
+
+       __u8 rxnbf;
+       __u8 rxnbf_mask;
+};
+
+#endif /* !_UAPI_CAN_MCP251X_H */

Also would you prefer using the workqueue instead of accesing the SPI bus directly in the ioctl call?

The usercode would look like this to set RX0BF high:

#include <linux/can/mcp251x.h>
...
struct mcp251x_gpio_ctrl ctrl;
ctrl.txnrts = 0; // don't readout inputs
ctrl.rxnbf = MCP251X_RX0BF_HIGH;
ctrl.rxnbf_mask = MCP251X_RX0BF_MASK;
ifr.ifr_data = &ctrl;
ioctl(sock, SIOCGPIOCTRL, &ifr);

Thanks for your comments.

Regards
Timo Schlüßler
