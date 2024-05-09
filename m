Return-Path: <linux-can+bounces-613-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFFC8C13C8
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B1B1F22721
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8561C1BC4C;
	Thu,  9 May 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="mW+PrXC/"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44735DDDF;
	Thu,  9 May 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275166; cv=none; b=lNuAuPeqVxWvkjf7EqhV/zDXWH8lW7483LNYHYreGgSeCIpXl7K+DnhuUuDUZGUTJVQb97fNEPmv5g/navOEIeBh3xBEjgTuErf/wYYyxlmMAhKcQYHDpuZLUp/t9Zn5aBQgu0jePKY2Ommv58UmapUycp1xrUaDc2sXzYr/w3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275166; c=relaxed/simple;
	bh=Sp5fOKsj5ptTFDiEE0HykFIqsFkZ5bx2BSBFqb4/6PI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jlIOd6rKusqdbO9Ku1MUHjNPsi5XmucQix7HWV7EQlpa3PoI1cZDRFypzH4YgAkFP1aNONc8iVa3uUJqYRSzVCsTC4hriUc3LqPs7fyrfCNaetS/gFxd8C/HHCu8mZC0RzOcQsG67MLsrlRDa1lVOiJ1YIrzyOgHKMcnXrxpyes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=mW+PrXC/; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zR2Ki5FWem44eG/+0WchmfJ1i/jWqtmZPUgJew+9H9A=; b=mW+PrXC/JjVoPHo6xWoUqaERCL
	N6tkobnEEJ8KV5C3bfA3uw4c67AKyWaGm77vygZMzV7somkvyV9ojE7Lc6ezhxFoehHq52iqOepdC
	kKsaRH2tspOMdc6zdscwj/Sfo0gCir3sCkf+JwA9vVytrz2t2JcSlqbdeCJ0GO2BrmAM=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57Q9-001jf8-2T;
	Thu, 09 May 2024 19:19:07 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 03/11] treewide, serdev: add flags argument to receive_buf()
Date: Thu,  9 May 2024 19:17:28 +0200
Message-Id: <20240509171736.2048414-4-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For serdev device drivers to be able to detect TTY_BREAK and other flags
in the buffer, pass the flag buffer pointer down to serdev its receive
function and update all drivers using it.

The changes were mostly done using the following Coccinelle
semantic patch:

// <smpl>
@ rule1 @
identifier fn;
identifier opsname;
@@
struct serdev_device_ops opsname = {
	.receive_buf = fn,
};
@@
identifier rule1.fn;
parameter E1, E2, E3;
typedef u8;
@@
  fn(E1, E2,
+ const u8 *flags,
  E3)
  { ... }
// </smpl>

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 drivers/bluetooth/btmtkuart.c                          |  3 ++-
 drivers/bluetooth/btnxpuart.c                          |  3 ++-
 drivers/bluetooth/hci_serdev.c                         |  3 ++-
 drivers/gnss/serial.c                                  |  2 +-
 drivers/gnss/sirf.c                                    |  2 +-
 drivers/greybus/gb-beagleplay.c                        |  2 +-
 drivers/iio/chemical/pms7003.c                         |  2 +-
 drivers/iio/chemical/scd30_serial.c                    |  3 ++-
 drivers/iio/chemical/sps30_serial.c                    |  3 ++-
 drivers/iio/imu/bno055/bno055_ser_core.c               |  3 ++-
 drivers/mfd/rave-sp.c                                  |  2 +-
 drivers/net/ethernet/qualcomm/qca_uart.c               |  3 ++-
 drivers/nfc/pn533/uart.c                               |  2 +-
 drivers/nfc/s3fwrn5/uart.c                             |  3 ++-
 drivers/platform/chrome/cros_ec_uart.c                 |  3 ++-
 drivers/platform/surface/aggregator/core.c             |  2 +-
 .../x86/lenovo-yoga-tab2-pro-1380-fastcharger.c        |  3 ++-
 drivers/tty/serdev/serdev-ttyport.c                    |  2 +-
 drivers/w1/masters/w1-uart.c                           |  3 ++-
 include/linux/serdev.h                                 | 10 +++++++---
 sound/drivers/serial-generic.c                         |  3 ++-
 21 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index e6bc4a73c9fc3..acb343931f83c 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -384,7 +384,8 @@ static void btmtkuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
 }
 
 static size_t btmtkuart_receive_buf(struct serdev_device *serdev,
-				    const u8 *data, size_t count)
+				    const u8 *data, const u8 *flags,
+				    size_t count)
 {
 	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
 
diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 9d0c7e278114b..a14afc4ecdda5 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1286,7 +1286,8 @@ static const struct h4_recv_pkt nxp_recv_pkts[] = {
 };
 
 static size_t btnxpuart_receive_buf(struct serdev_device *serdev,
-				    const u8 *data, size_t count)
+				    const u8 *data, const u8 *flags,
+				    size_t count)
 {
 	struct btnxpuart_dev *nxpdev = serdev_device_get_drvdata(serdev);
 
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 89a22e9b3253a..9c3e8f5c136bf 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -272,7 +272,8 @@ static void hci_uart_write_wakeup(struct serdev_device *serdev)
  * Return: number of processed bytes
  */
 static size_t hci_uart_receive_buf(struct serdev_device *serdev,
-				   const u8 *data, size_t count)
+				   const u8 *data, const u8 *flags,
+				   size_t count)
 {
 	struct hci_uart *hu = serdev_device_get_drvdata(serdev);
 
diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
index 0e43bf6294f87..4af4d2c0624b3 100644
--- a/drivers/gnss/serial.c
+++ b/drivers/gnss/serial.c
@@ -81,7 +81,7 @@ static const struct gnss_operations gnss_serial_gnss_ops = {
 };
 
 static size_t gnss_serial_receive_buf(struct serdev_device *serdev,
-				       const u8 *buf, size_t count)
+		const u8 *buf, const u8 *flags, size_t count)
 {
 	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
 	struct gnss_device *gdev = gserial->gdev;
diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 79375d14bbb67..410c7bc6af43c 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -161,7 +161,7 @@ static const struct gnss_operations sirf_gnss_ops = {
 };
 
 static size_t sirf_receive_buf(struct serdev_device *serdev,
-				const u8 *buf, size_t count)
+				const u8 *buf, const u8 *flags, size_t count)
 {
 	struct sirf_data *data = serdev_device_get_drvdata(serdev);
 	struct gnss_device *gdev = data->gdev;
diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
index 33f8fad70260a..b56675a7b6b06 100644
--- a/drivers/greybus/gb-beagleplay.c
+++ b/drivers/greybus/gb-beagleplay.c
@@ -332,7 +332,7 @@ static void hdlc_deinit(struct gb_beagleplay *bg)
 }
 
 static size_t gb_tty_receive(struct serdev_device *sd, const u8 *data,
-			     size_t count)
+			     const u8 *flags, size_t count)
 {
 	struct gb_beagleplay *bg = serdev_device_get_drvdata(sd);
 
diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
index 43025866d5b79..4d7ed0dbd4ac4 100644
--- a/drivers/iio/chemical/pms7003.c
+++ b/drivers/iio/chemical/pms7003.c
@@ -212,7 +212,7 @@ static bool pms7003_frame_is_okay(struct pms7003_frame *frame)
 }
 
 static size_t pms7003_receive_buf(struct serdev_device *serdev, const u8 *buf,
-				  size_t size)
+				  const u8 *flags, size_t size)
 {
 	struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
 	struct pms7003_state *state = iio_priv(indio_dev);
diff --git a/drivers/iio/chemical/scd30_serial.c b/drivers/iio/chemical/scd30_serial.c
index 2adb76dbb0209..c67524a394378 100644
--- a/drivers/iio/chemical/scd30_serial.c
+++ b/drivers/iio/chemical/scd30_serial.c
@@ -175,7 +175,8 @@ static int scd30_serdev_command(struct scd30_state *state, enum scd30_cmd cmd, u
 }
 
 static size_t scd30_serdev_receive_buf(struct serdev_device *serdev,
-				       const u8 *buf, size_t size)
+				       const u8 *buf, const u8 *flags,
+				       size_t size)
 {
 	struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
 	struct scd30_serdev_priv *priv;
diff --git a/drivers/iio/chemical/sps30_serial.c b/drivers/iio/chemical/sps30_serial.c
index a6dfbe28c914c..5e486e23110dc 100644
--- a/drivers/iio/chemical/sps30_serial.c
+++ b/drivers/iio/chemical/sps30_serial.c
@@ -211,7 +211,8 @@ static int sps30_serial_command(struct sps30_state *state, unsigned char cmd,
 }
 
 static size_t sps30_serial_receive_buf(struct serdev_device *serdev,
-				       const u8 *buf, size_t size)
+				       const u8 *buf, const u8 *flags,
+				       size_t size)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
 	struct sps30_serial_priv *priv;
diff --git a/drivers/iio/imu/bno055/bno055_ser_core.c b/drivers/iio/imu/bno055/bno055_ser_core.c
index 694ff14a3aa27..68729e9e98796 100644
--- a/drivers/iio/imu/bno055/bno055_ser_core.c
+++ b/drivers/iio/imu/bno055/bno055_ser_core.c
@@ -379,7 +379,8 @@ static void bno055_ser_handle_rx(struct bno055_ser_priv *priv, int status)
  * unless we require to AND we don't queue more than one request per time).
  */
 static size_t bno055_ser_receive_buf(struct serdev_device *serdev,
-				     const u8 *buf, size_t size)
+				     const u8 *buf, const u8 *flags,
+				     size_t size)
 {
 	int status;
 	struct bno055_ser_priv *priv = serdev_device_get_drvdata(serdev);
diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index ef326d6d566e6..5229b251d698f 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -472,7 +472,7 @@ static void rave_sp_receive_frame(struct rave_sp *sp,
 }
 
 static size_t rave_sp_receive_buf(struct serdev_device *serdev,
-				  const u8 *buf, size_t size)
+				  const u8 *buf, const u8 *flags, size_t size)
 {
 	struct device *dev = &serdev->dev;
 	struct rave_sp *sp = dev_get_drvdata(dev);
diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethernet/qualcomm/qca_uart.c
index 37efb1ea9fcd9..a59d88a8f9d91 100644
--- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -46,7 +46,8 @@ struct qcauart {
 };
 
 static size_t
-qca_tty_receive(struct serdev_device *serdev, const u8 *data, size_t count)
+qca_tty_receive(struct serdev_device *serdev, const u8 *data, const u8 *flags,
+		size_t count)
 {
 	struct qcauart *qca = serdev_device_get_drvdata(serdev);
 	struct net_device *netdev = qca->net_dev;
diff --git a/drivers/nfc/pn533/uart.c b/drivers/nfc/pn533/uart.c
index cfbbe0713317f..9686e354c0d56 100644
--- a/drivers/nfc/pn533/uart.c
+++ b/drivers/nfc/pn533/uart.c
@@ -204,7 +204,7 @@ static int pn532_uart_rx_is_frame(struct sk_buff *skb)
 }
 
 static size_t pn532_receive_buf(struct serdev_device *serdev,
-				const u8 *data, size_t count)
+				const u8 *data, const u8 *flags, size_t count)
 {
 	struct pn532_uart_phy *dev = serdev_device_get_drvdata(serdev);
 	size_t i;
diff --git a/drivers/nfc/s3fwrn5/uart.c b/drivers/nfc/s3fwrn5/uart.c
index 9c09c10c2a464..b55734ad1b0f3 100644
--- a/drivers/nfc/s3fwrn5/uart.c
+++ b/drivers/nfc/s3fwrn5/uart.c
@@ -52,7 +52,8 @@ static const struct s3fwrn5_phy_ops uart_phy_ops = {
 };
 
 static size_t s3fwrn82_uart_read(struct serdev_device *serdev,
-				 const u8 *data, size_t count)
+				 const u8 *data, const u8 *flags,
+				 size_t count)
 {
 	struct s3fwrn82_uart_phy *phy = serdev_device_get_drvdata(serdev);
 	size_t i;
diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
index 62bc24f6dcc7a..349b0638420e6 100644
--- a/drivers/platform/chrome/cros_ec_uart.c
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -82,7 +82,8 @@ struct cros_ec_uart {
 };
 
 static size_t cros_ec_uart_rx_bytes(struct serdev_device *serdev,
-				    const u8 *data, size_t count)
+				    const u8 *data, const u8 *flags,
+				    size_t count)
 {
 	struct ec_host_response *host_response;
 	struct cros_ec_device *ec_dev = serdev_device_get_drvdata(serdev);
diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index ba550eaa06fcf..4efd2a8226789 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -228,7 +228,7 @@ EXPORT_SYMBOL_GPL(ssam_client_bind);
 /* -- Glue layer (serdev_device -> ssam_controller). ------------------------ */
 
 static size_t ssam_receive_buf(struct serdev_device *dev, const u8 *buf,
-			       size_t n)
+			       const u8 *flags, size_t n)
 {
 	struct ssam_controller *ctrl;
 	int ret;
diff --git a/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
index d525bdc8ca9b3..c20c1be27227f 100644
--- a/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
+++ b/drivers/platform/x86/lenovo-yoga-tab2-pro-1380-fastcharger.c
@@ -133,7 +133,8 @@ static int yt2_1380_fc_extcon_evt(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static size_t yt2_1380_fc_receive(struct serdev_device *serdev, const u8 *data, size_t len)
+static size_t yt2_1380_fc_receive(struct serdev_device *serdev, const u8 *data,
+				  const u8 *flags, size_t len)
 {
 	/*
 	 * Since the USB data lines are shorted for DCP detection, echos of
diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
index 3d7ae7fa50186..bb47691afdb21 100644
--- a/drivers/tty/serdev/serdev-ttyport.c
+++ b/drivers/tty/serdev/serdev-ttyport.c
@@ -32,7 +32,7 @@ static size_t ttyport_receive_buf(struct tty_port *port, const u8 *cp,
 	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
 		return 0;
 
-	ret = serdev_controller_receive_buf(ctrl, cp, count);
+	ret = serdev_controller_receive_buf(ctrl, cp, fp, count);
 
 	dev_WARN_ONCE(&ctrl->dev, ret > count,
 				"receive_buf returns %zu (count = %zu)\n",
diff --git a/drivers/w1/masters/w1-uart.c b/drivers/w1/masters/w1-uart.c
index a31782e56ba75..ed465b6f491fc 100644
--- a/drivers/w1/masters/w1-uart.c
+++ b/drivers/w1/masters/w1-uart.c
@@ -290,7 +290,8 @@ static int w1_uart_serdev_tx_rx(struct w1_uart_device *w1dev,
 }
 
 static size_t w1_uart_serdev_receive_buf(struct serdev_device *serdev,
-					  const u8 *buf, size_t count)
+					 const u8 *buf, const u8 *flags,
+					 size_t count)
 {
 	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
 
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index ff78efc1f60df..94fc81a1de933 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -21,13 +21,16 @@ struct serdev_device;
 
 /**
  * struct serdev_device_ops - Callback operations for a serdev device
- * @receive_buf:	Function called with data received from device;
+ * @receive_buf:	Function called with data received from device (char
+ *			buffer), flags buffer (%TTY_NORMAL, %TTY_BREAK, etc)
+ *			and number of bytes;
  *			returns number of bytes accepted; may sleep.
  * @write_wakeup:	Function called when ready to transmit more data; must
  *			not sleep.
  */
 struct serdev_device_ops {
-	size_t (*receive_buf)(struct serdev_device *, const u8 *, size_t);
+	size_t (*receive_buf)(struct serdev_device *, const u8 *, const u8 *,
+			      size_t);
 	void (*write_wakeup)(struct serdev_device *);
 };
 
@@ -187,6 +190,7 @@ static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl
 
 static inline size_t serdev_controller_receive_buf(struct serdev_controller *ctrl,
 						   const u8 *data,
+						   const u8 *flags,
 						   size_t count)
 {
 	struct serdev_device *serdev = ctrl->serdev;
@@ -194,7 +198,7 @@ static inline size_t serdev_controller_receive_buf(struct serdev_controller *ctr
 	if (!serdev || !serdev->ops->receive_buf)
 		return 0;
 
-	return serdev->ops->receive_buf(serdev, data, count);
+	return serdev->ops->receive_buf(serdev, data, flags, count);
 }
 
 #if IS_ENABLED(CONFIG_SERIAL_DEV_BUS)
diff --git a/sound/drivers/serial-generic.c b/sound/drivers/serial-generic.c
index 36409a56c675e..3569ef40d35a2 100644
--- a/sound/drivers/serial-generic.c
+++ b/sound/drivers/serial-generic.c
@@ -101,7 +101,8 @@ static void snd_serial_generic_write_wakeup(struct serdev_device *serdev)
 }
 
 static size_t snd_serial_generic_receive_buf(struct serdev_device *serdev,
-					     const u8 *buf, size_t count)
+					     const u8 *buf, const u8 *flags,
+					     size_t count)
 {
 	int ret;
 	struct snd_serial_generic *drvdata = serdev_device_get_drvdata(serdev);
-- 
2.39.2


