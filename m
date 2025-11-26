Return-Path: <linux-can+bounces-5683-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E6EC8938A
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 11:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 266E43508F2
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 10:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468A72FFDDC;
	Wed, 26 Nov 2025 10:17:03 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82712EACF2
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152223; cv=none; b=IxojIyvV/9vdBzdfNynkQoJOM2VM211MvvfBQ1pxz2vGC3klFkI3J327rIWoakDd5QZuLwSafzYJ5baDKWOsNEAEvw+efxDDWhDPXsQ4VxbhtOTx9n5a52p1dLxQK4VtLGZIzhVG2/z0T/IvpB+67PPpaP2+tRK8i1XbTrb2img=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152223; c=relaxed/simple;
	bh=U7sHx0JHfit70X87294eNPlexAjBUfBhDOyNYjh1j4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UyQre441NfTVV5twnKusQxQ+gtQQf3KXDL/4cOy2qK+RSBHJe70ymHkbnBFrmGE0Zc+TXDPmMWuPdnXAZZEDdbMHopBSpRec2iQBdnl/JOtcEB4fFuOaMgIUpkqXbF5DNg/864uhs4X/L0IG49OhkizTVL3VDrh+0EqtNq6k1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZw-0000Ri-14; Wed, 26 Nov 2025 11:16:52 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vOCZv-002aT1-1B;
	Wed, 26 Nov 2025 11:16:51 +0100
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 28AC04A88DF;
	Wed, 26 Nov 2025 10:16:51 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 26 Nov 2025 11:16:15 +0100
Subject: [PATCH can-next v8 14/17] can: calc_bittiming: add
 can_calc_sample_point_pwm()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-canxl-v8-14-e7e3eb74f889@pengutronix.de>
References: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
In-Reply-To: <20251126-canxl-v8-0-e7e3eb74f889@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3143; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=4a1B/+vlW70I8/v+O7LaVAdKn9ZOfWTl31QbKZLswJo=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBpJtOLwFLAKekYMJzcaOaOAr7ufNhmz4nPG+p4r
 nGoh6MQ80OJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaSbTiwAKCRAMdGXf+ZCR
 nMx1B/48pFn2VNEkNqEBUxI/qRg/+LPJbdgdeToVUjsXVtcSaJNKUIGliz4fhF6p7XlOW2cqDqz
 jW5b37GSmV3W3GF837bmZMz1jjOSbl3QlL9eaYAq5v/Z874LCaCEp+Dd2I5FMlEsrh65fJFLWUC
 h6IDjY/1wpYO8KRXpUpIrhAFYyIf4ueUdn5X6mWL63ir+AI9KZBwMlheqU+oUVeEPF7KkkSEyBl
 ma40Hw4+lBoq1WHnwHntEzip7pouwnGiv5anvDINnoN9kkeMZmF4iSw9QjKo/rPLRO/wo307yew
 IE/EfIp9I2OHOTPTYiy128/FtfLHBQPUIluOWyXh89qy7KrM
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

The optimum sample point value depends on the bit symmetry. The more
asymmetric the bit is, the more the sample point would be located
towards the end of the bit. On the contrary, if the transceiver only
has a small asymmetry, the optimal sample point would be slightly
after the centre of the bit.

For NRZ encoding (used by Classical CAN, CAN FD and CAN XL with TMS
off), the optimum sample points values are above 70% as implemented in
can_calc_sample_point_nrz().

When TMS is on, CAN XL optimum sample points are near to 50% or
60% [1]. Add can_calc_sample_point_pwm() which returns a sample point
which is suitable for PWM encoding. We crafted the formula to make it
return the same values as below table (source: table 3 of [1]).

       Bit rate (Mbits/s)	Sample point
       -------------------------------------
         2.0			 51.3%
         5.0			 53.1%
         8.0			 55.0%
        10.0			 56.3%
        12.3			 53.8%
        13.3			 58.3%
        14.5			 54.5%
        16.0			 60.0%
        17.7			 55.6%
        20.0			 62.5%

The calculation simply consists of setting a slightly too high sample
point and then letting can_update_sample_point() correct the values.

For now, it is just a formula up our sleeves which matches the
empirical observations of [1]. Once CiA recommendations become
available, can_calc_sample_point_pwm() should be updated accordingly.

[1] CAN XL system design: Clock tolerances and edge deviations edge
    deviations
Link: https://www.can-cia.org/fileadmin/cia/documents/publications/cnlm/december_2024/cnlm_24-4_p18_can_xl_system_design_clock_tolerances_and_edge_deviations_dr_arthur_mutter_bosch.pdf

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index bacdf3b218d3..60a505ce69de 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -22,6 +22,21 @@ static int can_calc_sample_point_nrz(const struct can_bittiming *bt)
 	return 875;
 }
 
+/* Sample points for Pulse-Width Modulation encoding. */
+static int can_calc_sample_point_pwm(const struct can_bittiming *bt)
+{
+	if (bt->bitrate > 15 * MEGA /* BPS */)
+		return 625;
+
+	if (bt->bitrate > 9 * MEGA /* BPS */)
+		return 600;
+
+	if (bt->bitrate > 4 * MEGA /* BPS */)
+		return 560;
+
+	return 520;
+}
+
 /* Bit-timing calculation derived from:
  *
  * Code based on LinCAN sources and H8S2638 project
@@ -93,6 +108,9 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 
 	if (bt->sample_point)
 		sample_point_reference = bt->sample_point;
+	else if (btc == priv->xl.data_bittiming_const &&
+		 (priv->ctrlmode & CAN_CTRLMODE_XL_TMS))
+		sample_point_reference = can_calc_sample_point_pwm(bt);
 	else
 		sample_point_reference = can_calc_sample_point_nrz(bt);
 

-- 
2.51.0


