Return-Path: <linux-can+bounces-817-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C182A911E20
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E305A1C20A9A
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE12B172BD0;
	Fri, 21 Jun 2024 08:02:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470CF171669
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956938; cv=none; b=lez/amLqlCXjc9egATcT3TWscPF0C5jgtUrY+PtDvzvMZrmZ3FCZF810P7e85p7NSnx4IpDfAwL3GISGAf3vBCqAtDRdUm/l+01/Bf6Wy7LFDh+roHhPel4xcfyt8bW3RZtsgAmlr6TxbrkpZA+F3n33VxX5DTzKrui4dmYiQGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956938; c=relaxed/simple;
	bh=KrUwhgUmcSqud+iC5b5fpj9KPyCbcfq8o7G/KRW0aHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1JW7Qc4INhmdxOay68y6z6/D8oiiHIjuNjmeDXqxBccxXqBoZ4PiBuHvoTZyZmNtdxvL6PPcPbOCIOE3gbUPp/Y6yMVgMg5dDTee/lOLAluhXyWHnsV1bcVJxtxsriH7EVIDPLMwd76bNYKxm5i4rVpRzI+tRwXSmCuzCyEJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDo-00047N-PO
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:12 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDk-003tNH-JS
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:08 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 46A6A2EE451
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:08 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 82A232EE3C8;
	Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ffddcbc7;
	Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 24/24] can: m_can: don't enable transceiver when probing
Date: Fri, 21 Jun 2024 09:48:44 +0200
Message-ID: <20240621080201.305471-25-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Martin Hundebøll <martin@geanix.com>

The m_can driver sets and clears the CCCR.INIT bit during probe (both
when testing the NON-ISO bit, and when configuring the chip). After
clearing the CCCR.INIT bit, the transceiver enters normal mode, where it
affects the CAN bus (i.e. it ACKs frames). This can cause troubles when
the m_can node is only used for monitoring the bus, as one cannot setup
listen-only mode before the device is probed.

Rework the probe flow, so that the CCCR.INIT bit is only cleared when
upping the device. First, the tcan4x5x driver is changed to stay in
standby mode during/after probe. This in turn requires changes when
setting bits in the CCCR register, as its CSR and CSA bits are always
high in standby mode.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Tested-by: Markus Schneider-Pargmann <msp@baylibre.com>
Link: https://lore.kernel.org/all/20240607105210.155435-1-martin@geanix.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c         | 165 ++++++++++++++++----------
 drivers/net/can/m_can/tcan4x5x-core.c |  13 +-
 2 files changed, 114 insertions(+), 64 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 14b231c4d7ec..7f63f866083e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -379,38 +379,72 @@ m_can_txe_fifo_read(struct m_can_classdev *cdev, u32 fgi, u32 offset, u32 *val)
 	return cdev->ops->read_fifo(cdev, addr_offset, val, 1);
 }
 
-static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
+static int m_can_cccr_update_bits(struct m_can_classdev *cdev, u32 mask, u32 val)
 {
-	u32 cccr = m_can_read(cdev, M_CAN_CCCR);
-	u32 timeout = 10;
-	u32 val = 0;
+	u32 val_before = m_can_read(cdev, M_CAN_CCCR);
+	u32 val_after = (val_before & ~mask) | val;
+	size_t tries = 10;
 
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
+	if (!(mask & CCCR_INIT) && !(val_before & CCCR_INIT)) {
+		dev_err(cdev->dev,
+			"refusing to configure device when in normal mode\n");
+		return -EBUSY;
 	}
 
-	/* there's a delay for module initialization */
-	if (enable)
-		val = CCCR_INIT | CCCR_CCE;
+	/* The chip should be in standby mode when changing the CCCR register,
+	 * and some chips set the CSR and CSA bits when in standby. Furthermore,
+	 * the CSR and CSA bits should be written as zeros, even when they read
+	 * ones.
+	 */
+	val_after &= ~(CCCR_CSR | CCCR_CSA);
 
-	while ((m_can_read(cdev, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE)) != val) {
-		if (timeout == 0) {
-			netdev_warn(cdev->net, "Failed to init module\n");
-			return;
-		}
-		timeout--;
-		udelay(1);
+	while (tries--) {
+		u32 val_read;
+
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
+	int err;
+
+	/* CCCR_INIT must be set in order to set CCCR_CCE, but access to
+	 * configuration registers should only be enabled when in standby mode,
+	 * where CCCR_INIT is always set.
+	 */
+	err = m_can_cccr_update_bits(cdev, CCCR_CCE, CCCR_CCE);
+	if (err)
+		netdev_err(cdev->net, "failed to enable configuration mode\n");
+
+	return err;
+}
+
+static int m_can_config_disable(struct m_can_classdev *cdev)
+{
+	int err;
+
+	/* Only clear CCCR_CCE, since CCCR_INIT cannot be cleared while in
+	 * standby mode
+	 */
+	err = m_can_cccr_update_bits(cdev, CCCR_CCE, 0);
+	if (err)
+		netdev_err(cdev->net, "failed to disable configuration registers\n");
+
+	return err;
 }
 
 static void m_can_interrupt_enable(struct m_can_classdev *cdev, u32 interrupts)
@@ -1403,7 +1437,9 @@ static int m_can_chip_config(struct net_device *dev)
 	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
 			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F);
 
-	m_can_config_endisable(cdev, true);
+	err = m_can_config_enable(cdev);
+	if (err)
+		return err;
 
 	/* RX Buffer/FIFO Element Size 64 bytes data field */
 	m_can_write(cdev, M_CAN_RXESC,
@@ -1521,7 +1557,9 @@ static int m_can_chip_config(struct net_device *dev)
 		    FIELD_PREP(TSCC_TCP_MASK, 0xf) |
 		    FIELD_PREP(TSCC_TSS_MASK, TSCC_TSS_INTERNAL));
 
-	m_can_config_endisable(cdev, false);
+	err = m_can_config_disable(cdev);
+	if (err)
+		return err;
 
 	if (cdev->ops->init)
 		cdev->ops->init(cdev);
@@ -1550,7 +1588,11 @@ static int m_can_start(struct net_device *dev)
 		cdev->tx_fifo_putidx = FIELD_GET(TXFQS_TFQPI_MASK,
 						 m_can_read(cdev, M_CAN_TXFQS));
 
-	return 0;
+	ret = m_can_cccr_update_bits(cdev, CCCR_INIT, 0);
+	if (ret)
+		netdev_err(dev, "failed to enter normal mode\n");
+
+	return ret;
 }
 
 static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
@@ -1599,43 +1641,37 @@ static int m_can_check_core_release(struct m_can_classdev *cdev)
 }
 
 /* Selectable Non ISO support only in version 3.2.x
- * This function checks if the bit is writable.
+ * Return 1 if the bit is writable, 0 if it is not, or negative on error.
  */
-static bool m_can_niso_supported(struct m_can_classdev *cdev)
+static int m_can_niso_supported(struct m_can_classdev *cdev)
 {
-	u32 cccr_reg, cccr_poll = 0;
-	int niso_timeout = -ETIMEDOUT;
-	int i;
+	int ret, niso;
 
-	m_can_config_endisable(cdev, true);
-	cccr_reg = m_can_read(cdev, M_CAN_CCCR);
-	cccr_reg |= CCCR_NISO;
-	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
+	ret = m_can_config_enable(cdev);
+	if (ret)
+		return ret;
 
-	for (i = 0; i <= 10; i++) {
-		cccr_poll = m_can_read(cdev, M_CAN_CCCR);
-		if (cccr_poll == cccr_reg) {
-			niso_timeout = 0;
-			break;
-		}
+	/* First try to set the NISO bit. */
+	niso = m_can_cccr_update_bits(cdev, CCCR_NISO, CCCR_NISO);
 
-		usleep_range(1, 5);
+	/* Then clear the it again. */
+	ret = m_can_cccr_update_bits(cdev, CCCR_NISO, 0);
+	if (ret) {
+		dev_err(cdev->dev, "failed to revert the NON-ISO bit in CCCR\n");
+		return ret;
 	}
 
-	/* Clear NISO */
-	cccr_reg &= ~(CCCR_NISO);
-	m_can_write(cdev, M_CAN_CCCR, cccr_reg);
+	ret = m_can_config_disable(cdev);
+	if (ret)
+		return ret;
 
-	m_can_config_endisable(cdev, false);
-
-	/* return false if time out (-ETIMEDOUT), else return true */
-	return !niso_timeout;
+	return niso == 0;
 }
 
 static int m_can_dev_setup(struct m_can_classdev *cdev)
 {
 	struct net_device *dev = cdev->net;
-	int m_can_version, err;
+	int m_can_version, err, niso;
 
 	m_can_version = m_can_check_core_release(cdev);
 	/* return if unsupported version */
@@ -1684,9 +1720,11 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		cdev->can.bittiming_const = &m_can_bittiming_const_31X;
 		cdev->can.data_bittiming_const = &m_can_data_bittiming_const_31X;
 
-		cdev->can.ctrlmode_supported |=
-			(m_can_niso_supported(cdev) ?
-			 CAN_CTRLMODE_FD_NON_ISO : 0);
+		niso = m_can_niso_supported(cdev);
+		if (niso < 0)
+			return niso;
+		if (niso)
+			cdev->can.ctrlmode_supported |= CAN_CTRLMODE_FD_NON_ISO;
 		break;
 	default:
 		dev_err(cdev->dev, "Unsupported version number: %2d",
@@ -1694,21 +1732,26 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
 		return -EINVAL;
 	}
 
-	if (cdev->ops->init)
-		cdev->ops->init(cdev);
-
-	return 0;
+	/* Forcing standby mode should be redundant, as the chip should be in
+	 * standby after a reset. Write the INIT bit anyways, should the chip
+	 * be configured by previous stage.
+	 */
+	return m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
 }
 
 static void m_can_stop(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	int ret;
 
 	/* disable all interrupts */
 	m_can_disable_all_interrupts(cdev);
 
 	/* Set init mode to disengage from the network */
-	m_can_config_endisable(cdev, true);
+	ret = m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
+	if (ret)
+		netdev_err(dev, "failed to enter standby mode: %pe\n",
+			   ERR_PTR(ret));
 
 	/* set the state as STOPPED */
 	cdev->can.state = CAN_STATE_STOPPED;
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index a42600dac70d..d723206ac7c9 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -453,10 +453,17 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
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
+	ret = tcan4x5x_clear_interrupts(mcan_class);
+	if (ret) {
+		dev_err(&spi->dev, "Clearing interrupts failed %pe\n", ERR_PTR(ret));
 		goto out_power;
 	}
 
-- 
2.43.0



