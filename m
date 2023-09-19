Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551C67A646E
	for <lists+linux-can@lfdr.de>; Tue, 19 Sep 2023 15:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjISNJO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 19 Sep 2023 09:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjISNJO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 19 Sep 2023 09:09:14 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11E3EC
        for <linux-can@vger.kernel.org>; Tue, 19 Sep 2023 06:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=m/LMaWDEvPSMBCAalvZtY9ITvKbsNl0u/KmaP2AoFJw=; b=UxsfBJZE91fHRewSa2vvtbM7kY
        73/eE1j/CxK9IYZzA0sZlFsc6FzFCNixbIXBamJ5sOhZj4Erm+ww2HzRAEgd+/a6LicCOAyqwJC7C
        8zodclOIwCJkL0yMP6AlMNN1tclVW/v6KEbK8KXSNSErV5TSH2g2yE2beX9eDCfXFrS+/CpEPBXSJ
        3/MkaeDEDBDkVH59bQ+bJEve6RiAA1OwUGHdGlRgdoHpUIlTxnIDviYxzo9VsVroKfK5lTqfSTTkW
        ckzWg9r2NM46mJa5fZscAdqHs3mC12HVY/ktp5hwkmYz/fL4ApSaZMo0nHy13CgQ0YyU+lK1m69gp
        IZX5PIqg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qiaTM-0009qx-Kr; Tue, 19 Sep 2023 15:09:00 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qiaTM-000CO1-8g; Tue, 19 Sep 2023 15:09:00 +0200
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dong Aisheng <b29396@freescale.com>
Subject: [PATCH] can: m_can: don't enable transceiver when probing
Date:   Tue, 19 Sep 2023 15:08:56 +0200
Message-ID: <20230919130856.3839781-1-martin@geanix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27036/Tue Sep 19 09:42:31 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The m_can driver sets and clears the CCCR.INIT bit during probe (both
when testing the NON-ISO bit, and when configuring the chip). After
clearing the CCCR.INIT bit, the transceiver enters normal mode, where it
affects the CAN bus (i.e. ACKs frames). This can cause trouble when the
m_can node is only used for monitoring the bus, as one cannot setup
listen-only mode before the device is probed.

Rework the probe flow, so that the CCCR.INIT bit is only cleared when
upping the device. First, the tcan4x5x driver is changed to stay in
standby mode during/after probe. This in turn requires changes when
setting bits in the CCCR register, as its CSR and CSA bits are always
high in standby mode.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 drivers/net/can/m_can/m_can.c         | 156 +++++++++++++++-----------
 drivers/net/can/m_can/tcan4x5x-core.c |  14 ++-
 2 files changed, 104 insertions(+), 66 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16ecc11c7f62..a99da87b5b93 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -382,38 +382,70 @@ static inline bool m_can_tx_fifo_full(struct m_can_classdev *cdev)
 	return _m_can_tx_fifo_full(m_can_read(cdev, M_CAN_TXFQS));
 }
 
-static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
+static int m_can_cccr_set_wait(struct m_can_classdev *cdev, u32 mask, u32 val)
 {
-	u32 cccr = m_can_read(cdev, M_CAN_CCCR);
-	u32 timeout = 10;
-	u32 val = 0;
-
-	/* Clear the Clock stop request if it was set */
-	if (cccr & CCCR_CSR)
-		cccr &= ~CCCR_CSR;
-
-	if (enable) {
-		/* enable m_can configuration */
-		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT);
-		udelay(5);
-		/* CCCR.CCE can only be set/reset while CCCR.INIT = '1' */
-		m_can_write(cdev, M_CAN_CCCR, cccr | CCCR_INIT | CCCR_CCE);
-	} else {
-		m_can_write(cdev, M_CAN_CCCR, cccr & ~(CCCR_INIT | CCCR_CCE));
-	}
+	u32 val_before = m_can_read(cdev, M_CAN_CCCR);
+	u32 val_after = (val_before & ~mask) | val;
+	size_t tries = 5;
+
+	if (!(mask & CCCR_INIT) && !(val_before & CCCR_INIT))
+		dev_warn(cdev->dev,
+			 "trying to configure device when in normal mode. Expect failures\n");
+
+	/* The chip should be in standby mode when changing the CCCR register,
+	 * and some chips set the CSR and CSA bits when in standby. Furthermore,
+	 * the CSR and CSA bits should be written as zeros, even when they read
+	 * ones.
+	 */
+	val_after &= ~(CCCR_CSR | CCCR_CSA);
+
+	while (tries--) {
+		u32 val_read;
 
-	/* there's a delay for module initialization */
-	if (enable)
-		val = CCCR_INIT | CCCR_CCE;
-
-	while ((m_can_read(cdev, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE)) != val) {
-		if (timeout == 0) {
-			netdev_warn(cdev->net, "Failed to init module\n");
-			return;
-		}
-		timeout--;
-		udelay(1);
+		/* Write the desired value in each try, as setting some bits in
+		 * the CCCR register require other bits to be set first. E.g.
+		 * setting the NISO bit requires setting the CCE bit first.
+		 */
+		m_can_write(cdev, M_CAN_CCCR, val_after);
+
+		val_read = m_can_read(cdev, M_CAN_CCCR) & ~(CCCR_CSR | CCCR_CSA);
+
+		if (val_read == val_after)
+			return 0;
+
+		usleep_range(1, 5);
 	}
+
+	return -ETIMEDOUT;
+}
+
+static int m_can_config_enable(struct m_can_classdev *cdev)
+{
+	int ret;
+
+	/* CCCR_INIT must be set in order to set CCCR_CCE, but access to
+	 * configuration registers should only enabled when in standby mode,
+	 * where CCCR_INIT is always set.
+	 */
+	ret = m_can_cccr_set_wait(cdev, CCCR_CCE, CCCR_CCE);
+	if (ret)
+		netdev_err(cdev->net, "failed to enable configuration mode: %d\n", ret);
+
+	return ret;
+}
+
+static int m_can_config_disable(struct m_can_classdev *cdev)
+{
+	int ret;
+
+	/* Only clear CCCR_CCE, since CCCR_INIT cannot be cleared while in
+	 * standby mode
+	 */
+	ret = m_can_cccr_set_wait(cdev, CCCR_CCE, 0);
+	if (ret)
+		netdev_err(cdev->net, "failed to disable configuration registers: %d\n", ret);
+
+	return ret;
 }
 
 static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
@@ -1280,7 +1312,9 @@ static int m_can_chip_config(struct net_device *dev)
 			IR_TCF | IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N |
 			IR_RF0F | IR_RF0W);
 
-	m_can_config_endisable(cdev, true);
+	err = m_can_config_enable(cdev);
+	if (err)
+		return err;
 
 	/* RX Buffer/FIFO Element Size 64 bytes data field */
 	m_can_write(cdev, M_CAN_RXESC,
@@ -1395,7 +1429,9 @@ static int m_can_chip_config(struct net_device *dev)
 		    FIELD_PREP(TSCC_TCP_MASK, 0xf) |
 		    FIELD_PREP(TSCC_TSS_MASK, TSCC_TSS_INTERNAL));
 
-	m_can_config_endisable(cdev, false);
+	err = m_can_config_disable(cdev);
+	if (err)
+		return err;
 
 	if (cdev->ops->init)
 		cdev->ops->init(cdev);
@@ -1423,7 +1459,11 @@ static int m_can_start(struct net_device *dev)
 			      HRTIMER_MODE_REL_PINNED);
 	}
 
-	return 0;
+	ret = m_can_cccr_set_wait(cdev, CCCR_INIT, 0);
+	if (ret)
+		netdev_err(dev, "failed to enter normal mode: %d\n", ret);
+
+	return ret;
 }
 
 static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
@@ -1474,35 +1514,23 @@ static int m_can_check_core_release(struct m_can_classdev *cdev)
 /* Selectable Non ISO support only in version 3.2.x
  * This function checks if the bit is writable.
  */
-static bool m_can_niso_supported(struct m_can_classdev *cdev)
+static int m_can_niso_supported(struct m_can_classdev *cdev)
 {
-	u32 cccr_reg, cccr_poll = 0;
-	int niso_timeout = -ETIMEDOUT;
-	int i;
+	int niso_ret, ret;
 
-	m_can_config_endisable(cdev, true);
-	cccr_reg = m_can_read(cdev, M_CAN_CCCR);
-	cccr_reg |= CCCR_NISO;
-	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
+	/* First try to set the NISO bit (which requires the CCE bit too. */
+	if (m_can_cccr_set_wait(cdev, CCCR_NISO | CCCR_CCE,
+				CCCR_NISO | CCCR_CCE))
+		niso_ret = -EOPNOTSUPP;
 
-	for (i = 0; i <= 10; i++) {
-		cccr_poll = m_can_read(cdev, M_CAN_CCCR);
-		if (cccr_poll == cccr_reg) {
-			niso_timeout = 0;
-			break;
-		}
-
-		usleep_range(1, 5);
+	/* Then clear the two bits again. */
+	ret = m_can_cccr_set_wait(cdev, CCCR_NISO | CCCR_CCE, 0);
+	if (ret) {
+		dev_err(cdev->dev, "failed to revert the NON-ISO bit in CCCR: %d\n", ret);
+		return ret;
 	}
 
-	/* Clear NISO */
-	cccr_reg &= ~(CCCR_NISO);
-	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
-
-	m_can_config_endisable(cdev, false);
-
-	/* return false if time out (-ETIMEDOUT), else return true */
-	return !niso_timeout;
+	return niso_ret;
 }
 
 static int m_can_dev_setup(struct m_can_classdev *cdev)
@@ -1557,9 +1585,11 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		cdev->can.bittiming_const = &m_can_bittiming_const_31X;
 		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_31X;
 
-		cdev->can.ctrlmode_supported |=
-			(m_can_niso_supported(cdev) ?
-			 CAN_CTRLMODE_FD_NON_ISO : 0);
+		err = m_can_niso_supported(cdev);
+		if (!err)
+			cdev->can.ctrlmode_supported |= CAN_CTRLMODE_FD_NON_ISO;
+		else if (err != -EOPNOTSUPP)
+			return err;
 		break;
 	default:
 		dev_err(cdev->dev, "Unsupported version number: %2d",
@@ -1567,15 +1597,13 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		return -EINVAL;
 	}
 
-	if (cdev->ops->init)
-		cdev->ops->init(cdev);
-
 	return 0;
 }
 
 static void m_can_stop(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	int ret;
 
 	if (!dev->irq) {
 		dev_dbg(cdev->dev, "Stop hrtimer\n");
@@ -1586,7 +1614,9 @@ static void m_can_stop(struct net_device *dev)
 	m_can_disable_all_interrupts(cdev);
 
 	/* Set init mode to disengage from the network */
-	m_can_config_endisable(cdev, true);
+	ret = m_can_cccr_set_wait(cdev, CCCR_INIT, CCCR_INIT);
+	if (ret)
+		netdev_err(dev, "failed to enter standby mode: %d\n", ret);
 
 	/* set the state as STOPPED */
 	cdev->can.state = CAN_STATE_STOPPED;
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 8a4143809d33..22060baf6275 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -452,10 +452,18 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		goto out_power;
 	}
 
-	ret = tcan4x5x_init(mcan_class);
+	tcan4x5x_check_wake(priv);
+
+	ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_EN, 0);
 	if (ret) {
-		dev_err(&spi->dev, "tcan initialization failed %pe\n",
-			ERR_PTR(ret));
+		dev_err(&spi->dev, "Disabling interrupts failed %pe\n", ERR_PTR(ret));
+		goto out_power;
+	}
+
+	ret = tcan4x5x_write_tcan_reg(mcan_class, TCAN4X5X_INT_FLAGS,
+				      TCAN4X5X_CLEAR_ALL_INT);
+	if (ret) {
+		dev_err(&spi->dev, "Clearing interrupts failed %pe\n", ERR_PTR(ret));
 		goto out_power;
 	}
 
-- 
2.42.0

